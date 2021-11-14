Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676A844FA11
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 20:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhKNTOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 14:14:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236199AbhKNTNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 14:13:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E44C761167;
        Sun, 14 Nov 2021 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636917023;
        bh=Q4WAZdjQURA9pCYOF+1o0igcJhf7i/BxE5hDu8h24XU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=meUjbECFv7GZe4xf46ZFc9okzR40O22CddyZd0KhTqXy0f3rVRRDAVfXm7qdmavwh
         PNaTm0rmAJm9307ctj56zftMJNIjuiqtbo3K78Y4VPahZX51AQAGL2X0qlq9ojiKW0
         tPFgE58sUO3zgwbt9E6Ibwrr89vHtem4SnT6XNsfW/wIdZBXIFRjhJXXm+iKcpNVgg
         msy1OGcX54OuTlm8A0sfhKaBVwx0I4Eyct5bKBHRTHMn8ws2Ljw3xu65+SjPSDs12T
         C7exZd0WAq529dPKY6/DytsIACiu0UVuI4lZ3vYuef9JB1wrlbaMQoxh99wj/S0w7j
         N2H9r8MZC/MVg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D74D6609F7;
        Sun, 14 Nov 2021 19:10:23 +0000 (UTC)
Subject: Re: [GIT pull] locking/urgent for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163689642600.3249160.14155489699842458627.tglx@xen13>
References: <163689642456.3249160.13397023971040961440.tglx@xen13> <163689642600.3249160.14155489699842458627.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163689642600.3249160.14155489699842458627.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-11-14
X-PR-Tracked-Commit-Id: 2105a92748e83e2e3ee6be539da959706bbb3898
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 218cc8b860a255ce7f1a03ff3ec70953c423d27d
Message-Id: <163691702387.341.15628821081781991407.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Nov 2021 19:10:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Nov 2021 14:30:58 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-11-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/218cc8b860a255ce7f1a03ff3ec70953c423d27d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
