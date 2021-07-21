Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7103C3D1705
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 21:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbhGUSpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 14:45:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:61527 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230480AbhGUSpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:45:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="198773151"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="198773151"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 12:26:18 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="511909289"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 12:26:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH - Linus please apply] dmaengine: idxd: Change license on idxd.h to LGPL
Date:   Wed, 21 Jul 2021 12:25:20 -0700
Message-Id: <20210721192520.1442023-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file was given GPL-2.0 license. But LGPL-2.1 makes more sense
as it needs to be used by libraries outside of the kernel source tree.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
All content of this file was contributed by Intel employees, so
should be no issues in swapping the license.
---
 include/uapi/linux/idxd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index e33997b4d750..edc346a77c91 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: LGPL-2.1 WITH Linux-syscall-note */
 /* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
 #ifndef _USR_IDXD_H_
 #define _USR_IDXD_H_
-- 
2.29.2

