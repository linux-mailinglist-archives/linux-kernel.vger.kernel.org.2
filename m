Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C732480F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 01:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhBYAy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 19:54:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233817AbhBYAy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 19:54:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CCD556146B;
        Thu, 25 Feb 2021 00:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614214426;
        bh=Su5pLsyI3XO524BPQUMepJHjpSoJ8hRELjiYshMXJtk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eFY2uMXboxzo67XKUgwq178KnMgXhf6Vp+x/dqBEiX/1GycTWq96Wp3sPtE7tcheJ
         uXFkMGAQZO6F8DE3IMDJDHM+o2IpzwNlpvyAaFtgJvAFIxOockPl22pDNirRlWn3kJ
         sKpWXuiGRsZRIeLqJMxOtBemftLGRmE5QGmAW5maZbH9nyxdfNIi7lxvw04G2KWYfz
         DShqTHyrEo0rz63pvVUmUMP/mVsstmK+xstDjOctSAYGZArBvo9vfqTQd7PVvU+lZU
         uyCv5DUd38UkQ4N8Uv7JwKR5lnkQ98XM3VGpc8Y23bG0MEnQy4uzgYU7gLI+xisHTF
         wCjDE4BKRI2TQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B11F8609F2;
        Thu, 25 Feb 2021 00:53:46 +0000 (UTC)
Subject: Re: [GIT pull] x86/entry for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161420682325.18281.7125785645465599243.tglx@nanos>
References: <161420682325.18281.7125785645465599243.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161420682325.18281.7125785645465599243.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2021-02-24
X-PR-Tracked-Commit-Id: 724c8a23d589d8a002d2e39633c2f9a5a429616f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29c395c77a9a514c5857c45ceae2665e9bd99ac7
Message-Id: <161421442665.4065.12560785440375865664.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Feb 2021 00:53:46 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Feb 2021 22:47:03 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2021-02-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29c395c77a9a514c5857c45ceae2665e9bd99ac7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
