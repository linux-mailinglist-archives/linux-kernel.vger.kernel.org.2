Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DFF33A7FD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhCNUi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234071AbhCNUir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:38:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5326664EBE;
        Sun, 14 Mar 2021 20:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615754327;
        bh=EhwO2rtCKjPVJ+o0up8E/BbIrO3799p8r2B/4fuE1S0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YhdOEIhGZLgWOQ1QBI1GddAa0M0auIUnGHvCKMBMyPxErx4/a1M9Tv8ocCg5njiBE
         hcCZyc4JeXgc0ffGRN8hrIXuvwNNsKA4EfPEPRc/lKzoD4tG9G2HWHcUhvkJ2wTTZh
         Uprsbqhs3zeDGFR9M//7JqzFPUEgKHMPxEtL9qRSUQulVrpXLkJ/xIHb4FYrory+uE
         ukXoYE9IYVTZSWqj8OHAl8TwMuL0DISETAEiGf0b8KpopRwvZC+yPk5yfU+w0CFhq1
         WAsL5NZe3giynxjXxix54UJXOofwFl2vh2RnHJFymmoTfK7xSTHfIG/5+VZSnqHl6V
         Xcs73rDMVlIlg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4E92D609C5;
        Sun, 14 Mar 2021 20:38:47 +0000 (UTC)
Subject: Re: [GIT pull] objtool/urgent for v5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161573639789.27979.3143475584511547992.tglx@nanos>
References: <161573639668.27979.17827928369874291298.tglx@nanos> <161573639789.27979.3143475584511547992.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161573639789.27979.3143475584511547992.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-03-14
X-PR-Tracked-Commit-Id: ba08abca66d46381df60842f64f70099d5482b92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19469d2adab9a94e3c1713b7a12a67f9c59c1161
Message-Id: <161575432731.20317.7358122867720918809.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Mar 2021 20:38:47 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Mar 2021 15:39:57 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-03-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19469d2adab9a94e3c1713b7a12a67f9c59c1161

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
