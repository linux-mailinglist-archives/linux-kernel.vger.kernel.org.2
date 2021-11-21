Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7409045862C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 20:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhKUTmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 14:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231454AbhKUTm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 14:42:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D586860F48;
        Sun, 21 Nov 2021 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637523562;
        bh=scmojzYihm4SY2bYJTleJ3JAs3fZElPtLTE8pjDIm64=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lh1wj/KtGOSq6zcJFwmviMztFvvq0xhnVe14BVfzDUqSe5UJem0ap3lSI8KK21l0a
         7LdIk06ZMKfX8Oewmtc4cEtWxWEauUHnWw6boAnVxRJy2hFawtha/4xPb2P+b2dsoP
         cj/hrrbIh1ZkkMzbuFmYU4vNTv70LbgnonP5m9mj6pBHxgJBU6BeFTVAgax6HV8r2z
         UYIsgdZtKIM5Vm+ZCBgHSwsJ4yQPbyAEAlQ0qeVF8yyRxsboQtHrkMn/lM60m6OPUo
         I5s7rw5WxW973N8TZ/HUMSUNeo4xPj/U41c+zI8V0GlDCDZaxF/dc87zx04cYgRDCR
         ZalxlBc/mWHug==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CF7D7609B9;
        Sun, 21 Nov 2021 19:39:22 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163750734663.21962.15919226186457637549.tglx@xen13>
References: <163750734517.21962.4980600300710105647.tglx@xen13> <163750734663.21962.15919226186457637549.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163750734663.21962.15919226186457637549.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-11-21
X-PR-Tracked-Commit-Id: ac5d272a0ad0419f52e08c91953356e32b075af7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40c93d7fff6ff05c1c4c9f9c01a067eac6a791b1
Message-Id: <163752356284.15895.8091162956880264542.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Nov 2021 19:39:22 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Nov 2021 16:09:28 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2021-11-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40c93d7fff6ff05c1c4c9f9c01a067eac6a791b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
