Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F218393885
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 00:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhE0WG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 18:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233820AbhE0WGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 18:06:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3562B6113B;
        Thu, 27 May 2021 22:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622153091;
        bh=2bg7AYKWQ4EveYV3/31OlV8Q9FSDG2CnmWSSOuw6aoQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Cl/fYhPjDXr+wRqwYoIbIFCe0jbde4iL45xOscGJisDrONK7WSwOrew7cjFdf0TMC
         wCC/DhPtJdZa0n0fYa0KCh3HKj8fp2Vtr47F/lo1YV2F1GSNDJoza2jixmQg9d5ahY
         iLhVVRBl6vHrMMEIixRYQTTY53WyVjsUW014wzb/xwIeaeZT1b1UvdNUyCH5Dvi45J
         UW4SEQnuxPqLr/kyeru6XnC8clnmzGI+5ECMVk3eN5ZVUXMbH+yPQTeHQ9Oa6ouJdh
         +0cmAnWTvF9xF3TEvEN5n7LyR920HtAfN4BB4cp2Zfb2T4Ji79yvPlfZ7v/KVHqj3G
         /wRAPrOzBsJCA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2B9A1609F5;
        Thu, 27 May 2021 22:04:51 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210527190230.GA4576@arm.com>
References: <20210527190230.GA4576@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210527190230.GA4576@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: e69012400b0cb42b2070748322cb72f9effec00f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c856a3180daf38d33166c0c98da921841588019
Message-Id: <162215309111.27580.10960824136264737541.pr-tracker-bot@kernel.org>
Date:   Thu, 27 May 2021 22:04:51 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 May 2021 20:02:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c856a3180daf38d33166c0c98da921841588019

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
