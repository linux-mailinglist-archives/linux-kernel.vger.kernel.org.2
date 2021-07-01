Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5723B9865
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhGAWBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 18:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhGAWBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 18:01:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 495C1613BA;
        Thu,  1 Jul 2021 21:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625176709;
        bh=NUt43gcqvopSyG3CniOCgP+WdSQtlYXXIPzeH1i0Ryg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SF5O15OWluNAorev3/PI6x4Qzv5UYwemkEFSernFnEDCvmPzxQdj/xLfhlKnhCdmd
         Kp5skhJzVQzWHhRp8Pc7WBkGd/cW+YiTf8Wf5IoYDiNBstmJ/g0BrSGMv7kivK0nI2
         +0UFryBL+FA5ag72qRYmhBtPqi4PcC+tTuPXEVTgM2tKJLr5zL4P3sTYSgRkLzksgr
         06gChggNhdtiIRZgSmDeEawo9Z++4TYmyogpZXzF4HQEs9d9HUj+zdwdl0jLrFxuS9
         CMYSgAqwVs26vYuSqjQ35rBtbZZYjSoJY4ZvXM1yk11Psit4TZ6TVddEaAYS0qZ4zN
         uBioBF2lz14bQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 354796095D;
        Thu,  1 Jul 2021 21:58:29 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210630183823.3500371-1-sboyd@kernel.org>
References: <20210630183823.3500371-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210630183823.3500371-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: d2b21013bf5fb177c08b2c9c4dfa32ee0fc97b53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 514798d36572fb8eba6ccff3de10c9615063a7f5
Message-Id: <162517670915.12814.14744576124603045704.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Jul 2021 21:58:29 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Jun 2021 11:38:23 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/514798d36572fb8eba6ccff3de10c9615063a7f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
