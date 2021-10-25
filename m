Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A4E439F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 21:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhJYTW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 15:22:29 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:25569
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234572AbhJYTVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:21:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGs1lzYr9Qr8EJe8gs4N3ayM4ThtpHVi5XaK6zQu4qXlU7gdeDjAPodiSvXEU4u4bsU1VK78Y3KCoFC/1tdeEf5BmANnmVgTEK7yGWyBuvIrbuoeM7+mDIB468VjEEI50TWv0ux1tm7DiBXpCwAfij7S9QC6gLJk+kJ/eUIvIhu0bkNtw8Nlqy2aRAf8BuPTlVZvihkAB3E65T+49uAn72NZV4WnuO+PzKP9oH0uDoeuoJkV8xi6BRUUD8AuUEOehr1NLMbbYJvHY7DLQ2w7oeT2iNevFjClp++k0x01a/Q940c3rWYNUPmQkqNpwVw50iWv/g77oA9SsHZbwbFYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTurjpcNYP39X9y6Le7vwhO3mRyFdR3OVnRo3qvUvSk=;
 b=cX7S8ZxvjVc4wEwPauKIczyEgjiIHc3CkOR+B5WiR1KjvVXu1wSVZ1Nivjn4YttUdLwSbmNPZaMBaKxvwKTDt8SWNqBqX+82jAFnFswK2KHFg249IhjHuuFPw4t7bLVgg5n9RsFFWkJsrlgdw8tN5zCv22ZsKXej0vKK9AP/8VitN7ciwRldunEme1RfzQ4cj19+LpUvNbhRSybK93znWMVs0umocB+UVdebm9rRM1gSMw3puyblSxmb4f2okbDNvhe/Ii5YWRWKHeIeLZ4Q4tiNc/LpM3GAHEC4krE1VheMVE+efCpaimNvWRmJcAfmynAZuIkhJdQ94Tdvl5lsMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTurjpcNYP39X9y6Le7vwhO3mRyFdR3OVnRo3qvUvSk=;
 b=eOXp9QnxcsleI5fZBCX9fbBwoMz6jeqvhzdpItMdd5NdpLH6t0F1DmhbKzf9m9PUnHQJtLY5OkVGa+hoAiSVu1MVDTAfiX4z++Trru6Fxl/73Fa+4Mn+pST31QQvanw3w8AhfS9jKJHLd2oJ8mCA1unqpn2RaDu0ls/q9GLXpiA=
Received: from CO2PR04CA0179.namprd04.prod.outlook.com (2603:10b6:104:4::33)
 by MWHPR12MB1407.namprd12.prod.outlook.com (2603:10b6:300:15::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 19:18:48 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::1d) by CO2PR04CA0179.outlook.office365.com
 (2603:10b6:104:4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 19:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 19:18:48 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 14:18:43 -0500
From:   John Allen <john.allen@amd.com>
To:     <jwboyer@kernel.org>, <linux-firmware@kernel.org>
CC:     <john.allen@amd.com>, <linux-kernel@vger.kernel.org>,
        <suravee.suthikulpanit@amd.com>
Subject: [PATCH] linux-firmware: Update AMD cpu microcode
Date:   Mon, 25 Oct 2021 19:18:29 +0000
Message-ID: <20211025191829.22242-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbf70e4e-8785-4df1-23ba-08d997ec456a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1407:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1407E2276D291691C1E0A81D9A839@MWHPR12MB1407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jj42LiVzdc9HrfaCWU8clPs3hueByu/Xr+6eZAZGAtYv9px2Gg1TTOJxq8q4DMyFMlADV6hCupxbTluMSfl1KI7YztSS6g2XFi82BcdQYKcG62H+5DFzNgV0ogYoxLV6gYwb2jWdsk6W8945Qz/Kk4bEfC9RQsXHaGhL/FNpGl+UDQQkSAFVsi+x8WY7FcAdSrqGbbGzwak2DHamlS6iyO+wx3TcXa7hwoWSfH8CnApcewWTlJmsDXggTR/KkfchCWv5HcOKtdaxiRIe6WBhg71fY2QdTKmux0Lh/zPI7z85a2f47CtjFlUtdD+ktv53sg2IZonx64tNBZ7onwsk3rAMg3VQmMeRTXTc0KIAxay+FukilrZls2Fh1X5I0I2JHCv3ychM57GPL3l++gqUdpZSoIlfl3EqpIT3OO6W0sOdxt7eSMAb9oPgLxatbxKFGiyrVDgix+q+FfCDlH0A0Y8QQ5gnrUGDko7fYf1ZO7Z2LGa1j6XNQ1hTUtB/i9R7YvowziWpiVJ62qXFxdb0Yh1DmxERQyZ8lOwwRI8skQ3xjCyYJQ87Nh7gfqXJxBDu1KsRor5G8ft7vyRgj5NrHMS0e+DQ910XongplClZe1oPPH8sAgiltlnBJ4H8QauOzti26onOLsFDHLGjT12rYXojTApK1jiEI2yXttdl3l75RLYDM5muxn71DqNC8IkunyfKFJTL/lBWszGL+/ZYlWwb+x8e/6l6Y5O+gsYSbtU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(81166007)(7696005)(82310400003)(36860700001)(26005)(8936002)(16526019)(83380400001)(30864003)(356005)(6666004)(336012)(70206006)(4326008)(70586007)(2906002)(426003)(54906003)(110136005)(186003)(5660300002)(1076003)(8676002)(86362001)(36756003)(47076005)(316002)(508600001)(2616005)(4001150100001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 19:18:48.0276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf70e4e-8785-4df1-23ba-08d997ec456a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1407
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add AMD cpu microcode for processor family 19h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73
---
 WHENCE                                 |   2 ++
 amd-ucode/microcode_amd_fam19h.bin     | Bin 0 -> 16804 bytes
 amd-ucode/microcode_amd_fam19h.bin.asc |  11 +++++++++++
 3 files changed, 13 insertions(+)
 create mode 100644 amd-ucode/microcode_amd_fam19h.bin
 create mode 100644 amd-ucode/microcode_amd_fam19h.bin.asc

diff --git a/WHENCE b/WHENCE
index 67ff1f3..975cdcd 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3979,6 +3979,8 @@ File: amd-ucode/microcode_amd_fam16h.bin
 Version: 2014-10-28
 File: amd-ucode/microcode_amd_fam17h.bin
 Version: 2019-12-18
+File: amd-ucode/microcode_amd_fam19h.bin
+Version: 2021-10-25
 
 License: Redistributable. See LICENSE.amd-ucode for details
 
diff --git a/amd-ucode/microcode_amd_fam19h.bin b/amd-ucode/microcode_amd_fam19h.bin
new file mode 100644
index 0000000000000000000000000000000000000000..4ad1a9184917a02d9a157eb7e5bf85aef5422a1a
GIT binary patch
literal 16804
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
J|34h}e*xH%JzoF-

literal 0
HcmV?d00001

diff --git a/amd-ucode/microcode_amd_fam19h.bin.asc b/amd-ucode/microcode_amd_fam19h.bin.asc
new file mode 100644
index 0000000..8d1f6f0
--- /dev/null
+++ b/amd-ucode/microcode_amd_fam19h.bin.asc
@@ -0,0 +1,11 @@
+-----BEGIN PGP SIGNATURE-----
+
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmF289sACgkQ5L5TOfMo
+rnO6lgf/c8PwHjZfOljaOQ723oEVEICOBCuS8i6HJwvjI+2usC8m0TppZunU2TZ2
+QPB8hAR//ZyXiv1P05cpG1bB9Rs4d85HJHd9OQgfadCUumIZ+xGaxukG6ySqUJsv
+P8K+gycVKtvB0z86oapMfkJGqWXS56kKgnmLDRUqJ3w8OjiXWC/B797/xR+xHBwH
+dZ8N62vKZPC+R7yg+CnbChnB5gm1hJptQ+f2k28h/2uhLxIAsUtKTSutrucl033K
+4J3Vqm+W7lpi6ZELto83+xvqyHnvNJEiTlIhuC8XKY15egJmyuQO1D8OAtLNVpaU
+xaBMkxXybOXn2zvdm3f1LFwfg3+t1g==
+=c3kg
+-----END PGP SIGNATURE-----
-- 
2.25.1

