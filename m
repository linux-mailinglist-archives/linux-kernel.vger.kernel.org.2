Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178E036D033
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 03:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbhD1BSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 21:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhD1BS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 21:18:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6D26F613BE;
        Wed, 28 Apr 2021 01:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619572665;
        bh=Ff4Go7BV4MqMB22lQDWw4nowDZbraeXkoInHBK43C/8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=szC99Yh4q40selqYXOu4kKWrUmU/2t0oLqMi9rIfMx3d7RfdAN85fTT25CJAHFaUR
         5Of+dzoaRLQhixjtYCwOnpDSiqkt1aLMSXLxJxA7N6eULX49nc870/qx7/oqa7Tsu6
         ApEH6rnZYGTnYC+jai/fVVHix2nB9cE4wO8pJlcn4u+AFHIRrF8mBYJpbqjCZ3Qo1+
         guGyCdXYzBIpKKxGHBbqitQjzzIz+I9dDUv7Wgq2os08igaNy3xUz7v+4DjNa/PgDo
         SV2hjpW4a0lXpWtJNX/LeyHydoLwou8L32A2L4nCD2/Fso6XrDTQMGy+70ptvqtF6N
         V/UQZoOV7z+8g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 62A8B609B0;
        Wed, 28 Apr 2021 01:17:45 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210427133528.so6puv5wxj25dqwi@maple.lan>
References: <20210427133528.so6puv5wxj25dqwi@maple.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210427133528.so6puv5wxj25dqwi@maple.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.13-rc1
X-PR-Tracked-Commit-Id: 83fa2d13d628be901a21cdfb3553963cd8858052
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 916a75965e5236f9e353416a703a0f4c8de2f56c
Message-Id: <161957266534.1632.15702729220863743109.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 01:17:45 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 14:35:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/916a75965e5236f9e353416a703a0f4c8de2f56c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
