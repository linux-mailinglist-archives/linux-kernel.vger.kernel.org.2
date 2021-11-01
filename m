Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851D544215E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 21:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhKAUHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 16:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhKAUHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:07:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 314D760FC4;
        Mon,  1 Nov 2021 20:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635797099;
        bh=zB6FquU3FizSgEVNz2wf/9ZogROCeYf8bVP8abqHgps=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F6ETw+jmByXG2Kv1BnKMPvCeMaEGxZHgC+dWjQ1W/ALzrnqmIzvGahNm0YS8b22X/
         w2Jyr9pr4Xymm849FW46xHJJjwJy9HCfCSchpuT3+IpHBBMBg/YmrMM+6sjydRJezs
         AAlJm2oKeleA8ZqzaNnlxSrf59zs7neCcR68HGyEKVGgZSayKfbsdtNJKMEKbY0T52
         8ox0c5+SPJZvkJFRi2/fDgVNTusCeC/1tEe3nH8BC6xOIEPnCfCXofAPnznEDFYDKb
         yes7zvmhJTsyWrGX2Xeefy3oDxOIuk1VaOmw6IkXn/pJgJn01FxfDJigMKxP5Hl0BE
         jnLQ36wJSzksg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 29C8C609EF;
        Mon,  1 Nov 2021 20:04:59 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211101003654.GA23732@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20211101003654.GA23732@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211101003654.GA23732@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.16-rc1
X-PR-Tracked-Commit-Id: a0961f351d82d43ab0b845304caa235dfe249ae9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67a135b80eb75b62d92a809b0246e70524f69b89
Message-Id: <163579709916.1875.15474563954203260409.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 20:04:59 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Lasse Collin <lasse.collin@tukaani.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@yulong.com>,
        Miao Xie <miaoxie@huawei.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 08:40:32 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67a135b80eb75b62d92a809b0246e70524f69b89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
