Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5F6447537
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhKGTRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:17:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236287AbhKGTRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:17:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4CC3160FD7;
        Sun,  7 Nov 2021 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636312473;
        bh=eOh3QHkZhlHVUSJaIZv3zU69USIvO94ecTtjnlpfXfM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TXkyUvKO7OvJXukxucdYUGlak6JvY/QCT5yf/TbjeSABcRq0WuIMEZOzndYwTyLkL
         MfVxqt9AJWVUO7qtjcHsBp7EwYP/9ViuBsFyBoAvDJ9BoezF4HxIJTRxPMVfV/TxV9
         CVF36h/HWaPPJ9t0qf2uAuV3RrEqmiHH+uXC0zox26+YT/13NuMOKhUXu0SaZPD/Z8
         WTGqqZiOPp5De0ShjUBsHuxvlyctPLSAWOuWcjnD8KkrWSG7IDcpsXHvlHFbQG0Fv6
         +asUfVvwocELIv2yN4tGDZA4dUUk5ACxxOl3WmMexGYeAdF4v3tzAnXPUY9V/Y0AXI
         Hk2T7mJgBEaiA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 46C1260966;
        Sun,  7 Nov 2021 19:14:33 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211106142747.GA19096@kernel.org>
References: <20211106142747.GA19096@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211106142747.GA19096@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.16
X-PR-Tracked-Commit-Id: 97fbb29fc1ebde6ce362e3d0a9473d4c6dec7442
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e582e08ec059cc9a93d5d154a6429fc4779cf275
Message-Id: <163631247328.5338.5350788410825660383.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Nov 2021 19:14:33 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>,
        Huiquan Deng <denghuiquan@cdjrlc.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Nov 2021 15:27:47 +0100:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e582e08ec059cc9a93d5d154a6429fc4779cf275

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
