Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF18C3D4F49
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 19:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhGYRJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 13:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhGYRJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 13:09:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 56A2660F43;
        Sun, 25 Jul 2021 17:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627235389;
        bh=3CVagw1Z0zk8cReXjaDhxYJq7ZF+z6QBudb6vgjgioI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zren2xyqR7zKeiMZaYHHt/KtcEdUHZuXTdUW33OrWjKu4FKYoKqYT34kZ37WLgv0A
         E+RcxDsyYm8uI/4GHCBjFsdA+L8gP0f45Js2s14IgUynlxLia6fMGYF8KDCR8t2lJA
         TNjh15bqjU7bY+MtzWHwUXN/hmqqLjW8BzY2ck0OIN/A534eUFhFnQwCCQoN0n4+oX
         h80IqepGqeybbFTVTy+dNN97QnqWMp8VJtGXpLqo+Pcnu5T0CSDyN/3NUOQUJF9cQr
         uN8Y81xLDawEcoMSpKNR7KGIaaSzpcPsDvj1/I5MUPUMSv/2zjNRVcI99HzZeViiDC
         ICIFr0Z05QtEg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4D0E460A2F;
        Sun, 25 Jul 2021 17:49:49 +0000 (UTC)
Subject: Re: [GIT pull] efi/urgent for v5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162720492192.8837.18180570727914662033.tglx@nanos>
References: <162720492071.8837.4047241618315201209.tglx@nanos> <162720492192.8837.18180570727914662033.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162720492192.8837.18180570727914662033.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2021-07-25
X-PR-Tracked-Commit-Id: ddab1e71d2df3513ed6029435b97dcd83fbaa372
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e049597e7ec11fdc276d787d320b01ef1f647c4a
Message-Id: <162723538931.30584.13731210409766531458.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Jul 2021 17:49:49 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Jul 2021 09:22:01 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2021-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e049597e7ec11fdc276d787d320b01ef1f647c4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
