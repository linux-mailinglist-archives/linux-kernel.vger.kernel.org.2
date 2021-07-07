Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F363BEFC5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhGGSry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbhGGSru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:47:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7CF1B61CC8;
        Wed,  7 Jul 2021 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625683509;
        bh=UQBlyLiOBilU3i1cSEQm5wE3PndpsmQcjHvIx4R08E4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PKTZxV8sJ4U+3pT+jG75DFzImwovMLy5KpnZgI26y0T6/doiHMhn/jXJfoPZc1O/B
         6Gyg+lZd6GR2Xxc164gkNqJ3baKvmcv4PQi1dgshKZuEEA2mDUWh/MlCuSmtzrdLlo
         MwQKMH577SSXXHR8Phs9MbsfC6uyqupLMcE2I0h4Hi/GGLLyJxhJ4wpaLxO+ggPKIt
         /EeY8UDWk0YpsHZNVylgNPrfcfZNzo/miMiTmyrWHoExQ1Oi3cHIrvPi6DPASTdNsw
         DZ0REG1+vj+sxjFjjpsNla54rVbZJ9ADVvhELm/6jZGgDvPg561HYTooI83YdJMYYo
         P+XVdY597EVvA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6D0D7604EB;
        Wed,  7 Jul 2021 18:45:09 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210706210228.1229484-1-bjorn.andersson@linaro.org>
References: <20210706210228.1229484-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210706210228.1229484-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.14
X-PR-Tracked-Commit-Id: aef6a521e5bf61b3be4567f6c88776956a6d8b32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0fe3f47ef09bf5a74f7d20e129b2d15b4a824d0
Message-Id: <162568350938.3837.983733650642256119.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Jul 2021 18:45:09 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Suman Anna <s-anna@ti.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  6 Jul 2021 16:02:28 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0fe3f47ef09bf5a74f7d20e129b2d15b4a824d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
