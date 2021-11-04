Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0E9445A07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhKDSxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232295AbhKDSxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:53:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2D8E96112E;
        Thu,  4 Nov 2021 18:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636051866;
        bh=UOTPM5ZhqYL/3nS8xkv7cPrWsnm9PV2Tis/a3NE/+K8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QbD9O4aqfQLkIi3jB1EpJAdPZmUDO3iVafoWPdxSNmLDW5yWYmFLt/3LzEaCr9jeS
         HmHmwAQOZuQTT4u91/8aY4b1FR0O2cgLCnmcfg0NMzr1JPUpyBtBBB7ixBkEvhSK+t
         SBV57iUiG6CACoVy6qdJ2kQOcMVgBadp2g4GVrpSWhsozziWRilk9AgFCJrrAXDlTP
         iNC8BPQduvkQgvwA/QxYIOmS/XfXWf3klEZ4eewHno0QoJWOHy0kjgB/tzpAGljszu
         valXPHjnbFA5c9MV9yk4EK5rYBI0FOw9/Zmn6EUY2dj7X7T4TNzinTA/Q0npiDdwJi
         GugGc1aJUGzYg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 27550609B8;
        Thu,  4 Nov 2021 18:51:06 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYPrNkweZahTdAbA@8bytes.org>
References: <YYPrNkweZahTdAbA@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYPrNkweZahTdAbA@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.16
X-PR-Tracked-Commit-Id: 52d96919d6a846aace5841cd23055927c6e6ec2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e113d01f5f9fe6ad018d8289239d0bbb41311d7
Message-Id: <163605186615.14812.4274088227615366020.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Nov 2021 18:51:06 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Nov 2021 15:16:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e113d01f5f9fe6ad018d8289239d0bbb41311d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
