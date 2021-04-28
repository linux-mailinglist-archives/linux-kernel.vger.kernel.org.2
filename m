Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE4036E209
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhD1XOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhD1XNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:13:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 503686144F;
        Wed, 28 Apr 2021 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619651587;
        bh=G3y5HO0w94sSt5lQmESJNZvHDrukpCVeE/ZMc9CGwf4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HE9UN07kdigfZwAYczZlj/MxDsNwGPiS6qF0OZBEGizTTPriNsJjIec2adUYS3iiE
         7bTVzthJaD15GhsWWrHEvgK5H27/uez+M78RbcJUsenO2uBl+fEBB/uxNK42/xzbtd
         flJanT39lkB0tV92fVPkoPorFB69V/w73LMQFdd7WMoqy+ikL1gk/2cp/Iw7MKeJqX
         9afyAdALVKAuVZFPelyF2TvNK+FuUTmaiJazlOitvRc0X6KyoJ2/zb4I2dn7ry42dI
         +yRgpL8jfyk1NpJ+PDTkiSNPy1HtTiMUAOgRgzMzso5LINfR44eGZTZmExEeIYRtbJ
         5Dx0kgzjVpLgQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4A2F460A36;
        Wed, 28 Apr 2021 23:13:07 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210427214944.GA2052002@robh.at.kernel.org>
References: <20210427214944.GA2052002@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210427214944.GA2052002@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.13
X-PR-Tracked-Commit-Id: 031cc263c037a95e5d1249cbd3d55b77021f1eb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0080665fbd0e6a771aee366bb2aa208626e43def
Message-Id: <161965158729.11634.8822885761642229292.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 23:13:07 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 16:49:44 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0080665fbd0e6a771aee366bb2aa208626e43def

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
