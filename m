Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63B2323391
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 23:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhBWWEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:04:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231274AbhBWWD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:03:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8560864E83;
        Tue, 23 Feb 2021 22:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614117797;
        bh=qXgHVdDI0nrNqq0FheRYPVqKFQLP9eRIsfNfhds+6gM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ay4ks9vfeKJg74+rPlN4gkGIAmDCsc619D+jwNjQsjlI5gyCyaHTg9lXNHFU9kKCV
         xDq0ZQqRDOQLt4JhjKoS9EldWH10CX/qBkaFd3x26e+Isik6CTfrI/r2k/vaHZz8tu
         /7+40LxsclbosNjjxX2SvribGLMdQ+dIOLyHlx4TshNTR4+tT03sOgZPRyFIfUfjm1
         ywuB3t+YAF72xeeqytsEaqw4M/01PZpwgq82C1aHXjyAoTe6zSoU4AUi5OMwg+SVqD
         GjIVn20s1qmnMHfb/kDjnn0mMiPkggGaEH5Zj8KWYTOvuEf7A4k+yD8+sAyLCtRzun
         XrYnOMJG9DPvA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 652AA60176;
        Tue, 23 Feb 2021 22:03:17 +0000 (UTC)
Subject: Re: [GIT PULL] idmapped mounts for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210213130042.828076-1-christian.brauner@ubuntu.com>
References: <20210213130042.828076-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210213130042.828076-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/idmapped-mounts-merged-v5.12
X-PR-Tracked-Commit-Id: f69e8091c4a2ae291e1f55225e8116fef05dc156
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d6beb71da3cc033649d641e1e608713b8220290
Message-Id: <161411779735.8064.14963452396457007430.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 22:03:17 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Feb 2021 14:00:42 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/idmapped-mounts-merged-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d6beb71da3cc033649d641e1e608713b8220290

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
