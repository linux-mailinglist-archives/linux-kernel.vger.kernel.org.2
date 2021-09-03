Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA08C400540
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350517AbhICSqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350464AbhICSqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:46:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A3EC1610A1;
        Fri,  3 Sep 2021 18:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630694746;
        bh=Gs4WEuNC4+xUni9wbtdsAfl2zZJAm8XkeXR/2f+iNNA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jMn5Mn5CDZxDYZYQtffKJ0JEoZIDLu+oxgIe4JTaMGUhEcLMWwuClDC4mDih06VB0
         H9MgLbcSAh1oJOojNjTEsWqkKl9gnL4EYa8y+xOpg7/hY9LUtyB4jwGPP8OZftqHSo
         H2ZxdqD8/HYVL0HwBoY3ztVmhRpiYz5U+hHkO0rm/0so+N0dmZMy0+QBnr2YRebpnx
         pjb84u7J54mfAQlgSKY4WXCLamrePIPp/jhhBFhmW3BUC/q9ZjiTeM+uQTIzBxpdEy
         b109aAaaEErpFsCKeSyL96teirEpF/RGKXPFdJu5eL999ulu8o+9TZnNos7hqL8MQE
         /RgDFufhxvpmA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9EE7260A2F;
        Fri,  3 Sep 2021 18:45:46 +0000 (UTC)
Subject: Re: [GIT PULL] additional parisc architecture updates for kernel
 v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTIRjOdjUHGgG1eQ@ls3530>
References: <YTIRjOdjUHGgG1eQ@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTIRjOdjUHGgG1eQ@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc-2
X-PR-Tracked-Commit-Id: c42813b71a06a2ff4a155aa87ac609feeab76cf3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11d5576880aed34b8aa4e8049afdab92793b071f
Message-Id: <163069474664.21432.5236279924010228515.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Sep 2021 18:45:46 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Sep 2021 14:14:04 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11d5576880aed34b8aa4e8049afdab92793b071f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
