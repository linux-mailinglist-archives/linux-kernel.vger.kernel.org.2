Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B226A42C1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhJMN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:59:48 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:39244 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235496AbhJMN7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:59:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DCcwex013621;
        Wed, 13 Oct 2021 15:57:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=c6EaOVGfb8Sa8HSlE1ms6Xot8j3nZXJs3bVkNF7A+D8=;
 b=pUqda/VnJg8+97jZZU/JDtAxf111B9t9AoWFu3I1uo49fgks6eJq3FR1tpn7AXkcqI1b
 9e9lJppo0TR/qY91UK3YFU91O1DiovWI2mqFey8mew+mJgGhwtlNYahee6oeiT1n8xtm
 +dBbQH42Id6nYrhzPZ5oApOPOdIc+0T+e4fuVZ6+iDakDfkTyS4Bon9JebethxinoK14
 mf59++9Vvt0H3azZVkw4E1O/uzToKKgPo+AFsgI09FBvhFHWMw4g6CNPlpPgIoFU6CDi
 LtjHecohh3pvSGogzXkEVavgWON9lxOEtlFiSG7WJ6WsZW50qapwkxuK0A5XWEuDsdaY Vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bnumjace8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 15:57:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7621D10002A;
        Wed, 13 Oct 2021 15:57:28 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6E50B22F7CA;
        Wed, 13 Oct 2021 15:57:28 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 13 Oct 2021 15:57:27
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v3 4/4] usb: dwc2: stm32mp15: set otg_rev
Date:   Wed, 13 Oct 2021 15:57:05 +0200
Message-ID: <1634133425-25670-5-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634133425-25670-1-git-send-email-fabrice.gasnier@foss.st.com>
References: <1634133425-25670-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32MP15 complies with the OTG 2.0. Set OTG revision accordingly. It is
useful for the of_usb_update_otg_caps() routine to check and update
otg_rev to the lower value between DT and provided params.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- set otg_rev in otg_caps structure directly
---
 drivers/usb/dwc2/params.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 99d3b62..d300ae3 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -176,6 +176,7 @@ static void dwc2_set_stm32mp15_fsotg_params(struct dwc2_hsotg *hsotg)
 
 	p->otg_caps.hnp_support = false;
 	p->otg_caps.srp_support = false;
+	p->otg_caps.otg_rev = 0x200;
 	p->speed = DWC2_SPEED_PARAM_FULL;
 	p->host_rx_fifo_size = 128;
 	p->host_nperio_tx_fifo_size = 96;
@@ -197,6 +198,7 @@ static void dwc2_set_stm32mp15_hsotg_params(struct dwc2_hsotg *hsotg)
 
 	p->otg_caps.hnp_support = false;
 	p->otg_caps.srp_support = false;
+	p->otg_caps.otg_rev = 0x200;
 	p->activate_stm_id_vb_detection = !device_property_read_bool(hsotg->dev, "usb-role-switch");
 	p->host_rx_fifo_size = 440;
 	p->host_nperio_tx_fifo_size = 256;
-- 
2.7.4

