Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8F2426F72
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhJHRWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231215AbhJHRWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:22:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C505360F6B;
        Fri,  8 Oct 2021 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633713625;
        bh=jopKWbw7A8/2UPsH+ng1ZLMcJpnvl4Z/WQzHrR8gk6Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eVz4PyUZPk4kQtHrPQR09pmj1wDkS98ivlVsfIQPJGB5YV/ZLfoP0w3Hztg9b+y2o
         e87+7mD+mfXYjwnHAUAuXHi31TJuOfNd6iWJaQbHoUt1bmfrE13PhVOVmHT3nGqMiF
         Nr1Ujq1h7hbbFPsetuUVRR5ypzvSBzp7nhXfrYxGA1zfN+19WwxaNrYAuo6jQcXRaG
         8a1e3vFPynWr7NnpqWm1/R+Qrl2KSrHBPwNLDRglzfOdH8B098wI7oGtr2js5l2f0u
         ibOfXIS7gcwIWPbXTUFSOanDY+I4mWgTTWIX7jG7zt0g1XcFMKxyX9emThdW4WtiBi
         sM2v92iSivPdQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B17E860985;
        Fri,  8 Oct 2021 17:20:25 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txCVSSAQF8f_wR41sEBh_NjT-VSkbod6Pxcwb4dHu=WBw@mail.gmail.com>
References: <CAPM=9txCVSSAQF8f_wR41sEBh_NjT-VSkbod6Pxcwb4dHu=WBw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txCVSSAQF8f_wR41sEBh_NjT-VSkbod6Pxcwb4dHu=WBw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-08
X-PR-Tracked-Commit-Id: bf79045e0ef5f0fb2a0619f9d0782665d07b2d66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0068dc8c96688b72cc99470530b384429129950c
Message-Id: <163371362566.20952.16722002714497226730.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Oct 2021 17:20:25 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Oct 2021 13:42:41 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0068dc8c96688b72cc99470530b384429129950c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
