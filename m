Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEEC37015C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhD3Tjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhD3Tjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:39:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B0E486147D;
        Fri, 30 Apr 2021 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619811527;
        bh=M7qlf4KRAl0+T7PVX8kcYz03VzAKOOKuCYaB6f5E6+M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kqCnBrdVNsPcVfPcbFeQGTqx0aFYKB0uHrBq08h3SJlzMB6wFOHNKH9kyYnIc3DgQ
         f8Ay/CJ9+QpSKnM8xd6/x0lk16lMb2kjlFFvV+GBZawQ9oi2ND1piAfzs8Ohi/QeNA
         F3uuF1yxqsHi4JT64PK17AzMECRwWcXaT+hyKyCtGMI/+gqEJvb6+Xv2WLYa81hrrC
         iFLOP7+D0TrdL0i3xJKaF5qWV1Ujjc7YWPdh98AWXOE8rMSvGWOPhT/RPj8LXjb5UN
         jhA0JLvdzOXpZg7BtWucruTofqC5zaeof8uN4CF12gqpQ4UTBPuusHsMNYQUUYsvDZ
         Bsz+MO2YvPw0w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A8D3A60A23;
        Fri, 30 Apr 2021 19:38:47 +0000 (UTC)
Subject: Re: [GIT PULL] Modules updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIlcBHhuR9LvKZ7q@gunter>
References: <YIlcBHhuR9LvKZ7q@gunter>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIlcBHhuR9LvKZ7q@gunter>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.13
X-PR-Tracked-Commit-Id: 33121347fb1c359bd6e3e680b9f2c6ced5734a81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65c61de9d090edb8a3cfb3f45541e268eb2cdb13
Message-Id: <161981152768.3374.17500160225610831750.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Apr 2021 19:38:47 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 14:58:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65c61de9d090edb8a3cfb3f45541e268eb2cdb13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
