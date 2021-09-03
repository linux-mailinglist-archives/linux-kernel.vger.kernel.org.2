Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2255F400541
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350524AbhICSqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350488AbhICSqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:46:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 304C2610E8;
        Fri,  3 Sep 2021 18:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630694747;
        bh=AAegnXp8DjLcWSQIhw6Xa4GPvr9P2pP+q7SnAN6X/VI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Nk3/Y23DySrfXyvZ1TqCfujwBOzxw56hGyTFWRaKZYdLkJbXsV9tOQ4+95vIdHQNG
         kfJ0hSlsnphuR8eKY5C4EX1cz7NSNWetYmrLimWBPASAuMKiYL/aIlisMbgFtodP+I
         20QUnPbdcrrK8GNUprd4T+x7B3uZFNS3JTveBtf5Qqi6K9dH/1XthKhchqpN9o2doZ
         RuioQvZdsZg116cdKzhtgd6PFK0pTewxBRG6yej55iETUc7BU20dwrbo1MwOUyg/6U
         gyJYvQQIGD1mA/RKnE/nnZfywDRXjNOAjNpB3bqVBN/Own6uUq+7tNTAEs1CFEbNwY
         jbE1pylsei2Yw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2B0E7609D9;
        Fri,  3 Sep 2021 18:45:47 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTIrHxWNzIwuseXO@8bytes.org>
References: <YTIrHxWNzIwuseXO@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTIrHxWNzIwuseXO@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.15
X-PR-Tracked-Commit-Id: d8768d7eb9c21ef928adb93402d9348bcc4a6915
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69a5c49a9147e9daca76201e3d6edfea5ed8403a
Message-Id: <163069474717.21432.492880426025517336.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Sep 2021 18:45:47 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Sep 2021 16:03:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69a5c49a9147e9daca76201e3d6edfea5ed8403a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
