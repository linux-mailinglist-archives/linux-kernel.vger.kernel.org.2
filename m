Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7041B850
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbhI1Ua6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234794AbhI1Ua5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:30:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 83CEC6124B;
        Tue, 28 Sep 2021 20:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632860957;
        bh=5NAc0nKafKFT6BHAFbFPEQIjF4JqhnsB+1Onk/jLdrM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p5TqY05dt9lKWamKFKpv0h8UCGCG2MKrrNZ8dqajsdUMR91KeLX/LnaBg5DxAl35C
         2FFN2mbau+6hK78hvHzksaYgni7PobQ3YuHpJ4XZd9gyuhpeUl2KD4Q2+Rd/fJNl0X
         oxpVNHM11E0mSPJf3GlR9q8XHWxGn5sdHBsfk+3NRFEhIER0BkErQzlaOTwV5YwVhJ
         5koXstOnmqEuKhynXDIFczxCwCC7atyWBewWYTnUG/8JlZxxq7ovFuHxBADL6n8ZBi
         XVeD0fppP1FULY50/SE7eCzAxAN6XuV5f2wX+Q3jA5isTSlGGt180evpqPImsUhrnP
         SQXg1fS6iWpfQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 740F8609D9;
        Tue, 28 Sep 2021 20:29:17 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v5.15 (take three)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210928140018.2441795-1-geert@linux-m68k.org>
References: <20210928140018.2441795-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210928140018.2441795-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.15-tag3
X-PR-Tracked-Commit-Id: 9fde0348640252c79d462c4d29a09a14e8741f5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7bd807e8c9e37b0eef24e13df1f0619c39dc559
Message-Id: <163286095741.21949.15273207397325726053.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Sep 2021 20:29:17 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Sep 2021 16:00:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.15-tag3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7bd807e8c9e37b0eef24e13df1f0619c39dc559

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
