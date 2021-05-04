Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AAB372FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhEDSbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231917AbhEDSbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:31:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9E642613CD;
        Tue,  4 May 2021 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620153006;
        bh=9lxPgHGx5wlc/a7dJjiB1qI1M5VSOv7t8rHQd0H0jHc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FPXZI2AcmpVoELYQzq6Vx7whiUIvXvrlG9q4A5Xu+suObGNgT8UZlyCQOwFyO19x/
         N3BHu1qSzrzhKkizCmjKaJu56tzqaAqDziFg+SJlF6xHdVNb6vN1IQKSehTDnt8Xu1
         smKvJpef1EU9CwK/7hz854vid/6caQ0V/0gc5sKYR9xcEH4T3ko8k2tcSELKAVnwLf
         NuF3GvHo0qE8zEy6YxNZz6AXtmO62c7OXb9nRnwDl9S4DmnET6xm+xKxASL2NDGRpS
         c8OZil4qZ9g9vh88bdFecc/shjVKLL+0uT8dZwvb+YMFjCO223yQxXjZnW8jzYr26q
         sM0aKt/lYXHYA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 97FE160987;
        Tue,  4 May 2021 18:30:06 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210504150339.1468558-1-bjorn.andersson@linaro.org>
References: <20210504150339.1468558-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210504150339.1468558-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.13
X-PR-Tracked-Commit-Id: 26594c6bbb60c6bc87e3762a86ceece57d164c66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a01d9524cad7c0327bb6d6777639b4c0b3df8840
Message-Id: <162015300661.4328.11133188106214954344.pr-tracker-bot@kernel.org>
Date:   Tue, 04 May 2021 18:30:06 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  4 May 2021 10:03:39 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a01d9524cad7c0327bb6d6777639b4c0b3df8840

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
