Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9E3FA736
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 20:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhH1Srz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 14:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhH1Srv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 14:47:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5791360E78;
        Sat, 28 Aug 2021 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630176420;
        bh=Ci/ui1xs5qQBL+GfsQ5KgwrH4tzNHbkxvaY80a2wanM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IOBFAQF97IegwZOPmg71aJi9EHDbkM/JhTYu2URayeN3Axge/01N0B0OdRX4RFKUE
         Ei2mLMCcz28+2kYgYiBtqOqrq1Zf+y8vwo1Eep1KIKsg16xgbejKQRbqTrO9GZqOlr
         fhOc7zYl3coppVzQZV+348qlfHc1PZzs/fnLI9pGGgKefcAwrXi9imQdXpAL7Zpgga
         b4NgQ2vbyrWcstvbdwrYtfbnrh5cLyqbUqHR9KA1FiJvISlR0Kd8Zw3+ax2uAKKt/f
         iS2KY1T1zxZXhPN15x2HP+ksLb4LxYSSItxZhOqTBSB5XlIt0u8ZMxzvd2byxfyjdw
         HacaO39I21b8g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4C0C560984;
        Sat, 28 Aug 2021 18:47:00 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSp5/U1nxmG77m6I@kroah.com>
References: <YSp5/U1nxmG77m6I@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSp5/U1nxmG77m6I@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14
X-PR-Tracked-Commit-Id: 068fdad20454f815e61e6f6eb9f051a8b3120e88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 447e238f14b251acf2a954750e028ad0352b0016
Message-Id: <163017642030.5058.12618876809441405000.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Aug 2021 18:47:00 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Aug 2021 20:01:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/447e238f14b251acf2a954750e028ad0352b0016

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
