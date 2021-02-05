Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB7431105D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhBERIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:08:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233748AbhBEQcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:32:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2B6B364E77;
        Fri,  5 Feb 2021 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612548788;
        bh=/csbrMk6+VPCOiPQdvh2c2U7qDcJN+0+pZkFb5TOuik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vJJfi0nvEVWZzMP7zSx1K1UgpTndi1L9HD1M2nQvkOUPw7z838JZeELf40/Y4/ZGq
         l9pesXthQPxNt+4bzFU95c0V4NbMg3OcFugbJ2tYLpOSKPG/KQzB/e8AtWKzN3O9p/
         +7LQ0GNzQpVkAYKiLcSDGZREJxwTZhS9efvMh6n5Z1Gg9gY9oG48DTcNvEg+DaGOlW
         Y6J5tC85R0XVv0RJfU+mL5GBv+c+kIXO+ZX9o1+xS3Q+hipPPake6bLArpeWDcgKLJ
         /nGboAxsUr9Kckr2pOQbXyi7IMqisSHtjQq81k1acNyu056bI6T6N3DS+q9VyyOryy
         sr4Ug0A4BRznA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 26574609F2;
        Fri,  5 Feb 2021 18:13:08 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210205134345.117659-1-ulf.hansson@linaro.org>
References: <20210205134345.117659-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210205134345.117659-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.11-rc6
X-PR-Tracked-Commit-Id: d7fb9c24209556478e65211d7a1f056f2d43cceb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d8bdf5906580daf72364e0dac4517ac26d5b05d
Message-Id: <161254878815.14736.12999277617486435826.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Feb 2021 18:13:08 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  5 Feb 2021 14:43:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d8bdf5906580daf72364e0dac4517ac26d5b05d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
