Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7033DF327
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 18:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhHCQt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 12:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhHCQtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:49:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0EC4760EC0;
        Tue,  3 Aug 2021 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628009384;
        bh=+IVxZMceqFgzHOvX5ettm5MvpbabtSVI3/t4OK6C5ns=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BRPg265+Obo4S1sCooMqz+1IIdfyyIwIXxGqNat/TSsEfx4aLT2/KvzRhInvtbR+i
         wN21KOM2eOi/siJ5aJDb7SU8PJkseqMrPtPv+ifYng9VQuSwummA6JvwaNYgmOv4gJ
         baNeqGuh3AZOXL5V4XDLUl2h6mbhIMhh8mVuORx0jpuYM7L/ewQWULyFrkQYIa4INX
         OKoMVM7Fjjis8+zETXPK6P59Qrz4pTu2CsD8WC3fkUfbmuWT7HYVXoUPISdAbCybNo
         sbqSeD6Ebak2vP5xZsXZpkD9PbGTFevx4GqZi3nksN2ztSTI6Sju8QDshdR+a6GhuV
         1USN6qrMfqVPA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F0A5660A45;
        Tue,  3 Aug 2021 16:49:43 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.14-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210803081856.3896288-1-sboyd@kernel.org>
References: <20210803081856.3896288-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210803081856.3896288-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: f828b0bcacef189edbd247e9f48864fc36bfbe33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 785ee9834968bee3cdb4a7d33e5c51e32d508792
Message-Id: <162800938392.17675.6549949635232599780.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Aug 2021 16:49:43 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  3 Aug 2021 01:18:56 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/785ee9834968bee3cdb4a7d33e5c51e32d508792

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
