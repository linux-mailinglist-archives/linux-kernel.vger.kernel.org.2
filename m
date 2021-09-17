Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0940FDE5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbhIQQa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243762AbhIQQa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:30:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9126560F6D;
        Fri, 17 Sep 2021 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631896175;
        bh=97AS5qCl19Xfhr7IzJyjk9B54i+Z27BCRk3wXDXygdE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zdrr66bn6yZapNHWZ4rabmj3U+9pIL9i3umKSAatdXTqn+pgSwN4D27oF3XrdruZu
         vo95R3l+NMsTLF8hrk1YbMhwiDZUKWnNNMaILbHZ9qTMnvhbtAhaBjffGAyrviRg0E
         mTWHx4Uy85hqfCTFQk/TtYJ2kt9CiYyjh1l1LM2cd7hFZ9aH+ayTIsDmJBXj4jRcR/
         QhxzN76qv8ejEg1cvZEJrGjDaxqJuvwB8Xsm+qX4qeIyPT43tKSx0ZUOw74QsGhBRb
         VQo42WrS3GCIebA3MFMIHqDghljpLUj1GxA1tbbBVIKDffAAi83YKVtoc0VMatafCr
         u2oBiK6GGMFmQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8997F60726;
        Fri, 17 Sep 2021 16:29:35 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YUS33qojC6HpxtFw@arm.com>
References: <YUS33qojC6HpxtFw@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <YUS33qojC6HpxtFw@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 9fcb2e93f41c07a400885325e7dbdfceba6efaec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f2cd14129f0272a3ae983625a1adf2545bdad52
Message-Id: <163189617555.30150.10230862288673763319.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Sep 2021 16:29:35 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Sep 2021 16:44:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f2cd14129f0272a3ae983625a1adf2545bdad52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
