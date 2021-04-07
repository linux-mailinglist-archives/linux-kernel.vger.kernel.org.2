Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95ED3575D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356079AbhDGUXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234971AbhDGUXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:23:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E1D686100A;
        Wed,  7 Apr 2021 20:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617826988;
        bh=XjOW73dux/dho35SEWykXJ5ftMUfGmMU9BRzbkdCUwo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eiWyo5kcSXYfMceC21UH4KKY7NQO+EKA7b0M2NXV/YHq/8B5447quS5757p4kzMJV
         tjQhG3gsbqxV/n4+zHW73IFQb0V+fenDHzGYEaFJ6Q68yzyXY03dIIGpTbh6GlDDZ0
         EvkeLruqCB2J6arqeLqVqNl/zceHHN0A/cjWu/mSjms93Mz1gaa49w0C2xRfvX8r54
         +Gkmbi5Zodfg0kIhFwTq0hC8YA/O1B6t64xOQXmmks6r3k0UiIMmcFWgOc2hoyNKUb
         Vn5rCwTf7AjDauk0dTh9B44SDAe7hngIgktV9kH0zJleSo27ylkhErIhKrkirwik6C
         NGXntWR16S5KQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C8382609B6;
        Wed,  7 Apr 2021 20:23:08 +0000 (UTC)
Subject: Re: [GIT PULL] ARC fixes for 5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2fd4c2ef-6a48-53db-1b22-3742e438ae23@synopsys.com>
References: <2fd4c2ef-6a48-53db-1b22-3742e438ae23@synopsys.com>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <2fd4c2ef-6a48-53db-1b22-3742e438ae23@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.12-rc7
X-PR-Tracked-Commit-Id: 83520d62cc5a94d2ff0e2d37c8204fca13dd2637
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 454859c552da78b0f587205d308401922b56863e
Message-Id: <161782698875.25152.14511842179891981575.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Apr 2021 20:23:08 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Wang Qing <wangqing@vivo.com>,
        "dean.yang_cp" <yangdianqing@yulong.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 7 Apr 2021 20:15:54 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/454859c552da78b0f587205d308401922b56863e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
