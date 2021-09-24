Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE810417B03
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 20:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348150AbhIXS2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 14:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346239AbhIXS2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 14:28:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4EC7A60F24;
        Fri, 24 Sep 2021 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632508007;
        bh=e5v+SZddNVcYgA46bsTcKL7cjvmLBwquaSPGLYfNieA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A6l2yUnVFsMl2fuHR2dDzVZQjuLmkeniMjXw+6Drdrpu0VmEyvhpXr3DpyqK9fBKE
         JtTlNU2t40Nnhq4SI7WoMwtn+fyaPrcWvdt2cwZ66xaQ4xrwEN2UBmx+j8SmNXsSPn
         wrZ/+dmCPofPXoOa5tC949V6ez1l2fiS4muYwy2El4zViQGRyFkOifpEyNRGzfMUou
         FUxvo4DUzD/4Swb9yQ+nkyQBd0JNzZI5ca0vBppWPsQPSjoQ+VBmMHn4DbQvnMZ78B
         xR0xWru+FR/+HRYQcs6DTYYbVBcclvJmVY6OKDWrQEpVXdspU72Hz6ZIu8MnKYNb+f
         NDEv/RomcK9Dg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3B38F60A88;
        Fri, 24 Sep 2021 18:26:47 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YU4NqD1xVANVj0y0@arm.com>
References: <YU4NqD1xVANVj0y0@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <YU4NqD1xVANVj0y0@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 22b70e6f2da0a4c8b1421b00cfc3016bc9d4d9d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b7eaf570140281a1aa898a875aa587d48d96958
Message-Id: <163250800717.5900.5414267426601294836.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Sep 2021 18:26:47 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Sep 2021 18:40:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b7eaf570140281a1aa898a875aa587d48d96958

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
