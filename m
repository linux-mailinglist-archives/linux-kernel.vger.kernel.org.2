Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63555442281
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhKAVWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229970AbhKAVWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:22:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A9491610A0;
        Mon,  1 Nov 2021 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635801600;
        bh=4P9OAdSTuEAgigM4EhK8ptfMJjdsK/wGT8Omqqezr90=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jzVpdqalz0QOywbELfDdty1ugpDhZ3P6xEi4VvSDTahLELVDb8PdxYDs2XHkPxLZw
         ZHhnPsebT1YSs8YWKPL9vkYf/+f9q72HpcW6A6HiWMWHG/Hqy5NabTO4gOnhpl881g
         6NI7CyN7pdhaiX5w35XUO/lE1w6JMghNLil2oNzHULoedSoAd6jZQSaXzI5h6T45mt
         Y4kC95tEF9mWqXGj2J0Xh4G3AgDcsZPVLgl9qhLgG7mO+41saX/AHOqCj4RJpACBLO
         FCJ7nivX+tmWsHfpV88qqQgaTJb9Pp4cZAo5o0U/BFlfuDPZ4oF65yPUtM3sReO99p
         WRKstSC7JHc4g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A064E60A9D;
        Mon,  1 Nov 2021 21:20:00 +0000 (UTC)
Subject: Re: [GIT pull] x86/apic for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163572865146.3357115.6271807450024716473.tglx@xen13>
References: <163572864256.3357115.931779940195622047.tglx@xen13> <163572865146.3357115.6271807450024716473.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163572865146.3357115.6271807450024716473.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2021-11-01
X-PR-Tracked-Commit-Id: cc95a07fef06a2c7917acd827b3a8322772969eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d20dd3294b31c11a5f642a3e342174ef8da7c73
Message-Id: <163580160065.7741.13073560370803286819.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 21:20:00 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Nov 2021 02:16:07 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2021-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d20dd3294b31c11a5f642a3e342174ef8da7c73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
