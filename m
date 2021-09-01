Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2703D3FE5CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245001AbhIAWpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhIAWpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:45:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AB41F61074;
        Wed,  1 Sep 2021 22:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630536248;
        bh=Pt3kifkIyKafplTFqSITIA189DK5C0hakxv9MMdYWCs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CVeM6PPj2mUJB7MWZCW6OSBy/rD8cilLeu18+1eJfZW1grgxu9HDFIdfYYyxbeUnU
         qWcPAKQs+yh/C3W4kVYoVdHzxXCzYn1LYF7xcsvhuA39lu5nzwIt2sOoQWiBDg/E5u
         +EZwsrrZtmyHtOY5Ou+jd/uPPQUfeaYiPHdaadXEXNxo2WfzLwzEkE/RkkRshtX0dZ
         3oWL7md+BCiMimxY0nlObE4cymTSpDShp31tjZqR8Arbbl3BfIT40kZLEVRSJq6wlv
         E2+uo37RfkAGtDAOBoGcBlMXxle+9bIa9RVR7EsHO/MxBju7Xc8rlRyDMdaT6+KbKY
         UYOuBuyclwFCw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 979F8600AB;
        Wed,  1 Sep 2021 22:44:08 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS5u8M97frcjTbJW@arm.com>
References: <YS5u8M97frcjTbJW@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <YS5u8M97frcjTbJW@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: 65266a7c6abfa1ad915a362c41bf38576607f1f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57c78a234e809e3a0516491e37ae5ccc6eeb21e8
Message-Id: <163053624856.31944.16198791188677224369.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Sep 2021 22:44:08 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 19:03:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57c78a234e809e3a0516491e37ae5ccc6eeb21e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
