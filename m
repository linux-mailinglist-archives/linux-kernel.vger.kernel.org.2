Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0341E4079DA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhIKRbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 13:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhIKRbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 13:31:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 874D061027;
        Sat, 11 Sep 2021 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631381405;
        bh=hUcR2g6TUQiNlHG3a/B5efZFLKRnW8Z++9LPoE7IQAg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vHbExPW+4OggFCW4LUVPbZ2rUbt6p7HrbLNvC+2xa7mgal3SW3CORIX2BmrqvRcbu
         kyIoaVw4cFOHzIzSEJhzRqy3sY3ReOkQsyrU7O2WGXD95RboK8QN9X1TC6XYjJ2Dli
         wOsHpxwWNeLGzc3uv8ZTTR30+P23UOECXEUzlxbyxgJ1Bjgefuz9836aseu4UlkoVR
         bnU5A7NwLlnNBO3f3HoO6LUVh0w+SMbfII9qIUgQneNpB27+7SHdIjzi9g6xbxrgZa
         3hIb/SmtL4M7rmEUljA6APJNd/oqKXz2yT8tfIIG/Bnc4xcHNTtu5TpUQLYKjV228A
         NmlfTdkKn6OXQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 71498600E8;
        Sat, 11 Sep 2021 17:30:05 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for 5.15, take 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTvIXzO2QJ4n9RmM@robh.at.kernel.org>
References: <YTvIXzO2QJ4n9RmM@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTvIXzO2QJ4n9RmM@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.15-1
X-PR-Tracked-Commit-Id: 094b147c766289baa0f370d124609c3ac2b5a420
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1406e424253ba2121614377aaab274d403b08e0
Message-Id: <163138140539.31565.7748956337457195645.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Sep 2021 17:30:05 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Sep 2021 16:04:31 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1406e424253ba2121614377aaab274d403b08e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
