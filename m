Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871F13FBCAB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhH3SsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhH3SsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:48:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5622260F4B;
        Mon, 30 Aug 2021 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630349234;
        bh=f1Lf89bZjXUS+gMu52vGLWP8O3I7J8rzhMflo0m3DQY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=urVj48rS1J3YwBQt3y2MVFwe6/7H9Is0V77jcjLChga1BntR8QucQK49YEUsnDreD
         +ZuEhIL6QiTwcZ3wYztO9sdXYH1KgLqo/uI5ll+iaUDD+dDhXGq61uJ9Uj1AjeFBrV
         XLL219HWS49uequpksb3AZHgxyls5v9BCeulFdCUMQqRIf5DOtq5DMJNNgiCWRiRng
         Wt3xNpJMnjB+T+xgWfV/gkRJW5smTXfp/bgFMkUjBRnor7lfZGypNsFItgdWpf4wj2
         /YH5r8M3b/p8j1PHxl1WGLHnhIZKeWHVy7h1J/M9wfxlW/wZ0QBxxEnQfR+4CJQDsf
         K+RJsQVxdIx8A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 49D0E60A6C;
        Mon, 30 Aug 2021 18:47:14 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210830125104.DE356D1B482@fitzroy.sirena.org.uk>
References: <20210830125104.DE356D1B482@fitzroy.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210830125104.DE356D1B482@fitzroy.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.15
X-PR-Tracked-Commit-Id: 7aa6d700b089d960a03f6459898c096f4346990c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d46e0d335497d89e36a8dab3ce5b605d7088c67a
Message-Id: <163034923429.1022.4445064346004210243.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 18:47:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 13:50:53 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d46e0d335497d89e36a8dab3ce5b605d7088c67a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
