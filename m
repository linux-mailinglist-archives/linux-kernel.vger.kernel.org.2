Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BFD3759FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhEFSMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 14:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhEFSMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 14:12:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 857C461026;
        Thu,  6 May 2021 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620324705;
        bh=jKmnbB+Wm0o13X4JE/nV9I9FO/Rx92xBrQ/3A4pxSNk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mPhsxFpnYsYquT9Fu1daIbz/5sv3zY7gYugDoix8rrt4esOzkTUbRBbdcgfh051r5
         RyxIaQtUVY8pWJepcoOgzt0TMIi9TIu4o3s1HlFCHupNqoE9vgmK1vmOeBtJr9B4An
         NLC6QwhFxLCkCJfPNgWyxcEZYWQIuYzj7TUHPMq4jMbkov6SDfvRHyEqGUn9M1G8i6
         /xmkKSSJO0LsCVr14iblJSTbLEupjwq4llJwifk8tu/i3YPCvyP4QV/g8jsfqkJNZH
         HHAdCnZwJlFPFNVuq1N/jGm+FK6E/l2tg9vdGXy3Jvu43nb3zaFYuyUbF0c3aZrwO0
         BOzHqReu1DH/g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7A7EA609E8;
        Thu,  6 May 2021 18:11:45 +0000 (UTC)
Subject: Re: [GIT PULL] pcmcia updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJNw8bTiB+kZWA7u@light.dominikbrodowski.net>
References: <YJNw8bTiB+kZWA7u@light.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJNw8bTiB+kZWA7u@light.dominikbrodowski.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next
X-PR-Tracked-Commit-Id: e9d503fef7da2cc0610ce9cd056d0347ec9cafc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38182162b50aa4e970e5997df0a0c4288147a153
Message-Id: <162032470543.9538.827545441174367249.pr-tracker-bot@kernel.org>
Date:   Thu, 06 May 2021 18:11:45 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 May 2021 06:30:41 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38182162b50aa4e970e5997df0a0c4288147a153

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
