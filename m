Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4214321F55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhBVSof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:44:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhBVSmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:42:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D2F5F64E00;
        Mon, 22 Feb 2021 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614019018;
        bh=XqTM2owIRW5ymW2GMnJRwaO9PsQpx2QDxWNSLEu/UxM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Nti9P5o97v/TbNmpLrHntcqeB+H10Berc44BfJepDNGSU9Pvtix0IsF5S6ruTdK5G
         In3/jHlBjCRj8jL45uk0aP01VieBRBzBb4hl1nlngvaAr6aWaRgq3AqKLdu4aQ5qvd
         Aexe5DSp4D0Un4XNZLCH8Fru7LRWDwGxVFX6UT2NprVFgOZbqlIyLgCfMsxo9QC+yk
         t5LNrJaH7EXKuUacJFwAYV8NqD38rKaDwF5jl3lVoS15Fz7hxyc7j/yMZJT/My/hWP
         zsVFw2q8QHx3rztzdpCFzxeR/yjaHh0S8QsLNeAJZUxfKhueFIoVVJ+HHR/D2a0tmj
         yrkWzK2V/Lyug==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CEA4A60982;
        Mon, 22 Feb 2021 18:36:58 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210222161729.GA26068@8bytes.org>
References: <20210222161729.GA26068@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20210222161729.GA26068@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.12
X-PR-Tracked-Commit-Id: 45e606f2726926b04094e1c9bf809bca4884c57f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d652ea30ba32db12fe8365182fad5ba2e7c22822
Message-Id: <161401901883.24925.17382210599066419547.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:36:58 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 17:17:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d652ea30ba32db12fe8365182fad5ba2e7c22822

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
