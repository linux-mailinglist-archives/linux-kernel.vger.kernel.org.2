Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D6B34D79F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhC2SzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhC2Syg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:54:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F25456044F;
        Mon, 29 Mar 2021 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617044076;
        bh=YzFvmZjaX/wip4oYWzPvYrI8AXGqz02EXSFRGlMPYYM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mrBId4TAGmbrErBJW4cm0EqZkmZujzCYT2G6HLDvcxEoxHjA4wm7XlH37gRnX/lLm
         YyiRk6av/JEj/uXtD3lUJNMUAZ/phfMhbXP+5Qs/GPtcSNUuIWw/6G8rHcRSvRJv6+
         UA2jgjL+BNGEYjWStflsg8sKZF5arQX8wOa6Mug7b8+pwnF577kCosud5tVdggVKGt
         U0d+4v18FTPaUzCfHbWS4Q1fYGvBdBzIold9Wlxc5pLM6YBL4QD6OXgO+8cVqvDESg
         CsWwwyuQfAzbnhxHNg4XIkmRlYZhptNejIda/uJPfOM8EZL1VRggLKtNN9Dkdvo1Wc
         ZTuIWdPeVQpKg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E190360074;
        Mon, 29 Mar 2021 18:54:35 +0000 (UTC)
Subject: Re: [PULL 0/2] xtensa fixes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210329183648.2277-1-jcmvbkbc@gmail.com>
References: <20210329183648.2277-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210329183648.2277-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20210329
X-PR-Tracked-Commit-Id: 7b9acbb6aad4f54623dcd4bd4b1a60fe0c727b09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e43c377a79f9189fea8f2711b399d4e8b4e609b
Message-Id: <161704407586.2458.11452674669614615418.pr-tracker-bot@kernel.org>
Date:   Mon, 29 Mar 2021 18:54:35 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 29 Mar 2021 11:36:48 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20210329

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e43c377a79f9189fea8f2711b399d4e8b4e609b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
