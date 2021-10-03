Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB2E41FF00
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 02:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhJCAyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 20:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234329AbhJCAyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 20:54:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E67C761AF7;
        Sun,  3 Oct 2021 00:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633222366;
        bh=wy8+yXrFKFZA6EzKmUFybyAfO5+P3eIVjoyLXj50VmA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VkEQro566HoYpDRtcBLo7uf0pzwOC5a8hXsuMo6I5ix19tdOtuPc+iY5KJbgiUY3P
         sJ3P86wdGl+0/9kyIXtKcb+9jzTl12vVGVL0/GqVn/S/RZ7eLrhoGOmPcg5T8/v4L0
         su39FBr50CBx/U/EfdEHjVjE7/ICIMjzuBP9JMp0GzajCDmeW4AszOBUwuW1wXMPZV
         wmbuG8Jb1652sWy8Mn20dnGGswfgD1/wB2fkHhtjGgZ43Cd/lhokbmAFXoHujqNdMq
         aCMlMB1qk2OjcUCjdxoWXMGZdVaPfHsE0RP3hq+7zisW5m9393kDPM2daijy6juesJ
         fDPYVpK3E0eAg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DB67D60982;
        Sun,  3 Oct 2021 00:52:46 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211002161353.37484-1-linux@roeck-us.net>
References: <20211002161353.37484-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211002161353.37484-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.15-rc4
X-PR-Tracked-Commit-Id: dd4d747ef05addab887dc8ff0d6ab9860bbcd783
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b66f4393ad421e425ba643fde0493fa64346a43
Message-Id: <163322236689.17155.15161063289065771969.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Oct 2021 00:52:46 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  2 Oct 2021 09:13:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b66f4393ad421e425ba643fde0493fa64346a43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
