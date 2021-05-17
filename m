Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEBF383569
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244230AbhEQPTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:19:43 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37950 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242746AbhEQPIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:08:05 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HF3Gbm030842;
        Mon, 17 May 2021 08:06:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=0MQW9ut7aC3nIhY34XTN8nr6QFm/WseEK7eL6IFTmik=;
 b=H4AcqBN5Bzkevi0p8plX0U5L71nKpF7EuEvYfEuTUOwfp32dFDgj3rgMoVZeqzHy0Lo3
 AYlibn+ivucetx466Fc3vJfHTtsjm6xPbvWKsjIS2I87GIpUZ60IaQE7lLTDt3fS9gXS
 8tbdSj951XWyf8WIvw+dGtvljUd+ZKA+6j4coYc6VHtwN5nJqZ7OThMtjiu9a2pN9l2S
 l3OAbaLa5YNGI/PHgCTLL2+tXElVEbocmtmZDw1PaKp5sB1Eq8/rJytmcWOO3HEDhtGx
 fCHT0xZsqaLAeNlrDP9Dzdey3i5Gq9kJk9+x+t2loaU81cxG0C4Ofir3GwfOl250Wxye ig== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 38kp248v02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 08:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZxn0l6FuZy0zhQHUTaZDV7uJOGNnsrMxgwmj1xJQQCsWgvU0t3zChisUMBMaQgPi+/FPzTdxPFV4V8NuTJ6EeuxUiOt+Rlha4AdlvcUoB5fW/OxpXvNw6WFrmZfLcaMMgy0AYh+GOJP4j0OpmyjJ8IVeg7aGRdtvLS2KHIPA5909xM8BK5ujVyxx0PVEmNQ+lk1Pb1Qf5+hWmLgrPsVA4HvGFwBPqN/Mm2VFjhxiJcLOMkB4dHTU9KLAqWMlnQD6xYaqzPKRGBmoe/PfHjm5wPXcTDkvcWow1pvTxTkf/6kGor13m6mB+I4yWBiT0wC4aZQVeQpOWrat/EElxf50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MQW9ut7aC3nIhY34XTN8nr6QFm/WseEK7eL6IFTmik=;
 b=T6KqnwLGl3FpYr8+6FmuKj9cHI0uKlGZJM+w9KyYwTcYsljJKz6qbO3PDdN7rb64VTTLRFXj4uyckQNhgycttzgZ2pTIwcYBoR+CMkfOHbbhGpFxURelU6RPJqUVNhEPaY02tr+z8Tzpeb12tqx2FFrTNXT/kvApVCfRQhL6bggJaulz2iqy3aFrPZMzjB8OV41dVNZudOMUOCkmXCETmkz0rHBiS9335BxA+lNqSNoMZJjSAs9aa7QQcHzKU/29eGzxngiHG3vdKd6JaL/V7fJOPEVRjs9qsOZvWcu5uNci1SeQfv3xmchfPjKobboWhRUXmAjSJBzagQs7XuUqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MQW9ut7aC3nIhY34XTN8nr6QFm/WseEK7eL6IFTmik=;
 b=dZEA57wOPLsWx9rr2bX6ohTpvlZbY+0pbHLwB6iMWgCtHaR90GOZ7QxYjiMnAa146p2Je4AmFhZAUgAXTgntVUcbBbJE7Y3TY4rwF/Ui+McwIcTg0Ay+Xpc6KHCuO7SfsdokkzEdxHA5Ol0PxcaMQDbsfqqIgmTB/jPGorgPAcw=
Received: from BN6PR12CA0046.namprd12.prod.outlook.com (2603:10b6:405:70::32)
 by MWHPR07MB3584.namprd07.prod.outlook.com (2603:10b6:301:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 15:06:36 +0000
Received: from BN8NAM12FT037.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::8) by BN6PR12CA0046.outlook.office365.com
 (2603:10b6:405:70::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 15:06:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT037.mail.protection.outlook.com (10.13.182.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.11 via Frontend Transport; Mon, 17 May 2021 15:06:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 14HF6Xdg009206
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 08:06:34 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 May 2021 17:06:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 17 May 2021 17:06:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 14HF6Whd013255;
        Mon, 17 May 2021 17:06:32 +0200
Received: (from sparmar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 14HF6WUn013254;
        Mon, 17 May 2021 17:06:32 +0200
From:   Sanket Parmar <sparmar@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <pawell@cadence.com>, <a-govindraju@ti.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, Sanket Parmar <sparmar@cadence.com>
Subject: [PATCH] usb: cdns3: Enable TDL_CHK only for OUT ep
Date:   Mon, 17 May 2021 17:05:12 +0200
Message-ID: <1621263912-13175-1-git-send-email-sparmar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c057d0c-a856-4aaa-80c4-08d919455d6e
X-MS-TrafficTypeDiagnostic: MWHPR07MB3584:
X-Microsoft-Antispam-PRVS: <MWHPR07MB35847EBD896987664A63A0FBB02D9@MWHPR07MB3584.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeQi6jbuxJ9ab6V25wPz34rs/nz3HOleuPEsZUr8X8wv5AOpPFDuXD1QCjOmgtajzvSsr7WRFaPluu9TeC1+JlR9vOusBV7ZtQ/8jB0tN0f50KuQdnRFXUIJ68kT63uOsE+kGRrypv5ZDOyaCL8115c4750TovQGlFoyIWYhQVk5TsvvMItlsQ6N87RxiPJFPbjaKy3xSOynaa/RG7T54aaoWoS/FjZKnfux7A9QWcmmg+jDiLLH+EAVPRs5vgVHiELzljQE50K/XBrfYwEoYoqLnIfegA+gU2W0ABpKmVvjkDnSkjDCpZXfmp7a7DNhAfLu2ESqSkbDjbG++0SMN+powDu8tUX+vwea6C1jExKZCB6jpdaaWQ6XW3bLRL8SBnkIMGGPZZzD/YtbCk6mMOVrCMOg9lukAL2C15yOa1178jaKVIy2WuE2Qfgf0oUf03TWEb47cu+5yKil0Wv680BmW9YlQSHCi03Wts76rOwGdGxeZ45G57zJE67na5Hy2nWPfxfVgTIyR+wEBei6+TufwZ1N7Kw4l9scfUr7OK1GvLRabiCSNq/4qEyI0T0PP2+UHy4gCtn80Z672bDQy4MIftbuFibDrcPGeXFZYWXYzYylJruEnU0SOX9aAU3n0wjnWH/Anh5Y/KEG6o2hgg8yiFz+tjLaK/7hzUSr4fQNOfLA2lBU4cefojANCyyn
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(39850400004)(136003)(346002)(396003)(36092001)(36840700001)(46966006)(36756003)(26005)(82310400003)(186003)(47076005)(6916009)(42186006)(82740400003)(7636003)(5660300002)(83380400001)(478600001)(6666004)(8676002)(70586007)(70206006)(107886003)(36906005)(316002)(4326008)(2906002)(2616005)(426003)(336012)(36860700001)(54906003)(8936002)(86362001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 15:06:35.9127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c057d0c-a856-4aaa-80c4-08d919455d6e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT037.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3584
X-Proofpoint-GUID: RsoMi486DUR4yMbVG-IfBtNNZrBFzJfK
X-Proofpoint-ORIG-GUID: RsoMi486DUR4yMbVG-IfBtNNZrBFzJfK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_06:2021-05-17,2021-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1011 mlxlogscore=938 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105170107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZLP gets stuck if TDL_CHK bit is set and TDL_FROM_TRB is used
as TDL source for IN endpoints. To fix it, TDL_CHK is only
enabled for OUT endpoints.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Reported-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Sanket Parmar <sparmar@cadence.com>
---
 drivers/usb/cdns3/cdns3-gadget.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 105855a..f3c0276 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2007,7 +2007,7 @@ static void cdns3_configure_dmult(struct cdns3_device *priv_dev,
 		else
 			mask = BIT(priv_ep->num);
 
-		if (priv_ep->type != USB_ENDPOINT_XFER_ISOC) {
+		if (priv_ep->type != USB_ENDPOINT_XFER_ISOC  && !priv_ep->dir) {
 			cdns3_set_register_bit(&regs->tdl_from_trb, mask);
 			cdns3_set_register_bit(&regs->tdl_beh, mask);
 			cdns3_set_register_bit(&regs->tdl_beh2, mask);
@@ -2046,15 +2046,13 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	case USB_ENDPOINT_XFER_INT:
 		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_INT);
 
-		if ((priv_dev->dev_ver == DEV_VER_V2 && !priv_ep->dir) ||
-		    priv_dev->dev_ver > DEV_VER_V2)
+		if (priv_dev->dev_ver >= DEV_VER_V2 && !priv_ep->dir)
 			ep_cfg |= EP_CFG_TDL_CHK;
 		break;
 	case USB_ENDPOINT_XFER_BULK:
 		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_BULK);
 
-		if ((priv_dev->dev_ver == DEV_VER_V2  && !priv_ep->dir) ||
-		    priv_dev->dev_ver > DEV_VER_V2)
+		if (priv_dev->dev_ver >= DEV_VER_V2 && !priv_ep->dir)
 			ep_cfg |= EP_CFG_TDL_CHK;
 		break;
 	default:
-- 
1.7.1

