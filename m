Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A813FE13F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344611AbhIARkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232026AbhIARkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7098460FD7;
        Wed,  1 Sep 2021 17:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630517943;
        bh=ZFGT3K1IWU0xlh6XfVOWNBFSd3vtQXU+GwzoIVeCK0o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jvvcEMZ7O87iOWmeZaVs/uO0Cqf+sERt1lp0RfCL3FnD+GLtLRNpPMIipu+P9lDZP
         xV0V8AxDSlADWP6kzmWUT8kIFIafNLb25SsuFoydmexcBkG/8fwcdjpUWt7KmkTTDL
         Bv4zNrfcpqPOCZLaW9UB9NDxIVYayhPBeEhXRi1dLTAsh2eYulKzx+A6lO5mhlpBmJ
         tOnM60RxzGnjsvI9PbKKs3QPCjgXr/lKNSdSlwPV65JY+HthHfXH1kXXmC4YPCU5+G
         n3lS8dS2H0K4zmqqlhs7eTEDNJyi9rbauzSiTuuh3oqYNLmbtSTCbR1VsPPBmn6e4n
         mVeWtTWWDmkgw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5D05F6098E;
        Wed,  1 Sep 2021 17:39:03 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver changes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS+Lc/G+7JS4c93M@kroah.com>
References: <YS+Lc/G+7JS4c93M@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS+Lc/G+7JS4c93M@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.15-rc1
X-PR-Tracked-Commit-Id: 2e5f3a69b6fcd52a64ce3d746c6ee8390b6cabe8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c314bdfb64e4bb8d2f829376ed56ce663483752
Message-Id: <163051794332.15355.3223966835279830361.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Sep 2021 17:39:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Sep 2021 16:17:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c314bdfb64e4bb8d2f829376ed56ce663483752

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
