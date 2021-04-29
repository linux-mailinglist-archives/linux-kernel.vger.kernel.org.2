Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CAF36E297
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 02:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhD2A1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 20:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhD2A04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 20:26:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CF2E061447;
        Thu, 29 Apr 2021 00:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619655970;
        bh=/ErUyZEicO4Bzk/4RSCp2AAbO5ZcooZcOS+GacLwlAI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gFCyW58KOLdoWhVD/Qs6XiFRvUv2wPxp9TJ/BHUIlIogEeD5RD9AoEiKvO2ukrMpX
         LNIPb81YOgobQoBVPxXF1oAMxg1rcuCJah51Z4xL5Ejt5S9suxRGaa7vVNk2KxEUNW
         kmdTXIGK6VIKbOYlBsvuPO+dzwxqERhGL6yl7fWNrOArNdPNW7ycfbdPlX8fU8q5Yw
         uqxw/5ZOYveKTX5h1WdTdFJKk4bKVC+Tqne63NTP9bWHNRvN9Pdm60SH4vWpi9UBM/
         /V1c8ghJFro/pv9noahLd3Fu559HFwmuS0oopSmyK+ZJR7BlPWQaXggrbbAHrrKYCn
         BQMlGqwFvZcXg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BC6D760074;
        Thu, 29 Apr 2021 00:26:10 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210428235720.624250-1-sboyd@kernel.org>
References: <20210428235720.624250-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210428235720.624250-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 3ba2d41dca14e1afbea0c41ba8164064df407c8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35655ceb31b56cd1cb52635a725dfcdb9662d7b7
Message-Id: <161965597071.15418.9480484155814017533.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Apr 2021 00:26:10 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 16:57:20 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35655ceb31b56cd1cb52635a725dfcdb9662d7b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
