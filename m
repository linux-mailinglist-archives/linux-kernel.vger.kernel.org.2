Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3C0428294
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhJJRTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 13:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232196AbhJJRTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 13:19:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6A50E60F39;
        Sun, 10 Oct 2021 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633886245;
        bh=SyZp6ya7ThnLvYdt9qoz/hyE2TPZve+Pule7YnyO9Gk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gOC/7pvcwB/0dUsaUSIFw4DptXAVrhMjIkactJay5glCLb5cDDPJ13Dbz2O6OuCwF
         gYgwr3DJF7mvvhO/sarBZrRyf9sj0b5mXylwCqdw0C/P7O3MB+SEfbtLB5Aiy7K1H2
         0ArsMKcVv2X6ooj66tb4ALuzu53vH0PXEVhOAGjT1xzP1D42uZdwiAlG6vmw8TEMv0
         67u4DUG43t4uOk9DFv9tuxxrJlcK/HHWvE3eKYAF4AsSRF6ufXBtOnxXLNdRCluzbA
         9gjv6+W3pq5k6N887CcYfoDLEVFszeKJSR3MCZXuKPjhcrLrlsSC3c9hFziqaDolYy
         7SwlpGT6RGE3g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5553560A39;
        Sun, 10 Oct 2021 17:17:25 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWKqpkLDl4Yd87z1@zn.tnic>
References: <YWKqpkLDl4Yd87z1@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWKqpkLDl4Yd87z1@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.15_rc5
X-PR-Tracked-Commit-Id: d298b03506d3e161f7492c440babb0bfae35e650
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c22ccc4a3ef198752855f44e9279732260c889d5
Message-Id: <163388624528.22826.1082132223915723058.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Oct 2021 17:17:25 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Oct 2021 10:56:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.15_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c22ccc4a3ef198752855f44e9279732260c889d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
