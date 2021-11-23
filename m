Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4015D45AE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 22:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbhKWVUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 16:20:04 -0500
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:47585
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239281AbhKWVUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:20:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNtO6CVCcQNoFiXybFOuAvnVFLV0Vu8v8kpZ1j3LlO2Tl5oRAEozNm3tq7M0pFtf3KxsopgXYi9VLgFNJJvWD0DqipSKnoJhSLM61qG49PlmMLNrMl8ASi89HEYeY+PztDHzjwxwNhq87x2uqY4HB8pQUULNYJErlzgRnmE+lcn3CBc9KYJKZtTRzao8XyxyD0ojlboFBYqTittjC0+aBtSzdagFvCDvI4AUjznFNSXPYyVJOtQl1vvkiga1TpIJbBiLV4lXB1W3dLvnZvJ9163a7OqxJddefWSUVyYQBNzJeK4pukUF5ft4M/h6KA/WtXpraLRLK/EOUhl3md+fGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNNadnQacmsXi9h43nNDWzREnDzpWVuWvhQdjVzJjcI=;
 b=IH5wyANirW7qpBbbR+vCPI/WT/nxUWKbISYWvsZE9TfiwY2crwvTw4QTSOpEp71SJmlhNPJ7GMYB1KtrL6DXsBL70drPynbdYcBXkls8QTwF07h5X0DAd+Iu+IzUlgBosRI5pJJLHk4rHr4h79RUJcRRVjspeu1ijOZ7HvCU7/X797Dq+ujJj/8RxvCX9v8gbWuxH/mD1C+q1wD3fPROTHjsDeSZ43GGQgwf5ROGsuFYoMJs12Xc32K86d0YfoQuFVJtjCYFxhFop9iwp16KDDL13878WtIUF7WmW7PvGo9gUyYUXNWLHqP5eW5LhOh+BGb0PKVt/OIeL+6pN3Jt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNNadnQacmsXi9h43nNDWzREnDzpWVuWvhQdjVzJjcI=;
 b=z8oI5lpyfeUnPFMrc+QLmzp8U+JO9puTW7w15yCoHPyh7eZ3Td2J7zQVIilzhfnCNGv2agLUNtS+xFTPyK8FY3WMtZpvZZaYDqDwVafzKUh5Z71GrRpWjTYufS2qT8dKIcLBREpu6d0BOKLvIx2NNJD+y9xVoUJORUfy4C9Trlg=
Received: from BN0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:408:ee::20)
 by CH2PR12MB3989.namprd12.prod.outlook.com (2603:10b6:610:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 21:16:45 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::e9) by BN0PR04CA0015.outlook.office365.com
 (2603:10b6:408:ee::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 23 Nov 2021 21:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 21:16:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 15:16:44 -0600
Subject: [PATCH 2/2] hwmon: (k10temp) Support up to 12 CCDs on AMD Family of
 processors
From:   Babu Moger <babu.moger@amd.com>
To:     <clemens@ladisch.de>, <jdelvare@suse.com>, <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Nov 2021 15:16:44 -0600
Message-ID: <163770219414.777059.5794961910830381329.stgit@bmoger-ubuntu>
In-Reply-To: <163770216907.777059.6947726637265961161.stgit@bmoger-ubuntu>
References: <163770216907.777059.6947726637265961161.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9bd9a34-bfd5-49c2-66a1-08d9aec68dee
X-MS-TrafficTypeDiagnostic: CH2PR12MB3989:
X-Microsoft-Antispam-PRVS: <CH2PR12MB39898F159602414F2C1796E095609@CH2PR12MB3989.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmVXHXCm5alu+e/g6BiIWQmXuvcF3aRZ3antmAmHdL+IUcoYGC7hOnmFWr3FOrNxqcE0HR0A1Jn5Iy/ceF/jK6O5K+FKu0nF2sqMINEfG+YSSE8mMeFu+eB1dZ8D+gfOZsJGdhdDPgnhid/v99Of825uhDfOWlR2AEWCSgmxO8B5W7J5P9ZW+HDDq7GNerG0kdWYkPQx3WcNcp6PSIJ1EvYRDXADgE2mbl4OYC1xFCr4CLrcOkYripUIWmEqeGZzFQJs/Hb+PC0r8UFdgOC7p5ecF2HVmrOyel8kMvjEpOBHML0ZwTSOKkSV+lMUDh9ygm7IfIaiPlt5wecn9b1LuEzC8d91ckaEbf3MSuVnDhZ0PqcnAPK1rVLQFPJHVLJmWsdHuMfNFnMsBOndr+K37K3Zexwflo6GkMHQ4JjSGJEWWwPlvGX1MOfJwsD4V/hKsrgsWuIYYWneyeCh+/x4YmCaE4P+bOL7clRU8aHQpnuu4oj3eCXO1X7ukB52KfiJJM3cvLNNhXKcztLc+P8OfeNF+UWUyoZorcTOPUANUK+m7PE7H9b/QSe0Ib22IvzSu0/mwDzJNnz54YDWOWhg9ywocjRO/8qJ40Jz2YACHKKkfmEDDb4rjGC12RQrU/ws41atGXWej+5cr32VG6nbrgkYuLdpKF7OIf3uXIjArVMEVpaErbcqYgxU0CmG/LDwveRiY/0hQkiox3NT0LbGTs2HBIHoImjV/MwQSA4Dg+AmsrVOe/1UXPLti4HR9x0CjQ4MCs+LNbKP5dytsowywA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(7916004)(4636009)(46966006)(36840700001)(336012)(83380400001)(81166007)(44832011)(508600001)(426003)(33716001)(8676002)(8936002)(5660300002)(16526019)(186003)(36860700001)(47076005)(9686003)(103116003)(82310400004)(86362001)(2906002)(356005)(110136005)(70586007)(4326008)(316002)(70206006)(54906003)(26005)(16576012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 21:16:45.7165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bd9a34-bfd5-49c2-66a1-08d9aec68dee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3989
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
Note: Generated the patch on top of hwmon-next=0A=
=0A=
 drivers/hwmon/k10temp.c |   18 +++++++++++++++---=0A=
 1 file changed, 15 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c=0A=
index bd436b380a02..d20159e082ab 100644=0A=
--- a/drivers/hwmon/k10temp.c=0A=
+++ b/drivers/hwmon/k10temp.c=0A=
@@ -172,6 +172,10 @@ static const char *k10temp_temp_label[] =3D {=0A=
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
@@ -207,7 +211,7 @@ static int k10temp_read_temp(struct device *dev, u32 at=
tr, int channel,=0A=
 			if (*val < 0)=0A=
 				*val =3D 0;=0A=
 			break;=0A=
-		case 2 ... 9:		/* Tccd{1-8} */=0A=
+		case 2 ... 13:		/* Tccd{1-12} */=0A=
 			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),=0A=
 				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),=0A=
 						  &regval);=0A=
@@ -342,6 +346,10 @@ static const struct hwmon_channel_info *k10temp_info[]=
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
@@ -437,13 +445,17 @@ static int k10temp_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)=0A=
 			data->ccd_limit =3D 8;=0A=
 			k10temp_get_ccd_support(pdev, data);=0A=
 			break;=0A=
-		case 0x10 ... 0x1f:=0A=
 		case 0x40 ... 0x4f:	/* Yellow Carp */=0A=
-		case 0xa0 ... 0xaf:=0A=
 			data->ccd_offset =3D 0x300;=0A=
 			data->ccd_limit =3D 8;=0A=
 			k10temp_get_ccd_support(pdev, data);=0A=
 			break;=0A=
+		case 0x10 ... 0x1f:=0A=
+		case 0xa0 ... 0xaf:=0A=
+			data->ccd_offset =3D 0x300;=0A=
+			data->ccd_limit =3D 12;=0A=
+			k10temp_get_ccd_support(pdev, data);=0A=
+			break;=0A=
 		}=0A=
 	} else {=0A=
 		data->read_htcreg =3D read_htcreg_pci;=0A=
=0A=

