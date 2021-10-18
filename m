Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF7F430E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 05:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJRDYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 23:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhJRDYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 23:24:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 918E260E53;
        Mon, 18 Oct 2021 03:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634527347;
        bh=WQvv/2BQWh58MxuJC+OalY2CYQpkGcjzd13vRIEdp/A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RXi4iE1HuE367KLAUil7MFs0KRJIhWbPkLyuJyr99J7JGcUB/IlQiI1RAjMElmS3u
         jXxhc/DaczJnpXasML7Ykq+utpZlpYZWC4K1BxyjLFKI394GGve58aZ6PbsyZXqdBP
         D8Wdu/g3eWckAHsStsYtBMjHxWnE7U3RDOFXEDW73wqP7xQPaF1RsJtBv9cVfITYu/
         +bdczelC1JSa0FhK5oaLfvRxxPxOYDLW4em16Y6PlA4xd+qfq5Udx+BUlfbmdUpKBa
         bFOkDK+GGptz1Xm/L7J7LlNfkosnmJZlkje1KSZi1Z1kRXjYF4Ql+NSyntEn2nSiMn
         7TpK0a3JFgRqA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 87AC8609AD;
        Mon, 18 Oct 2021 03:22:27 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWv1XLbDBs/y1d3W@kroah.com>
References: <YWv1XLbDBs/y1d3W@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWv1XLbDBs/y1d3W@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.15-rc6
X-PR-Tracked-Commit-Id: cd932c2a1ecc8f261ecb8d140fa431c16379931f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebf613ae87baff7804966d3f251d09ec7c3ad17f
Message-Id: <163452734749.4914.1747784481215023416.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 03:22:27 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Oct 2021 12:05:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebf613ae87baff7804966d3f251d09ec7c3ad17f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
