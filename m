Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF8388B50
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346991AbhESKFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:05:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:57186 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345316AbhESKFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:05:02 -0400
IronPort-SDR: SBB+5Ik55u2tfs1Ugkdte7qJezIKjs4qb/OodgryoTPfom0asPNaq+qr4nESwmJSNPr624sl7V
 zyVa1NDV/7xQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="181216117"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="181216117"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 03:03:41 -0700
IronPort-SDR: DhOPIM/ZlkzZVDt5F+OwtTcPQAL3DsmsgokwmTihC+HXQEjgwFW5WOM0lHUWTlam2fP9aUMnP/
 udtSrSKc5owg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="474333312"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2021 03:03:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 028FFBA; Wed, 19 May 2021 13:04:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 1/1] usb: typec: tcpm: Use LE to CPU conversion when accessing msg->header
Date:   Wed, 19 May 2021 13:03:58 +0300
Message-Id: <20210519100358.64018-1-andriy.shevchenko@linux.intel.com>
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
v2: fixed subject prefix
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

