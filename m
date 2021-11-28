Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79640460837
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358704AbhK1R7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:59:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48784 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358646AbhK1R5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:57:39 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71EF7B80D3F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 17:54:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id EE1D260E78;
        Sun, 28 Nov 2021 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638122061;
        bh=5PmOpZgTeHb9YoY3QxTEwf9eESg/w1YHKiAypdcNP+w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mV49SCYMFl9oNQG/83OhJoHgZHxTNbEKhaa0vvxTEmBwbULiGfV+R3oJwI7BjJWjo
         PMnq2JRxISNXvCIDB6Xwx+aF/sRSI373DalN+qlRQo75MGz75iIKhjoBTltJUnmeRg
         CfTQQKD4Inv3G7HVxClCDA1g7hSu6oAEnvsekGty4NJBQ0oJXF1HwsR4mFZ8rqy57I
         /Yf8ShKcdwG0GKcO7qdsiCXJc5OnkEocEkEKjk9Kg33JE5b8ZMeTqmLdJw/ftptS6n
         k+O3MlJCaWCJiI19W18hE4Cav2x7ZmDtj0rtUVXM1qfaTZsFKg6NzcEqNIHYgZAAbm
         MIiCmO9SId0GA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D54B660A6C;
        Sun, 28 Nov 2021 17:54:20 +0000 (UTC)
Subject: Re: [GIT pull] locking/urgent for v5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163811728418.767205.14544746031342483043.tglx@xen13>
References: <163811728418.767205.14544746031342483043.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163811728418.767205.14544746031342483043.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-11-28
X-PR-Tracked-Commit-Id: 14c24048841151548a3f4d9e218510c844c1b737
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d039f38801245ed99c0351b2259550170d7fe17b
Message-Id: <163812206086.22773.5342234555555247607.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Nov 2021 17:54:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Nov 2021 17:35:16 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-11-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d039f38801245ed99c0351b2259550170d7fe17b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
