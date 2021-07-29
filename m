Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB93F3DA833
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhG2QBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:01:00 -0400
Received: from foss.arm.com ([217.140.110.172]:51310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238333AbhG2P6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:58:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16F0C1FB;
        Thu, 29 Jul 2021 08:58:44 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BDFB3F73D;
        Thu, 29 Jul 2021 08:58:41 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
Cc:     leo.yan@linaro.org, suzuki.poulose@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/6] perf tools: Warning fixes
Date:   Thu, 29 Jul 2021 16:57:59 +0100
Message-Id: <20210729155805.2830-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm submitting this as an RFC because there are a few changes I'd
like to get feedback on. The two changes I wanted to make were the
last two for Coresight warnings, but I ended up making some perf-wide
changes along the way.

For #1 (perf tools: Add WARN_ONCE equivalent for UI warnings)
 * Does it make sense to add warn once equivalents at all, or
   should the once be re-done for each usage?
 * Or should there be some kind of generic 'once' wrapper?

For #3 (perf tools: Add disassembly warnings for annotate --stdio)
 * If the output is interpreted by any other tools, then adding
   these warnings could be an issue, so maybe this change could
   be dropped, but no error output at all isn't ideal.

For #4 (perf tools: Add flag for tracking warnings of missing DSOs)
 * In theory I could re-use 'annotate_warned', but it might make sense
   to rename it in that case, or just leave the new auxtrace_warned and
   remove any confusion.

This set applies to perf/core e73f0f0ee7541

Thanks
James

James Clark (6):
  perf tools: Add WARN_ONCE equivalent for UI warnings
  perf tools: Re-add annotate_warned functionality
  perf tools: Add disassembly warnings for annotate --stdio
  perf tools: Add flag for tracking warnings of missing DSOs
  perf cs-etm: Improve Coresight zero timestamp warning
  perf cs-etm: Add warnings for missing DSOs

 tools/perf/ui/browsers/annotate.c             |  1 +
 tools/perf/ui/gtk/annotate.c                  |  1 +
 tools/perf/util/annotate.c                    | 20 +++++++++++++++++--
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  7 +++++--
 tools/perf/util/cs-etm.c                      | 10 +++++++++-
 tools/perf/util/debug.h                       | 14 +++++++++++++
 tools/perf/util/dso.h                         |  1 +
 7 files changed, 49 insertions(+), 5 deletions(-)

-- 
2.28.0

