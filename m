Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959DB45F515
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhKZTUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhKZTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:18:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7B8C061A17
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:41:30 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B76EB62330
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 18:35:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 3E5E36008E;
        Fri, 26 Nov 2021 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637951712;
        bh=N5akl/3lhXOgtUGqToxTmKcR+sIe3Ba0FalNYOan6rs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o8DxcLnvWkW/2koExcWx4p/9CDMb52fYe5WBrffO0KBWgwdAnaM8BcPPbRTOr4i6O
         GCRPbTwHY1W7QRIjt7QmX6CW/E8X+y/wPFuOJDKX/EynnBeYTQD7BP+zRG8Bgx7ncJ
         6gKHCxcpL72p6Gzl9ZLYxuzmqUAw8b041O+Drhi+HowWRa8xGQg5qVhKVe3Tm3Ev3B
         EyT9x5lt8n38eq8IeglVISEQ7SicwwYLy5/yZHGyXI+K0T5KqbuGElzhMV7CFGyDCq
         WNkrYBnFw0YiWk1hZZYMeeH5W8l7RFYI2sai+sYgLCliliv2mXHs+GAW1uVLcJHyIZ
         Cip3p9gPHYJTQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3730E60A3E;
        Fri, 26 Nov 2021 18:35:12 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211126132245.GA20204@willie-the-truck>
References: <20211126132245.GA20204@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20211126132245.GA20204@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 94902d849e85093aafcdbea2be8e2beff47233e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f17fb26d4dd71b8ea05e1890d8c64d2eca27e7d5
Message-Id: <163795171221.22939.12936668434586575968.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Nov 2021 18:35:12 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Nov 2021 13:22:46 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f17fb26d4dd71b8ea05e1890d8c64d2eca27e7d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
