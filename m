Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFD376BF3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhEGV7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGV7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:59:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8BAB561001;
        Fri,  7 May 2021 21:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620424724;
        bh=8TCG1lxhJTj006i5DM/BumPWVhwxK+KRMjOBDN4XPq0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OpsZsX2dso8XBH9SXGe/i9PmINMFATNDEop9sSUp4RMkUtdgSPexX7KzjVaP07sdL
         NP31/o/wVBeCL3GaKJm8xTBbYiQG3CibvhSzVU0+GfPCvhNU2OJ7Dz8ZDg++zfYrGc
         ObpfwZp/F7mjYEOB4D37weKxOUUmo2pEcroHtGyGF82bufCdrBQEdVAoQDB79MXTlI
         7nMOMFa/HRZCihqJCpAylG5M6hPQ4hfQWQ+TCXISFQgx3k86GI2zihUk8j/xsRvGK6
         bl5qV2CcBWqZA+y0jz4NjnumMJgKZwK3VJIaG+/qAuIam43Qn+rkrDAsvgXebr3SIB
         kYZiRoqWAVlxQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 77B2460A0B;
        Fri,  7 May 2021 21:58:44 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJWzrs7pu38YD6G7@google.com>
References: <YJWzrs7pu38YD6G7@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJWzrs7pu38YD6G7@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.13
X-PR-Tracked-Commit-Id: d61b3f9b91be32f714b218377ab5081932e3ebc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd860052c99b1e088352bdd4fb7aef46f8d2ef47
Message-Id: <162042472442.22334.9385508532354317565.pr-tracker-bot@kernel.org>
Date:   Fri, 07 May 2021 21:58:44 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, enric.balletbo@collabora.com,
        bleung@chromium.org, bleung@google.com, bleung@kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 May 2021 14:39:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd860052c99b1e088352bdd4fb7aef46f8d2ef47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
