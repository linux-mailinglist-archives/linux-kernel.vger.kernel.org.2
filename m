Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB07321F02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhBVSR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:17:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232033AbhBVSNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:13:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8ACE264F0E;
        Mon, 22 Feb 2021 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017537;
        bh=qkklk1faTs7yeW0pYSChHEqv2nIB21dJvx3/3082l2A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V+UytZhayvIthNjFAL4L2d/yTg9Qib7i8jhNsET+b34zSJqXEyEILawkqSGzoWGJD
         Ci0ulhF1NvyakLlQZQHj53uv3ShPgd1OtWjOwXKDeZOd3GGK32Zjr4oBtYc9SawqAe
         q6dQnqLK1HtCuxCSBI6nILIceTnId/QEdoqwZcAHqkR9InK9QWgJaEfwQAZSFUmwKm
         MSDdLng49UC2mQn4Ssub3QK74Qu9MpuhbuE+gHbCD825AOq+xrVkAf4rJ3FwV7gQfV
         bg+qiJaCZdhxmSJiLkBpMV6mKK2Gn9/N9Oz1TaKtqawMeT2KEK5R0mYlqgt6fEzsrG
         sz0os0+oP7sGQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8635C60963;
        Mon, 22 Feb 2021 18:12:17 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210216092047.GA27288@kernel.org>
References: <20210216092047.GA27288@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210216092047.GA27288@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.12
X-PR-Tracked-Commit-Id: b45616445a6e346daf8a173a0c51413aec067ebb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66615c4ee2874f07f09caa45c0c3f80973a75952
Message-Id: <161401753754.943.5301564251499326563.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:12:17 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Feb 2021 10:20:47 +0100:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66615c4ee2874f07f09caa45c0c3f80973a75952

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
