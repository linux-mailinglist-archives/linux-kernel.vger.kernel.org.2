Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72F831A5DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhBLUN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:13:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhBLUN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:13:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 594C864E95;
        Fri, 12 Feb 2021 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613160769;
        bh=a54omfQMWM2Pdr6Dt3am3kVr4GRIFSBqfzaOViCm7OM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NjSQysvXoyqxX/be3WYbUMZOE5gQKGLR5aYscJMqUQmMpSR9Zp40vb9jPjDR7lw6t
         +cBxnmlkWYlnuF+zgLmjG3wT1xwv9lybvGQn2jbCj++Y968/z2i2/OwTtq1X9lJqFV
         EP/vVkzchR40F2uD+lhu7p60+9qVwSf7ORmd/jHsOO6DAukeizN1SwJrNPWbAodj44
         fT0LAGSpdL9boKuo1TQ98I5qEUyIQ7MaEzc2F+WYhu6do6EzzhK76rBZQIJXJW32Gl
         yKi89YL+UmjCZEL0EYcPeF/bdeLn3EIKoTdACOdtIX/weajUHB1sWdDKDq55d2tHmR
         1J4/XVRDAUxWg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5504C60A2B;
        Fri, 12 Feb 2021 20:12:49 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.11 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyT7BXCT-CKZed4F+CP4Anpgb4X4LBHv4mxcvLzMwBcQA@mail.gmail.com>
References: <CAPM=9tyT7BXCT-CKZed4F+CP4Anpgb4X4LBHv4mxcvLzMwBcQA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyT7BXCT-CKZed4F+CP4Anpgb4X4LBHv4mxcvLzMwBcQA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-02-12
X-PR-Tracked-Commit-Id: 551c81853d6d3ff016269d62612e7cd0a53104ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a81bfdf8bf5396824d7d139560180854cb599b06
Message-Id: <161316076934.13717.7709085870960603486.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Feb 2021 20:12:49 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Feb 2021 15:20:52 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-02-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a81bfdf8bf5396824d7d139560180854cb599b06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
