Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8237E320859
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhBUFHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:07:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbhBUFHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:07:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A54E364F0A;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883995;
        bh=cwq6LtOvMiAHXq76l9KqAry8pnxt22khGj1vWzqpOwo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aLsjjfJx/lsXzuOBT2sXwKDdVgm6xtH3lozjPwToR4STGEL7bDbquvxBzJd9fzyX1
         HRDWV3P+OxiIzOkgxHV7ibzuadNC424HCwZbs9Aec4xUKNvWvf3Fqi57RqcoaZNh4N
         aUj29gX8mDbeShqO8gbgqjXoOY/VbJ/qmc9LL8MID9khFglqs9A9R7/QguvStqlLrj
         XKCqGDB/FRNl2tDjOShzEbR1s+vVbBbi6o+ECg5aCiA3IrfbEqnCjSgUNF9zh5joTp
         KiNwf9tzzbZMIl1IFU9fgYv+RFGqU9L0Ht8Wzag2FTZvDtNRmBd81aHQcXh0uCv8rZ
         yLwNUSNHROOeg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A052260A3C;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215104922.GE23409@zn.tnic>
References: <20210215104922.GE23409@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215104922.GE23409@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.12
X-PR-Tracked-Commit-Id: 604303018221d00b58422e1d117ba29ce84295cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f7a4028d8b48d1dc6b51b0737087f5e3c16c336
Message-Id: <161388399565.9594.2289221124030616946.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:35 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 11:49:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f7a4028d8b48d1dc6b51b0737087f5e3c16c336

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
