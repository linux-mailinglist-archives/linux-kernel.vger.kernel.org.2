Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FAF3CCA6C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhGRTg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 15:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhGRTgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 15:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D1E506108B;
        Sun, 18 Jul 2021 19:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626636806;
        bh=uk9e0d6OKHYLTmMx9DEC+xLy1WoOJiwHDTEAwiyFFzg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tauVAILm0HaEPrVFnOu18RwTO5RH8KnARDh8qtIw2PuTgd8HK1FSY3L0ErSzPAXH7
         G2nVq9VEwGKGl0xjWExzs5t880p0r5uI3smq60bgiAJ6Y/F/eX5RJMWHBp4o/S4VD4
         Ph8+hpqVsU9BzE9e6yxJTYrHu4+QgtjYLdfPRaMf3A52WqI4CKcIHHXKreB4vqp5MS
         amfUQkC9Bb6sCXHNU16zR1KsGGZFHr6ywMrvofuSiGVfszRQiDbjzlC3U/JF1MwyTQ
         8HxyYoZkI0vGyKlRL2G+aVpKLNaTvFu7ULdUIsWaRNglk5P9kjnWZKmRi0+UVBYWYJ
         xrW+a6B7XPSEQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BA06260A0B;
        Sun, 18 Jul 2021 19:33:26 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.14: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210718191110.168666-1-acme@kernel.org>
References: <20210718191110.168666-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210718191110.168666-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.14-2021-07-18
X-PR-Tracked-Commit-Id: b0f008551f0bf4d5f6db9b5f0e071b02790d6a2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c25c4476496b7136767c4023d1c08990167eaa0
Message-Id: <162663680669.28276.1100933162077024505.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Jul 2021 19:33:26 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Jul 2021 16:11:10 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.14-2021-07-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c25c4476496b7136767c4023d1c08990167eaa0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
