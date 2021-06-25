Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835713B419B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhFYK16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:27:58 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54566 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231365AbhFYK1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:27:53 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PA9tv8012388;
        Fri, 25 Jun 2021 03:25:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=8cZg/SsZhKpQ51ep2tiQNOBeMk/oeRDRMLkDuyC6ah4=;
 b=HCl+Bfa1VrDQnQscst8U4LeeEtLO051M4U8s9UVAceBYzo3d0HBFGsRSc2CkU9QgUjOW
 0h67YLaQM2Odx1BKPI5G1f9bMKxNUvhNSfyPsjxWUswFZQ7HFlU/+2d6FmbfrdvhtsQB
 Mu9Kwfj8/xarV3vNtwyC06YxQqqy+NijqOCWlLNSZeya/lje7s3Aif2C9xTgda2UrNMX
 f8yZ0D/K29cA3UD5T2PN2zkXjRtuUq2DHHc/8nTOaQDnTnNK4/PTHMVl8vjgo2k/fk+q
 MXJjz2cyqmqAO+q93Cp1rg3SeFkPCNCkzJxCNquZX2tW9dy80ZOo8n2SQT4nmXyAETJF DQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 39d23c2p7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 03:25:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdBL7Ow3T+mDNKUFyJH220AXrEFkDQgrQje96lvfbEd83USXCQ8NNynULXhPYkhTACyfuCZWhZqDqWio5oDzm4S472P0yOy9ORvSUJc+Osrgv6reHdbfgUK0QTn0eDuiFtW9jn03EVvNc2BV8irD5ED/9+kaKy2EgN7DAgk5djxJ/7dAqD4SFnbHFCVd3drD1b3Sg4CNVYcZ7hDvvqWMVBB4YFDjDjHk2yuTR7g6XhfSUBdBOgKmpxV4oBnD7EJqhDexPeEFl9TT2pNX/Q/1/Jb9WKULEg98YQK7ouF5j/hQaWTTQRVytlPCghtCpGHdtr0MJbqVoeoCdHVptE83Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cZg/SsZhKpQ51ep2tiQNOBeMk/oeRDRMLkDuyC6ah4=;
 b=VAJ/fBhOg0bhFRoEeJgs1/na/WcfymFK7Zl8xA0ZJrUSGz6CQZ9q8jYGeysayEIhQ4lhn0N+gAFQO9xTbTIq4G92f0Mot3RjhawXF/Dk815hL3quAm6a/H8pC+CW+N5mS8ygMzeJun7vNUppnctCWAg25IVLX3ekfc0BQ11jqNA/5RCAHeFKp1L3YlPuNjQFnx92IgF2rEJeOVObS6Aj2oIPEgaAoho85KPNYtBps+9tBIW968kW7TTWx9ti+fIdHn2LwBC41P08t4/qT0pOj26cp1+K18++cV3BXNXMXklf+8gQf55MTL5CYvtF3Uws1gLQFcSjLgg11glucv7Qew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cZg/SsZhKpQ51ep2tiQNOBeMk/oeRDRMLkDuyC6ah4=;
 b=HV/Mk9xji+GTRCrW71c+4iyupiqYFvHxMWL6vCWMaAOpOBnPRBFsJQVeA5ZcVJT60xis2kwuKMPjUqw+qzVHbdC83BHN+z0/QbH4DjbXxP9AAdGCPQL0tnkmuIMI+YTGPMqiLHFFpOVt3Q+VhbsMSBofKiSoCMHIj9AT65jblPU=
Received: from DM6PR01CA0007.prod.exchangelabs.com (2603:10b6:5:296::12) by
 BYAPR07MB5173.namprd07.prod.outlook.com (2603:10b6:a03:6c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Fri, 25 Jun 2021 10:25:26 +0000
Received: from DM6NAM12FT049.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::11) by DM6PR01CA0007.outlook.office365.com
 (2603:10b6:5:296::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Fri, 25 Jun 2021 10:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT049.mail.protection.outlook.com (10.13.178.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.8 via Frontend Transport; Fri, 25 Jun 2021 10:25:24 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 15PAPMWv194411
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 03:25:23 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Jun 2021 12:25:21 +0200
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 25 Jun 2021 12:25:21 +0200
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 15PAPKEg026907;
        Fri, 25 Jun 2021 12:25:20 +0200
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 15PAPKf4026906;
        Fri, 25 Jun 2021 12:25:20 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: Fix incorrect supported maximum speed
Date:   Fri, 25 Jun 2021 12:25:02 +0200
Message-ID: <20210625102502.26336-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b9e7bda-c30f-4136-fa60-08d937c38b4a
X-MS-TrafficTypeDiagnostic: BYAPR07MB5173:
X-Microsoft-Antispam-PRVS: <BYAPR07MB5173DFB79404A592595E91FDDD069@BYAPR07MB5173.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fg51g5XpMrxvZQRaGIx+bWMyDmJicGEy0sgTInocKFjBL27sACP8plTHYAxJ5lCdXLaumYtqEguRkLzVoQbVP9G81Y+DSwcTmAOJZYOYoBnq+AIQBOhJ7pNJEwlQODyqOVsCGp8ErarmLYqdrqtLwn6I2PsHlONd3woNBWn29g1JOWnCploubZ26ZsOG6Ts47MlNJzwRPuQDz7CG8UpZe/AT8hTttzi0QuGfCcHXE143E79pz4cypvvHqULt5j5Zn9gMzpF0gmfJIVx+GOTgYyUKPnbgPiG7WSyK4zad86RaO5oK3VqzqhHto+C1hlGgCepPsqHcZouc9bM7UBKJIdOFXcxNVNAIVtst3gpxvfg/EleTMjJM6mCib/74PvTcUcXvYA/yZ++eTKO6QpjJ3sxc8Ph1nf1nZemLfANcqDbzCYWo3fiHloPQU4qNFiio7bmX+5X8Syr27n5HiLkPZSO3wUsiRUXBmXQO0GbIvVjeoJ1VKizHi26IwP06bZ+8r2lDC8FuaBOb+qsRcMQX8V293MFa88cYnHqF9zpwBLHRPtSeBzPVqAo523Z5qaRIOBlXiYCXMB4Pux/sb6ZA87wjFQdqMoBXifOOoNpVtLIoE2I15OmsHSQotxd/namLwbN4t6WY+newGVcWFBCcoHhHya5RjCb3Qd2b+WEpHj7d6RWoUUMgNoHRPHfFWQYaozYlYcSBErMvu9LmdnFPC6ElKJcsUAUul5k0SGqUa9cr55fwDLHsddT9iIffXbBAFYe2tx8CiLG99rxy+Y6QmA==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(36092001)(46966006)(36840700001)(83380400001)(1076003)(70206006)(42186006)(54906003)(107886003)(47076005)(26005)(86362001)(426003)(316002)(5660300002)(336012)(82740400003)(186003)(2906002)(36860700001)(4326008)(82310400003)(6916009)(478600001)(8936002)(8676002)(6666004)(81166007)(4744005)(356005)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 10:25:24.3623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9e7bda-c30f-4136-fa60-08d937c38b4a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT049.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5173
X-Proofpoint-GUID: lbPshzTZ-Prp8zQfAP_uHPo0WfwwzCTh
X-Proofpoint-ORIG-GUID: lbPshzTZ-Prp8zQfAP_uHPo0WfwwzCTh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_03:2021-06-25,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 mlxlogscore=651 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Driver had hardcoded in initialization maximum supported speed
to USB_SPEED_SUPER_PLUS but it should consider the speed
returned from usb_get_maximum_speed function.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 4f66ddaef63a..e258ca87b231 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1882,7 +1882,7 @@ static int __cdnsp_gadget_init(struct cdns *cdns)
 	pdev->gadget.name = "cdnsp-gadget";
 	pdev->gadget.speed = USB_SPEED_UNKNOWN;
 	pdev->gadget.sg_supported = 1;
-	pdev->gadget.max_speed = USB_SPEED_SUPER_PLUS;
+	pdev->gadget.max_speed = max_speed;
 	pdev->gadget.lpm_capable = 1;
 
 	pdev->setup_buf = kzalloc(CDNSP_EP0_SETUP_SIZE, GFP_KERNEL);
-- 
2.25.1

