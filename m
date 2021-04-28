Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE636E08B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhD1UuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230245AbhD1Ut4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:49:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0A0B761456;
        Wed, 28 Apr 2021 20:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619642951;
        bh=ihbjjQ/Syxf2gMUGdS0STgKa7PjK8tJLFBFg2fAba6g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P1/GDgHjXAbbbeaBuah7bm+Mx3bONfZurndZgwWz8QvzNN8yLCswQiu8caxR/lK8J
         kSS3S4p0quYPHjRHZVJaKdVKcyelzMTZPz2kQ++v5BBnNTf8pbjIMsHbd0M/AN7bLr
         vvVxjSl3JQa/Z2vuUgrw59tfL/fK4LB/CdoZ+wN4Zm471bD/8eVwULbQNMGrRWfaWW
         qorh6WO0LwyE3and/ZcWISCZs5bvYfWL3o7pZ7safHH++QhCC3ft88gNiLgGVuxhoQ
         R5w+LX13rQasb3ru/VfPT0m4E5Sy0o/ualTHj+hg/eg+ieI1X4Tnjh4a44UGyQEvsP
         GqgZL8OhmJc7A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0452160A23;
        Wed, 28 Apr 2021 20:49:11 +0000 (UTC)
Subject: Re: [GIT PULL] perf events updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210428082508.GA272557@gmail.com>
References: <20210428082508.GA272557@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210428082508.GA272557@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-04-28
X-PR-Tracked-Commit-Id: ed8e50800bf4c2d904db9c75408a67085e6cca3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42dec9a936e7696bea1f27d3c5a0068cd9aa95fd
Message-Id: <161964295101.5673.13989602910164792077.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 20:49:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 10:25:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-04-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42dec9a936e7696bea1f27d3c5a0068cd9aa95fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
