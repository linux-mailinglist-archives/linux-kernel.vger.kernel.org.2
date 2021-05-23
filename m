Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3A38DBEF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 18:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhEWQg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 12:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231815AbhEWQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 12:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4425B61168;
        Sun, 23 May 2021 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621787699;
        bh=+6Ojf3LNxlcCLUAf63EUvlDxXZMheXgey5pRjNqrON8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bMgGRvg2F0KugwizdMh7hyoc2P7MEvVFhLX6J5WslIOIg3fH5FaGV0lxGZFZv9InC
         2CYiGwHp8x9CdisDARooA5pIQ5KYIZcMzYzUuaTZDy+Khr633k1uvDQVOe8QW+z9tP
         AG7LHPw8++QgNlF1r8n0XpogjQFwxJh06TV6xItXAIr2CVsrVudZAo018Ya7tG/E3R
         As8h9VrXaUo8l4xKS9bn4tQgMuTwDTT20UhwSIVABqhOFyRF+GAnGDhichGe1JTsdc
         9NJbnJSssGPn7gMjEZLLbzXEgw0PD4bI4uJ4MX2DKm+K+Z0Q5Y95Ie+08kgNKM7vkq
         v1hubxpMtWIig==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3146360176;
        Sun, 23 May 2021 16:34:59 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162177682324.10917.7221704858691713254.tglx@nanos>
References: <162177682324.10917.7221704858691713254.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162177682324.10917.7221704858691713254.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-05-23
X-PR-Tracked-Commit-Id: b4764905ea5b2e5314ef3aed96e1c5a5df9318c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f73d2a429334dbd30bc9a7e5ef5e07a676d3d499
Message-Id: <162178769914.22288.9936630566810082285.pr-tracker-bot@kernel.org>
Date:   Sun, 23 May 2021 16:34:59 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 May 2021 13:33:43 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f73d2a429334dbd30bc9a7e5ef5e07a676d3d499

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
