Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74732F5AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhCEV7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhCEV67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:58:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 09AE265051;
        Fri,  5 Mar 2021 21:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614981539;
        bh=wCtH3MoXQz+BB4xKiktPGcCpzGS4AumQg2uqoXMHhm4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uDEsmjUkuk+y1UnQf4uk5YFcHTP7XBVBG9txAdBNZnzp1pHsBXzKGZFaPEcm9spZc
         E+7T033yrncKqEFqNQ6hhEkgu+NTe8SQmEJkzRD81INHWTYeEowGu9LiCZ/YtV3S0I
         YAl4bjzJUSsMOxSj1VGOM/71bjXVQl7GSyP+iwnWJLBRmnJl2uva7cu3QjFARqYRjk
         s/c2XKXevBinKkR0k9lU2D3rlbgw5rA7j680rSxixBZI+FG0bHNstyLHEi6P43zLPy
         DapPD7SKQZGoigRgPsvn4SyclWSs61m577cs2QrsWbkD4zl821XaPpsHuEyFKyStwr
         1LSCqDZbkhuRg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 055E2609EA;
        Fri,  5 Mar 2021 21:58:59 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux iommu-updates-v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210305162319.GA14489@8bytes.org>
References: <20210305162319.GA14489@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210305162319.GA14489@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.12-rc1
X-PR-Tracked-Commit-Id: 444d66a23c1f1e4c4d12aed4812681d0ad835d60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc2c8d0af05af4c380824e40ff99ede398913ae5
Message-Id: <161498153901.14373.491816744847742815.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Mar 2021 21:58:59 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Mar 2021 17:23:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc2c8d0af05af4c380824e40ff99ede398913ae5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
