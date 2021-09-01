Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027A53FE280
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbhIASsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234983AbhIASsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:48:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 19AB160FE6;
        Wed,  1 Sep 2021 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630522038;
        bh=dbWrfcfuWS1ZY1fqgdPDTRlNK4AHRzaBcTAxp0S7pC0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B9QXHim0qwYlPUe0R4k863vbDyl0oFAVqW/TLc+BxYPpzdGprgfTia2vZGjXIEo/N
         Yemw8GcaD2nBufNnnPSJOks+tpzg0SIPMHXRx5ArXT0db9avrOEN1WaBkV6enHo6Gc
         Ts304E6oPy4Zjeo9BGKHFPXerCqYpCN5nMgL2ANu83E5BUnfjGpEvEnPigbPzi3vCW
         UWnpV/UH0m0f8jD93iiaKmVASio63gT1UCDj2/CY5cyJuCgiL1+VFvPHr0uPGjJ7St
         9ddw9lxGuekWwmODNZnQFWfUg4ToqinPRyGXHiYSLwecmFycUZ4uLFWRwtILe/WYU3
         ZXdpI5b5Q3qiQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0512E60173;
        Wed,  1 Sep 2021 18:47:18 +0000 (UTC)
Subject: Re: [git pull] drm for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txeN-qCRJvYV552zdo2H9iVy1ruVrq=YdZBP5Dmpc3Jmg@mail.gmail.com>
References: <CAPM=9txeN-qCRJvYV552zdo2H9iVy1ruVrq=YdZBP5Dmpc3Jmg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txeN-qCRJvYV552zdo2H9iVy1ruVrq=YdZBP5Dmpc3Jmg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-08-31-1
X-PR-Tracked-Commit-Id: 8f0284f190e6a0aa09015090568c03f18288231a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 477f70cd2a67904e04c2c2b9bd0fa2e95222f2f6
Message-Id: <163052203795.3882.2878340645675304753.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Sep 2021 18:47:17 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 15:53:10 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-08-31-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/477f70cd2a67904e04c2c2b9bd0fa2e95222f2f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
