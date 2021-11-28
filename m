Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74752460734
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 16:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353481AbhK1Pnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 10:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbhK1Pli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 10:41:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F763C061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 07:38:22 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EA8C6101C
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 15:38:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 86C736023B;
        Sun, 28 Nov 2021 15:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638113901;
        bh=3udFigij+Mxrmq6hY+BjxOVZFE6nlg3w7jRkh/g87Co=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g7U6/wzwWHvojN4rYp66iB2npDaQGZKTjueEt6LWDy2iClcp4+AHJ2TWe+Hv3kKDW
         qbM2uk2niCwiW90620S1YXlM8GBpaaY+5N7fpR7ELxicHmd5lU8THpwRkPzneC85bG
         rtFBsU330vMIeopnbVPS9cAd6eGxYxi13iZ5WDu+nACv6tPQZJyGuxyzro+T8VJFla
         eXE5z0pz4sloh3qdt1z6We+HeAtYOTXyFa4FkXHq5z8k6vjy31FIp3T5F/wRSr/KF4
         IUWxWVA7VM+xZQvOtC6znyGGdmdSH3jNxz4bg58WTrIK8xBIMy4VZy7WZ3opPp2Hch
         QKP4KrKtsXclw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7CFA0609D5;
        Sun, 28 Nov 2021 15:38:21 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YaOFCyGBRITPRyaa@8bytes.org>
References: <YaOFCyGBRITPRyaa@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YaOFCyGBRITPRyaa@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.16-rc2
X-PR-Tracked-Commit-Id: 86dc40c7ea9c22f64571e0e45f695de73a0e2644
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0757ca01d944001254a94ac1b25ced702a1e9ac5
Message-Id: <163811390145.31138.15681907790046498142.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Nov 2021 15:38:21 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Nov 2021 14:32:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0757ca01d944001254a94ac1b25ced702a1e9ac5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
