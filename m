Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2283B78F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhF2UAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234967AbhF2UAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:00:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0C69261DE5;
        Tue, 29 Jun 2021 19:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624996662;
        bh=wwDpt+CTNuifq7IogCE2nO6GTT/9Qoe1WXEJ19E+yvQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MFjk5fJcVhZMSEwnO52XE82i62FWvsosVANDdUfyEhpw3KKZYI4KfcLRctBEEhavB
         ho1Rv8NcnL2L9qIvU29QwwFoNe0mxg98Gtt6I23SCC6c0iH4ovijTjgds/NqZ2aA18
         dqr4Rh/ns5ZuH69Syl8wgx2GTf1tlCbxNhh8tEv9jTAwxMf3RRlz+F8BoZQ9WOTw9j
         iR7L9g0xahzbM9cpA6e9sVpm9uR0QUT+HkeRCYbsCKOVOGTVgjSE0QmsHcyqB0fzET
         qK9ZfF9HVdArE4gXztbt+WKrAUN9m/Afynbp/zLuru+bNgi5RRCJ0Wikx8Zb+mbF1H
         h9pCKXDxtqeBg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 02267609A3;
        Tue, 29 Jun 2021 19:57:42 +0000 (UTC)
Subject: Re: [GIT pull] smp/urgent for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162497731455.6531.14556986039751007461.tglx@nanos>
References: <162497731214.6531.6083197571290189651.tglx@nanos> <162497731455.6531.14556986039751007461.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162497731455.6531.14556986039751007461.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2021-06-29
X-PR-Tracked-Commit-Id: b22afcdf04c96ca58327784e280e10288cfd3303
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62180152e0944e815ebbfd0ffd822d2b0e2cd8e7
Message-Id: <162499666200.30376.6850902332101680232.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 19:57:42 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 14:35:14 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2021-06-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62180152e0944e815ebbfd0ffd822d2b0e2cd8e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
