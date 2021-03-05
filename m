Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BAE32EF8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhCEQCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:02:33 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:11360 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229798AbhCEQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:02:00 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125Fr9kv005396;
        Fri, 5 Mar 2021 08:01:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Z2W7AGH8E7yv3dlN5C+UZh3cCP++zNk490JbhJ3S468=;
 b=S4Cx0U7sSLbQ/uqybtvZZOyShl/lDb0DqgJgcf6jLS0BfxRORjSIkqmH7nVGwSoTVvK8
 3ZiaTRD6sO+0fsM2FWxIJU5X+3C6JfPk/PuP6uUlZkPq/LtqHUUbRrC27NJl1tJ7sMiC
 xwAKoQIUr21OBBvwZbrJRlBeUPIysK6+Paq7GKRuS5EvlljorIGc9dKbEm34DbKwkYcb
 /9d2/kEN1X21wdcg0plN9TQlfZM9sHm/xyjgmEMueJp7iUSbGps4BgKmymw7Qwdr/gkW
 +BmbxD0DnlTI6ca63fxqNpmqyKR4TLdgSjyYMF20f2NBHrHNfZEkGAOeOHFcQSjQs6NO OQ== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by mx0a-0014ca01.pphosted.com with ESMTP id 372bvqrgwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 08:01:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvddxMZgK+emZBoLB2SLQIzOvVGynCes2dEVE7td6nrYM1v/6LUO3mwCA/GfJBfld8Ikui050t0gxTBcBMX+WmK6BOx5cibSNTWzQRHABQAFN0REL1tiLmdi7lXT6r2ZDmZsTpp1IXQjvKLXwZkvDe+VbIqznk+c8XKnlYv3YN/4kltrhQBo9jxs+Ha5T1hg5u+DFFCdemMYC/NJQKHjiphZ5QEQxG8iaA1fkKQLMJMAreS736wPjG8LxjXXm07EjopKWDujMWA8/zs0gHTjfTI7+C07IzE0dyEvSgD/snJJ9+1ngZS6SWPpMW0qXd/q8vJhS2rGTIXflfz72N5Auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2W7AGH8E7yv3dlN5C+UZh3cCP++zNk490JbhJ3S468=;
 b=docWIyvuHK24IJ8OOTrb+xp2SXiy51mPcS4QX0pXLzy8y72DEc6ZaQb+eWfflzfWoVNhKG4ePpqU7TQWTtdJQu3hcgIwZg7BrHBhcCmjRpvFGZZjbtBU7Cllg+VBXSZ7PpsKBshakNfOOVirogrpx3mrLp8kMoNFNUcdxUKkZbwdwbpsMP3Y9MjDr71v4w1ILP5VZjVZZIh1BcYTgLoz1JN0gZRxkRYjBV20+1xJbL/M+zlUNQkfEqIONgQBS34tJQH8Dql2j4TzKD5ciZNQACjrKQxd/5t7tCnWvez+Kt/lva6HFDRKG7HfhFim8OedYksI65i5G2frLWZRA9TPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2W7AGH8E7yv3dlN5C+UZh3cCP++zNk490JbhJ3S468=;
 b=rwgP/60gWR0Rvj1b2QQF/IHTMtUIL0tDbuMCzG8deouCnxzTeQz5bMS4LAeBgMmTJTPOU17Wu6H3KxCQQAav4XVc4XunPF0ifHF8+mHXnHQufzdW5KChv4XyC5Fhu2VUq5OGZbPOOd/qVj2S4cg9Cw0htwNiL6YbJmGf8ig7ocI=
Received: from MW4PR03CA0308.namprd03.prod.outlook.com (2603:10b6:303:dd::13)
 by BN7PR07MB5170.namprd07.prod.outlook.com (2603:10b6:408:28::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 16:01:40 +0000
Received: from MW2NAM12FT043.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::32) by MW4PR03CA0308.outlook.office365.com
 (2603:10b6:303:dd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 16:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT043.mail.protection.outlook.com (10.13.180.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Fri, 5 Mar 2021 16:01:39 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 125G1aBv028588
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 11:01:37 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 5 Mar 2021 17:01:36 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 5 Mar 2021 17:01:36 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 125G1adX030546;
        Fri, 5 Mar 2021 17:01:36 +0100
Received: (from sparmar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 125G1Zka030540;
        Fri, 5 Mar 2021 17:01:35 +0100
From:   Sanket Parmar <sparmar@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <pawell@cadence.com>, <a-govindraju@ti.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>, <gregkh@linuxfoundation.org>,
        Sanket Parmar <sparmar@cadence.com>
Subject: [PATCH] usb: cdns3: Coherent memory allocation optimization
Date:   Fri, 5 Mar 2021 17:01:11 +0100
Message-ID: <1614960071-30367-1-git-send-email-sparmar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41037f3a-93ba-4387-2168-08d8dfeff6a8
X-MS-TrafficTypeDiagnostic: BN7PR07MB5170:
X-Microsoft-Antispam-PRVS: <BN7PR07MB51709BCAC7D0E232ADFFEBADB0969@BN7PR07MB5170.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:133;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jhcqeFBaWhOL+3pToOG+iNtd7P3JcwjY5JpFFnRn8Ozvkfa8srjfEjqRlPkLI1ea9GJCrRi+72nK3loRDdp3NUfA2DW5PM3WPc07YVh2dZ1CNtVsVgIQrYy/cW6Xb9nvw2edDGkuHeeCc3VP9CMrdBlgGp8Rown8eWPP4OEMojdmUebkkWatoM+OXCxbmz8l9h66DcZhcrjns3+K/VJgKlg9s7xIwFcgDtsFIXXKyx35GdCbH4uRIbC75/DCE7rJhC2sN5M6cPfLffKl+ImLFw7Jqg57Kfe9wDvDyimZfLVZR5R6QWwgSxiK1+T8BukSNmA7oojxhiqnIcdEX5HpG+cGBqE+S2rmEjaF5l8BMovDJq3N81a2lSNpTTaVvxJoqs6LpgYm+bv+edIM3xVnX4W+onQe1tkaamSVYBlnlJ0VK/xDTjTPKu4MCUuFNkOu++P6ceZesNmjs8yPDVpRhgL/OMhKOqS3pIpTXpuCaaD7XlhVcAH738mFEF2xPdPsMIwuqLNjzLfGhXd/H0FpAoHCK5Mh3D/BIewRMePo85WLHBGj8LmsKnZba+bo2eYKPZ2JL3Q+lPNriTMzb1aECaT7CIl65jnu5UwVBv8y1eCHyCBBd+5UxAkXN1a7U9ahTGb+ixVJgj96iU0jCXHOCucOz9RGXX44mtndhWsnv5xwhfl2cYBI3agra3VTA1Ig8Dk2zyAntzspJASw4nWIA==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(36092001)(36840700001)(46966006)(82740400003)(186003)(70586007)(70206006)(478600001)(5660300002)(316002)(2906002)(36906005)(2616005)(82310400003)(8936002)(83380400001)(36860700001)(6916009)(356005)(4326008)(81166007)(42186006)(36756003)(336012)(426003)(107886003)(26005)(86362001)(6666004)(54906003)(8676002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 16:01:39.9417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41037f3a-93ba-4387-2168-08d8dfeff6a8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT043.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5170
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_10:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1011 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation of DMA coherent memory in atomic context using
dma_alloc_coherent() might fail on some platform. To fix it,
Replaced dma_alloc_coherent() with dma_pool API to allocate a
smaller chunk of DMA coherent memory for TRB rings.

Also in cdns3_prepare_aligned_request_buf(), replaced
dma_alloc_coherent() with kmalloc and dma_map API to allocate
aligned request buffer of dynamic length.

Fixes: commit 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Reported by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Sanket Parmar <sparmar@cadence.com>
---
 drivers/usb/cdns3/cdns3-gadget.c |  115 ++++++++++++++++++++++---------------
 drivers/usb/cdns3/cdns3-gadget.h |    3 +
 2 files changed, 71 insertions(+), 47 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 582bfec..5fd6993 100644
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
+				priv_ep->trb_pool, priv_ep->trb_pool_dma);
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
+						GFP_DMA32 | GFP_ATOMIC,
+						&priv_ep->trb_pool_dma);
+
 		if (!priv_ep->trb_pool)
 			return -ENOMEM;
 
@@ -833,10 +818,26 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 	usb_gadget_unmap_request_by_dev(priv_dev->sysdev, request,
 					priv_ep->dir);
 
-	if ((priv_req->flags & REQUEST_UNALIGNED) &&
-	    priv_ep->dir == USB_DIR_OUT && !request->status)
-		memcpy(request->buf, priv_req->aligned_buf->buf,
-		       request->length);
+	if ((priv_req->flags & REQUEST_UNALIGNED) && priv_req->aligned_buf) {
+		struct cdns3_aligned_buf *buf;
+
+		buf = priv_req->aligned_buf;
+		dma_unmap_single(priv_dev->sysdev, buf->dma, buf->size,
+			buf->dir);
+		priv_req->flags &= ~REQUEST_UNALIGNED;
+
+		if (priv_ep->dir == USB_DIR_OUT && !request->status) {
+			memcpy(request->buf, priv_req->aligned_buf->buf,
+			       request->length);
+		}
+
+		trace_cdns3_free_aligned_request(priv_req);
+		priv_req->aligned_buf->in_use = 0;
+		queue_work(system_freezable_wq,
+			   &priv_dev->aligned_buf_wq);
+		priv_req->aligned_buf = NULL;
+
+	}
 
 	priv_req->flags &= ~(REQUEST_PENDING | REQUEST_UNALIGNED);
 	/* All TRBs have finished, clear the counter */
@@ -898,8 +899,7 @@ static void cdns3_free_aligned_request_buf(struct work_struct *work)
 			 * interrupts.
 			 */
 			spin_unlock_irqrestore(&priv_dev->lock, flags);
-			dma_free_coherent(priv_dev->sysdev, buf->size,
-					  buf->buf, buf->dma);
+			kfree(buf->buf);
 			kfree(buf);
 			spin_lock_irqsave(&priv_dev->lock, flags);
 		}
@@ -925,27 +925,16 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
 		if (!buf)
 			return -ENOMEM;
 
-		buf->size = priv_req->request.length;
+		buf->size = usb_endpoint_dir_out(priv_ep->endpoint.desc) ?
+				usb_ep_align(&(priv_ep->endpoint), priv_req->request.length)
+				: priv_req->request.length;
 
-		buf->buf = dma_alloc_coherent(priv_dev->sysdev,
-					      buf->size,
-					      &buf->dma,
-					      GFP_ATOMIC);
+		buf->buf = kmalloc(buf->size, GFP_ATOMIC);
 		if (!buf->buf) {
 			kfree(buf);
 			return -ENOMEM;
 		}
 
-		if (priv_req->aligned_buf) {
-			trace_cdns3_free_aligned_request(priv_req);
-			priv_req->aligned_buf->in_use = 0;
-			queue_work(system_freezable_wq,
-				   &priv_dev->aligned_buf_wq);
-		}
-
-		buf->in_use = 1;
-		priv_req->aligned_buf = buf;
-
 		list_add_tail(&buf->list,
 			      &priv_dev->aligned_buf_list);
 	}
@@ -955,6 +944,27 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
 		       priv_req->request.length);
 	}
 
+	if (priv_req->aligned_buf) {
+		trace_cdns3_free_aligned_request(priv_req);
+		priv_req->aligned_buf->in_use = 0;
+		queue_work(system_freezable_wq,
+			   &priv_dev->aligned_buf_wq);
+	}
+
+	buf->dir =  priv_ep->dir ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	buf->in_use = 1;
+	priv_req->aligned_buf = buf;
+
+	buf->dma = dma_map_single(priv_dev->sysdev, buf->buf, buf->size,
+				buf->dir);
+
+	if (dma_mapping_error(priv_dev->sysdev, buf->dma)) {
+		dev_err(priv_dev->dev, "Failed to map buffer\n");
+		kfree(buf->buf);
+		kfree(buf);
+		return -EFAULT;
+	}
+
 	priv_req->flags |= REQUEST_UNALIGNED;
 	trace_cdns3_prepare_aligned_request(priv_req);
 
@@ -3103,16 +3113,17 @@ static void cdns3_gadget_exit(struct cdns *cdns)
 		struct cdns3_aligned_buf *buf;
 
 		buf = cdns3_next_align_buf(&priv_dev->aligned_buf_list);
-		dma_free_coherent(priv_dev->sysdev, buf->size,
-				  buf->buf,
-				  buf->dma);
+		dma_unmap_single(priv_dev->sysdev, buf->dma, buf->size,
+			buf->dir);
 
 		list_del(&buf->list);
+		kfree(buf->buf);
 		kfree(buf);
 	}
 
 	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
 			  priv_dev->setup_dma);
+	dma_pool_destroy(priv_dev->eps_dma_pool);
 
 	kfree(priv_dev->zlp_buf);
 	usb_put_gadget(&priv_dev->gadget);
@@ -3185,6 +3196,14 @@ static int cdns3_gadget_start(struct cdns *cdns)
 	/* initialize endpoint container */
 	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
 	INIT_LIST_HEAD(&priv_dev->aligned_buf_list);
+	priv_dev->eps_dma_pool = dma_pool_create("cdns3_eps_dma_pool",
+						priv_dev->sysdev,
+						TRB_RING_SIZE, 8, 0);
+	if (!priv_dev->eps_dma_pool) {
+		dev_err(priv_dev->dev, "Failed to create TRB dma pool\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
 
 	ret = cdns3_init_eps(priv_dev);
 	if (ret) {
@@ -3235,6 +3254,8 @@ static int cdns3_gadget_start(struct cdns *cdns)
 err2:
 	cdns3_free_all_eps(priv_dev);
 err1:
+	dma_pool_destroy(priv_dev->eps_dma_pool);
+
 	usb_put_gadget(&priv_dev->gadget);
 	cdns->gadget_dev = NULL;
 	return ret;
diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-gadget.h
index 21fa461..c5660f2 100644
--- a/drivers/usb/cdns3/cdns3-gadget.h
+++ b/drivers/usb/cdns3/cdns3-gadget.h
@@ -12,6 +12,7 @@
 #ifndef __LINUX_CDNS3_GADGET
 #define __LINUX_CDNS3_GADGET
 #include <linux/usb/gadget.h>
+#include <linux/dma-direction.h>
 
 /*
  * USBSS-DEV register interface.
@@ -1205,6 +1206,7 @@ struct cdns3_aligned_buf {
 	void			*buf;
 	dma_addr_t		dma;
 	u32			size;
+	enum dma_data_direction dir;
 	unsigned		in_use:1;
 	struct list_head	list;
 };
@@ -1298,6 +1300,7 @@ struct cdns3_device {
 
 	struct cdns3_usb_regs		__iomem *regs;
 
+	struct dma_pool			*eps_dma_pool;
 	struct usb_ctrlrequest		*setup_buf;
 	dma_addr_t			setup_dma;
 	void				*zlp_buf;
-- 
1.7.1

