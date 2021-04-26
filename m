Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7BE36B7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbhDZRUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235324AbhDZRUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D3047613AE;
        Mon, 26 Apr 2021 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619457560;
        bh=sK/Nuw7HBxhAcqc4xphjKKfVc7lkhds+FQ3UWumrvqw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nJdpwOunlTycIDm7IMH5dGefn2Tp9FR26GneSjtDMNHbsmpF9i6EIjpHG7nNQC9FQ
         ww/8ICrXzSvnGjCC2gBFsMNPcZVjjvryjBdOkKm7QSiaLwN60qwR3d4L6yztg6x4eA
         6uWwbzERfbzs0f5HpDCY/fF3dfiDNOlTg0yFJ9RUAFrCja3oYVTuzwKQInd8jGXXBT
         cQgz1NyAr0dVsiJEjbOtCzwNceLEwMEhmuwnuFFgkUxb2SqDAKsOgWNbqTVX0c7F1H
         GO3Ju380J3tvF+UxhcjKu54m0hyPW1RwcCn38ii3XeO61SMcQJWL0MQB5lsxK5pyBY
         3mlxEbB5A5TLQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CAD226094F;
        Mon, 26 Apr 2021 17:19:20 +0000 (UTC)
Subject: Re: [GIT pull] x86/entry for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161943945423.1498.14173718925126273942.tglx@nanos>
References: <161943945302.1498.9201552430413038175.tglx@nanos> <161943945423.1498.14173718925126273942.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161943945423.1498.14173718925126273942.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2021-04-26
X-PR-Tracked-Commit-Id: 70918779aec9bd01d16f4e6e800ffe423d196021
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eea2647e74cd7bd5d04861ce55fa502de165de14
Message-Id: <161945756082.14705.14345676075211218024.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 17:19:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:17:34 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2021-04-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eea2647e74cd7bd5d04861ce55fa502de165de14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
