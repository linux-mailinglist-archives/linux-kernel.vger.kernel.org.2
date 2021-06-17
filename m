Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9FA3AB0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhFQKBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:01:20 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47788 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhFQKBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:01:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623923950; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=FDIuG8YEwdWYR3GNAlZ3/WT/tm9DdB90hp34bgrxsuI=; b=Nr4bNxLjR+G6xr30ebVplWC7gFMzDNbsOgSVeRgTyTOhWO/A0Ds7hYUjBKBWyGYJMyOszome
 64sn/X0p25LvbS5DnXq0argyf69zvMiYq8WGho00b26jFN6P4rzcyqT4K1DVXzrQf2TL/ob0
 zN31Gi7iL363U4ojaxGlYn5VNpQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60cb1cc2ed59bf69ccec9a06 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Jun 2021 09:58:26
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D1C5C43149; Thu, 17 Jun 2021 09:58:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C725FC433F1;
        Thu, 17 Jun 2021 09:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C725FC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        frowand.list@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jackp@codeaurora.org, fntoth@gmail.com,
        heikki.krogerus@linux.intel.com, andy.shevchenko@gmail.com,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v10 1/6] usb: gadget: udc: core: Introduce check_config to verify USB configuration
Date:   Thu, 17 Jun 2021 02:58:14 -0700
Message-Id: <1623923899-16759-2-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623923899-16759-1-git-send-email-wcheng@codeaurora.org>
References: <1623923899-16759-1-git-send-email-wcheng@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some UDCs may have constraints on how many high bandwidth endpoints it can
support in a certain configuration.  This API allows for the composite
driver to pass down the total number of endpoints to the UDC so it can verify
it has the required resources to support the configuration.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
 drivers/usb/gadget/udc/core.c | 25 +++++++++++++++++++++++++
 include/linux/usb/gadget.h    |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index b7f0b1e..e33ae2d 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1003,6 +1003,31 @@ int usb_gadget_ep_match_desc(struct usb_gadget *gadget,
 }
 EXPORT_SYMBOL_GPL(usb_gadget_ep_match_desc);
 
+/**
+ * usb_gadget_check_config - checks if the UDC can support the number of eps
+ * @gadget: controller to check the USB configuration
+ * @ep_map: bitmap of endpoints being requested by a USB configuration
+ *
+ * Ensure that a UDC is able to support the number of endpoints within a USB
+ * configuration, and that there are no resource limitations to support all
+ * requested eps.
+ *
+ * Returns zero on success, else a negative errno.
+ */
+int usb_gadget_check_config(struct usb_gadget *gadget, unsigned long ep_map)
+{
+	int ret = 0;
+
+	if (!gadget->ops->check_config)
+		goto out;
+
+	ret = gadget->ops->check_config(gadget, ep_map);
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_check_config);
+
 /* ------------------------------------------------------------------------- */
 
 static void usb_gadget_state_work(struct work_struct *work)
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 75c7538..fcde3b3 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -329,6 +329,7 @@ struct usb_gadget_ops {
 	struct usb_ep *(*match_ep)(struct usb_gadget *,
 			struct usb_endpoint_descriptor *,
 			struct usb_ss_ep_comp_descriptor *);
+	int	(*check_config)(struct usb_gadget *gadget, unsigned long ep_map);
 };
 
 /**
@@ -608,6 +609,7 @@ int usb_gadget_connect(struct usb_gadget *gadget);
 int usb_gadget_disconnect(struct usb_gadget *gadget);
 int usb_gadget_deactivate(struct usb_gadget *gadget);
 int usb_gadget_activate(struct usb_gadget *gadget);
+int usb_gadget_check_config(struct usb_gadget *gadget, unsigned long ep_map);
 #else
 static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
 { return 0; }
@@ -631,6 +633,9 @@ static inline int usb_gadget_deactivate(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_activate(struct usb_gadget *gadget)
 { return 0; }
+static inline int usb_gadget_check_config(struct usb_gadget *gadget,
+					  unsigned long ep_map)
+{ return 0; }
 #endif /* CONFIG_USB_GADGET */
 
 /*-------------------------------------------------------------------------*/
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

