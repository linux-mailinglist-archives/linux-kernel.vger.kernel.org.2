Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65C036B913
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhDZShK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234275AbhDZShD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:37:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DCE78613C4;
        Mon, 26 Apr 2021 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619462181;
        bh=2cJdLhrEyuaJ5FuyaUgcAcosv/qImhe10mqUPjMf/mc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=olDvyIeFuB0ys9cc9FUpI/sSiDoqetjk3aY2YrxXf1Ky5vmv+l4yMbaT43hntp8x1
         9/nmx8ay2oT5gg2Vs+5q0uDRcSTtoMcbHyIrSuPnGa1pd9vBytBRge+enrLbIUYauo
         w/wUcW4g3M/wiZMWKs65m03mSDYk4GkbiY3yBHCO7jGbEhzWtrcCkpUm07fELXBqh4
         yqNYw5Hy7QJGz6Pfg19fwEYCk92E96QKrGE31O6QQSmCUWXWP+4263cCTaLqBj5Oui
         YC1zh+n0rFYOfV0KmU4yuDtb1swKu3fvPw8ymDEUZlCKdndCqVkKhAICykMUtKCGrj
         57Ux0sPlpwfug==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D3AFE609D6;
        Mon, 26 Apr 2021 18:36:21 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIa0iifkxGDmlG+8@kroah.com>
References: <YIa0iifkxGDmlG+8@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIa0iifkxGDmlG+8@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.13-rc1
X-PR-Tracked-Commit-Id: a943d76352dbb4707a5e5537bbe696c00f5ddd36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c01c0716ccf5db2086d9693033472f37de96a699
Message-Id: <161946218186.19244.4462046819810230251.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 18:36:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 14:39:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c01c0716ccf5db2086d9693033472f37de96a699

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
