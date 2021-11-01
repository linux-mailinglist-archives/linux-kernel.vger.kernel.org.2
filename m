Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D9844227F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhKAVWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbhKAVWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:22:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 28A2060F42;
        Mon,  1 Nov 2021 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635801600;
        bh=nEYGWmhwEfhn7jCaZ3+fFXRO4/b2VZPLH5yM1RLZrkM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JP4XO3b9os2bNiY7WtGtKw6qaWLkKwVdyJtMfqTOwyOYLTBIzLnpvyPIuMdMv/T6Y
         iNvIHfhWzHjTWYLcf+Lm9sBtriLAMwqY4Qi398EmhcOjLhKOqdKGGRb15oJM/UnLtf
         cnl5Hi6WjWZB7UwwyOHy0CwkPdy7lwwyUwbtpfLPsHwMwPAzgsXkOoxO2O8bhdHOfd
         5wMUVyMMspYkvsUhA3MV9YvRrsi+GCsmiJUC0bG1u7ahfAeRgQlEwbZBgF+/mI4VPn
         zykXDNr4Ho+aOEUPaFjYjAY62o/HtRjOXIrALHubUT9ZvoyUvO39n6t4fuXfgBAB2S
         HdjR3UgF0VgSg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 130F9609B9;
        Mon,  1 Nov 2021 21:20:00 +0000 (UTC)
Subject: Re: [GIT pull] objtool/core for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163572864563.3357115.8793939214537874196.tglx@xen13>
References: <163572864256.3357115.931779940195622047.tglx@xen13> <163572864563.3357115.8793939214537874196.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163572864563.3357115.8793939214537874196.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2021-10-31
X-PR-Tracked-Commit-Id: 87c87ecd00c54ecd677798cb49ef27329e0fab41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43aa0a195f06101bcb5d8d711bba0dd24b33a1a0
Message-Id: <163580160007.7741.12643304236725730705.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 21:20:00 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Nov 2021 02:16:01 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2021-10-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43aa0a195f06101bcb5d8d711bba0dd24b33a1a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
