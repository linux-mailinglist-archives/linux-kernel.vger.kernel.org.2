Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFED4577F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 21:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhKSUyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 15:54:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231958AbhKSUyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 15:54:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 78A7961A64;
        Fri, 19 Nov 2021 20:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637355073;
        bh=pjK3yyRBt7f5kUH+hIc65x/yD0QMGt36utbDtlncIN0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uKnlLV1B1/iLQ1WgCNfcosaYr+g6TJUhcoWSAuYV4Ri+z5rIGNH9zi18hI+HznckG
         QkSAtyYeMTB27r9lftGAf6deX5j9tPZ/1gdI0NxNEuKCJ8Tgk+Yr6GypED4spnztKn
         3E4k60tknVrI9vAJJtCuVuUajJYh6IChb0bAO+y6uSvEeCA1Xkdj0U3f2hJc+mQmPK
         9az388vVRYq8NwIrNeyviiWsvQbHB3fyLoyZTHmx5Bmemf4KwT0tU6Ug+Gq/rc/wG9
         +S2B+PhmfIJjGJFnoJ+H5wJcKoHcPJToo8+dmKN9TTaoXpNv3dfw6oNAnpZHlUKES6
         EStPmtrZysksQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 62C1160977;
        Fri, 19 Nov 2021 20:51:13 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.16: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211119133615.31727-1-acme@kernel.org>
References: <20211119133615.31727-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211119133615.31727-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2021-11-19
X-PR-Tracked-Commit-Id: b194c9cd09dd98af76beaa32a041af674260d730
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b98436af2c0d6a6fc970700a290666600e2ba13
Message-Id: <163735507334.1617.537207187548031491.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Nov 2021 20:51:13 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Nov 2021 10:36:15 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2021-11-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b98436af2c0d6a6fc970700a290666600e2ba13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
