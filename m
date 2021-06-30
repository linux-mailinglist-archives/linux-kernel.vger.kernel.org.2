Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53023B8A8A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 00:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhF3WhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 18:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233484AbhF3Wgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 18:36:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B1BBE61477;
        Wed, 30 Jun 2021 22:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625092454;
        bh=RXI4IGnmD3W+18unGw+lK6BCcndyQBRtco/XEnXLrF0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FG3iLAcWeqwpnD6sdFbxAKWdrRyGR97OO36cUQ5Wa5w8lbs/TSbnFELk3qhLfHQWf
         zzDAI4tmbQc7eY9F60itKpSasdZ4EfE9aNn0BPLmTzObsR9WG7GuHSUMw1tX7tb5eP
         /Cki85OllNk5uk7FuuHHVLSSDHhO9uLSsvezcKXj2wZMY/Qxf0U/J3A0rxtiZq9Aty
         WpsQ8z0iShTY/eKxw9k5+AtLYO2qyipkhYnWrZ5NR50D+8wUS4bP82cCkgiWF/nRXP
         O2JYJ6ddtoqvhDQNkkUVxZ450PvfhZ40q1qjlOr5PYPkLV/byf6U487nAbwYxWN7b/
         8ww+3xoewYUqQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A993F608FE;
        Wed, 30 Jun 2021 22:34:14 +0000 (UTC)
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1 (take 2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202106291354.CE55889CF4@keescook>
References: <202106291354.CE55889CF4@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202106291354.CE55889CF4@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.14-rc1
X-PR-Tracked-Commit-Id: fca41af18e10318e4de090db47d9fa7169e1bf2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44b6ed4cfab8474061707b60e35afaf2c92a9dc3
Message-Id: <162509245468.2480.17242883733032620320.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 22:34:14 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Will Deacon <will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 13:55:20 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44b6ed4cfab8474061707b60e35afaf2c92a9dc3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
