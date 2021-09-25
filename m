Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A7F41840D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 21:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhIYTIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 15:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhIYTI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 15:08:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4D50061077;
        Sat, 25 Sep 2021 19:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632596813;
        bh=E3XCLKC9Qh6rBwCl2SNh6TUGSBEEmNTtGj2TFLQzLo0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HKZqWR+zGDEZTxU2XePVsvCf1ocZrDYuN+oUjCY5eoC8p9Zi3LvLiFjAL6s1buQDv
         xYdb7j4hQMvMUDiB9OsO1WBYWLcngi44jY/SQpz8D4637rNTdCyoGoMQY3JD4q9bwX
         IMTxXEy75xLW0/DGbTZDJnhee8pheXITNfletzNWV71v2BnWxB0QWnvhjHOJdA5XKK
         RXzRO0AYW3Isy+p+sTKWZYWEZNggpKRwIlS3aARjrubBcPYknIk47p0L66sY6kROZ2
         jiLfx9k26YhwXkY0dBaIFVLcSI7Y6QXc60eYGKi6dtkEXpR3fBoNU5i5lywFUVuTll
         JSEwszHeIGzJw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4135260721;
        Sat, 25 Sep 2021 19:06:53 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210925155757.GA22083@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210925155757.GA22083@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210925155757.GA22083@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.15-rc3-fixes
X-PR-Tracked-Commit-Id: c40dd3ca2a45d5bd6e8b3f4ace5cb81493096263
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5e0aceabef618e2bb3d96c096002d8326d46a83
Message-Id: <163259681326.4077.6964995249381369146.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Sep 2021 19:06:53 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Yue Hu <huyue2@yulong.com>, Liu Bo <bo.liu@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Sep 2021 23:57:58 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.15-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5e0aceabef618e2bb3d96c096002d8326d46a83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
