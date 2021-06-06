Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A088539D13C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 22:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFFUQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 16:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhFFUPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 16:15:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EEC4E613EF;
        Sun,  6 Jun 2021 20:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623010446;
        bh=niXkl0Vdrsf5fr9Sxzd82elsqIqkXKTaUWMJDivQkSw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c8Cc1tn325iPexajbUu0b0YdbKs9JjEadiR2dINh74QlkZDGzq99YKALY4u+eQitM
         vDIEFKt0wEuGY2j7D8tE/2qw/oO0bP+XGYJ21XdtqESTGkXHlsVrKPMlPoIXMbKaMV
         NJdlHXxgJwK3+wCpXPW8NToZWtLLGaH9Xjzau5MGYwl9MMloO/JtUd7EVh7CpWL6A2
         AV3vwPgL5l+lXvvYp2bXKLxVIaDBGPBzHCDLtrxQ9ZKbr2PWkYuXyDrk3x0caUlRfy
         RgkXOjspE8m/GoiWJ90+ixul7qCucwH0XbAtBCji7GPw+MHTkDnk3Tb5J00kR1bywD
         xtWayt7/wt6+g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E717F60074;
        Sun,  6 Jun 2021 20:14:05 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.13-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fsxvf9hz.fsf@mpe.ellerman.id.au>
References: <87fsxvf9hz.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fsxvf9hz.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-5
X-PR-Tracked-Commit-Id: 59cc84c802eb923805e7bba425976a3df5ce35d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd7b12aa6081c3755b693755d608f58e13798a60
Message-Id: <162301044594.15135.3567760184583315355.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Jun 2021 20:14:05 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        fbarrat@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com,
        npiggin@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 06 Jun 2021 22:44:24 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd7b12aa6081c3755b693755d608f58e13798a60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
