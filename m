Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591BA3E880E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhHKCk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbhHKCk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:40:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9385960EC0;
        Wed, 11 Aug 2021 02:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628649605;
        bh=KD6zgAv2K8DXOJ18xOdRewQcHLapTLrzN3ASorWseLw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DrpDcLPCpG6qQh6rpU39WGI9HOGuF3JwSoBuQCPinmhNyp2KsH0Fu/xl5AqeoJ8mM
         CTiL9RqMr1RcmAiXv4YPNlXDPOK5JSeA5JtJ+TLGPDhcK1Pz4P/3HG0vW53YS9byNm
         ybkCVYuE2u+NBOJ8D5Qu/CMAA7cBgppdN7eztiObAzN/wd9mKpy5fShLX4Tg4hIiCz
         09Ji/sdp7ndhHwz1CKjERy0CZZ3VK+w2vSwmRolvuP49Rk+LrfTgxLsFfJO7z3KvNV
         ym0JA8JlOW3sQRfo2fGQKTHZfQKZ3GNucHgxTO6sO2xq2gjN3I37wIvZcks09lBqQO
         SHesEbq1poC2Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7DEB7609AD;
        Wed, 11 Aug 2021 02:40:05 +0000 (UTC)
Subject: Re: [GIT PULL] ARC updates for 5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <931efd74-4b45-fd24-8c88-97f57f97e01c@kernel.org>
References: <931efd74-4b45-fd24-8c88-97f57f97e01c@kernel.org>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <931efd74-4b45-fd24-8c88-97f57f97e01c@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.14-rc6
X-PR-Tracked-Commit-Id: 669d94219d91a2ba950bb12ece69cf0ada53ad4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 761c6d7ec820f123b931e7b8ef7ec7c8564e450f
Message-Id: <162864960545.20572.13474655779418607583.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Aug 2021 02:40:05 +0000
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Colin King <colin.king@canonical.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jinchao Wang <wjc@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Aug 2021 16:21:30 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/761c6d7ec820f123b931e7b8ef7ec7c8564e450f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
