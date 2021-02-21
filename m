Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A493E32085E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBUFJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:09:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhBUFH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:07:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2413C64F10;
        Sun, 21 Feb 2021 05:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883996;
        bh=6PbpIg37rjsidtMKiArGeteRmtcIXXiQ2Zr932oE4vI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EbXu1CeLO4wNY6hp676lVawOxIXSLGEBrGS/j9FVHVPGeHW/Q680y3dsETtuwTyqP
         Hjt5In60IttOslo5i0zEMKZLU3QHJCITQRxgIGmP6ceFEq5jLopqkuuZbYip5ZZHY8
         H3n2YQcNImbCG/t5gZDjBS85u2LEJY290ewm3CqCs0FNVjWRK3saOnt2rkoVmS3tO+
         XiKqdDnB7ukkeKo/LkAwrcjwP3XJOBUWOmGTsu9SepXn0eHT7c8vHB2k5sY46zSZna
         XdqKFlt40f9CM7wXR4Fs0WcLSuYQ+qLCwUplavgkCtsbrLRpa2rd5uWARUdxPNzfv6
         3mFw/29m1RTKQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1D63760A3C;
        Sun, 21 Feb 2021 05:06:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215114504.GA7265@zn.tnic>
References: <20210215114504.GA7265@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215114504.GA7265@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v5.12
X-PR-Tracked-Commit-Id: c769dcd423785703f17ca0a99925a7f9d84b3cbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d00c4ed02e90c1a4290acdd4f9bc4d056a573859
Message-Id: <161388399611.9594.3055063870821705983.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:36 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 12:45:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d00c4ed02e90c1a4290acdd4f9bc4d056a573859

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
