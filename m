Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E43343DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhCVK2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:28:55 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49848 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230035AbhCVK2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:28:25 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MAP6mM010364;
        Mon, 22 Mar 2021 03:28:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=MoItcpHxe+HwMorB04AOq90yKNZYitEq2STxJOgtEw8=;
 b=SL0uc8M3Nkw/mahDMcl9wXWsA4t/ROelEYBP9zfGvou9t2Dc4/SEG+BZFSmKCOV+m0cu
 cthmlt4mK35T1BlCxIlQQDLaenMWzB1VLwwL/aqtYoqwBPVC0yHIBfonmlU+BnkWExUM
 eTQ4AH2lfYyVwQgjJzgBQb8JZCsjqPQJo+pAyd5N6340i7/k0n8aBfjTyNEYIdHXIP8V
 YzWD2pp7JJbMeCUJn0vO7VIj0PxFtYRt23qWhsGUzfDhKTTh+3lWGH0/IABqr67bLFZH
 bPOV0zFhsB//w61eWDt6hpot82TMoTlQ61pAGQrNcwFP/3iqtSs5RwcPSQ/J7H8KmrnL TA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37dcmy4vv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 03:28:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLfgl4c7U9PgGu3WXYE2Fk1ljkiHImGggNvAIw0Vb0+WieffMWa+LanSY8y09PbZOlDw9Y6FqNYP1XZW8gWPAt0tWobaeb9/Sn2vFum8e4/4GnZ3wcjFDQPu3bNUE3yyDiBhamSKLgXNO/F+yVCmacx4IzcrBsgpUmqmkpbISKaaF2/lrgtjy5IUYnkFmK9SpNIqVOJEHZ81w3aDSpGoxNM9vEEs9p/rNJ/jKT8UPRNUrez5M8MsSiveH3Ki2zIKg2LTu8J7YV73N8/JuiOcIQXj3UnU8gvSx1BGflYkk+wgIevFpXKZK87KVzSOIxhV7lgn8rip3gfWH8J/wWwIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoItcpHxe+HwMorB04AOq90yKNZYitEq2STxJOgtEw8=;
 b=M3EK213uevv1aLwov8oRMdWO3TTfEYBqMjWAQjjOXeqXbT5rDVvpzQIw1x0GIIvVshxuSXyYtrDgQIWj4trUGp9HsXbEvwQY3X6pj0s9TEyJWyn8FW4nxH4LdHVhzfw3evcdVJ2UtJXAsCTlqjV4cQfPzdUw80fTQ7NR74Uo9qIRsbWEcaC6LkNX2S2f55OZwWYBPMU6OFUQndyzefcnfnGxSjxUi/7JgxeVNCmEe0OictdHTLTVvtO+dwkSzs1wKw7ttQQqeSrH61qfZ2/IISGEXhqAPgwwRy0RwTdIOVbo4lAlXbSTKNWu2xZ01H2A6Ymrx9w+DK5kOr91VXN2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoItcpHxe+HwMorB04AOq90yKNZYitEq2STxJOgtEw8=;
 b=tvwretIQ0CcQ+8jBpjcskBdZDqwE0yPMGsc5T3zFmH6P1YHX9WQSgqXl9MHi547cOBOrQM6v5JXYgsDnVIZXvDGQMwlqbzL5/2s9nj9+wSWaf3B1fyZ9kkvtEGjZCHWBhNQGptQECv8/ulyOiZuJok+u4mAaB81C+yKjiynSsoQ=
Received: from MWHPR2001CA0013.namprd20.prod.outlook.com
 (2603:10b6:301:15::23) by BYAPR07MB6182.namprd07.prod.outlook.com
 (2603:10b6:a03:11b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Mon, 22 Mar
 2021 10:27:58 +0000
Received: from MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::43) by MWHPR2001CA0013.outlook.office365.com
 (2603:10b6:301:15::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 10:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT021.mail.protection.outlook.com (10.13.180.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.9 via Frontend Transport; Mon, 22 Mar 2021 10:27:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 12MARs55030538
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 03:27:55 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Mar 2021 11:27:54 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 22 Mar 2021 11:27:54 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 12MARrqj020554;
        Mon, 22 Mar 2021 11:27:53 +0100
Received: (from sparmar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 12MARptw020542;
        Mon, 22 Mar 2021 11:27:51 +0100
From:   Sanket Parmar <sparmar@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <pawell@cadence.com>, <a-govindraju@ti.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <hch@infradead.org>,
        Sanket Parmar <sparmar@cadence.com>
Subject: [PATCH v3] usb: cdns3: Optimize DMA request buffer allocation
Date:   Mon, 22 Mar 2021 11:26:30 +0100
Message-ID: <1616408790-20060-1-git-send-email-sparmar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75792035-6c2e-4e1f-f867-08d8ed1d293c
X-MS-TrafficTypeDiagnostic: BYAPR07MB6182:
X-Microsoft-Antispam-PRVS: <BYAPR07MB6182B9A01E84D86E4EE01183B0659@BYAPR07MB6182.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omfvoUHJ+DOPCV18CYQSZQlxnSWQYc4W+EbFGvK15hzQE2MbUsrufq9U+clOmKJuQ1QXW/fo8ukxMkm3kKexMP7CF5j5wmr77g74bR2YKaTlYvgpZ/C36MVFQpacKdzK2O7FUzuVbGXG5qW7Hg6Nkzljt4SuDBmOBsfuCEpT1Np+1uBuoI9w6/AFEqTFFSk+JRnxKxWAsGYK8wkVf/oMnt3k+08x4nDS9t0phakkyieT1Fg7hYEB1myFA89ZeCjZIx0k7q2PuqTFa3iVPHVNpU+V0AUiY/ujXXgG0F2yUq0PzhLWOXzseBkGDkqg+1IfGwHfHkewyV17nwAoq+M4MoM1IHUVfGi7xlBYuvUT6qRN1XMjhYrrdmw4TRhdkaNwMaYFL5rf0yX0MRx+niAM2FGRmlD39Dk0pEhUYo6vUJYOJ/2IkJFsWrugqXakGmCj04ltPBPInu0pVApfgoGu2NpfX6TKjKRpB4aTVsLMc3E3EoTJnQ8jHauC9NtOSMJuW1kUSnT1X8tzPpWBgIdFapdNxafg2WsqZQ2lOlIraBH+djrTRbSQA+j+vqtY6WfZarIH98OtsOkofkn+6eJHQhGcEkV1zYlIsnzTqV0U/eWF/eV6N0MOJ/7QHZJRfQ+9UIdwvJtxI+mUl29Ys2pxNu7sO7sSNn0Y7SqEUBO5ELdHz+Wbmx/ojRJl1DZXs69G0nVjlv6MWqfZGjpNGlcVXg==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(36092001)(46966006)(36840700001)(356005)(36906005)(5660300002)(6916009)(54906003)(8936002)(81166007)(6666004)(83380400001)(4326008)(82310400003)(42186006)(107886003)(336012)(186003)(82740400003)(47076005)(478600001)(426003)(2616005)(70206006)(36756003)(8676002)(26005)(86362001)(70586007)(2906002)(36860700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 10:27:57.4081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75792035-6c2e-4e1f-f867-08d8ed1d293c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6182
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_04:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=617 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220074
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
v3:
- removed extra blank line

v2:
- used dma_*_noncoherent() APIs
- changed the commit log

 drivers/usb/cdns3/cdns3-gadget.c | 29 +++++++++++++++++++++++------
 drivers/usb/cdns3/cdns3-gadget.h |  2 ++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 0b892a2..9b1bd41 100644
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
@@ -936,10 +945,17 @@ static int cdns3_prepare_aligned_request_buf(struct cdns3_request *priv_req)
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
 	priv_req->flags |= REQUEST_UNALIGNED;
 	trace_cdns3_prepare_aligned_request(priv_req);
 
@@ -3088,9 +3104,10 @@ static void cdns3_gadget_exit(struct cdns *cdns)
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

