Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711493B6831
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhF1STt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 14:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233222AbhF1STp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DDAB461C77;
        Mon, 28 Jun 2021 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624904239;
        bh=KoRgYoHbEdD9aWKgztd11pLmaxNpfWkaLDPr1Q0Yfmg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uO/s00dm6OmQsF3aIi5yC6pZmIG+Phg4Nw9DKVr14akwoNFyBO9ReFfsRRtxbnn6i
         pvekNMbr9xx0ZGU1CnuARyeW1TUp/jJsVJcRELXXH9EuVbIT9kZSqSaI4sZSuKut4W
         4Kx4LwtUfVZh8zlbVcVGx2491mjY49aq/NtdBKojACFHk+XKDjfqynxKAUyJfSR3Z0
         psoTlGaWMJ2h3jb5loW3DhQFBWRT592oDQ4FWF6R24MM2pce+ev9vLx/d8A9oEv45i
         wDpu6dIQUUVuw/pjm3dM8EsPXs52fiQQlnhjE8unCglS9ExvbDALUVmCkvTqQ/HJbY
         54TEebGMlN1gw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D762B60A3A;
        Mon, 28 Jun 2021 18:17:19 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210628133322.374614-1-linux@roeck-us.net>
References: <20210628133322.374614-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210628133322.374614-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.14
X-PR-Tracked-Commit-Id: a5f6c0f85a09f46c88c0ac53f3d2f70eef105a65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a5c61843e31cefd099f085764c2df2dac9fcd65
Message-Id: <162490423987.3852.16077476815832256824.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 18:17:19 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 06:33:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a5c61843e31cefd099f085764c2df2dac9fcd65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
