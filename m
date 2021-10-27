Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8926943C047
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbhJ0CxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:53:03 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33520 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238653AbhJ0CxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635303036; x=1666839036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=iFW11J24xI33bT3ahEg5qE3QCrU6FNkpE17Pl0nOnuU=;
  b=Cb7eCKBWSVjRQ/HveKVrT1wXW02dQBwuQWyEonZgEho9G0zUnBcXTRu8
   bh87jcdbr2FXJ5cBo2i3UAIbppm1/bZAnMU7srjnTLpRotGCGlNhmGt6W
   igAyehuNSa7Jv9swCUT49djpo9PppS6CrTkJOzV9kFcWJkZhWn6prnOTC
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 19:50:36 -0700
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 19:50:35 -0700
Received: from wcheng-linux1.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 19:50:34 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <jackp@codeaurora.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v2 1/2] usb: gadget: udc: core: Revise comments for usb_ep_disable()
Date:   Tue, 26 Oct 2021 19:50:24 -0700
Message-ID: <1635303025-772-2-git-send-email-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635303025-772-1-git-send-email-quic_wcheng@quicinc.com>
References: <1635303025-772-1-git-send-email-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb_ep_disable() routine is being widely used directly in the
disconnect callback path by function drivers.  Hence, the statement
about it being able to only run in process context may not be true.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/gadget/udc/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d626511..e1f90d8 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -136,8 +136,6 @@ EXPORT_SYMBOL_GPL(usb_ep_enable);
  * gadget drivers must call usb_ep_enable() again before queueing
  * requests to the endpoint.
  *
- * This routine must be called in process context.
- *
  * returns zero, or a negative error code.
  */
 int usb_ep_disable(struct usb_ep *ep)
