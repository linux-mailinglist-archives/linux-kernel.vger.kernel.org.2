Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0172E408254
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 01:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbhILXWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 19:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236709AbhILXWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 19:22:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EDB57610CE;
        Sun, 12 Sep 2021 23:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631488891;
        bh=aQb54SBUC0HsFLuj9vsAFmZ4NW1VGKOVAdD+GLlWAjw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GcgYCfa1w59lYCFdfVZUFDXDH2Zc73tDWmqshetikCQIjn/BvebI2VnpCP11yRmuT
         yyf8cUmIgxcMDxigckDpwwvFW81nE3hVzQZzGTK7ifGoj+TKnur7N2IOn+7atW8BfA
         n9OzzSq9NszdpDQtkmhDvrscbCIuawIoQK7VCf6kbbQ/Tjf05z6XABMDeNOKgjwaOG
         WJQhvVYTXiUvuZqhCA0wRlsPj8lP0f5+R3Jsiad7UT/G+nqPWCH2zCQpWybBEaMIr3
         ghmEijtu62RWWLinuIBS1nHOmDDfHtqnTUIvYV6HasbZ7aZKvp1bZiEsdnMwvP777l
         ZS8EOGos555mQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E8275600E8;
        Sun, 12 Sep 2021 23:21:30 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210909000730.GA23567@kernel.org>
References: <20210909000730.GA23567@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210909000730.GA23567@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.15-rc1
X-PR-Tracked-Commit-Id: 24ebc044c72ee6e88dc902a0041bac672f012537
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d41adc4e22c62640fa7de93f713a3c5b3638ab2e
Message-Id: <163148889094.14345.8526544301908003188.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 23:21:30 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jinchao Wang <wjc@cdjrlc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Poeschel <poeschel@lemonage.de>,
        Ralf Schlatterbeck <rsc@runtux.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Sep 2021 02:07:30 +0200:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d41adc4e22c62640fa7de93f713a3c5b3638ab2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
