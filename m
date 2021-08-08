Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FE23E3C39
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 20:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhHHSgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 14:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232128AbhHHSgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 14:36:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BBB8160FF2;
        Sun,  8 Aug 2021 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628447754;
        bh=qOnQUWfclP74RXcfDS3mPCLmLDyYXw7umGETGOlH+Fc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KWHdH7w/Ln3IW61LU44feFtr65S/eFbWIzcLOq6sn/Bh2wuNcWuzEjR/yQR11Pdpg
         QqAp7cbSBwfvHbn92eQluIZFWp6yedftqXWc3/xTTF5oygUafC36SKrS+DbW9yn9CF
         D7NZY8soWoEQxvYbarSrpUseHmRW4BU9pu23408NMp3LLtxP9A7f4P9t9lvMqCOgj5
         9l3rmAeFNTVzpPPWaSxCEZ3HeGTHMt5iPZC4si6NX/YD7DsJDC8/RQJ2zw0lYZeO2g
         1ivMFiddFIvsAmzLFvOApUtS7KLeBTSxbFnbtF3oCkcDB8ymZwraqsRC38UrXOQ8XI
         09HR2gENmJqng==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B5A7360726;
        Sun,  8 Aug 2021 18:35:54 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YQ/Au3O0GhQvrMc4@kroah.com>
References: <YQ/Au3O0GhQvrMc4@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YQ/Au3O0GhQvrMc4@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.14-rc5
X-PR-Tracked-Commit-Id: 6bfc5272904af6873aa6bc7cd5732552f9c6e955
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66745863ecdec7abbfc3325c2d917eecb739c069
Message-Id: <162844775473.32600.10807995559574332608.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Aug 2021 18:35:54 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Aug 2021 13:32:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66745863ecdec7abbfc3325c2d917eecb739c069

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
