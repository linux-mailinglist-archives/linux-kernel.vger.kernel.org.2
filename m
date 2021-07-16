Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0823CBC89
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhGPTbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232508AbhGPTbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:31:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CCC87613FB;
        Fri, 16 Jul 2021 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626463697;
        bh=gZlKT0az33ibZHx7Mw3MNO2kqRAanXSbyMqSf+ts/8Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hI/1LqCcvV/yuHe5Zd/T3dUJeFJUiihOBByDL+rLflMsd10Z+slXBLwZSc9cf1+SG
         A+2On0S5PUIMghJJkqGx2c0HY1UH7nMEwawDv6JMFwhKD+qWcMS5OrW5vQjPcEEo26
         GwepAquYTO5R8Xde9HwhS4/tyhZ4y52cBZvZFJPNfA6gZEZGafyGqcjVJ3CzCpiPmT
         jdmVPHOU92gt2jyH/avdDNnniVO0859AhJq/QvOgWF9CxjaNQP/e9jTO64HiNApOqE
         whN907S3p9f9+YablV5Ihk4fGofQRKCaoBo9WGsH6z68Jd1N82B3Gd9KBd7HOGNaeX
         mlHEWr55Qhgiw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C6853609EF;
        Fri, 16 Jul 2021 19:28:17 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.14-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzb9KSspAtVkSH3pYN97hQ815MoOBTSiuHzUJnnb2fhRA@mail.gmail.com>
References: <CAPM=9tzb9KSspAtVkSH3pYN97hQ815MoOBTSiuHzUJnnb2fhRA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzb9KSspAtVkSH3pYN97hQ815MoOBTSiuHzUJnnb2fhRA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-07-16
X-PR-Tracked-Commit-Id: 876d98e5511d8cfd12fc617a6717e7a8ea07be17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 786cb0a2f9bba267c8a80caf906b94c76d18f7e8
Message-Id: <162646369780.3285.6352090867314203560.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jul 2021 19:28:17 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Jul 2021 13:41:18 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-07-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/786cb0a2f9bba267c8a80caf906b94c76d18f7e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
