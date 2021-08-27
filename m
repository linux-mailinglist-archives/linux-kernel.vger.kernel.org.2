Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE4B3FA025
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhH0T4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:56:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:26658 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhH0T4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:56:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="218024424"
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="218024424"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 12:55:56 -0700
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="528422070"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 12:55:55 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Cathy Zhang <cathy.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 0/6] Basic recovery for machine checks inside SGX
Date:   Fri, 27 Aug 2021 12:55:37 -0700
Message-Id: <20210827195543.1667168-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210728204653.1509010-1-tony.luck@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's version 4 (just 38 more to go if I want to meet the bar set by
the base SGX series :-) )

Changes since v3:

Dave Hansen:
	1) Concerns about assigning a default value to the "owner"
	   pointer if the caller of sgx_alloc_epc_page() called with
	   a NULL value.
	Resolved: Sean provided a patch to fix the only caller that
	was using NULL. I merged it in here.

	2) Better commit message to explain why sgx_is_epc_page() is
	   exported.
	Done.

	3) Unhappy with "void *owner" in struct sgx_epc_page. Would
	   be better to use an anonymous union of all the types.
	Done.

Sean Christopherson:
	1) Races updating bits in flags field.
	Resolved: "poison" is now a separate field.

	2) More races. When poison alert happens while moving
	   a page on/off a free/dirty list.
	Resolved: Well mostly. All the run time changes are now
	done while holding the node->lock. There's a gap while
	moving pages from dirty list to free list. But that's
	a short-ish window during boot, and the races are mostly
	harmless. Worst is that we might call __eremove() for a
	page that just got marked as poisoned. But then
	sgx_free_epc_page() will see the poison flag and do the
	right thing.

Jarkko Sakkinen:
	1) Use xarray to keep track of which pages are the special
	   SGX EPC ones.
	This spawned a short discussion on whether it was overkill. But
	xarray makes the source much simpler, and there are improvements
	in the pipeline for xarray that will make it handle this use
	case more efficiently. So I made this change.

	2) Move the sgx debugfs directory under arch_debugfs_dir.
	Done.

Tony Luck (6):
  x86/sgx: Provide indication of life-cycle of EPC pages
  x86/sgx: Add infrastructure to identify SGX EPC pages
  x86/sgx: Initial poison handling for dirty and free pages
  x86/sgx: Add SGX infrastructure to recover from poison
  x86/sgx: Hook sgx_memory_failure() into mainline code
  x86/sgx: Add hook to error injection address validation

 .../firmware-guide/acpi/apei/einj.rst         |  19 +++
 arch/x86/include/asm/set_memory.h             |   4 +
 arch/x86/kernel/cpu/sgx/encl.c                |   5 +-
 arch/x86/kernel/cpu/sgx/encl.h                |   2 +-
 arch/x86/kernel/cpu/sgx/ioctl.c               |   2 +-
 arch/x86/kernel/cpu/sgx/main.c                | 140 ++++++++++++++++--
 arch/x86/kernel/cpu/sgx/sgx.h                 |  14 +-
 drivers/acpi/apei/einj.c                      |   3 +-
 include/linux/mm.h                            |  15 ++
 mm/memory-failure.c                           |  19 ++-
 10 files changed, 196 insertions(+), 27 deletions(-)


base-commit: e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93
-- 
2.29.2

