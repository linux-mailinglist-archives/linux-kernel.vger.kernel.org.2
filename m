Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9068373388
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 03:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhEEBSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 21:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231805AbhEEBSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 21:18:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 47914613C4;
        Wed,  5 May 2021 01:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620177445;
        bh=3p5VRw0+pja2UV0fTssJznxZohjeadteqcIHh5r7UtM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hp/Ym6goEZW00BvkPPBBJke88WNVSoluZulAsrlGL+4L+UjHq7RK0Tr6YOU8XFBM+
         OIyqwhFw4nDZ09xJBYenNYhvBe3VoviA2rv1bm+ZW3VdpYpX6L+3VFB3QqL9PGaMMp
         Knrvhv+ifAuimn3XRMgwWF2CMHw6IFQ14suxa6Ryi5sK9UdIW0SimXYzyJbul8UNhO
         KLzFWz46JAGnjmG7+Qq8Kk0HJ7bSX+ZyJdt+EAsU9qreXS8BXJYyNDsFPnUtgKBlzD
         aeI7C+gEFaRvaB0rQFgefCz6cOx+IHSBY8TmFc7emmKyMiAFIarZLJB+i5Roo2Zyqi
         4m7l+knzmW8VQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3B9E4609E9;
        Wed,  5 May 2021 01:17:25 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1774500012.55581.1620159368372.JavaMail.zimbra@nod.at>
References: <1774500012.55581.1620159368372.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1774500012.55581.1620159368372.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.13-rc1
X-PR-Tracked-Commit-Id: ed102bf2afed226703eaf85a704755bdbea34583
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d665ea6ea86c785760ee4bad4543dab3267ad074
Message-Id: <162017744523.16566.12478026286126646878.pr-tracker-bot@kernel.org>
Date:   Wed, 05 May 2021 01:17:25 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 May 2021 22:16:08 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d665ea6ea86c785760ee4bad4543dab3267ad074

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
