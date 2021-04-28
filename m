Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD3436E20C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhD1XO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhD1XNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:13:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 29ECC6144C;
        Wed, 28 Apr 2021 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619651588;
        bh=gSiF+G1aFjgczcywZvbO+1/TImUPFtz6Jfo8qwnrUK8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jbdXNwDA0Q7StWFJOHzY/5NpJnV7iXXlC+JWmvE8l1bCBo5LTSSSA1UIaYaoHL+Hv
         q6Ve2d6px2WhTXBPxJJcI3Weotujbvc7BYULASiHFV7hi+wOwylU2tysYV2KFMnFE1
         8C1QRL6PLQ3+FQToVNW/immaMJsGEsEcBP8SNI0pasyW06L1xBeoDJhIECLvf/2bkr
         rXokaNwMuVXn7jon0i7SrnX2PawXONqcIDAiXlGThZS2llagDDzkmomXHpYNEQD3dj
         OYvOU9UzTh821f85wTsOBQoKhR3tggb+GTTtJN3s2rIV0luOW9tAQ27sZe3Fb5ClZE
         OsHtntHt16MCw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 23F3D60A23;
        Wed, 28 Apr 2021 23:13:08 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210428085825.GH6446@dell>
References: <20210428085825.GH6446@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210428085825.GH6446@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.13
X-PR-Tracked-Commit-Id: f9386c91574fe6da9f4fca9a47734816b0db0019
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71a5cc28e88b0db69c3f83d4061ad4cc684af09f
Message-Id: <161965158814.11634.410079158861110814.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 23:13:08 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 09:58:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71a5cc28e88b0db69c3f83d4061ad4cc684af09f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
