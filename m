Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F16836BC18
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 01:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhDZXh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 19:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232022AbhDZXhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:37:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7F1BD61182;
        Mon, 26 Apr 2021 23:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619480200;
        bh=/cGa2QFpV0d7iEWYPe+I6Rqxjh3z/483JbkYBMQI6Bo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tkwiv7w+fzbU8JY1bnTcC5NP2hFdrjFSm6IgQNiQw6axVL8skmYBDY6CnHq5eJ6bX
         yjV8UbCNms3egenF8AFNd/Qdk/Dmtl/QzgBFwCaP6Ir/l/5MqG1Pa/HRR2Szr+WEpR
         fUJCZRfuXljB3kkQRtm7f7gBpzQD2Sg8mXnGnVZTn5qsEdAKyMTWbJBHEOUWe5O29Y
         TuR8nE7xI8zQKKwfjvVkN+Sseze9oMBmlzSW8uBVfL4g4ZV5+wTzYU6MlQk+eU9H7Y
         liNKPis8ZCeaf4qwoPskcQeXj/RUWR7ghYDnpL66TMvWMHLhE9F0jDh99lR5v7UBJj
         Cr34LcFtBK6sQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 79B7B609B0;
        Mon, 26 Apr 2021 23:36:40 +0000 (UTC)
Subject: Re: [GIT PULL] dmi update for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210426124447.228ee938@endymion>
References: <20210426124447.228ee938@endymion>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210426124447.228ee938@endymion>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus
X-PR-Tracked-Commit-Id: 3cb4d29a2633170208c96240c7e85148679ceee3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e19eede54240d64b4baf9b0df4dfb8191f7ae48b
Message-Id: <161948020049.27003.5176203808703929698.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 23:36:40 +0000
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:44:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e19eede54240d64b4baf9b0df4dfb8191f7ae48b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
