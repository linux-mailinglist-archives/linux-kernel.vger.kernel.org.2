Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E4036B82B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhDZRjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237008AbhDZRjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:39:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A4A9B61177;
        Mon, 26 Apr 2021 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619458701;
        bh=RxMD1pua23Wo8r1rkVVoFJzWiUD1ylqoh4sifrNtCHg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hWNfW7VKesCjHZ4RqjnYc9yerbIYpnaatWEBgFH9vCYrjMxOXZYE2r/V5iVL9WwzK
         8HSMapaQmI+8+ByYtm4Q6kpMNR8AKrcmWR28xQXNzQkX0Gwr/gQ34jClkMU2jPNf65
         /UNoz4by0cJMm253acghH/m1YfD+jo3g2lxO6np332eiZf2A9NuKr34yBsf3XTZz0e
         cJaX+gKNREnD4IknUj6QlW6+fQOAxIliMo6SspWJz+5oGq8KfRz9crrU1i03epJsqs
         0l74SqqHH1xeJXC4/CaYG7UDdPWtz+NF95ZkpZ+y5IZssHp+EjHw7Roeme4EVkDvpN
         9k5ENjEfErtkQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 992A6609B0;
        Mon, 26 Apr 2021 17:38:21 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210426085837.1235312-1-geert@linux-m68k.org>
References: <20210426085837.1235312-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210426085837.1235312-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.13-tag1
X-PR-Tracked-Commit-Id: 34e5269bf987aff9a33ad3ab4f5d65c02913cbc1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a713827cece73136bca63a93e7f9a35dd009d3e
Message-Id: <161945870156.23425.17467182446389169405.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 17:38:21 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 10:58:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.13-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a713827cece73136bca63a93e7f9a35dd009d3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
