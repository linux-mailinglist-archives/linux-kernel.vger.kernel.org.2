Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ADA3C3EBD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 20:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhGKSZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 14:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235784AbhGKSY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 14:24:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4F7DA610EA;
        Sun, 11 Jul 2021 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626027731;
        bh=enL20HNfw6ujvYhuFMHCtQ+bIgo0TPfnoTPeeN2NjOo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VM5G4WR3InuAJDJ+ylulkschOWwmT4whyldrTB1L52AVQ6903VWM23fyW/Q3s4JLB
         8Q2PQccke/RnSs5KO+fSVpjwO9IgpZpM2h6wSZP5KiQ7ISeIHBN9sLcerRiYvVC3et
         OVpmnulSpSvihrz3UylkyvT3FaHCaKJaQ8OmaZYxIiy4fCVWvLkvELQ19B0hKi/k3R
         /QFWjCNkSdeUDRH3ROPWIorpKFlihjpO9ZitMkjef/xsyVxx6lUPi427rEEt6ixn4y
         jKuQzPHRmBXnOFdPnd6cJrRbxctQAX6eG8h2KRzkjF2+eh5Hb0shQ95LMRf53JGteC
         HVH0E4kdVkhrQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 49886609CD;
        Sun, 11 Jul 2021 18:22:11 +0000 (UTC)
Subject: Re: [GIT PULL] perf fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOrxmiI8jmELoABe@gmail.com>
References: <YOrxmiI8jmELoABe@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOrxmiI8jmELoABe@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-07-11
X-PR-Tracked-Commit-Id: d4ba0b06306a70c99a43f9d452886a86e2d3bd26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 936b664fb20895277453c02be4f3a94d6ce2b3c8
Message-Id: <162602773129.20558.9799494616561868116.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Jul 2021 18:22:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Jul 2021 15:26:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-07-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/936b664fb20895277453c02be4f3a94d6ce2b3c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
