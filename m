Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E19407FA5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhILTRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 15:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235302AbhILTRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 15:17:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6813F60FDA;
        Sun, 12 Sep 2021 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631474186;
        bh=tpY0zOgaP638Jx4s6R3mcCRLAWTzFpd9++ECMdrUT7U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Am4GIAGPB7fPHw09cUnueOY6wtxvihP5Qtbe4GzZ34Ua5zzkoGgXRrDc3sLQOsFLL
         HA3PIcCU/1smCY7N2674HSQCG8Tyt7bSCYwhnahon/9uyXwq8dpfYd4LnQdRuAB/Az
         MOWpaqhNnW8xMiear9kd8Wih6hfRW9WjYwuaQRcXbi5Q2s0qcOFivvs9wswiVK3/7V
         NkGy2s4MbCVFISrRY65GCd47e0Q0Ooyg3MQpDOrmrmGY6R3vbTrUbUI3bjWLq4XxgZ
         mbuhpqCrq04YMeZ5BVZHBSvPGpZv+P+oT+iyRoMKStKPmZJ62i2qJ+rpHGv9O8/4po
         kKx2HxpgTmW+g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5550A609ED;
        Sun, 12 Sep 2021 19:16:26 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210909211052.GM545073@minyard.net>
References: <20210909211052.GM545073@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210909211052.GM545073@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.15-1
X-PR-Tracked-Commit-Id: bf064c7bec3bfe7e28889774dc9e0ca4f7236775
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1791596be2723f01de2f69d16a422fdba182c706
Message-Id: <163147418629.28875.16467528126401789688.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 19:16:26 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Sep 2021 16:10:52 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1791596be2723f01de2f69d16a422fdba182c706

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
