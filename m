Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A601427237
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbhJHU2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242880AbhJHU2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:28:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E1550610E7;
        Fri,  8 Oct 2021 20:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633724779;
        bh=vT5acUdijVlmgJ73PQ7CevuSDxlM5VYf0E2NOdYsC4Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dXgWir2THYdjizavZQrBr72bREyVMCL0fFpYMn29dzmeShRaLJd5jlE2Wi1pe80o8
         Tr8el6+5cD8eDSz6bQcfw9gBJayKunkq0UJNfU7+amqCrr0Hvr9T30S53209U5zCHF
         bYBg3NK6a4O2typZRFPlx+RXGHZRsCiojNtPAF2Iq+2+Ng/uWhK+HuU28Dfwwz/2Xa
         aO+ejv/wdSMY8oktyzs3Gnp67uoC6xCLnNG3OX8euEDWTq/Ps58jiI8zpRq/V5ERDu
         EwoTDbGw3wnOhbwECJomsf5vb3fFiHHWRsYo/6zdwXOa5Su350qDCu3beeTEv/cjmy
         z5QK57SMRmVvQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D1F5960985;
        Fri,  8 Oct 2021 20:26:19 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211008141911.25271-1-jgross@suse.com>
References: <20211008141911.25271-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20211008141911.25271-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.15b-rc5-tag
X-PR-Tracked-Commit-Id: 319933a80fd4f07122466a77f93e5019d71be74c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3946b46cab8b4714a9274af91772b9ad17a10e12
Message-Id: <163372477980.4543.4165045948379929086.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Oct 2021 20:26:19 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  8 Oct 2021 16:19:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.15b-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3946b46cab8b4714a9274af91772b9ad17a10e12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
