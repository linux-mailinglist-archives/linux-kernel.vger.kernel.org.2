Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A132401150
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 21:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhIETIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 15:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236036AbhIETIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:08:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 32D2A60F6D;
        Sun,  5 Sep 2021 19:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630868834;
        bh=7CS+2y4pqstHvyDwuLQZ99Mr1FwyLFF/JLvqS2nT2SY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d7boqw0eEPcm8iqyik1ASbsQ/lBpUBPlkVvDBw/9WItPD+H7hKc3xtFmxOCmXJvUa
         S/Wp1mmFDaESoAemUIi7dn5IpXO/EpHWg1ASG1D9ikHAVvW9tBfRJbUCPyL8HagKRe
         133DnVISDLS2TvB7Iw8Ws60DrlJSxv12ACsaWQR0+UPSLm6OlyRxnrca2d20Zafmtr
         thR3RE5beoO6Bj1w9xP+P04iAmLQyCp7Rh1QXd+IxhI2p2dyM6HscEVgBLDhVRR8Gx
         UG6Mti3LA5hYJZsqDwaDAfpvZ701uujB1a7AtL/8JI8GTqrDcwHnZ6VHDF0s0DmW/0
         KlSZ73wAWzEWQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2CB5A60A48;
        Sun,  5 Sep 2021 19:07:14 +0000 (UTC)
Subject: Re: [GIT PULL] ARC changes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <56b00ebf-3c2d-5c2a-0491-14b378e85bb3@kernel.org>
References: <56b00ebf-3c2d-5c2a-0491-14b378e85bb3@kernel.org>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <56b00ebf-3c2d-5c2a-0491-14b378e85bb3@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.15-rc1
X-PR-Tracked-Commit-Id: 56809a28d45fcad94b28cfd614600568c0d46545
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e07af2626643293fa16df655979e7963250abc63
Message-Id: <163086883417.6256.1384476428892280015.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Sep 2021 19:07:14 +0000
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Sep 2021 20:20:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e07af2626643293fa16df655979e7963250abc63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
