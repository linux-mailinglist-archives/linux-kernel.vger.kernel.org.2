Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAD344FA12
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 20:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhKNTOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 14:14:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236201AbhKNTNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 14:13:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 46F5461183;
        Sun, 14 Nov 2021 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636917024;
        bh=piy9pDv74Hud+/av2JFwfcO7r7DlTTYx0YCc17yz1X4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P0CzMepcmsBFh/7Q3So+ntSjLtAe7qTYoXNCyK4/TIG6ERNzN0sC8XUnZb4YbiK9l
         kzNIZMjUgYfDO2QnvVSV5fPABodOqO9CpQjJUVBa3UxPRwXFK7pdwznWFkYeIKe4L+
         K0+i41l3vR6/bpTZHGgwtVPT+b1aCajpnY1n7uYHeCFBTyGU9tx1i91LRPtLlXxkcw
         2F7fObFcF/Sh9I42dv0PnOYHhQSr+StiiIgDhowHFvoPej/u+bARpWTIYZfipzAqwG
         e14SjzmARVPdRqP/S7OBYelE2EjQE6pMJnmagH8xWcNwulWgLaLX2tvWd5ZQoe2w5v
         ijtzVuxL8FmqA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 402E66097A;
        Sun, 14 Nov 2021 19:10:24 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163689642744.3249160.6971106813056927807.tglx@xen13>
References: <163689642456.3249160.13397023971040961440.tglx@xen13> <163689642744.3249160.6971106813056927807.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163689642744.3249160.6971106813056927807.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-11-14
X-PR-Tracked-Commit-Id: ca7752caeaa70bd31d1714af566c9809688544af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 622c72b651c85cb55bae147debc1a2fae0189b53
Message-Id: <163691702425.341.5066817799658174895.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Nov 2021 19:10:24 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Nov 2021 14:30:59 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-11-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/622c72b651c85cb55bae147debc1a2fae0189b53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
