Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1013EDB12
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhHPQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhHPQlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:41:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A78E560EFE;
        Mon, 16 Aug 2021 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629132034;
        bh=5c4cX6lYttMgjhubSd1M6TvLLkb9jPM6WVjT6NTI3tg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FQAUBrypg3BkRcn2Re0vmqyoliWzh21hXxRUMyYwsa6yMg9Cab5Pv3LAibEsJdDEN
         d8m2xjh7an9eUMOZKDPqaS/xBhUbiXVqVqUi6M0czMi5q0X+rQU5UGdjG+nUeWnDYV
         6hnCRB/zNW0t7eARY1OdsoSoGEElivZb6OnyqzUVhJfA8XbtkSmRX5/Wt+fwyoIcaE
         /4Wc+5nu0dr+B7lhpi9OR2pXPOuPZNIMkAVIiJoEuzKbjKyjDdHoKMoNwdks8xIzLt
         /eOHN4Vvm4XSxqeioop3E0iQBCqeyNTddXTnkb89cyMxxfB+5PaA2a4qp2Abw+A18I
         JRum22xXwcaxA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9394E604EB;
        Mon, 16 Aug 2021 16:40:34 +0000 (UTC)
Subject: Re: [GIT PULL v2] tracing: Fixes and clean ups for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210812141636.35e41575@oasis.local.home>
References: <20210812141636.35e41575@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210812141636.35e41575@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-rc5-2
X-PR-Tracked-Commit-Id: 5acce0bff2a0420ce87d4591daeb867f47d552c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b88bcc7d542c33ad3f5c042409d8ce0505cde1f8
Message-Id: <162913203454.19716.9691736707772291882.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Aug 2021 16:40:34 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Aug 2021 14:16:36 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.14-rc5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b88bcc7d542c33ad3f5c042409d8ce0505cde1f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
