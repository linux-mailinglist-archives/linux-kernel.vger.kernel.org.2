Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38343402F7C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346360AbhIGUPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346110AbhIGUPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:15:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 41E3B61106;
        Tue,  7 Sep 2021 20:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631045674;
        bh=U5nW3mYRCHp9YN6I3/4yqt/Zo6AaEYHNpS6efjmJ3y4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F0PM9jFg9H3sArtE8S5INgTgMKdJ+94qT5+ATfaByvpnoKFAFidIj7zWAn0X9Ze7r
         VBk/qN1GJWtLmvzPt3rzvQwxAKaz35TAm44kxXCe3RVJU7IzXc8i719TV545/MUV5g
         LHL4hSCCVSgW6SblbxvnpsatlHLO+8CYULAv3oGKu+C/Ek5ZQYcG2/zdfdpz/qJPoo
         7YLn7zEIDRrGmP+RpfG2Whz47jdwBW08DbdOdrNE6uZfU54nG7oTXxjWO3F5FEM3hH
         QAXRQ5txfAQTpZe++Gdug6XRyXrYXoqEI9CVt34S/BzvOQ8t/WwbPw+YN4aTGVkLEC
         qYJig6NAy5mPQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3C6DF60A38;
        Tue,  7 Sep 2021 20:14:34 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTdvJZ/oLpSKs4mn@google.com>
References: <YTdvJZ/oLpSKs4mn@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTdvJZ/oLpSKs4mn@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.15
X-PR-Tracked-Commit-Id: 79fad92f2e596f5a8dd085788a24f540263ef887
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d7b4cdbb523cd11a978519f8e11895c27f05258
Message-Id: <163104567424.21240.12396584827313030253.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Sep 2021 20:14:34 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Sep 2021 14:54:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d7b4cdbb523cd11a978519f8e11895c27f05258

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
