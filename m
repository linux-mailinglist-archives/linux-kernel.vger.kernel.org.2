Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B90438B497
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbhETQtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:49:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235579AbhETQs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:48:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 237FE611AB;
        Thu, 20 May 2021 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621529258;
        bh=VQKssTJryLZiwhqvjTBvi7JUJLeGyWpSxIbyHiiH8Lo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j+yK2Lll1XG++LdyqfLxO08Mjzs9C1Vkzs8GEcSPEL7OFEJO3sHs7f06+FwMnIrUp
         LtceyZTUqfDoNOf3Drj8AKWF42FTh5earVg1BP1GzaDdLseHdmVmhb0YV7TTqKAeuy
         BoWyJc8FRiEVdJ9xU4VhxKv195vySXz2mKJ8xatthAn2ieDNPKm7+ZF4S2DSxHIBYE
         sRXLnvxplhUTRtxLOdpf2LNGWaeKgoqPmviwYzBVyXvlkoA58bXSGEmMxHjAWZCQvq
         ullljagl7FbIeKbHERPrxH30REfgqKSAmpCKmVW5okTSvHcu4JJzGv4a8OT0BwH76y
         Tyv16nGZg/dMw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1BA7F609B9;
        Thu, 20 May 2021 16:47:38 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hcztlh8sj.wl-tiwai@suse.de>
References: <s5hcztlh8sj.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hcztlh8sj.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.13-rc3
X-PR-Tracked-Commit-Id: 05ca447630334c323c9e2b788b61133ab75d60d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6aa37a53ff235a0579d7893c08fd05c2171aafb4
Message-Id: <162152925810.27581.17690977223924122183.pr-tracker-bot@kernel.org>
Date:   Thu, 20 May 2021 16:47:38 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 May 2021 14:46:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6aa37a53ff235a0579d7893c08fd05c2171aafb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
