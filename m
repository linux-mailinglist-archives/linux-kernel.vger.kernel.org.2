Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E693CBC8B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhGPTbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhGPTbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:31:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B4816613F8;
        Fri, 16 Jul 2021 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626463697;
        bh=TQge4bMFoi7MCQ/PbB8cZ31ZHEkcY9Z4iU2yciOKXbg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qh42T9WqtnD/V4nYvAcdv5c8a62kyYMnWUiM9tSztdorQpH9dwyItjByucvVGE+Js
         sW6bRKoNu2X2M3iHzt1LuiNVPy11R28xS8kG1EPay0C1Ntg4ldoc/BdXOzmHLU8iOq
         9PU5VX2Viq5TJJvP1ISrmiKfQLxP8qfaf+PXREbtCJQMX1969SCbA8WZRoIxkrdgUp
         ImEL6XFxHqQb7Q3ziVRsTmoKHJcC4qH/1trFKjKvHObeqAuDg4jdeOpoo13qChMXcP
         OcfW4k98uwIlkzsRmCfGJOWoUf2Vi1hT+VJw3lepMiZ5N5bhJATL7GOaRFE5gFoBh/
         JwldK/M0Cbm2w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A8187609DA;
        Fri, 16 Jul 2021 19:28:17 +0000 (UTC)
Subject: Re: [GIT PULL] RCU fixes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210715224513.GA1391317@paulmck-ThinkPad-P17-Gen-1>
References: <20210715224513.GA1391317@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210715224513.GA1391317@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent
X-PR-Tracked-Commit-Id: 2a2ed5618a0e8a890d948b88b368c0459f35136c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e442d06621f2af87fc0bf352976694db547c780
Message-Id: <162646369767.3285.8325600143235474378.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jul 2021 19:28:17 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, yanfei.xu@windriver.com, ast@kernel.org,
        andriin@fb.com, kernel-team@fb.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Jul 2021 15:45:13 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e442d06621f2af87fc0bf352976694db547c780

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
