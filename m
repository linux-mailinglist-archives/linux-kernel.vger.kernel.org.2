Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FE033261C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhCINGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhCINGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:06:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CC6C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=IiHCr9sIrtawE/V4O188HSaNWrVYYILoW20hEa4D1iM=; b=gBXyhL/t1Mt1hO7uPr7fovofJg
        sOYuwlt2o5CDj3vmwwowKD1a4LPPIOZ1GahIAioB5hXWNUlEPE7mUDxrrI2dz1Ac6NfpcGphEIiMd
        AGER0HmIuLlwi+jz0LdQdW/Y3QoufNaW4C6ZDgO3vzCuMjH/g3UwsIc9k1mENwatAlY6gj2a5wN1j
        Lycxyx1GlonsH4zkD3juKA/qLCUCG+gVIx7yklReM7PoS0JA72VNh1To+B6wqJf2dy4HTtqH6NW8c
        bCc2z7wZs9g5b6Ukm7EgJm5grs+hrJyfjvJruwiXStgKncvsFz2spgTmVux2F8/jRIg7tJ+wPs6dY
        DVDkmV8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJc3D-000bWx-VK; Tue, 09 Mar 2021 13:05:39 +0000
Date:   Tue, 9 Mar 2021 13:05:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm/filemap]  cbd59c48ae:
 fxmark.hdd_ext4_no_jnl_DRBM_9_bufferedio.works/sec -7.6% regression
Message-ID: <20210309130527.GK3479805@casper.infradead.org>
References: <20210309075706.GB12057@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309075706.GB12057@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 03:57:06PM +0800, kernel test robot wrote:
> FYI, we noticed a -7.6% regression of fxmark.hdd_ext4_no_jnl_DRBM_9_bufferedio.works/sec due to commit:
> 
> commit: cbd59c48ae2bcadc4a7599c29cf32fd3f9b78251 ("mm/filemap: use head pages in generic_file_buffered_read")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: fxmark
> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory

Can you send me one of those to test on?  ;-)

>          %stddev     %change         %stddev
>              \          |                \  
>       0.05 ±  5%     -10.1%       0.05 ±  3%  fxmark.hdd_ext4_no_jnl_DRBM_18_bufferedio.softirq_util
>    4168491            -7.6%    3849925        fxmark.hdd_ext4_no_jnl_DRBM_9_bufferedio.works/sec
>     300.00            +2.1%     306.16        fxmark.time.system_time
>      87.53            -6.7%      81.69        fxmark.time.user_time
>     784.83 ±  5%     +23.6%     970.33 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.copy_page_to_iter.generic_file_buffered_read.new_sync_read

23% more delay while preempted copying to user?  That seems bad, but I
don't see anything in this commit that would cause that.

>       7.59            -7.6        0.00        perf-profile.calltrace.cycles-pp.find_get_pages_contig.filemap_get_pages.generic_file_buffered_read.new_sync_read.vfs_read

That makes sense; we don't call find_get_pages_contig() any more, instead
we call ...

>       0.00           +11.9       11.90        perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.generic_file_buffered_read.new_sync_read.vfs_read

filemap_get_read_batch() ... which is more expensive ;-(

                if (PageReadahead(head))
                        break;
+		if (!PageHead(head))
+			continue;
                xas.xa_index = head->index + thp_nr_pages(head) - 1;
                xas.xa_offset = (xas.xa_index >> xas.xa_shift) & XA_CHUNK_MASK;

might be worth a try, but I have a medical appointment to get to.
I'll test it out later.

