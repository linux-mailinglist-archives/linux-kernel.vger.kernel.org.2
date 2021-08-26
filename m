Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152093F8E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243440AbhHZSxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243434AbhHZSxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:53:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3646A61037;
        Thu, 26 Aug 2021 18:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630003977;
        bh=GKWFVANq+IIV6OIsyk9jacv3V8KqVWMIMNga8ACbWCY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Mq6djp1heahewCmg7w7oRQtdskze+LlXeuLE8IEbzEywHWCZvpsPx8xr/4UJvQziv
         Y5G90041RInJ/BRgXDhxw5TJ355JGzLQMiNW5XGzDWjGX0BQJiYawjRKdqrxHd1k/p
         rOhPkf3BfFksV9ksY3Dtgc/w/zMMBwdAXlzl49HREhet62/HiBKoLZ+MDc8XzRDr7B
         rAejEnGlmVLCtAyI9Dz1N7erUPI5EVYfA5EmiarfNIkPAfDs5gF0JAI7NLlFti9GMa
         B/u0ach2dIDs2E9a9DmmXVNDckA0ums34gJGHrigv+LN0Sx2KYzXp90Y5IyUXKUDky
         0xYc+hcTCVhYg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2CBD5609EA;
        Thu, 26 Aug 2021 18:52:57 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fix for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210826131747.GE26318@willie-the-truck>
References: <20210826131747.GE26318@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210826131747.GE26318@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 3eb9cdffb39701743973382860f214026f4d7825
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a6d80ff2419e8ad627b4bf4775a8b4c70af535d
Message-Id: <163000397717.15844.5138355230241347117.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Aug 2021 18:52:57 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Aug 2021 14:17:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a6d80ff2419e8ad627b4bf4775a8b4c70af535d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
