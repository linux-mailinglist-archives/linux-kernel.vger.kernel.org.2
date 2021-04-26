Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB1336B70A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhDZQlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234522AbhDZQlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:41:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 15DD1613B2;
        Mon, 26 Apr 2021 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619455220;
        bh=ddCCJmRyeAKmUzdUcdQIIKRLJxJcFFHg7XNRHSWlX3E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oNivu/bcXza097Ajr0XV6PuPZx/vw6fzVr1xJVGdR2LEYgT1rbzYhc+tg11c3w8e+
         U4g17N8tUBOdpT86XQL/5ghxrsRuFtBwHbALtpWoBYtpZ8h26qyX0gCWdIg7pdFuuM
         sU7vSmFjo3nGNiRkAG1GgfMrRLF5ECcXibnExBWD0aMb+F42K7Dj1eTOgAfPai7CIO
         QE7ili0KgwkyyRMqvsW6H4sNNOPoerVU1E2uUkEoLmQ5JqbSOLfOX49xBKSiUWm2Ru
         Zcx/HaGfz+SCmSli+yQk9mdnIZPjnQZK3BqD8sEezxVz4WawGopA0rbfmXwRbvKB6x
         fxMrTO4mhn1kg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0F1586094F;
        Mon, 26 Apr 2021 16:40:20 +0000 (UTC)
Subject: Re: [GIT PULL] RAS update for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIZ//qeE42t1Sr+D@zn.tnic>
References: <YIZ//qeE42t1Sr+D@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIZ//qeE42t1Sr+D@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.13
X-PR-Tracked-Commit-Id: 2ffdc2c34421561c12f843e497dd7ce898478c0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c532791802223560f86e3864dbafa3a6d9d008d
Message-Id: <161945522005.27394.5759171712377008353.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 16:40:20 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 10:55:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c532791802223560f86e3864dbafa3a6d9d008d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
