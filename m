Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD6437B68
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhJVRGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:06:14 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:20288 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233730AbhJVRF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:28 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEGZhp028588;
        Fri, 22 Oct 2021 10:02:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=qyS93nZeZwh/+rMOjOefrWbwgrOpM62DuJyl0NmpwuY=;
 b=SYbPFznkMU7Xu16x0feSM0TuDTkLnSGEw/iB8F10aClAwxLNtZj42YUeju5IQdPGQFAF
 LYerrLe7DHIBb1Up7+jf+MRjkibFo/+gCqXYxcuI9rC4WqGFooi1+l0ET5mhLQzQJcs+
 vhd4mCOS1s5JxNrzySpq1YCH5tX314s0Z8fwIElz8qbK+W0fhLP112h/ydaJ0EDzTlSR
 9Fsd+TT22Sa34vnqzUtzkDEvoOg7e5+EKDHiSPOJRiTtLUVF/7fCvtR8cypuWR1GX+H+
 bG7tkRPzgFeLcAcI90uNJ2/K5HJ1yIFV6Kkw+SjECcxDLK5ZvurEBiKhwKjSkWqFtZZR 0g== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3buxg0rm4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW/Ed4LHqPfVzFlDNEtsxMhTLN/yIHxd4U6kFnFqzC2bLeVAD11fBAdy+fHquq70NL6o1OxoedUOk0FcgcOmDT8eziqp3raPOXgq2KV8rpndOtsI2TYKpWznPUjin8fe9JXwYNer8OmYg3MrQKsEldJlgjK6Kbmqv94Q1T7IcuoHb+zqxaRVHv6Jda1zVG7cBjykQc+qiBKZO9xy/5GVWSyAdchyHuJbgRhcjWDVieCvd1laZvy1+F8c2C+Gn41VwH+HI1P2u6IHONNSNdomwhRByP/W1uB4YYFMCiS10fDJaqMRUshctHY7UibhFHppoY939qB3xFDUSZ8YluU7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyS93nZeZwh/+rMOjOefrWbwgrOpM62DuJyl0NmpwuY=;
 b=GJqu4j5hLyDfotEHLY1yDA1VnLocpBX7GDlhhUIrLInRv+vrD4EZ71PczFGKcccPE+44YJzVLwTvWPHGFF1LLlATB6Sq1Xthq/vyAIH1XNa3frompuc2e1PnyMG45DC8t4CUdFvp6Ze8qR6JMkPjiodR4FZuHjC46Spy9UdXpXIOyTCBGvD0c+hP44T5l5kUmSTIsXckKhMF4TByk4Ii1XfJ8T8N905J7nFmAh84X+VT1gx7eymKKd2wG+w7oFL7DG3mLHw2glMaYsHx9lyhkAlRmm63bg9vplMHzxWYjhqbReSSLa0joMQEssSOwAdcswDxUf1DSLYFJHneg4w3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyS93nZeZwh/+rMOjOefrWbwgrOpM62DuJyl0NmpwuY=;
 b=J+6QF5beBAf8pdO5phH+BIeLXF0qMzh9z+lxApI9O6hS2lK900e6c9ZdjGLb6vx1jYjK7bQIha+We8lAZA/raIDTC1bTOuH5Zvyr+ofF0OkpXHE3hXYlyjECbHvbyZIxrrXTDfdlgb0yX3otCJLArsXtJeQ1+LreaRrZJBBuimU=
Received: from CO2PR07CA0076.namprd07.prod.outlook.com (2603:10b6:100::44) by
 DM6PR07MB5689.namprd07.prod.outlook.com (2603:10b6:5:7f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Fri, 22 Oct 2021 17:02:55 +0000
Received: from MW2NAM12FT068.eop-nam12.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::e0) by CO2PR07CA0076.outlook.office365.com
 (2603:10b6:100::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT068.mail.protection.outlook.com (10.13.181.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:55 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNT008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:55 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 19:02:39 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2dHr018945;
        Fri, 22 Oct 2021 19:02:39 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2dah018944;
        Fri, 22 Oct 2021 19:02:39 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 14/15] dt-bindings: phy: cadence-sierra: Add clock ID for derived reference clock
Date:   Fri, 22 Oct 2021 19:02:35 +0200
Message-ID: <20211022170236.18839-15-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01573772-567a-40e2-ff3a-08d9957dcaa8
X-MS-TrafficTypeDiagnostic: DM6PR07MB5689:
X-Microsoft-Antispam-PRVS: <DM6PR07MB56892A84A631647FE3521BBFC5809@DM6PR07MB5689.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxPv7zDDsrnyxcqnC3vz4M0wEDwmz9CT0jjRB4BKs3tv3gxmk37pB3EtSZR5OLfTWbG6IBi3X9X9KQcXfPZ2HDCal2xTv0r1gXuYxV95XVoz5qJwn8Et9mOMMcdlojj/8tUHxPso8YezDZ5h0BCyMD6N/2w/V61kY0xGisVo/0Li+Fz1CA+ItYKNzJ84Hb/RW1k8CbFtL+AbHFr1L975+lBT5EbcFDE4tuGn8x5rT+pEnKTvT1nPfqc2zAitNF2OZQGLnNgUGvFXm69JPv8IRWAAbF3RnTOShzPGQ0OZBBlMi0lQJQ/qpXWQgW8yVNTnyrz7k9xR2JMNfsFfWrgd1capSVvbKT7Wsqdvwa98G+7o8+S1iyRZoY2wn6Ub0OMRdDgGvkiZPp0/VuAOcFUbl/yR4B005h4zmH8Z4mcCkZ8QSrbrO5Sk9Vzfv4SbyRjMhp0T0m0L4jS9FcQiHnAr679efmc6X8Td6La5WIztYPmLF34dUNfUox1iiPWI3QFja+9XyIoOzVSP2KhvwfL4S7bO6TVLQ31uJpZXwfaN8orbSMeu3oH0lxG3l3Snqddj9+zruy0PbHOC1kyeP44Tg7GvEGOBUHwOpIQyoTiJAZ2oRX0DLgTUHnh4ZY2xLkyCWTSuVJD9vwE1Gq5h9jGW4+ZiuXKoaGHtOm8Bq215UQBWZ/vO6tvV3eUt8/REUjrnvXOgq0WkEeU5s7oIxlsG07djAJq6xNCZZYDx5pxV5yo=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(70586007)(336012)(26005)(54906003)(7636003)(6666004)(47076005)(4326008)(5660300002)(2906002)(508600001)(4744005)(110136005)(186003)(70206006)(36860700001)(36756003)(8676002)(82310400003)(1076003)(83380400001)(36906005)(42186006)(8936002)(426003)(86362001)(2616005)(316002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:55.2539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01573772-567a-40e2-ff3a-08d9957dcaa8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT068.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5689
X-Proofpoint-GUID: pEV3VhL_tf8UUQc4MMpHUF3ay7kz5aqz
X-Proofpoint-ORIG-GUID: pEV3VhL_tf8UUQc4MMpHUF3ay7kz5aqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_04,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock ID for Sierra derived reference clock.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/phy/phy-cadence.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/phy/phy-cadence.h b/include/dt-bindings/phy/phy-cadence.h
index d55fe6e6b936..0671991208fc 100644
--- a/include/dt-bindings/phy/phy-cadence.h
+++ b/include/dt-bindings/phy/phy-cadence.h
@@ -18,5 +18,6 @@
 /* Sierra */
 #define CDNS_SIERRA_PLL_CMNLC		0
 #define CDNS_SIERRA_PLL_CMNLC1		1
+#define CDNS_SIERRA_DERIVED_REFCLK	2
 
 #endif /* _DT_BINDINGS_CADENCE_SERDES_H */
-- 
2.26.1

