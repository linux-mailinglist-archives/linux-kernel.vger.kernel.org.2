Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377AF4071D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhIJT12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233109AbhIJT1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:27:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 75581611C3;
        Fri, 10 Sep 2021 19:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631301969;
        bh=49fOBdO9wolsd1hrRzupIPHFO1de84sxCuH24xq/j9s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xg4uc54AJfIApGHI5MycBu/7T9ThHiZkMaT/39vmERfRuSrCQiIQ/QlHpdWMsTSAa
         kjPJ5IOT6CahIC5EtCClRbRmWFSobN+zGJ0/AHR/KpWVDAxJpHDyCuais+H4jA3p0b
         V4Qbm8MYskUAQ00U3DfMBNBU8rWs/26nTpw+6+tMQG4RYWXaKbwUZG9av8S6LswHqd
         GzXu16n0IW5Fy2VcrtWyLkVUXZNFSgh2lW8S/0mZGsXMN9QmQDe/dPbwOQhsdPEji9
         csC8nkMgDnkf1BHcgoIc61rITc4DRNx841KfpVOTtFjWcNoL9fjMzsv+9Xo/SciyxT
         vbCnRSeChLGWw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6FC91609BA;
        Fri, 10 Sep 2021 19:26:09 +0000 (UTC)
Subject: Re: [GIT PULL] More Char/Misc driver changes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTtn4YSxwlQ5GbLT@kroah.com>
References: <YTtn4YSxwlQ5GbLT@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTtn4YSxwlQ5GbLT@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc1-2
X-PR-Tracked-Commit-Id: 4cd67adc44a3ccdb3b8526c9f932f905284e028f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ffc06ebeaab65d8e08df6953caf8155df2c45f8
Message-Id: <163130196945.21375.2673623553384837967.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Sep 2021 19:26:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Sep 2021 16:12:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ffc06ebeaab65d8e08df6953caf8155df2c45f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
