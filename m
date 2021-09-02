Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B783FF2BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347071AbhIBRoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:44:02 -0400
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com ([40.107.244.52]:25598
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347183AbhIBRnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:43:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZphIzNUE/lux4rSCNQAtTb13hcVDHY7Y+O7WZepa8FmZ8M72IIvRo4FYp32EYMlwf/fhreXfyrcHLxLhEZaxJJAFYIL1SoEb8s8RW+HvoJilwMyAIiraqhZP3o36vXVhgfbXVoHiB8tq+leq2rpf7ftkxcKTBf7wL3p6OcKjJUF8HIaPA6AnUBjbCHbLCfTUkafTz2sXsu6bSgeO+diqG/Ia1wqxdua4s9kaP0z/GJILqwUOefmFXFNET170ZfaV24zaO3q8RuOC9GZBhEcWNx/77n2SyspZMkSrAsVtEnuD8RvcPH3FvsrFH+wTueGyFIdM3muWxvHanT5c/HHy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO/Ab12+VupXB0+Oku5qTO5Hrx1Vgyuks66L4A9p5bg=;
 b=g8zCjE/E+OXSFkVefg7IEoCxoFOeFxbJgDUMB8umYx5uB3BleulwBfLsVWHNOj4Zfi0HeVFfbEuf0NVTvDk/vnszXVSrEmh+5SuKLBY+j0INsdXsmm1Oiz/txky6235QNydGnS0/rNi58L+KQkaFp+MUNaPjzdeterKMzET698OSaTrFsFjchC7gTqqx/o4Yk7hOlRUDzYrbx8Rmnj8WXbNZFohn1PBWZEgltDCzWEkg5VG8QxvyRD4vQND5xvL1EKegqGKYUvPlrcaZu76aqYrY4IF0118GQaDnflMY/vAJc27rQV9b3du+F0Z/cEZShD2SDNiVzOifMdgZj0WqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO/Ab12+VupXB0+Oku5qTO5Hrx1Vgyuks66L4A9p5bg=;
 b=cIAS9yK5xkShG9QzzxyHQ8bP8p9ZRMLp/4LyTbfqFnZlqSWk/SUKJBOAom0IWne3F93hoZ7VEIa6C//ekbfQkrweQgV/ipTb/UscwbBGx8wqeNX1Hz9g/c8abB7S7vkd6Itsao96HzeSnA0xV4ZtqUScjWnPIeRdX5/c2siGUU4=
Received: from MW3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:303:2b::35)
 by BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Thu, 2 Sep
 2021 17:42:22 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::7) by MW3PR05CA0030.outlook.office365.com
 (2603:10b6:303:2b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.7 via Frontend
 Transport; Thu, 2 Sep 2021 17:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 17:42:22 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 2 Sep
 2021 12:42:18 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC:     <linux@roeck-us.net>, <bp@alien8.de>, <yazen.ghannam@amd.com>,
        <mingo@redhat.com>, <nathan.fontenot@amd.com>,
        <lewis.carroll@amd.com>, "suma hegde" <suma.hegde@amd.com>
Subject: [PATCH 2/3] k10temp: Remove residues of current and voltage
Date:   Thu, 2 Sep 2021 23:11:54 +0530
Message-ID: <20210902174155.7365-2-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210902174155.7365-1-nchatrad@amd.com>
References: <20210902174155.7365-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c63a82a0-4ee7-4cc9-da47-08d96e390509
X-MS-TrafficTypeDiagnostic: BYAPR12MB2711:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2711AEF5BF13137F280C77B9E8CE9@BYAPR12MB2711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WWpliXrBHwhp4Kwj7WCaUhNbY8HfHdqe48NKiIpGfgAc6GTSuIr0DFa0FXJkuyAT9YxK1JnLgDrLnX3RFb2clBN34qzc7jNRhEDnl7SbnPM3cjPjGVxLv0gwnYHgKJymHT86Dnrb7/RDBphaOyqFA+vb3aRFIiUkg5ubhEem0c+u4+kIfRKYrn5FDLxh6CKwhSc0IzdTDTGqvojsVo04CsEGP9eXnR+Gh/4k7MgmeR2es2obm01wwrx787szTPHk1trzW82sL5duyyB6Rl2TWUl7MAehOJmA5fhUZFb4+C9qMfHKkYqnHJrxc5ub/w8Y+5kfznSjeXzzR4v4AmOKI55GRscNTiWJbIflnNFjjJhyMVVcYOcXIojOcsT+Rgs1THynNNFWQ1lMfc4EdSynZHcgjDakhwzkNsM9a9aeITJbc2fs+Mx9l2sTl7+h7ult2BgZKCa63+AIYy4979yeCaCusNe35xsoxPwVND7lHlPwDSL5/5wlQip+jYYgsecj5qsThibwSvQ95gpTZpD1hCEclVWB+2c7Tflt34MgvC41psLnsC3GCp+RA+aENTvjJTjsgQ0Fyv8kxltvPvrXbisyvBRflXiDsrHac+NfwWOJpiIgSiqu1F/9tS1h2/eBSn3Egrm1AwIGhCCPHnefuu93GhsXvarh4LiY9+hAW9/d+s9OcVW+LEu0Lfz0wWQHz79oMDZrEemJBijk2jmwbcZ5teQL162QBuhj/Tzmeo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(46966006)(70206006)(186003)(82740400003)(316002)(82310400003)(8676002)(70586007)(36756003)(36860700001)(478600001)(8936002)(7696005)(81166007)(54906003)(356005)(83380400001)(4326008)(2616005)(47076005)(1076003)(2906002)(26005)(110136005)(336012)(426003)(5660300002)(6666004)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 17:42:22.4569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63a82a0-4ee7-4cc9-da47-08d96e390509
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: suma hegde <suma.hegde@amd.com>

Commit id "b00647c46c9d7f6ee1ff6aaf335906101755e614",
adds reporting current and voltage to k10temp.c

The commit id "0a4e668b5d52eed8026f5d717196b02b55fb2dc6",
removed reporting current and voltage from k10temp.c

The curr and in(voltage) entries are not removed from
"k10temp_info" structure. Removing those residue entries.
while at it, update k10temp driver documentation

Signed-off-by: suma hegde <suma.hegde@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
This is an unrelated change, should we submit this seperately or drop this for now?

 Documentation/hwmon/k10temp.rst | 17 -----------------
 drivers/hwmon/k10temp.c         |  6 ------
 2 files changed, 23 deletions(-)

diff --git a/Documentation/hwmon/k10temp.rst b/Documentation/hwmon/k10temp.rst
index 8557e26281c3..91b99adc6c48 100644
--- a/Documentation/hwmon/k10temp.rst
+++ b/Documentation/hwmon/k10temp.rst
@@ -132,20 +132,3 @@ On Family 17h and Family 18h CPUs, additional temperature sensors may report
 Core Complex Die (CCD) temperatures. Up to 8 such temperatures are reported
 as temp{3..10}_input, labeled Tccd{1..8}. Actual support depends on the CPU
 variant.
-
-Various Family 17h and 18h CPUs report voltage and current telemetry
-information. The following attributes may be reported.
-
-Attribute	Label	Description
-===============	=======	================
-in0_input	Vcore	Core voltage
-in1_input	Vsoc	SoC voltage
-curr1_input	Icore	Core current
-curr2_input	Isoc	SoC current
-===============	=======	================
-
-Current values are raw (unscaled) as reported by the CPU. Core current is
-reported as multiples of 1A / LSB. SoC is reported as multiples of 0.25A
-/ LSB. The real current is board specific. Reported currents should be seen
-as rough guidance, and should be scaled using sensors3.conf as appropriate
-for a given board.
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 38bc35ac8135..3618a924e78e 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -362,12 +362,6 @@ static const struct hwmon_channel_info *k10temp_info[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
-	HWMON_CHANNEL_INFO(in,
-			   HWMON_I_INPUT | HWMON_I_LABEL,
-			   HWMON_I_INPUT | HWMON_I_LABEL),
-	HWMON_CHANNEL_INFO(curr,
-			   HWMON_C_INPUT | HWMON_C_LABEL,
-			   HWMON_C_INPUT | HWMON_C_LABEL),
 	NULL
 };
 
-- 
2.17.1

