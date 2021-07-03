Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF23BAA2F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 21:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhGCTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 15:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbhGCTnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 15:43:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7B4F56192E;
        Sat,  3 Jul 2021 19:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625341249;
        bh=WTQU9M1bQez2fVsg8iCUZUPTxvn7h/8k0SoHti0fILI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p2AhfyZEJkVevKAj0wCUhqBHNmkEIlE+DYtmLlxgB5XtMQQEZ+aOCbzqFeFgK/wSf
         1fU9S2nJCsifXL/0UBv48+Lb6VCzHsdLYtlZLqcGnlQfWKTQVqBuTCMiZsXtr8+C4J
         UDMasG4jx4cs9I+oloAU/Cyn714D5aExGIQhHIVfj9KOGB3jc9RmJZC7GrLYTmlRSw
         OnwXvHg+0dvKwcLLAh2rMMhjB85vrQGrZ7Z0PWm/ZabQadRVGGtvDH3rVMUzImVvRv
         h7JMRtrIYxh8rBUn56kEqZhqm88ChsfSxQCPRqdAITru0FA45CMxoil+2+BDOXpckr
         8tM5YXCe8mUeA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 74A4C60A37;
        Sat,  3 Jul 2021 19:40:49 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210702171058.GA587468@robh.at.kernel.org>
References: <20210702171058.GA587468@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210702171058.GA587468@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.14
X-PR-Tracked-Commit-Id: 6a9a930dc4415b2e8c0bf2085b2b0b2b291053d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a70bb580bfeaead9f685d4c28f7cd685c905d8c3
Message-Id: <162534124947.29280.4068344041669286170.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Jul 2021 19:40:49 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Jul 2021 11:10:58 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a70bb580bfeaead9f685d4c28f7cd685c905d8c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
