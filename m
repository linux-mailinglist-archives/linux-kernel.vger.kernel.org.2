Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DF045C978
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbhKXQGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:06:36 -0500
Received: from mail-sn1anam02on2061.outbound.protection.outlook.com ([40.107.96.61]:10431
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229961AbhKXQGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:06:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR+z47ubrz4vyMcHV3y/0yUB4AEu5C0Coxux9BgSW81e0PQjP5AUe7bYJPzNt3PRKgPKa1qlk2hMlrLHfmU1mUNQKf0Bz+jHG/gC5A49oT9Eec6LLSB0M0N/0U3KS18UhVTCrHPJk09ZnZH1mYkfdouFpS3uQ1iL0cEwnbIuFmsQTGzK24UXMskEjOEUaE1/4fJcgMDJHwaeinae2VIptyV5tAxxsyumg5yycw/NMsQ2gQVhybYz1aSFn/mCDIUB9Dk6RqyN+SlPrPD3dPLFcZ1fWRQD+Zbrdj4UlqyP2Fr4B8QOq7fbxeUeBy8iAVVeGazklVqL7qvrRIsQkjvXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBHftbLvocSey+dJXNRqAy1saukbwhnpvwoNajaaePo=;
 b=GlYqvWxzK8EQMQBqaHNx6ccI46QGbvYUCdkpaJexrmxCgAfrSAde2x1Buh71mPXUkMdFdvuFt12YZwLA4Be6zkbPxxGX4g8rIZeirz8jy/f4SbuC+Zi4UGqFmiUMz1QqnhyhyMakuHxcKi5huUZO8hwD6rggmpBqg8i0X3Q0ooYsKU7YBKA5hXTXflZoAHFvqe5/4DHesLN38frV8ozUivBXsGKbZyDQ6nqgNNxKGRLKPvEilhJahdwiDidw4NiIBtbLgDI7xMW8sQ9avUw67AA1QzKFJP9/7cxrP/FOHDbpb0A0jQzINp75FRfurYveBb5eCkjU55zeOoppsuo2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBHftbLvocSey+dJXNRqAy1saukbwhnpvwoNajaaePo=;
 b=brN6sGytj4dWRrr/BNBjTOD+KvBvXqRihMDn6m+b10bjNNe/m5n63wCwqB30vD5zTnO7wrqbq7KrjHEpd8KJuFlc0vFO8kIyLDj0qL8KAXuWHaDqiSOWyomm+wL6PRh5UtoiuZxoUajLD2q+Rc2jv6DaQ+ubHhdVwEcIfXwU550=
Received: from BN0PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:143::25)
 by DM5PR12MB1402.namprd12.prod.outlook.com (2603:10b6:3:73::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 16:03:23 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::d9) by BN0PR10CA0007.outlook.office365.com
 (2603:10b6:408:143::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24 via Frontend
 Transport; Wed, 24 Nov 2021 16:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 16:03:23 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 10:03:14 -0600
Subject: [PATCH v2] hwmon: (k10temp) Support up to 12 CCDs on AMD Family of
 processors
From:   Babu Moger <babu.moger@amd.com>
To:     <clemens@ladisch.de>, <jdelvare@suse.com>, <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Nov 2021 10:03:13 -0600
Message-ID: <163776976762.904164.5618896687524494215.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9b7ddaf-e7dc-4467-8ad1-08d9af63f13e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1402:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14028C1AD27FCE01DB0334C795619@DM5PR12MB1402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPsM1RAeEr8XjJIuFTCruIFbB7bQSSfm/hUi/hSGpwqCDN4Du1XZWLGKKbzIYQDMqyG7U7kDMzTyFUho6h9DQowQtr3gCwlNlUAu9wDxqJv2kljpSz5mXhEm2DKOfpk1citPcq6Mln+OesBgdVRuLbs3qyn+KkXcB6UrGg+POVxou+37DlfZufNA048TUme6Xqp/UA3gqrvuxHXSvbi7HRXGNCeg1qsoVbBNy3jPPiOpjG+Y1SVi7sjqMqc6sCQs3UUTWIzl4cDmXPcuGMMVnV5QCEa/bd32tCBXVYN3E1MFdzD4s6uFIO5tUMqbZMKJy1o6u/e8hTUwp28/XB2uTDmVtBqMJX4JeexpZ8GB8FaK5Xw/3hoxNTnc+IiTVWz9kIuaMvW+0NIielAl2A8QtyfFlv1mAvPxuAlrHKrECbN6s+p4v1ZBIr+oCfF0lbv0Ix90GPyuFv9W8lvZiRllE9GHewRBQy/o4G5qEOl0lp7oYK0Hh/teVVNGZ1VxMd+YGdQrOZ3xly+cdD97z17rBRxR8BwQ98pBwuFZFEaamGWtaInjaOPG6t9Y+o2fFAXZ9T/Y8HcIWOgyzQJneQNLL/cQ3b35mGQHbQtXsJN6zu0LzKtlhLUopiOfhbR0EExLs5y2JmPwTQQsEz11+czmRUY9ljcwdLX6IkYJ8FoZx4lupZ2I5XEOsqia40BjNyLf36S0FgvVsbQP3NAoOktdnKPxTQR2qjYvvgkNF1gzrZ+3rEBpQOXc6Wihzl/qNfPEWiVvMtgwCDTwPkctoe04yqDH+Z4Zp64xoqbM9Xz9kyJy0jnBSJILLQzuzKS0i/Qg/gOY8LOfoDmnoo7Bv4KqjpFpF+Gmg7UzzbyAaisF7NU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(7916004)(4636009)(36840700001)(46966006)(70586007)(70206006)(44832011)(33716001)(36860700001)(4326008)(186003)(5660300002)(9686003)(508600001)(356005)(81166007)(83380400001)(966005)(16526019)(8936002)(47076005)(26005)(103116003)(426003)(8676002)(336012)(82310400004)(110136005)(54906003)(2906002)(86362001)(316002)(16576012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 16:03:23.3247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b7ddaf-e7dc-4467-8ad1-08d9af63f13e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver can read the temperatures from upto 8 CCDs=0A=
(Core-Complex Die).=0A=
=0A=
The newer AMD Family 19h Models 10h-1Fh and A0h-AFh can support up to=0A=
12 CCDs. Update the driver to read up to 12 CCDs.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
v2:=0A=
Removed the date structure changes based on comment from Guenter.=0A=
v1:=0A=
https://lore.kernel.org/lkml/163770219414.777059.5794961910830381329.stgit@=
bmoger-ubuntu/=0A=
=0A=
 drivers/hwmon/k10temp.c |   17 ++++++++++++++---=0A=
 1 file changed, 14 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c=0A=
index 880990fa4795..4e239bd75b1d 100644=0A=
--- a/drivers/hwmon/k10temp.c=0A=
+++ b/drivers/hwmon/k10temp.c=0A=
@@ -171,6 +171,10 @@ static const char *k10temp_temp_label[] =3D {=0A=
 	"Tccd6",=0A=
 	"Tccd7",=0A=
 	"Tccd8",=0A=
+	"Tccd9",=0A=
+	"Tccd10",=0A=
+	"Tccd11",=0A=
+	"Tccd12",=0A=
 };=0A=
 =0A=
 static int k10temp_read_labels(struct device *dev,=0A=
@@ -206,7 +210,7 @@ static int k10temp_read_temp(struct device *dev, u32 at=
tr, int channel,=0A=
 			if (*val < 0)=0A=
 				*val =3D 0;=0A=
 			break;=0A=
-		case 2 ... 9:		/* Tccd{1-8} */=0A=
+		case 2 ... 13:		/* Tccd{1-12} */=0A=
 			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),=0A=
 				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),=0A=
 						  &regval);=0A=
@@ -341,6 +345,10 @@ static const struct hwmon_channel_info *k10temp_info[]=
 =3D {=0A=
 			   HWMON_T_INPUT | HWMON_T_LABEL,=0A=
 			   HWMON_T_INPUT | HWMON_T_LABEL,=0A=
 			   HWMON_T_INPUT | HWMON_T_LABEL,=0A=
+			   HWMON_T_INPUT | HWMON_T_LABEL,=0A=
+			   HWMON_T_INPUT | HWMON_T_LABEL,=0A=
+			   HWMON_T_INPUT | HWMON_T_LABEL,=0A=
+			   HWMON_T_INPUT | HWMON_T_LABEL,=0A=
 			   HWMON_T_INPUT | HWMON_T_LABEL),=0A=
 	NULL=0A=
 };=0A=
@@ -433,12 +441,15 @@ static int k10temp_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)=0A=
 			data->ccd_offset =3D 0x154;=0A=
 			k10temp_get_ccd_support(pdev, data, 8);=0A=
 			break;=0A=
-		case 0x10 ... 0x1f:=0A=
 		case 0x40 ... 0x4f:	/* Yellow Carp */=0A=
-		case 0xa0 ... 0xaf:=0A=
 			data->ccd_offset =3D 0x300;=0A=
 			k10temp_get_ccd_support(pdev, data, 8);=0A=
 			break;=0A=
+		case 0x10 ... 0x1f:=0A=
+		case 0xa0 ... 0xaf:=0A=
+			data->ccd_offset =3D 0x300;=0A=
+			k10temp_get_ccd_support(pdev, data, 12);=0A=
+			break;=0A=
 		}=0A=
 	} else {=0A=
 		data->read_htcreg =3D read_htcreg_pci;=0A=
=0A=

