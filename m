Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D4630EF93
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhBDJWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:22:38 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37550 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234806AbhBDJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:22:20 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1149IKm3009430;
        Thu, 4 Feb 2021 01:21:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=etWpa1ptn6l8pQTOWT17yct2bDxzkO9EzxSBKBsYAvE=;
 b=XY8XptS38QY5fL2MlnihOhfyyCQI8Zn7DaBi9RHMN99Ea2Bgn0+xG9hyQ5riAZ8w7Q3L
 tsJaOg0/Y1xvk0QeW09uHbwrs0+Oi4GdA1D0O9jj7AYtYEXtpFGsV1sXLW71jIevvkWq
 vq9Zo+cI9WvIr4eGxvA57S6ZLIBmACz/a+zNFyMF0/TN5OyBn667WWRWJnSuo/t5geLI
 R5HzPqfuVYqSJmJjfQR1E/uZoFePNusdCHnMJMqFlt4ytezIfh8Z46svDJT6QXX0CDcu
 n1gtuW11Vu/s98Xw/GiomDqHoRXLYXoI/eiajSYWzwU7AAopmv4jytj9rL8SxubwxlKa qQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-0014ca01.pphosted.com with ESMTP id 36fgekwu4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 01:21:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCXXEdE1968toS4BzIi/bYfAz50Qmz26u3H+SkeFnX++YwU2JtFmvxQ2aoRQ3+XVZf6CVCWfk5w9Dbu8udn+mSSBGoXUhtybPt4Guf1UmUU+tMcsYVgaNQi4x/h1DE68bBj40NSumtUL40pYPpmknaBPxjNs16LX/K96X5eGkQpi7/PP2oHjEtsc244VixsZS2Ua1jBl8fhypRKmeiQCxO/p1ZWI6O93xtRO9OsQH2UV1Eek1frtoIO6MP+rE1NxCmQJBnO3WrwyUGvXyk9Fq6pdlGUy3VYxeQIvYWa/KhzA6ZDBisaUgJ9m5T6EhNiGBC7E3FhPnB89m2FMNAtscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etWpa1ptn6l8pQTOWT17yct2bDxzkO9EzxSBKBsYAvE=;
 b=XtbXVxkGABL1zTvFv6AtSqqUbDXbCHkf1TYQ3ep7bZjEIvwAbl7yqjP53Sgt4DSIsvfgl1+SbtWAmrJwhNva1+8NiKBztrnFWE1zKVKOhgg17pxvXitI9Gbt7NJ0vmqIEVnKdTzdR9WYO0JD9kFYJs7h09+v9p3n/FURCdq1+nIOs0oNx9EBJYb5icdcaueRLiDBwUVb7r2tmMwei4uTyGrs7Y4K8KYU6IRPlrVxO1O9OMqXk2BEVVbMaUzVQ+EMSPo2zYTH7TXtCx1V+6TI0QNu9wAyj39K12TnwG1UA1bbAHdLank3M5GQ1FBAE4KerRS9twvjz0VrPQgL/CV61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=canonical.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etWpa1ptn6l8pQTOWT17yct2bDxzkO9EzxSBKBsYAvE=;
 b=eB+ti72Lzs9TY+GmqRJjQAmEfTK5GIz4DF6fjhq4VwUZkEkrAA0eGljOtI+/7NL8ARopiFfdtoAG/NO00yh8Je8xFY+lYv5izU7c54i+WK2Bey/htr63hkztyeaVFcvu5DVcw3tIj2+BwORykA+L6+T0CKU+W+7dxjoMg2A7j9A=
Received: from DM5PR15CA0050.namprd15.prod.outlook.com (2603:10b6:3:ae::12) by
 BL0PR07MB5233.namprd07.prod.outlook.com (2603:10b6:208:4c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.24; Thu, 4 Feb 2021 09:21:24 +0000
Received: from DM6NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::d5) by DM5PR15CA0050.outlook.office365.com
 (2603:10b6:3:ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend
 Transport; Thu, 4 Feb 2021 09:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT062.mail.protection.outlook.com (10.13.178.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.6 via Frontend Transport; Thu, 4 Feb 2021 09:21:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1149LLCF015410
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 01:21:22 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 4 Feb 2021 10:21:21 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 4 Feb 2021 10:21:21 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1149LKSN000326;
        Thu, 4 Feb 2021 10:21:20 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1149LKYl000325;
        Thu, 4 Feb 2021 10:21:20 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <colin.king@canonical.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <kurahul@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: Removes some useless trace events
Date:   Thu, 4 Feb 2021 10:20:35 +0100
Message-ID: <20210204092035.32424-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da203d79-8646-4f0f-79ae-08d8c8ee3dfe
X-MS-TrafficTypeDiagnostic: BL0PR07MB5233:
X-Microsoft-Antispam-PRVS: <BL0PR07MB52338B61A1BDF6E71746CCAFDDB39@BL0PR07MB5233.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QJtDC6fJQeL5PSVLXH9Uv04Qvqp99z4Ojd5vYp1feKGrJ+zUH7yC0+jNArJfLN5/2n4xrKbXeacz5yPPGSKT/efCBmsU1x1tj7HzL1Pi0NLm7/iuOs/2JTvhjKh6a95bB9guG/35t4WGHG+ciiswinPyfkeRiroRCEIwFj2sKTfr1eA/Zs7weteH5MfWcZ4SGbaMtyYRzP092aTfbcsV2k+f1oUqdyXfDhz4aD8FZIv2CPbR20sPQLmLE2CpSmHItkHu9tjmWkdSyK1iWWuvHndDVdATy/Y3d74sadBbfBszZvABU2BQbZVIwKiIk4/KJAje2cTTvCVy681ubZ9YY4lwHdBSi6bhdaeoBDN3rG52ItMdxE/v2XliZqRaTdp0yaVpqdaN6xqJxJM497UFC7ILY+WEesFufyJwIwAW64fWEL8FEF0ObkHO4je2VaD88/VKL2pqaY2aRWdtq86bMvBAvkQ79y7oLaTe+GezKCecF4prxWI3Ue1g46Z3mMhx7wr7/4yJ/wE6hgMydjDu3vlz1m8omnCd6SdOPAPDmL75PflbX4sq43VFOKwztDGUy9gU7cUSNE2zWbbxBnJE28elhW8UOHkzWYVVvA1j8bUiZiK3fII5aAUmKXe/OUpmtZSuyP5/eEM1micH3rh+n8Jq76FL4NUOttK4LYPjgBGLevRfE4n/+tidoqvx+nxQ01ClM6Rt5k5WPKLNom4lg==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36092001)(36840700001)(46966006)(82740400003)(83380400001)(26005)(5660300002)(34020700004)(6916009)(107886003)(36906005)(426003)(478600001)(2616005)(1076003)(6666004)(82310400003)(36860700001)(336012)(2906002)(70206006)(316002)(54906003)(186003)(47076005)(4326008)(8936002)(7636003)(86362001)(36756003)(356005)(70586007)(42186006)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 09:21:23.9714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da203d79-8646-4f0f-79ae-08d8c8ee3dfe
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT062.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5233
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_05:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch removes some useless trace events that can
be replaced by ftrace.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-ep0.c    |  5 -----
 drivers/usb/cdns3/cdnsp-gadget.c |  2 --
 drivers/usb/cdns3/cdnsp-ring.c   |  1 -
 drivers/usb/cdns3/cdnsp-trace.h  | 10 ----------
 4 files changed, 18 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.c
index e2b1bcb3f80e..9b8325f82499 100644
--- a/drivers/usb/cdns3/cdnsp-ep0.c
+++ b/drivers/usb/cdns3/cdnsp-ep0.c
@@ -24,13 +24,11 @@ static void cdnsp_ep0_stall(struct cdnsp_device *pdev)
 	preq = next_request(&pep->pending_list);
 
 	if (pdev->three_stage_setup) {
-		trace_cdnsp_ep0_data_stage("send stall");
 		cdnsp_halt_endpoint(pdev, pep, true);
 
 		if (preq)
 			cdnsp_gadget_giveback(pep, preq, -ECONNRESET);
 	} else {
-		trace_cdnsp_ep0_status_stage("send stall");
 		pep->ep_state |= EP0_HALTED_STATUS;
 
 		if (preq)
@@ -45,8 +43,6 @@ static int cdnsp_ep0_delegate_req(struct cdnsp_device *pdev,
 {
 	int ret;
 
-	trace_cdnsp_ep0_request("delagete");
-
 	spin_unlock(&pdev->lock);
 	ret = pdev->gadget_driver->setup(&pdev->gadget, ctrl);
 	spin_lock(&pdev->lock);
@@ -130,7 +126,6 @@ static int cdnsp_ep0_set_address(struct cdnsp_device *pdev,
 
 int cdnsp_status_stage(struct cdnsp_device *pdev)
 {
-	trace_cdnsp_ep0_status_stage("preparing");
 	pdev->ep0_stage = CDNSP_STATUS_STAGE;
 	pdev->ep0_preq.request.length = 0;
 
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index f28f1508f049..f2ebbacd932e 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -237,8 +237,6 @@ static int cdnsp_start(struct cdnsp_device *pdev)
 	temp |= (CMD_R_S | CMD_DEVEN);
 	writel(temp, &pdev->op_regs->command);
 
-	trace_cdnsp_init("Turn on controller");
-
 	pdev->cdnsp_state = 0;
 
 	/*
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index e15e13ba27dc..f9170d177a89 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -266,7 +266,6 @@ static void cdnsp_force_l0_go(struct cdnsp_device *pdev)
 /* Ring the doorbell after placing a command on the ring. */
 void cdnsp_ring_cmd_db(struct cdnsp_device *pdev)
 {
-	trace_cdnsp_cmd_drbl("Ding Dong");
 	writel(DB_VALUE_CMD, &pdev->dba->cmd_db);
 }
 
diff --git a/drivers/usb/cdns3/cdnsp-trace.h b/drivers/usb/cdns3/cdnsp-trace.h
index a9de1daadf07..5aa88ca012de 100644
--- a/drivers/usb/cdns3/cdnsp-trace.h
+++ b/drivers/usb/cdns3/cdnsp-trace.h
@@ -158,11 +158,6 @@ DEFINE_EVENT(cdnsp_log_simple, cdnsp_slot_id,
 	TP_ARGS(msg)
 );
 
-DEFINE_EVENT(cdnsp_log_simple, cdnsp_cmd_drbl,
-	TP_PROTO(char *msg),
-	TP_ARGS(msg)
-);
-
 DEFINE_EVENT(cdnsp_log_simple, cdnsp_no_room_on_ring,
 	TP_PROTO(char *msg),
 	TP_ARGS(msg)
@@ -173,11 +168,6 @@ DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_status_stage,
 	TP_ARGS(msg)
 );
 
-DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_data_stage,
-	TP_PROTO(char *msg),
-	TP_ARGS(msg)
-);
-
 DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_request,
 	TP_PROTO(char *msg),
 	TP_ARGS(msg)
-- 
2.25.1

