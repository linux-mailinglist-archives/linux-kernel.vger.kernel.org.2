Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DCB416502
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242824AbhIWSP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:15:29 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:46051 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242880AbhIWSPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:15:07 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id DB077580C17;
        Thu, 23 Sep 2021 14:13:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 Sep 2021 14:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=X2hrGtBsW51by
        306lHEkL3i5RELEyLjsk6fh/gem0TY=; b=nCaDFmTdIzfYuHOavoHHIlzybpfkQ
        9akh/ELBy/xaRMacz0Bu7+1VjXQeCy9l/XHr309gb+bX7fbiI+UGeVPyKb1dsQy4
        JUDmn1bpihc8IqU9eWvgvCvDTHfR/XqdBGfcWStbquM02fn6s3yCCx9X/98UN0gz
        wqzR1nvKZkcq45hlSzse+DOw3ZZthgFj3Ol71RCiV+kt3Lff97gCmFiz/rrdO6h0
        ULMP7vz5o+ApsgQrAKBTfOk36stuToq+xJsH+NIBj4C0ZMVrM4ztGjWho6dnTHHk
        Ngq5/oKJ1bKznngkj7+jU3YKH9CGAl0akQeY7Ztx6YBJP5iP9r7QkYXBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=X2hrGtBsW51by306lHEkL3i5RELEyLjsk6fh/gem0TY=; b=LMLVz0rl
        H+fcY2tiPjLaZ9gVQnLopY+arDe4+cG+kHDvIFVouS9UdNdXwKT2E+V6Q/B1poXG
        v7UwUk2ZQp6Frn2VFtpw7zfERaOMB+9sFqX3IUkfAENXXf7BoxYfa/Mi+JC8+j4q
        3R535NoElmPwKq1XHur1TU17tov47c6QiZfyGPxA+hK9Iv0oT8eiEXbNzaJEfnRV
        GmMuEU9OR12YP6U49ak1CbCgImp70wLJOlUErRvvBmCHAgJW3kps1yHTvh1rRy17
        XsXKJCOFpFu9L3IvWOsPvCxvjTdXNIE6nfLeeqqiZYblMAYLnNwM3EeX1IN4el2Z
        t0kqT0Berl1Y3g==
X-ME-Sender: <xms:z8NMYTOOeGILN9UraF8o2mG-bP9SMKArWK-9xUlBDYRNM5l5KJPaDA>
    <xme:z8NMYd95ENa_7apT5tRB7m3cjFtq_qV3Ptu8fBuRn8IhVoFL8_fgmcO75y3a_4Opk
    K60IEj9vDRMpR8lYOI>
X-ME-Received: <xmr:z8NMYSSWdqVUN_SDxI1QqEdhwFlre-HtvNtGA-t7EneuHmiV4Cj5ADaH2g51lpIvTLynU9XM5rW_-SrboS1bFld3O0UoJ8z1I6Ltxx-HBgG-T0agqx6GMNE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeiledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfef
    jeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:z8NMYXuxdeQJH8brZ5ah8S9fhngnTs4z2NFVnSyEf7y7C2yMGm3mRg>
    <xmx:z8NMYbfXOIeVb6Sy1K-CKEQ9byk8aOeQ7PIO-X4P2Zqsk9lPAXRg-A>
    <xmx:z8NMYT3fnLSqCD-_zWy4ncKQh6dOHHRVMjgQ8MaCgYl0TW5OHK-G9Q>
    <xmx:z8NMYT07zVtCQ443O876UCKVK7uIpgO1QixcQF-n_JDYEDnlRqZxhQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Sep 2021 14:13:33 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH v2 2/6] usb: typec: tipd: Split interrupt handler
Date:   Thu, 23 Sep 2021 20:13:17 +0200
Message-Id: <20210923181321.3044-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210923181321.3044-1-sven@svenpeter.dev>
References: <20210923181321.3044-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the handlers for the individual interrupts into their own functions
to prepare for adding a second interrupt handler for the Apple CD321x
chips

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
changes since v1:
  - new commit since Heikki suggested to add a separate irq handler
    for the cd321x variant

 drivers/usb/typec/tipd/core.c | 96 ++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 21b3ae25c76d..162d405baa92 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -401,13 +401,69 @@ static const struct typec_operations tps6598x_ops = {
 	.pr_set = tps6598x_pr_set,
 };
 
+static bool tps6598x_read_status(struct tps6598x *tps, u32 *status)
+{
+	int ret;
+
+	ret = tps6598x_read32(tps, TPS_REG_STATUS, status);
+	if (ret) {
+		dev_err(tps->dev, "%s: failed to read status\n", __func__);
+		return false;
+	}
+	trace_tps6598x_status(*status);
+
+	return true;
+}
+
+static bool tps6598x_read_data_status(struct tps6598x *tps)
+{
+	u32 data_status;
+	int ret;
+
+	ret = tps6598x_read32(tps, TPS_REG_DATA_STATUS, &data_status);
+	if (ret < 0) {
+		dev_err(tps->dev, "failed to read data status: %d\n", ret);
+		return false;
+	}
+	trace_tps6598x_data_status(data_status);
+
+	return true;
+}
+
+static bool tps6598x_read_power_status(struct tps6598x *tps)
+{
+	u16 pwr_status;
+	int ret;
+
+	ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
+	if (ret < 0) {
+		dev_err(tps->dev, "failed to read power status: %d\n", ret);
+		return false;
+	}
+	trace_tps6598x_power_status(pwr_status);
+
+	return true;
+}
+
+static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
+{
+	int ret;
+
+	if (status & TPS_STATUS_PLUG_PRESENT) {
+		ret = tps6598x_connect(tps, status);
+		if (ret)
+			dev_err(tps->dev, "failed to register partner\n");
+	} else {
+		tps6598x_disconnect(tps, status);
+	}
+}
+
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
 	u64 event1;
 	u64 event2;
-	u32 status, data_status;
-	u16 pwr_status;
+	u32 status;
 	int ret;
 
 	mutex_lock(&tps->lock);
@@ -420,42 +476,20 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	}
 	trace_tps6598x_irq(event1, event2);
 
-	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
-	if (ret) {
-		dev_err(tps->dev, "%s: failed to read status\n", __func__);
+	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
-	}
-	trace_tps6598x_status(status);
 
-	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE) {
-		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
-		if (ret < 0) {
-			dev_err(tps->dev, "failed to read power status: %d\n", ret);
+	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
+		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
-		}
-		trace_tps6598x_power_status(pwr_status);
-	}
 
-	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE) {
-		ret = tps6598x_read32(tps, TPS_REG_DATA_STATUS, &data_status);
-		if (ret < 0) {
-			dev_err(tps->dev, "failed to read data status: %d\n", ret);
+	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
+		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
-		}
-		trace_tps6598x_data_status(data_status);
-	}
 
 	/* Handle plug insert or removal */
-	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT) {
-		if (status & TPS_STATUS_PLUG_PRESENT) {
-			ret = tps6598x_connect(tps, status);
-			if (ret)
-				dev_err(tps->dev,
-					"failed to register partner\n");
-		} else {
-			tps6598x_disconnect(tps, status);
-		}
-	}
+	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
+		tps6598x_handle_plug_event(tps, status);
 
 err_clear_ints:
 	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
-- 
2.25.1

