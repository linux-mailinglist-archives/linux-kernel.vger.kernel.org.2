Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AC538F869
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 05:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhEYDDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 23:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhEYDDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 23:03:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AB30060231;
        Tue, 25 May 2021 03:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621911738;
        bh=00meE9e3uxz2ASWJEmYuflVdwSwqYLstOLlrAlm46Cw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vhxrd1unWOVEFm7WcSvuyYKsPCgZWj7LYtPiTLPm/vrKwZDPstRpBFzXRBKJpHAF/
         Zd8jwAGLDB8C3Iw782FO+SUL6aLnucbKheFrl2JQMIpKA0U0GlIWBBkHhJS2/18Lef
         Kk2MQ4deM3/k9AtLZorBV2BGil46ljWX06c23n2id5syhELlrQmHn1hhSlm1uYGoIk
         D33zGS4w5eY5lMijkhFhfmrnLyRO1F0trgedChWvLM0LamwlNIcE2KxKfrWHhWd/8h
         j18cuzkrYYpEylZ1RSy6NTatdAdhGyi1i8vudJj8zGlAm3pBP1KA+bZfgMfDHu0tcf
         sPDFsV/KRhrZQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 97E79609ED;
        Tue, 25 May 2021 03:02:18 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.13: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210524200028.174578-1-acme@kernel.org>
References: <20210524200028.174578-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210524200028.174578-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-05-24
X-PR-Tracked-Commit-Id: f8b61bd20479c094fb421da42fef6b4ff22a589e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a050a6d2b7e80ca52b2f4141eaf3420d201b72b3
Message-Id: <162191173856.27460.1101405891066256642.pr-tracker-bot@kernel.org>
Date:   Tue, 25 May 2021 03:02:18 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Song Liu <song@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 May 2021 17:00:28 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-05-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a050a6d2b7e80ca52b2f4141eaf3420d201b72b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
