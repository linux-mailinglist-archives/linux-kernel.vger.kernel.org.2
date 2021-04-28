Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6F36D019
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbhD1A5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhD1A5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:57:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 633DC600CC;
        Wed, 28 Apr 2021 00:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619571411;
        bh=X+e7zy05LxSbcHcAKwcMWdDqvqFZpukpl01J/ymnbQs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f+rRFwdiraNJhmpd9WPI0K3Vpjw46ONb5uW3cKOisdjTfuxAQC0yacqc5A3Fne8Vj
         pQR3V10l6RHFEVqPsFhbgg9TUhWqSLRr3BozAqBX0x2OALBvXtmg/sTwFms8/fdUlm
         cKLqdccmBWtgw2QFdLQbBwPaou5nhewlodhTQP92K+BBDhDptC+hVklbS/r7k2inkU
         bNYGcP34BIo4nUSDWZhO+V56n/IxCpoB/oWPihqtGTtIfpW7SWJZfhuJnwtbDNIjJB
         YQ7SGgfAdeXbc2kLZo8dQqEQn92jPzJLg1Uj43pDyqKoqRK/9woVoPfwSXhm9Y5IVs
         kNsVdgiZhQmPQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5C960609B0;
        Wed, 28 Apr 2021 00:56:51 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIfKEkC2lghJJHda@zn.tnic>
References: <YIfKEkC2lghJJHda@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIfKEkC2lghJJHda@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.13
X-PR-Tracked-Commit-Id: 2c88d45edbb89029c1190bb3b136d2602f057c98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6536676c7fe3f572ba55842e59c3c71c01e7fb3
Message-Id: <161957141137.22806.5507357274217202072.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 00:56:51 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 10:23:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6536676c7fe3f572ba55842e59c3c71c01e7fb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
