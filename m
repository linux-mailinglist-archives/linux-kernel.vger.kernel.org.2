Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E51C396678
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhEaRIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234111AbhEaQhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:37:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B63BD61001;
        Mon, 31 May 2021 16:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622478975;
        bh=Mezy7H2tCMhECfHbd3UpB+8mJv+8iSgxjTCIgJ/iOdQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ni2truIEHnvahYsGHQzX6uWu5WsZ/DC0GZlj7YQ64HJkWtNmC52D2A3mZbwldLT1A
         meI1jECVX2eGGpfYNh54v4b50APVPuznw5asytkDQhUL5emXAFxXvgNZCsj37Mp1kI
         kyL2VhXHamb0U6AS+kUaQXH5MwDPRD3AweMwpHkjMyIFpGNyVT6I2LEzXSlJQrEBAo
         pDOqAL8M5ipHhx+Z7X1viOalxeAy8+6abDqkWXGHBSbACmhevbnbd5UeqY3UVIHiql
         1vMjnRWgajyAIFEnEbUmSy6Ue5t7XfBNqb3PjvnatFT7lJuCVmaD/gXl9HD7+gDNu/
         sKRZuqkxaPFCQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A273D609F8;
        Mon, 31 May 2021 16:36:15 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes for v5.13-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210531105606.228314-1-agruenba@redhat.com>
References: <20210531105606.228314-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210531105606.228314-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.13-rc2-fixes
X-PR-Tracked-Commit-Id: 1ab19c5de4c537ec0d9b21020395a5b5a6c059b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2131f7e73c9e9365613e323d65c7b9e5b910f56
Message-Id: <162247897560.1691.17343243407637008255.pr-tracker-bot@kernel.org>
Date:   Mon, 31 May 2021 16:36:15 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 May 2021 12:56:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.13-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2131f7e73c9e9365613e323d65c7b9e5b910f56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
