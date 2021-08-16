Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7D3EDC20
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhHPRM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhHPRMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:12:52 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B915FC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:12:20 -0700 (PDT)
Date:   Tue, 17 Aug 2021 02:12:07 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629133939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3SuUnMqVOQbFtnyAKahq0VdDZE4Bz/c+gxDMli7bunw=;
        b=H94IN+wPzlFa/KYeledyUdhyJoGtThxgUQ2v655myRP6IoPoOu41YhDEQkeKS4cqIogQk/
        35UHd9ee9f+yr8b1jrko9mo10QBU0STOzMGnqkc6LLxIaBzybwmifmct2V5bXvaLV58QmB
        ZTiAUwoSz7Au5Ig0AtQ+zId5gqGXeOc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] mm,hwpoison: fix race with hugetlb page allocation
Message-ID: <20210816171207.GA2239284@u2004>
References: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
 <20210603233632.2964832-2-nao.horiguchi@gmail.com>
 <20210812042813.GA1576603@agluck-desk2.amr.corp.intel.com>
 <20210812090303.GA153531@hori.linux.bs1.fc.nec.co.jp>
 <20210812152548.GA1579021@agluck-desk2.amr.corp.intel.com>
 <20210813062951.GA203438@hori.linux.bs1.fc.nec.co.jp>
 <96d4fd8b75e44a6c970e4d9530980f21@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96d4fd8b75e44a6c970e4d9530980f21@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 03:07:20PM +0000, Luck, Tony wrote:
> I'm running the default case from my einj_mem_uc test. That just:
> 
> 1) allocates a page using:
> 
> 	mmap(NULL, pagesize, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANON, -1, 0);
> 
> 2) fills the page with random data (to make sure it has been allocated, and that the kernel can't
> do KSM tricks to share this physical page with some other user).
> 
> 3) injects the error at a 1KB offset within the page.
> 
> 4) does a memory read of the poison address.
> 
> 
> >                            action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
> >   +                       dump_page(p, "hwpoison unknown page");
> >                            res = -EBUSY;
> >                            goto unlock_mutex;
> >                    }
> 
> I added that patch against upstream (v5.14-rc5).  Here's the dump. The "pfn" matches the physical address where I injected,
> and it has the hwpoison flag bit that was set early in memory_failure() --- so this is the right page.
> 
> [   79.368212] Memory failure: 0x623889: recovery action for unknown page: Ignored
> [   79.375525] page:0000000065ad9479 refcount:3 mapcount:1 mapping:00000000a4ac843b index:0x0 pfn:0x623889
> [   79.384909] memcg:ff40a569f2966000
> [   79.388313] aops:shmem_aops ino:4c00 dentry name:"dev/zero"
> [   79.393896] flags: 0x17ffffc088000c(uptodate|dirty|swapbacked|hwpoison|node=0|zone=2|lastcpupid=0x1fffff)
> [   79.403455] raw: 0017ffffc088000c 0000000000000000 dead000000000122 ff40a569f45a7160
> [   79.411191] raw: 0000000000000000 0000000000000000 0000000300000000 ff40a569f2966000
> [   79.418931] page dumped because: hwpoison unknown page

Thank you for your help.

This dump indicates that HWPoisonHandlable() returned false due to
the lack of PG_lru flag.  In older code before 5.13, get_any_page() does
retry with shake_page(), but does not since 5.13, which seems to me
the root cause of the issue. So my suggestion is to call shake_page()
when HWPoisonHandlable() is false.

Could you try checking that the following diff fixes the issue?
I could still have better fix (like inserting shake_page() to other
retry paths in get_any_page()), but the below is the minimum one.

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 76cc53b2999a..3e770e4f259e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1146,7 +1146,7 @@ static int __get_hwpoison_page(struct page *page)
         * unexpected races caused by taking a page refcount.
         */
        if (!HWPoisonHandlable(head))
-               return 0;
+               return -EBUSY;

        if (PageTransHuge(head)) {
                /*
@@ -1199,9 +1199,14 @@ static int get_any_page(struct page *p, unsigned long flags)
                        }
                        goto out;
                } else if (ret == -EBUSY) {
-                       /* We raced with freeing huge page to buddy, retry. */
-                       if (pass++ < 3)
+                       /*
+                        * We raced with (possibly temporary) unhandlable
+                        * page, retry.
+                        */
+                       if (pass++ < 3) {
+                               shake_page(p, 1);
                                goto try_again;
+                       }
                        goto out;
                }
        }


Thanks,
Naoya Horiguchi
