Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F3F3BA53D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 23:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhGBVuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhGBVt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:49:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9D380613FC;
        Fri,  2 Jul 2021 21:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625262446;
        bh=dt0Uq9m23UqZKIIfgUp7yjZd3OZUmiA+H07EWR+B8Ns=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nM8PHk6HjZnSImA7rkgQ7cquHU796KXyjlY++BYfHDqWv/AQ+zTnSppUiMEVmtvuc
         2IilplP4twN3QOmup9Xkc1HxA1XrHfY75mdZWpSWFefc25TR2Jpkflg8YAItt9viPz
         p+HXSQLvuIq1KD/8Delmb1E5IkBKpCWM9TkPVdZJ84Qxk1YGNlR1bYcg4d5CjjzoOb
         oSUEY9juX6TFJPyx/Rwsza1yCMbQ2T5KFR9Pa2OxKQtn+mkitoVoxlMFqo/i0eyNd6
         z97gzyPFjpg6eSrbHIiXoF5aZAlxAIDtOT+W95ESsztGHRrXqYOzcmj2oavYyyzG/M
         tpIrhHM1oy/FA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9769860283;
        Fri,  2 Jul 2021 21:47:26 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YN85ebItWEBp98jL@infradead.org>
References: <YN85ebItWEBp98jL@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YN85ebItWEBp98jL@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.14
X-PR-Tracked-Commit-Id: 2b4bbc6231d789f58676d2ccc42177df163e1c4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e72b069609aa76cc1de35f5d434dbfaa5392ae9a
Message-Id: <162526244661.28144.17308914428564456116.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 21:47:26 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Jul 2021 18:06:17 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e72b069609aa76cc1de35f5d434dbfaa5392ae9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
