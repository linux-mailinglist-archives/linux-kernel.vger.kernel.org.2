Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0F38CB1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbhEUQgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236764AbhEUQgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:36:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D64F3613C8;
        Fri, 21 May 2021 16:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621614886;
        bh=dQL17bP7vBGpBcY0p2hypnD1Moenh6CjTaO0CFqWNVU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gx+BGJnMsx56ng9wuckttZvSz3gO26qrUitnMa+aJrjKhqPO8Kx6QIfS18PsjaKEp
         9lX006vz2UOT+RLlNoW6iwRb2uZX8OqyN7ZDgSWk+M64l4qeNTZ9+y8PKf5Y6nFOqf
         xaKDTLJrKCFwyUVKPjVimKp3tGjGefQguykAtqPXnHFdhgO0DUlfPvkpIfT3lSnPI1
         rkzsch7CA8MiQoR9IJ4jU3xUUnmahxIa5JYNfd+380QeSTsnekMMA0MQ4sDJCIzcCW
         cLu58AdqWwzBiSF5g8enbpPAjq8Dwowqv7I7WhxhUjbLnMx58Kx4siqUjVl6h+PQ+h
         D3jwlFKHw+fbw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D0B606096D;
        Fri, 21 May 2021 16:34:46 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.13, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210521153848.GA4041054@robh.at.kernel.org>
References: <20210521153848.GA4041054@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210521153848.GA4041054@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.13-2
X-PR-Tracked-Commit-Id: c17611592d9635c443bedc9be901f4463f45c6d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5328bf8ba44e3f92016bbc800f352db922654f1b
Message-Id: <162161488684.28405.1607667050091534604.pr-tracker-bot@kernel.org>
Date:   Fri, 21 May 2021 16:34:46 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 May 2021 10:38:48 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5328bf8ba44e3f92016bbc800f352db922654f1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
