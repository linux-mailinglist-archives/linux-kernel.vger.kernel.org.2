Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6D414EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhIVRGd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Sep 2021 13:06:33 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33809 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236784AbhIVRG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:06:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UpFelko_1632330295;
Received: from 192.168.43.92(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UpFelko_1632330295)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Sep 2021 01:04:56 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <YUsVcEDcQ2vEzjGg@casper.infradead.org>
Date:   Thu, 23 Sep 2021 01:04:54 +0800
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, song@kernel.org,
        william.kucharski@oracle.com, Hugh Dickins <hughd@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20210922070645.47345-2-rongwei.wang@linux.alibaba.com>
 <YUsVcEDcQ2vEzjGg@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 22, 2021, at 7:37 PM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> On Wed, Sep 22, 2021 at 03:06:44PM +0800, Rongwei Wang wrote:
>> Transparent huge page has supported read-only non-shmem files. The file-
>> backed THP is collapsed by khugepaged and truncated when written (for
>> shared libraries).
>> 
>> However, there is race in two possible places.
>> 
>> 1) multiple writers truncate the same page cache concurrently;
>> 2) collapse_file rolls back when writer truncates the page cache;
> 
> As I've said before, the bug here is that somehow there is a writable fd
> to a file with THPs.  That's what we need to track down and fix.
Hi, Matthew
I am not sure get your means. We know “mm, thp: relax the VM_DENYWRITE constraint on file-backed THPs"
Introduced file-backed THPs for DSO. It is possible {very rarely} for DSO to be opened in writeable way. So, the
Pagecache of DSO need to be cleaned when someone opened this DSO in a writeable way. The process of
Pagecache cleaned mainly refers to ’truncate_inode_pages_range’.

Of course, the above is consensus for us.

The ’somehow’ that your said is sure for us. Maybe I can try to describe roughly here:

In collapse_file <khugepaged>, when PTEs scan failed (e.g. SCAN_FAIL, SCAN_TRUNCATED..), the following
code will be run:

        } else {
                struct page *page;

                /* Something went wrong: roll back page cache changes */
                xas_lock_irq(&xas);
                mapping->nrpages -= nr_none;

                if (is_shmem)
                        shmem_uncharge(mapping->host, nr_none);

                xas_set(&xas, start);
                xas_for_each(&xas, page, end - 1) {
                        page = list_first_entry_or_null(&pagelist,
                                        struct page, lru);
                        if (!page || xas.xa_index < page->index) {
                                if (!nr_none)
                                        break;
                                nr_none--;
                                /* Put holes back where they were */
                                xas_store(&xas, NULL);
                                continue;
                        }

                        VM_BUG_ON_PAGE(page->index != xas.xa_index, page);

                        /* Unfreeze the page. */
                        list_del(&page->lru);
                        page_ref_unfreeze(page, 2);
  line1               xas_store(&xas, page);
                        xas_pause(&xas);
                        xas_unlock_irq(&xas);
                        unlock_page(page);
                        putback_lru_page(page);
                        xas_lock_irq(&xas);
                }
		….
		new_page->mapping = NULL;
	   }
line2   unlock_page(new_page);
---

The above code refers to roll back. When someone starts open a DSO in a writeable way, and the collapse_file
is scanning PTEs. The hugepage had been locked and was mapped in page cache before line1. And the hugepage
not be in pagecache and be unlocked at line2. The race that between ‘collapse_file’ and ’truncate_inode_pages_range’
will happen when ‘collapse_file' is executing line1 and line2. 
This race can be shown concisely:

Khugepaged:                                                writer
Collapse_file:                                                truncate_inode_pages_range

lock_page(hugepage)                                   skip hugepage because locked by others

					                              scan_left_pages() and wait_lock_page(hugepage)
scan_fail() & xas_store(&xas, 4k_page)

unlock_page(hugepage)
						                      get_lock_page(hugepage)
						                      hugepage is not in pagecache here, but not be checked

This situation triggers easily if we setting a very small ‘scan_sleep_millisecs’.

The above descriptions are roughly my understanding of ’somehow’. It says a lot of nonsense, maybe it helps!
> 
> https://lore.kernel.org/linux-mm/YUdL3lFLFHzC80Wt@casper.infradead.org/
All in all, what you mean is that we should solve this race at the source? However, a writer happens to appear in the middle
of a process in ‘collapse_file', so this bug solved when roll back. The above is my understanding, but it may be
wrong.

Thanks

