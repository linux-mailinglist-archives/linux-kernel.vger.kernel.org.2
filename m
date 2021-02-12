Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665D331A5DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhBLUNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:13:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhBLUN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:13:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9C03C64E8A;
        Fri, 12 Feb 2021 20:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613160767;
        bh=XzQIysu0mQndJ05yt6pmqSQeOyq2FC3T5KKmaQ86PKc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b1dlWhQjM8qivUwniCl1Ikt1JeRoRNCQlbX4nQ10uEUvgIJ3C1BjgNMuk5JVRFVWK
         xh1y/1y6npT9nkmgvFAcitrQvaCGHwpBJhxByZHmkeSRk5AHD/twQoXEw5UTcei641
         Tu436eYTbkWYBpzsQ0hslG/L5AHcJW9l0iRsCR0+1jaEk6UZK6p0t24z0Ch+Vkcrb7
         AAZ+vBbbhhcFAgQJoXJ73FlI552BjQsFDaA0JAsBQbKbC6dVNrrJ+AKq9zfgciEbU7
         xoNgjUyO2aA62Y423ktxdvp/4y4KQCKCs0vKJedRP8Fl34Y+c9hQtCziX4qRyxLcyv
         HBVK2CPADtaIQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 966F060971;
        Fri, 12 Feb 2021 20:12:47 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fix for 5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210212180649.GA11697@arm.com>
References: <20210212180649.GA11697@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210212180649.GA11697@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 68d54ceeec0e5fee4fb8048e6a04c193f32525ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93908500b8da0423c9f0511130c8ab86d59576a0
Message-Id: <161316076761.13717.17841435648461336354.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Feb 2021 20:12:47 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Feb 2021 18:06:52 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93908500b8da0423c9f0511130c8ab86d59576a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
