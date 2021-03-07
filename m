Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68A3304E0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 22:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhCGVbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 16:31:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233026AbhCGVa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 16:30:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BBB316516B;
        Sun,  7 Mar 2021 21:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615152657;
        bh=QnqDPVdIxTJC/1EGVfHIK2yKKOr3FQROSMIT8VqU3CY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eo+YDQ3BpuKE2lNxjeHJL/jKU20LUwnoteAq2MmnTZ9LH15xmeyhGH82upWP3kP8Q
         gmk51UcrURro3QO8LABzRXsSoxNQEPb5VD4nExdIM1zFV3g/WLRvhyb0t7bRyvZh5l
         bKb4xLSKzA/MJUa3lD8orSTII5uGO8EyXlSIclOEbfW2q7c0lX/joHrKRVkTSpvvbH
         hhKZCesZ8zf+v4VwzRVVWudnCdRV5nOvYeU8htSBlT6vsNTNt3w5IJJ6gkfjNYM2jA
         0N02mDn2sulnC3I3x6nNUbulJYY17t2BPPJL9icWabq5NkTXuk5xv3m4txJrHp2WBp
         26WSCrw2J2SNw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B62F8609DB;
        Sun,  7 Mar 2021 21:30:57 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for 5.12 (take two)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210307100731.2066899-1-geert@linux-m68k.org>
References: <20210307100731.2066899-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210307100731.2066899-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.12-tag2
X-PR-Tracked-Commit-Id: a65a802aadba072ca7514fc0c301fd7fdc6fc6cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dac518707880617a2beaffc01fb1d7adf4b8008a
Message-Id: <161515265774.2708.18273760352522911050.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Mar 2021 21:30:57 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  7 Mar 2021 11:07:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.12-tag2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dac518707880617a2beaffc01fb1d7adf4b8008a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
