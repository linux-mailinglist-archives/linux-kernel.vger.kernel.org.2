Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A22F36E206
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhD1XN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230245AbhD1XNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:13:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BE85061448;
        Wed, 28 Apr 2021 23:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619651586;
        bh=3QsFZO7adFF4QOytGPgACDi4PZVkCcqhTzgZL8eQay0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bA5MskuhglNBA8NPCuQ5/PgvDAnraR6potdDuOLGO1dow5EkJJYL8rkhUJNkMq8Lb
         IrS1Tl84MLVuqjRTlVFVVYiJlhcKGday6GOsfUeyUeqfo+Ok9crUcyG6EL6LhkxKJ8
         UmpbWQjB34RCCwb4NAvbpWSPFpJT0Jtjqw4Yk9MfWnaz0E5UsstwbxmEzsre5W6xj/
         nGIAaIgEQ2mX0cNXnfj3285joqM5s95Ns70NuXMDaI9tsR6HHY3ebtWvmoVa5vWt/2
         3eWI7O6a6l+aBsFpAcT5aBtZrp+0LvxvSO/j5dIA9PgtQCZCMDN1EBHvROdl+LzwVr
         fr4znZB9+bGug==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B491760A36;
        Wed, 28 Apr 2021 23:13:06 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for hsi-5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210427184955.trmszirmcqlv72te@earth.universe>
References: <20210427184955.trmszirmcqlv72te@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210427184955.trmszirmcqlv72te@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.13
X-PR-Tracked-Commit-Id: 5c08b0f75575648032f309a6f58294453423ed93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8b5e037d8a00d396377a97f08f5fd2a410b96a1
Message-Id: <161965158673.11634.9329671715851509085.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 23:13:06 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 20:49:55 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8b5e037d8a00d396377a97f08f5fd2a410b96a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
