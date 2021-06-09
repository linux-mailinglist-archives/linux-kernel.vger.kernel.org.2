Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69663A1F98
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFIWB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFIWBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:01:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1E71D613F4;
        Wed,  9 Jun 2021 21:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623275967;
        bh=hofyZ0oX8JIt9DCMufmTxkeMy4rZGpbUuHVtlI5L6HM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oispJTVjZVv6ASJYvMSfXEWjh1Gog2lqbzyESluQhBM/MYeHXoXiL+Xkdg6Q6jFFS
         qqo6Cgm+moQZtsbny0uTknsuluRZEBC8kGkbFnioRGszTAi1czRv4CxW3HoXTZSjZ0
         oW230EMKYoHGmqz5RlGBgiJzVmovYxG5ZXFEf+Rk4VLCGxIsOkzHdIYbUWMNSoy3Fi
         QspHU1WbvRWcsb9VvAZLFEQxdiYLLwsrgg/Y9lLXCMhWcLDBAQP0j/XR1EYwC4rYcR
         cuZMD7xgIVR3sdzc18Eb/Rr/jxvALVrvPIGvqVcQWvIepU+ig7V1hZH0HEyrDQ2m4Z
         2oNIi8qS7cURw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 182D4609D2;
        Wed,  9 Jun 2021 21:59:27 +0000 (UTC)
Subject: Re: [GIT PULL] Compiler Attributes for v5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210609134552.GA4847@kernel.org>
References: <20210609134552.GA4847@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210609134552.GA4847@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.13-rc6
X-PR-Tracked-Commit-Id: ca0760e7d79e2bb9c342e6b3f925b1ef01c6303e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4c30b8691f26c6115db6e11ec837c1fb6073953
Message-Id: <162327596709.6358.5969492272426221977.pr-tracker-bot@kernel.org>
Date:   Wed, 09 Jun 2021 21:59:27 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 9 Jun 2021 15:45:52 +0200:

> https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4c30b8691f26c6115db6e11ec837c1fb6073953

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
