Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C303790DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhEJOfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:35:42 -0400
Received: from foss.arm.com ([217.140.110.172]:59766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhEJOd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:33:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 282EC31B;
        Mon, 10 May 2021 07:32:54 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.83.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B37163F719;
        Mon, 10 May 2021 07:32:49 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        acme@kernel.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] perf cs-etm: Set time on synthesised samples to preserve ordering
Date:   Mon, 10 May 2021 17:32:46 +0300
Message-Id: <20210510143248.27423-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
  * Collect acked and reviewed-by tags from v1 that were
    missed in v2
  * Add comment and commit message suggestions from Suzuki
  * Rebase onto next-20210510 (also applies to perf/core)

Thanks
James


James Clark (2):
  perf cs-etm: Refactor timestamp variable names
  perf cs-etm: Set time on synthesised samples to preserve ordering

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 +++---
 tools/perf/util/cs-etm.c                      | 57 +++++++++++--------
 tools/perf/util/cs-etm.h                      |  4 +-
 3 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.28.0

