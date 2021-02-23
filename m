Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C66323491
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhBXAD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:03:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233627AbhBWXkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:40:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E2FE964E89;
        Tue, 23 Feb 2021 23:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614123392;
        bh=8KeLSV+vsfT3g4xaERh1xb8aonlTwmisMGnK+8OJG28=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yvw9mbSqYQx4BhDrzxcAYIIvitjbZ26Qa+1bYNH2ndnPjqrBj5H/FCrrk4cIf9iQu
         zIsdV/oMNBa8iooVmyjtftpMz/WhVZsH9slUbY1lsa+pwWydwCdGeydSEPk7dsloTt
         vX2/00XztTJJ/IaEVnfO7JC/SkcujU2Q1KTiRjo/eqkZ2HWDIHNngPsXCo5V/REchQ
         l/YrcAba/ZTrOkgJCWKr/lR6cDp/zIe63DpvtSjtGUsUDHWRTKl1LWgYPLOj0q6+U+
         EQ07tKslX5JmPzqbHPvKzGaiKRJds27v2FGtaW5dADkM/y2wGgaijOGG9W19boVRWf
         +eio5CtcQzvnw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DE89060973;
        Tue, 23 Feb 2021 23:36:32 +0000 (UTC)
Subject: Re: [GIT] Sparc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210223.132126.1594995051384966189.davem@davemloft.net>
References: <20210223.132126.1594995051384966189.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210223.132126.1594995051384966189.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git refs/heads/master
X-PR-Tracked-Commit-Id: 356184fb6d67770d7788f316226be810a430937b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6dd580b93da8de5cab4ac1f24f343086318b664e
Message-Id: <161412339290.20258.4463825858883396868.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 23:36:32 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 13:21:26 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6dd580b93da8de5cab4ac1f24f343086318b664e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
