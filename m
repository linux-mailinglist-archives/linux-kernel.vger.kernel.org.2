Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D872322242
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhBVWkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231464AbhBVWj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:39:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1936A64E6B;
        Mon, 22 Feb 2021 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614033558;
        bh=1Kcv6H6l84oWJHcMl5tp/G2DGiKT6PoiBby1CSTJEjM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cepeYSKYxcrI08sy2+upWUSQbEu8Ec4On2cKORNw9jqkrIH+Uey9/9ZPMuZHIQRnI
         UlEsBgTPpq13UswTCnAtcij665vxZkDIMgTmxenzjLLmqMAu0noDmQdw2Wy8dTmE24
         9GwLxDf4xejT1eQHa9XH5dziUm4qkZhw70yjRlXKz+EQo+Xutp+hUKhu9UseVf87Ev
         iYUHgSN2P2uOfO2kA9UZA93ml0uaFmmoN323bqHmQJGlY1RHmFeVfRaQ+q+9beBVrL
         Y6emgrDwq18YFXJBeli44hGcVjrB6NrBJJqIp6fLdwCT2i9cRn85cstfhSNoWl34jY
         scDEG32E4iWaA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 14B0C60963;
        Mon, 22 Feb 2021 22:39:18 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161402153881.20802.18192924337537790737.tglx@nanos>
References: <161402153881.20802.18192924337537790737.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161402153881.20802.18192924337537790737.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-02-22
X-PR-Tracked-Commit-Id: 8acb54abc1db4e1e3913359e4108e04e88ce4d92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4aa364443d023fab08c9dd4fe6785e8b73f6eaeb
Message-Id: <161403355807.914.3928999378912409104.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 22:39:18 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 19:18:58 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4aa364443d023fab08c9dd4fe6785e8b73f6eaeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
