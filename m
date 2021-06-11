Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0F23A497D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhFKTjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhFKTjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:39:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 11474613B8;
        Fri, 11 Jun 2021 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623440268;
        bh=mNw0UGqNwkbKkK4I4bl7/s0QB5RuimeMBTD/y05t6z8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GNAoSk178jXaZqDwYZDynOuSglFxy6AmRtsC+pvv9W8lTUJus7RLRq3EE8ogf2nSe
         7MNhzJBd/D11rEz8QiKUcXrzObs4aXnx+eTNk4hmCM3PHqKY92w1UYvI6ewy7G50ju
         7aDEEsMEwhQQBnlwTwsInya3AfXBWNcyjf3PYHA+kFS7n2qI5v0aPDhqKwKyKlqUaS
         F44cTCnO6KMEskk2Tv44t+uUF5IMys++Kn+jDozygkA9w0J7o3Z+RqIDT+e7hsDugV
         LG8HvC4cHTh9A+siqUEjdr3l+DHi20nmotN3SFZODVxRAd3jFy9dEnKZdb+JL7rZnX
         QgZ4pm0Fu0gwg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F353460A0C;
        Fri, 11 Jun 2021 19:37:47 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyyyQ-0QkKquLX4q=7=pjGeRxhhP=z7rfLjEbX7mSrh5A@mail.gmail.com>
References: <CAPM=9tyyyQ-0QkKquLX4q=7=pjGeRxhhP=z7rfLjEbX7mSrh5A@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyyyQ-0QkKquLX4q=7=pjGeRxhhP=z7rfLjEbX7mSrh5A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-06-11
X-PR-Tracked-Commit-Id: 7de5c0d70c779454785dd2431707df5b841eaeaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f21b807c3cf8cd7c5ca9e406b27bf1cd2f1c1238
Message-Id: <162344026793.23951.1047701304187344651.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jun 2021 19:37:47 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Jun 2021 13:41:34 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-06-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f21b807c3cf8cd7c5ca9e406b27bf1cd2f1c1238

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
