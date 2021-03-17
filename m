Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9525533F7CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhCQSGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:06:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:35063 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232600AbhCQSFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:05:32 -0400
IronPort-SDR: XVJf84wUFW/Nu4dEsg5O+ccDcp8zT0vWYFox4n7zm/u+cjrJOm33sKs6DSjD8zidkZ6cc384iN
 nnkPp8opnWZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="209489881"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="209489881"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 11:05:32 -0700
IronPort-SDR: 0LSquPGamsQqt5xaSQY90QnnveCDsb0lMdbg/thUiAQMjm/fBwSy7qpeEuYoP0V+vlB8StQxNm
 qe8bYg+0481w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="522957241"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2021 11:05:32 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 0/5] Uncore PMON discovery mechanism support
Date:   Wed, 17 Mar 2021 10:59:32 -0700
Message-Id: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V1:
- Use the generic rbtree functions, rb_add() and rb_find(). (Patch 1)
- Add a module parameter, uncore_no_discover. If users don't want the
  discovery feature, they can set uncore_no_discover=true. (Patch 1)


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
 arch/x86/events/intel/uncore.c           | 188 ++++++++--
 arch/x86/events/intel/uncore.h           |  10 +-
 arch/x86/events/intel/uncore_discovery.c | 622 +++++++++++++++++++++++++++++++
 arch/x86/events/intel/uncore_discovery.h | 131 +++++++
 5 files changed, 922 insertions(+), 31 deletions(-)
 create mode 100644 arch/x86/events/intel/uncore_discovery.c
 create mode 100644 arch/x86/events/intel/uncore_discovery.h

-- 
2.7.4

