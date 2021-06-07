Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1744C39DD69
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFGNQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:16:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:17596 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhFGNQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:16:18 -0400
IronPort-SDR: lc0qqfZUu3xBbHgp+32IZ6hF0BoXBLHEcju3iMBmfe3N3H0/QyA/bA75/s6xZZLCy7VQUKHuYo
 JcbX/PqazQrg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265773989"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="265773989"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 06:14:27 -0700
IronPort-SDR: kPmwXhJBEIz3UawO9j7Cj1wmGv5P/SrYM6YsW+5S5f13lUeuW+20Psm6H6/N9PCutYTYI9jinV
 7B6N8ZkeeEZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551881892"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2021 06:14:25 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/7] usb: typec: ucsi: acpi: Reduce the command completion timeout
Date:   Mon,  7 Jun 2021 16:14:39 +0300
Message-Id: <20210607131442.20121-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The huge delay was there to workaround a problem where the
firmware did not report that if it was busy with the
alternate mode commands. Now that the alternate modes are
polled, the delay can be dropped.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 04976435ad736..6771f05e32c29 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -78,7 +78,7 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 	if (ret)
 		goto out_clear_bit;
 
-	if (!wait_for_completion_timeout(&ua->complete, 60 * HZ))
+	if (!wait_for_completion_timeout(&ua->complete, HZ))
 		ret = -ETIMEDOUT;
 
 out_clear_bit:
-- 
2.30.2

