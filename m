Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75623FBD80
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhH3UmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235102AbhH3UmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:42:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E819060FA0;
        Mon, 30 Aug 2021 20:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630356078;
        bh=p3e6Aftkkq/0e0mifbDrIxrJgaCAO2qbmEuKCJMgmhA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dQVw6cWqbNENyrfsaPjAPfxUa0vQ52L7/BlhdPSGe10TbCKM4K4jhvS8HVw+pUDTo
         dI3TOP2UxhztYl3WvufsYy8YzUqUT6J+zzBdgAX0yvg2O/oKGKuyYaQutRdTZMqEjr
         THV6oY6EeEfTtfTcINZUmMnb1wPjHB2+v8Kaw5C3dgOWtN1DDiypMWEOKrxQb1Qn5D
         +Nc6VUdVcSwG2Zpux4C8xRsI4vkK5MJyUM9Ar3PaBAU9s64DOoF88lFf7prlJEVWvv
         j1qFdmlENOZX8ItVLE+56l2JW2ljmkUKzhCAv6jbiYc9cDyPzONei6/sCRf8Bnnyug
         NYBoDEUnj3eIg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DE16160A3C;
        Mon, 30 Aug 2021 20:41:18 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build updates for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSyqgcGmQckC60DH@zn.tnic>
References: <YSyqgcGmQckC60DH@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSyqgcGmQckC60DH@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.15
X-PR-Tracked-Commit-Id: 081551266d2fbf6ce69a30c13a355ee476b2e745
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ced119b6308df8ad2e4345e88f94d2bdcd6d6d4e
Message-Id: <163035607890.29257.11504198918641580570.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 20:41:18 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 11:53:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ced119b6308df8ad2e4345e88f94d2bdcd6d6d4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
