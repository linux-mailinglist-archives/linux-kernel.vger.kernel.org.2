Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5438733F8F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhCQTPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:15:49 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43192 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233149AbhCQTPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:15:23 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12HJCoXj011990;
        Wed, 17 Mar 2021 12:15:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=NtgydgGrHDL/aoYqRP2/phco5vpba8PzSFZowLnbWu8=;
 b=ochcDSJ4eu954zFicJz2QEWOAJ6+7loq55yBL6ZtSb6l5L7JQWoNnb+BkvQzeiBJMYff
 sGYtIZlBeuuOrruTm2Iu5KOvkWFjqyutY2R5t0+7yZ7P4AqVeLybsSR50Wgg3+Ao2fRe
 J+OSTkNZFRRPWd4d17+4ovZ6QQxJ1QzBpITicMJLwSmQ0MYt13lPCMR/FQvkH5wnRiWl
 JVmcI3vndtOZmBGoHfg7zKT6qMdmlFz3FaZ0p+xdaRLx00BFugnnHtNa+axOHQgldSh5
 jvtGEyFoEhFnXzGoZN/7nAgg6YueLkKO7omcIz/fbvWeiQfbLGg9c+vm7z47bqhydxAh Pw== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 378tu26f92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Mar 2021 12:15:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy5ZNwns4BQeodjLNKOOEkL9Cwdc1HpcPtYt93+OoLQO+i7z6WrwXUJ8plc09D7n2HBM/HWThZ/qUouUUlvwPfArkQ6heJBqVIdf+lWV8MIntWI5lZm1DRFOjND9aHkbBm1swUBYgs4HySVKD88wSasitGX0FQFTcdAPlZjArufAt+EevmdRasI68ejTVEMosNNx4wYc9wXaM/DpKyBfN8kvjXaCLGBFHg9puPFpDizgz51rwjOLgHRbD2mpqpPDiPAKLOn6qjaaDB2WexGmMJddsLxZvUCd5LXzuGGbKx7dVO/aFkr6WmsUxGKzltWD+aejK3yxztl48YjiRpwifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtgydgGrHDL/aoYqRP2/phco5vpba8PzSFZowLnbWu8=;
 b=ZOb1wJ3kfvQCRYbEWmfkI7MZ+DM9r/o1KQx7XQpnDkpo92W3oyexmxCckwLcq6cNxoh5tT4OGNmOuDtoHT5V33x+kE6KTgs+R+pX/lbtLLctZtu5OhTvZbbZY49AL+5oeLJrGwCpNVaIPz12haSWzBRhYm6sUmoA1AjHHI/wfuVHYRihQ+6Oo9C+bE1BtpUfeGriWBYQv3pGDVaRd1XpneZjrwffW9QCmytdu8rzGpECsjnviOygEah3wN7QntxzTblcGtkmRcpx+5uHzCf1f/N5AekSu5qCheQdgIVEhgm30cpFktzCispG6wnIbxxWLRkIFOAfd0aYHmRCSLfHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtgydgGrHDL/aoYqRP2/phco5vpba8PzSFZowLnbWu8=;
 b=3w5wzOeAqSp8QwhsI7GGd/EUZZl0dXeY257M+NZ6iyLa7dCV+Nk4bWuT8uNdRY2oHZjoJ8rsXQCLL3CxziKiNPOr0Ny502MIDQnNszFGZ7jmVZcBTcxKVL0vHhA/uOLgHEKV98BSvlfFY7hWRYWIf1apX3h87GmNgAOjlMIU/dE=
Received: from DM5PR1101CA0020.namprd11.prod.outlook.com (2603:10b6:4:4c::30)
 by SJ0PR07MB8583.namprd07.prod.outlook.com (2603:10b6:a03:370::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 19:15:04 +0000
Received: from DM6NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::e) by DM5PR1101CA0020.outlook.office365.com
 (2603:10b6:4:4c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 19:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT003.mail.protection.outlook.com (10.13.179.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.9 via Frontend Transport; Wed, 17 Mar 2021 19:15:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 12HJExpI019523
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 12:15:01 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Mar 2021 20:14:58 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 17 Mar 2021 20:14:58 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 12HJExJ9015846;
        Wed, 17 Mar 2021 20:14:59 +0100
Received: (from sparmar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 12HJEwsf015840;
        Wed, 17 Mar 2021 20:14:58 +0100
From:   Sanket Parmar <sparmar@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <pawell@cadence.com>, <a-govindraju@ti.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <hch@infradead.org>,
        Sanket Parmar <sparmar@cadence.com>
Subject: [PATCH v2] usb: cdns3: Optimize DMA request buffer allocation
Date:   Wed, 17 Mar 2021 20:13:59 +0100
Message-ID: <1616008439-15494-1-git-send-email-sparmar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6931c712-c2e3-41e1-7440-08d8e978f7f2
X-MS-TrafficTypeDiagnostic: SJ0PR07MB8583:
X-Microsoft-Antispam-PRVS: <SJ0PR07MB8583FDE569AC767242FE917EB06A9@SJ0PR07MB8583.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6UmU8Wq5D+qJM2xM7AuB2jCiHOlfolcZrKQVbfCh5f77Xtv+JWdklq0ju1BQSqxMdfEV+R+4lCtI14yiRdPJm+y+7rHAqGTS9SdDlaptJta84KgsiCYZRCr+nHvLHOUOGAeQsMspNrVU4UXkdc4F8ewdmtQDkF6HDuaHT6QYo2uXHvrFIczQfGLOm1HOgLqYzPd/+0aE0QqjYmkgFdxlxWpP+/S4mUBVUIFXaDwfMDx8ZZCp93SEvwJ5NlP/MWcWwkXj0BVnOAM1oZ1rdQf00rXPlHfAG5B0Iuh+HclX6PdJrs1bVK8bo1ZHbJyBXcKnPQdb/2TpAnlamLxoOt37qJi0TodopNakBTTTlniCMWv5oa+HFuwnyjzrd8GBoS/sYbQb0SlpCleinesZRCineL9fGYvab6Sg11odFbtRzPoNJTnfubd+oagpeIbKXD9O9aOpAUJorQpZmxbR4om3lQ1mpJc+5lvE/5fosm459xYDjb9AQjTPN3KxbJhF4baufsQ9GI2WNaN9A/AzEHVRdm72N/fQcvCYUTqSFBZz/XxOrwH2Rbglk37m/VB5QdJXY0rTptm1QZBGthF4G2w4d8YE3DCD2io+UkYqmGHyYYjK0pLfvKrqFC3WotA1vS+hUCsq40btz902c9FypGLrvKaqmsrHvFyUUXnFVKTNs24B8Gnpi27Xb0NO1DwQzHqB
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(36092001)(46966006)(36840700001)(82740400003)(5660300002)(336012)(4326008)(107886003)(26005)(36906005)(8936002)(7636003)(2906002)(316002)(2616005)(47076005)(42186006)(83380400001)(426003)(86362001)(356005)(70586007)(82310400003)(70206006)(36860700001)(186003)(478600001)(6916009)(36756003)(8676002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 19:15:03.7074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6931c712-c2e3-41e1-7440-08d8e978f7f2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT003.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB8583
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-17_11:2021-03-17,2021-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=745 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_alloc_coherent() might fail on the platform with a small
DMA region.

To avoid such failure in cdns3_prepare_aligned_request_buf(),
dma_alloc_coherent() is replaced with dma_alloc_noncoherent()
to allocate aligned request buffer of dynamic length.

Reported-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Sanket Parmar <sparmar@cadence.com>
---

Changelog:
v2:
- used dma_*_noncoherent() APIs
- changed the commit log

 drivers/usb/cdns3/cdns3-gadget.c | 30 ++++++++++++++++++++++++------
 drivers/usb/cdns3/cdns3-gadget.h |  2 ++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 0b892a2..126087b 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -819,9 +819,15 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 					priv_ep->dir);
 
 	if ((priv_req->flags & REQUEST_UNALIGNED) &&
-	    priv_ep->dir == USB_DIR_OUT && !request->status)
+	    priv_ep->dir == USB_DIR_OUT && !request->status) {
+		/* Make DMA buffer CPU accessible */
+		dma_sync_single_for_cpu(priv_dev->sysdev,
+			priv_req->aligned_buf->dma,
+			priv_req->aligned_buf->size,
+			priv_req->aligned_buf->dir);
 		memcpy(request->buf, priv_req->aligned_buf->buf,
 		       request->length);
+	}
 
 	priv_req->flags &= ~(REQUEST_PENDING | REQUEST_UNALIGNED);
 	/* All TRBs have finished, clear the counter */
@@ -883,8 +889,8 @@ static void cdns3_free_aligned_request_buf(struct work_struct *work)
 			 * interrupts.
 			 */
 			spin_unlock_irqrestore(&priv_dev->lock, flags);
-			dma_free_coherent(priv_dev->sysdev, buf->size,
-					  buf->buf, buf->dma);
+			dma_free_noncoherent(priv_dev->sysdev, buf->size,
+					  buf->buf, buf->dma, buf->dir);
 			kfree(buf);
 			spin_lock_irqsave(&priv_dev->lock, flags);
 		}
@@ -911,10 +917,13 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
 			return -ENOMEM;
 
 		buf->size = priv_req->request.length;
+		buf->dir = usb_endpoint_dir_in(priv_ep->endpoint.desc) ?
+			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 
-		buf->buf = dma_alloc_coherent(priv_dev->sysdev,
+		buf->buf = dma_alloc_noncoherent(priv_dev->sysdev,
 					      buf->size,
 					      &buf->dma,
+					      buf->dir,
 					      GFP_ATOMIC);
 		if (!buf->buf) {
 			kfree(buf);
@@ -936,10 +945,18 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
 	}
 
 	if (priv_ep->dir == USB_DIR_IN) {
+		/* Make DMA buffer CPU accessible */
+		dma_sync_single_for_cpu(priv_dev->sysdev,
+			buf->dma, buf->size, buf->dir);
 		memcpy(buf->buf, priv_req->request.buf,
 		       priv_req->request.length);
 	}
 
+	/* Transfer DMA buffer ownership back to device */
+	dma_sync_single_for_device(priv_dev->sysdev,
+			buf->dma, buf->size, buf->dir);
+
+
 	priv_req->flags |= REQUEST_UNALIGNED;
 	trace_cdns3_prepare_aligned_request(priv_req);
 
@@ -3088,9 +3105,10 @@ static void cdns3_gadget_exit(struct cdns *cdns)
 		struct cdns3_aligned_buf *buf;
 
 		buf = cdns3_next_align_buf(&priv_dev->aligned_buf_list);
-		dma_free_coherent(priv_dev->sysdev, buf->size,
+		dma_free_noncoherent(priv_dev->sysdev, buf->size,
 				  buf->buf,
-				  buf->dma);
+				  buf->dma,
+				  buf->dir);
 
 		list_del(&buf->list);
 		kfree(buf);
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
2.4.5

