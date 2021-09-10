Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBC44071D7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhIJT1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233113AbhIJT1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:27:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B193761208;
        Fri, 10 Sep 2021 19:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631301969;
        bh=Opyfm5fhA6ooM8t1x5C+wAKYYWwG4EbL9bKNrKYdoEc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B0hb6NE++KzsZcFoGN0GPVuUyPEjsuyXwIGUKjRUGty78cbctAb97ZeI6Z84eC7Ce
         51TeOuKAgKU+zYCi4iCWCLdFUoM4phtNDzsNbTHB9lQf8HhIZvJlt1IkQu51Ivr1Nb
         ay2zDFbIwhPYc3jbbSICYawds+u+eZCv7dCcxKYK37vAd4lbPBsdmaas4VGsNssxJP
         MKMgPg8uRmWrEK3chkmpqsXkWWrz2eFOsJZ1gMZoQFKMbZvAy/R1KHY8Qov4wuiFmi
         sIFtpUVHcHeBAUXgx2Muc5DgUb9N5D/tsHYqywTgh1f5BXob48ET9a6ajVcUdolY1/
         i4x4RK0SqURuw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ACDE6609F8;
        Fri, 10 Sep 2021 19:26:09 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTuXMRtjCu51AUj3@arm.com>
References: <YTuXMRtjCu51AUj3@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTuXMRtjCu51AUj3@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 85f58eb1889826b9745737718723a80b639e0fbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e99f23c5bf59219d0cd9b6e0d7d4c1b641a98704
Message-Id: <163130196970.21375.4263472057419446331.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Sep 2021 19:26:09 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Sep 2021 18:34:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e99f23c5bf59219d0cd9b6e0d7d4c1b641a98704

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
