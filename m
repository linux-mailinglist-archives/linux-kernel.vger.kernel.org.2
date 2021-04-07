Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F5B35642D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348953AbhDGGhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:37:25 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36798 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348904AbhDGGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:37:16 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1376NQ1I011060;
        Tue, 6 Apr 2021 23:37:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Ko7kB2ZfdIyg/zVnKzsZMGcR/zmMlJXQMyl3gJK6eDU=;
 b=bQaI7hihiZH8fULEj4cc3sXBtzVUhu7BMPPsYjcrsRF/VLG6kUZiB+3eeEN4FPIZxP+z
 RoXerAXS75rKWbUGVqAzvAxBcAIAyvhv2T65lssTzqid1Vl/JbSDzXehzRAcNlmLQAGm
 guxmdeN0IeiHGozqEvWSZ1krMSB12gNS4IPeJr25R0iVtKFA0qOxoOwtwIBGxYONemLh
 GgjakLTssXiQwJErqFS6MwMMpKqvsXa6xBujlSKjg1g7K4DHJb9cWiNJEEedH8ia8ok7
 fR4ZdxZIZ2LaFgLduBPxHOSdKYHSqioIxxnFonMfkUNf2gPAJPeWmbBCqrO3AyK15qgo qA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2053.outbound.protection.outlook.com [104.47.36.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37rva6a7h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 23:37:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSpBnRJOiq3eJUGDNUA00KgnMQR40PRZ4D/nJZsyOBeonWllRYMwgwFm4nNBqkCkXKGa0xBxnUOVgc5yZb5glVR1lCq2F0YAzhAwr0QVuw2Xn8Jt+j2tChfYH1QKFvxoZ4mfaYk6F3e+TzwgB0395IUKOMjNwAMLGew+IKFCxGNiifF7q7hevRmvQFNhog+4g5nScyHro24yisVFv6SMkDipK/sEaSQ9VcOQB0b8kZ/HkjQ2zZQe8uN5WV0W5TK+pLptUdjf3feXKkpOmI/rUdn87u+5wiM9hNwpnJRphRO6Uqc0LwlKgZNUA6CddilgsNo2LFY3QcGDuD38pu4FyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko7kB2ZfdIyg/zVnKzsZMGcR/zmMlJXQMyl3gJK6eDU=;
 b=TPchpKVK6nXE1r+dWL/7GzYbuVw+F12CCFebf6y7wwXKHbVc8MCaXA3dkXWgbSXvOwEA03zjuXumLrhnm19F2Y4GvQaMTu3Hpak3wYD9pdhT9SGjX6g9mLu7HXAPX//0dPiqPcIxdb2mCz1/ythik4Lvp385CrbPuou60hFeFjso7C7I92LSwN5N3G/eyUIpaI3DK/n/9ClnqIHl/7rVuhLsI6CTBf1cQcFC7N/Jpforq0JbPBqJ7yHG2y75FNd4Y5RRfSHtrVSo2sp69Mtm07BIbZ4Zh9UgIZdGNbBlBcDgmXkqze90sCXOt004VW/VH9ic5vSjcnTm2kp2Ij77SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko7kB2ZfdIyg/zVnKzsZMGcR/zmMlJXQMyl3gJK6eDU=;
 b=NBLqmrTZLwvPtjNpL+uSF83L3mzrPYO1HztwRW+AiDebzY3rQBdLCMm7zmzcDEfAMe694IWUMFeKYk4wz9IWdKBlhrbCcG+KnYJCX/8jk9CyifWMjSKujRQ9XMDaqOO75LCNsc7GOO+5Gu9fjsBHRZx2e3eWBNj4NZUZk6uIVIQ=
Received: from MWHPR15CA0032.namprd15.prod.outlook.com (2603:10b6:300:ad::18)
 by PH0PR07MB8575.namprd07.prod.outlook.com (2603:10b6:510:81::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 7 Apr
 2021 06:36:54 +0000
Received: from MW2NAM12FT023.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::9) by MWHPR15CA0032.outlook.office365.com
 (2603:10b6:300:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 06:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT023.mail.protection.outlook.com (10.13.180.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.8 via Frontend Transport; Wed, 7 Apr 2021 06:36:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 1376apii075622
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 6 Apr 2021 23:36:52 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Apr 2021 08:36:51 +0200
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 7 Apr 2021 08:36:50 +0200
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 1376aops044508;
        Wed, 7 Apr 2021 08:36:50 +0200
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 1376aoAa044478;
        Wed, 7 Apr 2021 08:36:50 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2] usb: cdnsp: Fixes issue with Configure Endpoint command
Date:   Wed, 7 Apr 2021 08:36:29 +0200
Message-ID: <20210407063629.43685-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6ac958a-f1a2-44b2-304b-08d8f98f885b
X-MS-TrafficTypeDiagnostic: PH0PR07MB8575:
X-Microsoft-Antispam-PRVS: <PH0PR07MB85755983E3E3266686411141DD759@PH0PR07MB8575.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /67dNh3sF3ouOvH0FkDHuS6LMdEM/f4f4sYX2IKXIvY7a5Ym21h2vzQHq3diKXvObP3NmDV6+FDJg0PIhmSUxPTbsCwd/Y3ThV3GBCK6pbh4zaa4s7FmDLPa0ad0SvK4N4GL84m6j6PkGWIc8p9i8w6u3xJqcdUS9NMQWrD87KlHinbdoj/t7lSxVu+MOLSJIgrU3LptUvWOiAXktB5xLh3762tb1CEt056nhcUgOpvXaFJOgBilcCqBhxQbe0oUSZ8Del/2mV+vEOfYDNVsEUeR9h7+RDtlbnP1IzLpqG2NIm/Mi9TWGl2CiTLbUiKHMUjSDN0dBl9kbd9uf3QuJtsuf+jlLONQ2c3CxaZIY5YlKSQLVSrZv5gMFI+QrWjEys32P6XMaAoP4gsG2wVoIPQnAKSxiDYtzDIYSuLL7GHUzPl+gGIUxBhNvLxU2BZNxMlvTlE6hj9CFS3v0LJjEaL5KA9rT1o6OD901l70QRam0r8z9SxJPuCm/bskUeIY6w66XqAE7rFSSSpRIhaNAWxnM+8nkIugthL8t72bX9maeev4XuVI5PiET4xkzcN84udQkcm3CRcu4RSD+/z8PM2K4WPclOPV7jToAs2okX04W8G/RwcHCwe3VZhNAu98p5Su/oG+87639O39o0Gu9wDZu3+fin11EC7wAloGiu3ZFzb1IdPRjrm2GhbuG0JUHDWcgTXMGVv7LG6lkZfgWA==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36092001)(46966006)(36840700001)(5660300002)(336012)(4326008)(6666004)(478600001)(316002)(47076005)(42186006)(36906005)(426003)(54906003)(26005)(186003)(2906002)(6916009)(1076003)(36860700001)(356005)(8676002)(8936002)(70586007)(107886003)(81166007)(82310400003)(70206006)(86362001)(83380400001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 06:36:53.5742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ac958a-f1a2-44b2-304b-08d8f98f885b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT023.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB8575
X-Proofpoint-GUID: Fvn6yYhzTNmgSa4CZdMlToX9zr6jqM4k
X-Proofpoint-ORIG-GUID: Fvn6yYhzTNmgSa4CZdMlToX9zr6jqM4k
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_03:2021-04-06,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=469 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Patch adds flag EP_UNCONFIGURED to detect whether endpoint was
unconfigured. This flag is set in cdnsp_reset_device after Reset Device
command. Among others this command disables all non control endpoints.
Flag is used in cdnsp_gadget_ep_disable to protect controller against
invoking Configure Endpoint command on disabled endpoint. Lack of this
protection in some cases caused that Configure Endpoint command completed
with Context State Error code completion.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>

---
Changelog:
v2:
- removed useless blank line
- changed the EP_UNCONFIGURED to limit changes in patch

 drivers/usb/cdns3/cdnsp-gadget.c | 17 ++++++++++++-----
 drivers/usb/cdns3/cdnsp-gadget.h |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index d7d4bdd57f46..56707b6b0f57 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -727,7 +727,7 @@ int cdnsp_reset_device(struct cdnsp_device *pdev)
 	 * are in Disabled state.
 	 */
 	for (i = 1; i < CDNSP_ENDPOINTS_NUM; ++i)
-		pdev->eps[i].ep_state |= EP_STOPPED;
+		pdev->eps[i].ep_state |= EP_STOPPED | EP_UNCONFIGURED;
 
 	trace_cdnsp_handle_cmd_reset_dev(slot_ctx);
 
@@ -942,6 +942,7 @@ static int cdnsp_gadget_ep_enable(struct usb_ep *ep,
 
 	pep = to_cdnsp_ep(ep);
 	pdev = pep->pdev;
+	pep->ep_state &= ~EP_UNCONFIGURED;
 
 	if (dev_WARN_ONCE(pdev->dev, pep->ep_state & EP_ENABLED,
 			  "%s is already enabled\n", pep->name))
@@ -1023,9 +1024,13 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
 		goto finish;
 	}
 
-	cdnsp_cmd_stop_ep(pdev, pep);
 	pep->ep_state |= EP_DIS_IN_RROGRESS;
-	cdnsp_cmd_flush_ep(pdev, pep);
+
+	/* Endpoint was unconfigured by Reset Device command. */
+	if (!(pep->ep_state & EP_UNCONFIGURED)) {
+		cdnsp_cmd_stop_ep(pdev, pep);
+		cdnsp_cmd_flush_ep(pdev, pep);
+	}
 
 	/* Remove all queued USB requests. */
 	while (!list_empty(&pep->pending_list)) {
@@ -1043,10 +1048,12 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
 
 	cdnsp_endpoint_zero(pdev, pep);
 
-	ret = cdnsp_update_eps_configuration(pdev, pep);
+	if (!(pep->ep_state & EP_UNCONFIGURED))
+		ret = cdnsp_update_eps_configuration(pdev, pep);
+
 	cdnsp_free_endpoint_rings(pdev, pep);
 
-	pep->ep_state &= ~EP_ENABLED;
+	pep->ep_state &= ~(EP_ENABLED | EP_UNCONFIGURED);
 	pep->ep_state |= EP_STOPPED;
 
 finish:
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
index 6bbb26548c04..783ca8ffde00 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -835,6 +835,7 @@ struct cdnsp_ep {
 #define EP_WEDGE		BIT(4)
 #define EP0_HALTED_STATUS	BIT(5)
 #define EP_HAS_STREAMS		BIT(6)
+#define EP_UNCONFIGURED		BIT(7)
 
 	bool skip;
 };
-- 
2.25.1

