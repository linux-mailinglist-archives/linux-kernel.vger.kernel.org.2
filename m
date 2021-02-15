Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A295831B6BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 10:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhBOJvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 04:51:10 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:44084 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhBOJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 04:50:38 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210215094955epoutp014509ee7965ef6bcd9c562d7024771c1a~j4uwccE5c1543415434epoutp01u
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:49:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210215094955epoutp014509ee7965ef6bcd9c562d7024771c1a~j4uwccE5c1543415434epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613382595;
        bh=/1AGqWOmRthD00yEu2KIzxHteZZXjPiXJ2yDr24vXlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGO+6TY1B9VRbaS52Z2vggC8YY5QGSwJi26t0T1aWjZYg0tvgGbnDsx401X5kzcgj
         dvB1Jox+Sze/jnNGT8YA9sILkHuhMeGnieFRyZ+7s1MDtRKVtE006v5DPASQdpZTTk
         eQr/GO8vBXbb1DP2zHgAV3Dn+PzH+6rgkiebIjBk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210215094954epcas1p4c17d7859531c2a5055a50a7c7c341710~j4uwJJY9N3153431534epcas1p4g;
        Mon, 15 Feb 2021 09:49:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DfK8H5vV4z4x9Q9; Mon, 15 Feb
        2021 09:49:51 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.67.09577.FB34A206; Mon, 15 Feb 2021 18:49:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210215094951epcas1p3a7532c112193cbc9c2f3aa37a30ece33~j4us4CBEx0184401844epcas1p3o;
        Mon, 15 Feb 2021 09:49:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210215094951epsmtrp2eaa536a603ce823b3c82a04becb89e25~j4us3WWJX2912229122epsmtrp2P;
        Mon, 15 Feb 2021 09:49:51 +0000 (GMT)
X-AuditID: b6c32a39-bfdff70000002569-b9-602a43bf808c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.2E.13470.FB34A206; Mon, 15 Feb 2021 18:49:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210215094951epsmtip264c395611c5666d929110a11d67b49d4~j4uso1QTG1775517755epsmtip2J;
        Mon, 15 Feb 2021 09:49:51 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     gregkh@linuxfoundation.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org,
        Nikita Travkin <nikitos.tr@gmail.com>
Subject: [PATCH 3/3] extcon: sm5502: Detect OTG when USB_ID is connected to
 ground
Date:   Mon, 15 Feb 2021 19:06:10 +0900
Message-Id: <20210215100610.19911-4-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210215100610.19911-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7bCmvu5+Z60Eg6tNuhYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzWLLtn9MDmweO2fdZffYtKqTzWP/3DXsHn1bVjF6fN4kF8AalW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE7Y/au
        04wF54UqDs+oa2CczN/FyMkhIWAicaetnbmLkYtDSGAHo8T2roPsEM4nRokLP6ZAZb4xSqxf
        /oMRpmXR0ndMEIm9jBLHdn2Hcr4wSjw4f4gVpIpNQEti/4sbbCC2iICcxJPbf8BGMQv0MUrc
        utPJDpIQFgiR+HyvE2wsi4CqxMSLK8DivAJWEhtuLmOGWCcvsXrDATCbU8BaYue8VkaQQRIC
        h9glft74yQJR5CLx9vRzVghbWOLV8S3sELaUxOd3e9kg7GqJlSePsEE0dzBKbNl/AarBWGL/
        0slAP3AAnacpsX6XPkRYUWLn77lgxzEL8Em8+9rDClIiIcAr0dEmBFGiLHH5wV0mCFtSYnF7
        J9QqD4m7O5ewQEIF5OFnn1gmMMrNQtiwgJFxFaNYakFxbnpqsWGBKXKcbWIEpzEtyx2M099+
        0DvEyMTBeIhRgoNZSYT3qoRGghBvSmJlVWpRfnxRaU5q8SFGU2DoTWSWEk3OBybSvJJ4Q1Mj
        Y2NjCxNDM1NDQyVx3iSDB/FCAumJJanZqakFqUUwfUwcnFINTOUH+9aed/s9pa5TcfpFp9DW
        tshHQXvss9cnsxU83tL6tXOty4OeqKOJnFZ3aqYyxi/ebfTLO7W54UxE9S2NLPdXN7z7Pxxd
        vcvKJ9xLTmzyj20yt2ZtvHzl5tNNfmbSHx/tzVm4d8rbF01nYxk1nqSenPCayTipWnCztdEV
        5zK5yDT2ynkb2wWfn3/w9Oj5h7mP/ipWMN9dZG4082uP7pU9NfP/L2eMey1blxjnq/2b/1MG
        h+xLm8l2jcHvY3Yed7nbxrHO3swrPzXqcUzaRGmPqWp5E5YrBc/dKdVeEB5w9fvZyYWP4+IY
        N6j99bc48YD35uK1azxd2jt4bY7opt/Ypqe+rdP4XOzOTXPV+5RYijMSDbWYi4oTAdyZWm3s
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSvO5+Z60EgyutAhYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzWLLtn9MDmweO2fdZffYtKqTzWP/3DXsHn1bVjF6fN4kF8AaxWWT
        kpqTWZZapG+XwJUxe9dpxoLzQhWHZ9Q1ME7m72Lk5JAQMJFYtPQdUxcjF4eQwG5GieUPt7FA
        JCQlpl08ytzFyAFkC0scPlwMUfOJUeJ6zy1mkBo2AS2J/S9usIHYIgJyEk9u/2EGKWIWmMIo
        sa1/L1hCWCBI4vGKHewgNouAqsTEiyvAbF4BK4kNN5cxQyyTl1i94QCYzSlgLbFzXisjiC0E
        VLNs+nKmCYx8CxgZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBIealuYOxu2rPugd
        YmTiYDzEKMHBrCTCe1VCI0GINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakF
        qUUwWSYOTqkGprKys9GdEl/r7E3EbO4a/jnIoHbhu6ni9iwfJ+Mil7C0fRd+VjJ3r0tr0Ku7
        6CQoZ/vo+N2axJDakFuL/5pfkb24aJrvEWMBpyKdGHfJAzb2F+eqRj0tSDopWDjztBHjMglG
        f86fdxsfcX0t3PtRLbr3+5ZX4WsXpEhpbaio/vGvSbzj+9HfOlwPtvrcUry+ZfbMnbWdxdzq
        q7frPhPYsmXx9PjTYQdS/vgYtP1q8Xif8d7poEVq6+lTzY9/NB44fjq7tEzm7J1mc1/2xisr
        L+12O2Q4K+Dl8oVLvB7ub9ULjZnR3lv7sqHh7cUY8d95P3dfuPz1f/u3DW5ti/V0Z9/l0FT5
        vfaU/aqgd/WB05VYijMSDbWYi4oTAbRNeKKkAgAA
X-CMS-MailID: 20210215094951epcas1p3a7532c112193cbc9c2f3aa37a30ece33
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210215094951epcas1p3a7532c112193cbc9c2f3aa37a30ece33
References: <20210215100610.19911-1-cw00.choi@samsung.com>
        <CGME20210215094951epcas1p3a7532c112193cbc9c2f3aa37a30ece33@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Travkin <nikitos.tr@gmail.com>

In it's curent state this driver ignores OTG adapters with ID pin
connected to ground. This commit adds a check to set extcon into
host mode when such OTG adapter is connected.

Signed-off-by: Nikita Travkin <nikitos.tr@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-sm5502.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 106d4da647bd..db41d1c58efd 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -144,6 +144,7 @@ enum sm5502_muic_acc_type {
 	SM5502_MUIC_ADC_AUDIO_TYPE1_FULL_REMOTE = 0x3e,	/* |      001|11110| */
 	SM5502_MUIC_ADC_AUDIO_TYPE1_SEND_END = 0x5e,	/* |      010|11110| */
 							/* |Dev Type1|--ADC| */
+	SM5502_MUIC_ADC_GROUND_USB_OTG = 0x80,		/* |      100|00000| */
 	SM5502_MUIC_ADC_OPEN_USB = 0x5f,		/* |      010|11111| */
 	SM5502_MUIC_ADC_OPEN_TA = 0xdf,			/* |      110|11111| */
 	SM5502_MUIC_ADC_OPEN_USB_OTG = 0xff,		/* |      111|11111| */
@@ -291,11 +292,27 @@ static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
 	 * connected with to MUIC device.
 	 */
 	cable_type = adc & SM5502_REG_ADC_MASK;
-	if (cable_type == SM5502_MUIC_ADC_GROUND)
-		return SM5502_MUIC_ADC_GROUND;
 
 	switch (cable_type) {
 	case SM5502_MUIC_ADC_GROUND:
+		ret = regmap_read(info->regmap, SM5502_REG_DEV_TYPE1,
+				  &dev_type1);
+		if (ret) {
+			dev_err(info->dev, "failed to read DEV_TYPE1 reg\n");
+			return ret;
+		}
+
+		switch (dev_type1) {
+		case SM5502_REG_DEV_TYPE1_USB_OTG_MASK:
+			cable_type = SM5502_MUIC_ADC_GROUND_USB_OTG;
+			break;
+		default:
+			dev_dbg(info->dev,
+				"cannot identify the cable type: adc(0x%x), dev_type1(0x%x)\n",
+				adc, dev_type1);
+			return -EINVAL;
+		}
+		break;
 	case SM5502_MUIC_ADC_SEND_END_BUTTON:
 	case SM5502_MUIC_ADC_REMOTE_S1_BUTTON:
 	case SM5502_MUIC_ADC_REMOTE_S2_BUTTON:
@@ -396,6 +413,7 @@ static int sm5502_muic_cable_handler(struct sm5502_muic_info *info,
 		con_sw	= DM_DP_SWITCH_OPEN;
 		vbus_sw	= VBUSIN_SWITCH_VBUSOUT;
 		break;
+	case SM5502_MUIC_ADC_GROUND_USB_OTG:
 	case SM5502_MUIC_ADC_OPEN_USB_OTG:
 		id	= EXTCON_USB_HOST;
 		con_sw	= DM_DP_SWITCH_USB;
-- 
2.17.1

