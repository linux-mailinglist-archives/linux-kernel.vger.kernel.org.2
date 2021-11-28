Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA65746083A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358713AbhK1R7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:59:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48818 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358701AbhK1R5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:57:39 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4365B80D43
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 17:54:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id C74D260041;
        Sun, 28 Nov 2021 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638122060;
        bh=YJoozCpLVMS9lxRAguMDjEUQUZH1FV18unlZqj7gctc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AXtpa3wLYt1atATAevMVuLWq0cShuUYAAUe7PUWlmCZ5ZeKUDzbkLeOzFGfsUSh+I
         tem+UWoXX7m2lkCK85fxo1GBp4nXfiVPX04lhRVwd9hSMzUTnFGeGZi04kF9evz72h
         sF37VRjlgTu3tcN14krzIyLr4eSJb9tJa+uRsZNZxd3BAN4/v2b9PuVDkN1Cc4ms2g
         ZlL5fw9TFCc2EHWIloda4vm/2xGhNZvRMEyMUH1G6P7CZA6zZKqKWcZBnMse/uKBLJ
         PYLDpTsUdZA4JJ2OoDuk/AsnYhxIggVhKrGvWjSV+smc41JUUhi52xlWv8p7/Ja5L/
         tvZFPYheJHjbw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B3D0360A4D;
        Sun, 28 Nov 2021 17:54:20 +0000 (UTC)
Subject: Re: [GIT pull] sched/urgent for v5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163811728714.767205.7609265541729493515.tglx@xen13>
References: <163811728418.767205.14544746031342483043.tglx@xen13> <163811728714.767205.7609265541729493515.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163811728714.767205.7609265541729493515.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-11-28
X-PR-Tracked-Commit-Id: dce1ca0525bfdc8a69a9343bc714fbc19a2f04b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97891bbf38f71ec97199d2459368b5b4b700706e
Message-Id: <163812206073.22773.13392679764912710564.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Nov 2021 17:54:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Nov 2021 17:35:19 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-11-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97891bbf38f71ec97199d2459368b5b4b700706e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
