Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34DC40E9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbhIPS1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244505AbhIPS0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:26:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DB303611C4;
        Thu, 16 Sep 2021 18:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631816729;
        bh=IKbL0+P26yrT60PUSF9ToDMxXj0h9UjbkJCYM+R+kbg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FsCDS88V9L0SPAGYZzSjxiMy4laezTqsANVpJzThxuWlmwtIPnObzyOFw/SE7e1Gr
         x/8MWLCZ74JeO30Nvn8wmqIBZ2uHxuGoIiqxlxOLR5lRzhT3LQQAnFMJq76CfKs4ZK
         HjNrC+G/PAeh7R9N9lvh2679LLw0vLyLDjErdYYh4XLv051DP4QWHl96LAECkVsmLZ
         LSJlvQGli+J4IS/0hplVTO0N8ZvcmcWU94LNRx06r+UckNjODI8y2wUjdyPnwBwAiB
         xe8/PCaRaqTwTAEsTKRpgU887mTFIE5qsndVYF3bhSfizITs483foh7C93g+I7xFDK
         jn1LQMBdGnk+w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CB85C60A22;
        Thu, 16 Sep 2021 18:25:29 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v5.15 (take two)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210916065257.775368-1-geert@linux-m68k.org>
References: <20210916065257.775368-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210916065257.775368-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.15-tag2
X-PR-Tracked-Commit-Id: a7b68ed15d1fd72c1e451d5eb6edebee2a624b90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 077a6ccf2588c7c893b443fad62d0f8ed342cafc
Message-Id: <163181672977.572.3096908781411027570.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Sep 2021 18:25:29 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Sep 2021 08:52:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.15-tag2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/077a6ccf2588c7c893b443fad62d0f8ed342cafc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
