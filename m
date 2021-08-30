Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5873FBF09
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhH3WkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235435AbhH3WkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:40:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id ACEB560FF2;
        Mon, 30 Aug 2021 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630363168;
        bh=7NrDA5rHj5BsASEu3kn2ez2Vi0E7Q6ldlEBpkrnXEOY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EPRWVQL0BJQZOQDzNTDTepAuj3howpstzrnD9SLnA4RIFNiXxnVHMEMOWd56d9NnA
         sOzTr5JoNx3iqV2Fvps9tlbtp/r21ly3GLlVoNKPmnJJ6Q5x3b4zAcp6ksPXYKGojj
         2/Es178tX1/NSSIRuYn6xbV0AW0V2fcEyEf2dijM77HlmNI4/TarESYAvNPqYKf0uX
         5crilT8nOyAiD292AOxW6pbmlvaJ0NhQM66ESIy4qXxi+NwAmv/nTUG/sZSsU+U4pZ
         Qy49qdln9UbunurOKqQ1eGK5lV1saDpZh4R6QZHZJysO0OuTQU2Kcz2/VV0oID8Xs5
         VJOYsbJOVMGWA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A13EF60A4F;
        Mon, 30 Aug 2021 22:39:28 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163031993620.58256.3173641822017840619.tglx@xen13.tec.linutronix.de>
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de> <163031993620.58256.3173641822017840619.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163031993620.58256.3173641822017840619.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2021-08-30
X-PR-Tracked-Commit-Id: d25a025201ed98f4b93775e0999a3f2135702106
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8596e589b787732c8346f0482919e83cc9362db1
Message-Id: <163036316865.23007.8955822075889114835.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 22:39:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:44:46 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8596e589b787732c8346f0482919e83cc9362db1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
