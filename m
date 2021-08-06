Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C053E2F46
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242930AbhHFS12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242887AbhHFS11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:27:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1D0C461186;
        Fri,  6 Aug 2021 18:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628274431;
        bh=ZECR41FR5dWOrGhUWzm6gb4ODHj6MexAoySHsTht5Vw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r9fqZrPHBGB/vooWaXciAB0zDUu84uYq8GDxyJmrwp3SVEv1Khc2swWYSctcRzCAi
         zv1IZUmxHaK9dXM8gwgRg0P3b8prTMq/WJRwofKy7K59bgZNiqBXIKPNM9i3E1c5za
         tEv0wP2/BkDla8XgowslcsKzH2lsrIQZChqAmxC8JBKyA7BZbLEbPUXx+YMbC/facP
         5f/cBSq+JfXb7uXqKK+C6+brk7iguc98xCc2xMXTcoyXZYh2tvVc0gwCe2qfEcK10u
         J2/gUU2NhM7Eb6EbouspTH5bEDdiqSIQbuQlJBt6alv+WnuWIUGdjXzVB4YDWpRa0X
         6xWx7qYYLfUaw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 17722609F1;
        Fri,  6 Aug 2021 18:27:11 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txE4jnHDV9B2PWfieMJjdFv0C7=Zc=MovOtJ6sKN2AuYg@mail.gmail.com>
References: <CAPM=9txE4jnHDV9B2PWfieMJjdFv0C7=Zc=MovOtJ6sKN2AuYg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txE4jnHDV9B2PWfieMJjdFv0C7=Zc=MovOtJ6sKN2AuYg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-08-06
X-PR-Tracked-Commit-Id: d186f9c28008810d8f984d6bdd1c07757048ed63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1254f05ce097c9bf2872a8407725346faba59844
Message-Id: <162827443108.9282.9951648100746802903.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Aug 2021 18:27:11 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Aug 2021 16:03:00 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-08-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1254f05ce097c9bf2872a8407725346faba59844

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
