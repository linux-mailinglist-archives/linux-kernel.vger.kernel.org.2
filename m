Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F03D4F4A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhGYRJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 13:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231302AbhGYRJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 13:09:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 25B0360F35;
        Sun, 25 Jul 2021 17:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627235389;
        bh=cVQC5IBewjL4Fy2beGRSiUwwt3SBinvpPVuQdJN0w48=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a3tqczPhrrLCInCo4G5Jbeneuwy/okbdMyYXYK8jTQIX7foZBWxX5+lsVPTif8lzl
         n5EQYRCv6YwiQN/6BVYJHwGe+V7r7E4YVXLYW8HgUyMCwjRx/yRTow0LHuBDiV/MMa
         p99eE7ENdHMZmlHdl9sktRcPplSU6T94KmcdVA9aMoFw9CE+5ZA0Ifn7NgKlv4F0gb
         TCcYOSPEldP0eZLeHO2nhbTFF3DHPGxXz+NtgNYs2oafiaZLZ4wkLfc+Gk39I7iirj
         Zai3WW2t2qRQL+C0nH6znAf1VoaL8thcwAWubIDd1skmHYSXkjHXv/04v6wtw2VbzJ
         NsiqlC5tWFMjg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1CB9860972;
        Sun, 25 Jul 2021 17:49:49 +0000 (UTC)
Subject: Re: [GIT pull] core/urgent for v5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162720492071.8837.4047241618315201209.tglx@nanos>
References: <162720492071.8837.4047241618315201209.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162720492071.8837.4047241618315201209.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2021-07-25
X-PR-Tracked-Commit-Id: e9ba16e68cce2f85e9f5d2eba5c0453f1a741fd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9041a4d2ee2f551981689cb12066a872879f5d07
Message-Id: <162723538911.30584.6361193103153153782.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Jul 2021 17:49:49 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Jul 2021 09:22:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2021-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9041a4d2ee2f551981689cb12066a872879f5d07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
