Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0B3418A5C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhIZR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 13:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhIZR2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 13:28:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 31BF360F91;
        Sun, 26 Sep 2021 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632677224;
        bh=SkEIkY6LATMnGelblhmtEXJopC2yPI8zf6H/gSjOqZc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TSEgksmYk4yKfjfHGFPMBiuo7V1KgIS/rPcaK1ENBLUaRXK25xnFP/ZseNJiY8AAV
         Lm05x61wk1yeTtUIr0dkEhAaVAi0i3037A5sze7ZrR+Z1Swc0WHjQ3KDIQeGwNGzJt
         Sw4umCzzWVLlC5OixZv5Mel6qvjYo4QbNV/K2AVxJzaO3nJsIbON/PT5eAwZfFZHyO
         aSnoVwxw1CgSWmpXSWZBoukJG/snPg7o+6GuFfl7lobvOZ7jJL8m9A7dQeoEJNyjCL
         0ZK9YpjN8tEXG83fPTrvVcufCvmsR2yUei0anVBPHnXWU3Wzk4Zfu3RQHc0ltbf8N8
         1l7VY1UBR45aQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1CE9F60A12;
        Sun, 26 Sep 2021 17:27:04 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163265189226.178609.9712455554034472888.tglx@xen13>
References: <163265189226.178609.9712455554034472888.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163265189226.178609.9712455554034472888.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-09-26
X-PR-Tracked-Commit-Id: f9bfed3ad5b1662426479be2c7b26a608560b7d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc0f97c2613d09734719ef89d99d06417d92337d
Message-Id: <163267722406.5286.7723051579411297868.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Sep 2021 17:27:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Sep 2021 12:30:06 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc0f97c2613d09734719ef89d99d06417d92337d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
