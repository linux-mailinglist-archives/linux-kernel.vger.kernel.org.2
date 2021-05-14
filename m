Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA26380F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhENSCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhENSCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:02:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 06A4E61206;
        Fri, 14 May 2021 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621015253;
        bh=eojwiQ26h8vmPTZuwZY/BRBlQ4wX2uhb3WjrW/7cBuA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ffXCWcA3P3mq0G+oV8FS2gpY8cHdKnmrQS6pnbe3OMYOojK4nbePU4KLzbbd6dJDL
         XcuhxwG9zmuK6aEbRtRcmKKOgi9DPpArysmS+8VTb/G8zgsx5Vr2MLi1IZ5ui8TvrV
         HVTM2QOs99lQ4/0J4O6x2qkV+Wsh1Is2cqWqh/9oNhfGkmSdNUYrz9MyZV4kxElsj6
         DrMN+T8rRsTvWDVYe6bekzqtBjjhWMz3h29PLlfOuiOvhmY+PU3qszhR4OYuxcNgrm
         FLz0MOUyXiZB1GiuGF/8FgZlezbqrC9wCGwHkjjYQ+/ZNsxqkw+ovZg2ZgoVQp2ea8
         HjnKoadZ0KgVQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E895360A2C;
        Fri, 14 May 2021 18:00:52 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes/updates for 5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210514172904.GA29470@arm.com>
References: <20210514172904.GA29470@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210514172904.GA29470@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 588a513d34257fdde95a9f0df0202e31998e85c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd3c9cdb21a2674dd0db70199df884828e37abd4
Message-Id: <162101525289.30508.8118872674872429477.pr-tracker-bot@kernel.org>
Date:   Fri, 14 May 2021 18:00:52 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 May 2021 18:29:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd3c9cdb21a2674dd0db70199df884828e37abd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
