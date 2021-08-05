Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D671E3E1CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbhHET0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242892AbhHET0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:26:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E984860D07;
        Thu,  5 Aug 2021 19:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628191565;
        bh=67DrnrxjYaUF0lrvhY+MKcjs2TWrHuctXxh+tGg8x7E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NonnZ40fOQVnikPc/K02ClV5d7Gpah0tjbIoFlaLB5WKgPoA5YgtNQ1dcZ4KWJ7mj
         mvtVjHi01qMH4LJomR3tu49oMhKvNRfBgUXNLX3TqznGQoqvcFTC55Fe4V2mAmdbSu
         DK3m4N5GL2Kdoe2VccO08l9aLaF2anEmc0qckHke//EBpbJHLMw+2DGBnk0zmAlyti
         pDeTeLkNzw7p9v4HyxPHaWy0mG1fiVcOonxtacq/fJF7QwBcSsjP1oLc7XDlWSsHTL
         aXvL8fre1FFCaqX4baInDnvJ9Da9kmqV9ZObw3nQs4vWYsAL62KpJPxj89Lug/HBpK
         LNPcXvtk1HtGg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E2F9D609D7;
        Thu,  5 Aug 2021 19:26:05 +0000 (UTC)
Subject: Re: [GIT PULL] pcmcia bugfix for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YQuDOeJ7QQ7g8sqj@light.dominikbrodowski.net>
References: <YQuDOeJ7QQ7g8sqj@light.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YQuDOeJ7QQ7g8sqj@light.dominikbrodowski.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next
X-PR-Tracked-Commit-Id: e39cdacf2f664b09029e7c1eb354c91a20c367af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 611ffd8acc4b06e606325ca727c891ce70adcaa6
Message-Id: <162819156592.13342.16164287677708482928.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Aug 2021 19:26:05 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        zheyuma97@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Aug 2021 08:20:41 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/611ffd8acc4b06e606325ca727c891ce70adcaa6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
