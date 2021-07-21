Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9CF3D0B55
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhGUIb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:31:57 -0400
Received: from foss.arm.com ([217.140.110.172]:49196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235290AbhGUI0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:26:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A3DB31B;
        Wed, 21 Jul 2021 02:07:18 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.38.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF2BF3F694;
        Wed, 21 Jul 2021 02:07:15 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.org, al.grant@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/6] Support ETE decoding
Date:   Wed, 21 Jul 2021 10:06:59 +0100
Message-Id: <20210721090706.21523-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decoding ETE already works because it is a superset of
ETMv4, but if any new packet types are found then they will be
ignored by the decoder. This patchset creates an ETE decoder
which can output the new packets and saves a new register that
is required. No new packet types are handled by perf yet, as this
can be added in the future.

This set applies on top of "perf cs-etm: Support TRBE
(unformatted decoding)" on perf/core.

James Clark (6):
  perf cs-etm: Refactor initialisation of decoder params.
  perf cs-etm: Initialise architecture based on TRCIDR1
  perf cs-etm: Save TRCDEVARCH register
  perf cs-etm: Update OpenCSD decoder for ETE
  perf cs-etm: Create ETE decoder
  perf cs-etm: Print the decoder name

 tools/build/feature/test-libopencsd.c         |   4 +-
 tools/perf/arch/arm/util/cs-etm.c             |  13 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 151 ++++++++----------
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   8 +
 tools/perf/util/cs-etm.c                      |  54 ++++++-
 tools/perf/util/cs-etm.h                      |   6 +-
 6 files changed, 147 insertions(+), 89 deletions(-)

-- 
2.28.0

