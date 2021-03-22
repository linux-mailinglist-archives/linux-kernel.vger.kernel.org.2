Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7A343935
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCVGJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:09:41 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:55634 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229829AbhCVGJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:09:21 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12M68uJw026998;
        Sun, 21 Mar 2021 23:09:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=nau1yopTQq4fpHMtg/lMwvfAaFFbLy11H3ppi/PoRPE=;
 b=Ic3hdqimvO9cB5AUrjpSU+Rw3M+xRTXdNEVBmhdGTRyGb3kY2UseqjvL/uOxfalfkCa7
 G13OFb6yXzdUS6DhPxy1iWYZ4ShRqlrd7qU4O+mQKCBnD4TXaT0V2giRsNPl9KBXCZ9g
 U+9HqUETAvwDsrh3DuBdaWLV9yzEOyNhvKwSuXHTQtRV2Neu3G8zIoduF1D9DS1gurH9
 rFtBwI8/88pe36d1YwOY+t5aKGH9e7D176zxBfIqI8BzOMO0uY5TWoSABwtjPqcuHMMp
 LNI3wUndZ66dG23r/M0ZPhBvm2MiLo29jhKPMkw9nLyHkbDfYinsSfTg2PFEdXcjCFj4 Pw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37dcmy48fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Mar 2021 23:09:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKDmmyQjidp+BY42H5fi3h1PrkmlGwB+9pSuwcKLD/iosDRjnUrkmWRXtdKGKXsucQHIhLtoDBad+gnLC5aJYTZfxS58/2C1egxjmKyU+7FPFkEeV8oO8qskYXbMmVViqmE6iJtv3TQbb20BqoxKigNm0acqQK/8FasPioYeqvt+gJ4Wya21u6HLCB7bSA/qXhkm0XYpz68svTng0hmbc2JX1AdgUXzet64dF4KqnqaehQJ2lZQS8F6nnd+TnmA5GJZp/SIbsvi0wY97W0Vd6oEYVQ5fSCXTgPGOzbqA3l8sRszTAehWo/h/FPWfOUULeJUGLuo36Uj0vcLdCJ3gsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nau1yopTQq4fpHMtg/lMwvfAaFFbLy11H3ppi/PoRPE=;
 b=eLJWQYPIevTqq+L+71pBPysNR4wOknUuh2c3MKS6BZuLjK82fKQPgDjYX+9aAfPRbG8FvGDX7TGfWuYMjyBPC8J6N0sQcbNodnhohmVyV85Kb2Z7yZznDlLKL1F9utI7NTP+xfNwCIOJtxuuBlcNBtgBq5tHiZBQFBc+MERfSfo5n07s8H8b5BZZwhlxU+QyjvgnB4AYCYRwjXSsMfKrQ91F9busYkgKOSQTZRzcNE8CfSFhEqjAT11NOX1UA42ve7WKuA+bp5vyPKtBjxihegr1mwOgj0/cfJ0qOt/557Re5H/V7CiBN2dH+aTLW5iqaNjngw7rQgYSiLlHWaWWWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nau1yopTQq4fpHMtg/lMwvfAaFFbLy11H3ppi/PoRPE=;
 b=hOZBYebWM0+m49NcUKLSheITTQrwkD67+YWI3bUQsjbCka91TxplYzyQFi6wJLPbJjxPQyCLEq+h+1P06ByuX6x19Loto5HEPwQbe+W9JBwQ6Vl2BIRkYi88mr9Bv8qI9Hj874s+VIr1YMsY9n8Gr7AcUSqwr7s2hYmDGmevl+U=
Received: from BN9PR03CA0661.namprd03.prod.outlook.com (2603:10b6:408:10e::6)
 by SN4PR0701MB3741.namprd07.prod.outlook.com (2603:10b6:803:46::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 06:09:15 +0000
Received: from BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::94) by BN9PR03CA0661.outlook.office365.com
 (2603:10b6:408:10e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 06:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT019.mail.protection.outlook.com (10.13.183.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.10 via Frontend Transport; Mon, 22 Mar 2021 06:09:14 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 12M69DVk022807
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 02:09:14 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Mar 2021 07:09:13 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 22 Mar 2021 07:09:12 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 12M69CTS011659;
        Mon, 22 Mar 2021 07:09:12 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 12M69CKb011653;
        Mon, 22 Mar 2021 07:09:12 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: Fixes issue with Configure Endpoint command
Date:   Mon, 22 Mar 2021 07:09:02 +0100
Message-ID: <20210322060902.11197-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 259dcdc4-f4db-446f-ff91-08d8ecf90503
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3741:
X-Microsoft-Antispam-PRVS: <SN4PR0701MB37410962F81B2B3CBD9DF7FEDD659@SN4PR0701MB3741.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: we07aP2mIog4gqsQXcLBpNUp7zM8ti0jLfhpEHAh18ApDYnIpXzJN6oveXS+LzYbgE9zuFQ040xI/2ZSNzDYUDmqcN2q2fqzL/Y8Ns5dqOQkLNjySazCXA62IqUOREicBsYwy4mKQeOFHeiEtzGYi2NV2v9tp4DTHPGhPuit+QpTMCNsj8JSyU4F5OEY1LBeL/yYaXkersaNB+ZyJsy8xXgwfsGlBxB2mzZilCf9qTfI5yO9tkJrBBt6J7fdbsLMcFgLgX9tnCJt6cTFUp1lypBVr33NdaDBtHtBAO75/QjVxeDruxSoD4rCq9ueDvKFvN0egIB0q0xdJuqYV4kfwuUYfjrG6e62ecQSxMj/qMPz6v46D407OaySoEeMRRoTBz5k0kvOfCHI/eay/ZyvZjC85ujxLd9RDhVNUpkURrK80ZY55Ke7ooewfXE3vWSYs1heOIPzRniJtndPO2bN3i42hI2bhTuL4KGBkwR/J19M3ny7xsUvvNXgHEQ/biX/Xf/S9YFl8AklYLlbCqI2T6Px5qr9jv/gXeQB9yGtrKHAPAvuxna7HRadwCXv4RQC4ooKm5gY1Gsnya5zKZADTl/IRUfbVRsEalSyevRx2yfnOnUdHZBwoiW7BTL2itkrT3YdIFzDyt0FUHQewfOdkWIWLSccQpe4UTUrvHLm7U8yBW5OAeO29Jb06Bi6LfkvwgbrT54cWRynDsI1ETRVdQ==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36092001)(46966006)(36840700001)(6666004)(186003)(426003)(1076003)(336012)(478600001)(70586007)(36906005)(5660300002)(42186006)(316002)(54906003)(26005)(8676002)(47076005)(82740400003)(107886003)(83380400001)(86362001)(70206006)(36860700001)(356005)(82310400003)(6916009)(81166007)(4326008)(2906002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 06:09:14.7845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 259dcdc4-f4db-446f-ff91-08d8ecf90503
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3741
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_02:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=467 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Patch adds flag EP_UNCONFIGURED to detect whether endpoint was
unconfigured. This flag is set in cdnsp_reset_device after Reset Device
command. Among others this command disables all non control endpoints.
Flag is used in cdnsp_gadget_ep_disable to protect controller against
invoking Configure Endpoint command on disabled endpoint. Lack of this
protection in some cases caused that Configure Endpoint command completed
with Context State Error code completion.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 18 +++++++++++++-----
 drivers/usb/cdns3/cdnsp-gadget.h | 11 ++++++-----
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index d7d4bdd57f46..de17cc4ad91a 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -727,7 +727,7 @@ int cdnsp_reset_device(struct cdnsp_device *pdev)
 	 * are in Disabled state.
 	 */
 	for (i = 1; i < CDNSP_ENDPOINTS_NUM; ++i)
-		pdev->eps[i].ep_state |= EP_STOPPED;
+		pdev->eps[i].ep_state |= EP_STOPPED | EP_UNCONFIGURED;
 
 	trace_cdnsp_handle_cmd_reset_dev(slot_ctx);
 
@@ -942,6 +942,7 @@ static int cdnsp_gadget_ep_enable(struct usb_ep *ep,
 
 	pep = to_cdnsp_ep(ep);
 	pdev = pep->pdev;
+	pep->ep_state &= ~EP_UNCONFIGURED;
 
 	if (dev_WARN_ONCE(pdev->dev, pep->ep_state & EP_ENABLED,
 			  "%s is already enabled\n", pep->name))
@@ -1023,9 +1024,13 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
 		goto finish;
 	}
 
-	cdnsp_cmd_stop_ep(pdev, pep);
 	pep->ep_state |= EP_DIS_IN_RROGRESS;
-	cdnsp_cmd_flush_ep(pdev, pep);
+
+	/* Endpoint was unconfigured by Reset Device command. */
+	if (!(pep->ep_state & EP_UNCONFIGURED)) {
+		cdnsp_cmd_stop_ep(pdev, pep);
+		cdnsp_cmd_flush_ep(pdev, pep);
+	}
 
 	/* Remove all queued USB requests. */
 	while (!list_empty(&pep->pending_list)) {
@@ -1036,6 +1041,7 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
 	cdnsp_invalidate_ep_events(pdev, pep);
 
 	pep->ep_state &= ~EP_DIS_IN_RROGRESS;
+
 	drop_flag = cdnsp_get_endpoint_flag(pep->endpoint.desc);
 	ctrl_ctx = cdnsp_get_input_control_ctx(&pdev->in_ctx);
 	ctrl_ctx->drop_flags = cpu_to_le32(drop_flag);
@@ -1043,10 +1049,12 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
 
 	cdnsp_endpoint_zero(pdev, pep);
 
-	ret = cdnsp_update_eps_configuration(pdev, pep);
+	if (!(pep->ep_state & EP_UNCONFIGURED))
+		ret = cdnsp_update_eps_configuration(pdev, pep);
+
 	cdnsp_free_endpoint_rings(pdev, pep);
 
-	pep->ep_state &= ~EP_ENABLED;
+	pep->ep_state &= ~(EP_ENABLED | EP_UNCONFIGURED);
 	pep->ep_state |= EP_STOPPED;
 
 finish:
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
index 6bbb26548c04..e628bd539e23 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -830,11 +830,12 @@ struct cdnsp_ep {
 	unsigned int ep_state;
 #define EP_ENABLED		BIT(0)
 #define EP_DIS_IN_RROGRESS	BIT(1)
-#define EP_HALTED		BIT(2)
-#define EP_STOPPED		BIT(3)
-#define EP_WEDGE		BIT(4)
-#define EP0_HALTED_STATUS	BIT(5)
-#define EP_HAS_STREAMS		BIT(6)
+#define EP_UNCONFIGURED		BIT(2)
+#define EP_HALTED		BIT(3)
+#define EP_STOPPED		BIT(4)
+#define EP_WEDGE		BIT(5)
+#define EP0_HALTED_STATUS	BIT(6)
+#define EP_HAS_STREAMS		BIT(7)
 
 	bool skip;
 };
-- 
2.25.1

