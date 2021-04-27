Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BAB36CA75
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbhD0Ri2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235647AbhD0Ri1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:38:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AC42D61090;
        Tue, 27 Apr 2021 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619545063;
        bh=b4c12OjJrQTxrSqCX3KK+h7C5KY1S2GHZY+5jS6idCM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eRsD4wWfPjFsivPUgyPJPe1TUxQRMd02Lt1E7B5/jqKSOuk50BvfiolnKkzTKQ1IN
         pvMhDmagCpUDbRLh7QIbvhHDO96H1t99dOsHqM/dK9CZlZaIc2ljCOqd8KEngQrDD7
         BI3exn7zdljjlKAPKGZo9idRLQj7a0LmzojKrXWbPKlUR+2B9VTYVMivstNItMpQT0
         dDtwrUEzInkjZjwAVpJXVQBqablwHVPWBKzsDgoDRfVex2WA9ujtgJlT/hNheN49lV
         ZqLBlLfvRLmW1PSCeSGZ6aujoy5478awFnKb5aaEG4onsXLuZTicG/KZS+LDVLj9K9
         jk7D4tJHQ4/pw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A6362609CC;
        Tue, 27 Apr 2021 17:37:43 +0000 (UTC)
Subject: Re: [GIT PULL] pstore update for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202104261131.DA983FFC3D@keescook>
References: <202104261131.DA983FFC3D@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202104261131.DA983FFC3D@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.13-rc1
X-PR-Tracked-Commit-Id: 9d843e8fafc7c0b15d8f511d146c0c3d7c816634
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 288321a9c65192878446a00acaa9f6c3ca9bb1f5
Message-Id: <161954506367.13735.3556100160228493496.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 17:37:43 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Mukesh Ojha <mojha@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 11:32:28 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/288321a9c65192878446a00acaa9f6c3ca9bb1f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
