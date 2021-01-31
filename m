Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776773099F9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 03:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhAaCSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 21:18:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhAaCR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 21:17:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 39CFB64E0E;
        Sun, 31 Jan 2021 02:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612059438;
        bh=pkAM2tVzKl0Pjc1PqziVkOFxEQHhxhysdUVS24QK1+8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BF/ntyLwMOfNl1NVi02gq1eFEei8JTYeEy17Y1xz789TfCP282qA0iV3S886zLXTo
         LeMOrPakc8vYQMYBTnyHGHXkdODNNI4uNfz0dNeWwY4ineHDP5PcdNSc0qlnc1hyU1
         k3NnqjMLcJy+/w0XQvJc3pp+n5DCsLFxAEF63YcFxMLuQFH2AXx8lwn4Mg9jI6/7Rj
         O0f/0aoWiYzoGOlD0ZvsXUvK5AGIb7ltmdVWlKpB2DnAjBJt43hjE0fx2kfvPiVxAi
         mCCSjfpbloMeTJ9sLVKoZNBDesI0kbD39UV+fLlk3QbVMYMTZBbZzK5WKM9wooylLW
         JGUiIhMS5e1Dg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2FB0E60989;
        Sun, 31 Jan 2021 02:17:18 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC fixes for 5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210130224442.GB2002709@lianli.shorne-pla.net>
References: <20210130224442.GB2002709@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210130224442.GB2002709@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 1bea2a937dadd188de70198b0cf3915e05a506e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03e319e5465a2da6fb188c77043775f2888df529
Message-Id: <161205943819.4129.13346730597249255168.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Jan 2021 02:17:18 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Jan 2021 07:44:42 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03e319e5465a2da6fb188c77043775f2888df529

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
