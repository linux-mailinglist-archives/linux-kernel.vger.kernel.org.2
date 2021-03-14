Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2368E33A7FF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhCNUjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234096AbhCNUis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:38:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EE5F764EE2;
        Sun, 14 Mar 2021 20:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615754328;
        bh=rRXJjJIRXqS9hMV8Q9ZAqIRmLQLB/Mf2PjWOCg2eEbo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=juePjMnUQbeaspwHIY9w0XCSa2RIsS/0DVBIxQllUuo8iGogWC7uWUPR2LjW1rZhT
         2g2aYeVxHIrUhcRcy3KYN6MckV/XYcYQUGNTXhSt0DJjMiGbKhJdLqfWrJudOuDiAI
         D7XceXIVy8u4w1EKQsldH2i9hb2xPUQhVAzn/fou4CJBhPPA8rraCRGJ610h97j/4H
         zmaMiq/PXl/9nCxJCHYR1Z2mcwrIfUTKSXu4SJU1pDPLdUS8yJVGUtnq2Ks+6hnrKL
         O5CDMac7L3rswTMNSeUim4kLD1hekqQUUOaIqKgQKuCrazkt0L9mN9bkQGZxNfGwxu
         fYSBHBRNQSB/A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E9BDA60A45;
        Sun, 14 Mar 2021 20:38:47 +0000 (UTC)
Subject: Re: [GIT pull] sched/urgent for v5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161573639909.27979.13628967413376263524.tglx@nanos>
References: <161573639668.27979.17827928369874291298.tglx@nanos> <161573639909.27979.13628967413376263524.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161573639909.27979.13628967413376263524.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-03-14
X-PR-Tracked-Commit-Id: ce29ddc47b91f97e7f69a0fb7cbb5845f52a9825
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c72cbc936141eac737b24f43e742cefaab35edd6
Message-Id: <161575432795.20317.6545711331866370208.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Mar 2021 20:38:47 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Mar 2021 15:39:59 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-03-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c72cbc936141eac737b24f43e742cefaab35edd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
