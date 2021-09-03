Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6FE3FF9C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbhICFC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:02:29 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48978 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233264AbhICFCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:20 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 182NR3No011810;
        Thu, 2 Sep 2021 22:01:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=cYcNe0MfFHYDxfY8ctq1GH6uwCXkv5WhjaERsTlaKjM=;
 b=hTPP2cHzwiGc7Y2alsWbH5sPc2TQC4+zfI1fjTvZIvhFESc4GjUHGfcacBSDhhHlaytt
 pVlah6qJ9YiWWRbqZ98/Kx1lqm64a3aP6Qx5sALWCMeFllTNaRTD9sCsdCXvIe7UU6pO
 uCFKuXetUlVPvQmVxFoZ3rufMHU95BlBM6vDZzar6V63THZmX0ONC/AC8eWXl7QTTtSa
 p6TPgWiYZaZvVm0VRgH8BQ4DRPxfbvgdbVCPyyJksNnyxCv5Tg3dokKEcdHfTlje3H8d
 vBWocBtuyL1hhs3Sb+mDZ70H38ELwcKFwwnWiM/VX1rDkpDT8BBiF+QvhW/Sr1UIT/Iz Ew== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3au8a18u4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2nKUfkgYcWQ/TvxV5FWzI1ZsXUWfL3hxtnLRi3VjI+sY8Slc/pJp1SLy0LtgI2Wjb+OMz27CHOxsvg76eB4za6fPlJ4JO1RZ+p1j8CJsxrs6nh9HGZzLfCaWdc1UPcitZxpY5rDDCrraMM4TfZPPV3y6RG1gTcofwR9aI5YmLgQiLdhjafVLpATy939kBRYu2kKZM89pwW3oj10JYbbnhyFvqhq5jX4rL8psUT69Uho4zyrLdwKo/xh50Hyp97rl3JeyASXpYsg3dSOutyy9+Cy3KLBuhuERB6sjfhxck34Jtnv1TeZ8DIfAOIvdWLl8U7YfFfeYeB16MVr/fqJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cYcNe0MfFHYDxfY8ctq1GH6uwCXkv5WhjaERsTlaKjM=;
 b=RyblkE5iQpuEeChrlfueX+hU9lKL72caNGoXqLB0jyKIoHghxRN30VWy/nUucjSq+QlXnSuTBModHMCKdxqdG25by4uBFgHoQFndtciLK6PwpgA0UqBgVZ+F3UYKEazpBH5xMhryq2gtvZrNA88GVJNxzqcRXqZK0vEt+JIP6xwO8gjdrOEx4HFg1xzoR1eUSDfWTjBpYekV51WDUZ5DPDv96d4S3+wZnnJxlvsRdNvLCluHS8rUdZApYOP7+dYjsbu21AuzcgTHfj6qj/yDfGcQEqReuYFSKZj3KvghDkc8leYIP3q/a/XLcl5J06XDahSCKmURkiLvbz6JJExWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYcNe0MfFHYDxfY8ctq1GH6uwCXkv5WhjaERsTlaKjM=;
 b=p6eCMzYTdQTtfTI2/e8RqHB+/6tNX3Y94jyzjIU3MtJxXSePA+IxDQS7jurSoM/DCbmrsam5SMSttmYL5ngVrK+T4uBJF8AmpaDVQzTg9M+wE0w9xczjGy4YI+xHQDqENBVDkBq1h0KDeUUVLyLoJ4vVghmsuo0YJd2fjp6Ut3w=
Received: from DM6PR18CA0022.namprd18.prod.outlook.com (2603:10b6:5:15b::35)
 by BN8PR07MB5908.namprd07.prod.outlook.com (2603:10b6:408:96::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Fri, 3 Sep
 2021 05:01:07 +0000
Received: from DM6NAM12FT047.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::32) by DM6PR18CA0022.outlook.office365.com
 (2603:10b6:5:15b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend
 Transport; Fri, 3 Sep 2021 05:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT047.mail.protection.outlook.com (10.13.179.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:01:07 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ufh020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:01:06 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:57 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 07:00:57 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350uRf025721;
        Fri, 3 Sep 2021 07:00:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350u5M025720;
        Fri, 3 Sep 2021 07:00:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 13/14] dt-bindings: phy: cadence-sierra: Add clock ID for derived reference clock
Date:   Fri, 3 Sep 2021 07:00:53 +0200
Message-ID: <20210903050054.25627-14-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210903050054.25627-1-sjakhade@cadence.com>
References: <20210903050054.25627-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c17be49a-b69b-4cba-12ec-08d96e97d6ce
X-MS-TrafficTypeDiagnostic: BN8PR07MB5908:
X-Microsoft-Antispam-PRVS: <BN8PR07MB59082316C5B74DA7BFFAA425C5CF9@BN8PR07MB5908.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJCa7McliDWcU7T43d3BokvMYFo/vlpnhR7OmqVHnRCl5JPg55LP3VF3v0S2meP6sj43oKcDu+Vvw3gXUmQJgbqKf3cxb8sp+VTuzx/ozmQvXgXeInMb6bnpVfLilPLimCYO/VwnM9ikagslC2r/in1x663d61jPqePqt4An3N3IZPySvag4CsNg3NkTyHEm01YMiAm2jycQQaA2ClMsh0GdHrRCBPmJp06gwVKEmAKvcWEzhjygnTWHdJncGhYQm/RWcG08b+6XaYBuRi7vvzJVmXwU+AZEU38VmSYeIEH8yMfaMdz1yBI4H61j4kKJvP9PifhGyREuJVAVugKpLVjimKuzCX8nTzZWNSE/ae1zclVZ9I+kRC2o7EDm/hOCL5jSBpE+SiAaKT5F6fZ7jOhs+hn7baB7KlPxQR6K0NRjxA12mwdjWhv/lR4iOdUhzNL5y893RZ1350atjucLnC04aaYq8cTtq01mmp/eI9D4w6dmde4Rvg67gA06o23eGBFecVjDpDRyolPIzRrtuKfClsJNROHsNEucayzyqUGvt0Dgb9KO2pKHIm7RLB/1aUSfavSPXwuLx4FpTEtg3bh+UNuj/F2EqkcIjycWjwRepm2qj1k0N0gCortaksnFvhGA5GzF8DewSZN/JFTaBe5rsgS5+4JL8xqBbCDo9cSOamW04atTQQe4IGIKJho5zbUWq0jJJfZSaM7SGsh5T4MY36wFUBFvn0c27JS+S1o=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(36860700001)(47076005)(83380400001)(82310400003)(86362001)(110136005)(42186006)(54906003)(6666004)(2906002)(4744005)(5660300002)(186003)(7636003)(336012)(426003)(36756003)(2616005)(8676002)(36906005)(4326008)(8936002)(26005)(70586007)(70206006)(1076003)(508600001)(356005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:01:07.1303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17be49a-b69b-4cba-12ec-08d96e97d6ce
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT047.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB5908
X-Proofpoint-ORIG-GUID: TEwRtitr3QdcCS35AoJ4DLo3lK5FD52C
X-Proofpoint-GUID: TEwRtitr3QdcCS35AoJ4DLo3lK5FD52C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_01,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=977 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock ID for Sierra derived reference clock.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 include/dt-bindings/phy/phy-cadence.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/phy/phy-cadence.h b/include/dt-bindings/phy/phy-cadence.h
index 0122c6067b17..54933029961b 100644
--- a/include/dt-bindings/phy/phy-cadence.h
+++ b/include/dt-bindings/phy/phy-cadence.h
@@ -16,6 +16,7 @@
 /* Sierra */
 #define CDNS_SIERRA_PLL_CMNLC		0
 #define CDNS_SIERRA_PLL_CMNLC1		1
+#define CDNS_SIERRA_DERIVED_REFCLK	2
 
 #define SIERRA_SERDES_NO_SSC		0
 #define SIERRA_SERDES_EXTERNAL_SSC	1
-- 
2.26.1

