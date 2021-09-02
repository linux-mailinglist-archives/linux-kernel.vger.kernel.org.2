Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EDE3FE778
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhIBCPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232613AbhIBCPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:15:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 989FD610CA;
        Thu,  2 Sep 2021 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630548850;
        bh=lSRYXw2GNUHa22Q3qtRxtXAjlQWO1nynz5KZy8emrAM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JsDmOLxLwtQPVmkNKAucfQNCFTvEQ6M9H1FRo7YtI/JfUcBHA2aItnBKIQ+M5YFtI
         of+jN+kRhgKHBhSbal8GCHCqjHT6W/ehlqtsHshRmtt77wBVdCJj6kSjqwJb8yCzw1
         zB4gsGIy5LtKjhhH6rcIj+E1YnITuAPkzPYvblQO3Cwg+z2Zkq/vmB/48NEFFPPQYJ
         L1v8X55QWG3PcH+EnFMfjO6xBgqQbZCiebJqzI0Mjq10S/MIbmtlh8ZG9IQTehrQeq
         ToFwmM7N7ArvIW0bCJ+CSCp1YLCuSJoer53NDMXnWugsMbyRN0UXKN6E62Y6eYarMA
         VrmJEJy09C6mw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 92D226098E;
        Thu,  2 Sep 2021 02:14:10 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS54t3gfZYdE3WPj@robh.at.kernel.org>
References: <YS54t3gfZYdE3WPj@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS54t3gfZYdE3WPj@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.15
X-PR-Tracked-Commit-Id: b1e202503508d5b66bf1532bea36b5776b00d869
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e5f3ffcf1cb34e7c7beb3f79a96f58536730924
Message-Id: <163054885059.9778.10056044587388023871.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 02:14:10 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 13:45:11 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e5f3ffcf1cb34e7c7beb3f79a96f58536730924

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
