Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0459436B3EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhDZNRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 09:17:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:57069 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233639AbhDZNRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:17:00 -0400
IronPort-SDR: 0HSAgCNe2jiemAoIwXW+KKzSc0WBAzar8kENjloFPizDf5/kaUSXMvvOnNA922igVNPP2pkIjd
 J/pbkzSiic7Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175815560"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="175815560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 06:16:17 -0700
IronPort-SDR: Ti+R+OWnJB5xZhTB9xttgtscJxu8efdsn4ZOYzQKqv3fuxMhSLOBS7O/8SIMqlXbITTI+E6uuo
 84m/HTlgOrqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="424903128"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2021 06:16:14 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        ak@linux.intel.com, steve.wahl@hpe.com, kyle.meyer@hpe.com,
        alexander.antonov@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com
Subject: [PATCH 0/3] perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on SNR and ICX
Date:   Mon, 26 Apr 2021 16:16:11 +0300
Message-Id: <20210426131614.16205-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Currently I/O stacks to IIO PMON mapping is available on Skylake servers only
and it is exposed through attributes /sys/devices/uncore_iio_<pmu_idx>/dieX,
where dieX is a file which holds "Segment:Root Bus" for PCIe root port which
can be monitored by that IIO PMON block.

The example for 2-S Skylake server:

# tail /sys/devices/uncore_iio_*/die*
==> /sys/devices/uncore_iio_0/die0 <==
0000:00
==> /sys/devices/uncore_iio_0/die1 <==
0000:80
==> /sys/devices/uncore_iio_1/die0 <==
0000:17
==> /sys/devices/uncore_iio_1/die1 <==
0000:85
==> /sys/devices/uncore_iio_2/die0 <==
0000:3a
==> /sys/devices/uncore_iio_2/die1 <==
0000:ae
==> /sys/devices/uncore_iio_3/die0 <==
0000:5d
==> /sys/devices/uncore_iio_3/die1 <==
0000:d7

Mapping algorithm for Skylake server is based on topology information
from CPU_BUS_NO MSR but this approach is not applicable for Snowridge and
Icelake server.
In case of these platforms mapping can be enabled by reading SAD_CONTROL_CFG
CSR from Mesh2IIO device with 0x09a2 DID. This CSR contains stack IDs in its
own notation and these IDs are statically mapped on IDs in PMON notation.

This patchset enables I/O stacks to IIO PMON mapping for Snowridge and Icelake
server.

Alexander Antonov (3):
  perf/x86/intel/uncore: Generalize I/O stacks to PMON mapping procedure
  perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on SNR
  perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on ICX

 arch/x86/events/intel/uncore.h       |   1 +
 arch/x86/events/intel/uncore_snbep.c | 173 ++++++++++++++++++++++++++-
 2 files changed, 168 insertions(+), 6 deletions(-)


base-commit: cface0326a6c2ae5c8f47bd466f07624b3e348a7
-- 
2.21.3

