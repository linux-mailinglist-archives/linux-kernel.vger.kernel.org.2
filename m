Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565233623B3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343490AbhDPPRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245712AbhDPPPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:15:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3BAFD61184;
        Fri, 16 Apr 2021 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618586101;
        bh=eSQcljIYl3Hgl1jZuA/KozNWi0lcW6fQwaXzi1gJR5c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OK9E8v0LHCVVLrBWXqwPVeA+bfLKSjCkxMwmRlC5YejJTi8/QaUE67o9Wisb7U3zX
         oD4uhrBAzBtcpyQJUeO4Fv4BICnQj4VSVELiDTGyOMn941ROQggGMKc04CbhkuAMjR
         LBbhHN6hMucI1GAgtZiOGTWlFNFlVB8ao06vOMoQWEopPhTbC4Xq2rr7I8Z2kOyWoY
         e/JXDyeaUoptDnWXaYO7x3lGABTW+bdoEU8hoG6rWo1uHBZmVQxL1g3Ffk9y9HN7VL
         CSn68WWPLnSxMPmzhUTq27b4SdBIpHcUFBOt/aIWSDKQWSxTftLnl2RDTM4HeS5RFV
         RhsmULcPd9cPg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2968E609AF;
        Fri, 16 Apr 2021 15:15:01 +0000 (UTC)
Subject: Re: [PULL] drm-fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YHmR+Gyh/s2sHT2D@phenom.ffwll.local>
References: <YHmR+Gyh/s2sHT2D@phenom.ffwll.local>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <YHmR+Gyh/s2sHT2D@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-16
X-PR-Tracked-Commit-Id: 4d2e1288372ccc5ac60290bc10cace49c9bfa6d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f7b98d1e55ccd34e4998bf5f321ec7b9d6b451b
Message-Id: <161858610111.23465.8316457944463841403.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Apr 2021 15:15:01 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Apr 2021 15:32:40 +0200:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f7b98d1e55ccd34e4998bf5f321ec7b9d6b451b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
