Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCD543C4A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbhJ0IJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239150AbhJ0IJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:09:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E658610C7;
        Wed, 27 Oct 2021 08:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635322000;
        bh=R6npbyugMJ+bx1oeZuErmLo4Jh44Cv++S1JLqSBanos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=pHrzvdXHYJhNqidAVW5XeItr4Df2lXPI8YXYcvXqhguVR1g0jM1UAw/8IHLCoII+R
         RwECQrjvFTNZ+ipvoRujdwg5j8J/CTfpGUz0e1BKmmfPVH3Fd9l7eKxsg2Nc1utxJz
         4eRFkh7ZbPWewIUcCRHO+191vL+8fUE8xBjcMwMPTCZsnRImiq7I7M4t5FkgNtYRAi
         K8qC+WEGL3GijHj0WvM4do15Riqn7PsYggoh9MyK1IixOwkEU0WwRfZI8OH95wQ4OB
         hW/cHQ8danQvKFeQBQV6OqqI9gBJPO1dihGAXRl7+3odk4TxFownYtFFAaZhDrBtmg
         CCb8BpJwYRO5Q==
From:   SeongJae Park <sj@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     sj@kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DAMON: problems when running DAMON on ARM64 with 'transparent_hugepage' enabled
Date:   Wed, 27 Oct 2021 08:06:36 +0000
Message-Id: <20211027080636.14886-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <b2219330-66d2-de9d-534b-076d84d7d791@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xiongfeng,

On Wed, 27 Oct 2021 14:14:57 +0800 Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:

> Sorry, I forgot to Cc the maillist. Cc it in this mail.
> 
> On 2021/10/27 10:19, Xiongfeng Wang wrote:
> > Hi SeongJae,
> > 
> > Sorry to disturb you. It's just that I came across some problems when running
> > DAMON, but still didn't find the solution after several days.

You're not disturbing but helping me!  Please don't say so! :)

> > 
> > A short description is that the result of DAMON is not as expected when running
> > on ARM64 with 'transparent_hugepage' enabled. But the result is correct when
> > 'transparent_hugepage' is disabled.
> > 
> > The following are the steps I came across the problems.
> > 1. Firstly, I use 'damo record' to sample the 'stairs' demo.
> >   damo record "./masim ./configs/stairs.cfg"
> > 2. Then I use 'damo report' to show the results.
> >   damo report heats --address_range xxx  xxx  --time_range xxx xxx    --heatmap
> > stdout    --stdout_heatmap_color emotion
> > The result doesn't show like a stair. I wrote a userspace demo to access a
> > certain address range in loop and use DAMON to sample the demo. I added
> > trace_print in 'damon_va_check_access()' and found out the pages in the address
> > range are not always detected as accessed, which is not expected. When I disable
> > transparent_hugepage by chance, the pages are marked as accessed. Then I test
> > the 'stairs' demo again, the result is correct. It seems that, only when
> > transparent_hugepage' is disabled, the access check works. I don't know where
> > the bug is, the software or the hardware ? Appreciate it if you have time to
> > reply. Thanks !

Thank you for this report!  I have a theory, but would like to test first.
Will check and get back to you soon.


Thanks,
SJ

> > 
> > Thanks,
> > Xiongfeng
