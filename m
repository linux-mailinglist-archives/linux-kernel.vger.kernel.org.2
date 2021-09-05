Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED9140114B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 21:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhIETII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 15:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232996AbhIETIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:08:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EF3E260F5B;
        Sun,  5 Sep 2021 19:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630868823;
        bh=DTO549HVdfyZqGh47aCecpLiom7JCFP6BlT5P11RTTE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hWD2Kmcv1a67pBN8zp8hRURn6rm4nejRNB7/Fbqx70VRvKQJoI1VUFYScPo3SiSNO
         05+YPewxYi1xV/8S9LGYizQXWaZmQrcAjn7jVcpiFHkCciHjcElRr2sbQv6EIlgWr2
         1kxcjXm7K9pvhY4MVCB0Ob2Me9nNqQ7JZgnuGsl/Q3V87dvqjL44rgdi0S2zB6kKjB
         7qsaz/vUEA4gjQAJLibY9YJk9vNc4HX5cM5ymQXF7yit0C4xL01W1hPMoMr8pnwxWv
         VZh1t4bupRP0FvHpbUlJ0JOr1lOU8b3IdsnKFPX7nGJ4sWi10UhbmNqIh+PPE31jrh
         Nl3r++1e8XF9A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DB4C6609D9;
        Sun,  5 Sep 2021 19:07:02 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210903114946.3f874e6e@xps13>
References: <20210903114946.3f874e6e@xps13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210903114946.3f874e6e@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.15
X-PR-Tracked-Commit-Id: c1fe77e42440d2cad76055df6fb58caabf622d51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b6dc4f40c5264556223ba94693f20d83796ab1f
Message-Id: <163086882283.6256.17944151994530666959.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Sep 2021 19:07:02 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Sep 2021 11:49:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b6dc4f40c5264556223ba94693f20d83796ab1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
