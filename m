Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDB53F34FD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 22:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbhHTUKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 16:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239281AbhHTUJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 16:09:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EC8856115C;
        Fri, 20 Aug 2021 20:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629490159;
        bh=ge24DmoJYW30k2kXJzTVKBOQkhKfNge/n2Wphj+L7cU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LWSqjQBnp8hvSuWgDd4birELGCoK/GTJjC1mKyAlmWz1sIYfVITjarM/+74pd4bT0
         Ts2hOAY7eBL6OL/paOfXDKoXstSQ37QH+kwd7I+UO/yNkdyRiSJJyOm+bTTkz+bTiR
         WZgBFuyXx2gE1MwQNmdz0SVX9nUmGsuhuXFnlouNqFADZbR1yuXBPZWcptTPWmwFND
         bygTG5DEeu7i7RYfJvQ9G0LGEXmO+PUN4izw2a4u7kqtjooHUpvnskLAn0bvHlU0+m
         y2GeSo2EKswrJeADcQfsoEeRM5xw95ScgGNyjcV7LmZTf1uiWhgEfBdlcSnuPW01yA
         02WZjBjhoDkEw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E634560A50;
        Fri, 20 Aug 2021 20:09:18 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210820132234.318026-1-ulf.hansson@linaro.org>
References: <20210820132234.318026-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210820132234.318026-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-rc4
X-PR-Tracked-Commit-Id: 419dd626e357e89fc9c4e3863592c8b38cfe1571
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a27c75e554feb63a0e72b9479bab0b49600d1410
Message-Id: <162949015893.21370.12178974282322515078.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Aug 2021 20:09:18 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Aug 2021 15:22:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a27c75e554feb63a0e72b9479bab0b49600d1410

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
