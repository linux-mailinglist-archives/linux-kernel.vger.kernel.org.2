Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C372943E8F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 21:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhJ1TXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 15:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhJ1TXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 15:23:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E132760F58;
        Thu, 28 Oct 2021 19:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635448881;
        bh=boEPKV+7Ftz3gkNK/jO4Gx0Xi+1CSojLzmdTtYckchI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uCqkSb8o1h201kCumuWtjinTkRTJRb18e9gWIVE9kNkqbWAn/H34g+Kruh+VO13ol
         mmvrZUzvKfZG/FbnSXfgtiG1otjM3/Br9ZSrY+ro62KBYqDgHcIfWAYxTSgqzwuLLg
         uJo0cLfMvHtAHjHfaZx36ed4x8GELijSAZXlb89UJ7Wsh3gByHI84tEJ5m1yRZJOET
         46+AxTILSO23jv7RgnOFLh1DhG+O3YXPkiijQ4XrEp+syOiwyewjA9ZtgWzclnvHwX
         Ssn9GVAuYT8MoE/JfBKuOiY9LCfXKamRWoyVbTaGTk+jn/phD50WgaZMsX8M6veIs7
         CsWEo2LUOyc+w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D22A1609CC;
        Thu, 28 Oct 2021 19:21:21 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.15 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw2U8mu1H+yCg=eRvoWOJXu7FD81doH+qQhWt-yznRSbQ@mail.gmail.com>
References: <CAPM=9tw2U8mu1H+yCg=eRvoWOJXu7FD81doH+qQhWt-yznRSbQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tw2U8mu1H+yCg=eRvoWOJXu7FD81doH+qQhWt-yznRSbQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-29
X-PR-Tracked-Commit-Id: b112166a894db446f47a8c31781b037f28ac1721
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f31531e55495ca3746fb895ffdf73586be8259fa
Message-Id: <163544888180.5393.3156294262224416081.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Oct 2021 19:21:21 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Oct 2021 05:14:19 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f31531e55495ca3746fb895ffdf73586be8259fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
