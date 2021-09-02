Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A453FF52F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346272AbhIBU4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245324AbhIBU43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:56:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D46726109E;
        Thu,  2 Sep 2021 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630616130;
        bh=aTFedgOw8MTX7QfrksRz9iKRq1Ip8bf6ti8F3t3he3Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r+oxrJjqBnv6PXEubx993TZaEkf9Jp/AyUA3g0dAKRoy1HxctFyQjmTTs+L8iJPTq
         ALJiIZphtGcxbLYXaOPpqOcby77AUMFJgkdmQ+ss0dmKN6zh/Vzm2zMQraplhxWNSS
         BUlGUuScgNGONd+hmXwLAQcdgbAd8reBfawXPZhYdgMqyguxKPBSlTojyW8nlLoO0b
         vrFE6UeyU5N54R93e8+K1Aj1qdxKCJ0fY7kpW0NGdxM1csH374LH2Ox7HJhV7N3o0a
         bs6PsXGLzaHfzbVl46DMlgmnHMafs9uHQWZU6fjNNt3ZUP2Mqb4ojxqau4JqTC7mT7
         tHQBuw1YjEMbw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CF0D460A0C;
        Thu,  2 Sep 2021 20:55:30 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture updates for kernel v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTEOIq86QHceYCO9@ls3530>
References: <YTEOIq86QHceYCO9@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTEOIq86QHceYCO9@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc
X-PR-Tracked-Commit-Id: 6f1fce595b78b775d7fb585c15c2dc3a6994f96e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2d616b935a0df24bc9375785b19bf30d7fc9c6a
Message-Id: <163061613084.4397.16763023463770407145.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 20:55:30 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Sep 2021 19:47:14 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2d616b935a0df24bc9375785b19bf30d7fc9c6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
