Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EC73B9A39
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 02:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhGBAtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 20:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234576AbhGBAtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 20:49:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B7D056140E;
        Fri,  2 Jul 2021 00:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625186791;
        bh=JQVIzVFAsH0iYEmOwFtvKwvoc+/Y6QAgI/p8c+9HMLc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IpBQv4a5WxH4fZWhgoSxTiUXuY4joG8F15DMSoq92OlplMZSP/Oz2y7nGKGRDiq7+
         YbAI4z6AqEBBJoN6owQ2ETkAQ8ILB7xTVtfwBGLVaTf/3CCrs0VdPkzfDuUmgVS1zS
         oP7mIETMcu/nLcNyKGg16uTIHVzluGUUhqQiX+YZa4lUu9YYdJDkveSc2jVMzmvrhB
         /+kh8vpcaWeSr40AgF2qwHKCEmk46lxMt2908VZB0axGlSrCcALJdA0wx1SaLDeYSx
         d5pfDTkEbp6JZb6arquxD904C9gEr3Ykz00wI5SOVeVJcJmJg1Q5qCtaxydAo+5ylh
         +5xm3pitfstkg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AF37C609F7;
        Fri,  2 Jul 2021 00:46:31 +0000 (UTC)
Subject: Re: [GIT PULL] percpu changes for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YN4G5kUGi295tSzs@google.com>
References: <YN4G5kUGi295tSzs@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YN4G5kUGi295tSzs@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.14
X-PR-Tracked-Commit-Id: e4d777003a43feab2e000749163e531f6c48c385
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e267992f9ef0bf717d70a9ee18049782f77e4b3a
Message-Id: <162518679171.2278.15806419236220359373.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 00:46:31 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Jul 2021 18:18:14 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e267992f9ef0bf717d70a9ee18049782f77e4b3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
