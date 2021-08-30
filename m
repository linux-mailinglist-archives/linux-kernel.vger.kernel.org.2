Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF53FBF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbhH3WkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232030AbhH3WkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:40:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 98A0860F6C;
        Mon, 30 Aug 2021 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630363168;
        bh=csOLv3gkRujoO3vMMklgEdYv7GWHGbQRWAU17hH/hzU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ssBuAf2sHiGlaZ5e7+VpG89BDxWirzTquJ9X2o/Bc/xq2uVaj6bwxS2ITw1cGflWF
         rY38fhTyNLZEtMq63y2AB+jUZxNyi9uJoNlSBYxpQLEvpOnc+vKxvvGg4KbHUzmo0k
         9z8VPPDzbyqO5IAL2cYeOD92FuvvGjgmS6P86SuzF3FR6HFQZ1wT7wurH/YY55kOpp
         b734uvLHiNeyDA1omueYIJncgRrsOFyYyZp/blzRYIpSlcRRW78pTFWdsFhFdfe/OB
         ciaSBHWjjZ61K7xir7qb9YErX2W0iY+hQhGYpYBtMYLwKXkWpubTeKJZYpwrnN0VqG
         Ic85XIddJmYAA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8D15F60A6C;
        Mon, 30 Aug 2021 22:39:28 +0000 (UTC)
Subject: Re: [GIT pull] smp/core for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163031993498.58256.7558950960844391018.tglx@xen13.tec.linutronix.de>
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de> <163031993498.58256.7558950960844391018.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163031993498.58256.7558950960844391018.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2021-08-30
X-PR-Tracked-Commit-Id: 7625eccd1852ac84d3aa6a06ffc2f710e683b3fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08403e2174c4ac8b23922b5b7abe670129f8acb5
Message-Id: <163036316857.23007.16329368189003965228.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 22:39:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:44:45 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08403e2174c4ac8b23922b5b7abe670129f8acb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
