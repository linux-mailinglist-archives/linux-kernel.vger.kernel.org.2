Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3DC372FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhEDSbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231921AbhEDSbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:31:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 20D67613D8;
        Tue,  4 May 2021 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620153007;
        bh=XjyOLWDTdPUqM1r+CAAtypP5rqJRtoNYx5ueA+ZPB4w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e6EZp1Uuo++Cbi2ysOB5EisUDv3/sKmmYd0sfI/LH/D17lV/6Ygbyl578VDLcgqIj
         Ux+vUU34juIS5YTFEqvj0AeWC+nj+eIo4ESPH5SLDwUMA1q8m9xjm18q3CNKIWSI52
         i/Yhgl00hHaknN5x5SkURv3xY2ncTE3NCrLUdQm2ldl8CKeLz+6N8EUovoJYO21odo
         nYb1z9IL0Dk13BWH51ovoPi5XDtmpbKgYkKTxbw7A5CIzV9JsFKihDVlH7RZTlyYnh
         8miSl6Kg1J4t+4CG/jruTdjcKUO+q5K51e1abfMc5TyEIP7tAey8slBRFSVXQP3+lt
         cE5VnZFs94ZwQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1904B609AC;
        Tue,  4 May 2021 18:30:07 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b2180862-6e08-d813-ac65-83052f87be1c@linux-m68k.org>
References: <b2180862-6e08-d813-ac65-83052f87be1c@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b2180862-6e08-d813-ac65-83052f87be1c@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.13
X-PR-Tracked-Commit-Id: 6b3788e5fb8041211ac2fa7c818ca9010e976a74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51e6f07cb12e50bfc71181bd08bad5f0a9b5e9e2
Message-Id: <162015300708.4220.1619890891845350084.pr-tracker-bot@kernel.org>
Date:   Tue, 04 May 2021 18:30:07 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 May 2021 10:14:45 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51e6f07cb12e50bfc71181bd08bad5f0a9b5e9e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
