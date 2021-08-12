Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D635C3E9E60
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 08:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhHLGXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 02:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232800AbhHLGXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:23:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B4B8C60724;
        Thu, 12 Aug 2021 06:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628749392;
        bh=KbDxuFEGTIP3svMCydqDTuI2Zw1YeL5h8i1O5BHmweU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O4icNDd+d717iN59oC6TPkWyuJS+SF2DuX6Gz57SEv85XVL7qu9i6cEGGozFLHn27
         Ip5LcUcE8+Nn6/B1jBkd2IAG8gfFV+74trDZBCx2PqTdtWaclz1PioZM0iqRIWHXZw
         DUDo8V15/Ll6hUKkHFPomVyzx64KDVvYsjAzf9u8zP1c2yZ0k2OzDeDgfI7sEmKTHX
         FUfpR3FQk74bgA8tly0OfY7CMUTFjGn2gog/AP8pZUtqXstdgnJ8Ivu5+yUN7BKtYY
         uUJmaQaODwSb/DZvaeaW1DIJCouH21r7+tJmzhA6CgmmTtvzDZYf8i9paAooJa4NTZ
         qQXS2T3YUp/rw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A6697608FA;
        Thu, 12 Aug 2021 06:23:12 +0000 (UTC)
Subject: Re: [GIT PULL] orphan sections fix for v5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202108111236.CF876AFAA@keescook>
References: <202108111236.CF876AFAA@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202108111236.CF876AFAA@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/orphans-v5.14-rc6
X-PR-Tracked-Commit-Id: 848378812e40152abe9b9baf58ce2004f76fb988
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1746f4db513563bb22e0ba0c419d0c90912dfae1
Message-Id: <162874939267.15829.11106340889188475387.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Aug 2021 06:23:12 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Aug 2021 12:36:32 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/orphans-v5.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1746f4db513563bb22e0ba0c419d0c90912dfae1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
