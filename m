Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABA23D3E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhGWQnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231317AbhGWQnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:43:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CC4E760EFD;
        Fri, 23 Jul 2021 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627061014;
        bh=usn+QnnqIkz2yqN1UdHOhGaIWHxNIgxwXunV9/DeH5Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pqx/xLBE+omijV2pbb8CQdtL1dkf23HmmX1A2szEoFBn9vp88JZFbkn6tKtmpaidu
         qzhWALgXobHPAw6D95z73I3j7Dk9GXgRAaFleyBhy4uviHDMppJ8cltUnu0/hBwcxE
         nqTbinSCkZaRXp2w7JnX7OJHwC3xKlbmG3/HelpM9FoZsF4VNeBuwOqf4QcdQpVu27
         FMMVnwEBIMjvm3oawAHytyANsSBDijO214doxGN15EDZcYrv5gLWEkwUaowYxiqYTm
         H+yNRgymUFG3/QMR3kV3i3LaZsEBeFznxsvOJsjoMXuzHHm1AIkJ3tBzaXIMOC0CpW
         N5ta34iPvSYwA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C3A9D60721;
        Fri, 23 Jul 2021 17:23:34 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YPrZBiDr/6Y78Vda@kroah.com>
References: <YPrZBiDr/6Y78Vda@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YPrZBiDr/6Y78Vda@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.14-rc3
X-PR-Tracked-Commit-Id: e64daad660a0c9ace3acdc57099fffe5ed83f977
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d597682d3e669ec7021aa33d088ed3d136a5149
Message-Id: <162706101479.5428.12894705733196752253.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jul 2021 17:23:34 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Jul 2021 16:58:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d597682d3e669ec7021aa33d088ed3d136a5149

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
