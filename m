Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF99459B71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhKWFTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:19:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhKWFTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:19:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E30660C51;
        Tue, 23 Nov 2021 05:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637644589;
        bh=Z2THBGeFFCxDVXvD1leWBOsCoREPKHixd2QrzNbmWY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LToUysWiG5lN+hFbCpBMsWLT2pqoYcuZwbY90yw0T8mTQsAy6poFkk/T/bh8gLSIq
         0zJIgCfR6GJ097A1sYLYIURFgiEGxC91n8clinO2km49RuRG5MJ9JfZpU8OtYhhsJo
         E9MVmhoAUXO6iK2MXKQN5qBqWuJ8QkLpbN3/E6wh8Pb91iBYkiZAgipjefr50p0ze4
         fn5J81iy+mK1FlGUVAZ8gUqMegtOan5ocvo+Ls9f4FirHQNucSSL1+geYV6+4nRu+W
         2nuXzGRfb6abTBViuRt7NsHFIP0yf/4XAZeYvjSQ1y7uEEOdbms4WAZ3sOpmqLhh4E
         tKfmz6Cazfr7Q==
Date:   Tue, 23 Nov 2021 13:16:13 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Huang Jianan <huangjianan@oppo.com>,
        Jianhua1 Hao =?utf-8?B?6YOd5bu65Y2O?= <haojianhua1@xiaomi.com>
Cc:     "xiang@kernel.org" <xiang@kernel.org>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chao <chao@kernel.org>, guoweichao@oppo.com, guanyuwei@oppo.com,
        "yh@oppo.com" <yh@oppo.com>, zhangshiming@oppo.com
Subject: Re: [PATCH] erofs: Deadlock caused by kswap work in low memory
 scenarios
Message-ID: <20211123051612.GA4009@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Huang Jianan <huangjianan@oppo.com>,
        Jianhua1 Hao =?utf-8?B?6YOd5bu65Y2O?= <haojianhua1@xiaomi.com>,
        "xiang@kernel.org" <xiang@kernel.org>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, chao <chao@kernel.org>,
        guoweichao@oppo.com, guanyuwei@oppo.com,
        "yh@oppo.com" <yh@oppo.com>, zhangshiming@oppo.com
References: <669247783482488c8654c55e67fe1ac3@xiaomi.com>
 <64eb8b6e-ee30-8649-ba42-e08db17dfea0@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64eb8b6e-ee30-8649-ba42-e08db17dfea0@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianan and Jianhua,

On Tue, Nov 23, 2021 at 11:58:32AM +0800, Huang Jianan wrote:
> 在 2021/11/23 10:59, Jianhua1 Hao 郝建华 via Linux-erofs 写道:
> > *We also found that it is easy to cause deadlock in the kswap scene， We
> > observed the following deadlock in the stress test under low memory
> > scenario，**﻿**Same as "erofs: fix deadlock when shrink erofs slab".*
> > **
> > 
> > Thread A: Thread B:
> > 
> > erofs_try_to_release_workgroup(grp =
> > 0xFFFFFF87ADFEE610)erofs_insert_workgroup()
> > 
> > erofs_workgroup_try_to_freeze(grp, 1)//xa lock is held here
> > 
> > //set ref count to EROFS_LOCKED_MAGICxa_lock(&sbi->managed_pslots);
> > 
> > atomic_cmpxchg(&grp->refcount, val,EROFS_LOCKED_MAGIC)pre =
> > __xa_cmpxchg(&sbi->managed_pslots, grp->index, NULL, grp, GFP_NOFS);
> > 
> > xa_erase(&sbi->managed_pslots, grp->index)erofs_workgroup_get(pre) 
> > //pre = grp = 0xFFFFFF87ADFEE610
> > 
> > //stuck there to wait for xa lock, already held by thread
> > Berofs_wait_on_workgroup_freezed(grp);
> > 
> > xa_lock(xa); //wait ref count to be unlocked, which should be done by
> > thread A
> > 
> > atomic_cond_read_relaxed(&grp->refcount, VAL != EROFS_LOCKED_MAGIC);
> > 
> > Follow-up fix:it need to hold the xa lock before freeze the workgroup
> > 
> > beacuse we will operate xarry?
> > 
> Hi,  JianHua,
> 
> The fix is in the patch, please test it kindly if you have condition.
> https://lore.kernel.org/linux-erofs/YZcJpDs3FKpSfzAE@B-P7TQMD6M-0146/T/#t

Thanks for the report, I had some other work to do just now.

I've pushed out this patch to fixes branch and will send to Linus this
week:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/commit/?id=deccd444d2844f1e89314dfc3956cccfdb813b65

As Jianan said, I believe this patch can fix your issue and please take
a try in advance. Also, it doesn't effect v4.19 and v5.4 LTS, only v5.10
and v5.15 LTS are impacted.

Thanks for your report!
Gao Xiang

