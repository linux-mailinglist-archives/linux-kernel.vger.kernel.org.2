Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E27245F519
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhKZTVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhKZTTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:19:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2240C061A1E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:41:30 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC02E62321
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 18:35:09 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 092EC60041;
        Fri, 26 Nov 2021 18:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637951709;
        bh=7driNm2WVc92ubSabALVsvKyR0qbyWJzS4X9tddEVRI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Sd+Ud/y8XILA0q5BnaT1Oxz9J2AJaJpUyOtemJjO2toIr1rR4h6WsxU8i+vZw5h8y
         z97kOlzsTmGze4IN+FImoM24jJVtDcvPlEwRfAK+MrlLZLATABHI6OwFEJBoUUJ2pj
         ONLhgYwC+PfXXJEbeEOG/arwbk45xAoSUO9Et7h7+70vEJnV3rAJ3a1C1kEgD9N/7r
         2BoGaP8JbhVbBDHEb8pyK9fbiGokkFrt8Aez5RMHt7/G8B+vyT1Y/5Foz4CplwWh8c
         4inNlmaDy4jJoAPfIKnmEne6Ca6z8ERJmBwJNfsYsZ81MZUsGcipTDxn6x+QfJXMS+
         IKyFn8x/UWG2g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E779260A3E;
        Fri, 26 Nov 2021 18:35:07 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YaD6DdgslN17VWV8@kroah.com>
References: <YaD6DdgslN17VWV8@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <YaD6DdgslN17VWV8@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.16-rc3
X-PR-Tracked-Commit-Id: b535917c51acc97fb0761b1edec85f1f3d02bda4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 703374418e93006a4b42a9b607e8e438bdf6b087
Message-Id: <163795170788.22939.11490049493260235702.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Nov 2021 18:35:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Nov 2021 16:15:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/703374418e93006a4b42a9b607e8e438bdf6b087

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
