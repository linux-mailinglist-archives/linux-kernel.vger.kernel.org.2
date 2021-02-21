Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E22A320CDA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 19:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhBUSpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 13:45:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230317AbhBUSlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:41:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2875E64F0A;
        Sun, 21 Feb 2021 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932784;
        bh=6trAUtPdf/YON4vII38zkB1tVuPe555MUASoKjPFjbc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ntaUCnXCrWILcemOSGSMx/Q5nliFebieYw9f7xKd0ErsAxxwGjwstDDFWx4Hastsu
         ubKK450TvBsFJjEsOT0I/EtXv8SiDrX3CCrreyzmhIrsJUTFreSFnRi0wcN2hAgvbq
         3vENZxMaHVi1PyIPhWb0opvHPSjzbxaF7VLkw+zmzlcOjHMzVOIbEAaPNpmfAnQo/5
         cNjp4moiryYoCeizFTw6Bwa2yXPdscjUszwAJyowRLROkU5c5vtc+PXdh/w/S29FIr
         xkOr33PKPy0vsE6fB+8JXvO3I6YngndVz/mISncCuAK/K7GRMcfhqS6dMtNMnYjAGC
         CvkL2zS/4dS7g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2330060967;
        Sun, 21 Feb 2021 18:39:44 +0000 (UTC)
Subject: Re: [git pull] work.namei stuff (v2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDFJpF216gaPavrc@zeniv-ca.linux.org.uk>
References: <0000000000001fb73f05bb767334@google.com>
 <0000000000000ca18b05bbc556d6@google.com>
 <CAHk-=wiEBTD884i-U9DU7aDdRxXuz66Q1r-rKTiJUzZoYFgp+g@mail.gmail.com>
 <YDFJKR5uG1N+g9TL@zeniv-ca.linux.org.uk> <YDFJpF216gaPavrc@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDFJpF216gaPavrc@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.namei
X-PR-Tracked-Commit-Id: eacd9aa8cedeb412842c7b339adbaa0477fdd5ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c57b1f0a5f40e6d35f22a3ce61e69d73fc0b1dbc
Message-Id: <161393278413.20435.954431401808706257.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:44 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, snovitoll@gmail.com,
        syzkaller-bugs@googlegroups.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Feb 2021 17:40:52 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.namei

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c57b1f0a5f40e6d35f22a3ce61e69d73fc0b1dbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
