Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900E13BAEB4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 22:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhGDUMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 16:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhGDUMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 16:12:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 687E7613FB;
        Sun,  4 Jul 2021 20:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625429386;
        bh=MatZM6e0MMhkYJn1xWayFRIVU/QZ+ZZXM8TvPn4MhAg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ow+47lPne8/3VUvUgxSRgVul1pB1Wg4XlIvwmQTc7kR8xK9a8NCfkbp76Lj/fi6ou
         AL/DXdC5OUlYOj69tcDRmDjYCYbzR8s9EQQpLa2OfEl8WAwaLVbPanyRXHrAGoigWK
         it6A3eG6H9hK4rCQnJzRx+is7QhHIgtTbv2Os3rpWBf3EIh5c2u0XSFqv/WLDcC03/
         x8va+ax1eGtbCANE95PdjsZAxNltoSjPYQY+ZwO9bOrP10SoahuESQ9WObQyUTP+3I
         8pXKf63EKtknTUvoaCI6lv2UTFut86RaZNP7lYmXlXeSSKmdWZMCa5w7ER7dHuYl1o
         gCtf+uDIkKadQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6273C60A27;
        Sun,  4 Jul 2021 20:09:46 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210704172440.GA2966393@paulmck-ThinkPad-P17-Gen-1>
References: <20210704172440.GA2966393@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210704172440.GA2966393@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git core-rcu-2021.07.04
X-PR-Tracked-Commit-Id: 641faf1b9064c270a476a424e60063bb05df3ee9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28e92f990337b8b4c5fdec47667f8b96089c503e
Message-Id: <162542938639.15409.8209616934419539960.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jul 2021 20:09:46 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 4 Jul 2021 10:24:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git core-rcu-2021.07.04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28e92f990337b8b4c5fdec47667f8b96089c503e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
