Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8BA320CB8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 19:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBUSkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 13:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhBUSkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:40:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 498BA64EE9;
        Sun, 21 Feb 2021 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932782;
        bh=mi6x5MBE2+LRZ2kcKtoRBnpU64+odAVPKOamHqfu3cE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jk/Mq+Sn+ZkvJUXqEPqlK0RO7YCPtWZMZNov0rP1NK50dQhSHYGEILAusfon0ZcZB
         +9PlxDmwf5gP2r/hT4gWSSP3zz1/6hNAQMfXdnxfBtWGy/jhaoeEoowvJ9QqeciQEA
         uzEH9BO6hUbHQGUIL8MzD70Pqx60pHjrtc9nvTjget7E+4yt6laq3KrkyszsSgoxAD
         rJy7qixCJEYshdoZTUD38G04x9bn+h07m/p7eLnVxaT5XjPfKud1KQUszthrz4iWuQ
         XwJsApbW1BtIuQT8NqdNzXxlA7DdGpl1UVdFRFNNunB8wI3euccyFSgvK0yRQId6LP
         clhDVyCxG6T+w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 45A6460191;
        Sun, 21 Feb 2021 18:39:42 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4605002a-b275-1190-c56d-7d888aa770a0@oracle.com>
References: <4605002a-b275-1190-c56d-7d888aa770a0@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4605002a-b275-1190-c56d-7d888aa770a0@oracle.com>
X-PR-Tracked-Remote: git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.12
X-PR-Tracked-Commit-Id: 4208c398aae4c2290864ba15c3dab7111f32bec1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d88e8b67a6f2f6dae41c986ed58cb1955e0179b3
Message-Id: <161393278227.20435.11982601908255141368.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:42 +0000
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 10:05:32 -0600:

> git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d88e8b67a6f2f6dae41c986ed58cb1955e0179b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
