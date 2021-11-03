Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97F0443CC7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 06:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhKCFlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 01:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhKCFlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 01:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2BD2D61108;
        Wed,  3 Nov 2021 05:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635917911;
        bh=bMJkCNMfEdl7jeeJHgwaIxg6kWrh4pHtpBI+BfK2J1s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JsuCCQnZCV0WAx0+pGLkhUl57SZfxptRNtkFxz23K9mE8WbHllOe3a2mK1CB6sJ8X
         ml708TbMA1C3JiB1Lq/jwjOeiYuHgjVAZ4R/U1+f+pQCsI+iarQ+uVTTU9FgDEIVy0
         o/c9PxSI9g8C5t5Cy5vRFtbgMoXIHBsymf12T7KfGafrSJkIWMBYvr96C1YWihPyV0
         xgoxTR40Y3B1f8G1OmX8tsN5mcZYmDfl/W+j+gJnQlJd9TUdEgOmlQUMnv9XwCsgFS
         IZwUUEbLJVl+e5WY31FIF9IeBq2noEN+Kz9LOBXbKpaxtw3S90zVsP2hWm/Q3UZB+B
         6DUIscEs0VNQA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 255FD60173;
        Wed,  3 Nov 2021 05:38:31 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYG0KwuwSyH2uSqz@robh.at.kernel.org>
References: <YYG0KwuwSyH2uSqz@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYG0KwuwSyH2uSqz@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.16
X-PR-Tracked-Commit-Id: 4c7a7d5086cd0f9ce22bb3df86604576d0604db5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcd68326d29b62f3039e4f4d23d3e38f24d37360
Message-Id: <163591791114.8140.5882708782947703733.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Nov 2021 05:38:31 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 16:56:59 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcd68326d29b62f3039e4f4d23d3e38f24d37360

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
