Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDDA408252
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 01:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhILXWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 19:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236708AbhILXWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 19:22:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9A9F9610CB;
        Sun, 12 Sep 2021 23:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631488890;
        bh=MBYAqymJqueNpPfH/XDMgSbcXHffLv2bGy8bkyWSAVo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OiyZZUBfLr2mOazod4yzdSULxdSlvvbc5W3exXYr3Dja3qJVMEtEfdQAu4eIJB0JQ
         c2FLaMvvoQlIa5s5NRSZtfJjHsUw0kuAaRb2LlLvXyNa2ThIb5SgYsZiq3F5aQvklu
         jHy+PNdnqUuIU0kAlFzBKMfAyPuD84afsMEq0OcfrM9i9yvfcqZFDJLsTVCNhZBpB4
         GKMfnVr2Qef6YnyhMwUf212lbXOMs2P5RmoXNw4D8AojYseiNrzYEA7JpsEb9mqrFi
         Qo0DAm7WS9HlMR9HVuIhReNEgutevMfMi14cIvIB9PE5ORTSaSGCV0hQiZ29vx5lHG
         lQ/AK/I8d0/Zw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 94B37609ED;
        Sun, 12 Sep 2021 23:21:30 +0000 (UTC)
Subject: Re: [GIT PULL] Compiler Attributes for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210908234751.GA8052@kernel.org>
References: <20210908234751.GA8052@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210908234751.GA8052@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.15-rc1
X-PR-Tracked-Commit-Id: 7ed012969bbcdbd7aef5778a061681e6cbc4b402
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ca70b24afb999376bee3cf3b4a52732988fa0d7
Message-Id: <163148889060.14345.7918509765413930817.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 23:21:30 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Sep 2021 01:49:14 +0200:

> https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ca70b24afb999376bee3cf3b4a52732988fa0d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
