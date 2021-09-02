Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3653FF497
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbhIBUGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344040AbhIBUGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:06:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C98616108B;
        Thu,  2 Sep 2021 20:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630613126;
        bh=CWwQNbiN15uBWCh3JH28vqGnBHx8ucCFJWsueGFFXgs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q1ec+1TiSIN+8N5880oG68PWsoGdGUWFvzDVCdm32VekZJHQLWBg42awepwkNNxz6
         r+1Eci/MPe8Vd+kpqsZdtWO1BsA2M10pbACMktWXIFBDDoXbbT6hZFWsJ9+xf+DWaf
         k0DGGqMelbjHSNZoWs07G3z7HpfeKl4barFn4vzR/AZdMRj4fJcuqmiHnzs9YuW2nM
         ldYA8K9ASNcxxo0hFztJ1yKCHAnarcAfJX+nvZH7etP9k/w3OARnn4gRAiaqicnz1m
         t2TbFCK/7+qPK2LzH74xQTpkqOEcRrfXDViU2U6NKs3RH+kTET2BYJ2qmX6kxXv9/F
         rEB9BpT/Jnrgw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BDFDE609D9;
        Thu,  2 Sep 2021 20:05:26 +0000 (UTC)
Subject: Re: [GIT PULL] locking/debug updates for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS8eLmLdB7a9WLGd@gmail.com>
References: <YS8eLmLdB7a9WLGd@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS8eLmLdB7a9WLGd@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-debug-2021-09-01
X-PR-Tracked-Commit-Id: 4812c9111220b0af00f7a436cc02ffaed289962c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa829778b16f15266fefe2640f04931b16ce39c0
Message-Id: <163061312677.10011.17657901793795417610.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 20:05:26 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Sep 2021 08:31:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-debug-2021-09-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa829778b16f15266fefe2640f04931b16ce39c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
