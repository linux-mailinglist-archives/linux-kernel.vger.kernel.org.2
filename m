Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A047235AF2F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 19:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhDJRDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 13:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234903AbhDJRDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 13:03:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 45550611AF;
        Sat, 10 Apr 2021 17:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618074212;
        bh=dtMAO0X4BeSs8Bei37ewMJMk5KOmk4jcKsKKZb1G9qg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VxaenhPs1s+wwOgYpRr0veCmg5E0fiuMu8FWAntGQzfXbGlyVwf/K3qrtXv8ZUjI7
         lXaTUgfqS3QB88Wufi/xcIgaKcvbQGR3B5ihrQDq4eIh0jpGL20XTNh2RWJTEcAH6p
         3HZExzxqUM390+gKDpZcKh3/ssGo8rlYANP4j6Q+Cw7MHWKVASw3795swEm7tVmTTO
         RRFx09DKuXglVsyL5PpbB2hf7mQe9eDGOC+fbvIlDOaLwO5kHZ7aHOIU058tp/xZ3V
         mStSMrXtzcxAQFWwPoUcxygjbAkWehh/edQLk0L57szpR38K2oplbwuVrdOPVgYd0X
         5WehuuVvbPA9Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3FE8060192;
        Sat, 10 Apr 2021 17:03:32 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-6 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871rbidwt6.fsf@mpe.ellerman.id.au>
References: <871rbidwt6.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871rbidwt6.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-6
X-PR-Tracked-Commit-Id: 791f9e36599d94af5a76d3f74d04e16326761aae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95c7b07551879c8ad4d6dca10c02de46ddbf55a8
Message-Id: <161807421225.30985.5791691520680055342.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Apr 2021 17:03:32 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Apr 2021 00:43:49 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95c7b07551879c8ad4d6dca10c02de46ddbf55a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
