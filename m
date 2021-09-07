Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0CD402F79
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346347AbhIGUPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343748AbhIGUPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:15:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6AFA9610E9;
        Tue,  7 Sep 2021 20:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631045673;
        bh=UVMS4EA8BipwKOkSed374Dsga8+L5OeSkV06MHOHs8s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZcMndR/vDH2xmt8Y71ZEJATWsY0fkGsAHTEMrZMW53uqitul2fpzvK2b5AKRg0Cp2
         MvSLLBBP+XlLOZJf47NPbYOGSNjK0Hdo/y0NvIdsgLLuaaw87ZEE0HP38DdK3pKOfU
         Bzsyez2pYrgV0eU8437Lrx5pw/22A1zDbYOEDuNxOZfMp5qvXXJkPA0xQQunIi6gAw
         iTCg5yg3wR1QM8p7Ggbuptb2NbeMGiUCsH2DYCXauFNADiWNhqJv8b4x4/VGC3MJC4
         uQQSfREHVa7S1OCY+HUXTzBJhPQCj84J8Y9pOeqfZLT9Z5ZUPdMWn0rSsKyqOlYOg+
         yS4QBc1arhZ0w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6384B60A38;
        Tue,  7 Sep 2021 20:14:33 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210906160056.j42y4rrtmvjb37hc@maple.lan>
References: <20210906160056.j42y4rrtmvjb37hc@maple.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210906160056.j42y4rrtmvjb37hc@maple.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.15-rc1
X-PR-Tracked-Commit-Id: f8416aa29185468e0d914ba4b2a330fd53ee263f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 996fe06160998a38ff07189feb3ec8ab8f68fd4e
Message-Id: <163104567340.21240.16620446640493146190.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Sep 2021 20:14:33 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Sep 2021 17:00:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/996fe06160998a38ff07189feb3ec8ab8f68fd4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
