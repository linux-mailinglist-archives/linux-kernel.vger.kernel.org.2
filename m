Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9723B78F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbhF2UAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234978AbhF2UAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:00:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 29CC561DE8;
        Tue, 29 Jun 2021 19:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624996662;
        bh=tXK3dzcg1TJRT7ok7qoQpCZzkBNdVM5Td6mpE1wmLTw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dtIDKBKV/CI5fAYBtn69fDMi3SDZf/ayzay8jk/9KClRCuBeYtCSOeXNMXRtaWAZY
         DuDyjwmqfIdEc6J/nhgOZsZJdeQitAjhjrt38QhFWJjv2xdnWoQBCKLRCDyDOlBN4E
         MG8tJjjaETfDKtUWpiMItnO3i7S9NQxQaiJhHl3yUul7aePbv0qbppCcGlEIMIdIMI
         a0hsON/oYhHhqsQk3MheGY4RHNtcHoLDRJ7VJM53qYKv1Gex5nzT6SYQsADSTwu6p5
         gBJvGKTNoh4znCa+3J5sNl44FIBH06+tNShMbzatHO1jOfoc5PCwD2C+CFEsq6VdLp
         kAFCOe0zPCaZg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2199260A56;
        Tue, 29 Jun 2021 19:57:42 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162497731214.6531.6083197571290189651.tglx@nanos>
References: <162497731214.6531.6083197571290189651.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162497731214.6531.6083197571290189651.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-06-29
X-PR-Tracked-Commit-Id: 3d2ce675aba7e2425710e23268579a5d76c7e725
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21edf50948728f55b685ad95f196ba46196eb767
Message-Id: <162499666213.30376.10876790355133219108.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 19:57:42 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 14:35:12 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-06-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21edf50948728f55b685ad95f196ba46196eb767

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
