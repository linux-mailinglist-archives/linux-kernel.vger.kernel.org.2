Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDD43BA490
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 22:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhGBUQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 16:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230116AbhGBUQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 16:16:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C2F3461405;
        Fri,  2 Jul 2021 20:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625256819;
        bh=d5ZU1/pzMvHwZ05Fx2ITCzOHxaWZZfhdgCRQPjtpC18=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pt22tI98jKpFMyxpSzg9w0myHcEmXdNcZA0CUl3SD21GdnvuwzPSzHmC1SpO0Tn8Y
         smo0nf5jLwu0FxNO9PEw3jDde5iO1w7ntWzoDfBGYZvguFYVPedSkvkcOwhTAg1/np
         YRoyi65q8nP7CNUclduGbU3X7ASDtGolKMPgaTABtpIDww+2OvbQMd2kwVHnim97c7
         UOintmFBsCll6r1+8voR/6eWeDF7Z6usk9nkMYNyx/a0HAG8u9ndFoVkL2XhfnzmoP
         P+sX2ZwSejhF6I/sZodT0tb7MH8rxysJk27AnoziITtaBVWvoexe/k044PZuYFZ4kO
         QArpC9tCBPYgA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AC4A1609E4;
        Fri,  2 Jul 2021 20:13:39 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210702000110.1179766-1-acme@kernel.org>
References: <20210702000110.1179766-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210702000110.1179766-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.14-2021-07-01
X-PR-Tracked-Commit-Id: cf96b8e45a9bf74d2a6f1e1f88a41b10e9357c6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 406254918b232db198ed60f5bf1f8b84d96bca00
Message-Id: <162525681964.6172.866147960098734636.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 20:13:39 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Hulk Robot <hulkci@huawei.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joshua Martinez <joshuamart@google.com>,
        Lei Zhao <zhaolei27@baidu.com>, Leo Yan <leo.yan@linaro.org>,
        Li Huafei <lihuafei1@huawei.com>,
        Li RongQing <lirongqing@baidu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Rob Herring <robh@kernel.org>, Song Liu <song@kernel.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Zou Wei <zou_wei@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  1 Jul 2021 21:01:10 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.14-2021-07-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/406254918b232db198ed60f5bf1f8b84d96bca00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
