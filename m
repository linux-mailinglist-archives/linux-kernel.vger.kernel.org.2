Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53613FBF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbhH3Wkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238476AbhH3WkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:40:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 15BDC61037;
        Mon, 30 Aug 2021 22:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630363169;
        bh=pL/x7fd53Na8jzjPzvV9m/hLvo1WVCgfeqDlxyF2A9Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XH61QSyXPUXANo/Fi3Bcud632rYB1ZCcxzEz3Y19KNyYi6ZTxxg/2dVDO2mz+jSN1
         dXQ7P7KkACyC3DEko6ObUYwbcWDkAZGtbHYOTI19JJz0czG8uMcbRjzTcltbynw7eC
         vqLefwwbXJGJSiKgtjB6M5lJ9gcb1UbGO95U6/gr1V8WX+zSiVtnj93JEhmWkwfCYd
         yBOUf/wZAI+ADaeuTsGzyLUydEnLFTw2uWHRi9mTSYuHJYCa226XS0XGMYxJwabVe8
         Ft8p7+vb4SvWF5pYWubw9LRn45LBaiaQIexad6QKlEocjRnYFAJoyer2v9LBsQvAXv
         TTwJ0/ueEiukQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0E33460A6C;
        Mon, 30 Aug 2021 22:39:29 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163031993245.58256.17381067625019238476.tglx@xen13.tec.linutronix.de>
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de> <163031993245.58256.17381067625019238476.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163031993245.58256.17381067625019238476.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-08-30
X-PR-Tracked-Commit-Id: 47fb0cfdb7a71a8a0ff8fe1d117363dc81f6ca77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d6e3fa87e732ec1e7761bf325c0907685c8571b
Message-Id: <163036316905.23007.6823420872430989295.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 22:39:29 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:44:43 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d6e3fa87e732ec1e7761bf325c0907685c8571b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
