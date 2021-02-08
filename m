Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC583138A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 16:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhBHPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 10:55:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:25629 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233209AbhBHPHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:07:48 -0500
IronPort-SDR: 1KPq9AQhEFpoZew618y7D8U5axzalWuKjtuF5xCE4hh+aY6CjNooaxvWjLkZ27zolH0NtpOo3g
 JuwemnuRTkuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="181871135"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181871135"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:07:08 -0800
IronPort-SDR: zY/lj5VcuqgD9epcaRCx04VlVIqhXqpGqFaWpARD42luWszyD8hUnVfBAQCN3pw/+nFcJDAc9x
 /TeMVNOncI4g==
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="395414249"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:07:06 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/2] mei: use sysfs_emit() in tx_queue_limit_show sysfs
Date:   Mon,  8 Feb 2021 17:06:49 +0200
Message-Id: <20210208150649.141358-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210208150649.141358-1-tomas.winkler@intel.com>
References: <20210208150649.141358-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using of snprintf is discouraged in sysfs use the new sysfs_emit() API.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 9f6682033ed7..28937b6e7e0c 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1026,7 +1026,7 @@ static ssize_t tx_queue_limit_show(struct device *device,
 	size = dev->tx_queue_limit;
 	mutex_unlock(&dev->device_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t tx_queue_limit_store(struct device *device,
-- 
2.26.2

