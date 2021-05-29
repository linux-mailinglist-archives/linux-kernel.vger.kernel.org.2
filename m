Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72FD3949B3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 02:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhE2Awo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 20:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhE2Awh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 20:52:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BBBD1613F6;
        Sat, 29 May 2021 00:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622249461;
        bh=RJGO4ySFS5ik0AyOe7U96615KYMPdVZ7aXlA7T0q3eI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Mbc0KIHuyEGmSD+64ALHE1/RiFml9wXiTxGDByJ3MbCUURxlkTpDd52cZkLaxlwXy
         N5Md1ouuYLwNidRWSi3exQJLGg6rm+gYuWwbNyuG4hjjwrYhiQNRc5eKTSX+90gcvI
         MANi7+a1tgqF8BxlU/fWNOOByBFqtq6aGUhokCX6CRH9J4j2oTlrR9wRGpw3NboJNB
         OMOsxeKBamL9SXdxAy4ICq8nuKatpE0lB9MjXH7DU1czaOEUc3mBm+9lUE3wF9cTOJ
         gcJ39UhQmQIMh5ZLS+rKnFKtjsEb/EVK31XnRzltY9ML243D/rKcVrZ0mst/JwiCqo
         0itiEq3+ujafA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B0883609D9;
        Sat, 29 May 2021 00:51:01 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twKOn4j8-_gDfm_DsQv-96MA6Wv+76bURR6Tb34jkVMcQ@mail.gmail.com>
References: <CAPM=9twKOn4j8-_gDfm_DsQv-96MA6Wv+76bURR6Tb34jkVMcQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twKOn4j8-_gDfm_DsQv-96MA6Wv+76bURR6Tb34jkVMcQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-05-29
X-PR-Tracked-Commit-Id: aeeb517368822e2b24231f5bd43a98ecdbe65d59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 567d1fd853b8786f93ba399c8ff7c8106bed5fe5
Message-Id: <162224946171.17808.6606271609905792324.pr-tracker-bot@kernel.org>
Date:   Sat, 29 May 2021 00:51:01 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 May 2021 06:00:49 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-05-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/567d1fd853b8786f93ba399c8ff7c8106bed5fe5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
