Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3742132D1FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbhCDLti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:49:38 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:35970 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237029AbhCDLtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:49:10 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124Bh3fM029251;
        Thu, 4 Mar 2021 03:48:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=proofpoint;
 bh=UkXjoKEoaVzCCUHn4x8DW/mGeN7Tt6I+eYBJINtHIDE=;
 b=J5ylxdm9F5VP6R1OPyV0qaX74X5q6G/0Wi2x+uAW3yA4TLvvkzEqP+7gYiOXshydZHWm
 rAsBKsTvvEkhJLKRtzG9BCyN9NsuEJ7GWy8+jPOkx4zob1ORP2C7CbTJZ9uGGzcqTpMT
 4syCdgc6PVqlCJ9+WgNWtWTUk9Oc4hYa7hTtrLjErtzjy9xda8W7PuPkvsfBwk0JjwUP
 r6dZKUN0EBKERre1ryAidrr/K9bsQViQaNS45ZWSOzd08f6W7fd+1TzkLb8gQdTkB9Wj
 Ay4R3+5XAi94beVIRduEpNTeqXcqsKA0UaWXbI3gG54FNmBq046qmcJfOiEH7nbhG4dw Sw== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by mx0a-0014ca01.pphosted.com with ESMTP id 372bvqknqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 03:48:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixIA6KvGQEiG1tQz9hui6J9SpNyR89yOU7VRVqHwcVK8k2utxvIbMDXvr6gfxBvXfWJYJeYmnGFUBN0UH2M/4WnBqeoo+L9wO3ukaERmOhQ6r+hURNI8bsAHVKqcGY1x2tNKVLXLGvcP6uTdsvOWafJk7kQI8htGV3f6olU46N79CayQhz6bjcw0e/CXdW3A33SQSELdygTCsz4Jox39SyDN8SRUp1s+ks+dUgRcL1CrmTdT/EoedtWwFENCUIREb8BYCxTU8c730rVg0t46bhOchDvZH9knc4YiP+3dGOApoKNwNnxAnJ0SlVXjOgzaToAJ40J9uQy4/uAx9n8yvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkXjoKEoaVzCCUHn4x8DW/mGeN7Tt6I+eYBJINtHIDE=;
 b=UCmmareOIMN+4ygJ3ifZj08H4QI6zZxJOCOmSYDykrbc8tHmWlm3VuCU7VU3T0BC4FXKExpdHAwEtYLCkfSb7HpZtUFh64FpcyM+JBWe9eajWzpx3YpjGqZUL0a9sHoPoq8NoMgyI6210Ym8op57bhVTRUBxX0QR9Mjk+zpio5Ozws/fhq8t+RB4u2TRSJaVuHVzK5+jdiAf8BU3KcvhWPLrezth8KZgf3lYawT390SneQQ4FabtZXssb/ney0wyd8kQBUoTHnWLTHk9/iIaMIrNoApZxhFjH344Bcr1F5M1rxnScA40Bs5wEJWWX2WkXh86sOzJnsKQBcFJFvIktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkXjoKEoaVzCCUHn4x8DW/mGeN7Tt6I+eYBJINtHIDE=;
 b=bvsJJrASlh7vmmZlVkzTK9Vor0yTakPAVPEwrsM8J4kaVbo2FqvPOCEk3dJcwBMzfhD8sbW2OY2xSj/8k1VXMAyavcEf4IRbkU52cb9/y1S1s+8u8jTKNCeH3MJf1TEDEfAhZD13fz6/4nEyHi1c6rlkkukhQz0qadtBA/f59QA=
Received: from BN6PR19CA0080.namprd19.prod.outlook.com (2603:10b6:404:133::18)
 by MWHPR0701MB3802.namprd07.prod.outlook.com (2603:10b6:301:79::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Thu, 4 Mar
 2021 11:48:20 +0000
Received: from BN8NAM12FT036.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::7) by BN6PR19CA0080.outlook.office365.com
 (2603:10b6:404:133::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 11:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; linuxfoundation.org; dkim=none (message not
 signed) header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT036.mail.protection.outlook.com (10.13.182.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Thu, 4 Mar 2021 11:48:20 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 124BmHpn026746
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 03:48:18 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 4 Mar 2021 12:48:16 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 4 Mar 2021 12:48:16 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 124BmGvl008470;
        Thu, 4 Mar 2021 12:48:16 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 124BmFhs008401;
        Thu, 4 Mar 2021 12:48:15 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <laurent.pinchart@ideasonboard.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: gadget: uvc: add bInterval checking for HS mode
Date:   Thu, 4 Mar 2021 11:45:15 +0100
Message-ID: <20210304104515.35933-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97bb7d0e-f59f-4816-7fa3-08d8df036872
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3802:
X-Microsoft-Antispam-PRVS: <MWHPR0701MB3802D59C41B4F1E71CC8EE92DD979@MWHPR0701MB3802.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i74mhc81W6WzaTd+CZRQLVfMorrOBSRZh4DeT0C4j5V09HwJbGdkM3DGnsSpqqvkTPPUSY4TK+7ALavAr0MKNXUMBLMsePXOtjht+KvxBUSTB8ZHf854vgA8HUCGuWqpMUg558irnjdKqrCsAgXRlfhrN/d0FoUYsy9bkTd2XaIrH6XjygUFsykYulOgUSXsEUCO64+y5MRb7xaWS2nFC3ligVWubSbQlxvm+5OlGqQkkoHpMWXIGcG0akME8gpXzgpI9IuH1SK9MBP0Walh6/JjU0g/oQun6Q/R46YdHP1aWatN6wHT190hArISpHjx/LFrdG1Mm3sQ+2m6ddayikYWrAnjqktIwMYc/2Ocgsa9S8gA49OyTH27nTj1rtMkV08g284ev91Q0FLjXmf48SprCwF84KA5Opd8fyL4n6wAyf2wr9Oh/PKGFfPowOsBwhmC/PVpvnHYAdlKkQ8jqZx8M+XldTzN+myh2SSMXa2p7HhxkKDdxYNDvgkydr6XmP+Weh5+eVBL88KJR7p6XNzJh7t80BnTeZ34/fs36B7DG6O030pyE+36/QKejBUKTbaT/Pjej6J1oOBPukfrjYrAxHiF3fFHIQYYJVddsE10GJeKxbu842tfCQoTrQ1hwinUPHHN/9yI20i8Bqk6bbcdPTtj1F/8bx8USVGpAa/8hHDiOpFKP38Sb2uAamXT
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(36092001)(46966006)(36840700001)(42186006)(47076005)(70586007)(1076003)(107886003)(336012)(54906003)(8676002)(426003)(82310400003)(4326008)(82740400003)(26005)(36906005)(110136005)(70206006)(186003)(478600001)(316002)(356005)(86362001)(5660300002)(7636003)(8936002)(36860700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 11:48:20.1836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bb7d0e-f59f-4816-7fa3-08d8df036872
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT036.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3802
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_03:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=656 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1011 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Patch adds extra checking for bInterval passed by configfs.
The 5.6.4 chapter of USB Specification (rev. 2.0) say:
"A high-bandwidth endpoint must specify a period of 1x125 µs
(i.e., a bInterval value of 1)."

The issue was observed during testing UVC class on CV.
I treat this change as improvement because we can control
bInterval by configfs.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/gadget/function/f_uvc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 44b4352a2676..5d62720bb9e1 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -631,6 +631,12 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 		cpu_to_le16(min(opts->streaming_maxpacket, 1023U));
 	uvc_fs_streaming_ep.bInterval = opts->streaming_interval;
 
+	/* A high-bandwidth endpoint must specify a bInterval value of 1 */
+	if (max_packet_mult > 1)
+		uvc_hs_streaming_ep.bInterval = 1;
+	else
+		uvc_hs_streaming_ep.bInterval = opts->streaming_interval;
+
 	uvc_hs_streaming_ep.wMaxPacketSize =
 		cpu_to_le16(max_packet_size | ((max_packet_mult - 1) << 11));
 	uvc_hs_streaming_ep.bInterval = opts->streaming_interval;
-- 
2.25.1

