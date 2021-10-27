Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D620943D236
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbhJ0UMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:12:47 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:54288 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243835AbhJ0UMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635365418; x=1666901418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ZcejEIJ9EOZAgE5eHfWgNEFBqqGWcfS5JpCwc2ATJTM=;
  b=QgRSumWRJnPFjkNDNao5YJQr4zUF4rIf5TWfFJlDk9FiRw2TVw72t3rh
   NogT3tz+Nyc2XE1vZGkwG8pPxvOsazx6TOWiuhU86BgPjW2JZYe7loRkt
   rFAvI0K3AE/7lt3yZ06/Fa0jqCTz+C8q3ZthO+AvoOzUoIcxe0YaqcGgX
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Oct 2021 13:10:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 13:10:17 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 27 Oct 2021 13:10:17 -0700
Received: from wcheng-linux1.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 27 Oct 2021 13:10:16 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <jackp@codeaurora.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 1/2] usb: gadget: udc: core: Revise comments for USB ep enable/disable
Date:   Wed, 27 Oct 2021 13:10:06 -0700
Message-ID: <1635365407-31337-2-git-send-email-quic_wcheng@quicinc.com>
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

The usb_ep_disable() and usb_ep_enable() routines are being widely
used in atomic/interrupt context by function drivers.  Hence, the
statement about it being able to only run in process context may
not be true.  Add an explicit comment mentioning that it can be used
in atomic context.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/gadget/udc/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d626511..568534a 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -91,7 +91,7 @@ EXPORT_SYMBOL_GPL(usb_ep_set_maxpacket_limit);
  * configurable, with more generic names like "ep-a".  (remember that for
  * USB, "in" means "towards the USB host".)
  *
- * This routine must be called in process context.
+ * This routine may be called in an atomic (interrupt) context.
  *
  * returns zero, or a negative error code.
  */
@@ -136,7 +136,7 @@ EXPORT_SYMBOL_GPL(usb_ep_enable);
  * gadget drivers must call usb_ep_enable() again before queueing
  * requests to the endpoint.
  *
- * This routine must be called in process context.
+ * This routine may be called in an atomic (interrupt) context.
  *
  * returns zero, or a negative error code.
  */
