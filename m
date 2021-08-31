Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7973B3FCFC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 01:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbhHaXBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 19:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240688AbhHaXBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 19:01:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 27F20610A2;
        Tue, 31 Aug 2021 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630450841;
        bh=7iC/Bw2ja5qdbwOtyPYkwmaD+7Bs3ighE9cT0qmrzUI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y/c4fhKOqGQrrfFE9bCFMdScNZBRPm28B1DNr4CEqHeIhKPGlNK2THjJ8xaiQbGuw
         lf5zGpbfmtMUXLIgZQFJfd3IpRdaRpKlpVnFwwzJR9QK4rfq458pQw4sdAFW6ljO0w
         Uy2k0RUEfR5FOIvZftC50Uaem0bY/rV6DUoUO1VnbAoqvFqdQAUPDJ3oGwZn9G9Pqe
         mRrfxMEsUy4KiSLxYH0UeO02Vz23pkHYlOHNhyHZCPGLswwaT619d0PLG0HT8D7pRw
         eIzYoMgiQHwMseiAxZW6Ke6X+yZHuPyTpypugVUoiSRcV/Ibi1kOe2mi+VrvX6SGPl
         XSfdltky4jm/A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1B6B660A6F;
        Tue, 31 Aug 2021 23:00:41 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue changes for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS5d75CpAWb4aUOP@slm.duckdns.org>
References: <YS5d75CpAWb4aUOP@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS5d75CpAWb4aUOP@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.15
X-PR-Tracked-Commit-Id: bdb0a6548d2233dada752109a71bcf4c9b8ae6d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86ac54e79fe09b34c52691a780a6e31d12fa57f4
Message-Id: <163045084110.6589.5078338315051686101.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 23:00:41 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 06:50:55 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86ac54e79fe09b34c52691a780a6e31d12fa57f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
