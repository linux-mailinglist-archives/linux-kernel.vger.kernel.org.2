Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB38B408253
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 01:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbhILXWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 19:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236712AbhILXWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 19:22:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5DA44610D0;
        Sun, 12 Sep 2021 23:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631488891;
        bh=YFMAiKtyCdPCtRWRXGlGl9qtqYyD4dhaYHd74C74bZA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qHHCnCuoFQaOR3SUFWZjp+1dfTLQBHHoQysQ9qLX9BoMy69nWw4A6REdE1RYkLjGn
         MMyE4uE85DKxfLLeFkx33/inJfPOBwWvvKySvRpwaF8oAi6whvniDMG7dMlhZANiL9
         z5uIBegwlrO3vKTsAS8Dl/jrlDvm4sj6/QrpFBq2tm90dQbwypWneX+Eyfg3PhVc0U
         x6Z6O8ILzEQCxVcdXQYsaoI2uHlOVcSLvwhWqR+mTYZkX4lREnKPmww262zW4/4WIE
         nD9NUCdlBbuRDeSAIzFIv+LEDWob00yjCcdnNxTJYDOkXw/Fb87i0eRBuMOialYnP1
         xnXlK8MiZ/yeg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 58893609ED;
        Sun, 12 Sep 2021 23:21:31 +0000 (UTC)
Subject: Re: [GIT PULL v2] Compiler Attributes for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210910191734.GA8688@kernel.org>
References: <20210910191734.GA8688@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210910191734.GA8688@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.15-rc1-v2
X-PR-Tracked-Commit-Id: b83a908498d68fafca931e1276e145b339cac5fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3e46874dfb9a2ef08085bb147dc371e72738673
Message-Id: <163148889135.14345.6992457235469669107.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 23:21:31 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Sep 2021 21:17:34 +0200:

> https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.15-rc1-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3e46874dfb9a2ef08085bb147dc371e72738673

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
