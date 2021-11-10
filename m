Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45BB44CA33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 21:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhKJUMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 15:12:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232448AbhKJUMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:12:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5C9FC61211;
        Wed, 10 Nov 2021 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636574999;
        bh=GIza7ZSIohqzIK+kaaRIB/P1v9W2acV9w2TyeOxoMfg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=giJgjbDBhXRaKNgqHBsULZ23zd//+P05DGIkWkmgMTjmyJtYa+8Zo9HUw4gJdywYW
         xkB6tLtOhrQ0NIcMIK4EU4vx30wE+20CBqB/RfkXZU766VpJtrpBmQ5h8nTyrtrDO+
         CZYfDLBSv+SZbffFVYqRpVxRIfLMALRqgVHVgxob7kaf98ERQWqCHdK05czBeKh/xx
         T5rZ44H4xZrh796hLVIqaNwO2sSTP5jpI0sUITNsQEs6HoG3qzXQEJkkqeGr9S0lS2
         FTzM8C0XsR1JPMR2JhGRq9U3sF8G9d4OXoEKsPL7GhWuwVGJcSxpmTPiFl/RHlZxRx
         m5tJXu04OGSBQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 562E560A6B;
        Wed, 10 Nov 2021 20:09:59 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211110185212.GA4786@willie-the-truck>
References: <20211110185212.GA4786@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20211110185212.GA4786@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: c7c386fbc20262c1d911c615c65db6a58667d92c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89fa0be0a09c8edb5e028e7368ae87c8f6cbc462
Message-Id: <163657499934.19350.8868175352924867775.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Nov 2021 20:09:59 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 18:52:13 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89fa0be0a09c8edb5e028e7368ae87c8f6cbc462

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
