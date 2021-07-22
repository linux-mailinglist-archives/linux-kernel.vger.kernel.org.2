Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6555B3D2B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhGVRUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 13:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhGVRT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 13:19:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DED1A61380;
        Thu, 22 Jul 2021 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626976832;
        bh=zgHAj6WIzZko2I3MKohzmf4D9WqEgA5OVY51XDKti2o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qd99b1q9EhyIxYpTSq+kdg9/AHXWkquC7+7VhIu3xUinsGRa8DWv+b2+xx8L7GzbF
         21F2Q236ZpVMhQ6w3MYkYD+7a3cpE7pT6JcKdQ3HznKGeg2e0aDBaQcudov1hB3Rpo
         bvX/ENYUAcysNn1jxx1/z6PU7hIzjcZa7k7VbNCXJDHv3pMLY9nebOlVrugEPDMw2U
         nX49mdk/HfJqr/MwVsGiUKcd4J0VIrp0Jtg6A9HajSVnBmeyIvHyRP1RZW1J8SOwus
         S/B5jSjVPmikSUU0Od4zEi32TWLwHy5AoF/y6rfgF0+6suJKcwWXDIGs4nIENYkoHL
         p5uNH5rUME22w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D89F660173;
        Thu, 22 Jul 2021 18:00:32 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210722101615.31766-1-ulf.hansson@linaro.org>
References: <20210722101615.31766-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210722101615.31766-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-rc1
X-PR-Tracked-Commit-Id: 10252bae863d09b9648bed2e035572d207200ca1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e09e197a85a98d59d9089ffb2fae1d0b1ba6cd2
Message-Id: <162697683288.6012.11944272828481398440.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Jul 2021 18:00:32 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Jul 2021 12:16:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e09e197a85a98d59d9089ffb2fae1d0b1ba6cd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
