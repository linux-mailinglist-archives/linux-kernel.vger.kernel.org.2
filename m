Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3085350AB8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhCaX1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:27:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:4846 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhCaX0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:26:41 -0400
IronPort-SDR: S0aHk6GCniZOfAj9Mq6ifpwuEeXwz/TsmGuvFwnGe3j5kyAaZ1iB4Qk0JyScxu2fSEr+tPtmlJ
 O9m3Z9zw3WuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171528072"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="171528072"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:41 -0700
IronPort-SDR: 3No0/Qf/eTO89iepDYeyx95eT3Ej5/O6UCR8hJ6rSQe0tsfJsmX6baCmpdw+MA0prgCk7dixxE
 8ls0AID5FGBg==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="610685731"
Received: from dfrayn-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.146.236])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:40 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/7] driver core: attribute_container: remove kernel-doc warnings
Date:   Wed, 31 Mar 2021 18:26:09 -0500
Message-Id: <20210331232614.304591-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
References: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove make W=1 warnings

drivers/base/attribute_container.c:471: warning: Function parameter or
member 'cont' not described in
'attribute_container_add_class_device_adapter'

drivers/base/attribute_container.c:471: warning: Function parameter or
member 'dev' not described in
'attribute_container_add_class_device_adapter'

drivers/base/attribute_container.c:471: warning: Function parameter or
member 'classdev' not described in
'attribute_container_add_class_device_adapter'

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/attribute_container.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
index f7bd0f4db13d..9c00d203d61e 100644
--- a/drivers/base/attribute_container.c
+++ b/drivers/base/attribute_container.c
@@ -461,6 +461,10 @@ attribute_container_add_class_device(struct device *classdev)
 /**
  * attribute_container_add_class_device_adapter - simple adapter for triggers
  *
+ * @cont: the container to register.
+ * @dev:  the generic device to activate the trigger for
+ * @classdev:	the class device to add
+ *
  * This function is identical to attribute_container_add_class_device except
  * that it is designed to be called from the triggers
  */
-- 
2.25.1

