Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D543063D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbhA0TKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344213AbhA0TJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:09:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 91AF864DC0;
        Wed, 27 Jan 2021 19:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611774522;
        bh=/f/xj5aM5a5bRUtpOaT08vnk1gauFpcfVrZSJxcZmHg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RccW/k132Oe0M9fwI1NXxZPFhV7efXigp/QPojJXhyPMDQBefCEjIg0Co6LqivL2O
         uCEAWDoYRNUvF0RgDa1cbroEXEes7fuMfyG+G0iAGw+Iqw5U2mODzYHr3U8u08W3RW
         gprA0eVofzbS2nAUm9pL4Myx9D5Ajt+LHw4zpPQaY0BXVOlk6d44j2nn0TdYhCc3yO
         Uuqej5wdRJLG/CnuW4hh3Fh1H3MXXDVlLtpMJq+xARz/UzIYzznc0r3rjj8m1G66NN
         Vkw5gddZsgFEV0njIDTv8WhisVVC8R+6p3GFa0yok9AQ3/5JiFb855pK7mp0XJoRcd
         ky3ZUr+0F2aAg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8C78D61E3D;
        Wed, 27 Jan 2021 19:08:42 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture updates for kernel v5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210127155622.GA13805@ls3530.fritz.box>
References: <20210127155622.GA13805@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210127155622.GA13805@ls3530.fritz.box>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.11-2
X-PR-Tracked-Commit-Id: 00e35f2b0e8acb88d4e1aa96ff0490e3bfe46580
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76c057c84d286140c6c416c3b4ba832cd1d8984e
Message-Id: <161177452256.15019.4593802395711492824.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Jan 2021 19:08:42 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Jan 2021 16:56:22 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76c057c84d286140c6c416c3b4ba832cd1d8984e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
