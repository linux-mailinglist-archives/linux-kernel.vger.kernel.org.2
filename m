Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011533B78F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhF2UAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234953AbhF2UAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:00:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E259E61DAD;
        Tue, 29 Jun 2021 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624996661;
        bh=R/FDhStjpVpWUF/GcI455rU8YDezpZk1havA6yzDxns=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SstnPzpAFbLlgnjhK5DD/FwcrCjMA4axb9y3ecxlmUDnbX4pgFG8FHT5qtJ3u6qRB
         HWpqTygvaC9WPQVUXGCOvkUbxvEftgK9DCvTcrp6sUb6qs3+Gh9DwplV3e9/Xet4ao
         KTSZjD2sTxw4VqojiCToXuSvlbZ5KLq+g0LSeFpJYwswkB93Z8/5dfAF67X+7CcYKG
         ihtDops4SHtbVuINEXguT/iye2wlCJ4hEKwHgLwxCF1OYP4fDWCXWxkHNWmq8clnpR
         jd82O5Kz6kE/8u0428dlvgktJ0V0CU+huMM7BM4XTNVdbYt0Fkz9ISWet/yY6/5KCJ
         QUh4afS0A+85Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DCDDC609EA;
        Tue, 29 Jun 2021 19:57:41 +0000 (UTC)
Subject: Re: [GIT pull] smp/core for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162497731335.6531.6983356866447421688.tglx@nanos>
References: <162497731214.6531.6083197571290189651.tglx@nanos> <162497731335.6531.6983356866447421688.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162497731335.6531.6983356866447421688.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2021-06-29
X-PR-Tracked-Commit-Id: 130708331bc6b03a3c3a78599333faddfebbd0f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 371fb85457c857eeac1611d3661ee8e637f6548c
Message-Id: <162499666189.30376.9740234365482376237.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 19:57:41 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 14:35:13 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2021-06-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/371fb85457c857eeac1611d3661ee8e637f6548c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
