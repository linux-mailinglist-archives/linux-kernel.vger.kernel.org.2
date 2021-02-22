Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AA5321F01
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhBVSRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:17:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232035AbhBVSNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:13:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B5DDD64F13;
        Mon, 22 Feb 2021 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017537;
        bh=Encdi+QHcNYufmigSPMhzB6NxiOmSvtS740S8osYJx8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pRLx5X5plCsNtUOnu6U/Eta8jSXGF9ZxTd7XA18iDmPCL9f4litq5L38J8zHV+we+
         aV+piJ31gjowET1Bi6b6U38ra6IdwZA9yjVqJPwbDhAGJ1tsi7h0b4vG7OHUhXmx0v
         FdwXpI0a+AEBvERuvRYFxdqjGPd0RtRWHrDqqiGGeIude5gYCoHjBnACKziLAbDZO2
         7Yd4KftyxGc8DttJKhi1MQVwnj8NAl3JCssvgdM36FzPzPeCwR0+YWVrMU2NPPucp6
         ky5gPJRAjkOhYuZi2ysNpC31/Y+6zN+Cq5FFQ+GIpqB+dGtL4uXamtDq+8FFth3shY
         TGIwTwvTRF7Rg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B21B560963;
        Mon, 22 Feb 2021 18:12:17 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210216164505.GB4803@dell>
References: <20210216164505.GB4803@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210216164505.GB4803@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.12
X-PR-Tracked-Commit-Id: 26783d74cc6a440ee3ef9836a008a697981013d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f158bbee9403b7bd2ad22f0c03b7e9762c20ad18
Message-Id: <161401753772.943.7376496930211451895.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:12:17 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Feb 2021 16:45:05 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f158bbee9403b7bd2ad22f0c03b7e9762c20ad18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
