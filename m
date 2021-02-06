Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0532311DE1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 15:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhBFOo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 09:44:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:38614 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhBFOoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:44:19 -0500
IronPort-SDR: NBUmpEfGSXlHL5HRMzrhxcM+CSukKhsfc2T6cmwO62uGiXns82iX7z0DjjcSxlaVAhffG4q3G6
 255YfuSiOpKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200566032"
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="200566032"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:43:39 -0800
IronPort-SDR: dd39Z3IBKfPGMl3TSWBVLethjAFJrtzYBub2FVxh1lDhX14d8REEf3IUpBN24dvVfK9Gwj1GWh
 hwlKwFXtMCqw==
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="394360209"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:43:37 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/6] mei: use sprintf in tx_queue_limit_show sysfs
Date:   Sat,  6 Feb 2021 16:43:20 +0200
Message-Id: <20210206144325.25682-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using of snprintf is discouraged in sysfs.
For simple u8 it is safe to use sprintf.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 9f6682033ed7..24a05f45b639 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1026,7 +1026,7 @@ static ssize_t tx_queue_limit_show(struct device *device,
 	size = dev->tx_queue_limit;
 	mutex_unlock(&dev->device_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sprintf(buf, "%u\n", size);
 }
 
 static ssize_t tx_queue_limit_store(struct device *device,
-- 
2.26.2

