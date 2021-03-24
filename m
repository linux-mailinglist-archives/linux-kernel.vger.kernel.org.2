Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E61C3480A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbhCXSic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237586AbhCXSiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C8A6361A16;
        Wed, 24 Mar 2021 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616611082;
        bh=eSZw8yU9zUa1RFZayjOa+pIrltGQX/u3MnGtFcRxUP4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NIc4aXRRHDyljr6aVbnrJa58ZgiFYkCRgir02Y1eim2lOJOEGZYBPWtFh0eXD718e
         HpEOitKGUUskKn0YbAA5b0lA9qedbrqbSf2SLllR5UCV5UQvaDChi8DgKvA++nVT1f
         yha20kJ3QHiN5Ss8Gmm4txXLKTGz6R2NUkgd2ptTs6d6mB0hLRhMFoj7FC1E8H0ok2
         Z9vTPl9Iy+SPzNvvwMJ3Eya2DfPiE3FDt9ovyncHPSQV+wOuM8VcpivDvTFmdc5c/h
         bGBVgl9hn3pXWXqk3nWYQ/Dx3gbrK1lX9NwXXFtl4G4ip9LGpgha98S7eUmuuC1ZjX
         spiY4FjMNGmQw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C41B16096E;
        Wed, 24 Mar 2021 18:38:02 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210324182453.2033329-1-sboyd@kernel.org>
References: <20210324182453.2033329-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210324182453.2033329-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 148ddaa89d4a0a927c4353398096cc33687755c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ee998b0ef8b6d7b1267cd4d953182224929abba
Message-Id: <161661108279.26767.11653190916642234587.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Mar 2021 18:38:02 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Mar 2021 11:24:53 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ee998b0ef8b6d7b1267cd4d953182224929abba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
