Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B6E35AF2B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 19:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhDJRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 13:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJRDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 13:03:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7D242611AE;
        Sat, 10 Apr 2021 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618074210;
        bh=Qlpuzzsjm1zFdj5YliE4YG7nruI3C7EE1C3ufI4t2FI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NUKwUsOuD8CAMZp+Jb3HWg8sDfPhkv4uv8nZ21ncwWC9nVGAnNyXH05v9LTNvedkP
         N6D0C6STSOTolUykaNIqVW6dIJNbQoGa7v1YNaGHnvop6cQqI6VYzuCFYV8jBTyah/
         pMnTsuaLRi2t2hrpjvZeySt2AZYLNdhHobE1KS2mUOEZ5QfNSqKCcu0mdEHuQ0jxAg
         4ROJP856oq2NW6TzPd4PW23OJn281CtH44E8jmaQ90w2otFiXEc2X+ZRT26U458BV+
         fs77nb8KwvrbezFlF8GyW/ZXaTYsAjOoyfZoeMbwrQC95PqjOUYEst0olDn6XSiJrZ
         c8zf7a2AYAKZg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6785160727;
        Sat, 10 Apr 2021 17:03:30 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver fixes for 5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YHGivAMSbiL2Y7je@kroah.com>
References: <YHGivAMSbiL2Y7je@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YHGivAMSbiL2Y7je@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc7
X-PR-Tracked-Commit-Id: bc2f3e4c662841dc19f7e7efae87782b9f3c0831
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 445e09e79743c8ba01f1e9eb6b10faab5a92a5c7
Message-Id: <161807421036.30985.2882771287219457048.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Apr 2021 17:03:30 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Apr 2021 15:06:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/445e09e79743c8ba01f1e9eb6b10faab5a92a5c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
