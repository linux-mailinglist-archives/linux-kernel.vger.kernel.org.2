Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250273BC31C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 21:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhGET0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 15:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhGET0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 15:26:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 144B36197F;
        Mon,  5 Jul 2021 19:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625513049;
        bh=wHBBeN/WES+V5LTJKf1rRzrUGtjs7W+hmfB7z7y3/LQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UZFn7+Sorkb4Nw5aF6b+X6Y49qWbPV4ZGK968RkYtt7HqXWSMlRKRHqmE9PEBDp2Q
         8K/EPDLo5uE9/jKI/qiRBKne2qrLCE7XapdpvWy2qB7fS17BrQFw9MKxRZq3hELb15
         7cNvmZYBOSDh+LZJ9Xl2Q7sLH4MU2TH9t2uIrGUwlSIsuGkjD9Ga+sWRPrR3hdwFEY
         3WjLBvizuPESch31g6+VR4WMa3w3pm+L4HxODSJdJLxPHsw4wcLCflXptA0u6JSsON
         HJopTXnLNyA154uL/+ilRYgUsh/Lg2MH1VdHlOKHMZozb9FXphlbxUCTKZ2mxLTlSM
         Ki/OPU0HHlxcA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0D6AD60A6C;
        Mon,  5 Jul 2021 19:24:09 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210705103248.7811-1-ulf.hansson@linaro.org>
References: <20210705103248.7811-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210705103248.7811-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-2
X-PR-Tracked-Commit-Id: d0244847f9fc5e20df8b7483c8a4717fe0432d38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f3f2ccf3c9eff8e80e7993f8345a4fef52567be
Message-Id: <162551304904.9654.10684814548334754345.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Jul 2021 19:24:09 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  5 Jul 2021 12:32:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f3f2ccf3c9eff8e80e7993f8345a4fef52567be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
