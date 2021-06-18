Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757BE3AD018
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbhFRQNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232825AbhFRQMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:12:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF3D361003;
        Fri, 18 Jun 2021 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624032645;
        bh=dbHAgGiYQE6XMZg5rLz1/IZkrUOG2C/iLRbZuuL7kFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAVUyVLgyaxuX8KxNyq+OrBK5egFvOHJAbPWqz2to6IWN9SkuyUmm4k8GIaWaAs13
         uzWArdpN5gvfepQ3QDgf4iRJgeFDNNUVXZfvB+FcROI0HaLQqnUqa4fbiGlsYcyDbY
         Zj0NaJM1Xpvf0mJ6YJSJ6FuMoQXlxcRGhwf5Ir1RaJe2H5DNUDNSwx1wpr56qtMM04
         mFoRXMBY6G5kivDNLP2ju1YOgKUHNsqBkbovvzw3LnWZhhJKNYiKuyrtVmZ5tt8IsU
         J7ZcAfVWqj2gI6JO8tfosH5BQ7RSngcIHdIAyXjEMz+ha0B9/oh/B1dg98jBehHQng
         yiQHCONfwyrvw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf probe: Boot time tracing support followup
Date:   Sat, 19 Jun 2021 01:10:42 +0900
Message-Id: <162403264218.528888.2914545241015551186.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YMycGkhkPuo4xTc4@kernel.org>
References: <YMycGkhkPuo4xTc4@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

I found that I made 2 mistakes at the last series, typo and the return probe.
Since bootconfig have to use %return style definition for the return
probes, I have to update the synthesize_kprobe_trace_def() too.

So here are the follow up patches which update the last patch in the previous
series, and add the return probe support and documentation update.


Thank you,

---

Masami Hiramatsu (3):
      [v2] perf/probe: Add --bootconfig to output definition in bootconfig format
      perf/probe: Show return probe correctly with --bootconfig
      perf/probe: docs: Add --bootconfig option to perf-probe manual


 tools/perf/Documentation/perf-probe.txt |   15 +++++-
 tools/perf/builtin-probe.c              |   12 ++++-
 tools/perf/util/probe-event.c           |   82 +++++++++++++++++++++++++++++--
 tools/perf/util/probe-event.h           |    2 +
 4 files changed, 105 insertions(+), 6 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
