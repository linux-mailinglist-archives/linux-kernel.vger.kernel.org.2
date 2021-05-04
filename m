Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5F6372FC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhEDSbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhEDSbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:31:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 000A4613D1;
        Tue,  4 May 2021 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620153007;
        bh=CjqjLgBiQa/xjUUTwGphcFmuQGbAhfSmeaIuRbTG/IM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ldeXxR808q9Y7A+HIrCAwG0VT4NkvjyOiCIbz87wrsutoxvrPxr0BubsDfUU3RjW3
         6DYXI5+0bSdji7YXhB4eaE9EcfuyOdilCjm8mdhdKoFCwv3FpJXslYlGtr9YeQJaD4
         rjLRjzHOUaSeyjBUvVcQSTS1m0Ozv7In9/7QTT7zWKsDosabrgrElScKcfXU0evAYo
         /a45jEUaRV10oltqY86ZfZzM4CdkdA0qTn85W+BdkHPhg3NGrYZcW9UP0Pbi8nsw4E
         4QR99UJP+T/L48nN5YJ7YbeGj46qnnWF9Zz7hH913IgH1TWzGJjte/f4ePLwbampUh
         VUna3Qq9zMpuQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E6DB760987;
        Tue,  4 May 2021 18:30:06 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210504150351.1468612-1-bjorn.andersson@linaro.org>
References: <20210504150351.1468612-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210504150351.1468612-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.13
X-PR-Tracked-Commit-Id: edf696f26855788cdff832ac83319e1f2aafcc90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8796ac1d031ad0d9346fd62841c8eb359570ba48
Message-Id: <162015300693.4328.1761711581437301808.pr-tracker-bot@kernel.org>
Date:   Tue, 04 May 2021 18:30:06 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Govind Singh <govinds@codeaurora.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Suman Anna <s-anna@ti.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Junlin Yang <yangjunlin@yulong.com>,
        Raghavendra Rao Ananta <rananta@codeaurora.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  4 May 2021 10:03:51 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8796ac1d031ad0d9346fd62841c8eb359570ba48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
