Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BF540397F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351648AbhIHMJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:09:20 -0400
Received: from mail-sn1anam02on2067.outbound.protection.outlook.com ([40.107.96.67]:6484
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234758AbhIHMJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:09:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4jPVS1xKIpkUCcqFxqulvrhjPwphXxrQ0entkIl9W7cxu34kSlxCsMYtAO/PIMxniAjiSPT4E5JZNW1RvCqZ/jK6OAd+F/7gEkIW0vBylVxzHyTJ84ZyecHBTeDO7Q8LfpaOhZFHHUi8hYeLlvJjlZV8JfQZN0ZJN/IZpLv85plLjURy0AQXwIqGCqoxehbcb2RFl+0KIpMThyGcNlNs/9co9/6ruMmHffyRp5msPncvAyVOOpdf1ZPlmx+9+i/aCkFTPLGi5kf4RRhq59ulYCOHE7So86db5Lm/lrJyXcUr6ivG93HNFeUNc9AjHLW46qPy89kZ9KqcSJHLWSDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=D5FCET3Wp8p3gybuN1kkuN8hQgc+BvSH7HTjCKsS7Rc=;
 b=iExVqHeEyVHst281ifRC95a+5flLOjy8BJ7bGVnFwP6ovEp7KXt9gDEurns/8oZxOX69Jmdr2b//+qh8TuBIneMY5iAJvcDkIpL/rSXOZeGfd+SrTHX6fTtsWktxbd+0xhMXWdZrZxv5eWQHdSQFmtCURKxeCTz9L/62qnYrrSKhxFrLkpR32JWC2ura1Aj0NcTRCnPjPt6wB9x7nRscav1Ps6TgaB3pSnPjivMHan0IyEiEP6xE/0th2RJxsjXCTj+vZBefg77+cxUV0YkkSuAV1whAucBhAMxf4oUuJGlWpE4xoym2uxPjoaysDBKey5uZ5AloIB9EgwqlhCqeBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=perches.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5FCET3Wp8p3gybuN1kkuN8hQgc+BvSH7HTjCKsS7Rc=;
 b=GHPgkRlYJVsYWFlBxGyuJ8iW5FomiVuk2E+83kXlsT61OuMvE5LQ+3wi/+bkypgzGouPYf3mMRggYu4baduUFElMmBrV6tdBQjSksqMDMnaxRTnO5vxd7GpMJJdJoWj84mWEmVMmKG7cV3OSIOi2fIN0vrlLcQLphZJ+10422Nk=
Received: from MWHPR13CA0047.namprd13.prod.outlook.com (2603:10b6:300:95::33)
 by BN8PR12MB3155.namprd12.prod.outlook.com (2603:10b6:408:97::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 12:08:08 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::6f) by MWHPR13CA0047.outlook.office365.com
 (2603:10b6:300:95::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend
 Transport; Wed, 8 Sep 2021 12:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 12:08:07 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 07:08:05 -0500
From:   Lang Yu <lang.yu@amd.com>
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lang Yu <lang.yu@amd.com>
Subject: [PATCH] sysfs: Remove page boundary align limitation on sysfs_emit and sysfs_emit_at
Date:   Wed, 8 Sep 2021 20:07:23 +0800
Message-ID: <20210908120723.3920701-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66c399e8-e424-4ef3-bf77-08d972c15209
X-MS-TrafficTypeDiagnostic: BN8PR12MB3155:
X-Microsoft-Antispam-PRVS: <BN8PR12MB31554B255F1086166CF29EF2FBD49@BN8PR12MB3155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uELmwkIElq0jwAW4yS7i2rpb4CGFLJCanYyuNG75i/pgcKmGBzPRLcISAa39R6Xvgq8XWFAoXH+Zyz4wQ2rU907SrW+xQ6vzL58IgwJ/cXOf5OddPV6kiIlXC6KfnydK0YVZ0/Exgn8q+o0YLpA/zs0O/AUzS+VxIWkIakw2wiZ/j6CguveXrhyDfeonjZcC7fjytMmBfpOLsLOD9FgE8+OKfElEWDjd7vzl7I6+5dlrYaHFgYQ6Dw1kiX0XTMdq8ZkGBPsBhSVvpnWrMmiuhcHs3rY+Ed0zVM2DsXMD0hHovZdInMvLPDpS2eNN6wleeDzxnEVPNUM3Es7YcSrlNhFyXbYIAZ5Gn0KibFIJCD2L9kDYPt/l0PCjhLZT5+1o6yzQ68JQ0NMqzQtRZ6rjK0pfOzEroa5jLCmeFvvzyVWBHDKJWvVShiEulZNcuxg/agfNMapmu/dNOlMGi+OHty8SluHQ3DtLbPyGjZzBc3+qSZYtS8SbBoIBzV8Hxh/jUAe23jPAa/9iyitYIrLcM0AE+fOEYL29bDrIZiNCEyi1ckN3JkTCKl7K83vVyBNu8Yw9wZfGEyDi898vrshbczQGRb8+GaX4Rfn7CWQmTW638ZiDD3GDgaeOxazNFOhXl0J+vGL+kWwrj9e7NktgzPcdFlJP1udl/tL+W5+h7Kmhv9is7rlloJVeS3pnlQPvFqyWgHpEBmV0kUgIZ4gSnqLP10296mTmT41PAJKTMm8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(2616005)(316002)(1076003)(5660300002)(36756003)(7696005)(110136005)(478600001)(2906002)(82310400003)(186003)(44832011)(356005)(47076005)(83380400001)(426003)(336012)(36860700001)(16526019)(70586007)(70206006)(8936002)(81166007)(26005)(6666004)(82740400003)(8676002)(86362001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:08:07.8711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c399e8-e424-4ef3-bf77-08d972c15209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3155
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The key purpose of sysfs_emit and sysfs_emit_at is to
ensure that no overrun is done. Make them more equivalent
with scnprintf.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 fs/sysfs/file.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 9aefa7779b29..b754f2ef186f 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -732,14 +732,16 @@ EXPORT_SYMBOL_GPL(sysfs_change_owner);
 int sysfs_emit(char *buf, const char *fmt, ...)
 {
 	va_list args;
-	int len;
+	int len, offset;
 
-	if (WARN(!buf || offset_in_page(buf),
+	offset = offset_in_page(buf);
+
+	if (WARN(!buf,
 		 "invalid sysfs_emit: buf:%p\n", buf))
 		return 0;
 
 	va_start(args, fmt);
-	len = vscnprintf(buf, PAGE_SIZE, fmt, args);
+	len = vscnprintf(buf, PAGE_SIZE - offset, fmt, args);
 	va_end(args);
 
 	return len;
@@ -760,14 +762,16 @@ EXPORT_SYMBOL_GPL(sysfs_emit);
 int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
 {
 	va_list args;
-	int len;
+	int len, offset;
+
+	offset = offset_in_page(buf);
 
-	if (WARN(!buf || offset_in_page(buf) || at < 0 || at >= PAGE_SIZE,
+	if (WARN(!buf || at < 0 || at + offset >= PAGE_SIZE,
 		 "invalid sysfs_emit_at: buf:%p at:%d\n", buf, at))
 		return 0;
 
 	va_start(args, fmt);
-	len = vscnprintf(buf + at, PAGE_SIZE - at, fmt, args);
+	len = vscnprintf(buf + at, PAGE_SIZE - at - offset, fmt, args);
 	va_end(args);
 
 	return len;
-- 
2.25.1

