Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9ECF36EFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbhD2SvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241017AbhD2SvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:51:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9448E61408;
        Thu, 29 Apr 2021 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619722224;
        bh=gsDhp5xP+VTDVof1bkfn1g5YLC96sgnxmOLcyWwKWcw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MS6bQzaslH43Oyc5fgCBc/Lx1D/sbYzkOMkBKb0gUjBpLIeu3jz6XxBbQAFefAxWK
         79U6+a4XD4NBcQrn2TOBXXswMnZJi5CNknLOJ2YxjHT7YQpKFfmgCjczvrkhYnvTSH
         prypvjFyCfEth+lfEZ0Vnw6pxrUke1yPGUU0jqa2LzRrxGQyq0O40XOoBMhQMfsfuS
         voeM+oXlzkcmCBH+bYMbYtu0eijRfNVhtkaDv6T6y8Qva5JTnCmOnicysMMwIM+1BH
         4OipUMO9qxaGGZmZkRBPl8fiOLZsZKrbkwORYnHzYzjmHUVEUSU5yG2helY99Ui5s+
         o7DHVSG7dp0Hw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8E49C60A1B;
        Thu, 29 Apr 2021 18:50:24 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm changes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210429082819.GA2827959@gmail.com>
References: <20210429082819.GA2827959@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210429082819.GA2827959@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2021-04-29
X-PR-Tracked-Commit-Id: a500fc918f7b8dc3dff2e6c74f3e73e856c18248
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 635de956a7f5a6ffcb04f29d70630c64c717b56b
Message-Id: <161972222457.6619.15296998135532721680.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Apr 2021 18:50:24 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Apr 2021 10:28:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2021-04-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/635de956a7f5a6ffcb04f29d70630c64c717b56b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
