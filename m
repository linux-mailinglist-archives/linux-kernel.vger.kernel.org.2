Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BF53D9702
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhG1UrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:47:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:60186 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231576AbhG1UrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:47:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="234634465"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="234634465"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 13:47:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="506679889"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 13:47:01 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 7/7] x86/sgx: Add documentation for SGX memory errors
Date:   Wed, 28 Jul 2021 13:46:53 -0700
Message-Id: <20210728204653.1509010-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210728204653.1509010-1-tony.luck@intel.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error handling is a bit different for SGX pages. Add a section describing
how asynchronous and consumed errors are handled and the two new
debugfs files that show the count and list of pages with uncorrected
memory errors.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/x86/sgx.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index dd0ac96ff9ef..461bd1daa565 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -250,3 +250,29 @@ user wants to deploy SGX applications both on the host and in guests
 on the same machine, the user should reserve enough EPC (by taking out
 total virtual EPC size of all SGX VMs from the physical EPC size) for
 host SGX applications so they can run with acceptable performance.
+
+Uncorrected memory errors
+=========================
+Systems that support machine check recovery and have local machine
+check delivery enabled can recover from uncorrected memory errors in
+many situations.
+
+Errors in SGX pages that are not currently in use will prevent those
+pages from being allocated.
+
+Errors asynchronously reported against active SGX pages will simply note
+that the page has an error. If the enclave terminates without accessing
+the page Linux will not return it to the free list for reallocation.
+
+When an uncorrected memory error is consumed from within an enclave the
+h/w will mark that enclave so that it cannot be re-entered.  Linux will
+send a SIGBUS to the current task.
+
+In addition to console log entries from processing the machine check or
+corrected machine check interrupt, Linux also provides debugfs files to
+indicate the number of SGX enclave pages that have reported errors and
+the physical addresses of each page:
+
+/sys/kernel/debug/sgx/poison_page_count
+
+/sys/kernel/debug/sgx/poison_page_list
-- 
2.29.2

