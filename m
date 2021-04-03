Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CB635352F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 20:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbhDCSSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 14:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhDCSSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 14:18:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D679061247;
        Sat,  3 Apr 2021 18:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617473919;
        bh=PY+a1N+fZF+1R0kW1kSHaP53kLviE/U+7+MGrM/eIwE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cjuF4ugfYdcyeQ43VZw1X8XGKYcLrarAG/dHsPTO05OYkihwS72ebYQvtMiRb4FB8
         8pRMwiez7DYaap/fXEiPQ+pM4QUDvatqEyyHUKe3fnhj/p6ejgMwRJDPR10LTp5M3G
         YloGJBnK7HUpPrw+Uet4zsTa+Da6n4/MPLp/yoN+L6Dq2ESWZdXveEcnJ9IYmVXkOU
         MvQ0dxX7rB+kO6zrk0uC1GD8X58uXJn1zOvawJ8r57065ySwiL8bZWniZB+4ZJEVse
         P821rTXoqlLMAjlKqFuN+kgt8djiPBo4KSyd0rcUBAH//t3h3I9QV7UfCnGfwjbuxQ
         TNU4ldcTbMdhw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C2AD5600DF;
        Sat,  3 Apr 2021 18:18:39 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871rbr1te5.fsf@mpe.ellerman.id.au>
References: <871rbr1te5.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <871rbr1te5.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-5
X-PR-Tracked-Commit-Id: 53f1d31708f6240e4615b0927df31f182e389e2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c2ef23e4dae122d2b18e834d90f8bd4dda48fe6
Message-Id: <161747391973.13474.14283872332789051789.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Apr 2021 18:18:39 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        nathanl@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 03 Apr 2021 22:48:02 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c2ef23e4dae122d2b18e834d90f8bd4dda48fe6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
