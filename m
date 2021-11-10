Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C1B44CA3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 21:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhKJUNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 15:13:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232631AbhKJUM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:12:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 967BA6109F;
        Wed, 10 Nov 2021 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636575010;
        bh=mQZBte6YnnhraXSL2YjivXKRttuoFbSxPka0ggrNl2I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gTu/uF+47p2Uyxn9kSkARlH5KyZpxcfGMlTOAbd7Iq/S5lHseiSZeK3dvmePoTBTF
         deyI5K4RiSoroPhQHHsATrr2QfozZiEnW/tKeXR5eFpFO5XsQgXJWVwKyk0ykcDcq9
         z5MEbzmSgQkCIQv9Qxbw03qd65EYGwKIf3Lzt55Sc0PJl/0TTV8HvA/M27HVnH1muI
         Fk5k8jc5h3bzDbICyIH63Z3SXAHQMC3Fxjmcgo85/Wi13rGBAurOgQbETZyXTL5rxC
         sftiTafGeHxFOJa+qcjNzF7NbeRzZ/WZCCYTadSQV711CxQ1XdGVlf67m1C7UXvAwA
         maZabF9IS9Jug==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8F31C60A6B;
        Wed, 10 Nov 2021 20:10:10 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYtbKoSFCLzvvOUZ@google.com>
References: <YYtbKoSFCLzvvOUZ@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYtbKoSFCLzvvOUZ@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.16
X-PR-Tracked-Commit-Id: 297d34e73d491a3edbd6e8c31d33ec90447a908b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4efc0de00fc10a805ce991ceb6a94ed837a6e71
Message-Id: <163657501057.19350.8434517700338649294.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Nov 2021 20:10:10 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, pmalani@chromium.org,
        bleung@chromium.org, bleung@google.com, bleung@kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Nov 2021 21:39:54 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4efc0de00fc10a805ce991ceb6a94ed837a6e71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
