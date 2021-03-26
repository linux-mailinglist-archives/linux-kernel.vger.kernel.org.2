Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9788B34AEC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhCZSsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhCZSs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:48:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2AD6461A21;
        Fri, 26 Mar 2021 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616784506;
        bh=aZxBOKUsHqL3lGH0KC2toVv+7HygHF69Rr19gkemfDI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YDGJCW3zVi/YKFDxxZzA2kDtZIaNUR95exWdx/aQwsvDSkkR0QmqzL0UQr/G9SihI
         8JaAsId9mF8r3pKDxLKq39GdCS7hwPGQMYlPruFg+8rTb5uhNbsN1HAUISg5C6Jsuy
         OrufHWP9cAMk/JSvemloKK7dm3pwCxiYz+O85gZJhSTA7TJ2t0TDsBOlVApaE1OJCA
         Qlh0AfdFRXOXLNW3+iF6NlgDpowHY4uAvFgAO0Rg1X9AlgUHn4b6mfYquu93Ht/JZk
         TZoQ1AP95+ExMJxxUobQkMCD+nzUin2XdOXW2PZKH3I+v+uSMmXiIrxvjGwSuodZzz
         sRL59OJQYi0zA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 10C0060952;
        Fri, 26 Mar 2021 18:48:26 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.12-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twkAXygrutCExSdhRh69Vvnr0X7HagQw8WQGZgC_UdTGA@mail.gmail.com>
References: <CAPM=9twkAXygrutCExSdhRh69Vvnr0X7HagQw8WQGZgC_UdTGA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twkAXygrutCExSdhRh69Vvnr0X7HagQw8WQGZgC_UdTGA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-03-26
X-PR-Tracked-Commit-Id: 09d78dde88ef95a27b54a6e450ee700ccabdf39d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f944d061f847b0ccf0ebc095b5a6ba9ea9caec4e
Message-Id: <161678450606.8437.2284982485967975024.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Mar 2021 18:48:26 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Mar 2021 13:34:03 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-03-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f944d061f847b0ccf0ebc095b5a6ba9ea9caec4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
