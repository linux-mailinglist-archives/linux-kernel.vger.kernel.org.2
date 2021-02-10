Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC40317141
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhBJUXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:23:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233271AbhBJUUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:20:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 692E064EDC;
        Wed, 10 Feb 2021 20:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612988371;
        bh=Q5EoI2uzbHkB7DE0iTiEoeyLlCuQAvw2ZZHm3QWbVhI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nPvoa/k6ef1fsG5da9XGUCYUKp4EInIyg+6XTlTHUb7DFTgMom1kvQHCzOFt67dMz
         duSX0IYPOcMJOw+YKQ8sRAZhs4xrrrsPVRsDtGTOHvZIG8bQ0EWn5u6oBrwZClro8b
         rYD5HO41soLFJSRE9XalMX1KYbmnCwUzu/xOHGlrXOC3KPw9pC0snx4Rz+P8zwW/kX
         oUOsx45lwHpwrBQouSKcb1jQ96PmogSNBJuQpiVWHMUM56xQNJw2X1LzYCl9dNz/Zi
         D36rXPOxIuJZHUuOGb/+193sV34S7nx2T/vjWsHn/aFZ9OfSF8a8BtlJbGj+O2BJtf
         G3NYulfeSoAvg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6474B609E9;
        Wed, 10 Feb 2021 20:19:31 +0000 (UTC)
Subject: Re: [GIT PULL] I3C fixes for 5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210209220527.GA498175@piout.net>
References: <20210209220527.GA498175@piout.net>
X-PR-Tracked-List-Id: <linux-i3c.lists.infradead.org>
X-PR-Tracked-Message-Id: <20210209220527.GA498175@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/fixes-for-5.11
X-PR-Tracked-Commit-Id: 291b5c9870fc546376d69cf792b7885cd0c9c1b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef7d0b599938450c54a8dc0aa4b954d73d9a9370
Message-Id: <161298837140.25163.5789660091863634580.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Feb 2021 20:19:31 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Feb 2021 23:05:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/fixes-for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef7d0b599938450c54a8dc0aa4b954d73d9a9370

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
