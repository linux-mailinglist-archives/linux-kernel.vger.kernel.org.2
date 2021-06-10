Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D733A296F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFJKi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 06:38:57 -0400
Received: from foss.arm.com ([217.140.110.172]:56530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhFJKi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:38:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABE7ED6E;
        Thu, 10 Jun 2021 03:36:58 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.31.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1C753F694;
        Thu, 10 Jun 2021 03:36:55 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/1] perf cs-etm: Split Coresight decode by aux records
Date:   Thu, 10 Jun 2021 13:36:46 +0300
Message-Id: <20210610103647.7038-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since RFC v4:
 * Style and indentation fixes
 * Add a warning when the buffer isn't found (suggested by Leo)
 * Undo change to set 'etm->data_queued'
 * Replace 'matchesCpuPid' with early exit when CPU/TID doesn't match
 * Check more return value errors
 * Remove TODOs from commit message and code
 * Add motivation to commit message


James Clark (1):
  perf cs-etm: Split Coresight decode by aux records

 tools/perf/util/cs-etm.c | 158 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

-- 
2.28.0

