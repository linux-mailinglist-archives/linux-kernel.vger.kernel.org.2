Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3223CAD29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345134AbhGOTyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244311AbhGOTbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:31:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 19A9F611AE;
        Thu, 15 Jul 2021 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626377296;
        bh=1NSyY1VrYa+ptMyFjLHzUi0wjs3LfZX+gdyrWr/XmOc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uF+O7WFgcRlPbFnI+GtC3WHGO5yiFbndhQeIA4IHrHBheGVt/jmfKkO8zkRUhSdSX
         AhyvDMOUIuw8oqJBJAKbQzj4Uqh/ebbq8W7uhR6yYGTm1SIymtIbZJmbfoXDKIqqAp
         qmiII2Or0Xa2TGA21hoMh9H2UtJrz8/Ja9A8gUbEwQAnK2GdBZ5cTq/LUarWGkPmYD
         PxYwCopZ9boNikKBGa5tftgnhomEbb8QTFnFteNPyMreh6LVSjnhMOi7Dq2K6eLfeH
         zHMYa9GZ4uSRI+RZKpcfes1jwBPRYfWi09VMNQOqONA1OfyzQFq7+yC2JN9CtDaHMS
         FLL2SBBjXtrOw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 03467609A3;
        Thu, 15 Jul 2021 19:28:15 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YO/tnD+7RA32yO1F@8bytes.org>
References: <YO/tnD+7RA32yO1F@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YO/tnD+7RA32yO1F@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.14-rc1
X-PR-Tracked-Commit-Id: 4a5c155a5ab372516a1a5ddd29473f8f696feb79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3523a226dbb0c925def650a658a0755185d60a8
Message-Id: <162637729595.11736.5575499763587728536.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Jul 2021 19:28:15 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Jul 2021 10:11:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3523a226dbb0c925def650a658a0755185d60a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
