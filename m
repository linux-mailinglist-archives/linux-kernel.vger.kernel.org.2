Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B517D36E088
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhD1Ut6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhD1Utz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:49:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 785456144E;
        Wed, 28 Apr 2021 20:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619642950;
        bh=VrgpTFZgXbO64GmrlKW4O6PlSmj5TyFkKmc5LefcvVY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rdilcFHkZPIpNAkfV4Augy63TVxHzA3Xu/jTfSlRHScnyjvoTTqGU4iP8gsNq4xih
         Bw6IBXiH1/Fw6CjS1krrjCCUJqGpTN4eUh35iiJE7i+6JWw+W8xWNVGIGxRclpqp1T
         7c7ogOcmyeF5ws+wzXyXFhY2GAsXxSFj2IC4nHuOv01TFkE83wxq0vLOFLDu+XLe9N
         OC4qpDSN8jf/26ecu1KO0Znki0CgtZoXuQB7D9oG5PRzVk0ih8Wl/4N/54gNcwm9wR
         rhz2udvD0anr8SGu3Ye600tyWpNbwpNfXUKcPquG4BaZNAYghCyJcNRXnwg18ajecG
         IiQA65zYlWwaA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 72E3A60A36;
        Wed, 28 Apr 2021 20:49:10 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210428073007.GA144738@gmail.com>
References: <20210428073007.GA144738@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210428073007.GA144738@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-04-28
X-PR-Tracked-Commit-Id: f4abe9967c6fdb511ee567e129a014b60945ab93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ff0edb550e256597e505eff308f90d9a0b6677c
Message-Id: <161964295046.5673.4273430896765135276.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 20:49:10 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 09:30:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-04-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ff0edb550e256597e505eff308f90d9a0b6677c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
