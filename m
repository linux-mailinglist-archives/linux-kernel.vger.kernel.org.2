Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E093EAEC4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 04:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbhHMC7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 22:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236112AbhHMC7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 22:59:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B6B586104F;
        Fri, 13 Aug 2021 02:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628823561;
        bh=2mP6bHER5L8GFr2L6n7KngpM81WlcQyUwKcCxJVWYCs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ksPjyVWC4+hTjX80UtULkcTRqNIVLrex2NAVd4HY5QY/P8QbJSoou4a1+7slCTYaG
         XCWAvcF9cSjDFkPF0cNLeE5S9E5YTe54/puV844qVlyW2mbV03LFhLAdG8TK99Tomy
         wzPRyANr5e0HlADLHcXr4zOli29prik9BzV4Z2q94ikSdou6nEZWqb8CetSfSKGner
         dDcb2CXJrxB/ItjlNMO+9MKaWgsds3VlR6KpHjwsubGamteNHXJyz9nbswB+vGKiAQ
         KP8utD8wmj0UXv/yos3d95JnzmuHYyNyXGBpYWInB3agfYYRxyRoxTp1A0T1gkDzxR
         7i/uhuy+2hMNw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B040960A54;
        Fri, 13 Aug 2021 02:59:21 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txa94qbYbskxeTA=8YvkFE+0AMK8Mow+KYV_xkfCfQSzQ@mail.gmail.com>
References: <CAPM=9txa94qbYbskxeTA=8YvkFE+0AMK8Mow+KYV_xkfCfQSzQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txa94qbYbskxeTA=8YvkFE+0AMK8Mow+KYV_xkfCfQSzQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-08-13
X-PR-Tracked-Commit-Id: a1fa72683166b3c69511d5f2ffb37b9f49f48fea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82cce5f4291e089d44b7b9bc77918cbcd52d429e
Message-Id: <162882356171.1107.16837001218540200538.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Aug 2021 02:59:21 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Aug 2021 07:06:07 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-08-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82cce5f4291e089d44b7b9bc77918cbcd52d429e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
