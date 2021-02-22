Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EF9321EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhBVSM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:12:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbhBVSMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:12:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 140AE64E40;
        Mon, 22 Feb 2021 18:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017516;
        bh=0ELEeivwJ7Y1DGidld+fq2pOpuyIitUFhiNvbdoBxzQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m8iAbJR8/24POJtsGa26+Gjr7rbkVrugjUssi92GFtohTS6wL/+2gqDKVA00+Xl2N
         3ytUL1xPa1RDPJZFjYKcu+4WRqHhLZSizMBZzNSDn/53Tm3FqNq4PpnhCQyttw6181
         TnltsflrC19Y2N56kgjuCtPr1kqz5BbJNy5wS5FcThEPF1hI0vRIKdV97Jo0yX2b8f
         f9hE0NXPnb4XlTqXMu69G9KvT8GPcToZZotftwZu4pjX8iBoPONv5j2ng+DatEr34w
         GyHpl8IfiyOCx9TBKMIUptdZrO4BiMxoCu7e6/w2aREPT7v5GL/1P6P7EVTohjgMpj
         TSpueQ80G52Fg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 100E960963;
        Mon, 22 Feb 2021 18:11:56 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215123709.7781-1-ulf.hansson@linaro.org>
References: <20210215123709.7781-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215123709.7781-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.12
X-PR-Tracked-Commit-Id: a56f44138a2c57047f1ea94ea121af31c595132b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19472481bf58f7c6c939668be885bd300afcb6c6
Message-Id: <161401751605.943.3284506434717734906.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:11:56 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 13:37:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19472481bf58f7c6c939668be885bd300afcb6c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
