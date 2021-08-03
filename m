Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2823DED4A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhHCMA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbhHCMA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:00:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C99C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mWWcG5RvzZnZtzlTEpwyxElez8u4/J5+F8NGP5+ob2I=; b=HrXnZbf8ZK+Qr50SSMhpEZCtgU
        l0YFFCxnK++awS8wJVr5m49RsENKHlMUb5wHA6U/ljSvInTXQabW2yyEp7b5/2XlgTBKSS6frG03k
        evTCgGgRDnmjsR4++F8tjEEPEYWdG5WYpldllArWVwMyoGKNaFl8lnUQ9iHqOFBJ8+xa3rMs5x4HK
        w5gozJoYw9BKU2ha1loKSuDyyRrzs2+gtE2maPM9rJ9jpYkFNII7Rmp8y7nSH081PCMOTnAOOrCkK
        ZJNLBDpgumgWyD+bBdPiwt38iDoLU94Pc19NDF7M2892jtQja3pfewd0l/IQzjk+m2x83pHawSeCf
        nQEXC+0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAt4g-004bvm-21; Tue, 03 Aug 2021 11:59:17 +0000
Date:   Tue, 3 Aug 2021 12:59:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
Message-ID: <YQkvjng6ljwtp9eb@casper.infradead.org>
References: <20210723080000.93953-1-ying.huang@intel.com>
 <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
 <CAC=cRTNby4GkSJ-pjs6utgHtrQYEdy3XZQ06Qsxgyf1MJSBjrw@mail.gmail.com>
 <877dh354vc.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dh354vc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 04:06:47PM +0800, Huang, Ying wrote:
> As Hugh pointed out, EINVAL isn't an appropriate error code for race
> condition.  After checking the code, I found that EEXIST is the error
> code used for race condition.  So I revise the patch as below.  If Hugh
> doesn't object, can you help to replace the patch with the below one?
> 
> Best Regards,
> Huang, Ying
> 
> -----------------------------8<---------------------------------------
> >From e2b281a0b09d34d6463942e214e577ed9357c213 Mon Sep 17 00:00:00 2001
> From: Huang Ying <ying.huang@intel.com>
> Date: Tue, 3 Aug 2021 10:51:16 +0800
> Subject: [PATCH] shmem_swapin_page(): fix error processing for
>  get_swap_device()
> 
> Firstly, "-" is missing before the error code.  Secondly, EINVAL isn't
> the proper error code for the race condition.  EEXIST is used in
> shmem_swapin_page() for that.  So the error code is changed to EEXIST
> too.
> 
> Link: https://lkml.kernel.org/r/20210723080000.93953-1-ying.huang@intel.com
> Fixes: 2efa33fc7f6e ("mm/shmem: fix shmem_swapin() race with swapoff")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Also, the description is poor.  How about:

If we hit this rare race, returning EINVAL (or even -EINVAL) would cause
the page fault to be handled as a SIGBUS.  This is not correct; the page
is not missing or unreadable, it has simply changed location.  Returning
-EEXIST here will cause the lookup to be retried by the caller.

