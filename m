Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B557309824
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 21:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhA3UCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 15:02:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230237AbhA3UCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 15:02:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 767EA64E11;
        Sat, 30 Jan 2021 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612036880;
        bh=oxIvY76XJLRY+wL9Pz1VQM3hV8KPPxPTT7aqXFcZ9FE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HRGyzHwkJAxJD5rdLS/62VMv1vfj3/RywuGMrPAI5ld9S+D/NBcSaQCA1gc+wHoi+
         TY9fWMMDPkVI4/tx7LEeVrqEgtvld5SPOAa+m5aCucmKeZYf4LFT6rkLaGmr+Uanji
         ogmhnz99KP0sYSke9rAzIE9awDSxnB+9QfzhMhEr/J96CyRRCNsH+RV33eGUv+m4EF
         v8fyRVfvWpILjetCjjr15aGCxabacTdOJFZ2ItCIe/M3n3YIyhsQC4a9sARZ74lS42
         O2b2n5aM0imI8ygMBniy5ywi6DYEOdnxrO1byJgc90BtmzGt7CK9lSHVKfQVR+u9oz
         7ESGdnhe9IPyw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7209F6095D;
        Sat, 30 Jan 2021 20:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for 5.11, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210129225915.GA3859663@robh.at.kernel.org>
References: <20210129225915.GA3859663@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210129225915.GA3859663@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.11-2
X-PR-Tracked-Commit-Id: 32ada6b0980d86133d080d62371a5787ea2ec5ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c947645151cc2c279c75c7f640dd8f0fc0b9aa2
Message-Id: <161203688046.22475.5630840234609908693.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Jan 2021 20:01:20 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jan 2021 16:59:15 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c947645151cc2c279c75c7f640dd8f0fc0b9aa2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
