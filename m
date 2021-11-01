Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8994423CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 00:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhKAXNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 19:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232372AbhKAXNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 19:13:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 19C7F60FC4;
        Mon,  1 Nov 2021 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635808257;
        bh=HdDYjErXnFAdCKPY4lpK90SrnSHCYGt1/vQE7pVnGgI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WXY4fBEfaEsVUagjCUn40RCaaTpFmQ2JPyFV2uLquIYDO/eXAaYBvh1j+6S/CK9O6
         aLJPN+Wzr74CymU5ePvY/x6yheT3+pe0llKpltLLGx3sIyc9jjJWjZT3QB3uzOHKXo
         4hAjwnLXRYufIuGyks1LOU8cpOJVnGmOC84dzA0HZQtIettSzimbUZZ0M7HamJA6q7
         xOn+2gXwCi56sMnBHA1yXKB60vcvQEPAslE5mipOofYSyNIeI0pdgyrwc1MHnOwvNt
         j64yE0rebykZ3obx39rw9lBD/AVGLV4nnh3WrvXyykxE7Jka/vryjzeXg3netB+RNZ
         yZF2duUKDIPSw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0CEDB609EF;
        Mon,  1 Nov 2021 23:10:57 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YX/BhEUBTK4bkQNm@zn.tnic>
References: <YX/BhEUBTK4bkQNm@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YX/BhEUBTK4bkQNm@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.16_rc1
X-PR-Tracked-Commit-Id: 415de44076640483648d6c0f6d645a9ee61328ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0f4c59dc4d39b3e9fa61ceb4cf2384787bcd09d
Message-Id: <163580825704.31036.1670000803509083328.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 23:10:57 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 11:29:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0f4c59dc4d39b3e9fa61ceb4cf2384787bcd09d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
