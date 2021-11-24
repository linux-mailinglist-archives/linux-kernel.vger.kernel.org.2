Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF86945CC19
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350449AbhKXSew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:34:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242028AbhKXSev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:34:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 965FE60FE8;
        Wed, 24 Nov 2021 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637778701;
        bh=iPiPwfW6Yi4U+ZP3Z2u6tehYziPqilWMz+Z0u8//aMw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E99A3lwI68OOkFET4pqkk3hED0p4wIb6J8TF9/b1xqUfm2t2Iw8XuKSOUq7qBWq8t
         eNVdADt8B/x1T1rC6DUvTnfZf4biTNkU8AzF8pMEImVDCWfY/PMP7Na+iBK006yvfE
         uKV9mwtAEfO4OG7tlCBYspxZRI0nkDpmtis8OneHa4baJt8Aj18yT3U1BbOGt5mL4H
         49rexTOA8+KujmBsQZrPF8zytzEcZaNRlFwDlmtQ6KYmFmVrRHeJcWs+m/YoZEJWeq
         VHtgFs62UglLRTRuCh8pbTyQIn62DFqStu6cP+6xscPWhlhjWEKd+LQaX6woKb0cND
         UfkOWqlHCbl4A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8F99A60A0A;
        Wed, 24 Nov 2021 18:31:41 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2111240804370.16505@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2111240804370.16505@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2111240804370.16505@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 32bea35746097985c48cec836d5f557a3b66b60a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 740bebf42104d2f082514b1545a14056f3b1b56c
Message-Id: <163777870158.19345.6451834337888181200.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Nov 2021 18:31:41 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Nov 2021 08:10:08 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/740bebf42104d2f082514b1545a14056f3b1b56c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
