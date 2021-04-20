Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5457A36517E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 06:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhDTE3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 00:29:20 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:31620 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229516AbhDTE3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 00:29:19 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13K4RDQk014804;
        Mon, 19 Apr 2021 21:28:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=+gMfYFIr8rguTQP25Yeh3wInr67GZwuuOyT6W45xpZY=;
 b=GTTybMTRy8QFJ84OPlR9az7ZJEw42CzmqMAFq07xL9JqDmK3p9DOISYqbuIH7dEfx6yB
 1oBmtv275kL7NhnoFh3/PBhnbJ5eZsdJXfLwe3wiEyjuEg9K1vW/SKm1ALZ4skG/8a9M
 cndCD2KDeigaeXCBLsO8m+FYAXP2GQpuQ4x9FxJ2IG7Blc3PVvLlGwTR9Iyow4tnfKaQ
 nBkF272YJWaeMVfzbBmkGh388eOEiZ9V8gvRd0NoYf1e0JE3hw3H51bStDgfBbE2Z+nr
 aMvtLbr7qRsLgFbeLzEvew1JP0D5x54aF02mRQNS+xllv2bErFk+6THpUQuPDtvNgB3m MQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by mx0a-0014ca01.pphosted.com with ESMTP id 381b2ca7fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 21:28:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwraDeAmNKuXFv9j/gjTNlJjpxdkzODx9bBTWa3r3WGxL4kie5ywtfkt88/ZennEWEX6eQomBWWlbVizAfB9QdzcQZ/3S6TCQi71eQ3XuOvaXtC9r0bzDrUg/gdAzzF3ViB19yOYBP9b+rk2rG8r5RbZMycmyQ+boWeoaE5ZoKCJFwYvpDWz2fzRq0ZYO1qkFVfjzzQ55IDdv0EOvYi4OcnPJRMJR8lyuMHXrLAr1g+n2w2JnO6g9hivMhEEYeVK0MDGVApzSZTfxwnDDNvBzUmev5dmEYWB+Wo+Wj2rbuJ14wFGMPPntC+iuccxzgJ9ggDcFd4u3ZvFVKuf+YyM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gMfYFIr8rguTQP25Yeh3wInr67GZwuuOyT6W45xpZY=;
 b=Ro9h6f8GtXH2AIGrrjIfofg0vRXuEL38sbYw0seag2hmUUaFBeatSY7Cx1WQorVUeBSoMo327Tn9UBlsn46A19NjW9lKRgc0skrHFQI+D+dp/mwNN5f2BVYfFZGXFaGNQuEQWKQBOkfjyAFEidMjBQ1/JMg9UvntSpRZ3+roFy+7TuGNzYTVRzy1Dkm1t3/i6wrVxA/Db20wsiyOD7E30ckIkGjzo5wYLULAyHTnNGCl8kw8VVPMWas2VbuA+hUaqjRuzSFfiQwirxZM1s1oAk0vZL/vWb/Xh23nBD0maD3NqgoP06uBFJEmWHnWss5wUcmE+RC98bwxtRPdJxtpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gMfYFIr8rguTQP25Yeh3wInr67GZwuuOyT6W45xpZY=;
 b=skUE5K/OfoaK+eORJsxEbfUY4tqm0Aa+uDGbDAuKR7Zf9gH6w7Qw+2KFuYKEN5uzSlQdMxpHIUYBsi2Euid9YTdvWZSryvDMqrDobOU6ZyhsazouzUEw8L7/mlKs78sIq34RSDApBJdsQFDSCqfhITEZkrub6W1ab1gCs0zL8ts=
Received: from BN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:408:ee::31)
 by BY5PR07MB6770.namprd07.prod.outlook.com (2603:10b6:a03:1ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 04:28:44 +0000
Received: from BN8NAM12FT035.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::eb) by BN0PR04CA0026.outlook.office365.com
 (2603:10b6:408:ee::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 04:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT035.mail.protection.outlook.com (10.13.182.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.7 via Frontend Transport; Tue, 20 Apr 2021 04:28:44 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 13K4Sf84001788
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 21:28:42 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 20 Apr 2021 06:28:28 +0200
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 20 Apr 2021 06:28:28 +0200
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 13K4SSKo035595;
        Tue, 20 Apr 2021 06:28:28 +0200
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 13K4SR4P035594;
        Tue, 20 Apr 2021 06:28:27 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 2/2] usb: cdnsp: Fix lack of removing request from pending list.
Date:   Tue, 20 Apr 2021 06:28:13 +0200
Message-ID: <20210420042813.34917-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a89cdded-007d-45b7-bee3-08d903b4c86f
X-MS-TrafficTypeDiagnostic: BY5PR07MB6770:
X-Microsoft-Antispam-PRVS: <BY5PR07MB6770A193D369A28B854F26CCDD489@BY5PR07MB6770.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HzBcUwWG2E6D03PLyQbauiV35l1schePQQwVEpouvuvFsykdKsbR6GMUO4OvFeP3cEq+Tyohl9jlSDS7mErF8tUrznIx7KDfrj0IfatvCQwGshGHcnN0K3nKrRV818iUNsSv1Tan8G76BlJbJeSWxpRVy7mxKPx8iXyFzpCayi2SFDiBCcPstI6EOebYbvrKNpQtF+/033C6o8mMbTALhq/awNaNkUC4XK09jXd5iwlsDMvH9preGORelaXD6t9DjCrzsUNFJPTa2nle49k1RGWp00iVptxuZ6w7k0N6r9P4rVA9kjx2gg1Mz9Noz/qqhU0c7gbJWpVgNBdcIELHo/CDuRfbS47Ux7XOWgatwxwtCz/AkWzjuoHwKkjpu7Dk5iE6a4xW/4RZhAOwgpF8rPIqs9AYX/uA2hBPAbzii5RKkG+wRDRQ3/LeqVyNXVtkY11T/1aSlV1KqRLDn1Q6kYG55jM4k01SAhjFBXihTYlMq7blLSzbZnLt5zXDoN6rFDGgSjjULm0KQPSlhNsq7iNuMOaXlb3RU/AVzWx8Kxwz+NVGc6tLZYqRgILQYpDWbNvQui93rwIFOTXnSXc78eQIjk92gr80l45pWMchiUb6NPBewWQPo4fFQz1p9bOk6bMjmdujj+PL843tXLO0mYD9wb2Kq2bS+RzHp3cXa3HGZv6Rn6bW8l2aa4/f7HK
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(36092001)(36840700001)(46966006)(186003)(86362001)(26005)(70206006)(54906003)(478600001)(36860700001)(6916009)(107886003)(2906002)(8936002)(47076005)(70586007)(7636003)(336012)(83380400001)(356005)(426003)(82740400003)(36906005)(4326008)(42186006)(82310400003)(316002)(1076003)(6666004)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 04:28:44.0019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a89cdded-007d-45b7-bee3-08d903b4c86f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT035.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6770
X-Proofpoint-GUID: RExV8-bdN2BaiLFKgVd9k_FVH5x2RxGK
X-Proofpoint-ORIG-GUID: RExV8-bdN2BaiLFKgVd9k_FVH5x2RxGK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_01:2021-04-19,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=765 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104200032
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Patch fixes lack of removing request from ep->pending_list on failure
of the stop endpoint command. Driver even after failing this command
must remove request from ep->pending_list.
Without this fix driver can stuck in cdnsp_gadget_ep_disable function
in loop:
        while (!list_empty(&pep->pending_list)) {
                preq = next_request(&pep->pending_list);
                cdnsp_ep_dequeue(pep, preq);
        }

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>

---
Changelog:
v2:
- removed blank space
- added "Fixes" tag

 drivers/usb/cdns3/cdnsp-gadget.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 56707b6b0f57..c083985e387b 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -422,17 +422,17 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
 int cdnsp_ep_dequeue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
 {
 	struct cdnsp_device *pdev = pep->pdev;
-	int ret;
+	int ret_stop = 0;
+	int ret_rem;
 
 	trace_cdnsp_request_dequeue(preq);
 
-	if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_RUNNING) {
-		ret = cdnsp_cmd_stop_ep(pdev, pep);
-		if (ret)
-			return ret;
-	}
+	if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_RUNNING)
+		ret_stop = cdnsp_cmd_stop_ep(pdev, pep);
+
+	ret_rem = cdnsp_remove_request(pdev, preq, pep);
 
-	return cdnsp_remove_request(pdev, preq, pep);
+	return ret_rem ? ret_rem : ret_stop;
 }
 
 static void cdnsp_zero_in_ctx(struct cdnsp_device *pdev)
-- 
2.25.1

