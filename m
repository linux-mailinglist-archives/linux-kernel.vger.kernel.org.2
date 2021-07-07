Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928C43BEFCB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhGGSsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231727AbhGGSsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:48:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 902A661CC8;
        Wed,  7 Jul 2021 18:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625683533;
        bh=zy17eyU3LXkjAAOFAYVJtsanJlpLQbOGZIfnrB9wG/g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BAqp89zAam196n4WaLWdWS4ky3Xh3NAI632uO62+mPUm/aciYCi2LhNVMpeUULVz2
         8LSm4iRNTMzt+i44Ix4CmhYEjcD54go4BNzMApMu4i4v2p/ten6RAqJSODq+jdOVrR
         gJqJ9EqE9XmZk5pkGjuPMXs6aBY/Klk9HMH6VCbMrVlzMpMMBGIKT539EgPRGPV1tK
         OBDsms0ID7Ap3C/o1QwHKnMQXN9o2ahDI+peluaaXs3KYsqmSgPYWW+qnROu22v+UF
         Xj0E9Hl8QYRbERNdE3M3IHhjiSMmbX4KUiMAOc0U4NPOF1nweQkFDXUk8yUeQ/SPJ0
         x7kiNP6wrjojQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 89A9E604EB;
        Wed,  7 Jul 2021 18:45:33 +0000 (UTC)
Subject: Re: [GIT PULL] More fallthrough fixes for Clang for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210707052822.GA35094@embeddedor>
References: <20210707052822.GA35094@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210707052822.GA35094@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-clang-5.14-rc1
X-PR-Tracked-Commit-Id: f1469e568bf6dcbdff9fd7cd7d2cc9ca9d06efeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 383df634f14778302879e41d985958070e8f2320
Message-Id: <162568353355.3837.1960809537113979896.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Jul 2021 18:45:33 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 7 Jul 2021 00:28:22 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-clang-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/383df634f14778302879e41d985958070e8f2320

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
