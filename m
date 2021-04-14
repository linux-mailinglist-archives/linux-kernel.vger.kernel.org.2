Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A6035FA35
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351795AbhDNSDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351580AbhDNSDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:03:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6221C61168;
        Wed, 14 Apr 2021 18:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618423373;
        bh=S969RyVAw4Ti/v4d6k5/FzuVNBExktfV22kbKIfcgI8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uREhpwRQgDPYeec1CgxySUsN22ZzdRko6hlx79zFUCxRK3/b9VWJ7XSr/iD8ksxp5
         0Ub7P/fxduHciJRnqluCrrLAmx9j0lt5FcpNGFazEqh4QEExHpnYawwzehdCYLwBed
         XvJox0jMuLKRUX1l4cMUmSTgHi8jikT4Xkc4F0ShkMGJdlrGAX32G429+DcLzyMhbJ
         cf7XQ7x69F+4aX8XjCn/12Csna/GozWpgWaxgcDLyA3fQexIYPqmAUIme/VvU1+CgQ
         i+9+CSSMV4DuhfPWGpnd5qUGIsB/0926lDaMzyMbpTR+4YkL1c2AYGSaY8WkU/yAeS
         a8AKq6EnilHdQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 522B860CD1;
        Wed, 14 Apr 2021 18:02:53 +0000 (UTC)
Subject: Re: [GIT PULL] arm64: Fixes for -rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210414171334.GA25300@willie-the-truck>
References: <20210414171334.GA25300@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210414171334.GA25300@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 738fa58ee1328481d1d7889e7c430b3401c571b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec97a7296ad1ca3ccb8bca1e72739cb8262686f1
Message-Id: <161842337327.19533.11791869407185736160.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Apr 2021 18:02:53 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Apr 2021 18:13:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec97a7296ad1ca3ccb8bca1e72739cb8262686f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
