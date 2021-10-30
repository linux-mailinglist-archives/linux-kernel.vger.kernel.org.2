Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D086440BA7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 22:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhJ3UuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 16:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhJ3UuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 16:50:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A1FB260F23;
        Sat, 30 Oct 2021 20:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635626858;
        bh=i/ZGFbptHLhRgB6xZcC/8NSXylXprVhdd1X9yDdng84=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OW2CfkdKT3U4MGoJ5Y6Jie1qTkixvOoT8xG2/yIvMM0+qsfyqYK0wBEh5hSjwyyn9
         qRcx9X7GqH+yaUKTyKKGkw7I6w5+bvX65q/CYfIZnZW7sug64473okqUtVI3UBBz5i
         v3ujIr552JTl6w7zLxacrrUcVcBqUV2aS/5EZf5H6jqsVRSes47roC8cZrR1E1Sz2y
         k88GpVz9guUYOBx8BHtM+25BHlvcY8ILJHhuMNmP8M3ZqgA5NHiURaOqkl9zlz/Npq
         VVRr3L1997NxdYZGtXyU8XYYelvUX9+vfEgesidgloa0MGlVM+Voh5UeE0dzUh2GBi
         NrE9VPTmo/0FQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 96B1B60A38;
        Sat, 30 Oct 2021 20:47:38 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.15 (or -rc8)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-5efadc14-a2c3-4c9d-a383-8ecb782399e7@penguin>
References: <mhng-5efadc14-a2c3-4c9d-a383-8ecb782399e7@penguin>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-5efadc14-a2c3-4c9d-a383-8ecb782399e7@penguin>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-rc8
X-PR-Tracked-Commit-Id: 54c5639d8f507ebefa814f574cb6f763033a72a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf85ba018f9229ce54765a62dba2dea60f7cdafb
Message-Id: <163562685861.6976.9088395794636907661.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Oct 2021 20:47:38 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Oct 2021 09:05:40 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf85ba018f9229ce54765a62dba2dea60f7cdafb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
