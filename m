Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37453BC3A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 23:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhGEV1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 17:27:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhGEV1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 17:27:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CA6BB61985;
        Mon,  5 Jul 2021 21:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625520317;
        bh=/bhrRGAUOfNYZQjrVmeroyfTbxb7cSuYbcM4ZYPsLJI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Uh+0HcLMtg1MZ+pKouaAjpdpDOFMflpjwlL8ugYJ3LFZQR63onaZTOlernnGbaqBP
         x9fD4U0m1YQ7/EYLlTt6lda6atoXViI+dJRBB0+rI8dIDAGgPOcd3842Iw4Pc9+xgP
         9sC9VVrRFwmf4yTUdlAcnvhDGYCOI73lVjPkVcchW8Cow8LsJ/H4tcnqeIk6eqndHk
         d3oGaecu9QuVvrIlW8dke++K6Ou1sLtSPGOYC1sOMI8G8mKzJjlqj+WBPRMIl6zzw9
         VBdWPMEIWEI/lb+BfTSacXzXqFgM68N9b2sQY9PisMnwYscYKHChXLAiM16/abhojn
         D32NisxG1nKBA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C48EE60A4D;
        Mon,  5 Jul 2021 21:25:17 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver patches for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOM9TAEXx2EsohjB@kroah.com>
References: <YOM9TAEXx2EsohjB@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOM9TAEXx2EsohjB@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.14-rc1
X-PR-Tracked-Commit-Id: 6f746d485fb9188dc67dce7de63d21f0c28a1f2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eed0218e8cae9fcd186c30e9fcf5fe46a87e056e
Message-Id: <162552031779.6675.6664047973854838567.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Jul 2021 21:25:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Jul 2021 19:11:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eed0218e8cae9fcd186c30e9fcf5fe46a87e056e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
