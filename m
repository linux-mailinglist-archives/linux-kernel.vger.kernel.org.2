Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510F93DB29F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 07:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbhG3FNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 01:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234581AbhG3FNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:13:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CB5ED60C40;
        Fri, 30 Jul 2021 05:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627621993;
        bh=e0fzypt8XSmgNt9fip0rFn8+GEmOFDhP8tOjiGrRCig=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lOsGKBHvLwMmwIwSHZS/0KsuBWPdLEdSItl1nTemiuWE/1cPGoorxVRJbreVCblPm
         5lUlBkEp956FdAZmwTv8GmOLlVhQUcRxOptXGmbrw7TaaG5T1hpe6EkjLhptuNn7K3
         YoguMoeuRpIPvX0QPkcLXMc1PQqYezYJFPXA68Z2UnDdwPkqx6pOfwgrOV5wZ5gLNP
         3rLOMumwvOnPEWXK2NMlYS3xB+CdOGeq7BIhAlB6bUernrieVJgvy7N8Hq4hOsU8ic
         2+SBHue15Y8+n/HGKcVaLIb5+15p157kiLYky6sC3tauulJoL+qjaSKJ9Z9iKpUf14
         rAQ2cmsTo1AMg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C569860A7F;
        Fri, 30 Jul 2021 05:13:13 +0000 (UTC)
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210729180823.GA7908@embeddedor>
References: <20210729180823.GA7908@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210729180823.GA7908@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.14-rc4
X-PR-Tracked-Commit-Id: cb163627e6d32dbaca4d89b2292788cee895b06d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c71a2f65e7a13a05f49b1d9afce6af3afcefab1b
Message-Id: <162762199380.22958.10795236092927214775.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jul 2021 05:13:13 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Jul 2021 13:08:23 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c71a2f65e7a13a05f49b1d9afce6af3afcefab1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
