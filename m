Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD833C8003
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbhGNI3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 04:29:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:59554 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238517AbhGNI3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:29:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="232118692"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="232118692"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 01:26:59 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="505147105"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 01:26:58 -0700
From:   Shuo Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, fei1.li@intel.com,
        Shuo Liu <shuo.a.liu@intel.com>
Subject: [PATCH] MAINTAINERS: Change ACRN HSM driver maintainer
Date:   Wed, 14 Jul 2021 16:26:14 +0800
Message-Id: <20210714082614.88560-1-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuo steps down, Fei will take over.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a61f4f3b78a9..fb4a9d08dc15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -445,7 +445,7 @@ F:	drivers/platform/x86/wmi.c
 F:	include/uapi/linux/wmi.h
 
 ACRN HYPERVISOR SERVICE MODULE
-M:	Shuo Liu <shuo.a.liu@intel.com>
+M:	Fei Li <fei1.li@intel.com>
 L:	acrn-dev@lists.projectacrn.org (subscribers-only)
 S:	Supported
 W:	https://projectacrn.org
-- 
2.28.0

