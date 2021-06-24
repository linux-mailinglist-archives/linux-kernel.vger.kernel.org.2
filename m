Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34A83B3801
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhFXUmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhFXUmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:42:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EA767613C0;
        Thu, 24 Jun 2021 20:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624567196;
        bh=DTaOpIVhVoM4wbhvsj7YKsl1LWfgOZIoAHcI3KKXxt0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nHDY1ivA9YUorTOilClr/wS6XniLpxeQxySxMlAzwWKMkDDJT0fKLUU+oKam2SnV0
         6LZQXqZo5pHExSUYs6zlL3QTu7tgUlFtNNCHux/htQqLxUlY9Gc9dhMOnKIxjIaLr/
         i39+V/cn+sFbZsz4P4Vx6d7etJaibQNOAfTxBOvo/Myvuk3m6X0sPOJlf7QP9utrSj
         ywv+UGf1rRFtAYHq9/Pn7ph4zHkNRTBmQkwiLmiHe5CWE1BsFOWirmPuFQTUX77ZLn
         WgaiLi8AyvyVkXRGfG54rpKab0abEi8shQyxcJaNuo0A9TuuLvZhRlQIk0RFhqm6Ze
         SkaW6CVV0Ai+Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D794A60A2F;
        Thu, 24 Jun 2021 20:39:55 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.13-rc8/final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty9+nYh5JC-gw5Pf8u1QaYwr2PFcOKobohQz-RGaCP3mw@mail.gmail.com>
References: <CAPM=9ty9+nYh5JC-gw5Pf8u1QaYwr2PFcOKobohQz-RGaCP3mw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty9+nYh5JC-gw5Pf8u1QaYwr2PFcOKobohQz-RGaCP3mw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-06-25
X-PR-Tracked-Commit-Id: 5e0e7a407675d9f50f1d840214beaec42293b79b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44db63d1ad8d71c6932cbe007eb41f31c434d140
Message-Id: <162456719582.2537.6774197958738573385.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Jun 2021 20:39:55 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jun 2021 06:17:22 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-06-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44db63d1ad8d71c6932cbe007eb41f31c434d140

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
