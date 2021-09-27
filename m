Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E672419D01
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhI0RhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237329AbhI0RbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:31:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 121446113A;
        Mon, 27 Sep 2021 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632763508;
        bh=MtQ2XVa4KqDMKT5idcOhiAUaQuvh9wtZnxXSh1q12FQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DpqkZXz2cvvQ7on3IfmL0CEuxpcr84ORnb5JM0PcaM386shElLi0ISqCgO0U2kn0g
         H+j8TIPA3TzBIdIhQgC46bY2hBSU0HFvnWXHuk+XYUStnNQWHfbKvw3UzAPIMGIjQr
         P1k0G4oThIVXm+oY6se5SYOzZYKfn0xPm+br+aBJZCqj4EvmicGTG/cHSWuz80q86h
         nE+m0enJ7tnTRb4SMF6PeVhU6YNG1VRjXvkUBIzIrH2v9NAFJhGWLATDc0Jr5KB35/
         hEJ2JvtdVMfbiGMM4lbpIRf58JtJivACMdeiq2SFPSbU9pHwSmKSRpHhsufRMQVJ1o
         YV0hLNeRv5/tQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F1B52609CF;
        Mon, 27 Sep 2021 17:25:07 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2109271551130.15944@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2109271551130.15944@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2109271551130.15944@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 88a04049c08cd62e698bc1b1af2d09574b9e0aee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42d43c92fc577dca59ed74aec7868abec8d6ca6e
Message-Id: <163276350792.13519.14426449788803163163.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Sep 2021 17:25:07 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Sep 2021 15:54:34 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42d43c92fc577dca59ed74aec7868abec8d6ca6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
