Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE15B43CFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbhJ0Rq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229887AbhJ0Rq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:46:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1E90E60F92;
        Wed, 27 Oct 2021 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635356671;
        bh=nL7X/132GuZaimIiG3qxPM5gY7AHDNKMjOoo2/jldNg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fUpUlfbrZBpcu9qPdAFDoehIug6aBjkwwhmFX9btcX8VB/5fXTjKWuD9x4xoeGrz8
         au93eed7p/QSazWisb2bMRqCZF8hO5OomEtIFI3ygeDU7BH4szJcJ7RbFMeOKQLyjc
         cFfbm1HeiJygPGXFH6ABTqE6DBUvs2eS76ILyYI3lPnSTR/qUJSG7ifFegciapvGM4
         A4AMxOF/PBAA1vYGUl25WG5J182tE4QjxM8EKMnqsZHB1mprVwW/37ifqChnHjiMLy
         cYpAayLqQyYzpYlfb+VEhmAAIbRYyHNZwEuchWHFCaWl2G6g8GbPBW8iRNs3ocOi8J
         X2IOt473i1JgA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1337660726;
        Wed, 27 Oct 2021 17:44:31 +0000 (UTC)
Subject: Re: [GIT PULL] NIOS2: fix for v5.15, part 3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211027145253.454811-1-dinguyen@kernel.org>
References: <20211027145253.454811-1-dinguyen@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211027145253.454811-1-dinguyen@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fixes_for_v5.15_part3
X-PR-Tracked-Commit-Id: 4a089e95b4d6bb625044d47aed0c442a8f7bd093
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 646b0de5fe32306eaf5399647adf2177d4417021
Message-Id: <163535667107.24725.3658320103235560644.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Oct 2021 17:44:31 +0000
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     torvalds@linux-foundation.org, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Oct 2021 09:52:53 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fixes_for_v5.15_part3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/646b0de5fe32306eaf5399647adf2177d4417021

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
