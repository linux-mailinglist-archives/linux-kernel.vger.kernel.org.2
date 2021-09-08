Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7F94039EA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351817AbhIHMcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:32:15 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36168 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349341AbhIHMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:06 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886dfYY030276;
        Wed, 8 Sep 2021 05:29:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=r23o/aGrRijkmjGgDmtQ7mE9DsyPCqVxJm8ZLWdJ7Y0=;
 b=iyOipfMG465P9ZhmOrC5nSEjtAF44+ItQ67NkIXBaVVFfMkquW9bBlIOPRnu5YuNw90T
 0VqxKTvkHtstahKLBkxx1IbXucPYrvAlyXMRgKnc6DhH2yQgNqfe3TRARgfvi6aRkR20
 e9OyQndjD0RayO/hT/FjV3u43TTP2rlpGkx/inlXiaSQZNASMfR6C/EqlWZXZY2sE+w9
 4gifM/SGsyzh3EQ65bFAkZwt8C9RXu6hpcEi0jxPRtKJOEIZB3sdJnlWVwRuWHEZw90u
 Hd+9yXjGsOJaRLOHd4qQX+J37ZreHrGpzPNJL5kserye1300TWtEeCaxkl+YgZcCND9S tw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5b0xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2zOIkM7V8L0EzixAkgKywrpS3DkAAMLsYa8Up0Mv0WyO0Dr7NCEDqzcfSaMDXAiEnHHRSSRU7lMN+L7+eR1T8A14RLHc3zJ+wptbssGuU2KaWy2ua1U8J0WjU66wHUnS6i2CChyrAK3W8cT8qQF4WN0jp/+Ok+uJm17xxBNGGc6kwuzS6vQ6mHNg7+pMm6laD6nIW70hQeQAd8LAYKehNb6pQr6N3kIkYBrS9WI1o2aiiSIYufiMTWpK6Q+2H/vWyRVd/3qPKhl8g++b8OXGVcjSseDmXY/Uz5+tXapRv4G0J1fGLgdD3KFIYgiUd22OvsuIzlJJLrsaQFWK6F9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=r23o/aGrRijkmjGgDmtQ7mE9DsyPCqVxJm8ZLWdJ7Y0=;
 b=fQi6u9XylojcNyzpQEyzzpUKbon/RhzH3PFq4q/gV6xlqJr4JjnK141Ia81J8j+D2cExKAZ5yoB8pzuxE7/nfTQarCVwPxHiZVHgQ+mSSIMmsL+YfJgh/fLQAiRmQ4dXYpJqRQ+Sp4xs9Oc5IvFALKvJYtE9IkHmlsTrlm74S4Cr1S3c3XNFkH9kFu5s97NDk6szd/R8BXSctBGwusm66cdQ/CFlfixGjKKGuHxtmIoI3dISX5uxwvTPHj0qLO3gVKin9Q0hEERZ7lLgCyRk78uLmODwX74d8o2DRsuxJVn+UpWGK9EY3EsTsNQ8eXlBt1IpAvvLt0xUqB7kVMV5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r23o/aGrRijkmjGgDmtQ7mE9DsyPCqVxJm8ZLWdJ7Y0=;
 b=Szo+sqvX0G7e/7Ln652AA2T/30zumk0yW/grbfHN7VfhuE8RmoUtypPPTUB6xu8mIU/ZNsQRiFVdK5SvSVG4ZkY9Pyu1KOw9f2x3USO78H0/gs1XVQv4KbrqrOq6cuJX0pxxVPJKIUFwzAtLO24k5loRG5i4Aw+AuFXlyvXubOY=
Received: from BN8PR15CA0007.namprd15.prod.outlook.com (2603:10b6:408:c0::20)
 by MN2PR07MB5837.namprd07.prod.outlook.com (2603:10b6:208:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Wed, 8 Sep
 2021 12:29:49 +0000
Received: from BN8NAM12FT055.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::8b) by BN8PR15CA0007.outlook.office365.com
 (2603:10b6:408:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT055.mail.protection.outlook.com (10.13.182.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.13 via Frontend Transport; Wed, 8 Sep 2021 12:29:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 188CTj44190907
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:46 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTWZb010272;
        Wed, 8 Sep 2021 14:29:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTWqo010271;
        Wed, 8 Sep 2021 14:29:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 01/15] phy: cadence: Sierra: Use of_device_get_match_data() to get driver data
Date:   Wed, 8 Sep 2021 14:29:16 +0200
Message-ID: <20210908122930.10224-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8e32fb5-19fb-42d5-7e58-08d972c458e3
X-MS-TrafficTypeDiagnostic: MN2PR07MB5837:
X-Microsoft-Antispam-PRVS: <MN2PR07MB5837CD91F167F91ADDEFBDF1C5D49@MN2PR07MB5837.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gdc0p0Ra/StDWgkwLbla6OE6WRrqqCyDBoyWlUz1sANvq7K5c7ikaY3PfUVVXz8/jGJmnui8bh+dpY7GAG8UUrm2bU2j7EO6dcWAJ6weKB8vsUGEFWiqXX/pRpF2poiZ4Sp8By9pyaUYdgKVlFW3h5FXZwfgL5DwndpjLo/FCWeagpZhsoHoeFm2tX9Zsn8ruGyK50tGEft2ipDj+Ly4tzg47RyL7QZTkj48UbGCtYIT+FmD1lAwmmNCFNd7klcK6GoX1WNdNXhRD83yjO/LpTHdPMPcnwIwsBHPPltUgckyRjwEnU2uT65jUVkkrXRWFpoNQqJy6NJxKlWYLth/2OT9TaMSv6cBI9THDakswodj/g6WyPjGFF9K0AZHTeNHpec7/tNZ4rLc2sEnFcX/kKUFul20lYU7ZMfbc/n/APYEYs4/6KZ8nn4EYPLZP5ZLLaySaHigeRJVZ1lw8sJtPtCnTnJLSY4kjVdjto3t+cD5ltDnB5rfh/G0QCr+ZxaO+EJXGFnbU0mHQS6fHpSTtHp6y5x4NFj6kBStnlBpNblWivdYz1gPvMU/cQdv3tCKKNrMtPkuqsURFbyuvk7JmKvpzdkxB5rlQ5LLNZGsj99thOgj7/YsbzrG+pNsLyJlcKmND4icRvR5TQmxgYxjhYScCql/MjJ9O4edO2okxzNymsvR6/Wkmkhle0s7Yn8OS4LP/4R/FhuVX5SiyOmBs2viyM5/r7wPhr6DEmx6PgMVARDakm056sdP9E2CAjZOZf4Uzzl/jslFId+kSJr+Pw==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(36092001)(46966006)(36840700001)(1076003)(2616005)(86362001)(82310400003)(82740400003)(26005)(336012)(316002)(36860700001)(426003)(81166007)(356005)(83380400001)(36756003)(4326008)(186003)(478600001)(70586007)(5660300002)(6666004)(47076005)(8676002)(42186006)(54906003)(8936002)(110136005)(2906002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:47.8077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e32fb5-19fb-42d5-7e58-08d972c458e3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT055.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB5837
X-Proofpoint-ORIG-GUID: ZG0z5gG_ywyyCMYwDHRZJ1eHZXzdUIzL
X-Proofpoint-GUID: ZG0z5gG_ywyyCMYwDHRZJ1eHZXzdUIzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to get driver data instead of boilerplate
code.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index e93818e3991f..54d1c63932ac 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -253,7 +253,7 @@ struct cdns_regmap_cdb_context {
 struct cdns_sierra_phy {
 	struct device *dev;
 	struct regmap *regmap;
-	struct cdns_sierra_data *init_data;
+	const struct cdns_sierra_data *init_data;
 	struct cdns_sierra_inst phys[SIERRA_MAX_LANES];
 	struct reset_control *phy_rst;
 	struct reset_control *apb_rst;
@@ -595,8 +595,6 @@ static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 	return 0;
 }
 
-static const struct of_device_id cdns_sierra_id_table[];
-
 static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
 				       u32 block_offset, u8 reg_offset_shift,
 				       const struct regmap_config *config)
@@ -829,8 +827,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	struct cdns_sierra_phy *sp;
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
-	struct cdns_sierra_data *data;
+	const struct cdns_sierra_data *data;
 	unsigned int id_value;
 	int i, ret, node = 0;
 	void __iomem *base;
@@ -840,12 +837,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* Get init data for this PHY */
-	match = of_match_device(cdns_sierra_id_table, dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct cdns_sierra_data *)match->data;
-
 	sp = devm_kzalloc(dev, sizeof(*sp), GFP_KERNEL);
 	if (!sp)
 		return -ENOMEM;
-- 
2.26.1

