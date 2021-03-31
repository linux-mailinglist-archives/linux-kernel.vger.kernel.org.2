Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D77350AB6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhCaX0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:26:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:4846 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230349AbhCaX0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:26:40 -0400
IronPort-SDR: 6Nd8f6N0/mShUsdTsIVxxqZ4dBWZ1AinEL/gS5phC2U9QWSbxq7T5XJOmcMDA6d4b/O+FW23of
 qA7nr9dUX0zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171528070"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="171528070"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:40 -0700
IronPort-SDR: d5yxGRZnD/XDs2IorH/z4o64+vz+2u/UR07eeyxgZ/dreb4l6N1DNBkKQOBp5pQNftfVXCtfjq
 CCVgYnz0aJaA==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="610685728"
Received: from dfrayn-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.146.236])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:39 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/7] driver core: remove kernel-doc warnings
Date:   Wed, 31 Mar 2021 18:26:08 -0500
Message-Id: <20210331232614.304591-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
References: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove make W=1 warning:

drivers/base/core.c:1670: warning: Function parameter or member
'flags' not described in 'fw_devlink_create_devlink'

drivers/base/core.c:1670: warning: Function parameter or member 'con'
not described in 'fw_devlink_create_devlink'

drivers/base/core.c:1670: warning: Function parameter or member
'sup_handle' not described in 'fw_devlink_create_devlink'

drivers/base/core.c:1670: warning: Function parameter or member
'flags' not described in 'fw_devlink_create_devlink'

drivers/base/core.c:1763: warning: Function parameter or member 'dev'
not described in '__fw_devlink_link_to_consumers'

drivers/base/core.c:1844: warning: Function parameter or member 'dev'
not described in '__fw_devlink_link_to_suppliers'

drivers/base/core.c:1844: warning: Function parameter or member
'fwnode' not described in '__fw_devlink_link_to_suppliers'

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index de518178ac36..ad0d26f04215 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1647,8 +1647,9 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
 
 /**
  * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
- * @con - Consumer device for the device link
- * @sup_handle - fwnode handle of supplier
+ * @con: consumer device for the device link
+ * @sup_handle: fwnode handle of supplier
+ * @flags: devlink flags
  *
  * This function will try to create a device link between the consumer device
  * @con and the supplier device represented by @sup_handle.
@@ -1744,7 +1745,7 @@ static int fw_devlink_create_devlink(struct device *con,
 
 /**
  * __fw_devlink_link_to_consumers - Create device links to consumers of a device
- * @dev - Device that needs to be linked to its consumers
+ * @dev: Device that needs to be linked to its consumers
  *
  * This function looks at all the consumer fwnodes of @dev and creates device
  * links between the consumer device and @dev (supplier).
@@ -1814,8 +1815,8 @@ static void __fw_devlink_link_to_consumers(struct device *dev)
 
 /**
  * __fw_devlink_link_to_suppliers - Create device links to suppliers of a device
- * @dev - The consumer device that needs to be linked to its suppliers
- * @fwnode - Root of the fwnode tree that is used to create device links
+ * @dev: The consumer device that needs to be linked to its suppliers
+ * @fwnode: Root of the fwnode tree that is used to create device links
  *
  * This function looks at all the supplier fwnodes of fwnode tree rooted at
  * @fwnode and creates device links between @dev (consumer) and all the
-- 
2.25.1

