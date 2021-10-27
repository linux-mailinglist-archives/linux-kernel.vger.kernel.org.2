Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236DE43D239
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbhJ0UMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:12:52 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10131 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243839AbhJ0UMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635365418; x=1666901418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=v1X2j5whadQ5qsqNX1PcC/XgYJy3oUyc4E5mS3fnRHY=;
  b=ciWrRGsD2Gz4Y9SnOVYxEwDg6ufU9G3k069406xbbWrz3SZ2Xio3SEro
   gM9IjE2Q0r7YhtqNqMxWEQg9jt57ivytU8CsC5vpbvZbQkNjqTgxDfxXh
   /tQhm8qPTW5wSf/ved/qkYb6IGdnFvdN8cQhGK6PqSJYbejQsZi8t3iCp
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Oct 2021 13:10:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 13:10:18 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 27 Oct 2021 13:10:17 -0700
Received: from wcheng-linux1.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 27 Oct 2021 13:10:17 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <jackp@codeaurora.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 2/2] usb: gadget: f_mass_storage: Disable eps during disconnect
Date:   Wed, 27 Oct 2021 13:10:07 -0700
Message-ID: <1635365407-31337-3-git-send-email-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635365407-31337-1-git-send-email-quic_wcheng@quicinc.com>
References: <1635365407-31337-1-git-send-email-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When receiving a disconnect event from the UDC, the mass storage
function driver currently runs the handle_exception() routine
asynchronously.  For UDCs that support runtime PM, there is a
possibility the UDC is already suspended by the time the
do_set_interface() is executed.  This can lead to HW register access
while the UDC is already suspended.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/gadget/function/f_mass_storage.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 3cabf76..7524396 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2342,6 +2342,16 @@ static void fsg_disable(struct usb_function *f)
 {
 	struct fsg_dev *fsg = fsg_from_func(f);
 
+	/* Disable the endpoints */
+	if (fsg->bulk_in_enabled) {
+		usb_ep_disable(fsg->bulk_in);
+		fsg->bulk_in_enabled = 0;
+	}
+	if (fsg->bulk_out_enabled) {
+		usb_ep_disable(fsg->bulk_out);
+		fsg->bulk_out_enabled = 0;
+	}
+
 	__raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE, NULL);
 }
 
