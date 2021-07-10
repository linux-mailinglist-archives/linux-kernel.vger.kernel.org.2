Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC9D3C35DA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhGJRi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 13:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhGJRiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 13:38:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 75AB46135D;
        Sat, 10 Jul 2021 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625938539;
        bh=HlV20LLDOYS7hODFKi8+hnGlbfZ65tezqgNtx9Ei92Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r31b7M38RQDDMm6PMIrZ6tH0+ax0GuKbNJ0v0Flfchila3GZLiCPcYw6QGhfap9Wq
         s7/Q3GsUe90/legJgoanr+jzY/uGyTvxctcPyK2zXNzD4mtsBAnmLj64Uvl8dw2sHB
         DS4xnTrbrpWElWRLuXWBjDvydm5iRWMzpAruwdSKZaMTDtrfpt1rguHNEUtdQZ6oIv
         WaIcicOqfyMCCqwf5ZrzoLd0NWwUqieLl9EpkyadAz4pdASDDv30bHrRcy2dJ2167F
         c7+Cb1LowujwjgWbm+TOKDH7fHXzrN05qsqU+h2ciDhVnoBbL6geB4ijGWSUmJMEha
         cqMSX1kcnix8Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6E4E6609F6;
        Sat, 10 Jul 2021 17:35:39 +0000 (UTC)
Subject: Re: [GIT PULL] memblock, arm: fixup for the pfn_valid() rework for
 v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOiZif/oQWkVzDgg@kernel.org>
References: <YOiZif/oQWkVzDgg@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOiZif/oQWkVzDgg@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2021-07-09
X-PR-Tracked-Commit-Id: 024591f9a6e0164ec23301784d1e6d8f6cacbe59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6fd9e259457b847646844ed202b830e585289dd
Message-Id: <162593853944.16773.8514165115386216359.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Jul 2021 17:35:39 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Jul 2021 21:46:33 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2021-07-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6fd9e259457b847646844ed202b830e585289dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
