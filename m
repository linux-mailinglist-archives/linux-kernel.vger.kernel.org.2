Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37E83B8881
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhF3Sh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232745AbhF3Sh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:37:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 655C86141A;
        Wed, 30 Jun 2021 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625078098;
        bh=PtQiYbm/vqGL/C64zMS9yiz/jF06hzfUFjOVC/XJfdQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oHThgqFUIrvv0UfuLikAuIA2uicnVQC4hSb3Rtty3OQoKbE4rY/a1rLMIUddEEvys
         6EJFFZSNHbT07QKXzScTN71VF4J7U2cQsXHpz0arwzbdaY7cQ+849bymW86L/fruOw
         Mf2y0byP216le/7+DXOQyBeoGB+GdYh5q3yofWs0RKBtIP0ZssiPiO4tj5tMYuXUBv
         fdNSLdjbKrCEAKXZkg+X8Q8OUiHYkWqil7qBxHJc+kxXOhlcFe9Cf0xMK6g9lr6B6B
         WvHxdd6nUEoO+b/dTtxOmOLYi3arIZNmPaskBISBybY/UYS5y+UTYeVW/tu0f7k6x4
         jgfQJXD0VegfA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5F22260A38;
        Wed, 30 Jun 2021 18:34:58 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210628233629.GP2921206@minyard.net>
References: <20210628233629.GP2921206@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210628233629.GP2921206@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.14-1
X-PR-Tracked-Commit-Id: 5b32dd281ee0a269f39ecf6b48f0cd3f37264842
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0c6d209b66096b22a59a01bce48e4867704338e
Message-Id: <162507809838.10377.4327957505294746184.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 18:34:58 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 18:36:29 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0c6d209b66096b22a59a01bce48e4867704338e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
