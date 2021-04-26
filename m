Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB036BAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhDZU6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234743AbhDZU6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:58:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2E21961040;
        Mon, 26 Apr 2021 20:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619470658;
        bh=uOBWXZQVEAzyWhXmZKkYHruv+hC3J7GU0R4uFDhiFRU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uLWuSPtmkNcjxzzbfE+kYRz2fGIqmj68Q8ZdT4A/SHWUj/FarTZchhi5MirhTrzbC
         s+Pbf1D5ERL8LezKDgQ6/40vl81s5NcqxGs9yo4o5LDsk1QgkT94cMwmA/ddntjnm+
         dkCjczFTL2RpfgvAu7ASy9HhNO3UFmilaNZuexM2hl3UEsZ+8PkSS77Tyqg90KYLHu
         dhBgzsb+9ohvZbQ9KSdxYnZxILHFd8B4u+SuM3wkQ4WiuGPK/hCraGBukNe3q8WxgX
         i3kNgtxc0fmHoCv1UAVO1BsFzk6Gu5eJ/2u6cNV8Pjf0gW61llLyokAUZjCo5gIZzb
         ncO/3Oq2Ucn4Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 296DB6094F;
        Mon, 26 Apr 2021 20:57:38 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pmyh7ziz.fsf@meer.lwn.net>
References: <87pmyh7ziz.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pmyh7ziz.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.13
X-PR-Tracked-Commit-Id: 441ca977a84dadac6173db7c07c25db110b76c1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f9ef0559efbee18a10a3ca26eefe57f69918693
Message-Id: <161947065816.16410.6399482534768951509.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 20:57:38 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 10:59:16 -0600:

> git://git.lwn.net/linux.git tags/docs-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f9ef0559efbee18a10a3ca26eefe57f69918693

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
