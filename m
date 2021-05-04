Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD58372FC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhEDSb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231651AbhEDSbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:31:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A4101613D7;
        Tue,  4 May 2021 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620153007;
        bh=xIIi+GHw9ac7mDseRyc5Nmmu5Wv52v0kSnzgZ4/lMaU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Q7GsMPxGzamHZoAyLg4S5MKpaLQet2xZI+RRP32AvWIqVgYnHo8WANjuBfIR3Lrm9
         Ol6MFKcmFyepaHbOsNHRsIIcMtgFhzqOUPt2mGYDHyYLDWGmlCEjJ6E3V4bxMbw9SK
         Xm2KWOAfmcxB/iKJelkZ2ho3MJtnoZ+9nsARtWc4pzOJpJiRLIx0/iCOK+LolRiyAs
         yf5IGWZ7507BOy3HwF0Sz+9NpQLOKd3I3hL9MJFc+nfIAtsIEcCYPlWV5qvBHVxoPX
         Xoensnla/Ids1wL2d8KHSqFoITqwu1RdC4BkuskrKit70wrkfpvtUFRxobqzomZr/N
         jd2D1tBuZtt8Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9E576609AC;
        Tue,  4 May 2021 18:30:07 +0000 (UTC)
Subject: Re: [GIT PULL] (swiotlb) stable/for-linus-5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJFho59usXdyDU8O@Konrads-MacBook-Pro.local>
References: <YJFho59usXdyDU8O@Konrads-MacBook-Pro.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJFho59usXdyDU8O@Konrads-MacBook-Pro.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.13
X-PR-Tracked-Commit-Id: dfc06b389a4f54e78c03abecd5b42ab6ea8d492a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74d6790cdaaf3825afe53e668b32e662ad5e2e12
Message-Id: <162015300764.4220.9433128594051150986.pr-tracker-bot@kernel.org>
Date:   Tue, 04 May 2021 18:30:07 +0000
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 May 2021 11:00:51 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74d6790cdaaf3825afe53e668b32e662ad5e2e12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
