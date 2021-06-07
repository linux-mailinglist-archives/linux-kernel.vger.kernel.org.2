Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96D39DD65
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhFGNQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:16:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:17596 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230286AbhFGNQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:16:15 -0400
IronPort-SDR: tBavJunpLrIJaTDUFzwAqPVD9WU12Nlr3q/LBHCYUyA1e88O+w+a0R3QywmAO4XB6NW3PRHdFE
 eAUKRS/85Z4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265773975"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="265773975"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 06:14:23 -0700
IronPort-SDR: Rukd6daE8+rrbDufK/dGwRtteilroJL0Sg0stGAun2qE5Ec665Q2/CGRi9qJMviz+NqAK1kSo5
 3qD2rzxnjxFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551881872"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2021 06:14:22 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/7] usb: typec: ucsi: Don't stop alt mode registration on busy condition
Date:   Mon,  7 Jun 2021 16:14:37 +0300
Message-Id: <20210607131442.20121-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the PPM tells it's busy, we can now simply try again.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 366c8a468bc18..a8e0e31dcddf5 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -437,8 +437,11 @@ static int ucsi_register_altmodes(struct ucsi_connector *con, u8 recipient)
 		command |= UCSI_GET_ALTMODE_CONNECTOR_NUMBER(con->num);
 		command |= UCSI_GET_ALTMODE_OFFSET(i);
 		len = ucsi_send_command(con->ucsi, command, alt, sizeof(alt));
-		if (len <= 0)
+		if (len <= 0) {
+			if (len == -EBUSY)
+				continue;
 			return len;
+		}
 
 		/*
 		 * This code is requesting one alt mode at a time, but some PPMs
-- 
2.30.2

