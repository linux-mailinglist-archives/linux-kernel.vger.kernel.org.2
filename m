Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C79036B711
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhDZQlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234607AbhDZQlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:41:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9AF7E61059;
        Mon, 26 Apr 2021 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619455221;
        bh=KkSjJH0wL2cjBgyOt/kZlGHrC3ofwaVN4BdMlgnTnDk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g4dJwKDHkLdW56vxkmes0DgPsN/PJp+QpVAZMNzkX90WhvSOwXOxnmSQyKKUjR5y3
         LPSPRHmBdxALOPCeUqo0a7jFMswdAk9nPim1c9X2t1N+h0bAe4Bsr7UOwG0joVb8Rk
         vPARMJFz1SHdb3up+nRdFSmkD4q+xHQQjy0qsx7Zq4alMbzx39Lf7JSEO3N0ldwfHU
         ZZktj8FZTC1JFINN06K5SdRMMRc135ZMlXxxSyd2CesnmJolDmu1PCYeDD0lns4CYy
         cdo4/2owx9roIqg5PM8E+emsdo2r91Xz8qAO53T6hLbRPf2YtggFhEZczr67ou6J03
         2u96OF8IMYoxA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 916D56094F;
        Mon, 26 Apr 2021 16:40:21 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIaZ8y+xn3PcbnX2@zn.tnic>
References: <YIaZ8y+xn3PcbnX2@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIaZ8y+xn3PcbnX2@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.13
X-PR-Tracked-Commit-Id: df448cdfc01ffc117702a494ef302e7fb76df78a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea5bc7b977fc7cd2be4065ef41824adc976c807f
Message-Id: <161945522159.27394.7964533679149778747.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 16:40:21 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:46:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea5bc7b977fc7cd2be4065ef41824adc976c807f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
