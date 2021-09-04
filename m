Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42192400CC0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 21:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhIDTB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 15:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237498AbhIDTBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 15:01:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3720360F4C;
        Sat,  4 Sep 2021 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630782053;
        bh=4CLYOVf27HgI3udSKJqInt4iAK1gJXz2phwQaoJk8XI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R0CfTW1e50Q7e89xLf1r4hCQ7mS9CyXLkCzK/qfkU0pma+Y+258hnjIExbPYhz4rg
         szqGY3Yqv+FTvRdUkXMWocePS3V/HKvgyYfaY9Nh4daiMWOeKbUAX9bs9obCn2t5IB
         cRRdovqlgp7hFLv4j6sb6sZG56Nd3Sim9TUrYypARPdTyEN9SIu0jDA7CS9IDdZkFH
         mdFtM6b+nwFzuwIR+ydUsy8Qg210ftFCsAjeMh660k4Tz2KOscZMQCn64BXDuEprgg
         ZYD6acdhBt2nmp4MpobYcf7SIEU2Y9HwQ7HEcaM0hy7Baz4bxL1Y16xJRhZJFZLDg8
         c+ZPrG4amJQfw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2FA1560A3E;
        Sat,  4 Sep 2021 19:00:53 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTLLgFTaal2+EC1c@google.com>
References: <YTLLgFTaal2+EC1c@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <YTLLgFTaal2+EC1c@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.15-rc1
X-PR-Tracked-Commit-Id: 9605f75cf36e0bcc0f4ada07b5be712d30107607
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6abaa83c7352b31450d7e8c173f674324c16b02b
Message-Id: <163078205318.10287.7643558945708241474.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Sep 2021 19:00:53 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Sep 2021 18:27:28 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6abaa83c7352b31450d7e8c173f674324c16b02b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
