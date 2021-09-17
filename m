Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E80140FDEA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbhIQQbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243971AbhIQQbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:31:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F100861019;
        Fri, 17 Sep 2021 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631896180;
        bh=3hNpJBVLgBNsFzSfX3k7E2bkIa1y6yO1fC6HDXbuBH4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s7iULun5C/kR5/GiKW9wJjaZvu1Ky75KLgmsEIpWYz1fgmENm9MueTTmg6cyiSLoS
         28vX2EpQJu9xTvwDFr7N9uOJTOer5VWP053CERoEh/21FVgE02CKoi6jg2KlciTWnu
         BG/vBVvbd88xEPgcitFE0X1sb4E+nGyzFPRe2S8P+EiANbH0scraDGLAj1tu0ijYun
         ASev0Dr1LY63NrTinykSLRhKRyhhKBf4m/W7vJA3U4TJOXAL/Se7Zvg6n/ENNFnINv
         EA57I0RLpPsH/vlER9KYif/sbQRj6AqfPB0poitYPwSrUOELX2RaVA4jwdskxNXr/n
         +Fn6NCjiqOMog==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EAEF960726;
        Fri, 17 Sep 2021 16:29:39 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210917113526.7963-1-jgross@suse.com>
References: <20210917113526.7963-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210917113526.7963-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.15b-rc2-tag
X-PR-Tracked-Commit-Id: d859ed25b24289c87a97889653596f8088367e16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6460daea23dcd160f2dc497c64b4c882ea1de69
Message-Id: <163189617995.30150.3872477863690937936.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Sep 2021 16:29:39 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Sep 2021 13:35:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.15b-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6460daea23dcd160f2dc497c64b4c882ea1de69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
