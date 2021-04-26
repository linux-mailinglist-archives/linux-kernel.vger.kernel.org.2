Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA84836BBD8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhDZWwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232116AbhDZWwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:52:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 32EE36100B;
        Mon, 26 Apr 2021 22:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619477487;
        bh=Ce9NV7ueSpTF49P0v2TlIxFknPleAIcsv+vrdZEw9tY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dqppDYj5UdsMOcIvvGPJKEUmidOgde4eC9a4pWPYG9vSODO7rIOWto0uhNyXzXxHW
         HD7cquv24uTHOef+SGZ6I4Q7x3bR6d8FqXCbFHyAq8hgf6SS+eiPRL7I2FGTyCnnvp
         JjGSY6w10V5GeKB7+/UcJayeAvNm1Ph5Xd/bLvd2NENqP+1/I12yuegWykMMRwBw7x
         KPCPMjxG6KUXkU07559kR7gsB6zIys76q+k0K5s3Foa3UQHcQkVA6gB5JEMg+M1xWw
         dSy40HfMrX5HzzAGfWu08SV8W6aCuMIxNVgPlsu3JdLENiUCin/MS2m5s68/Fqz4qM
         xDV5XMiDbL0GQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 28FF9609AE;
        Mon, 26 Apr 2021 22:51:27 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210426174229.103899-1-linux@roeck-us.net>
References: <20210426174229.103899-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210426174229.103899-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.13
X-PR-Tracked-Commit-Id: 9049572fb145746725b198a19e27fa2671b80448
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47080f2286110c371b9cf75ac7b34a6f2f1cf4ba
Message-Id: <161947748710.6408.16062485848450212079.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 22:51:27 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 10:42:29 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47080f2286110c371b9cf75ac7b34a6f2f1cf4ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
