Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB43363D09
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbhDSHyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:54:12 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49956 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238062AbhDSHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:54:09 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13J7n8UX026617;
        Mon, 19 Apr 2021 00:53:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=30gi1R0tQ/mAhtfyBqyVfpEagfZThdq9G3wsQbKI2aw=;
 b=jV7yZPZtSrVkxoaH1ZVOxl/LFgIPq067qw+dcuRbn/+peF7rSaXCZrvXqBZI6rS2M5iX
 4c5TQ34mpb0ZbuQcEMZWxlTD6HCSuPTMpeiIlqVNvjFt6RyRvWl6W/+oyFQGJNTj1VEJ
 2cMArN8nRNpyojDGTy7IZ3iRLp9ip2DtxAmTYrbNhSOJkjo+aWFR1ZuJ2rMzNlspb0l0
 RnJP5iQSvw2UWOJEGSe1/k2xosmB6v+5LZOsqJjVTOaXU8fKEkyp8XS06lgPxxc+F1lk
 fMQ5tXbwtblHyZZ5AbL85sy8itAVgY4Om1ye5yf9yoi5S4ZPPh1nu2zk0X/fFl5oKRCX 4A== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37yu91mf83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 00:53:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edwH9lCcTEdf2ZowDbnsBHTAhPJV+N3zVzwPYIm+cVopffybLWYzSz8WdjADjjmIUxF9mPZxnhg/4fKpvs+bO2lud5AB8zKvZkp17ypqRhv6QiWPrJLk0AXZxMQ2VrWPh7KRztGU6VhSeEq1A4AQ8KIOwpY+qNDFWsaJHoxXdtQkv98ojZejB7aWXjNjX+I8XbMbpn5UE0fQmjl4PvsIwcO6TDc4HyNMhc1iOQJWjDasXs9cVE1+7WlPJ85ktW078M6IQF802FUx1D75DRkfqvaaS/MzeTD9S3X6C9JMzvW/1omJywms8K0EEw2bYTVhEybbpVI5+dUIXzbLkL8t3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30gi1R0tQ/mAhtfyBqyVfpEagfZThdq9G3wsQbKI2aw=;
 b=jrpFu7NngK8IALVHqYfdfm+xAnKKNeRHbJCbG8bK/0RRcQTq71zR4cacBBojN8SuASsi5E1UpxHDiqP3h+ICY7hmLLtsXknwVeCOxFxBvNICnMwzkqAWglKoQc09PQpH4MFTeA6oaQD9DyAMXl7atryMENYeNUXTzhm/0A0F15jC12t0kt/oMqyQMHXIv0dkFANeUfPTviCaGEW+yBOKWCgmSvX5N7iErhvrrlxDkLmLru4ewgTqXPJxJewUJp9ObMs+T3qZiujLEX8eVqoeFM9/lvF64xXMSJgi/AP8676lj24yG0CHLK3bfQlfgyMUv3Y8VG4ZSO3BB1rfX0CN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30gi1R0tQ/mAhtfyBqyVfpEagfZThdq9G3wsQbKI2aw=;
 b=iYAfWmP1sEeDJwDnRvmU3j1401Bk9d5TbrgyTUprfpXQWwrD6bYromUZfTyb/3N0rmcuzEY0DfLZ2JYT33Q1fiW5TdQWE1EZwZNUk3ddbp3zhM4ATooVzqf7KGeYKMdLSKZLmNwyz/u3FT3QhHUc0FOXlxg3+sJaC4XsKYWhsfE=
Received: from MW3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:303:2b::35)
 by DM6PR07MB5162.namprd07.prod.outlook.com (2603:10b6:5:50::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 07:53:35 +0000
Received: from MW2NAM12FT026.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::e7) by MW3PR05CA0030.outlook.office365.com
 (2603:10b6:303:2b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend
 Transport; Mon, 19 Apr 2021 07:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT026.mail.protection.outlook.com (10.13.180.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.7 via Frontend Transport; Mon, 19 Apr 2021 07:53:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 13J7rX1G009646
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 00:53:34 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Apr 2021 09:53:33 +0200
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 19 Apr 2021 09:53:32 +0200
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 13J7rWNF035370;
        Mon, 19 Apr 2021 09:53:32 +0200
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 13J7rWBQ035324;
        Mon, 19 Apr 2021 09:53:32 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 2/2] usb: cdnsp: Fix lack of removing request from pending list.
Date:   Mon, 19 Apr 2021 09:53:11 +0200
Message-ID: <20210419075311.34430-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deb8c46b-fd07-4042-fb50-08d903083c53
X-MS-TrafficTypeDiagnostic: DM6PR07MB5162:
X-Microsoft-Antispam-PRVS: <DM6PR07MB5162383EAEA3984699116F8BDD499@DM6PR07MB5162.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Aogn4B34Zgl+dELDSwIJAbldjFPO3K119qp3MeC8jXxjc6wFyRgUvsn2RW7MXW19k2kwgIi4o601nbcFC/Ia9tApIk5vJEqCGwjI+jT+ogBXf6gedmuemksSWOFBm69njfAfbDfBIvOu6YgPqxpy25tEmBofPWeTSDcEJH0QWtTOCx+nqb2gs49jgDDGYRJ/BgdxEWb0tA05JV4SjHj2wc8xWq69xobsqE8n35GQUmjlPvrvBLE2OmXtei36yJvyLaoCfs5OkHXTK1ea1vVhr/agYBROgcJRx6F7+ZOHEu2mNAehLBuxmXo78qmg/3Z8R/vAZkqigK/S/kDx8nbiyUWMIdhIL9BDeDsyq59M9K8SzFcJAm8K6ONdyFLSFYDNMWwDGvtHnk6K8duUFfIO1i18XTkp0EzVXOjteMS+NUGPR973JYdRZioP3w/WLHrVwV800IODx7rthiFYqw+sZV9wCgcu6oVe+a4ko1BLlKt0rYKXCmcZFMob/wY5TZMImyVac5u6c/e/8SG+5dNk15yCXfDowxk+5YTzkXogBA2PRs7q7vFkC9qo1v+/HCkbHleuzuSr/uKrYvOT0n0lFnutZlPxdYGbgu5kJfvgedstQeCclxxUadyAmHh5i8p9gF+XFjf8DSr3yuiJuStCmIJQghaA8soP7L+PqyDPk7fXdLnivbCi+7C24nxreKt
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(36092001)(36840700001)(46966006)(1076003)(42186006)(6916009)(82740400003)(2906002)(336012)(107886003)(26005)(316002)(8936002)(186003)(82310400003)(36860700001)(356005)(8676002)(70586007)(36906005)(478600001)(426003)(86362001)(7636003)(83380400001)(70206006)(54906003)(5660300002)(47076005)(6666004)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 07:53:35.5874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb8c46b-fd07-4042-fb50-08d903083c53
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT026.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5162
X-Proofpoint-GUID: eFjLEi_juI9puTMxFXvdA75dAd7bPxJk
X-Proofpoint-ORIG-GUID: eFjLEi_juI9puTMxFXvdA75dAd7bPxJk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_02:2021-04-16,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 mlxlogscore=841 impostorscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104190053
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

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 6182c9bc65de..1ca8c1777a5c 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -424,17 +424,17 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
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
+	ret_rem =  cdnsp_remove_request(pdev, preq, pep);
 
-	return cdnsp_remove_request(pdev, preq, pep);
+	return ret_rem ? ret_rem : ret_stop;
 }
 
 static void cdnsp_zero_in_ctx(struct cdnsp_device *pdev)
-- 
2.25.1

