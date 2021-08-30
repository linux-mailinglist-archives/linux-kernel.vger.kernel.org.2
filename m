Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255EF3FBF0B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbhH3Wk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhH3WkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:40:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8CF1A60FD8;
        Mon, 30 Aug 2021 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630363168;
        bh=7JytnEHTgVtoqQ52yCYQBHOYPU8814jB/Bwo9dkKnyw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kvs9N424OICybFj4mDWr8gEt8Lewzvcxk5vDZlssqB0Z2ldPZKVvYgX+shSiTwA9K
         A/XIT92xKQKiExMN2HpGiq5mX7EClDFN8/K46bXGUykErYSBdkIsGhfhgMT7tlnk3c
         FjDCa8RGRktNikF07XQSlFBoukIt44a8RHLqfDlgXPtPjd3NnfA+DO3cmjNA2cjmJX
         3vAEYsOcGRDR18F+OYqBnAIq/NgLgE3E9wTm5os/2xWaBDFBEzqF69+2AgAzSolk8Y
         8OCBFYoSqD94yEyq38g1PxdLas6qpu5HYNnVjrQrbGAQg4RJ42kD/3gep06Y5Jmfcz
         LZx3+tjchVLfA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 774FE60A5A;
        Mon, 30 Aug 2021 22:39:28 +0000 (UTC)
Subject: Re: [GIT pull] core/debugobjects for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2021-08-30
X-PR-Tracked-Commit-Id: 4bedcc28469a24fe481a8a31b3584e6070457ddb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4c3562e1bc79f912457cb062cd0c147026d4a1e
Message-Id: <163036316842.23007.15305354562222847920.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 22:39:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:44:41 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4c3562e1bc79f912457cb062cd0c147026d4a1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
