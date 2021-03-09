Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EFC331E46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 06:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCIFUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 00:20:11 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:37106 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229701AbhCIFUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 00:20:10 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1295E6Bb006926;
        Mon, 8 Mar 2021 21:20:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=D2PSS1ZwpURnnl0IyYxuoCJHHE6C+J6jH3fo9oXVanc=;
 b=Ykp1woVYv+cI9gEaBrjs6PxAlbjOGgTATdI0bIwp9H5eSi6VH5c/s1gNU0sNB7jP0rvB
 rtr5fj7gh8kQbQMVhjpMJ81XXaVX+h8roCWYmzfT8Hd2DtFbaHqdToz91TqcOAefyJu5
 fev/3oZZf0IaadZm0KAmTd1uooezHnSOmvoHgTRadYM2Xv3uvIBR+l/xCRCOFMOE7MLC
 4ozVCgtK5p6sAgiS4a+AaF1VJzg47Vip7k+KONITsZLVsiQSR2fuCu3l+e+qYlfJr86W
 33AjHbOyUFfofqJ+w+SyxH03FKJew62QFFYl6HO0HtkOv4WmA9+8LpbJTy0pRGOCofAe +g== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0b-0014ca01.pphosted.com with ESMTP id 374674ynh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 21:20:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNPBeD7z4Kltd9WA66YtV9dIpgGC2U6OrQtaxQb3gIMoeBZHvbf/wl/IJducX0bUkkRSgfigQL1gQujchU/RL01x8RBgvr8Eieba+/YgLkCE1V+lFboC8uQybXNJF00srogyA0wcdihqnVlL+gOkjpmvmmbwYb2netK7b5INloU16XzCjMzfaMSIytR5Mise/A7TUIf5TEvAZcNxubLFBE/sYFoxNlAOYwLK74BZ3N5qfhXNoyWP7i5AXwwCZ7z15WufUmuq3qpKbBf+e3OMjwEfftrtlWPbQroyElEuUOdKvzUKCvjpc3LMW8EcCwj7l0FgLEY7UrDWRTFp+WRZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2PSS1ZwpURnnl0IyYxuoCJHHE6C+J6jH3fo9oXVanc=;
 b=PyjPerdhGCMIOyBnWIgRoYZrUQfMl7wgXA+/wwlhxH2BZEC+rd0t3FcZVAiWlL3DJYSwCVu8GTY+0LGf3KEBjxjz16ZeqrXt6vML17hZpSWSICCjJzz64aJZKmpliFV2Kjpr1Rl9AJCmkLJcaAjrSGGZGvNmOei/UgJ0CHFwmhYspMHf/Eo83M6u83HXM+mKcoxZTHQZTtwtknGGhKY02bbQS1V5ahtmDukp+Ozm/XiF2wILnzuJMtZrQtTqvcvhJlIZsOf3ka2+9keHHoLgD3JY80ED6iUSAofRhtTyY/M08nqwMcxjouqUois7klWF4APYfsibtEkrYn+U0oVUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2PSS1ZwpURnnl0IyYxuoCJHHE6C+J6jH3fo9oXVanc=;
 b=Wal0VdwIhVQiMN8cgKSYsFcTe76eWx/kzQJVlH3hub5IeaoQcxmCM8O+hYXTpSyctlNjs4PPt/UoqO7g64zN6y91p8yPVVaRU5kSD8WKnlYgISWcp5LpsxvfTkKttWUeNEBM9pwof0GbWADp56HFN457rYfVpbTvPY5+VdjvCdY=
Received: from DM5PR15CA0066.namprd15.prod.outlook.com (2603:10b6:3:ae::28) by
 BN8PR07MB8002.namprd07.prod.outlook.com (2603:10b6:408:aa::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Tue, 9 Mar 2021 05:20:03 +0000
Received: from DM6NAM12FT039.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::54) by DM5PR15CA0066.outlook.office365.com
 (2603:10b6:3:ae::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 9 Mar 2021 05:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT039.mail.protection.outlook.com (10.13.179.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.16 via Frontend Transport; Tue, 9 Mar 2021 05:20:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1295K08A026646
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 00:20:01 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Mar 2021 06:19:59 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 9 Mar 2021 06:19:59 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1295JxET009441;
        Tue, 9 Mar 2021 06:19:59 +0100
Received: (from sparmar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1295JwO0009434;
        Tue, 9 Mar 2021 06:19:58 +0100
From:   Sanket Parmar <sparmar@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <pawell@cadence.com>, <a-govindraju@ti.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, Sanket Parmar <sparmar@cadence.com>
Subject: [PATCH 1/2] usb: cdns3: Use dma_pool_* api to alloc trb pool
Date:   Tue, 9 Mar 2021 06:19:39 +0100
Message-ID: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d55e154-4901-41dc-362d-08d8e2bafe2f
X-MS-TrafficTypeDiagnostic: BN8PR07MB8002:
X-Microsoft-Antispam-PRVS: <BN8PR07MB800275DAF323524E74FFBBA8B0929@BN8PR07MB8002.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0N51G08uKLzsOazHvcGwsqKzATdjrxE1GX7xIYILK4FfzB+P5mvcSKvg4/+FEiGVjFsy1ZhvrgWKHE7KSgdhds3aYNaOX/VzPnjX1/rN+wgTdDX6MWb5HhIEiy2l0/igEhsfIDpEahm2UaimwSD9OG6UCAxihGvOqjjRDOM76XimZwlXg6lQBPXscW69HQPgvDMV9vTQNBlHQxDOWsAZf7FQze7NOQLftB1xQvsC2E7TdUqAFTzYBS33GEym2sitz6zIK4EMN1CYanKG3l2gyg4+z+8xyWUSYZRfz+t3Y8R2GivgEJWooyRfiloHuA1SkP3Dn7lgX6XkdWY2B8aIoQf/0jT3OP+HraXmWXRDN9i47vBDdnGHnnamu4ldymXdc+qbxJsiPKG1O7D0DW7+BOJ9cYbAATO49tOvcy6xQPV6uVG3dP4BDIO1R/m16H1C5NulWaFnQcHdmCRbiyW1KKwRmrvF3iqi/ZcMcBx83lltW2aTwDh0/czVXURcgc+yWt3eAhmE3rd7d32whAyC/BiEajow5fb1CpUZPCDNnRiTEyr37wl/6mSvP5339bF8UKMnre00nZnn7cFbvd0u1NjAt0UOBw1SHpBR3hkDKTA2vFEKD0S5Ay2dSjYIortFFNQJpotLRFnH9lBQLLdJPXvyOnSInyRqXVtotoMfQGIJYG7RZNvbn0+54UHmfrn4lE1CQ44yageGj4MKomwgw==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(36092001)(36840700001)(46966006)(83380400001)(70586007)(2616005)(336012)(36906005)(5660300002)(36860700001)(82740400003)(86362001)(81166007)(82310400003)(478600001)(107886003)(47076005)(54906003)(4326008)(356005)(42186006)(186003)(26005)(36756003)(2906002)(6916009)(8936002)(70206006)(8676002)(6666004)(426003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 05:20:02.8267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d55e154-4901-41dc-362d-08d8e2bafe2f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT039.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB8002
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_03:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=955 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation of DMA coherent memory in atomic context using
dma_alloc_coherent() might fail on platforms with smaller
DMA region.

To fix it, dma_alloc_coherent() is replaced with dma_pool
API to allocate a smaller chunk of DMA coherent memory for
TRB rings.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Reported-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Sanket Parmar <sparmar@cadence.com>
---
 drivers/usb/cdns3/cdns3-gadget.c |   42 +++++++++++++++++--------------------
 drivers/usb/cdns3/cdns3-gadget.h |    1 +
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 582bfec..5f51215 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -59,6 +59,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/usb/gadget.h>
 #include <linux/module.h>
+#include <linux/dmapool.h>
 #include <linux/iopoll.h>
 
 #include "core.h"
@@ -190,29 +191,13 @@ dma_addr_t cdns3_trb_virt_to_dma(struct cdns3_endpoint *priv_ep,
 	return priv_ep->trb_pool_dma + offset;
 }
 
-static int cdns3_ring_size(struct cdns3_endpoint *priv_ep)
-{
-	switch (priv_ep->type) {
-	case USB_ENDPOINT_XFER_ISOC:
-		return TRB_ISO_RING_SIZE;
-	case USB_ENDPOINT_XFER_CONTROL:
-		return TRB_CTRL_RING_SIZE;
-	default:
-		if (priv_ep->use_streams)
-			return TRB_STREAM_RING_SIZE;
-		else
-			return TRB_RING_SIZE;
-	}
-}
-
 static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
 {
 	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
 
 	if (priv_ep->trb_pool) {
-		dma_free_coherent(priv_dev->sysdev,
-				  cdns3_ring_size(priv_ep),
-				  priv_ep->trb_pool, priv_ep->trb_pool_dma);
+		dma_pool_free(priv_dev->eps_dma_pool,
+			      priv_ep->trb_pool, priv_ep->trb_pool_dma);
 		priv_ep->trb_pool = NULL;
 	}
 }
@@ -226,7 +211,7 @@ static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
 int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
 {
 	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
-	int ring_size = cdns3_ring_size(priv_ep);
+	int ring_size = TRB_RING_SIZE;
 	int num_trbs = ring_size / TRB_SIZE;
 	struct cdns3_trb *link_trb;
 
@@ -234,10 +219,10 @@ int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
 		cdns3_free_trb_pool(priv_ep);
 
 	if (!priv_ep->trb_pool) {
-		priv_ep->trb_pool = dma_alloc_coherent(priv_dev->sysdev,
-						       ring_size,
-						       &priv_ep->trb_pool_dma,
-						       GFP_DMA32 | GFP_ATOMIC);
+		priv_ep->trb_pool = dma_pool_alloc(priv_dev->eps_dma_pool,
+						   GFP_DMA32 | GFP_ATOMIC,
+						   &priv_ep->trb_pool_dma);
+
 		if (!priv_ep->trb_pool)
 			return -ENOMEM;
 
@@ -3113,6 +3098,7 @@ static void cdns3_gadget_exit(struct cdns *cdns)
 
 	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
 			  priv_dev->setup_dma);
+	dma_pool_destroy(priv_dev->eps_dma_pool);
 
 	kfree(priv_dev->zlp_buf);
 	usb_put_gadget(&priv_dev->gadget);
@@ -3185,6 +3171,14 @@ static int cdns3_gadget_start(struct cdns *cdns)
 	/* initialize endpoint container */
 	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
 	INIT_LIST_HEAD(&priv_dev->aligned_buf_list);
+	priv_dev->eps_dma_pool = dma_pool_create("cdns3_eps_dma_pool",
+						 priv_dev->sysdev,
+						 TRB_RING_SIZE, 8, 0);
+	if (!priv_dev->eps_dma_pool) {
+		dev_err(priv_dev->dev, "Failed to create TRB dma pool\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
 
 	ret = cdns3_init_eps(priv_dev);
 	if (ret) {
@@ -3235,6 +3229,8 @@ static int cdns3_gadget_start(struct cdns *cdns)
 err2:
 	cdns3_free_all_eps(priv_dev);
 err1:
+	dma_pool_destroy(priv_dev->eps_dma_pool);
+
 	usb_put_gadget(&priv_dev->gadget);
 	cdns->gadget_dev = NULL;
 	return ret;
diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-gadget.h
index 21fa461..ecf9b91 100644
--- a/drivers/usb/cdns3/cdns3-gadget.h
+++ b/drivers/usb/cdns3/cdns3-gadget.h
@@ -1298,6 +1298,7 @@ struct cdns3_device {
 
 	struct cdns3_usb_regs		__iomem *regs;
 
+	struct dma_pool			*eps_dma_pool;
 	struct usb_ctrlrequest		*setup_buf;
 	dma_addr_t			setup_dma;
 	void				*zlp_buf;
-- 
1.7.1

