Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F2745AE29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 22:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbhKWVTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 16:19:46 -0500
Received: from mail-dm6nam10on2045.outbound.protection.outlook.com ([40.107.93.45]:19297
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239630AbhKWVTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:19:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSWe8+a/qwU5zFlTbHLnM5LV5huFn29z6Wi8C/OThCRLsDsL7MrNRnBpC9QchLKpgUVPMrYHs/6Rl2Gvmcxx4JfDVxXvtsACoaICpdPCmBKQ0t06kMaGN28V1CY/7wjeGw7KrirbkzQ2YfiSS1gufJyQEVGpK3vDgLNTefzFIW1Cl3oZH7Et6of8lmNU3Rh86BalGjoSWZWf4dRbD8c6sTyUZT9dzQ279Bnen+SNb2qqhVpAbMkArJpqS7fIpokRpFv1MNMkZm3WEx6FEJZF9Fj4/lJMPFADYY+TQuDEdhYRga707oweWHmNjczyv4QsM4GeTofgbZ6VSOjVHV/Opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QmYMef9ORmx30J6vdBxzucnHFXl4ltdHRVZgaOCwn4=;
 b=SErt38AaeyGY6UHxl+Vdv1iSvU38KCGBMEnnPPsImKw0+V1SDXXzTklyZjISAecYCxBBS08fcGFqoKjQuMpWRb2V478eIOsVeF4IOAjFd/jLF0PCAlJkqmluUCRjGZMnqVkrIzCgf42Auaz/GXTJcuECtDUTf/IOE6K0mdIOiwcI2j9kKrs0oEmRzRNGKGSJY46lE8e9L0JJT4569hSWkNVaWjXUMV0wWUNsOwwBtB0ZUWMF57JUN5Lmjyc/mEtY9X3t+CYVVplmFwx3jR31zV0YuZVt8VCoNRl4Pr+fQbOx2Crkou/fanNU3BUQWmb68RjBqKsmWgplCm65/JtZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QmYMef9ORmx30J6vdBxzucnHFXl4ltdHRVZgaOCwn4=;
 b=zdsxMQyNNwjGbRUIoB2BUjFkTaqpRsdNLLQmdq/6AwzLAB5dnJzBNgu166G+SCjittp9bTy8K0utHzsLu3VJC2iglAHpXBELxNUichd7jfmQNt4dsQTBAYmkhEv26eZS+9xYcsqG9w1jTlftsZ5vbGAM9hy6zDdpYnNfM6RIJk4=
Received: from BN0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:408:ee::27)
 by MN2PR12MB3390.namprd12.prod.outlook.com (2603:10b6:208:c9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 21:16:32 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::7f) by BN0PR04CA0022.outlook.office365.com
 (2603:10b6:408:ee::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19 via Frontend
 Transport; Tue, 23 Nov 2021 21:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 21:16:30 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 15:16:28 -0600
Subject: [PATCH 1/2] hwmon: (k10temp) Move the CCD limit info inside
 k10temp_data structure
From:   Babu Moger <babu.moger@amd.com>
To:     <clemens@ladisch.de>, <jdelvare@suse.com>, <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Nov 2021 15:16:28 -0600
Message-ID: <163770216907.777059.6947726637265961161.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 856ad192-4615-4571-1c35-08d9aec68526
X-MS-TrafficTypeDiagnostic: MN2PR12MB3390:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3390DEBA667B56F32E03A7C895609@MN2PR12MB3390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BSS4mEsty6NHWENqETU9U0dfYO9/ik2GY0USuq9Eu/A4QUZjw/YNeNm3sVdHwkHaNbaGAKuKMmx95nyaxCNtHjl0077djG6TT9yJ30CXbEH9p7CreNfyT3M7/mbvufaH7uiXpAlIZ3noYf7bJ28unsKlDx5EpNiA9ofHV9NJ8N3g6ezfiUWJEHHm2K88rc5b9qy8UL/Hb6NSN/D9njrZD89FeGbmebHySx029JQZzJrIhXP/4RDp4Gla/lhAwcJTJX+5cp2fIVvHYcwyoKK6umAunCeejzHCTt0SB5uD37fEUHSuIZ2MCeQcTFKLAtnTl6HyxRHDfqQLydn1fokLhSm9+qzFviV/UYMBCGlmNjSrSPxgNd8RdQCO82W7JP+Az0gTVAu4r/c/kNKHnZGXtNq3WhrObPooZ4k3GF0mfgLWzlDCv610QvpFWDg3fWmb+sulDuLqvjXpuEiok9w6XnZmm91kdREtXHz/fPfnm+g/H6KRNIqE5yQPQLjljCEQ9UGhuaUNNOELd3lZzeqhYPIeWKa7tQA3hWMORmhcwvctb5Rhdomv5rfdc8d5ZejHPt2JFSvUfqX7zicsHnFbd2jas1NWXD0hkE3dCG3ByvZSmuqnmOtpamnuy+QuTfUUwqF56iZo4ejN8poQPKRDLQG2nxM5M0NWCme6DFZvXZRJT+o+FGgi7vDzmCaD4VMzpVcjvzGW6ktpDk+piROR6QLH+0NtNZdDb+tJa9U2CQzI4pazM+uGRTSR/nTNmPEUSFcpDF00Stxfkjz1y1jIdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(7916004)(4636009)(36840700001)(46966006)(5660300002)(33716001)(336012)(110136005)(8936002)(356005)(426003)(70586007)(103116003)(2906002)(4326008)(186003)(26005)(54906003)(8676002)(508600001)(16526019)(16576012)(9686003)(81166007)(47076005)(86362001)(36860700001)(70206006)(83380400001)(44832011)(316002)(82310400004)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 21:16:30.9821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 856ad192-4615-4571-1c35-08d9aec68526
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3390
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems appropriate to move the CCD specific information inside the=0A=
k10temp_data structure.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
Note: Generated the patch on top of hwmon-next.=0A=
=0A=
 drivers/hwmon/k10temp.c |   17 +++++++++++------=0A=
 1 file changed, 11 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c=0A=
index 880990fa4795..bd436b380a02 100644=0A=
--- a/drivers/hwmon/k10temp.c=0A=
+++ b/drivers/hwmon/k10temp.c=0A=
@@ -85,6 +85,7 @@ struct k10temp_data {=0A=
 	u32 show_temp;=0A=
 	bool is_zen;=0A=
 	u32 ccd_offset;=0A=
+	u32 ccd_limit;=0A=
 };=0A=
 =0A=
 #define TCTL_BIT	0=0A=
@@ -357,12 +358,12 @@ static const struct hwmon_chip_info k10temp_chip_info=
 =3D {=0A=
 };=0A=
 =0A=
 static void k10temp_get_ccd_support(struct pci_dev *pdev,=0A=
-				    struct k10temp_data *data, int limit)=0A=
+				    struct k10temp_data *data)=0A=
 {=0A=
 	u32 regval;=0A=
 	int i;=0A=
 =0A=
-	for (i =3D 0; i < limit; i++) {=0A=
+	for (i =3D 0; i < data->ccd_limit; i++) {=0A=
 		amd_smn_read(amd_pci_dev_to_node_id(pdev),=0A=
 			     ZEN_CCD_TEMP(data->ccd_offset, i), &regval);=0A=
 		if (regval & ZEN_CCD_TEMP_VALID)=0A=
@@ -411,14 +412,16 @@ static int k10temp_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)=0A=
 		case 0x11:	/* Zen APU */=0A=
 		case 0x18:	/* Zen+ APU */=0A=
 			data->ccd_offset =3D 0x154;=0A=
-			k10temp_get_ccd_support(pdev, data, 4);=0A=
+			data->ccd_limit =3D 4;=0A=
+			k10temp_get_ccd_support(pdev, data);=0A=
 			break;=0A=
 		case 0x31:	/* Zen2 Threadripper */=0A=
 		case 0x60:	/* Renoir */=0A=
 		case 0x68:	/* Lucienne */=0A=
 		case 0x71:	/* Zen2 */=0A=
 			data->ccd_offset =3D 0x154;=0A=
-			k10temp_get_ccd_support(pdev, data, 8);=0A=
+			data->ccd_limit =3D 8;=0A=
+			k10temp_get_ccd_support(pdev, data);=0A=
 			break;=0A=
 		}=0A=
 	} else if (boot_cpu_data.x86 =3D=3D 0x19) {=0A=
@@ -431,13 +434,15 @@ static int k10temp_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)=0A=
 		case 0x21:		/* Zen3 Ryzen Desktop */=0A=
 		case 0x50 ... 0x5f:	/* Green Sardine */=0A=
 			data->ccd_offset =3D 0x154;=0A=
-			k10temp_get_ccd_support(pdev, data, 8);=0A=
+			data->ccd_limit =3D 8;=0A=
+			k10temp_get_ccd_support(pdev, data);=0A=
 			break;=0A=
 		case 0x10 ... 0x1f:=0A=
 		case 0x40 ... 0x4f:	/* Yellow Carp */=0A=
 		case 0xa0 ... 0xaf:=0A=
 			data->ccd_offset =3D 0x300;=0A=
-			k10temp_get_ccd_support(pdev, data, 8);=0A=
+			data->ccd_limit =3D 8;=0A=
+			k10temp_get_ccd_support(pdev, data);=0A=
 			break;=0A=
 		}=0A=
 	} else {=0A=
=0A=

