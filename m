Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FB735AF2D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 19:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhDJRDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 13:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234900AbhDJRDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 13:03:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 11F84611C2;
        Sat, 10 Apr 2021 17:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618074212;
        bh=wfGUp6nDowhIgv8vKG3p+S+94HworLOEblno8hScZeE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F+Ealjj0eHp5IKeneOyAn5504+3Ot1fZSV1o4t3ity1jR6IMkvSjeDg995ZJvP+MX
         5sRlizraoHHMO/Jxhh5W6ckITN28G7MIcb28EHNbbuyG9cKm+zHK99i0J5NBiKEb2a
         XfXaYI6m5k1ApFw/Uvb5zvsQ2kq7N0kM0da8KPcDjMgGHgqEAu+BES6O5sJzgAQjGR
         PtdpDMn4fhsqJ6vrNJ5FHq1nhwX337Y9J8OwfLR2kuGUReqwNAOGZyLFc6Gxh2u7IT
         7iIO0ahq917ydy2chXNAdEH6szQ3qfI3DoO0U424UtXlQ0MCLKiBleoeLHwgI6CGKD
         a3j96n8BurcNw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0D59760192;
        Sat, 10 Apr 2021 17:03:32 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fix for 5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YHGkPlxkMvG1JKdn@kroah.com>
References: <YHGkPlxkMvG1JKdn@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YHGkPlxkMvG1JKdn@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.12-rc7
X-PR-Tracked-Commit-Id: eed6e41813deb9ee622cd9242341f21430d7789f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5fa1dad75bef69fbff5a193b7a99ada624a0154
Message-Id: <161807421204.30985.16911060115857759169.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Apr 2021 17:03:32 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Apr 2021 15:12:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5fa1dad75bef69fbff5a193b7a99ada624a0154

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
