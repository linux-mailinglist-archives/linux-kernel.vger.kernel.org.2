Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13B93F3C13
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 20:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhHUScB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 14:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231136AbhHUSby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 14:31:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 654B061246;
        Sat, 21 Aug 2021 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629570674;
        bh=UCiEayyDdLE9DEGZy1L4YpimBVQKswt+O5qdf67QIio=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dk28kcifsXccUHhHDQEfDzmf1WxkkVBqGhn//rFY6h8dOpMEy9qguqA3ITHTcpckB
         UEXXwIe/b/+yd/tUufx1vZKaUMw63cKw/GvjIwrOA4mhjbur/yFMjr5L6L+w02z4Ei
         pHYqzlvi8oLizWQqXtArUUKjjOcszA1M9q80lKvYOUGhPo0HjbdgjFxHTKkZQXyiXr
         XgRWqh43OoTUniVgV0jVGDHHJrgot5PKLl8WIrWp4cfyF/kcwz9HBy3X7nod2Y2bVj
         z00N1Xxwy2mbPELkFbwTWx0afrYeN6+r95lzzgtUIplvIAY7+3FC3BSpwqnHp7WilA
         oYsZAL0RjRrOg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5C3B360A6B;
        Sat, 21 Aug 2021 18:31:14 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210821181058.131854-1-sboyd@kernel.org>
References: <20210821181058.131854-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210821181058.131854-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 9711759a87a041705148161b937ec847048d882e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ff50bf2f2ff5fab01cac26d8eed21a89308e6ef
Message-Id: <162957067437.18934.11338507944975733560.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Aug 2021 18:31:14 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Aug 2021 11:10:58 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ff50bf2f2ff5fab01cac26d8eed21a89308e6ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
