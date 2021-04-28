Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE6136E20D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhD1XOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhD1XNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:13:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 685346144F;
        Wed, 28 Apr 2021 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619651588;
        bh=Gglvvlgr8oeAHZcxVaZ6S6f1Bnd+bQzW3jgsDnznvy0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pk4XJOqE7a40shqXq4tINv8TN3pbqK4vN2FHFNZQj/rXTdAme0+sNqYFfFkbfXtlz
         CWVxqUwxPxZdhWxXscQGKqaOxxJrR2sgE5Ob17Dpdc70WkF4L/DR8GvuFFyp3jmapi
         mI0oN5hzf46q5FSPbDp9ZTakAzgoJz6XVUAsmlhhjsvOLk/HO4MqAzsjgSv2UL8S7N
         QTkMaqXwkfZ4fhVdnkqdd/viuY/NEPAVCg4APqhNkO19P3SFkXvEhUyGxhio3OZHP2
         U6B5vGJwd1ylWDZv3GHQ9BSfoWHjB++fR2KQlEe54/FnEGi+WEvITp8c+c24WUjY1C
         Xh/y6JTUlnEfg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 629A160A36;
        Wed, 28 Apr 2021 23:13:08 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210428085940.GI6446@dell>
References: <20210428085940.GI6446@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210428085940.GI6446@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.13
X-PR-Tracked-Commit-Id: 04758386757c1ef339b18d996976911be61d5efb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c969f2451b5343a01635d35542f48bc14b44f6b3
Message-Id: <161965158839.11634.15910125722040690644.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 23:13:08 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 09:59:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c969f2451b5343a01635d35542f48bc14b44f6b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
