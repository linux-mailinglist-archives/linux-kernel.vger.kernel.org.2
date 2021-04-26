Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6924036B915
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhDZShM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234647AbhDZShE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:37:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1811561164;
        Mon, 26 Apr 2021 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619462182;
        bh=ki5j7sco3Y6AttseIRABEAACjwi7L7h5KCAYWCudRsM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k+nL8NlpiqvICyVbHa7sP/7qYaL0LMy1XZx/WyIGpTb6zQm/arMbFgKzgbB8CBhOI
         Gy8NhS1+uXn5dVVZB94DZmk45V8I+U5x2hbGQE8nk94Q5yKQHWNS8pkDntCNdQEGTk
         08fDlITRQMAxjGDAfW+DkbYxlHKVE0N5V0SwMRS+UMXs71lAXQkUjaMwNa3d5jhbKB
         MX5ONPtsrR7DcZfQcq65YLzYi1l8QRnL/IYEoTCcr1AT7OmMh1YL8KJqa0k3XZR2Sx
         Y6hYqxZ9CSUcmZRDoiK3sPAfjpbqC2USRP7tTcgh8n2GQ7BQK+xN02Oh7bc50JvTDD
         ZmA8cRAg11TWA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 10B85609B0;
        Mon, 26 Apr 2021 18:36:22 +0000 (UTC)
Subject: Re: [GIT PULL] Staging/IIO driver updates for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIa2ErYuJyCfSkS+@kroah.com>
References: <YIa2ErYuJyCfSkS+@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIa2ErYuJyCfSkS+@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.13-rc1
X-PR-Tracked-Commit-Id: c295d3007ff63064181befa734d9705dfc10b396
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8900d92fd666d936a7bfb4c567ac26736a414fb4
Message-Id: <161946218206.19244.13705418886944400379.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 18:36:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 14:46:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8900d92fd666d936a7bfb4c567ac26736a414fb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
