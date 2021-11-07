Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3094E447536
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhKGTRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:17:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhKGTRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:17:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 28D8060F46;
        Sun,  7 Nov 2021 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636312473;
        bh=mq5xP7UyJruumTLOW1X/BBtTaN0hak8wu6C83XuG9L0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h1MFS4ykkb8PePlyLolU7yaOkADTK/awiInJR7bhrYMzsDwJk0bWEBUA2Mka4D126
         NAITRNPD5egMivokicH1B5E5ipf/QMtWyXRFn9T2s11yI8kAIaHvprZ0qGxnextncd
         oBp/jU2Cq8hYBaKSH63i0rX7D/XD+eQchmZ8b03JHvfvSyoWa8bHhOh/Hwl60I06oy
         oXOrrVOXEv+VyxU5X0HVtPwqgVDk0CHZKQTcy8VyTx3R5aR+u+uHKucU1KOB65elI4
         TvgUfviywKQnuoaeoYShoOffBRL+zyLJjIEn91A4WCIirvbR+LbxWqh2kakLm6tEYm
         Lk+Joi+X/miCg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1C2F860A2E;
        Sun,  7 Nov 2021 19:14:33 +0000 (UTC)
Subject: Re: [GIT PULL] Compiler Attributes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211106133345.GA15102@kernel.org>
References: <20211106133345.GA15102@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211106133345.GA15102@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.16
X-PR-Tracked-Commit-Id: 7c00621dcaeea206d7489b3e8b50b1864841ae69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e54ffb96e6f41eb5ca2f89788f95224273ce09f1
Message-Id: <163631247310.5338.6116226076671691808.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Nov 2021 19:14:33 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Nov 2021 14:35:23 +0100:

> https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e54ffb96e6f41eb5ca2f89788f95224273ce09f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
