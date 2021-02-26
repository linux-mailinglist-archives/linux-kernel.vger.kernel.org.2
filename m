Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268E23266F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhBZSei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:34:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhBZSdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:33:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id DA79364F2A;
        Fri, 26 Feb 2021 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614364333;
        bh=rTvykHw34K/tMsHPX6D7nJYpjtJ91gIglGXVHvvbJ9Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U0aoWU2vPAtdUulCrOoXKZDao7aQJ8hWSmI/CckUdjGsFr8hp1qMZmfx4vRfMB2+v
         9zxMzvt+j7n5Asn96qn3jzjP+AlI5iF1/RpD4OW24e5zbRCoyUKYljBmvRm6HMFWIR
         9lzyz9Mh+VLcjfxPTHCYNOYT8In/WrVKERsio/IVQGVxlA5uzTIIOYyfkkqIT8zqf/
         UMz0jSj51uteMbqvKI1tcut9v+mUULX7ZP5kLAaouVviQr1D1TKD81QocXl4JSaOWr
         GlLqlxPui+mMjS/64kGX5yjP/w5lx7VBev2OSV9X1jXyJem7ZM0SJusIV+/b3RCp4n
         2HQ5qKErl7niQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D6300609D0;
        Fri, 26 Feb 2021 18:32:13 +0000 (UTC)
Subject: Re: [GIT PULL] orphan-handling fix for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202102251318.22C44170@keescook>
References: <202102251318.22C44170@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202102251318.22C44170@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/orphan-handling-v5.12-rc1
X-PR-Tracked-Commit-Id: f5b6a74d9c08b19740ca056876bf6584acdba582
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bd3f4eeb3147330d03df56f79378f12f25d73de
Message-Id: <161436433387.9780.6256655638684978416.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 18:32:13 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Feb 2021 13:21:05 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/orphan-handling-v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bd3f4eeb3147330d03df56f79378f12f25d73de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
