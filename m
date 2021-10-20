Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE074434FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhJTQSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231283AbhJTQSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:18:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 497C06139F;
        Wed, 20 Oct 2021 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634746566;
        bh=YE7Jt7aUOYFau65HPHt8oTB/a5uGLFYVuneqwzHdIbc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V7j8L/qr6FoonWtWo2Y5LwO0DevgeLUaV2j3/LFr3vxfHCqmKgCXoDqYxHESCbEpd
         E7rTRj/91L6I1Bzfz0yMRfXaZ9JDDz/Pjh9FGvYtQ6Cq65Pe4eFgeHDagzEm9oJ2UK
         dQ4KBM4Omto+QtBJrrEoOlpU86l+PlWtRybokrLCsLuBqUxCXW5Rj/5KQIuynCMNzu
         NyruK6nCbcZgZRVlhcPrXUNyCrlAXqenYFqQDzaa/AxqMt1SnOnR2K2QBVYlG3EfsM
         gq2c44kUj3npBpYM8ItoecNywjEh2g5VXdAoCBrNOVmW3GCZYyWMws+R5IzRbHkdkw
         XUuHPAnbKATSg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 429E8609F7;
        Wed, 20 Oct 2021 16:16:06 +0000 (UTC)
Subject: Re: [GIT PULL] NIOS2: fix for v5.15, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211018195945.2462739-1-dinguyen@kernel.org>
References: <20211018195945.2462739-1-dinguyen@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211018195945.2462739-1-dinguyen@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fixes_for_v5.15_part2
X-PR-Tracked-Commit-Id: 4cce60f15c04d69eff6ffc539ab09137dbe15070
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e59977463e9894e3d579d4e1e2a1dc81f456633
Message-Id: <163474656626.19537.10781489373933987513.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Oct 2021 16:16:06 +0000
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     torvalds@linux-foundation.org, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 18 Oct 2021 14:59:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fixes_for_v5.15_part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e59977463e9894e3d579d4e1e2a1dc81f456633

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
