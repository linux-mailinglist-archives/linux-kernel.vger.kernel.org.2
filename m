Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDABE3535B7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 00:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhDCWxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 18:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236666AbhDCWxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 18:53:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0033161210;
        Sat,  3 Apr 2021 22:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617490418;
        bh=Dl4cJAkVrbJGylPo+DgEO/2cHCYMKJnFhRZZShrCOzM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZucYMk0njF6Vo6I8x62CSi+KIY15RRzA9J0l3uNkUwPRMWE3wx7sNnzD3AspZFOeg
         3LB5yoWrZIGYmIu0c8V6m1IqlAZHd/m58th9j5l/GWIa9ZgcS5070OHHYXLXEAijAY
         OZacmi7dwj8cqbTXMdbYSXvuvHQNDONihtjdUVbHzDIkW8fzJOqEbF3Za8QOU/BVwx
         Efs+9a9+wikY+yvIJ4u6DiVbbF9sPxf0n3AQK0lpir1FgjjTDETkx6XUIluo3Q0UyU
         AkPRCli5wMCUukhjTQJxDjopM1RigPPeusTB6g7VP732AdfdbnQsNgEGoAFgs/p5Hu
         NfBJ1rVTh7/ww==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DE56B600DF;
        Sat,  3 Apr 2021 22:53:37 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC fixes for 5.12-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210403212944.GC3288043@lianli.shorne-pla.net>
References: <20210403212944.GC3288043@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210403212944.GC3288043@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 1683f7de65dbf0a2c6a7d639173fe92430a28930
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2023a53bdf41b7646b1d384b6816af06309f73a5
Message-Id: <161749041785.18942.11486747194774411847.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Apr 2021 22:53:37 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Holenko <mholenko@antmicro.com>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 4 Apr 2021 06:29:44 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2023a53bdf41b7646b1d384b6816af06309f73a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
