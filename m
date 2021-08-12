Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D01A3EAA2D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 20:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhHLSWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 14:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232698AbhHLSWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:22:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 16FBB6104F;
        Thu, 12 Aug 2021 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628792540;
        bh=YgXc0NQ6YNvX/HvxhJ4YGsMEDx3SYE8wdxdfH7nWBNQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qwPxBj5OhEKE73jRVyPjH2ci7zzTsvE2Hr7z2PWVFWoXWSTrzuLfjZrJEgmsi0Ftn
         6kIW5EvhZ9DV/kBcLD6+Avir1ecK61VAslfPP2CK3jf/15ePY6j46eYQVI+zAVHwND
         0y2z2Ovt4sfYn0Bt2X2hySxtlKKnWcw/BOj0gdNwBdOhFw/VF3pNLv74cot/AHR4JE
         Mj1hT/UVkt9XXwkWssTje/gex9WBdcQP66hV6qs+881loDHbIZ/Y0ef6SBRun4BYbX
         jvRoAYuU2+Csbot/xGIvJilIMMR56FB2twik78to99/D7O6n6zYRMcSxxgkOmLYjhQ
         hwrNB8hvg4D4Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0A02A60A54;
        Thu, 12 Aug 2021 18:22:20 +0000 (UTC)
Subject: Re: [GIT PULL] bigendian ucount fix for v5.14-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87a6lmeh43.fsf@disp2133>
References: <87a6lmeh43.fsf@disp2133>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a6lmeh43.fsf@disp2133>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-v5.14
X-PR-Tracked-Commit-Id: f153c2246783ba210493054d99c66353f56423c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8fbb47c6e86c0b75f8df864db702c3e3f757361
Message-Id: <162879254003.22579.8892423497447775886.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Aug 2021 18:22:20 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexey Gladkov <legion@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Aug 2021 11:57:00 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8fbb47c6e86c0b75f8df864db702c3e3f757361

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
