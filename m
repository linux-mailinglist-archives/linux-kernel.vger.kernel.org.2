Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF7321F04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhBVSSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232042AbhBVSNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:13:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9429064F16;
        Mon, 22 Feb 2021 18:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017538;
        bh=+Fnvy0ixYMtEC/PMcEtVoOg6GXUAGSLMdAVAiVGIC6Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NoZVKXKMx15HhUHlT4DKg6RgK7+ZbAhueQjPXjXG289HLVp6iYqdM9G4Xt4D0uIFY
         7QRTwfVOanyqgJbvy2341Yp6qxRFhDbhY1dFoIyCBblaVlSfhyIEq5bST07VIccclU
         XmSaInafU4lna4GktzcZowiLNwCzLR3nFG1aN5aXmDBjYyCdFfpzcDGadysdPRCxDt
         3kkcQNkEYO935yH+MUdYYj0VeH8wPQrYKu9BDslqbMEaSHWvoIbOQjocWzTm+ttvwm
         m7MmEXEV/zvC2cCFmzWARcpxe/+TBzy1vPLdOoU7Ssl8NFxldTBD0ZAGOpGmUG75ID
         KDT38o674e6jA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 903C160982;
        Mon, 22 Feb 2021 18:12:18 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210221235005.5cy7swj6g4kfpwgt@earth.universe>
References: <20210221235005.5cy7swj6g4kfpwgt@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210221235005.5cy7swj6g4kfpwgt@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.12
X-PR-Tracked-Commit-Id: aa57e77b3d28f0df07149d88c47bc0f3aa77330b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 579f50cee1a1c12c0113dac02eb510cdb8c7f5f0
Message-Id: <161401753858.943.11241664522400630739.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:12:18 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 00:50:05 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/579f50cee1a1c12c0113dac02eb510cdb8c7f5f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
