Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB804424ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 01:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhKBAxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 20:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232021AbhKBAxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 20:53:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7A3C56102A;
        Tue,  2 Nov 2021 00:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635814265;
        bh=WPXOR3JQCQXts5v0DWb3OvH8hoj7qVJ5n7mt5NzreAc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pgMF+Ki5Dy+Mridharg0wzHOFNRaNTf6scXPSkwUSnxgqRfAlhaVCepzmdNJaTu6x
         kpRsPgc591+c5dTWU1hq7dcMQrvsvvbZsExRL+8AebHnMPrZALcjD7Ah3fwUjwv+TL
         O/zNbqJsOvAmtJ5QOBof0I4/q1vcZQ1WCWOuSYCGTZxD0yvi+VjIFjVV8VDtAg4uHy
         ddDDOigXv2buZ/ZIgZbyYyULFvIT0VjAJJpj05mpdxu+w7QqFpZeuoXN4WFgbnVdhd
         ps28a8DPzDiyK1flDSwvUBp28kr5EWb9L2DTcr6+ye3o6moQo9spTvOI+yLxEITpgZ
         aOC0Yr9cHZNIw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 739E260A0F;
        Tue,  2 Nov 2021 00:51:05 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYANgdNcYx8KQJUJ@ls3530>
References: <YYANgdNcYx8KQJUJ@ls3530>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYANgdNcYx8KQJUJ@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-1
X-PR-Tracked-Commit-Id: 6e866a462867b60841202e900f10936a0478608c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 552ebfe022ec67aca4ff2bda0722ed0e28fc90d5
Message-Id: <163581426546.14115.14600256839310753977.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 00:51:05 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 16:53:37 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/552ebfe022ec67aca4ff2bda0722ed0e28fc90d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
