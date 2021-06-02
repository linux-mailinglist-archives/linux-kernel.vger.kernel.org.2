Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7923993A2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFBTiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhFBTiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:38:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A9650613F5;
        Wed,  2 Jun 2021 19:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622662586;
        bh=i/gBplijkKmXL1Xfk3sSdjVJgUyfzpjzejfTwk1vr8Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fJQ80oCkhow9bcGlTVzRncXCU85iqUwYfP4szpsn8fN513eqqUu3bx+lJ2Tm6LeVL
         AreebQ3bVcFSNNlEJlhKEudNJffwU2xz3teZPVAlCoVjpmqbAjtpzbhIJ/wMBD8drr
         iYIoGGORzRuiuhK6spqicpw3c0V+ItSPnZpFx3ScVcXrTAlRgruUTtjCPhxTPwXA72
         /k8j2Toyi53tnXJuXEiecXPGTasbzJeXhU/yWdRWrOJHLHoZTyTa89so153tPUa0My
         5xZd+kynjPEfv291ZaSBIphDoAPT77sD4Z6wp5/gqijukHWOaXNYq7xWEBWcvOhWAg
         p1iey+bo4nntw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 95061609D9;
        Wed,  2 Jun 2021 19:36:26 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v5.13-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210602112858.2870288-1-linux@roeck-us.net>
References: <20210602112858.2870288-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210602112858.2870288-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.13-rc4
X-PR-Tracked-Commit-Id: f0fb26c456a30d6009faa2c9d44aa22f5bf88c90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bfc6ffb616f14dc268aa121b71637ef06654e92
Message-Id: <162266258654.13029.13947068784073650137.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Jun 2021 19:36:26 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  2 Jun 2021 04:28:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bfc6ffb616f14dc268aa121b71637ef06654e92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
