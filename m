Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5374D3B6A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 23:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhF1VRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 17:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237613AbhF1VRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 17:17:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E0C8661CB4;
        Mon, 28 Jun 2021 21:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624914920;
        bh=aMf+nIYzljMhH/NbiVoimaxXnxyS8GYdgzT6FfDxrnM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G+gJBaAEq99/F08H8gBmXC0sGZ3TfwGH0lnZVqJK+6/K/n6FWEB4lCLYnZn9bbBXE
         S4/D1kMzCnf3OSbFlLvf3bMMW4P2IVvNLW/AGF8VDwvK3XW3SpEXh+GYrLQR+GdreL
         43xVtliRSmzuAGPfFAXsts1togZmzB4JANuuVzqgMzTEe8qE0Mdh+WfDzdziiw5U8L
         n4MUDx/qx9Z7Xn2o7lj2IA98bsOrbmn9rt2KXdSj2ScgQNvZK3z35SAOUeVN24v8/C
         dW8vsPENZeVcOXdB9PT9qAI+NdieIWv4x8vE+X2gl3Wgw9hKGsYQiee7wTMCLW8Z/j
         ZMGiyw481N1pw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C9EBD60ACA;
        Mon, 28 Jun 2021 21:15:20 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210628101033.3491773-1-geert@linux-m68k.org>
References: <20210628101033.3491773-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210628101033.3491773-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.14-tag1
X-PR-Tracked-Commit-Id: c1367ee016e3550745315fb9a2dd1e4ce02cdcf6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17cfb9d332243f6d2551818df27d666d3dd70a23
Message-Id: <162491492076.5391.18137860883383214966.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 21:15:20 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 12:10:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.14-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17cfb9d332243f6d2551818df27d666d3dd70a23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
