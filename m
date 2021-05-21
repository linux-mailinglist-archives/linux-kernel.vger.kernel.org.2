Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B5938CB1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbhEUQgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237157AbhEUQgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:36:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E8FE3613E8;
        Fri, 21 May 2021 16:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621614887;
        bh=byWO9EmlvDXEWZWbEbm47BEszbFOyqw4M9FBHYBVPKE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S1/wP4ZgcDzK8tir9mBWqY27iPCTA29jZOaVx/dhd2XmtEKrfWjgFdjrNSy2O/LIM
         XSxz1VCc+lUNd2BcLb/wX5suKWiK+JaYfMRdhS/LB6Bw416eTbcAfV3Alqi3eqveCi
         GrI1voUBQpVmySoxxO8DWPVejZb9DQJxus4uK8ViKKGqFvvzy/7hBSB6MsiqHhPV6S
         szaSv6Mn0H66O/KuicXVU4OT+H1RuPoqm513NE9rxSpMmT0FIpz+mqsDlKsqbfW7AW
         +6YH6+CJA9DB0z5O48+yNSe3V11LTl6+/gx6RZ1q1nTCxqlTfYdhlGeWx3Cv613KfR
         dYgxTaF7G/u8A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E474A6096D;
        Fri, 21 May 2021 16:34:47 +0000 (UTC)
Subject: Re: [GIT PULL] Modules fixes for v5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YKd6HcDP7aP0s366@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
References: <YKd6HcDP7aP0s366@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YKd6HcDP7aP0s366@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.13-rc3
X-PR-Tracked-Commit-Id: 055f23b74b20f2824ce33047b4cf2e2aa856bf3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1f47ebc9b246e36afaa339cc5ca7ad9d3ae71b2
Message-Id: <162161488792.28405.16630534663920759127.pr-tracker-bot@kernel.org>
Date:   Fri, 21 May 2021 16:34:47 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 May 2021 11:15:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1f47ebc9b246e36afaa339cc5ca7ad9d3ae71b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
