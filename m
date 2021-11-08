Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363F4449D17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 21:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbhKHUaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 15:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238877AbhKHUaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 15:30:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1CAE361159;
        Mon,  8 Nov 2021 20:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636403247;
        bh=GFlbzHgfypXar8xkHv+wzKGvm+IQ8fdtVlDB8coezRQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E34SdieKzA7NodnNAg1QPaDhy42T4kZd/S4C6bgJNjk6QcaZIOfUd1mZWlFbBlEa8
         BKV9Gzjla7kC70AcwtooXHF0L2ZMzasKdpjoHIX5AWLbDniRyBbskW/uoSN6OBxbsW
         39ALrmBFHNJ5VDIWz0FffITHngWk9k9RQfAjMZYIaXarWMjZKbnFKD78BzzlFzOjuM
         fvNQbZGJVAmuNbmmzc+fg967DxlV09aET6fHFyln9/drl213MxCyVU3gaxHAAyewVe
         /bq4mKLu7kYyJ9rIP8tZfW1Fc5phOw5+xTFW66e9DR4tymo6R+5nYRnLM+DZt4V35w
         oT4Of2oGT2gtA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 163F160A23;
        Mon,  8 Nov 2021 20:27:27 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYlOHmhpII5vIbxL@google.com>
References: <YYlOHmhpII5vIbxL@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYlOHmhpII5vIbxL@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.16
X-PR-Tracked-Commit-Id: 5dc6dafe62099ade0e7232ce9db4013b7673d860
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a9b0a46e1708b6b3c298f2cf22923cc5a2ca63f
Message-Id: <163640324708.16718.13130544780428208465.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Nov 2021 20:27:27 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Nov 2021 16:19:42 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a9b0a46e1708b6b3c298f2cf22923cc5a2ca63f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
