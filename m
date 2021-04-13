Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803E735E7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 23:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346556AbhDMVEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 17:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231990AbhDMVEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:04:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 064DD61158;
        Tue, 13 Apr 2021 21:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618347829;
        bh=4Rr2C5kh/nxc96K2E4OerlxnH1QR3cu7vm7JPrvZeVg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lPRIJK2fVVaTv3g+MzU+vMGCR7GFVaC7q1IFKvy+4iQUAJ54MfYsnYkDm9UF+KktJ
         kbv4AAO1dtlPmOSI2ek0SVRAumNhoCkRyR8ozCO8B6GOvCZWtozJbXtZlMDY2czCcq
         CyidvUsvqTxRPuU+pzTqWz6sQm/Mtj+F7Uc3UBYM1xatHGnvyZ2u12M07OUbkiP9qU
         eWF5Ay7LrV6su5HZE+BmSQ5vxq1Fsf6zK6O4rn9BF/efnpXN4Y1Wg27F9RPmMVPfNA
         Yekxzp4TrPiwuAbPcdiWakstDLDZK57p+2G4FZLNmgZBReC0sHRnQyaXKzQoo33XBN
         6hMOFqN2kE7dw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EB07D60BD8;
        Tue, 13 Apr 2021 21:03:48 +0000 (UTC)
Subject: Re: [GIT PULL] MTD fixes for 5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1678691098.178869.1618344341740.JavaMail.zimbra@nod.at>
References: <1678691098.178869.1618344341740.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1678691098.178869.1618344341740.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/fixes-for-5.12-rc7
X-PR-Tracked-Commit-Id: 2fb164f0ce95e504e2688b4f984893c29ebd19ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eebe426d32e1a10ac7c35f8ffab5f818c32a2454
Message-Id: <161834782890.2646.811422618503116662.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Apr 2021 21:03:48 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Apr 2021 22:05:41 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/fixes-for-5.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eebe426d32e1a10ac7c35f8ffab5f818c32a2454

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
