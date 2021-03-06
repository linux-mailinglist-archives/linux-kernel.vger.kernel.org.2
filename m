Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83532F788
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 02:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCFBgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 20:36:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCFBfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 20:35:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 303C364FE9;
        Sat,  6 Mar 2021 01:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614994547;
        bh=+Pt/sCfGKBCTCZ8euyCoY9wSNi3SakMEve9AJpAmVaI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qiWAnB0Z2H42SvYYMW6btrPRxoTlQ4BldD6oBUeikcOtKmc1BJv2spI8Zjuoospct
         PNgY9nu+3lP28Ua1Ed+Gq/iAUbZvftlmRYvLNZ7yl3j9vUnPanBW0zxtRPNx6wSA7i
         4KkTcOo6qn9GDNCT1AodciU8uWzjZFnUxb6vGV7ZwUALmOYyP4JlhH7dkyaslxGL5h
         P0mxcly+i2fyZdOBtLw161ZKVj+usyMm4YQx9L0RXUBLkqyN/IbegNPFa0zFhNUlfG
         jqZ+BPvNafNrUD/6z+4iRVOFRji4Z2zAN4zviyPPw3LHiqcfhSKc0JWGlhL6oOta2x
         8lieIUEYfIqlA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1D26D609D4;
        Sat,  6 Mar 2021 01:35:47 +0000 (UTC)
Subject: Re: [GIT PULL] pstore fixes for v5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202103051509.D5DDF1D0@keescook>
References: <202103051509.D5DDF1D0@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202103051509.D5DDF1D0@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.12-rc2
X-PR-Tracked-Commit-Id: 7db688e99c0f770ae73e0f1f3fb67f9b64266445
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b24ef44789c990329a15a287ae0e634720745e8
Message-Id: <161499454705.11799.14032836347860971962.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Mar 2021 01:35:47 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        syzbot <syzbot+d0cf0ad6513e9a1da5df@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Mar 2021 15:09:35 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b24ef44789c990329a15a287ae0e634720745e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
