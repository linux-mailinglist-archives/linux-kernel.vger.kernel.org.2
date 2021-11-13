Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619CB44F56E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 22:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhKMVWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 16:22:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230189AbhKMVWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 16:22:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0FC9B61106;
        Sat, 13 Nov 2021 21:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636838362;
        bh=Tf7s/uHvXWigiRCfzwmQV+lg27ONI5w7zkrMTJYk0cA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AN2vap4zPYPMiZMKcVTQw9uCQqnX7UTemqbU62Hdr+kXlPBNCO2jYds1jyxwZkxVQ
         FSuD8gavKEEQGq1kBXjL5q2PcszwyLFJYiKx7aGtE/FpeA55NrI4NRmD/+Z6iAeIIo
         6XiJWDMQe8PCayCiiRoKRY3LkB7VGkTf2AOI1D+XUgmwUuo4sm4RqR74b7gxtLMq1I
         q+BTN6PlpppXNrnLPmoPmgcBm53I5PU7izpJJWnODJ2KNXmCJp99w0SCA/z8Im+2Zn
         +Zq5R0U57jk7F2xqGom3QW4spHFzXz06PWROseMlPBOmYbT7poyJZI3YGGNlcxo58l
         LhlSjDsKbNIjw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EFA27608FE;
        Sat, 13 Nov 2021 21:19:21 +0000 (UTC)
Subject: Re: [GIT PULL] More clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211113063648.3184640-1-sboyd@kernel.org>
References: <20211113063648.3184640-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211113063648.3184640-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 05cf3ec00d460b50088d421fb878a0f83f57e262
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ad7befd4842afa2449026715987122a1c6dcb85
Message-Id: <163683836191.5975.16797417168662635611.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Nov 2021 21:19:21 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Nov 2021 22:36:48 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ad7befd4842afa2449026715987122a1c6dcb85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
