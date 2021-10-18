Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D20E430E23
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 05:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhJRDZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 23:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230484AbhJRDYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 23:24:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1209F610A5;
        Mon, 18 Oct 2021 03:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634527355;
        bh=rUP03nPVy0EjQr7E3oqfAEm7RqRDVDaUYbtugqprNAA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XaQMN2AM60n3FMxM/9skDCo0jsIHR3VRz1MNk5qw63J8jwEwd+ZvmQV4UpAr2mbbv
         4zkZ/2yZRqXNM5w5FOsh57dxij58wSf46SXgX66slwncZS+TdrPyWiMDc7xhiX9Unm
         st/xtDILnguVIOx91pKx3SlsBqenlur3Sf059irpMqfBFjojaPh4RxWkE39atw02Yi
         h6wKaN5UBSLX0M/bADzHyuhPOmYe7UHXpoHUA5Zp3SIcJ9qZAe83gpeU8Oq6UPeg1d
         8qjO7uAJvhaG7QnwXPpyK9S4twBxDcyaZXgky6bufS58dofH5IgpZWgZQJJumyycli
         7EtAPl95TM1Xw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0BEBC6095B;
        Mon, 18 Oct 2021 03:22:35 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWv1tz7ZCDOtebFE@kroah.com>
References: <YWv1tz7ZCDOtebFE@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWv1tz7ZCDOtebFE@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.15-rc6
X-PR-Tracked-Commit-Id: 81967efb5f3966e8692f9173c7fa2964034ece5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf52ad5ff16c38a62a6536b5e7612b56794f5a5e
Message-Id: <163452735504.4914.5353825461734925741.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 03:22:35 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Oct 2021 12:06:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf52ad5ff16c38a62a6536b5e7612b56794f5a5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
