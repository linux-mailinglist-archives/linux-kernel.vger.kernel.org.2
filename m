Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD913442284
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhKAVWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhKAVWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:22:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E4987610E5;
        Mon,  1 Nov 2021 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635801600;
        bh=k0Q0SmCOrsTpaO/2SBQiY8dI8SbVk+Qn/PDMEtoNBUU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q1CWaWDv/TVkexx0xfDLgRj4OIr4MWG39nMa0EGfzhB3rlB+CUdmfwIoe8IOZpVlI
         9pR6xdOEJfy7xz/jkxVoeSIpNVhfO2VwPttw3MM0Hiytrb7nYT9+T12qdP31J1N8os
         LBaa4TAYEXQ8oZOeZ7GGr/YsSufPUCbsAsuSOW4wS7V8NbhB/RT3bakHKDK77GqNb4
         7LRg8wgIuvvt7Ltyil4D1Ngj44rLADYr4gC6Wv3FBpJ5RG7Rs3usRIi6kpoBEFLTrD
         ixxL+nMgdmmB8Jmjiu468cfBm36iD/+TWC7fqxG2KhGMY8lkgIzV/QDFHEUALd9MFq
         +VKsScdi+kz+w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D836460A0F;
        Mon,  1 Nov 2021 21:20:00 +0000 (UTC)
Subject: Re: [GIT pull] locking/core for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163572864413.3357115.7664423060313420054.tglx@xen13>
References: <163572864256.3357115.931779940195622047.tglx@xen13> <163572864413.3357115.7664423060313420054.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163572864413.3357115.7664423060313420054.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-10-31
X-PR-Tracked-Commit-Id: f98a3dccfcb0b9b9c3bef8df9edd61cda80ad937
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 595b28fb0c8949463d8ec1e485f36d17c870ddb2
Message-Id: <163580160088.7741.9284223223554854284.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 21:20:00 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Nov 2021 02:15:59 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2021-10-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/595b28fb0c8949463d8ec1e485f36d17c870ddb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
