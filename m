Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8215F3B682D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 20:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhF1STp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 14:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233965AbhF1STl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:19:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 084EC61C3D;
        Mon, 28 Jun 2021 18:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624904236;
        bh=shqqhxSbfMHm6DFpnkFnzpy/2c6WbxJ44e8xJ8kV6nM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MUgLV4ruaYLyfPOsAQ0XDfUaviwUrZDFGjdtur60YErw+olk5tG9sbTO2+Y8OuVTQ
         rfh3frZV6XoyweL8YoBiUqmf22IIpHhfdJ8luSchFhGW7i9qSEqlQ6GcSwu7nTme6k
         +PLpLGnjjgs0tnW4h8AaUW6zI4/+6dSv7hvbsF6qC+LP850pvsn8FotWSe5CRsAtbb
         Vm5Ix8pKBuvab4bbQprTHNSxalqsltyBfZ1FUfCnt63EQzaZZLn7UjD/cEEO+JMExE
         OSnvcS6W9+Cvmp7K7HkDGHH2EVlx/umbLNGXcb7/Et0TXnm/0xRJuz73RTng2k/Y8W
         HA00Dlv3e0hmA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E997360A71;
        Mon, 28 Jun 2021 18:17:15 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210628101944.205357-1-ulf.hansson@linaro.org>
References: <20210628101944.205357-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210628101944.205357-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14
X-PR-Tracked-Commit-Id: 98b5ce4c08ca85727888fdbd362d574bcfa18e3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef60eb0eb6e0aaf0aae302cb6362a81b2491e997
Message-Id: <162490423589.3852.1520696636725472554.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 18:17:15 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 12:19:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef60eb0eb6e0aaf0aae302cb6362a81b2491e997

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
