Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B23B6D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 05:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhF2DxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 23:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231598AbhF2Dwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 23:52:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6E7BE61D41;
        Tue, 29 Jun 2021 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624938628;
        bh=jBI5KSTeUraS+rfRplewyXAwCWCGoFQZHQmHF1yldOc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Knj2m/RzgZQtrPdIVwawXejskk7EgwOe2E2slhFBG1d6o+MsmWBCXxRU9STqqLamZ
         6O2FMGyspxbvsVaZCBkGpq1KmexrL8pxQAF+8WG04Ks48pmUSNw0hLdnDDpsg8i3Iq
         4pVDft1FjEfLNrkAt/Y1LvTff0fR56fblDnmf8PWFyu2ZxX3ZXIoAVGBeuFcTlFpdw
         1njyyQnArXua2AW0cp6PAWNmTFrvq2nbKSSAOsiWCtGNqPYMrU9mn0oWc7SCjT2Em+
         eH9uTKxS7GEbWVi2bBE8DnxDftQIvmPjQJo0X/09W9s8i++0vbAWCC4oclNLhPIVNF
         CP4G8G4Z/j1uA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5ADA6609B8;
        Tue, 29 Jun 2021 03:50:28 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp updates for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202106281254.440E6D926@keescook>
References: <202106281254.440E6D926@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202106281254.440E6D926@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.14-rc1
X-PR-Tracked-Commit-Id: 9a03abc16c77062c73972df08206f1031862d9b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 616ea5cc4a7b058f8c27e37b9a597d8704c49130
Message-Id: <162493862831.19305.7750040732250071625.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 03:50:28 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 12:57:16 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/616ea5cc4a7b058f8c27e37b9a597d8704c49130

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
