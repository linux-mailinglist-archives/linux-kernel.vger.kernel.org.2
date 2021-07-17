Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E773CC0B3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 04:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhGQCP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 22:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232184AbhGQCPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 22:15:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6EA3A613DA;
        Sat, 17 Jul 2021 02:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626487949;
        bh=QpWyBv8FqDGoFIzfSVUK+rI/iMdmuOlsQBHfqYgwY48=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FX30hKscrEhF245mNT3r7ApaqG4pTX3nVerbLimmpou+pLfl7pQEnnEt/Y51JgvxM
         wxpep9mQckvI+DqcIQXqWMZNWU9A0qeWwaTjuqFAjtR5E97LJZ1sqC2T9HJGXhXOOw
         SedhN8HX2cOd3V2cMN1H1fMygi6s0sVDLIWwt4FLtUEtEGgw6f3r6+J1rUtO1E+nsM
         S4lyFqCC5avR8LpCkDT6M7Dy441nMXbpRrNIIrZeIWb2bSo2XEGE4iqs5XN1Iy7i3N
         E6vhIrL0UY1XU7KqIoEPhJHNee9+B74+mSkqyBlsWGGvn7dj9wnNTMQE3EySyaGBPv
         Nsu5rvVQjBotw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 598EB60963;
        Sat, 17 Jul 2021 02:12:29 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210716145320.GB3161@willie-the-truck>
References: <20210716145320.GB3161@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210716145320.GB3161@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: e6f85cbeb23bd74b8966cf1f15bf7d01399ff625
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f06a790a0d39a9efad18407f32a61a520520f54
Message-Id: <162648794930.32541.9419397291234742668.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Jul 2021 02:12:29 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Jul 2021 15:53:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f06a790a0d39a9efad18407f32a61a520520f54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
