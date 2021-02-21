Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF57E320860
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhBUFLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:11:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhBUFIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:08:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 47CF564F14;
        Sun, 21 Feb 2021 05:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883996;
        bh=b6nHWkL83Bz+7i55JTWx3ZCPf3uuS5tHVDRY5jfCea8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g3yM9D4xos9i+n8rXUE5xJSEUd+MOf2TAYJgYOl9I/zpvhFabn+fzU+COl1XQ5EAz
         qg3JlP+nhjIOAdn7QqxEj3gYzKYCK+QZEVmBzdWu1yE5cu5mLNtcuqk66nvUyfcPD4
         1v8yEVFwNaf900d+JX3iXVdCrT2o65w3P9DsQUV8eUw4yyqNSifgEEeu28eMvheZ5i
         gVf7kCRciVwaW39kKkgk3feUrNvsSayRL/m1VNmuQkZBlLSrdw2kSq0PW1+8Io7tR5
         NTwBK2ECTVDRvfa5eJ3Fvr6ug6KhZHy6NMoGldTn5t9e0blhK+OE9yA0v7+lLAKRYd
         NgeopjPtCqBOw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4036160967;
        Sun, 21 Feb 2021 05:06:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/fpu for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215115214.GB7265@zn.tnic>
References: <20210215115214.GB7265@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215115214.GB7265@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v5.12
X-PR-Tracked-Commit-Id: 0a74d61c7d842b583f33f74d7a9e93201826f4c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8831d718aa5a9540aaeb527a582af5fc140aed6e
Message-Id: <161388399625.9594.10207365495061591455.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:36 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 12:52:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8831d718aa5a9540aaeb527a582af5fc140aed6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
