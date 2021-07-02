Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8333BA53C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 23:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhGBVt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhGBVt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:49:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 49FC1613C5;
        Fri,  2 Jul 2021 21:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625262446;
        bh=EO9AxEgMOLzM2Q6/nyEjGEeF17ZjoCabe8lMhr+K/Cw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RT3PcEDDkWTJiD+Rn3CgVG6xXktyPgDhHl3hGlxUeowjnVxfhoDA5Rl+6vJ6XReC9
         spApdOPzvKM8++9xLpSI+y8pymCzQ+TEtnNZqFD8lJsmZWVMQtbEsBBAFP/bBvJc1s
         iXE9m1bk5iy9IcornUWPkJEqmnL/cprR5yk2VCD+zsDJGqUMgMEuQCngC351XxcHD9
         +uRau76ZoXx212Wk+mhwML+d/J+BKg6KnroihAjttyM6EF1FU4RoPZXIxzxz98dhec
         xusZrW4eLJjTyJ3DwLRuLY+cWMXTCt20uRgSdsVMDPxrji0DPjK4eX4JGkIivI9Oce
         E9+lhb35aOdqA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 367C26097A;
        Fri,  2 Jul 2021 21:47:26 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YN7IDbKZFQnYFCNq@8bytes.org>
References: <YN7IDbKZFQnYFCNq@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YN7IDbKZFQnYFCNq@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.14
X-PR-Tracked-Commit-Id: 2b9d8e3e9a9bb693a8b8bd26ad192db037517759
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd3eb7efaa995db00db0ba64893814f9831be842
Message-Id: <162526244616.28144.17442613568063715973.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 21:47:26 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Jul 2021 10:02:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd3eb7efaa995db00db0ba64893814f9831be842

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
