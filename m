Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00836CA74
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbhD0Ri1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236172AbhD0Ri0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:38:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6C972611C1;
        Tue, 27 Apr 2021 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619545063;
        bh=C+BmZQZT/cMJm24BqhIBZmwjNRk23nCwq4V1vWk0AC8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PtWJVI5MN9ilpkd7fB0Z9/Eqx3GRkxnUNPRYBtlMAwtQlNXcADCfUQ+3HBjoKHAUx
         1IGmY05Dl+onvEUntDRU0g5bDHBOz7ZyuS78kGgmix76cxwiZ7vXdxZbaC4Ex8lKmK
         V3v1U+CWJhGFDV4TvMuaPA4OuHAwMfZdbMUYggIYcLzkVFzHucbhETHuCIyv2DS2zV
         +4kam0CkPJ0zoku6EXh6LdgXDNIJVERpLBTGcmzgsjmkevqPe+AzSkFwqJMBa6s00p
         DBXgS2nRGUSfkkBNcl+NtPFDUnXJZ/aFx5dvJTxb1I5bSgkED7i2mubTWgpsvJk+q+
         GhA5usdr4iINw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 62698609B0;
        Tue, 27 Apr 2021 17:37:43 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp updates for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202104261127.43AC34A519@keescook>
References: <202104261127.43AC34A519@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202104261127.43AC34A519@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.13-rc1
X-PR-Tracked-Commit-Id: a3fc712c5b37aec802438fe0de095d7f6f3827a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e4910b9acea9fb9575f6506f76dd465259ad8d9
Message-Id: <161954506333.13735.8867260380661333286.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 17:37:43 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Cui GaoSheng <cuigaosheng1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Kenta Tada <Kenta.Tada@sony.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 11:29:05 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e4910b9acea9fb9575f6506f76dd465259ad8d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
