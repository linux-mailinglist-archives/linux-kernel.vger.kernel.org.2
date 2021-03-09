Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15B0331E48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 06:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhCIFU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 00:20:58 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:11992 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhCIFUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 00:20:21 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1295HsDd025242;
        Mon, 8 Mar 2021 21:20:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=NVT7S0IRFpinzyLtnSBMqZ6eSdZ+lIHHMOEX1A5oMl4=;
 b=MN7n5IRYcQmrxa8Gojd7kQfW9oGgIwpjLRlb0qT1S5jZT9mqveLBTh5LuRR7mrmb9S8Y
 x80+nlfe+lAN6Tg6yWCOJ5SrjdR1oVQKhfpE/IPllQvKhmGlNc91TOAzInqylzO58Kx+
 dX6VuJM8vO7KIwir2FACJJwVOoQ0rPvJMPC6vIIkyTl+d6VSnmxHSE1b1CIwjL/ClTNb
 frHQ6sfe5cLxm54I7Dvk5AMYNF5qSz4r9HBMvaOHSOwWpIHp7ZIet0qP0knqnaAhvCnP
 yDk3qiHfWxFq2/YEHYGjrMXIb7qIrlDwgtN6WGamLO6hya0D4QhbeeaOFIZ/4bZjqk3n dA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by mx0a-0014ca01.pphosted.com with ESMTP id 374762yc25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 21:20:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIKz5pltTNqJMRsacb5TRfnJ5urMqlGcA+qZANHzqcKWDLwR9EG1vd5TEUhw9LpeQll/UPV17OWVDA+xNN0x0BHMWeozlLSoNSYIL9+KKV3zm3H3GrJNG1Pow5IRDzWSZkn1LtcBIZh4llmHq2901PYd2NiVbNSreSi6FpZONKct02wHxc3LBCa+DKK5GEQBoqbXBmjkcJbjGUEVpXkAISjqHJirE59UvmhHP6T03LkGzq9pzQd9vmKQslgRxVocvFAbkEQzirPB7HTbtu/kMFLw2xZ/d7lWDnEwjN6V+O6JMtCmQf7HBEmzGxCphRXG3hrq9fdtjRMp31JQWMygjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVT7S0IRFpinzyLtnSBMqZ6eSdZ+lIHHMOEX1A5oMl4=;
 b=XweHsnA5nGqiszVwmlckQlBLbJivifZd2DjXtlUGJyYySVYtj6/KscD/hd4FX/eLSEuvX7lEuZa7AFta3tDQ0BfKnokBlmUcaRJBA/Q4IqdY1wJaX7NuwNwyL3mpOZHdyCdA52pgmKYhid8wwTYbVaNLoo1K2yT7pr/8kZ1fEpvBQjQlkxLeb6Jr1ka/eq0EIDeMPCNsXd8aCBvjBthK64ghUUf7HF9aHh/CylCvl/sno6ZiNTFxhs4vZmGbT/S5hwOiBkUMEbTIs2A6dtXmmfEGr2+tgnRVdWVMNuqU8g31mRSSxbfkVWX5i/p1t6lcdkpEVbusl1mA0+IsWtGnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVT7S0IRFpinzyLtnSBMqZ6eSdZ+lIHHMOEX1A5oMl4=;
 b=iRi1TrNEoyvP4nmkPZCz7sNbO2AudKlIk+qvTp4f9WKLmPuY1/WEWMeTHr4Ip75n2AfYXEF80SF+FDS9zE0fgwoMgXxduK/kmBMLW9Xb00tjxs3fA5wSugCGQgw0J+2/781MG/b6TqtseqWmEcIB8DjWxAUJTQnXMWVvEpkE5W0=
Received: from BN9PR03CA0890.namprd03.prod.outlook.com (2603:10b6:408:13c::25)
 by DM5PR0701MB3623.namprd07.prod.outlook.com (2603:10b6:4:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 05:20:09 +0000
Received: from BN8NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::e2) by BN9PR03CA0890.outlook.office365.com
 (2603:10b6:408:13c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 9 Mar 2021 05:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT017.mail.protection.outlook.com (10.13.182.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.16 via Frontend Transport; Tue, 9 Mar 2021 05:20:08 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1295K6OE018405
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Mar 2021 21:20:07 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Mar 2021 06:20:05 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 9 Mar 2021 06:20:05 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1295K53u009487;
        Tue, 9 Mar 2021 06:20:05 +0100
Received: (from sparmar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1295K5Nc009486;
        Tue, 9 Mar 2021 06:20:05 +0100
From:   Sanket Parmar <sparmar@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <pawell@cadence.com>, <a-govindraju@ti.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, Sanket Parmar <sparmar@cadence.com>
Subject: [PATCH 2/2] usb: cdns3: Optimize DMA request buffer allocation
Date:   Tue, 9 Mar 2021 06:19:40 +0100
Message-ID: <1615267180-9289-2-git-send-email-sparmar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
References: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: becd66f7-4a74-4c34-db13-08d8e2bb01a6
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3623:
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3623061F9A4B91ACE4B9A6DCB0929@DM5PR0701MB3623.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9APdjQI33A/VcDmRTk5o47IxN2vqPPH0d1e+kYEH93c48mTSDZHC49S6w3fzdVM+bdddm89wCMwtub6sqkgdHCMc/lh+6wM8gz0xVt+FFRvYybL+aazpGehl/qCG3pXYLkfGkQaTGG1Nl9QqZOKNjX73VHKrJC+kDrETIwazlod/k7uX5W9FZSbE9Y7e+fphedbC4OQ4FlW37YxCoC46NHhTipRQayxVxQ0fwl2Tbwesr3mpCQ3yqbP4Bleh7N9IfxPFNzCKp5gWxLpAPP7gs3faeZNy6aZ4FexP+MUesOI1XHrd1Wi6bkkHBdq8H3QS9QSHE/Su7EVN2vOUmnYNYxlILdCj02UqZj2VHddOe5L2vrSMkYg9V8JFAcV7dmVy/3T0wNFxB4iW9mlkNq/RJH0IelqhOkcWKNKxyZM+nmoin6CY6/Iz0R66XNJf3OQdHwpsBnV1OK8zFL4tJc3Aua2s7U70V/ireFpka/21OqDwlulOJJKjF5Q6mUuBxfYPWPNci6GPuZk6YzQDBMNrrSbtA2YH3jsj4c9KARP8YE+ug07V6PxAHI6nsn4+Zy1VdwYCbMWpzhvLbw4zgzu+AGCYZMkQmwx0fQ55m0Bq8U86sQLEpaXSZ2yjr5org3RpKJbhNdxjZGm+7dJK+Wrm7W5m0sA0KlyTUJWc5XBNN/72nKzBhEhhAisD7ITNN+sg
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36092001)(46966006)(36840700001)(26005)(186003)(336012)(8676002)(2906002)(6916009)(7636003)(36756003)(6666004)(2616005)(82310400003)(83380400001)(426003)(70206006)(356005)(8936002)(86362001)(82740400003)(478600001)(42186006)(316002)(36906005)(4326008)(5660300002)(107886003)(47076005)(36860700001)(54906003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 05:20:08.6089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: becd66f7-4a74-4c34-db13-08d8e2bb01a6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3623
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_03:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=557 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103090025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_alloc_coherent() might fail on the platform with a small DMA region.

To avoid such failure in cdns3_prepare_aligned_request_buf(),
dma_alloc_coherent() is replaced with kmalloc and dma_map API to
allocate aligned request buffer of dynamic length.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Reported-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Sanket Parmar <sparmar@cadence.com>
---
 drivers/usb/cdns3/cdns3-gadget.c |   73 +++++++++++++++++++++++++------------
 drivers/usb/cdns3/cdns3-gadget.h |    2 +
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 5f51215..b4955ce 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -818,10 +818,26 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
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
@@ -883,8 +899,7 @@ static void cdns3_free_aligned_request_buf(struct work_struct *work)
 			 * interrupts.
 			 */
 			spin_unlock_irqrestore(&priv_dev->lock, flags);
-			dma_free_coherent(priv_dev->sysdev, buf->size,
-					  buf->buf, buf->dma);
+			kfree(buf->buf);
 			kfree(buf);
 			spin_lock_irqsave(&priv_dev->lock, flags);
 		}
@@ -910,27 +925,16 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
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
@@ -940,6 +944,27 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
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
 
@@ -3088,11 +3113,11 @@ static void cdns3_gadget_exit(struct cdns *cdns)
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
 
diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-gadget.h
index ecf9b91..c5660f2 100644
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
-- 
1.7.1

