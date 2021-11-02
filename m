Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27984424E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 01:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhKBAxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 20:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231992AbhKBAxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 20:53:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BC669610A2;
        Tue,  2 Nov 2021 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635814264;
        bh=fleafHIXJu2xh4D7iEqUQbe4EDYlA2E7DRYT2/+nX1M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aUETEcRRf0n8Q3X1zuRFeJMC5mtOMgHqyzKGFCgckSGdPkCQuBwcWDBme181eQ29U
         NTe468Rfb2xJMSyLUInJ/4iBJpHNo7ED1mkzpOyd8ljZCDp1ivdCUjGoDIy6mPrbE8
         zme1mIK1R1ubtQjNvdJkJN1YbFS1dDkaIDueU2asKh/dGwgeBjXLSUbncgcFlH9yx+
         MOFQXEd4K2tk1duYArkcS0UcbB+WX/kDD9Ck/cExtoSW2YqCUEPYm4N+22BH7De1Aj
         QA7aoU4B0e91q9da0KnZUKz1gEzWNy+ZkK5eRbxJ98vaTQ93lPVVpZYRFBKKMk+FES
         /kgs0fkUu6J7g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B1F5160A94;
        Tue,  2 Nov 2021 00:51:04 +0000 (UTC)
Subject: Re: [GIT PULL] Various hardening fixes and cleanups for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211101214341.GA29478@embeddedor>
References: <20211101214341.GA29478@embeddedor>
X-PR-Tracked-List-Id: <linux-hardening.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211101214341.GA29478@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/kspp-misc-fixes-5.16-rc1
X-PR-Tracked-Commit-Id: ebe4560ed5c8cbfe3759f16c23ca5a6df090c6b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf953917bed6308daf2b5de49cc1bac58995a33c
Message-Id: <163581426472.14115.9807562884046558762.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 00:51:04 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oscar Carter <oscar.carter@gmx.com>,
        jing yangyang <cgel.zte@gmail.com>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 16:43:41 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/kspp-misc-fixes-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf953917bed6308daf2b5de49cc1bac58995a33c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
