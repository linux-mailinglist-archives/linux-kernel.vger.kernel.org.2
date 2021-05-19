Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5A388B46
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345999AbhESKDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:03:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:20757 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345656AbhESKDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:03:53 -0400
IronPort-SDR: EcEhhBdAIycZqszdXY11av68P44Nvp+LDdkaBG1UPh5Q4YyvAANnvMQDIbEGhX5NUMWX6lE1tV
 DpiWAoN9zyoA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="286469051"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="286469051"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 03:02:05 -0700
IronPort-SDR: IGMfFdNYII17tU+yMvKunDBi+jWnFs1QssOljd6UdCudBWXlmTvpz/0ImTQDnkMK4sRJjeRM9j
 Ava2F/I3r+jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="466908517"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 19 May 2021 03:02:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 45CB3BA; Wed, 19 May 2021 13:02:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v1 1/1] usb: typec: wcove: Use LE to CPU conversion when accessing msg->header
Date:   Wed, 19 May 2021 13:02:12 +0300
Message-Id: <20210519100212.54630-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse is not happy about strict type handling:
  .../typec/tcpm/tcpm.c:2720:27: warning: restricted __le16 degrades to integer
  .../typec/tcpm/tcpm.c:2814:32: warning: restricted __le16 degrades to integer

Fix this by converting LE to CPU before use.

Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
Fixes: 64f7c494a3c0 ("typec: tcpm: Add support for sink PPS related messages")
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 64133e586c64..8fdfd7f65ad7 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2717,7 +2717,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
 	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
 	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
 
-	if (!(msg->ext_msg.header & PD_EXT_HDR_CHUNKED)) {
+	if (!(le16_to_cpu(msg->ext_msg.header) & PD_EXT_HDR_CHUNKED)) {
 		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
 		tcpm_log(port, "Unchunked extended messages unsupported");
 		return;
@@ -2811,7 +2811,7 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 				 "Data role mismatch, initiating error recovery");
 			tcpm_set_state(port, ERROR_RECOVERY, 0);
 		} else {
-			if (msg->header & PD_HEADER_EXT_HDR)
+			if (le16_to_cpu(msg->header) & PD_HEADER_EXT_HDR)
 				tcpm_pd_ext_msg_request(port, msg);
 			else if (cnt)
 				tcpm_pd_data_request(port, msg);
-- 
2.30.2

