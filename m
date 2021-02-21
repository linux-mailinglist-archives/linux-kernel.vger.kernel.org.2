Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323D232085D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhBUFJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:09:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBUFHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:07:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C86FA64F0D;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883995;
        bh=U6ebNM968oRxH7J8kd4zDTbJVIfzZQrAZBVRDp5uc2g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tfFP2cD3K+QoAbIJqvsGGdm8WBZpSM0w2fAl2YZxZFCHahTTVSWumW2MdcD1528TJ
         5+3+xuVwmuCBZ7F1onZ+UtVIf4Kp4sAutrV7EHD843bMt0v0rG9BM/ONC968PljfDm
         AEVPZTktARN/BsM+Y1b33xbG2LyHgSixdFX3m6lxgvTCcFeLATe9qnnKkSwbiBNNjZ
         RYaZW2mr+QuVV1NOUXHaiLzyqE+9yaRria6oJhgs1PJua7hl4ziYu/R/f8nAcRbEjQ
         NtGFbtC89DEDCNb2Bkn8dkhq6zEWUncRnP4CaD4R9qxCF/tBbWPTf8m2OF4/n6+bRm
         CRFjkIFtw/Xhg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B8DAB60A3D;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
Subject: Re: [GIT PULL] x86/paravirt for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215105324.GF23409@zn.tnic>
References: <20210215105324.GF23409@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215105324.GF23409@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v5.12
X-PR-Tracked-Commit-Id: ab234a260b1f625b26cbefa93ca365b0ae66df33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1255f44017c02d14e3ad5b63cdf619a734d765a1
Message-Id: <161388399575.9594.13404597117569786883.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:35 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 11:53:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1255f44017c02d14e3ad5b63cdf619a734d765a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
