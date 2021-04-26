Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C56036BC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 01:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhDZXhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 19:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235123AbhDZXhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:37:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E178861103;
        Mon, 26 Apr 2021 23:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619480200;
        bh=P0FZr3T9ecQixeHdMg/AIx3glOEP3lY/prcOBMF9LC4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KKLiyhwuL6bmZNGp296IsMW46TZ22CR+Umz17gJkPu1ZXKMctaHzr4+uk+9MoICes
         SlI9O7bM+fCYCrT18wowfwxGY9dK4Z8nYZCtU/570V43wx0Vv/Vek038DKFILf1BKV
         2Og7R//hTzopadM+ovFsyUG/r9iJc1wJGHzxWv7uCz0PWTwr6LeORm9deMK9jj4wFx
         tREOdSZsduqAtDMgI5WHAIJq9Ocox+f50SAfebqi69y75F7ijOMueJpEpdnUoHlljd
         VrsESbrTjkmgY+EjEmsBEhwdILOK35vduFV6NzkYUZEbrpPptALMxyAzj3TGYAP6qm
         99tIYWf0Fv87Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DBFDA609B0;
        Mon, 26 Apr 2021 23:36:40 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210426144053.F0C4F61289@mail.kernel.org>
References: <20210426144053.F0C4F61289@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210426144053.F0C4F61289@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.13
X-PR-Tracked-Commit-Id: 4dd1c95306980c997b9a32e72877e060c25dc6f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca62e9090d229926f43f20291bb44d67897baab7
Message-Id: <161948020089.27003.13749981014263108580.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 23:36:40 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 15:40:10 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca62e9090d229926f43f20291bb44d67897baab7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
