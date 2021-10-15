Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6F742F584
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbhJOOhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237347AbhJOOhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:37:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 88DF66121E;
        Fri, 15 Oct 2021 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634308510;
        bh=axrc1xIMt67MrEWf5dtcLcckXcmWxB5K/geLtccCS+Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e4SWpnoPcVEGMi+seluqeeb+ZFE1VDZuX2L20EU+U6wqXlwVfssR419D+NyqTPD4g
         RPTfF5LicvvZ7P02hHWjEc0paMSv46Ebjq5Wu7ISlO+KBQRu8I1NWi6/o45NJZIkW8
         A3Ji230OmDm+SM9r93dplIFkGF1HlBawh/qBXOhB3D9xoN2QCTY9RFx81Ffjl2mXIS
         QCZxZsWXni+FON72Gb9SOXJa8JfeNTbl+TtkA1QlQuPqktqjXAGVDgX+mAx6xyd3nV
         a0aZ0+FrtXOK3KkaXGJVOKjdY/R0V3EUKnTthMcfZNLZnWd4NQrNHTVD7+VynMwP20
         jao9Y0YtrFHhQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 83A8D60A44;
        Fri, 15 Oct 2021 14:35:10 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211015115739.34F38610E8@mail.kernel.org>
References: <20211015115739.34F38610E8@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211015115739.34F38610E8@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.15-rc5
X-PR-Tracked-Commit-Id: beb76cb4eebf9ac4ff15312e33f97db621b46da7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccb6a666d555652232e845352b9ff7217aca85cb
Message-Id: <163430851053.21069.11303844657677048117.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Oct 2021 14:35:10 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Oct 2021 12:57:24 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccb6a666d555652232e845352b9ff7217aca85cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
