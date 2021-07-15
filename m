Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC893CAE65
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhGOVS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 17:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhGOVS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:18:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1E78D61374;
        Thu, 15 Jul 2021 21:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626383733;
        bh=uWI0EGfCf0YFjzV6kk4x2uFjYgpgQPQSey+uAd+UAN4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HjGb4b2u+2Nh5RmrR1QWdGtMbXaxUDLEfbMCyDuYUNTg1IXqKMXSkmPy5AkphDwRx
         D51TAg+qgX0XN/wFlt619FuZi2a+FgvNlhRUtC+HhB+b7VIbKDyzp8tPPDeRLab76w
         WThMfC5wBCAEEzQ5WNRLHxb+4ic7jMxGvCroSpcIeF2SPFXVQGVc4X3N9DKoV9rQTZ
         r//o0nyXJ6N/beKZyvS2P8zhjqaGfusxdZOoGL3CV7Zw7lwa8d+pv/8h5WUAd5O0uC
         Hw0UtqwO9Mmt6zIR57RtVsDKAEY2PGlldDEPecO8wyRM63pRojyxsoRygl4X2qiBrQ
         Qqi/7jB+gmcHw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0CBD6609EA;
        Thu, 15 Jul 2021 21:15:33 +0000 (UTC)
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210714200523.GA10606@embeddedor>
References: <20210714200523.GA10606@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210714200523.GA10606@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-clang-5.14-rc2
X-PR-Tracked-Commit-Id: b7eb335e26a9c7f258c96b3962c283c379d3ede0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9338abf0e186336022293d2e454c106761f262b
Message-Id: <162638373299.3912.330918314511213806.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Jul 2021 21:15:32 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Jul 2021 15:05:23 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-clang-5.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9338abf0e186336022293d2e454c106761f262b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
