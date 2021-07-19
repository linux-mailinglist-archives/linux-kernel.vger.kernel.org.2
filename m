Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB53CED49
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382071AbhGSRwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:52:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:51676 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382639AbhGSRjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:39:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211166997"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="211166997"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:20:15 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="509462730"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:20:15 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 0/6] Basic recovery for machine checks inside SGX
Date:   Mon, 19 Jul 2021 11:20:03 -0700
Message-Id: <20210719182009.1409895-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210708181423.1312359-1-tony.luck@intel.com>
References: <20210708181423.1312359-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very different from version 1 based on feedback.

Sean:	Didn't like tracking types of SGX pages, so that's all gone now. I
	do track the life cycle (in patch 1) using the "owner" field to
	determine whether a page is in use vs. dirty/free. Currently
	this series doesn't make use of that ... so patch 1 could be
	dropped. But it is very small, and I think a pre-requisite for
	future improvements to take pre-emptive action for asynch poison
	notification (rather that just hoping that the enclave will exit
	without accessing poison, or that if it does consume the poison
	the error will be recoverable).

	I think we should defer the whole asynch action to a subsequent
	series that can build on top of this (and do it properly ...
	my version 1 sent out SIGBUS signals without regard for system
	(/proc/sys/vm/memory_failure_early_kill) or per-task (prctl
	PR_MCE_KILL) policies).

Jarkko:	Said poison pages should not just be dropped on the floor. They
	should be added to a list for future tools to examine. I tried
	the list approach, but safely removing pages from free/dirty
	lists involved some complex locking, so I skipped ahead to the
	"tools" idea and just added files in debugfs to show the count
	of poison pages and a list of addresses (maybe the count is
	redundant? Could just "wc -l poison_page_list"?).

Other:	I got a complaint that after a poison page is handled Linux
	spits out this message:
		Could not invalidate pfn=0x2000c4d from 1:1 map
	this is from set_mce_nospec() and happens because EPC pages
	are not in the 1:1 map. Add code to check and ignore them.

Tony Luck (6):
  x86/sgx: Provide indication of life-cycle of EPC pages
  x86/sgx: Add infrastructure to identify SGX EPC pages
  x86/sgx: Initial poison handling for dirty and free pages
  x86/sgx: Add SGX infrastructure to recover from poison
  x86/sgx: Hook sgx_memory_failure() into mainline code
  x86/sgx: Add hook to error injection address validation

 .../firmware-guide/acpi/apei/einj.rst         |  19 +++
 arch/x86/include/asm/set_memory.h             |   4 +
 arch/x86/kernel/cpu/sgx/encl.c                |   2 +-
 arch/x86/kernel/cpu/sgx/main.c                | 137 +++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h                 |   6 +-
 drivers/acpi/apei/einj.c                      |   3 +-
 include/linux/mm.h                            |  15 ++
 mm/memory-failure.c                           |  19 ++-
 8 files changed, 195 insertions(+), 10 deletions(-)


base-commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
-- 
2.29.2

