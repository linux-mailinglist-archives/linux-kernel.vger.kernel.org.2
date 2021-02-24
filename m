Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9C8324407
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhBXSsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:48:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234713AbhBXSrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:47:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4B27064F0E;
        Wed, 24 Feb 2021 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614192394;
        bh=l4pVWJx9otiL2X3MHcDaUJ66z7LdP3xGM8nBWA4oFyE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xyjwj/ZeFiQODC9ahnKRmxzQx9WGY3FY9NiotyamLHzCWHjTRE1A6gnj2Hrl2/ij6
         02TPXkpA9WOYy7DX7E8HRyprdSvqdyrYlCF2CbRv/Z6OiboZ6eKx8Lf+Mt8Ktp1iu1
         BVDiw6YbJ8pZsNEvJt+U/sYMDahVGKor9sPZp2DlJVctz0XNTDkLFGreocXgMfio3M
         rJrfcm5YhEVNQn4M3EZW3xhIidtmxs9442RPZVoHIcaL0e+CgQpv2axOgZFOPFvR77
         TBkpRLWkx6BUP/Q3gbhvgm2SCsrnY+Yzxmgvmpgi38WSiVu5n8UQV2DD885C+0kI5D
         Xf4kFUldZCaNQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 45D19609C5;
        Wed, 24 Feb 2021 18:46:34 +0000 (UTC)
Subject: Re: [GIT PULL] arch/nios2 update for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <BY5PR11MB3893BFDB87B74CC384B9224DCC9F9@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <BY5PR11MB3893BFDB87B74CC384B9224DCC9F9@BY5PR11MB3893.namprd11.prod.outlook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <BY5PR11MB3893BFDB87B74CC384B9224DCC9F9@BY5PR11MB3893.namprd11.prod.outlook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-5.12-rc1
X-PR-Tracked-Commit-Id: 7f7bc20bc41a4fbcd2db75b375ac95e5faf958ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b866bc5fe0f9626e557fc011048cdb1811451960
Message-Id: <161419239427.20610.15178686440858542163.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Feb 2021 18:46:34 +0000
To:     "Tan, Ley Foon" <ley.foon.tan@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>,
        Andreas Oetken <andreas.oetken@siemens.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Feb 2021 01:59:21 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b866bc5fe0f9626e557fc011048cdb1811451960

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
