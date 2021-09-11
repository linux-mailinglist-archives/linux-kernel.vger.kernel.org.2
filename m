Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B4E4079E9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 19:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhIKRbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 13:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233603AbhIKRb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 13:31:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3FBE561029;
        Sat, 11 Sep 2021 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631381416;
        bh=nuuft++NUwoZlt5wp98zZgiG206MD1ZMESgbISB+iE4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YWDFWY8hkrQwFvPyfowflXGMixIVgnye6YHaP1ZQcyFkBM6dO6EJ9GSOJLfLMi4Kt
         SS36cXDlO0GBcdBqnFQKwvf/nUuf+oS7Pt+HkVvIEKxc7En3DVKZy+8xTNqd6e6TVP
         vzpabL8WtAC1A4/dySwPlk8axK2BVWQfq5I9GSgI4rmLZVUj3nexOde9aOUi0P4Byt
         UhfEgdFO71A5XZYQfVSGdhFRElIeTWpGme8Bo0E8xDYka9lEtJTk2znILjISTDp/Ei
         mCRDVuI+gH1S576rDcaHRtiRMuecjAxpy4u6kGgRX6Q7xx433NQNoyN7+l4hLQ8wMR
         JVxlQiD/dXjKQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3A27A609FF;
        Sat, 11 Sep 2021 17:30:16 +0000 (UTC)
Subject: Re: [git pull] FireWire (IEEE 1394) update post v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210911134236.58da0be9@kant>
References: <20210911134236.58da0be9@kant>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210911134236.58da0be9@kant>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git firewire-update
X-PR-Tracked-Commit-Id: 54b3bd99f094b3b919de4078f60d722e62a767e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52926229be069258440c39de063fcd4a5fd75d62
Message-Id: <163138141622.31861.13677477113703536032.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Sep 2021 17:30:16 +0000
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Sep 2021 13:42:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git firewire-update

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52926229be069258440c39de063fcd4a5fd75d62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
