Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F9D30E369
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhBCTkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:40:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231345AbhBCTjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:39:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CA88F64F5C;
        Wed,  3 Feb 2021 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612381124;
        bh=XU6nicR5fKlkjssiR2CSUxT8bquhNZ5d3iyQxLVhry8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fqvQm5xed9z1hdI9axpPxnJ2lAtG8PVSLKGMwggSz4BKaKUeFFirT67JvTMqix16r
         GuJw574JxnEQllgs5UBlOGdhSkgpbdYxUpcJ98NUb2P1uJbPxYkexA2CRQcuY46/Ig
         s8R5zzzAWS91HGWmijDBbAnQslz8Lt5Bp39YwOmoV+zDKvivXLFluyBu6uEmjWzJag
         fqWmrt70M+MuEQLmenpO72w19aHsoTf4790fBMAdxu3oDHDSpKgjIgXrtoBcs3flg1
         aP+iZRJZKEb90U/LtB4Fv4cA48/lBiXe9h7GnDNEr/Gt8YusUu3cHoLZUXi+39E8z4
         ExZTn0qlPBB0g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C5454609E3;
        Wed,  3 Feb 2021 19:38:44 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210203095119.6627cd56@gandalf.local.home>
References: <20210203095119.6627cd56@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210203095119.6627cd56@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.11-rc5
X-PR-Tracked-Commit-Id: c8b186a8d54d7e12d28e9f9686cb00ff18fc2ab2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbc15d24f9fa6f25723ef750b65b98bfcd3d3910
Message-Id: <161238112480.20071.1935445830669072437.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Feb 2021 19:38:44 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Feb 2021 09:51:19 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbc15d24f9fa6f25723ef750b65b98bfcd3d3910

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
