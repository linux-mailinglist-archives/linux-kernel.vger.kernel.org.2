Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9144B3BDE00
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 21:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhGFT0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 15:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhGFT0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:26:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0F16061C9E;
        Tue,  6 Jul 2021 19:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625599445;
        bh=njMuHRoqOWTwzOoFyErmf0x+EjKyb3uy1ZDx+GYv22I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EhW67GuYXVmQvySfCsqKTXcj6aMKzKURiSkdDXGtPCP2x6GDRsuaF2RjhQyeMqcKl
         BmFMrR4rK2OlCjsybexioWarIpU94WtUjaEaUQaXufPVu5dPR9F4hgruFooZwMOCh5
         MaqubrZBSbyHLC6hd+t21tQ/TcjGgb8CSCtfcSFapDBMw01P9oayve6gllHsnCNxn0
         aZ0JTx9ECHqDtmd6HDLuGz0ul10qy3ygCqARTl7fBnvB3qxNK3F5UifJiWzyzclZD0
         9UecKOg+y3mAgfLp8oFR1wMw5BniSLpWYOIpKqVlSApKhwqiCVCbuUu+30Pn6jGEEQ
         8Geb56BXA3FnQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 08F1960A38;
        Tue,  6 Jul 2021 19:24:05 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210706101508.4jha4mm6kbcdpvdt@maple.lan>
References: <20210706101508.4jha4mm6kbcdpvdt@maple.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210706101508.4jha4mm6kbcdpvdt@maple.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.14-rc1
X-PR-Tracked-Commit-Id: c8daba4640ac9619f9cb34ca7c314ff1eaff5f33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df8ba5f160335cf9ea09c0a037235331a171fe1a
Message-Id: <162559944502.10101.3116238733417264710.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Jul 2021 19:24:05 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 6 Jul 2021 11:15:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df8ba5f160335cf9ea09c0a037235331a171fe1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
