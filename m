Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA23532322B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhBWUdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234326AbhBWUc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:32:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 48B5C64EC8;
        Tue, 23 Feb 2021 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614112336;
        bh=2XBkdhQ2vKGZ/toqaHU82p7tuJpazPFhC2DinLJ7nS8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dEVdMKYIIT0LaYtfUtaweXFYwFnIGvmzznr9Vwrg81gFvejNXI3p41uoLIVa1Z07G
         1KLHw/kCmLHgltJNzb2H5ysnrFZ0VmlElx6DPX5E2aA3pox2W5kiROgEY2wX2CoGDI
         lR3iLWiINp8zlCf23cj+DtOGRCaXxxgLO5OBLj2si0uSO7jH+Xnu2jF/uYyLSKPL1C
         Hc8ylW4f0sTIn4YGBE7vmniH7m9b6pPOSNrPW4pEotTwY41VInb4bKVzlOhbCkNGmL
         HDR48G3h9wPVbOCkFxqi1p2m/yIamfDspw0Z1AMjSg4zoARIVEGOvhda+lTZriHlT4
         3eetFvcMzWEHw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 43AD460176;
        Tue, 23 Feb 2021 20:32:16 +0000 (UTC)
Subject: Re: [GIT pull] objtool/core for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161409254266.2358.17202318838981714361.tglx@nanos>
References: <161409254266.2358.17202318838981714361.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161409254266.2358.17202318838981714361.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2021-02-23
X-PR-Tracked-Commit-Id: aafeb14e9da29e323b0605f8f1bae0d45d5f3acf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a56ff24efbba18f4361415597f145f4b5773be3e
Message-Id: <161411233627.28784.10354192556334259885.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 20:32:16 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 15:02:22 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2021-02-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a56ff24efbba18f4361415597f145f4b5773be3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
