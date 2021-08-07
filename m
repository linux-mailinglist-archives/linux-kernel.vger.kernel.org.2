Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CCE3E3698
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhHGSWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 14:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhHGSWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 14:22:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 354A860E9B;
        Sat,  7 Aug 2021 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628360510;
        bh=agqOoUD89S/Z8V8ZdzqbGU3qvUK4Tk/EkaLKFcpUq2w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jhjG6cEB+7aGrwXdOoQySu28BgQ4wRykRzRUgKT3oTx7bm0oKpy6kZBDPnkENGOm1
         pGvuljev+6TRSGM35j9PQHonVnwNg4jor5vZuJBdwMZosnVuuD3AxS5obuPXjMllWG
         m4Q4BzmCJeRGuVWU8B06y76Xbd+mwZww0ih7XDGkxuVxHHoKRDSrukDhW5b7NhGqvy
         cqcZTcgJdLy41x2PFRTh8oH/+VOv1J7hxp35SzaA46pYTtLjQB3tJP3YgtZKTKMUXe
         Cl2OOwbRc6tx2LVhAYtMSXHALLR4+ukHVHIKQpy9RbLDNg/k7jhtuQr6YWMS+Q9EFw
         yrRPZmaziKUbQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2AC3960BBF;
        Sat,  7 Aug 2021 18:21:50 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-bafc6421-186d-4f3b-b5bd-7c7f15bf94fe@palmerdabbelt-glaptop>
References: <mhng-bafc6421-186d-4f3b-b5bd-7c7f15bf94fe@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-bafc6421-186d-4f3b-b5bd-7c7f15bf94fe@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc5
X-PR-Tracked-Commit-Id: 867432bec1c6e7df21a361d7f12022a8c5f54022
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b6684ba5f5abf0dbbda35af570443181910a780
Message-Id: <162836051016.5679.13094161831326920444.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Aug 2021 18:21:50 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 07 Aug 2021 09:39:50 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b6684ba5f5abf0dbbda35af570443181910a780

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
