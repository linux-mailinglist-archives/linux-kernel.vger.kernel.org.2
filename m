Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729613FAE30
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 21:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhH2TsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 15:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhH2Tr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 15:47:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9A8F560F45;
        Sun, 29 Aug 2021 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630266425;
        bh=Dcw645ja51Nt1e+yBxibGoEdEv3vUwgC3+RY41DJcvM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XBHOD0jbse0YC6hdBVsdai/ia/MFMTJ48aLjFQt5yh4qvLUkyHi45CHPLfZTxRL5A
         I/LgQcanGQphP5SqjO8IhRhsu9XRuYAe8GKExGRhmuyDGw/2r49Z0/f0tK1CbV2eV0
         /Z8De0wxoYEvciEngd2+gC4WsE7CzgLEvpGmwy6iKrcAqKHwUlHhu8syjg3dDq9lro
         ouvGpyDGd+gaR/e4poP6MO+jTLu1k0CziQcIbpTGqGa0lqCZUUn0N/svstWad72LHP
         vg7F0ugnQegTSXf372EzyXysZlLcVpb5l3j4B502K3Z/PmszEmzdNDaM8Q1WkRFkkh
         LQ5wY1JpbYLGA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8BAC060A5B;
        Sun, 29 Aug 2021 19:47:05 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSttskpCbUeAiwTj@zn.tnic>
References: <YSttskpCbUeAiwTj@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSttskpCbUeAiwTj@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.14
X-PR-Tracked-Commit-Id: e681dcbaa4b284454fecd09617f8b24231448446
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 537b57bd5a202af145c266d4773971c2c9f90cd9
Message-Id: <163026642556.27261.1649154030955992268.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Aug 2021 19:47:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Aug 2021 13:21:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/537b57bd5a202af145c266d4773971c2c9f90cd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
