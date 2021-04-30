Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32D73703A1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 00:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhD3Wlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 18:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhD3Wlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:41:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 73B6C61260;
        Fri, 30 Apr 2021 22:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619822443;
        bh=ltlw4Mnq/2KWnIcswxcfQL4T6R3XjwcQKwjWwSt5+C0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FIhTCNjhfe4ugqKiURCyTgTlp27RtVdd2KmuztLwgeO7HskqB6gWIheaQEXvqhblX
         CZXHwF0BlumXKZ3bnlBVbCMSX5X76VujvFSbzvZvC9T7H2HsNNkQQC7KXUwRtV7hj/
         ++h4XdFLKsWZ6L02tDAEHaKJfvxjQU4i2sKnjthbQ7Y6DQxm5dSUJAYdqRW3b9czy0
         LnvFjeV2u7y7hY3H5nrU4WJqPM/ajp9LCiMnBC0kYGqOHMCFE0rIloo7Q9vUp7ugR8
         UjM44ry5ffTgntZMM0IQt+ua74ClGnEhGN0Ao2m+Qq+J4RyxoZFemUQdMx+B8GRuhU
         2lYjXhKfK3EmA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6EA0860A1B;
        Fri, 30 Apr 2021 22:40:43 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210430162803.GA15511@redhat.com>
References: <20210430162803.GA15511@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210430162803.GA15511@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.13
X-PR-Tracked-Commit-Id: 2fd8db2dd05d895961c7c7b9fa02d72f385560e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bab076a3d2ff4298483c1a3b77162811b451863
Message-Id: <161982244344.6177.7505259942347738575.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Apr 2021 22:40:43 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Apr 2021 11:28:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bab076a3d2ff4298483c1a3b77162811b451863

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
