Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14EE32E123
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 06:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCEFLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 00:11:25 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:50106 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229446AbhCEFLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 00:11:23 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125536IM018992;
        Thu, 4 Mar 2021 21:11:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=MhRYpAqN37kztJ4LW/ZOnXAODaQTKYQMouHaujVcppk=;
 b=X90biaOBKbwLqPx4XQGy+j0FUiGpv42gRl4+TGmcmwxj9l3o+Lhvg61V3ee7GsKvLBvX
 YY164IXQTzWPpltopvW8gtGGQQ/SsP54a0UwPtn7E+rrdS+p2nf8HUYttbgH1osZJUbc
 y+OC2WrN92VmBAeYxtfU4G1W0VgSQIIBp8VTE8U+zPMI9Fp5OFBW0YYE9T8BtFmVpLUj
 q1B0AF9T0g//v+ZYA52CCCB0qGWxQMoU/EeBJUg0G9dJVbq0bJPGSMdbPx9ciBbCwzLw
 Ag9pec6gwtUbjw1UAXhNK6qwetRI9GQqjggJzGDphzb3z+3v0yy7G+ZRypNYkyC5C8Va 7w== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 372bvqpvqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 21:11:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXDPxNBRuN7TP96RZFEnSBxs+UF6XzJSgREno5lSPeaGTG64Aw87f00mu598BMMG5gDNrxibApCNV2QjGBNw99fe8+t6NrMpWOTmFc7sfiGN0Ys6XXRNxERTanXcMAZTXbk9mpzl2pW+iYIJ6gSya+qhw7zEdwKrZ0TeaLf0YTtdOujiYLQsrX3kqL533sN3TpwZILWI0o40GuSm5psyaJANIQAHwe5rInN73ASj3NwXiN+1zPFYOfpl0OWmDSikZebkRzhQJAdlyj4zvXihPCx7M9q51vop1sF+E8I04jbbxhA1p2XL2wqAvhEwr+DhPHuIuz23X9fpUQzt085uTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhRYpAqN37kztJ4LW/ZOnXAODaQTKYQMouHaujVcppk=;
 b=mygLvw8gp50tY7OahzvQ0p8v2fdjaPkvQux9gH+I+kp/Xi5eIZL1K1PQjVbV858Ajr765+7uz5kBxJ8/C/ZsSlpDebVBrePd3kIWjAtvQjdY2GxlbuAMHv6NAVcc1CzEUxz++k69Ax7MSR1D17nKLpieUTttdYP6rsRaioe6VzDXGNZQpr+Hejc7jVNVc4W1rlCTpJcHEgS/wcWf8ocEbd2b8knBFcZAi85ASNJqijlLEANleeLlnbJihmW4xqv8qt8vfKu0zNxcvKpNwV2t0pm33aZCUSNA9o6ZgzoS4PmnrQpg9dhC46RHGcAx0vgJN4tkCFXsjNSUHyvnLUZzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhRYpAqN37kztJ4LW/ZOnXAODaQTKYQMouHaujVcppk=;
 b=J6F6IL/QNH7BIpXgtjBkDSOQBrfWN8aXJ2g9YO1PRs08YCePFoq2Yp+jPQxAKUWJ9wUrrDethzUpi2sK4BFaqfjEFYnxdK8EccNyb7Q60qzPIOBWbH1YzetoRl1oYJRNTgLh7H8u/zIBbhpiorwktFzYddaknVkwfjXG2pB/lic=
Received: from DM5PR20CA0010.namprd20.prod.outlook.com (2603:10b6:3:93::20) by
 BL0PR07MB8113.namprd07.prod.outlook.com (2603:10b6:208:1c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 05:11:19 +0000
Received: from DM6NAM12FT025.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::f0) by DM5PR20CA0010.outlook.office365.com
 (2603:10b6:3:93::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 05:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT025.mail.protection.outlook.com (10.13.179.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Fri, 5 Mar 2021 05:11:18 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 1255BGhp031009
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 21:11:17 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 5 Mar 2021 06:11:16 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 5 Mar 2021 06:11:15 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 1255BFtF032405;
        Fri, 5 Mar 2021 06:11:15 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 1255BFck032404;
        Fri, 5 Mar 2021 06:11:15 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: Fixes incorrect value in ISOC TRB
Date:   Fri, 5 Mar 2021 06:10:59 +0100
Message-ID: <20210305051059.31623-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7ae45be-99e6-4073-209a-08d8df951c4a
X-MS-TrafficTypeDiagnostic: BL0PR07MB8113:
X-Microsoft-Antispam-PRVS: <BL0PR07MB811375A8C45155C3D51C7953DD969@BL0PR07MB8113.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TlbYI0Y04B4HH+hftRGZE1KAgvC1YDgDEoVMvOD4ztBr1NKs3JGTQFQVE1uxyOtLXHrdXOZVzzxTZ0HQcgPEyOUnuUxH52Tfi9obLkRWL9nvI0mA1vsl4UveePSh65GNhhEVZf2FXhwdV1AfORJ2YOHrcZ27rIuM91HBZIzQVL3721vKWWStWX2ng4Yn0sZHOk8h3CImM+rOTqdiP45yE2VWi5HzKJlDaXXyEL9CCiJTadGW5kstHapRI8lrIfilTGEeKIXGFNpWVPGQ0wiDq0fCPKgOAz2glJI+m7KxBS+6/O70CcoAGgYrPh3LFxMsy/pVOsXMxxgyFF0OazKD8yE+Cdwl4YusS63J8J8JXnKUEfnUOQ8w3zhqG9MB25kemtvGA6NaQYUugd6fvw8puIE9Rm/a7WO7Jc5p/KCbq1+ECKLPC6izEJ/pKjCNiEF3bZ6bxHJTggLScUrNewwLqDaDpI7kNFijsOeJKyXRE1FROg+sgWsWcKGnin/tb3cw2irzpuDic5blAm8++DqUPABK2yemCmWxG7YKMm/h6ls1SP9YrcTiwiClJ0iKx5SNnTjj/MXRr/0R6TWWuMRwUfBytb7qIc1RWLqxjkj1VMq2j1BjegRzLy953demElW+RbR6X+yTLTNNcnvNj3b3U7DVEwWH07rWbIJrZ5mcoB2CLYxYPwF69joUqKacHJhg
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(36092001)(36840700001)(46966006)(86362001)(316002)(42186006)(1076003)(107886003)(8676002)(426003)(336012)(83380400001)(356005)(5660300002)(7636003)(186003)(36906005)(36860700001)(82740400003)(70206006)(4326008)(70586007)(6666004)(54906003)(8936002)(82310400003)(26005)(2906002)(47076005)(6916009)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 05:11:18.9587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ae45be-99e6-4073-209a-08d8df951c4a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT025.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB8113
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_03:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=690 bulkscore=0 adultscore=1 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050023
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

The value "start_cycle ? 0 : 1" in assignment caused
implicit truncation whole value to 1 byte.
To fix the issue, an explicit casting has been added.

Fixes: commit 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index f9170d177a89..d35bc4490216 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -2197,7 +2197,7 @@ static int cdnsp_queue_isoc_tx(struct cdnsp_device *pdev,
 	 * inverted in the first TDs isoc TRB.
 	 */
 	field = TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
-		start_cycle ? 0 : 1 | TRB_SIA | TRB_TBC(burst_count);
+		(u32)(start_cycle ? 0 : 1) | TRB_SIA | TRB_TBC(burst_count);
 
 	/* Fill the rest of the TRB fields, and remaining normal TRBs. */
 	for (i = 0; i < trbs_per_td; i++) {
-- 
2.25.1

