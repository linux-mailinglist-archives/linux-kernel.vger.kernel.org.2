Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73853FBD7C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhH3UmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhH3UmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:42:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D5E7C60ED6;
        Mon, 30 Aug 2021 20:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630356078;
        bh=YeJzLxAyEv3Uwh1MrJTOuZd18fw2bOKtER4hyPcv8YE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fnmmggqFMb0b7Xdq5HbqAsojosiQC4mfpqEzkiOEk8JMqo1aOFMjYa7QVxKr7GimL
         fWNcPVu3stG3LepQMV2eYbVmZ27U8kKqFY9omnt5Sob+TOZmkC7BoI9JH+MPrZ7YwD
         hkxxk8kKDS0XR1MeUkccAE0I7aKsOb7H7uTEEg0pXh+d5DwVJAokdbpT/PUvaBnGYl
         1ga37yX/H0cFMrWuj/vviIYzrwbq19oQTVicgkQglI8AFjq4qFu9X9mijICOTxpWhr
         at+8Y2GcVEObMceh9dEJ2jmeb2ClVGGfwy4zETX460Vt9teji1gaQOnQQd8MK/rYhS
         ejQhsR5JloRVQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C9BB960A6C;
        Mon, 30 Aug 2021 20:41:18 +0000 (UTC)
Subject: Re: [GIT PULL] RAS update for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSyotFTc4bX5PrlD@zn.tnic>
References: <YSyotFTc4bX5PrlD@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSyotFTc4bX5PrlD@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.15
X-PR-Tracked-Commit-Id: 3bff147b187d5dfccfca1ee231b0761a89f1eff5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f645b420822f2061a41d022e8bd9a02fae5ba28
Message-Id: <163035607882.29257.4544389061979950384.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 20:41:18 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 11:45:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f645b420822f2061a41d022e8bd9a02fae5ba28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
