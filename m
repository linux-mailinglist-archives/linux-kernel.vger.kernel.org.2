Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EAB350ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhCaX1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:27:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:4846 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230349AbhCaX0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:26:48 -0400
IronPort-SDR: i2xRrawafQvx9+1AOGu6RzM27TjLfdmw8mNM1y/OfsuPWhrtLRgZYJM1DS60FUaU5Wh38YbIZ4
 dmUUn2wHRpYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171528086"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="171528086"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:48 -0700
IronPort-SDR: Sc5XF5rWEx6dHYe3EMa/6MsHwtpUHr8qKM01SU0oOLyL2FOAcuRw8Aljfrdl+pE65w0sPqT7+4
 8+kOrkf+zOlg==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="610685766"
Received: from dfrayn-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.146.236])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:47 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 6/7] platform-msi: fix kernel-doc warnings
Date:   Wed, 31 Mar 2021 18:26:13 -0500
Message-Id: <20210331232614.304591-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
References: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove make W=1 warnings

drivers/base/platform-msi.c:336: warning:
Function parameter or member 'is_tree' not described in
'__platform_msi_create_device_domain'

drivers/base/platform-msi.c:336: warning:
expecting prototype for platform_msi_create_device_domain(). Prototype
was for __platform_msi_create_device_domain() instead

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/platform-msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 2c1e2e0c1a59..0b72b134a304 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -316,10 +316,11 @@ void *platform_msi_get_host_data(struct irq_domain *domain)
 }
 
 /**
- * platform_msi_create_device_domain - Create a platform-msi domain
+ * __platform_msi_create_device_domain - Create a platform-msi domain
  *
  * @dev:		The device generating the MSIs
  * @nvec:		The number of MSIs that need to be allocated
+ * @is_tree:		flag to indicate tree hierarchy
  * @write_msi_msg:	Callback to write an interrupt message for @dev
  * @ops:		The hierarchy domain operations to use
  * @host_data:		Private data associated to this domain
-- 
2.25.1

