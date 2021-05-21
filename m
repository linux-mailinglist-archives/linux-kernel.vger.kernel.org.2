Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8519B38CB20
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbhEUQgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237395AbhEUQgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:36:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 16CDB613E6;
        Fri, 21 May 2021 16:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621614888;
        bh=xYpb4gyKseV64RajILMPIRDgYSNJeMMS1yswPaXbBWE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hlfIv3CYLw2lBlf6O4trnR+KCKxuKWBgAtULNtrN2SvVUPz840kkm1UoqAMXA306T
         KxB6vLCynMLn6cdqC9DYBD6E9s3JbaCIbrKkFzSR38eR44W9LKbqfu0wjw4QugjjAS
         eu9rL8JGRQ+bYelHqnJsbATAUmkhKOg+me2qOtq2dNoCz+c2yq6psPKW14jCLuia/f
         csHgs608uTPM81nU0FWpMMlra9tYQn1sRLMGakeglKD6KP/9UdKuyMvrKNEbRyC+Ml
         2xbjlCRvVC4vWSTzFbP53kpIMXre95uWNbXPv1lQr9Joold+pQMXksRFGls2LOOWEQ
         AfEPhaoqYMtfg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0CE726096D;
        Fri, 21 May 2021 16:34:48 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210521102540.104166-1-ulf.hansson@linaro.org>
References: <20210521102540.104166-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210521102540.104166-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13-rc1
X-PR-Tracked-Commit-Id: a1149a6c06ee094a6e62886b0c0e8e66967a728a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 011ff616ffe8df6b86ee54d14a43c8d1a96a6325
Message-Id: <162161488804.28405.14172591769191127057.pr-tracker-bot@kernel.org>
Date:   Fri, 21 May 2021 16:34:48 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 May 2021 12:25:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/011ff616ffe8df6b86ee54d14a43c8d1a96a6325

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
