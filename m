Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05B3450BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 18:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhKOR0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 12:26:02 -0500
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:17714
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236832AbhKORNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 12:13:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IU4IcRhlpZvYrXz+8kG229hPggBWV5sv6elyyWCsjSbE8r4iWBGK7YISesoIWB+UfDhQs8oC46aIzlJpcsA3NzWcLBDiyBzfg3UpfgB273XcvA/h6y50yomZqjgg+kwLcMl49W5Ek7kAud/b24EU2b6VWB8dnQD/+D+rQSj9i4Meh0lvHrDumuSfHc9ABSoLdUaV5robAHjDHhXCup6/rINoI5K62i8kwM+ec2RpeYBCMTVPu4xkywHo5cUEd3IBk2jZiDZcGa7y0rfKIiB+SFJ/rZWuH7pMH7tpj8D3dhxE27eEV3hMMmGtvb5PBHDKNSto856vm/F1pV4TQsZ4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkqS8L+WWz0mcRgBeB4zPS3Sy6PX7+KXNaR1lwx0scc=;
 b=Ng5UnJIgFWXaUJA4SYIAkyxDhGnjVrpZuolXaUKc9TBFbTrUTzf5yz3AFHqz+ijttLA7SF3aMr+jtCDdt4q5O33bKihzKZILQE7pGhgv6uYtcUmh1MMWmEW0DOES0Alytg7RvsXYy0E7bfCbthf37l9Kaky1lOIbjulOqfTir3Y8gpLNVtlQy5g/2CBWPtbiIEJOND3+1KbkMk8nfHJBZunFQkEah5pYpUwM8IFFdCu7aHqeW4xxAWFqFTNoWWbR8R/iRf8u/n5UWRB3QzvOhgbHRa5vpF5UQxNWg1mlFndkuBhJVNdPpvFowXX9dqbP/aMcQoQuGEaBZU3UdnyVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkqS8L+WWz0mcRgBeB4zPS3Sy6PX7+KXNaR1lwx0scc=;
 b=DGfVNgJvRwga61faZGIl8AQ0bgwT77jjSABbxyhBaknmB9xfmxsxS5/NKT4jQGPO9+62HL3FkZc7dSmQhHSbnlbY2JZpSUPItXhYGt3FfsjKW7QtXnPFA1MDp1c0j3BBz7x49nUcbjoj573uOU182e9rcOiwbCujm/ORbkWa8Mg=
Received: from BN9PR03CA0338.namprd03.prod.outlook.com (2603:10b6:408:f6::13)
 by DM5PR12MB4664.namprd12.prod.outlook.com (2603:10b6:4:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Mon, 15 Nov
 2021 17:10:21 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::30) by BN9PR03CA0338.outlook.office365.com
 (2603:10b6:408:f6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Mon, 15 Nov 2021 17:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 17:10:21 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 11:10:20 -0600
From:   John Allen <john.allen@amd.com>
To:     <jwboyer@kernel.org>, <linux-firmware@kernel.org>
CC:     <john.allen@amd.com>, <linux-kernel@vger.kernel.org>,
        <suravee.suthikulpanit@amd.com>
Subject: [PATCH] linux-firmware: Update AMD cpu microcode
Date:   Mon, 15 Nov 2021 17:09:54 +0000
Message-ID: <20211115170954.95133-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01d5edb7-43ae-4cbd-28eb-08d9a85ace65
X-MS-TrafficTypeDiagnostic: DM5PR12MB4664:
X-Microsoft-Antispam-PRVS: <DM5PR12MB466447D524CA7B1FC685063F9A989@DM5PR12MB4664.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59eM26UuXaZdQqksvaIrxBwqKbuTFtQ18UzzHjqnc0TJT6P2+ga8lP8jdW4LmjhXkj1YgnFfFctlZIhxlCO7Ic2WRJ2PCI6sMOS6KPWaYuxCVN2w4nuLWrwC4pCxbp3nFiHRxJ5QYb/wwIW6yenx16BlNFyZJWOKvoqZhYj6ffpcFI6QTlve7viTS/v5qlPM56Fu+9Hgs2FarC1syyJ7eaWQnFCzgrZhhCzpb2jQFttl9N0rGrGwbWKn05tN0YcWBPN8TRhgRsC0R8236SPMsP/bXM4YbSyXALtNBds3o1t3hCeRHodKZY0YNNYsUIWHzQIHfn0iQ+AHL6OEhr9+ziBYbaZwK9lzR78ttGfQvIlTVSzg8AXK0sfMzM+drMfE7usoCwaH/ozfdG27HFDrDl8qKk3Tk5M/nSL6sidFZMndfoVTjmTZhO/1zwxDrMCVoMp1hC1BRk8emuyp7ZdoZmd/FpukGlXrRNmamw6czoQvkktb0CdecSs4CSRzSQOs7ApeA1/F7an23ak7mwjh84hwHTGTaGj2e1i9rlNcDrmve+X0mILDmFhXgjA1dcQPbtSLLXkgPZ/AexCJfh2t5DKmopZi/bfC1wAKad0HJ6XPMSPx6L2gsFZ5nxWofhPzpS9CGLYdMppBGtqpDyczWVPsbI39PKau3coT45sOqwi7z0dR+6EuJgDw8JqGLy9JYO6I3mUA6eDEij81cWisZZxdAaqohgONUFz0lkE4o44=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(4326008)(110136005)(8676002)(44832011)(82310400003)(8936002)(2906002)(86362001)(508600001)(7696005)(36756003)(83380400001)(6666004)(70586007)(316002)(47076005)(26005)(356005)(16526019)(186003)(81166007)(5660300002)(2616005)(426003)(4001150100001)(36860700001)(70206006)(54906003)(30864003)(15650500001)(1076003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 17:10:21.2345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d5edb7-43ae-4cbd-28eb-08d9a85ace65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4664
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Update AMD cpu microcode for processor family 19h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
 WHENCE                                 |   2 +-
 amd-ucode/microcode_amd_fam19h.bin     | Bin 16804 -> 16804 bytes
 amd-ucode/microcode_amd_fam19h.bin.asc |  16 ++++++++--------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/WHENCE b/WHENCE
index 7ece0af..1f0830c 100644
--- a/WHENCE
+++ b/WHENCE
@@ -4005,7 +4005,7 @@ Version: 2014-10-28
 File: amd-ucode/microcode_amd_fam17h.bin
 Version: 2019-12-18
 File: amd-ucode/microcode_amd_fam19h.bin
-Version: 2021-10-25
+Version: 2021-11-15
 
 License: Redistributable. See LICENSE.amd-ucode for details
 
diff --git a/amd-ucode/microcode_amd_fam19h.bin b/amd-ucode/microcode_amd_fam19h.bin
index 4ad1a9184917a02d9a157eb7e5bf85aef5422a1a..dd48655c4b88133131e8673a9b1ec97885b2acc3 100644
GIT binary patch
literal 16804
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
F{{pju6cPXc

literal 16804
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
J|34h}e*xH%JzoF-

diff --git a/amd-ucode/microcode_amd_fam19h.bin.asc b/amd-ucode/microcode_amd_fam19h.bin.asc
index 8d1f6f0..388b2dd 100644
--- a/amd-ucode/microcode_amd_fam19h.bin.asc
+++ b/amd-ucode/microcode_amd_fam19h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmF289sACgkQ5L5TOfMo
-rnO6lgf/c8PwHjZfOljaOQ723oEVEICOBCuS8i6HJwvjI+2usC8m0TppZunU2TZ2
-QPB8hAR//ZyXiv1P05cpG1bB9Rs4d85HJHd9OQgfadCUumIZ+xGaxukG6ySqUJsv
-P8K+gycVKtvB0z86oapMfkJGqWXS56kKgnmLDRUqJ3w8OjiXWC/B797/xR+xHBwH
-dZ8N62vKZPC+R7yg+CnbChnB5gm1hJptQ+f2k28h/2uhLxIAsUtKTSutrucl033K
-4J3Vqm+W7lpi6ZELto83+xvqyHnvNJEiTlIhuC8XKY15egJmyuQO1D8OAtLNVpaU
-xaBMkxXybOXn2zvdm3f1LFwfg3+t1g==
-=c3kg
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmGSiQEACgkQ5L5TOfMo
+rnNNqAf8Ct6gPb0w5sYBQluqsylE8MKPQ5opSLxiklGgCQ6Qw3DzC7VMsLHpt4sT
+y05AcGNgdXaj/B+95zWf5q4DkImjL02Q8aT5dy2RNzI6Qfz4muN2cdDR/LcEIMIv
+cJky5Xnu+cLilTJ4/7fk/IfAzXyqpfiHU/OOub3Yyy0ExFIdX+b7vmDEnT6prp09
++OjHU3vZRu54q1dI7S04GNIcI93yPUqmawBiqcHFy7mztoZdvefoA5K3/+hheWZV
+5ZtZjx8ms8c5H0neyWsPf+Kh0Mvdgo/RmhIlt486TILVABJbk0aIGMBzjmL5+tAG
+aXjIb/laJSlf3jPKCp+ZlI6nItlt1w==
+=qdN2
 -----END PGP SIGNATURE-----
-- 
2.25.1

