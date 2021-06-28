Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7C3B6B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 01:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhF1Xiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 19:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233465AbhF1Xiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 19:38:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DF0FB61CBA;
        Mon, 28 Jun 2021 23:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624923384;
        bh=qXmWFItnTdYoBR9+K5Sc4/OlhXsrkNE6YdO//n+SAFA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CNA5eqnoG6eXHQqdINNHO0//vMVfS/rdX06vcDvw0nvJQUkzNmFfvWOGzFD+H+hVV
         YlhXK8bxSlDtlyNiSA7k0krt1lO4GeRVbdE7BQnhq74Eo3BHJCIBLVsE4WA322DcO+
         WDP1WLaNageZyaE2xzY5pWe8jukejJyLZElj0gJfWkGSvqubAspEAe5VRX7hP9TYHa
         OZzI9WIGq3w/u4t9/rCFvHYJFlFrJAeuxEVOLieA/guP3kHy/vGtcDlTEOrSJ9rkPb
         Fie2U3uSfpsMZ/u8jweHDwedlH7PcOnHr8HWxTjccRnQg7mvNftgjIInMbgT+EWh/W
         FDkEEu5nNFZtw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CBF2D60A3A;
        Mon, 28 Jun 2021 23:36:24 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210628153020.GA18976@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210628153020.GA18976@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20210628153020.GA18976@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.14-rc1
X-PR-Tracked-Commit-Id: 8215d5b7f15f8643bf12fe005b2bc0cc322aff62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7aed4d57b113f81214bea1ddb10480f620ade800
Message-Id: <162492338477.13806.9034684085428438298.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 23:36:24 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 23:30:22 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7aed4d57b113f81214bea1ddb10480f620ade800

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
