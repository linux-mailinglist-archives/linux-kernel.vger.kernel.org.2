Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895824425FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 04:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhKBDTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhKBDTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:19:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CE36060E08;
        Tue,  2 Nov 2021 03:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635823034;
        bh=OlnsVIvSgx2c+psSKp0OnBR0L2FSIQBwDQL8KmFe1sQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Neb5BJzJcrVs2lCajgSo3uGrHwRw1QVNvIiY1Ml2axAkgCNJ5bj5Ug0sckI6jMIKM
         OG2kwd3nvbIdJzazpgVN49u2QG4UkgjbQlT/lTQoHZKlmm8tGNItVPcrXl4vUWxWeN
         bBPN8fpkhrtBwEL2AQ7g5WXyYm/D99xZCdhDMkNtjjZmooQhn3zfS6+5wr3jWKCicg
         vSe+C33Z+NmsySWHWN2Vc4WIkm74lz0Ect9Di+w6FcLwowsjJAhMreQALtExR4PzBj
         kE+T2/ZLCw5jmLOYghWKM7BEiiUuD8qB2bq8iRbXFW6b5K9D8seps1ZWrbcNH5B+yh
         R/qMqBN1f70fQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B973860A0C;
        Tue,  2 Nov 2021 03:17:14 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211101175544.00fc0d57@gandalf.local.home>
References: <20211101175544.00fc0d57@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211101175544.00fc0d57@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16
X-PR-Tracked-Commit-Id: feea69ec121f067073868cebe0cb9d003e64ad80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79ef0c00142519bc34e1341447f3797436cc48bf
Message-Id: <163582303469.21758.14456547883726968691.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 03:17:14 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Carles Pey <carles.pey@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Song Liu <songliubraving@fb.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Weizhao Ouyang <o451686892@gmail.com>,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 17:55:44 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79ef0c00142519bc34e1341447f3797436cc48bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
