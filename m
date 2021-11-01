Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46B44227E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhKAVWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhKAVWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:22:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0C49060E9B;
        Mon,  1 Nov 2021 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635801600;
        bh=KBET1oAU8zZ5Q5HNRA6Wr6CZcZA4+U56inGr0G9V+fI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Im9g3uQhdXTZlZKd56MaKANVBx/+NejQxYyguJTdVQNyB4ADQZWBDB7WdcUbiCXwE
         J7g1KCdnhlTic/IoigqwIyxFvcl10Ni3YRti9Wob885Th8y9DnG9UkAzx+8KXF+vYb
         IqoSk8INqsGJILde9tn8vkq8E0zh/F4uzsBGVRgQlPTKakOmwVLCFynucr7iLEyGWT
         MFZSVeu0f17AiIKde5PKg1irFJnafWJPqOKLcelMDIAyrSuD2nao7/0hiIt/8UvKrQ
         Lkrts/KQfV7jOnK4FKKjXMyWH7A+bvyVMUa1j40CKGAVm8my6r33GcI/MDdC+M3A3o
         95UynagqqPmnw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ECB1560A0F;
        Mon,  1 Nov 2021 21:19:59 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163572864256.3357115.931779940195622047.tglx@xen13>
References: <163572864256.3357115.931779940195622047.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163572864256.3357115.931779940195622047.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-10-31
X-PR-Tracked-Commit-Id: 2258a6fc33d56227a981a45069fc651d85a0076f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a47ebe98e6e5113ea8213d019a794d5851fbd46
Message-Id: <163580159991.7741.9907206988143867308.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 21:19:59 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Nov 2021 02:15:57 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-10-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a47ebe98e6e5113ea8213d019a794d5851fbd46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
