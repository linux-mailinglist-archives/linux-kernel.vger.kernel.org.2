Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE3E43A96A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 02:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhJZAtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 20:49:46 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:14972 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbhJZAtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 20:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635209240; x=1666745240;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5znon4iCho05Hu+qdNP4H8pF1rkGlP/vfvPo8Af0PG8=;
  b=vlFlKkEn7rxqiS+mBZ+aerxYFyWS+AfpHd9n3CxXmpxJU9NbXyDwW9W+
   RtaBggBK7omZuhYZFny3ZIYXpFST4+eLXjoqoltoN/jkfu1IffTfL+oJf
   JiAuez0EI5rJTMYKd6pWy5CgKmYZoHjNSjcm86GwVb/HkJeD6h0anjkWj
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 17:47:19 -0700
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 17:47:19 -0700
Received: from wcheng-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 17:47:19 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH] usb: gadget: f_mass_storage: Disable eps during disconnect
Date:   Mon, 25 Oct 2021 17:44:56 -0700
Message-ID: <20211026004456.23054-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wesley Cheng <wcheng@codeaurora.org>

When receiving a disconnect event from the UDC, the mass storage
function driver currently runs the handle_exception() routine
asynchronously.  For UDCs that support runtime PM, there is a
possibility the UDC is already suspended by the time the
do_set_interface() is executed.  This can lead to HW register access
while the UDC is already suspended.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
 drivers/usb/gadget/function/f_mass_storage.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 3cabf7692ee1..752439690fda 100644
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
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

