Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793DB3BDDFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 21:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhGFT0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 15:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhGFT0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:26:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C7F4D61CA3;
        Tue,  6 Jul 2021 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625599444;
        bh=hbqGc4nB834TtbSX0HdfhLh1wNo0K/OsNN3HUI2wCNw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Fw4ouExBbDuUWxspiBWx5u7+Nc1jSta4v2nJGLi7i3HEDKHzF3B4UVLZgM8ucnQ8z
         1byAGvG1vIe/wtT/E3VBzJ87nQnC+om1RdXihAtYTTctgjGx0Y/dqKOqLR8gdR2UvW
         pBfAymDKUYpeWBxo/iYRBCgHUB3zRNJ9M+6jbsqMsrcGeEdvo9/2ybZeVYSs3PrZQb
         wlIV9j6RLezHuZPZcT9tY4pBxf1FA+kKLPAHbR/v6ndnIEhRxa75892lgTumdRLjAP
         W/qp86zng5nqNrs9k1TeKJYLcx4L+vNbfQ305oqvZs9uUStfpwy53l1ch7p2/5+WZX
         f+SNBLA/I2O+w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BF49B60A27;
        Tue,  6 Jul 2021 19:24:04 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOP6x0Mz8aBv9x18@antec>
References: <YOP6x0Mz8aBv9x18@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOP6x0Mz8aBv9x18@antec>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: ad4e600cbf897f47525b342cd4b02e88ed300a83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c55e2aeb8082cb118cd63596bfe0dc5247b78e1
Message-Id: <162559944477.10101.2678805799665823956.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Jul 2021 19:24:04 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Mateusz Holenko <mholenko@antmicro.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 6 Jul 2021 15:40:07 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c55e2aeb8082cb118cd63596bfe0dc5247b78e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
