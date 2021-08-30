Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2356C3FBF0C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbhH3Wkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237384AbhH3WkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:40:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C087161004;
        Mon, 30 Aug 2021 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630363168;
        bh=BGsONLNLbh+AUFxt6h3ToK2audxN2vLjL7KpkZAJsDI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hqJ7Azg8dGCy7Lo1oqZN5T5RRqCutfZ5jVpRpIshehbNfdEhPLEj8CHf4f6HmAO1P
         YeLqQZmq0fpA0AhuRu3oc9Gk9B/wJd4s9/BWrwj4SNwc4XqmKP1hk5GG1G8+pCdcip
         etPYCwqHjAKbZ8JEhMat0TaQxEz/kySE2QEz4+rjukKRPvlatr3AYHSjaBE/x2Fj+K
         6DMnnF8GffjgJxVEjCKuIhaaoY1bFNckqgbbNd8nSsTaGJC9SazBz1J3o2fDrXpWPd
         ohyiGmiFLXMeXAN7b0sr3+Hu366Ms6GLfSsslNGrHI3abZtGqQ7ao1m1PjfixjOLHb
         ScJF7mfQ9yahg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BA56F60A6C;
        Mon, 30 Aug 2021 22:39:28 +0000 (UTC)
Subject: Re: [GIT pull] locking/core for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163031993374.58256.622407503518554022.tglx@xen13.tec.linutronix.de>
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de> <163031993374.58256.622407503518554022.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163031993374.58256.622407503518554022.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-08-30
X-PR-Tracked-Commit-Id: a055fcc132d4c25b96d1115aea514258810dc6fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5e726f7bb9f711102edea7e5bd511835640e3b4
Message-Id: <163036316875.23007.4505500913514625644.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 22:39:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:44:44 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5e726f7bb9f711102edea7e5bd511835640e3b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
