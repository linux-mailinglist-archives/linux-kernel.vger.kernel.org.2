Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4B30E3E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhBCULY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:11:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhBCULW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:11:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 750C764F76;
        Wed,  3 Feb 2021 20:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612383041;
        bh=4lcwogiCPI3Y0k+gkyr6aZ6Zc+NCcwmOR6sgwbpI4yw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Nk1UTwp/nuYKGlcxtrvM7Uot5/kIOFBCt8HYeeX7oZ2bUTprrxgo69RgaXb3vUtCy
         lVQnXCgVSdBgWOpDmlmGTD3bLMXOv1rzPKgM+sjrsFzO9CqJp4WPUtwXUEPLWAT35s
         PgWvfpjQtq1bVvTMgENovXu6QkbuEI8aoPzRlJau1piwQUbSWMSt6RcERUm5FOX/6u
         DHfyi7bS2izW5iahI61e0ZPv57SKl4uy9z1UF98jAh0RTIOHGlNiU0l7t6BU/N4tk1
         writrirYQgrsXxxXE5bpBNMCTch6gfCvQh7kRkb8MEHhh/EeAM1s08OuqyuEQvQQd6
         tiOpPHfNxNA9w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 63243609E3;
        Wed,  3 Feb 2021 20:10:41 +0000 (UTC)
Subject: Re: [GIT PULL] UML fixes for 5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2021686242.358980.1612381974638.JavaMail.zimbra@nod.at>
References: <2021686242.358980.1612381974638.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2021686242.358980.1612381974638.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.11-rc7
X-PR-Tracked-Commit-Id: 7f3414226b58b0df0426104c8ab5e8d50ae71d11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61556703b610a104de324e4f061dc6cf7b218b46
Message-Id: <161238304134.2800.11569803493386915876.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Feb 2021 20:10:41 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Feb 2021 20:52:54 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61556703b610a104de324e4f061dc6cf7b218b46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
