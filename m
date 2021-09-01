Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8F3FE064
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhIAQxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344251AbhIAQxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4DB3961058;
        Wed,  1 Sep 2021 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630515128;
        bh=RbvbxIEYnH3J2SmzfIM291yjJNX+agc0UgFMiIgA4MM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O4TZNf+YgWhMNLYgdHrUzp7TftFi6sz8uAKKxUOxxlzwffjkeg7XSyS14BPzJbx8h
         in7l7VuTlobFUEuMm7ioPhaHErOohV7Etp/snBQ0yZrepDphJIrZs6CkwvrSVX/KPt
         2bljm9S7pq66BxlsHwgYf3+wWb3EPCIZT70QDMuLYTNNqQWANX7TafXYEK8mKFUFOA
         J0HV4v3cHK0kpU7R6AwhDcgTtVPwDEo9Cp342e60P6grPB89dhd7nTi21P+XQUM+zY
         hDQI+M41hx+cR7JoWwRp0c3SHcWQlJ+UP8UxLBF+P4pF7m5erjKm3Oa6WXwGDNEQ7a
         q61gDTsno0QXw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 47C9D600AB;
        Wed,  1 Sep 2021 16:52:08 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS+LQJnyf5w93K+A@kroah.com>
References: <YS+LQJnyf5w93K+A@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS+LQJnyf5w93K+A@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.15-rc1
X-PR-Tracked-Commit-Id: 049d1693db78144c979b34e2084287ada912cf7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6c3c5704ba70820f6b632982abde06661b7222a
Message-Id: <163051512828.18728.15364417774736831907.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Sep 2021 16:52:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Sep 2021 16:16:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6c3c5704ba70820f6b632982abde06661b7222a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
