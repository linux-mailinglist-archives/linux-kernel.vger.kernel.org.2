Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42A63FBCAC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhH3SsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhH3SsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:48:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4796260F3A;
        Mon, 30 Aug 2021 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630349234;
        bh=4TPGiPxmpgNhw5PeV62G5z6aFwBcV11A1N6nx3C8EAA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KyF0cgLg5/2DMrDeeWN2CcJIstVAlRtXkmEsZUAAqUsBdJEObP6x2BXnbbSJNBJzg
         95Dh72RhCC+edByqg5Az9LrRpl4+oU55cAtNmZKTQLEONcWcirvjZRgPyrD/aqr6IM
         oaxExBMNO3/iIea6EJXtnpbEiKSou3htKxjwQLlHYGNGkSmHm8yNAIZMqQ1DJKq7LA
         0XuaGf6tnWr353SIIvPcQQQF8T3dw/q4n5mnSasHm/RtvAJbzrdzrt4YJQ116U/9WE
         dWfAcJbE8kV50qg/bJ0bdsOxA92/hcQpmmbuJ9x0EzZAICrIazGwN4T6xviqI4AAXI
         Bg4WUkIgJMnjw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 381EC60A5A;
        Mon, 30 Aug 2021 18:47:14 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210830125048.919B3D1B482@fitzroy.sirena.org.uk>
References: <20210830125048.919B3D1B482@fitzroy.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210830125048.919B3D1B482@fitzroy.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.15
X-PR-Tracked-Commit-Id: ca5537c9be13c205492e704c5a3016f54b2fefec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4aed6ee53fcc012ea599f1be6b2c8d76cb7f7354
Message-Id: <163034923417.1022.8999832429010039379.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 18:47:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 13:50:34 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4aed6ee53fcc012ea599f1be6b2c8d76cb7f7354

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
