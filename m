Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813FE3244B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 20:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhBXTid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 14:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234317AbhBXTi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 14:38:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B5C2164EC4;
        Wed, 24 Feb 2021 19:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614195467;
        bh=yTmI1SK9IK07/gVZ0SM0XXsyNEz5IRximdjuO4rObQ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NPiOVjN5nJMq1k13QXpBYgU4cbqlK9fkFen8EvEStdABRIDPLCAUxhTO0PmgPIzGa
         3MlFHDBTy7/4uspELtuo089lhmXdpNW/nV0ntZuPoXVDG3Wer3sn27V9YEaTTOJgst
         V/x0uymjOfYNOW6rY3cYNcPu9RnWnrpW6dLUPnut+tb6+cwwNHo9WBvJawGIbYuTv6
         vT8tketrd31tgloIHoyFjGYr1q7Q6tVQtRbTbf6aYlqrk+AJbYW99wtqd2VSOwnnTn
         1UH70W/07QDEF1Yv03+UbkHls5DRwmchvtzE6so+IB6h816HMRqHZVmQXPzM6vKDOE
         sGV4DvmdSHU/A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A18DF609ED;
        Wed, 24 Feb 2021 19:37:47 +0000 (UTC)
Subject: Re: [GIT PULL] hwspinlock updated for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210224191715.192575-1-bjorn.andersson@linaro.org>
References: <20210224191715.192575-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210224191715.192575-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.12
X-PR-Tracked-Commit-Id: b9ddb2500e7e544410f38476ab928fc2fe01e381
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 890caa39a95933f6af3ed395f2a8a3db1fb0a85d
Message-Id: <161419546760.19197.13115632649140626529.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Feb 2021 19:37:47 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suman Anna <s-anna@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Feb 2021 13:17:15 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/890caa39a95933f6af3ed395f2a8a3db1fb0a85d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
