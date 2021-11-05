Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E68446488
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhKEOA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 10:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232604AbhKEOA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:00:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98E5061165;
        Fri,  5 Nov 2021 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636120698;
        bh=m9zv5EkQKsKyPpx5/ykeQzM38x9YUm/UOnYFys8+E1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=amg5MS8oymxKPGCl7yJhYMmULdSy7+CVkIs5NZiFbrFxlGwGmzL/ndWUu75anwWBm
         GpULlv6OlmNKN9gm/l+Pp+in8Qg0A3jm9r4ydP0NLPN5+e7CAacIltxRTJwgiwFAQu
         XNSbVkZaL+h2PKigX9E15OH3QXhYtY3p18vKYFMGPlXOBQWgnwcj5tcbDQtmTBH0ch
         NW62nG/elJJbqguz94M2lPV1ikS9vwdM+uJ9RedcGxOW+ZFG/J8wDdelV2hUrKvaGI
         jgiNaEA1P1UIC5iBagTxwGuyBlNdxJlUGdAIVi3ed+nleR/cerMniOtSCvZaj6PTVq
         cNnPZ3JSYdQWg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DAMON: problems when running DAMON on ARM64 with 'transparent_hugepage' enabled
Date:   Fri,  5 Nov 2021 13:57:48 +0000
Message-Id: <20211105135748.32729-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211027080636.14886-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiongfeng,

On Wed, 27 Oct 2021 08:06:36 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello Xiongfeng,
> 
> On Wed, 27 Oct 2021 14:14:57 +0800 Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
> 
> > Sorry, I forgot to Cc the maillist. Cc it in this mail.
> > 
> > On 2021/10/27 10:19, Xiongfeng Wang wrote:
> > > Hi SeongJae,
> > > 
> > > Sorry to disturb you. It's just that I came across some problems when running
> > > DAMON, but still didn't find the solution after several days.
> 
> You're not disturbing but helping me!  Please don't say so! :)
> 
> > > 
> > > A short description is that the result of DAMON is not as expected when running
> > > on ARM64 with 'transparent_hugepage' enabled. But the result is correct when
> > > 'transparent_hugepage' is disabled.
> > > 
> > > The following are the steps I came across the problems.
> > > 1. Firstly, I use 'damo record' to sample the 'stairs' demo.
> > >   damo record "./masim ./configs/stairs.cfg"
> > > 2. Then I use 'damo report' to show the results.
> > >   damo report heats --address_range xxx  xxx  --time_range xxx xxx    --heatmap
> > > stdout    --stdout_heatmap_color emotion
> > > The result doesn't show like a stair. I wrote a userspace demo to access a
> > > certain address range in loop and use DAMON to sample the demo. I added
> > > trace_print in 'damon_va_check_access()' and found out the pages in the address
> > > range are not always detected as accessed, which is not expected. When I disable
> > > transparent_hugepage by chance, the pages are marked as accessed. Then I test
> > > the 'stairs' demo again, the result is correct. It seems that, only when
> > > transparent_hugepage' is disabled, the access check works. I don't know where
> > > the bug is, the software or the hardware ? Appreciate it if you have time to
> > > reply. Thanks !
> 
> Thank you for this report!  I have a theory, but would like to test first.
> Will check and get back to you soon.

Sorry for late response.  I also confirmed the issue is reproducible on my
ARM64 test machine.  My theory is, enabling THP reduced page table walks, and
therefore the PTE Accessed bits are not frequently updated.  To verify this, I
made below experimental change.  After applying the change on my test machine,
I was able to show the expected access pattern regardless of THP enablement.

    --- a/mm/damon/vaddr.c
    +++ b/mm/damon/vaddr.c
    @@ -429,6 +429,7 @@ void damon_va_prepare_access_checks(struct damon_ctx *ctx)
                            continue;
                    damon_for_each_region(r, t)
                            damon_va_prepare_access_check(ctx, mm, r);
    +               flush_tlb_mm(mm);
                    mmput(mm);
            }
     }

Could you please test this on your machine and let me know the result?

Again, please note that this change is only for proof of the theory, rather
than the complete fix.


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
> > > 
> > > Thanks,
> > > Xiongfeng
