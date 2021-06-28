Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02E23B687F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 20:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhF1Sgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 14:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230220AbhF1Sgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:36:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1A32F61456;
        Mon, 28 Jun 2021 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624905265;
        bh=VaOQ0YMaG7aDmIWE7zKp4MZY/P6VduubE2yBcd2dh5E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=elKwoJdFvM8XBPTUhOgfwNRWd6r2cvia4xVkXO8WuxRGzRMku/YzQ7jM5t8vrT5U5
         f12tOKxDlB6BdxwNUxYT4yB30wlThKpa5QD2rgpkEQMVH1YmjTrQDhkPGjmoZAZyVQ
         TvQPNuqn4RgsMwmI/snqaPHlu6myuSsMng8ykALsHYUV3mcQsUdjPswzPUEl1rxIch
         xo3+q3R4f7rP3tgQn1NxGCa0wf0QIzH/cIPGltT8Udkwz5TBZmNsCmmF5ikPPu6d/x
         ISoUMf4TOwt5qo1NWACj22uMWJxMYvJ240W5Io6vHO7qwdF2yKkkz8R/bU5VLUSNXS
         QrYycsGhbEcQg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0567560A6C;
        Mon, 28 Jun 2021 18:34:25 +0000 (UTC)
Subject: Re: [GIT PULL] RAS updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNmFt5yMpePkeb6Z@zn.tnic>
References: <YNmFt5yMpePkeb6Z@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNmFt5yMpePkeb6Z@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.14_rc1
X-PR-Tracked-Commit-Id: 429b2ba70812fc8ce7c591e787ec0f2b48d13319
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f565b20734d32bab5a899123d2c58909dbf46a5d
Message-Id: <162490526496.16283.11958857932461328509.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 18:34:24 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 10:17:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.14_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f565b20734d32bab5a899123d2c58909dbf46a5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
