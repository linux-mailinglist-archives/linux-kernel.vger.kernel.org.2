Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B97B320F12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 02:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhBVBW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 20:22:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230413AbhBVBWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 20:22:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3D62764EDE;
        Mon, 22 Feb 2021 01:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613956868;
        bh=U5uqtE8IW4oXKy7Avufn8gOWnQ81/kqCo2PmaKhgceI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=txNqAASGKzDPWiI2r27zCCjxptIj3AWl0JsWRrrnCKhdtbfczxcNIrVJOAMXrc1jV
         2g1ZCB//7I7rT6u8YuX0yZ/dPccnzylcEP89j62feUrg9wbqVZK2hSK+XyvoR7ir/c
         UQRrl/4GL+C3AA1rE7r+Ig65OcymNDe3bSrFT3vnKTflMygZwv8bhxdJdnY3mNTYUZ
         oN3aVdmwPcC0WkadonxiY9DIuyYZh4RHQkoIVCdedB9UQgTaZPFhqIzGN/uHHR8rqq
         vOalM9iF+PdTHi0x2spzGCPVcenJhvKp3mbc1s3aGGyYUcE4VZHf7VOHK6rQiHX6py
         SLPbPwwxWzm2w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 38B8560192;
        Mon, 22 Feb 2021 01:21:08 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp updates for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202102171252.B769A2FB@keescook>
References: <202102171252.B769A2FB@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202102171252.B769A2FB@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.12-rc1
X-PR-Tracked-Commit-Id: a381b70a1cf88e4a2d54f24d59abdcad0ff2dfe6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 177626c6d5ab1f73d41c94bf9fb0071149779bff
Message-Id: <161395686822.836.9715875971697080130.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 01:21:08 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Paul Cercueil <paul@crapouillou.net>,
        wanghongzhe <wanghongzhe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 12:54:03 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/177626c6d5ab1f73d41c94bf9fb0071149779bff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
