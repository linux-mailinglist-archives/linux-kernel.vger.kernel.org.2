Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8603BEFCA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhGGSsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232698AbhGGSsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:48:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1F74761CCC;
        Wed,  7 Jul 2021 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625683525;
        bh=kdfpLu1SsHBuIdOzsEkc8SEq6yaCdkgmUWedy83UZdI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tacU79ggiYoCmccnpL7d5ZnPbXlKbuqXdL/LE2YfFfvk5zjIbzM1wkTChNmUfkWAA
         JtsPKxPckrARc7w1mt/kHjjMB64lSu60OCiCIXrZleXLwUr2C/QdXaHHSbba10Ba/r
         lyHpAm7rdbMQ3Blp+YxI0aR0Wje1rGuGMvCjk9JzXTtz49NDtvKapDz3pj1xJ2a5gT
         GrvLXGjRlFuwvTDqqVaWd6MDOD+aPe0PGA7AHM+AA1yen4gxOIN5d25M8TnMpbvj2X
         nJN0DhVupvd7Mm70s8Ini2XFUvb8aAZM7qgQbX+0n2V2UiXb/CqsmT53uF9XBswbw5
         dOoHwq18JJ8Aw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 199346094F;
        Wed,  7 Jul 2021 18:45:25 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210707070139.27901-1-jgross@suse.com>
References: <20210707070139.27901-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20210707070139.27901-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.14-rc1-tag
X-PR-Tracked-Commit-Id: 629a5d87e26fe96bcaab44cbb81f5866af6f7008
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ea90317956718e0648e1f87e56530db809a5a04
Message-Id: <162568352509.3837.16922329777846284070.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Jul 2021 18:45:25 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  7 Jul 2021 09:01:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.14-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ea90317956718e0648e1f87e56530db809a5a04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
