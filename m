Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215CD442285
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhKAVWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhKAVWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:22:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 063F8610E6;
        Mon,  1 Nov 2021 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635801601;
        bh=a3D0cE/6CHB9i9YtHsJntkTHX2CpBxN/SRbZBi/GADU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FzAmdrwriVeEZdmpQSF8/3jBpEH38Bwo9xWyEn1OuZkuOuTwaJmzQpylSkcofttkn
         39yFRt36rcB7w6mtmFe5CHavEtf82nPL4mcatCzgZKfCrkYQr7km/njSLh/V65sEHL
         PXQ/0wMa2N03vCHp7sHi+d+NSGDf5yspDDNjM/d68KV8orquex6s6Ttlu6wbCcG1ob
         Fbpsp5N2+Tp6JUUu7F4iLOs8eqBP1oVlV+1qhxd7gvFBK4VxyrpNJSJLBI1tExLYTV
         k7plYKHY30gCgKiONbSFlK1zdcrFxEW7bhv2kC+ErK9I0xCziHus1fuW8yBzUqBhjG
         yMZNkiX+n67aw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F361A609B9;
        Mon,  1 Nov 2021 21:20:00 +0000 (UTC)
Subject: Re: [GIT pull RESEND] x86/fpu for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163572865296.3357115.3707320162730818106.tglx@xen13>
References: <163572864256.3357115.931779940195622047.tglx@xen13> <163572865296.3357115.3707320162730818106.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163572865296.3357115.3707320162730818106.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2021-11-01
X-PR-Tracked-Commit-Id: d7a9590f608dbedd917eb0857a074accdf0d3919
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cb1ae19bfae92def42c985417cd6e894ddaa047
Message-Id: <163580160099.7741.13477483120620505689.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 21:20:00 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Nov 2021 02:52:32 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2021-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cb1ae19bfae92def42c985417cd6e894ddaa047

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
