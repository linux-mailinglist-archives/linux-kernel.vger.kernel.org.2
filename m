Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6833064BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhA0UEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:04:02 -0500
Received: from mail-eopbgr00122.outbound.protection.outlook.com ([40.107.0.122]:15844
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232392AbhA0UCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:02:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MffwwbjgMiXCNM1vrqAJVSiMP9vJWkkJdU4rhhygIA3MG3QLCvNBzbaVcPkeE5qa8xicwpol41gBjVfpBDgxzyjdtOhClWEvecT+ZWiJ50G9M94lfzUnMXndpBRMyAXrgtH0NtQiO/OUnVbQoPmCp0WnP9UdSLyJzhIUwp9T7TjaLq8YhS63CrhzFb2K8sh85hyHvFTfrRavikkyIKJKignTKajeKbwC1A0RkBup/7eGk5iRV64vHwwug2TX2g97vvGCFXuXJzbyXp0IzAewGjt80aWihymf0JlL7bHke60hGLaTTw8zzNkO2Wb5QdB8ttMM/T5h0AcuaARV3YjUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n29PwTQhyVPh2XexqqS/FJO61dqnTbkiFJmx7vJvt18=;
 b=fgXhplOCGVOEO4Z2UwwRmw+6iTsM1VfLYabu1ZA/QL4acmz73xo1fLJ829czfevcXsEzjXKw8Hwa4kIg1cMT1Gx3eCHQVBCAVn5s3wnbK6Sy72B1cfyBtMZGOdEi3glfTk3v2VFfPbQGCPX5HrGjKSAPlHlv6Q4cRdXcKJ1QOBHtgAcbaF5ZDSSU3dF6qpxC6AmITw1DSpXL3U/n5/2lbWI+IKF49g9X3E2Hb7odL1UjK7vFhQ/zG/lcYgPgxnyEASyHhoqEyVfl09qBasbBtQHnzhszG28m64uOXbIO9xoSHbdp8L4DAk3jPEAl/AJdX8k0t9S4zIZ6Yg4/4KgHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n29PwTQhyVPh2XexqqS/FJO61dqnTbkiFJmx7vJvt18=;
 b=wECIcyRPdMldd4KyguT3ALRhkNi0GgMqt1hTSdT9Xj94cZwxBBfJDWNptVBjWDssqt8SFqa83vZXpZMlqRdC0tMWdlQlmmVIlXCqUdlQER/fjhop8eOdd7Hg9ePLK5i2NnizIyOLgj2MYoR/VX3IyaSv1AZCu67sYO9pdrwb7zg=
Received: from AS8PR04CA0230.eurprd04.prod.outlook.com (2603:10a6:20b:2f2::25)
 by DB7PR07MB4058.eurprd07.prod.outlook.com (2603:10a6:5:6::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.5; Wed, 27 Jan 2021 20:01:26 +0000
Received: from AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2f2:cafe::e7) by AS8PR04CA0230.outlook.office365.com
 (2603:10a6:20b:2f2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Wed, 27 Jan 2021 20:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 AM5EUR03FT049.mail.protection.outlook.com (10.152.17.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 27 Jan 2021 20:01:25 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 10RK1NYi025069;
        Wed, 27 Jan 2021 20:01:24 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ARM: mcs_spinlock: Drop smp_wmb in arch_mcs_spin_lock_contended()
Date:   Wed, 27 Jan 2021 21:01:09 +0100
Message-Id: <20210127200109.16412-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20210127200109.16412-1-alexander.sverdlin@nokia.com>
References: <20210127200109.16412-1-alexander.sverdlin@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 806bacf2-b15c-4dab-bee7-08d8c2fe5407
X-MS-TrafficTypeDiagnostic: DB7PR07MB4058:
X-Microsoft-Antispam-PRVS: <DB7PR07MB4058D480660BE2752ED8B10F88BB0@DB7PR07MB4058.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elwemmh7PhV22eXQamM6s3LryH4BAoozeH8FXrFuJlb86YwdyPpNgKfATUQOz2E9a0ORgOd24Z44BUEEtizkLKEs/Nj3ny2nIDf7PZttmFvFb5j10DKlFvPQDd7Lwpei0yPUpyuGyhLKXzwk4TArG9m2sKzTLCLy1HhQFpFAT7wCEDpZtwm0LKnwN/wLmlfL4C9gZsBwb08s9xkLygOxs7duepjWeT1+XFSZ/P//Af0EU3OlAjovclaOCI/N1BdACscZoAzaRWy58NRYFqz/14fcArHBj2iytzmIrOLTyWvLMJevycHCXdo9lP8baOdfDNTwmR5uSuYdCrqKPUw2W2qGWW4YiFEoqZre3EfY/e1XfFdm9WU8wWopAKyF9YBG7EVyx2LuooW9fSiyRSJIYOlqYfWDgpUdII1vopyGpOtCNnQCL2hCUUQTkgiljadkj1JfYnRKGxIB4Y//+zGzCC4EYp1K5T2n9Ct8IaMt1S1rUND18tEGywAZSa4zMULKbNcbTD/go8vInZiYRy+bg+006jZS99sTUSVMFYVqIuJY4Mpst2uZiR91q85uhUd18nbAFgUnGP0nLocedbzEFY4LMYL20t4SH2eoEdm24Q/szjRbUSe88Ii2PzC9ToMH
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(70586007)(86362001)(70206006)(8676002)(4744005)(356005)(8936002)(82310400003)(81166007)(1076003)(5660300002)(2616005)(478600001)(186003)(82740400003)(316002)(36756003)(110136005)(6666004)(4326008)(47076005)(83380400001)(2906002)(336012)(26005)(54906003)(36610700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:01:25.9581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 806bacf2-b15c-4dab-bee7-08d8c2fe5407
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB4058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Drop smp_wmb in arch_mcs_spin_lock_contended() after adding in into
ARCH-independent code.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/include/asm/mcs_spinlock.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
index 529d2cf..d8fa921 100644
--- a/arch/arm/include/asm/mcs_spinlock.h
+++ b/arch/arm/include/asm/mcs_spinlock.h
@@ -8,8 +8,6 @@
 /* MCS spin-locking. */
 #define arch_mcs_spin_lock_contended(lock)				\
 do {									\
-	/* Ensure prior stores are observed before we enter wfe. */	\
-	smp_mb();							\
 	while (!(smp_load_acquire(lock)))				\
 		wfe();							\
 } while (0)								\
-- 
2.10.2

