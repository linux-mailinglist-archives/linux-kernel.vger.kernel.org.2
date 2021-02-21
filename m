Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B55320CD2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 19:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhBUSo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 13:44:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhBUSlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:41:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8115C64F07;
        Sun, 21 Feb 2021 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932783;
        bh=QoJZijyzMZa54GFaAZF5VMeThIA0EAPcK3hri/ZGKG4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MfZ0Mo8+fydW+tv6VU3r49kC/s4OyOmy5MfTylRZr9AKS8Xlpulx/wKepvtyHSEnh
         nbiJm27ByBZZjG6l/YNGHQ4jMz62ttv2VwCT/Yel4gxqAvNqZuUxcqXOEwHeQCZQ0P
         ntA8tCVuKuF8fDwTb9jgfI8rTIHJuiqRDQ3yI+YGNcHxHy9r7eAmEdEVt0hDCF9X6Q
         2RyiUAaJfVOtdpGxk/jauGWLZdL2D+PrLVyV1qSltfguikcXW66uGj8LAh4S4c5UGu
         ZX4pxLenb2rA1o6eNmXoNGS5tYTAqnexGxxmRB7CDabkpdm3CntGqGCgYeaan83xoH
         o2muDOuiQxvjA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7CC5260191;
        Sun, 21 Feb 2021 18:39:43 +0000 (UTC)
Subject: Re: [GIT PULL] pstore update for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202102181234.5FC6F9CEF@keescook>
References: <202102181234.5FC6F9CEF@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202102181234.5FC6F9CEF@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.12-rc1
X-PR-Tracked-Commit-Id: 19d8e9149c27b689c6224f5c84b96a159342195a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f02361639a481771130db5e67933c4f414377fce
Message-Id: <161393278350.20435.9919754989298856469.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:43 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Bohac <jbohac@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Matteo Croce <mcroce@microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Feb 2021 12:35:21 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f02361639a481771130db5e67933c4f414377fce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
