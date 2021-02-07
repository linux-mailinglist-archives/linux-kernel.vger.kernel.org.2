Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65636312733
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 20:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBGTX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 14:23:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhBGTXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:23:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AC23D64E3A;
        Sun,  7 Feb 2021 19:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612725789;
        bh=IeP1OvJ/k8x8gikOH5SEUORTPYx4qLXqVQVQFSsRFhs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jok/F8hus0w+lI/pk6NY5unYbH9BETlJf84sibD7pwN2m3bUi08GWmqBrYet4Dlig
         3o9AINusWTpxCCP5P9xkqNL0wURU0d2CghEdYDTZ5Sgl/OOSpIikT8EMkRgvFXl6Dr
         4TjBFlsqPk89OOm5nQ9L0HqeOyNo/PSwa0xmTWNBKt8D8anSnyVIIlUx4YfyDjrWzH
         Jc7qhVfpdUezfZmWoyva3SehDSSAFJnlh5K1edtdBVb0NNIYh8HmMXRau2vM2VZIYQ
         6sYdV83Fwr9L//u0pZ17zuZPX7Wlbbx2+Cb2P2XzF2rS0yzm7IeTSnDB4YBB+9smS2
         jackFgYAhYuuQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9BD0060A0E;
        Sun,  7 Feb 2021 19:23:09 +0000 (UTC)
Subject: Re: [GIT PULL] libnvdimm fixes for v5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4j++J_ra8zWkvVovmwmYCERp8vKsVSZn9x4PYGoJa-XOA@mail.gmail.com>
References: <CAPcyv4j++J_ra8zWkvVovmwmYCERp8vKsVSZn9x4PYGoJa-XOA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4j++J_ra8zWkvVovmwmYCERp8vKsVSZn9x4PYGoJa-XOA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.11-rc7
X-PR-Tracked-Commit-Id: 7018c897c2f243d4b5f1b94bc6b4831a7eab80fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b75dba7f472ca6c2dd0b8ee41f5a4b5a45539306
Message-Id: <161272578963.18997.13576347206696291411.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Feb 2021 19:23:09 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Feb 2021 09:37:21 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b75dba7f472ca6c2dd0b8ee41f5a4b5a45539306

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
