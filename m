Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CA3449D15
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 21:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbhKHUaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 15:30:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238854AbhKHUaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 15:30:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A362B6105A;
        Mon,  8 Nov 2021 20:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636403246;
        bh=uPNWUM+URW9zcvHvHAIYdAfuwwvSLrAVtDzplGUPQcM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pIfIV3mXsKra33o018op71CMq5kFgoS0NUNMVLIxJcmeLRzYtZlC8C45x2Vz2relH
         I9Azle11LXo7hd7o0goLqOPlXLwHs0xNeLcHSAxX5rDqvDRyQBpWbzj2Et3vKufOp4
         nWKJFfpGlWa2Ge6gNhoYcylihNrzjhb633b72/zXexbkPh1bMkVTp7SpkorinI/sIv
         W2dJrVCLpGJdzy1BipFNgQFwuSbB1gctbMw4fVAnVXyDOl303GVuh+hpAGCiUdv029
         RHc1kQ8hgPU/vGphm0N/KFa0xZgolE/duMVYi1TxwfVmwpMj/2h+LQ2yy0Fqd524uo
         2RYA0Ml4hOLGw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 98F9760A23;
        Mon,  8 Nov 2021 20:27:26 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211107174555.2d1a5eec@xps13>
References: <20211107174555.2d1a5eec@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211107174555.2d1a5eec@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
X-PR-Tracked-Commit-Id: e269d7caf9e0dbd95fac9991991298f74930c2c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 206825f50f908771934e1fba2bfc2e1f1138b36a
Message-Id: <163640324662.16718.15799257448358750653.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Nov 2021 20:27:26 +0000
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

The pull request you sent on Sun, 7 Nov 2021 17:45:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/206825f50f908771934e1fba2bfc2e1f1138b36a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
