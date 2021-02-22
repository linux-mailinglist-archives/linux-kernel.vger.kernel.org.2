Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBBF32200D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhBVTXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:23:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233041AbhBVTQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:16:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id ECFAE64E77;
        Mon, 22 Feb 2021 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614021128;
        bh=ctlKpPN00r7fgdmhF/gvWDRGdaRYjZJEcdNSHa1Kdzw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qdEWCaE98ttBGS8JHlBs7E3hq6iCqup5uPSu6Nhp5AqZbustJ7dU7LplpfO0vYDCa
         EfeGHopBxf5eVXA//6Tc6hU0dUukJIq88xclPb1xAlHWPs+xxU4lEdgU9GdUbeTLjP
         wRnQvZ92hoXoodO4ucElGYW2cQylwDeb3LNwGI3PFNhSAr4whVLCoirkZTb/KqCwaZ
         p0QFx7oJ8ygjDRzDqIS+0o9Mw8i0mxc609v6MevAKHLc6QOTIP6Jx/fEsZKyYPfp7G
         HcB3kVfa6dDSaXn5ReY8NCbqw9riIE+bl+1qA1rASFsNS3QLQftIiy6q+J39AbOhLk
         1KeS2P+uL9Xmw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E77D760963;
        Mon, 22 Feb 2021 19:12:07 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210222172424.yw5nvfuadr5m5max@maple.lan>
References: <20210222172424.yw5nvfuadr5m5max@maple.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210222172424.yw5nvfuadr5m5max@maple.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.12-rc1
X-PR-Tracked-Commit-Id: f11e2bc682cc197e33bfd118178cadb61326dc0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 899cbb0e53c6b66c3fb98d8745aa4b0b41cd94f2
Message-Id: <161402112794.16114.3419496530375562204.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 19:12:07 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stephen Zhang <stephenzhangzsd@gmail.com>,
        wengjianfeng@yulong.com, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 17:24:24 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/899cbb0e53c6b66c3fb98d8745aa4b0b41cd94f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
