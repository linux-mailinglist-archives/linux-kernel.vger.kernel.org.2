Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D243304DE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 22:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhCGVbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 16:31:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231504AbhCGVax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 16:30:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C6CFA6515E;
        Sun,  7 Mar 2021 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615152652;
        bh=uYLm7xKK6ZEE1lqBbXhkmhmNi3VPcFb0sKmL8xv+k3g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bkTAZubQX1P4oxlR/1s7gr6JpD6Bn3xbDbcF7pQHPuGzGoFEavqLd1ps+5AN1EDVH
         RVAk/T+X2B7c/MpKvDZN6wyhOjdAwSfj3revpnAHxF6P2XtL2iUWcHz1jwRNa+xtRL
         g+GyaHLDMY8cdKgXO3Uygum/4GHiKOKt6s6pVzmhxg8KXpsUhdpp28aDp74I+4EuJJ
         DXlWvGlGIwpfAivvZ5dMJWfSKN5bVKGuWRevUClPPOwtnJJ4J7E8eDdSxd7IOEfsqy
         5WoIz8sILII5WOx/DRMWEWKcjTlT2WXFya92hGS7+Pu94yLmSHT2rgyKTrWIwfM0iA
         qSEk7urCMBIVg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AE15E609D8;
        Sun,  7 Mar 2021 21:30:52 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.12-rc333
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YEU6nUd2P8ud4fGU@ls3530>
References: <YEU6nUd2P8ud4fGU@ls3530>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YEU6nUd2P8ud4fGU@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.12-2
X-PR-Tracked-Commit-Id: 460c9f1c944b4bf04f2934478fd3f865b730b771
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bb48a8506275f4d9e4593acf9f2fc0880a42f73
Message-Id: <161515265265.2708.148960393594294397.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Mar 2021 21:30:52 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>,
        menglong8.dong@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Mar 2021 21:42:20 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bb48a8506275f4d9e4593acf9f2fc0880a42f73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
