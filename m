Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFD23B33FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhFXQg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhFXQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3DFB7613D8;
        Thu, 24 Jun 2021 16:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624552446;
        bh=bdNL4JbiiCjuCbc+UtX7Z5RNc/Irt3NCPS+T80U/1Lg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KFUbGTdbT4AXqvpVetLLeAocuWAeqY1UWpu7MdNM2VV7TYhHhDM4seD0gsEJRt1Cn
         yBFmTMbcemQRVQ6pqwOQBmGGkzECdVNOTR2vk4DhDXmhO1jo5JCtUNS+G2Ch6ZA0TO
         5eWIyT79VDM4559lh6v9ikKDjJcRANZlpwYjC6mokT9MVOSxT0N35hO3Yhizp2mo7t
         sLU8O1LHR/yWZXyFK5vhQspbGHF7W1gSdV1CtEM7cuZIIGBEJT8O9SVuTqiYV9YL/K
         fINCzAjAshmjMtEayLA8QGaBqO6oWvtV1Ct2ltZfzDrC6J2yg/7rUtkmSj31qUn9NO
         946Oxq/ObdQ1Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3276C60A4D;
        Thu, 24 Jun 2021 16:34:06 +0000 (UTC)
Subject: Re: [GIT PULL] perf fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNQt1LsJCi2C0Aa5@gmail.com>
References: <YNQt1LsJCi2C0Aa5@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNQt1LsJCi2C0Aa5@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-06-24
X-PR-Tracked-Commit-Id: 7f049fbdd57f6ea71dc741d903c19c73b2f70950
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df5011000496355d8508d56cd3ce45b1196b8b43
Message-Id: <162455244620.8751.18116199346021866914.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Jun 2021 16:34:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Jun 2021 09:01:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-06-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df5011000496355d8508d56cd3ce45b1196b8b43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
