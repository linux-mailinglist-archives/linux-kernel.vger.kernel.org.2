Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593D7321F00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhBVSRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:17:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232031AbhBVSNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:13:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 412B964F0A;
        Mon, 22 Feb 2021 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017537;
        bh=Oh8+t5WleLKgPzK7Y7K8MU72rkG498ToO3tzcRfM8WI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ixqdps8ZJFDk0kWeRF+EraswDDup0U5/jKH5pxSHBwJLAAJD964iOdSEkDoyrLw3c
         6baFcmC1Nzbx6b5EQZvPj8o2YZeIBBn8PvKfgvJAZjfqv1JgQrgzIsODXM+If66foZ
         tC58o0E3NU1VBx/SSlpcAwQxUce5ZaN7NbpekFf+gruzvs1ZPikuzNynawvUlN0sCZ
         j7dJiWbnRvxfEsS73LDiV3vrO6ZyGSolhWfr69IP4PjOyyCRSf7yI8LkLzsCkbtD2R
         of3TRu4xPsu6DDKv18jqC42HF3qIq79fYvmjLSmoKD+3UaIX9TNTfIHB0dcQt3nu4F
         nxzmMIweB8qSg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3CF2560963;
        Mon, 22 Feb 2021 18:12:17 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215204447.B59CF64DEC@mail.kernel.org>
References: <20210215204447.B59CF64DEC@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215204447.B59CF64DEC@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.12
X-PR-Tracked-Commit-Id: aa3233086b48e5269cd0b5c16fb9711ce9341244
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05a6fb94a6e1774eb529e1365ddc2783de614e88
Message-Id: <161401753724.943.6613144216590416207.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:12:17 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 20:43:39 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05a6fb94a6e1774eb529e1365ddc2783de614e88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
