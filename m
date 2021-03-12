Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C323397F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhCLUDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:03:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234503AbhCLUDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:03:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4955264F86;
        Fri, 12 Mar 2021 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615579413;
        bh=1SyKwyDP7/NFZ7cyt8fIo+72q5l9srRxkizCRCaLHSk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vOGGbTt3jt8vZ6PV//hA0unP7Fdg5Lxij3OvpSR46FNP6Z9DAqrSuyetSchCLFlrg
         c3Tl98cuvjbEmxZGRQnY3+YrqXC2PGpmeyapyOfb43tMAAkFY2IWQtSFLVW7vwOMaC
         JOs6VjqaoUUr2FDb1XAuOh/O3lUe2j52kXC3PJGOmqJut9NTG8XUbcqlBFhqfwsubx
         L6afKODxZ9T4ewo3KGd1vcRDda+lyEKvyp8FLxVlz+9PyP3YEu4i6n7gX3xmc1CH12
         7LY1qr0XPLx88XCVWfffOWi1zki8lRxDwB0KKhP6BRedloEbxCwbZDwPhinEeW5Z9X
         QlFcv7oTKU8ig==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 43F2A609CC;
        Fri, 12 Mar 2021 20:03:33 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210312110237.174917-1-ulf.hansson@linaro.org>
References: <20210312110237.174917-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210312110237.174917-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.12-rc2
X-PR-Tracked-Commit-Id: f06391c45e83f9a731045deb23df7cc3814fd795
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 568099a703de7c31b02d3cd9e26e6f88fffac28e
Message-Id: <161557941327.10515.18264007690295373126.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Mar 2021 20:03:33 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Mar 2021 12:02:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/568099a703de7c31b02d3cd9e26e6f88fffac28e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
