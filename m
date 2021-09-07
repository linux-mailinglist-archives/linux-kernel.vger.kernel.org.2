Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD7402F7B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346404AbhIGUPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245440AbhIGUPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:15:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CB43F6112F;
        Tue,  7 Sep 2021 20:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631045673;
        bh=Yi+98wbo6Gk/OKFSojEtLhP62YL5etY21kMfMo1vums=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ah1N/R3yIvyblc3HbVAzn8J/isj6z0eb6ThCBDnX1sxdogAVPK3HzXd7HVGznmb6w
         bsUGgomd0NAthx09AtQ7WE/81GJeXiZ8eMrO173AjCXrq9IWkysrsYkh2exIkvmdxy
         eA06NbzWTHMhJmmCmvBvYF+Vluk0rsbTQKWxbr0AvBOHj5O3zgrJv0GD2F9fTp0qWK
         mfyZ775dnJdKzfeEvPJKvRqrQf5OV4J8yrrAH9QVOqnImJlVTrhlY/g6AqD8n8l3qZ
         Yr0HkmFr1WAvMzQKdYnMzQpOSmuMAawt59d2JCuarQtjneJtPURx6mJnprwAnRCQn2
         EfN457sUPtOaQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C5CBF60A38;
        Tue,  7 Sep 2021 20:14:33 +0000 (UTC)
Subject: Re: [GIT PULL] dmi fix for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210907102428.616e5087@endymion>
References: <20210907102428.616e5087@endymion>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210907102428.616e5087@endymion>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus
X-PR-Tracked-Commit-Id: f97a2103f1a75ca70f23deadb4d96a16c4d85e7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2b28235335fee2586b4bd16448fb59ed6c80eef
Message-Id: <163104567380.21240.14512041027240645807.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Sep 2021 20:14:33 +0000
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Sep 2021 10:24:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2b28235335fee2586b4bd16448fb59ed6c80eef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
