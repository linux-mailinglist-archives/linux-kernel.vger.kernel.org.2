Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5049B42F582
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbhJOOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240340AbhJOOhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:37:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5447961214;
        Fri, 15 Oct 2021 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634308510;
        bh=T9mFZK6z4XrXK5srmw5gyWKHnyNNrM0CFmu4WcqEzmM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UQCFVAm1Kmydj5UZl90JvOFkYmGLqAFrHWddgVZhVAnx2uxBkCg+N3T30RFXLv0Dm
         AuQn4+a4diohPKfWZRvUZhyJqTfuBoSaDX0FcSKbpstAaopgMSxD+j8QnVVBX79wbL
         5ctTFdqIU7hV7W0dAD/hckUn0HZ+5bi3D/0hVSx1pPS6L3tsQ6hIe8buh8vO6pz7xj
         CmxRLJ5TjPxlKGvCCaz2FWHMW8Wc0X54wW/Q5qlBkq53u1B3DmeavMI/edPXCjWN/t
         ljuiilM4xSDUJ3iAWhkUOMw9sr4+TLx9Bu0OecpeUBpOWgnKTD1IvHTM71z17iag+D
         SbSwJun8RXgxQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3FB9A609AF;
        Fri, 15 Oct 2021 14:35:10 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211015121631.2d9fa93c@xps13>
References: <20211015121631.2d9fa93c@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211015121631.2d9fa93c@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.15-rc6
X-PR-Tracked-Commit-Id: f60f5741002b9fde748cff65fd09bd6222c5db0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e795d94deafd007bd6702679a02b82facc6e7ea
Message-Id: <163430851025.21069.13663451040102869717.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Oct 2021 14:35:10 +0000
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

The pull request you sent on Fri, 15 Oct 2021 12:16:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e795d94deafd007bd6702679a02b82facc6e7ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
