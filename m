Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1466308FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhA2WO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:14:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231940AbhA2WNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:13:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7F1C564E05;
        Fri, 29 Jan 2021 22:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611958342;
        bh=I0DQYedg79MDplR4wz0VMCk0Kg1nGuOgVHy0BPastaQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ot/m49BwWvv1BTHkQNwCtXonxcAAY2vi1nfcl4+solCYa+YCX4C81nOKTKSFGP0c5
         fYr3vpHKR2xXHSxwNPZUnZzI4ntPiFY4KvMNPFcP5LgRuSQ7Nf3fG8H49r10/QYfeJ
         zkjBOOPfWltSo7fqqgJCHFJ2KfvrpMu6N7ju02zSp87OBsRHG/zInBUFqd3+Nkkyvl
         yf0xQloCZkI1j+g4A9uxnMkr31BB8lez0gS+TVBb0Jyvpu1ofCVnQX25LZq3nI2E3h
         ip6WdyBVDBDeB/86GcKFewpuQ0xrp5jnJaESUkAitCMBV2izBTL0hjTwURHOAo3juQ
         Ab9qG0uouHRgw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8BF8860953;
        Fri, 29 Jan 2021 22:12:22 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210129164123.GA25513@8bytes.org>
References: <20210129164123.GA25513@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20210129164123.GA25513@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.11-rc5
X-PR-Tracked-Commit-Id: 29b32839725f8c89a41cb6ee054c85f3116ea8b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ef24c2011b77bd6344d16630d3cd95d63de63f8
Message-Id: <161195834256.1476.12524452460486856757.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jan 2021 22:12:22 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jan 2021 17:41:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ef24c2011b77bd6344d16630d3cd95d63de63f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
