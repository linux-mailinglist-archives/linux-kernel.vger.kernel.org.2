Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76BB3393B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhCLQkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:40:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:14817 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232043AbhCLQkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:40:25 -0500
IronPort-SDR: hLPwO+WyT9dPZunXJxx46l2r+E3uKuoF7s6S27yDlv6fcK+A4YmAhHqJ45KyaUcizUeKDdGZPw
 xS55DTvT75zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="188219717"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="188219717"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 08:40:24 -0800
IronPort-SDR: VT2d3zzvVAoBu5mGLfAXjm8P/vTYcWyX9TV7cfdDTVhlPQ9xTYD+7PDSm8LGrSc8OPc6qDRGvA
 HZEQfUwSdH7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="404469053"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga008.fm.intel.com with ESMTP; 12 Mar 2021 08:40:23 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/5] Uncore PMON discovery mechanism support
Date:   Fri, 12 Mar 2021 08:34:33 -0800
Message-Id: <1615566878-70244-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A mechanism of self-describing HW for the uncore PMOM has been
introduced with the latest Intel platforms. By reading through an MMIO
page worth of information, SW can ‘discover’ all the standard uncore
PMON registers.

With the discovery mechanism, Perf can
- Retrieve the generic uncore unit information of all standard uncore
  blocks, e.g., the address of counters, the address of the counter
  control, the counter width, the access type, etc.
  Perf can provide basic uncore support based on this information.
  For a new platform, perf users will get basic uncore support even if
  the platform-specific enabling code is not ready yet.
- Retrieve accurate uncore unit information, e.g., the number of uncore
  boxes. The number of uncore boxes may be different among machines.
  Current perf hard code the max number of the uncore blocks. On some
  machines, perf may create a PMU for an unavailable uncore block.
  Although there is no harm (always return 0 for the unavailable uncore
  block), it may confuse the users. The discovery mechanism can provide
  the accurate number of available uncore boxes on a machine.

But, the discovery mechanism has some limits,
- Rely on BIOS's support. If a BIOS doesn't support the discovery
  mechanism, the uncore driver will exit with -ENODEV. There is nothing
  changed.
- Only provide the generic uncore unit information. The information for
  the advanced features, such as fixed counters, filters, and
  constraints, cannot be retrieved.
- Only support the standard PMON blocks. Non-standard PMON blocks, e.g.,
  free-running counters, are not supported.
- Only provide an ID for an uncore block. No meaningful name is
  provided. The uncore_type_&typeID_&boxID will be used as the name.
- Enabling the PCI and MMIO type of uncore blocks rely on the NUMA support.
  These uncore blocks require the mapping information from a BUS to a
  die. The current discovery table doesn't provide the mapping
  information. The pcibus_to_node() from NUMA is used to retrieve the
  information. If NUMA is not supported, some uncore blocks maybe
  unavailable.

To locate the MMIO page, SW has to find a PCI device with the unique
capability ID 0x23 and retrieve its BAR address.

The spec can be found at Snow Ridge or Ice Lake server's uncore document.
https://cdrdv2.intel.com/v1/dl/getContent/611319

Kan Liang (5):
  perf/x86/intel/uncore: Parse uncore discovery tables
  perf/x86/intel/uncore: Generic support for the MSR type of uncore
    blocks
  perf/x86/intel/uncore: Rename uncore_notifier to
    uncore_pci_sub_notifier
  perf/x86/intel/uncore: Generic support for the PCI type of uncore
    blocks
  perf/x86/intel/uncore: Generic support for the MMIO type of uncore
    blocks

 arch/x86/events/intel/Makefile           |   2 +-
 arch/x86/events/intel/uncore.c           | 184 +++++++--
 arch/x86/events/intel/uncore.h           |  10 +-
 arch/x86/events/intel/uncore_discovery.c | 626 +++++++++++++++++++++++++++++++
 arch/x86/events/intel/uncore_discovery.h | 131 +++++++
 5 files changed, 922 insertions(+), 31 deletions(-)
 create mode 100644 arch/x86/events/intel/uncore_discovery.c
 create mode 100644 arch/x86/events/intel/uncore_discovery.h

-- 
2.7.4

