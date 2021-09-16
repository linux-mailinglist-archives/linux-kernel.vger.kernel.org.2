Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFABB40E9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345489AbhIPS1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350147AbhIPS0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:26:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0448661139;
        Thu, 16 Sep 2021 18:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631816730;
        bh=ZYqBwGltxcKMXg1LbmHuud9yrx+hU10ks2ZF3cTUY8c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EbPworgaq8F9kDlzLu74yigw32P9x2JJiM01MqqOvvZMQD5yIO6O0bSu5BWf8ZhZn
         sG0OXv1YM6FDv2BFsz6T2fhBVLPv7PtKdceLjwm/bQ2sFOrCHantv1iZxGWQcquWB8
         TO79526xfC1V0shIWQtTBtSMz4zQ6oBwtx5FQUp3TuubjkRbwBFJDw6brZaaf+jMX4
         0+E0JJPcj9fQh4glpOeueZadLfNaDU4nwljhJZWNHowKLz5GiwWjsKTiAWjJ6dG2Kf
         7djuYW1TlCEhpyi6rYVOTtHgSqfhcxubDxx7fdOkN1h7eh6WugtQVGpFsvhN03CUqw
         riLHd/DwAbY/A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E94F760A7D;
        Thu, 16 Sep 2021 18:25:29 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture warning fix for kernel v5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YUNi6hTcS8nUrrpF@ls3530>
References: <YUNi6hTcS8nUrrpF@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YUNi6hTcS8nUrrpF@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc-4
X-PR-Tracked-Commit-Id: 90cc7bed1ed19f869ae7221a6b41887fe762a6a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fe983d3f1a5b103fc00a24f9e0408302e60c39c
Message-Id: <163181672994.572.26987069234257056.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Sep 2021 18:25:29 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Guenter Roeck <linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Sep 2021 17:29:46 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fe983d3f1a5b103fc00a24f9e0408302e60c39c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
