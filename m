Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19031445A05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhKDSxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233780AbhKDSxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:53:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9208761157;
        Thu,  4 Nov 2021 18:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636051859;
        bh=fYnzrn7DSEvFXngRVMxlv66qP7uMzg7fMqLu4A789OE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ThxGVhnPYZgr2tLR1ZKUdNtdVsIbqSosWsWrvY1mRqZTCL5XBt0DGDqRDo5YtEyz5
         EiaQw3yUb6IH1a3aS6x1SAkMa/zI6EAB35VvqD7DwjW0URU8NGsEKOZKPkBB9CelbT
         z2TMRUnbENQ0ZfR4gKHOTCXH5anUWRPbxyRmzBBTRXiSlyRJInJaa9as4YnhCTEoxu
         SXQCo7jXbOylsiWF+AIiSjwTvy56yil5RlLWMyM/Hwb13gZ6tY2mzWyxKqa9gmy70j
         RXNVczFLTPf18zOqR8DqYd502MK5TJYFsbV9STSpgE2XhLvCn4yplRoctHxPoWJnlM
         3h9eA1pSoM50A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 82822609B8;
        Thu,  4 Nov 2021 18:50:59 +0000 (UTC)
Subject: Re: [GIT PULL] more parisc architecture fixes for kernel v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYQRdM6er3Hty3qP@ls3530>
References: <YYQRdM6er3Hty3qP@ls3530>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYQRdM6er3Hty3qP@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-2
X-PR-Tracked-Commit-Id: 2a2e8202c7a16a85a881ad2b6e32ccbebdc01dda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1e2e0350ce37f633b5ce3ce1cdf4428513fc2a2
Message-Id: <163605185947.14812.12554900570950614137.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Nov 2021 18:50:59 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Nov 2021 17:59:32 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1e2e0350ce37f633b5ce3ce1cdf4428513fc2a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
