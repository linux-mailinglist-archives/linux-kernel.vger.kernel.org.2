Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD805449D18
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 21:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbhKHUaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 15:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238882AbhKHUaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 15:30:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 54CB16152A;
        Mon,  8 Nov 2021 20:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636403247;
        bh=POlyu/1XHbGS298I7zDSJAXekfLKRYbWP5pxpGUrhaQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bLCO6d15qniu8UcBPGUUyJ7JKisaFX2ToC8rDOKnC4PL6BsPnwcNwKTj8325rRHwo
         y1WmjFT+sR5VUD/ChC32neqMe9CON+a/82nlYyYO0Zy4UnXSUVoqjhcdjC4UIilbZ0
         EZWGiXqu/hhNyPLyG1OeR2QZQTu64EK2LcnD6IoCb5AGr5OROqs2SGapKTS/6gCANO
         Ohsas5Vn9Vr09aet7u8nJYG3odVhnumrxgXlJiPiXUKGBPZh+THtdvinczLSdJNVC1
         ZxexMzREJMqtu6tY0jwDXhstkv1Ldi+wFleNqUCI6yzdfrBb+WpHYw+yu+6G7X7T44
         ICugpMC84vt5g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4AA07609F7;
        Mon,  8 Nov 2021 20:27:27 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYlOh1l+4T4ir4aM@google.com>
References: <YYlOh1l+4T4ir4aM@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYlOh1l+4T4ir4aM@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.16
X-PR-Tracked-Commit-Id: 3976e974df1fd3a718627b0c9bdfee1953baa0d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2f38a3c6507b2520101f9a3807ed98f1bdc545a
Message-Id: <163640324730.16718.2193813381653530917.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Nov 2021 20:27:27 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Nov 2021 16:21:27 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2f38a3c6507b2520101f9a3807ed98f1bdc545a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
