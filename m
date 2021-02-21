Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9675320CD9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 19:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhBUSpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 13:45:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhBUSlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:41:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E369E64F08;
        Sun, 21 Feb 2021 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932783;
        bh=elGYTcXChBWsfDRccHJ3f3SY+OUH/bcWWbYdGxO5JzM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c3Y0+MRSn4StdK32kqjwV3khCDTUmpzDn6Yu69jDntfPDkNCMkNSBFiy0slBbZm5F
         frqcm4zmUigOoQgMU/sPKnSVRDNNjoxvPei78tz1EMh1EuCWdIEpDkBHb/z7mWunJr
         A2RAEkzB+OrvgSWlldC2au0aYC9ixT51n9uTSLiZ2yEPXaYBrZDimFCFUUCLgANYo8
         MY1bbLfnmuBQ6WCdo9/RtoKi1efg1+7hr4HXzaZQDMAhDXeePRMfr6atouy72RkIo0
         lWo6uw4Qsq87QCAlJvulth6EYQSem9aIkxBOAISjMCUokSIfbxsDZvx0CQhP//frsE
         1X6O1VV3/kDOA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DD3AE60191;
        Sun, 21 Feb 2021 18:39:43 +0000 (UTC)
Subject: Re: [GIT PULL] erofs update for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210219113537.GA492321@xiangao.remote.csb>
References: <20210219113537.GA492321@xiangao.remote.csb>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210219113537.GA492321@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.12-rc1
X-PR-Tracked-Commit-Id: ce063129181312f8781a047a50be439c5859747b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 681e2abe2191058b320716896cccda05b161eedc
Message-Id: <161393278390.20435.11331185091951569905.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:43 +0000
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Guo Weichao <guoweichao@oppo.com>,
        Gao Xiang <hsiangkao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Feb 2021 19:35:37 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/681e2abe2191058b320716896cccda05b161eedc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
