Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2AB3B6D29
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 05:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhF2Dyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 23:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231809AbhF2Dwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 23:52:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C1F2A61D49;
        Tue, 29 Jun 2021 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624938628;
        bh=q5+ETST3lr0SOPluRLqn4pfdPl4P7hCHDR5CTam731Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ddZM84BZjwU9md6ZLDvFiwmyfCs/PzQ0+GCwWLbqr2I0OmxO4vuSudWuq9GQAz2nb
         dUKmzscO5qyIe8+nKJbkxWmowjKOref6smxBULwZ1zt8As04e0E3dZ4thp6naWv7Ii
         98rHtMEtjRm3/xNqQTEse73MGNWeCEnKonzef/4R7hsN3QmXaYL9vdsvsXVGhKXLFu
         XpRRcWelFwWoCKhX8T4jXmgkwUT/2BAi9fKnCI69qCXV1TdTzafyFiYp148msVBWo+
         4AN1diJYm4lc+PiZ70e4efqunCXiKeVGXtj1W+L7ahAVYNeRzmt8ACjwxEfGbm/9bf
         2yq2TyPOuQB3Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BBAEE609B8;
        Tue, 29 Jun 2021 03:50:28 +0000 (UTC)
Subject: Re: [GIT PULL] array-bounds fixes for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210628212059.GA11158@embeddedor>
References: <20210628212059.GA11158@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210628212059.GA11158@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/array-bounds-fixes-5.14-rc1
X-PR-Tracked-Commit-Id: 13dfead49db07225335d4f587a560a2210391a1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e17c120f48f7d86ed9fd6e44e9436d32997fd9ec
Message-Id: <162493862876.19305.728597162587544293.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 03:50:28 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 16:20:59 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/array-bounds-fixes-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e17c120f48f7d86ed9fd6e44e9436d32997fd9ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
