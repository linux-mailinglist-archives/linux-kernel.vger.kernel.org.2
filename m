Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8239C361E52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbhDPK5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:57:08 -0400
Received: from foss.arm.com ([217.140.110.172]:38740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhDPK5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:57:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72ADB106F;
        Fri, 16 Apr 2021 03:56:40 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.57.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB6ED3F85F;
        Fri, 16 Apr 2021 03:56:37 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        acme@kernel.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, James Clark <james.clark@arm.com>,
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
Subject: [PATCH v2 0/2] perf cs-etm: Set time on synthesised samples to preserve ordering
Date:   Fri, 16 Apr 2021 13:56:30 +0300
Message-Id: <20210416105632.8771-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
 * Improved variable name from etm_timestamp -> cs_timestamp
 * Fixed ordering of Signed-off-by

James Clark (2):
  perf cs-etm: Refactor timestamp variable names
  perf cs-etm: Set time on synthesised samples to preserve ordering

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 +++----
 tools/perf/util/cs-etm.c                      | 52 ++++++++++---------
 tools/perf/util/cs-etm.h                      |  4 +-
 3 files changed, 39 insertions(+), 35 deletions(-)

-- 
2.28.0

