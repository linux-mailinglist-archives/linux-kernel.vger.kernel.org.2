Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEE4377863
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 22:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhEIUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 16:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhEIUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 16:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D275E61108;
        Sun,  9 May 2021 20:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620591538;
        bh=OvSdkcCddmqHtWx4y087njzXeqleaEiH8ODuu07YmLA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZVEwRith85SXOq8kulPhYl5GfGeP3oJY984CoYeZYlKTXGQ1cbVJasnromJIeS+1K
         tWdUgz40R7acciARZRVmqILNWyW/mr7n6LWwGzdG0tqKvBi+ojsM98RDMqQHhHqWlf
         4cXD+wyjtywqVI+F6WjodyUaSiFVbjzxqaX56oXAoox+oWTwEqs0rh3JrxuodOep61
         bqR7YiIbDL1MCMvd3nTI5Jw0qQTbwmvIm1wt/NYqqFiTX66LMr92nLj1sGLc9T7Rix
         051tybMipTrUgbJFtav4W3yN5IBxjHfiqn8mq9Wvi63m9sCAmn5gZhzqp7OsT/ugg3
         yYIiiRrkZbD+g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BCB4A60A21;
        Sun,  9 May 2021 20:18:58 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJenV2X0Xo0i5TKE@zn.tnic>
References: <YJenV2X0Xo0i5TKE@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJenV2X0Xo0i5TKE@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.13_rc1
X-PR-Tracked-Commit-Id: e10de314287c2c14b0e6f0e3e961975ce2f4a83d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85bbba1c077848e76ab77682e9e56c41113f5770
Message-Id: <162059153871.28372.10056297035966039034.pr-tracker-bot@kernel.org>
Date:   Sun, 09 May 2021 20:18:58 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 May 2021 11:11:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.13_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85bbba1c077848e76ab77682e9e56c41113f5770

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
