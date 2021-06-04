Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560C739B350
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFDG5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 02:57:08 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:46785
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229831AbhFDG5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 02:57:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT12XbkmMVjRYqAndeJ5oA7/LeUf1utOzTUHKj4Y5DcTl8Ur1JRIFlUw7HBT5L0K19pFrd+yOG5y4pYeRNrma7ORiG555yFevlCvYwJcnQxybeq2lepIc5Ye2F5JcdL4UEs0EfmAUKbxkdQTauvoGSjcjhdiEoaz3yzRgaxAcPNtYhlFKPF/5SKIapGSteWJFXyw0sJh6p6rV9XZBGN1PK8Cqu1OQ+O5D8dOKQ396wnrzeQ8cer3dpM32lcAtOGaFVLiqee7TNOPv43IlOtzXClz1IlSzPGbIM6ttYY2FawhEPJ/74KD6NEnyPoJUyAMDQweHhNxjrKriO4EyTMDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vltb3jFKtCV+IdXvE+GRu1MtFk1GIT2cvmg1EUCVPJY=;
 b=Jq0k3tYEOtwb71qkEDauxges/U9JmKBF38OKOc6Djhse8qBALSOFcWqMiXoo33JWQ4Umx+vlfWUwHnsJjSJWm5of5TJ54fiNevkI+4Fba5MJqjm0CcBVlUa1PdaGf0+TaFmYDL6ty9mGvnmn9u5oVAreOXRSQX1aGaq1GhDIFuPorbPHYU1XnRRaLnrHjp81FZMuXg3PGwkzPn52c/pCuIVsexIw/280h3VinZnsytfddOt70hmzj8OfAFHlFDWonlXYc4bEqkE4R/zgSUAeReotOeCQYVbcuet+Q3CIJqB2d44h622SlEex3VhKcuHXfLJUZqhfzF581YIe8Z6nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vltb3jFKtCV+IdXvE+GRu1MtFk1GIT2cvmg1EUCVPJY=;
 b=XDZgOFT0RTX86v4wmJ4HxTEsHcD955CcnQi54ugoSSCT80qyhRp/K8fZ6c11951Rm9ngEmUGyXJuVuMeT8IssXIuZczRwwTlFcf4t491DnNzP5CMWsIPebiXVmSLMmx2flFChEeqBuNkpmmdrBUB6D6q3WD1sMJYPHhhoGocXuvuPbKswCbhqoSFHKWfyi6GIpAx23KieOUifGxSDXrhCSKWb1cQZfuQAgsCBF/TuAC9ahwxjssojA/6wUSlA+eNjRKhFqHdFW+dauJ7WAml9vL/8ayH4zFvu9sfQYJf6rxVmqJwhhPzd9SLE9sGOPs4Dnpk/mqNJygLeYugLPgH1w==
Received: from DM5PR07CA0109.namprd07.prod.outlook.com (2603:10b6:4:ae::38) by
 DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Fri, 4 Jun 2021 06:55:20 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::5c) by DM5PR07CA0109.outlook.office365.com
 (2603:10b6:4:ae::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24 via Frontend
 Transport; Fri, 4 Jun 2021 06:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 06:55:20 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Jun
 2021 23:55:19 -0700
Received: from nmalwade-dt.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Jun 2021 06:55:17 +0000
From:   Ninad Malwade <nmalwade@nvidia.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Bibek Basu <bbasu@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
        Rajkumar Kasirajan <rkasirajan@nvidia.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ninad Malwade <nmalwade@nvidia.com>
Subject: [PATCH] ina3221: use CVRF only for single-shot conversion
Date:   Fri, 4 Jun 2021 14:54:43 +0800
Message-ID: <1622789683-30931-1-git-send-email-nmalwade@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a54e29-6364-4779-5c6f-08d92725b804
X-MS-TrafficTypeDiagnostic: DM6PR12MB2938:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2938924FE70B2DDC8AE8D84CB13B9@DM6PR12MB2938.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FViDa8M44UayslIVtvV2i9US6ZPPFFqc3HLcDMeDJqYmK3znuLkhg5++OfV8g4KMCH8OZMWHJISMspSrETyOQfG+4gmQcqZ0CdofMnYwjkucTc5XrGWbfrJb0qXmocI9Z9IQasBymnLfI9DQHUs/N8DiV1N7Fr4wk4sG1n09ydpPNos38twW7JDb+zRam3EWb1zEFvVpL/rxLIXHHvqIopAqxLX2tBtmOkH2yhtR5KPo9VIdeJPQzpNpnw0Hfi7hWKrrNXIrhyJO/LaqBxr95/oC5sw9FM8xBVcKASBDR+o36zBYm5fgQaLwpWNZiDJIwiMcuZu1UsZGDwR85/OpMmChX+Dt/4J0m2m7+Dq9J3pehPNO6dgGndQ+cF9T9pRhG9mrROo8S6820MazkfHTgdpDMInnFFW235MPRKGOFWtP5X6SogfDHhj6PSgsJsGNOWfMmShGoYtStQ5xgN28LWvs6ZX1UL09sfLsJVcIUYXHdgRfeVrrzmJDKYUVYU0Felxuw66P0GoFSqSBAQTwdt9cOWqJ4scGEA89nosGmqZTkoqoy7ANkWQZqANfF1leRNtpaa61EEa1YogGSI94aewvXwEmzmfb6PFB+uw45j2viYxQ5S8pKEz7+21XPw6EZAeQSvluzZBTxgKSMb/9e+rjsYKyyb9HKEWzyAwOOxU=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(36840700001)(46966006)(107886003)(316002)(336012)(110136005)(54906003)(426003)(8936002)(5660300002)(356005)(8676002)(82740400003)(7696005)(70586007)(82310400003)(70206006)(83380400001)(2616005)(86362001)(36756003)(478600001)(36860700001)(26005)(2906002)(7636003)(4326008)(186003)(6666004)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 06:55:20.3073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a54e29-6364-4779-5c6f-08d92725b804
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per current logic the wait time per conversion is arouns 430ms
for 512 samples and around 860ms for 1024 samples for 3 channels
considering 140us as the bus voltage and shunt voltage sampling
conversion time.

This waiting time is a lot for the continuous mode and even for
the single shot mode. For continuous mode when moving average is
considered the waiting for CVRF bit is not required and the data
from the previous conversion is sufficuent. As mentioned in the
datasheet the conversion ready bit is provided to help coordinate
single-shot conversions, we can restrict the use to single-shot
mode only.

Also, the conversion time is for the averaged samples, the wait
time for the polling can omit the number of samples consideration.

Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
---
 drivers/hwmon/ina3221.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index c602583..58d3828 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -196,13 +196,11 @@ static inline u32 ina3221_reg_to_interval_us(u16 config)
 	u32 channels = hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
 	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(config);
 	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(config);
-	u32 samples_idx = INA3221_CONFIG_AVG(config);
-	u32 samples = ina3221_avg_samples[samples_idx];
 	u32 vbus_ct = ina3221_conv_time[vbus_ct_idx];
 	u32 vsh_ct = ina3221_conv_time[vsh_ct_idx];
 
 	/* Calculate total conversion time */
-	return channels * (vbus_ct + vsh_ct) * samples;
+	return channels * (vbus_ct + vsh_ct);
 }
 
 static inline int ina3221_wait_for_data(struct ina3221_data *ina)
@@ -288,13 +286,14 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
 			return -ENODATA;
 
 		/* Write CONFIG register to trigger a single-shot measurement */
-		if (ina->single_shot)
+		if (ina->single_shot) {
 			regmap_write(ina->regmap, INA3221_CONFIG,
 				     ina->reg_config);
 
-		ret = ina3221_wait_for_data(ina);
-		if (ret)
-			return ret;
+			ret = ina3221_wait_for_data(ina);
+			if (ret)
+				return ret;
+		}
 
 		ret = ina3221_read_value(ina, reg, &regval);
 		if (ret)
@@ -344,13 +343,14 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 			return -ENODATA;
 
 		/* Write CONFIG register to trigger a single-shot measurement */
-		if (ina->single_shot)
+		if (ina->single_shot) {
 			regmap_write(ina->regmap, INA3221_CONFIG,
 				     ina->reg_config);
 
-		ret = ina3221_wait_for_data(ina);
-		if (ret)
-			return ret;
+			ret = ina3221_wait_for_data(ina);
+			if (ret)
+				return ret;
+		}
 
 		fallthrough;
 	case hwmon_curr_crit:
-- 
2.7.4

