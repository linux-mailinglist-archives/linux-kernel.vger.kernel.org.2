Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B30E37F9C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhEMOhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:37:08 -0400
Received: from foss.arm.com ([217.140.110.172]:36702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234527AbhEMOgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:36:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31597169E;
        Thu, 13 May 2021 07:35:32 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.81.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 503613F73B;
        Thu, 13 May 2021 07:35:29 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] perf cs-etm: Handle valid-but-zero timestamps
Date:   Thu, 13 May 2021 17:35:17 +0300
Message-Id: <20210513143520.22694-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is an alternate solution to the original: "[RFC PATCH]
perf cs-etm: Handle valid-but-zero timestamps". It uses the existing
Z option to --itrace instead of modifying the behaviour of the
cs_etm__etmq_get_timestamp() function.

Using timeless mode is equivalent to ignoring 0 timestamps, as
suggested by Mike and Leo.

It applies on top of "[PATCH v3 0/2] perf cs-etm: Set time on
synthesised samples to preserve ordering"

James Clark (3):
  perf cs-etm: Move synth_opts initialisation
  perf cs-etm: Start reading 'Z' --itrace option
  perf cs-etm: Prevent and warn on underflows during timestamp
    calculation.

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 45 ++++++++++++++-----
 tools/perf/util/cs-etm.c                      | 20 +++++----
 2 files changed, 46 insertions(+), 19 deletions(-)

-- 
2.28.0

