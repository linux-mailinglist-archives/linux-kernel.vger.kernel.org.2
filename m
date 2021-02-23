Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D6322713
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 09:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhBWI05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 03:26:57 -0500
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:60609
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232127AbhBWI0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 03:26:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSjg9PqUHtXCHY208H51+b/+kcJKr3p7gj2XWFNlL4KcS+1ovGM4zTdA8Y1Tyu+bEH3xKYw3jKkFzsEeDoHScZIwnWoFM4GnBP2l4ZvSMvAIs5V9ED5oXhJANjeQJl6uADt6mOdveWt4fiSlXTx6oNvO/fiOGoIJ0wPFrSGZB5YK2lOsOJ03m0lUMOWl2tExnq+7DoLGtjtQTwZgZMNgCuKO0weNTgoSvtzhLmsJ91bCo6wEG+8hhAQbxjZARyz1GP/pCMgUodbtsN5/2BZRFPxFq+LkIkATUuxQrdyCxRPAsKrLB2E1daEBZNkPiS15ej6CMBmSCYeHZbCLCnlFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlX64pFI4xchQAa4ixY4HiquPPDyxaOtGM0lBJxoM/M=;
 b=RkPd67B7AxEbRLuD3n7fxQ8xIoSI/+OJJFKjifYeamsLGZRYlTIDUThcfan1SUbJs0fwNwkfINsEjjmFGrPYBfuWohwTGgfRaB2qpH6mWllYHwiQF2DsYEoxRmEX5RAxqoZzj2ud2qMZW96IPTQBPEdyWy4c/bVQWkn0ZsJ2MNsp+O+XtpViv6x3H7Qo2MjEMh1CB4D4/HxuQlPGXppIKAyIp0u31IQ9us9i9MeExSHr3nFftez+6aM3RRMKw9wfKzud7RUJQmSUKCasf7zZAJZSVwgq61CKaRgHkBb0WE7rTXPC0wBpCxgJ2++8+Z4qmQB3+YRC2PIZ6Zk+57r1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlX64pFI4xchQAa4ixY4HiquPPDyxaOtGM0lBJxoM/M=;
 b=RXTaByqzTgXRW4/b7skciwg+MHWuiLKKsY4Nx9FyMEEnwd/u0v/5gVFjOrgshyqGSAqVeJ9Bz0dINVFfImLt9+22Sjv5iArSfuNWQ8UjyUyEFNAdRVm2oZ4L9JrUHrgH3jG+fEPbjyb+c/r+lGQkyA7beSjXhlCOjqebGpyRPPE=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by CO1PR11MB5171.namprd11.prod.outlook.com
 (2603:10b6:303:95::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Tue, 23 Feb
 2021 08:26:00 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::ad02:3dcf:d3e5:b27d]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::ad02:3dcf:d3e5:b27d%10]) with mapi id 15.20.3868.033; Tue, 23 Feb
 2021 08:26:00 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf tools: Improve EOPNOTSUPP error reporting
Date:   Tue, 23 Feb 2021 16:25:35 +0800
Message-Id: <20210223082535.48730-2-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210223082535.48730-1-zhe.he@windriver.com>
References: <20210223082535.48730-1-zhe.he@windriver.com>
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:203:c8::8) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by HKAPR03CA0003.apcprd03.prod.outlook.com (2603:1096:203:c8::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.8 via Frontend Transport; Tue, 23 Feb 2021 08:25:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c9b4fca-de18-4070-4a76-08d8d7d4a6da
X-MS-TrafficTypeDiagnostic: CO1PR11MB5171:
X-Microsoft-Antispam-PRVS: <CO1PR11MB5171A201B456342AE52F67F48F809@CO1PR11MB5171.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75aZylm/iSzwMifJXUBzxwqioGWz0zXPcXs1asntCWHI1kFyGgcnSvoku0OwKRb4wyy5i2zrwzcRwzAVHVjZhZ08r2s8QidrG7UCf+EbOr0RRjkIJnj5Khz4lZqv9Kt2DFaEfco7SlpvFScscfSn1SIbby6Fpa2qgQOuA+S5AbvKFtX5QiMtkO7bT7ZJCUhL60jjEISBd7kelmUqKcM9fxtyF+TRQEuh1zbmS6PKQcr8kIGfLlCwlmxwtNw4frcwfUFktEyQnwCA2tp8+1qTgstV9O9RdcNXb45nqZc//UqC78A/nrJpzGWhcRSNxrldfY247YLjuW5AAGLlUFFFH14Ab9aJerOCTmo6yJtyIYIvJW/g3b2ADkSH8c4k+mqGk5cKqgP3rH4BJxUt4qxft3yqXvfmMuM8guooyYANdwv/Y4DKaoQWX+7dFDtIQseac4NOR4m/Dvf8UDHiFpVfapVFJDu3r+BO2dvxvY3mV+3/T6Tuw5OZXfu8C1hSSoUzRSHQXPoCCh86KSzTzYBL/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(366004)(346002)(136003)(396003)(2906002)(316002)(6486002)(26005)(52116002)(66556008)(66476007)(66946007)(1076003)(6506007)(6512007)(186003)(8676002)(6666004)(2616005)(83380400001)(86362001)(36756003)(5660300002)(16526019)(478600001)(956004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2yEaasxrdhH1omg+PrY7gsk/l7zUdEV17R8LctJpqu1UzCgAkV1CfIRzU29H?=
 =?us-ascii?Q?/tAOFlKLr3PHBrsrMopAlxppyAh9bmjLkFJ9WcA1bz+SNn5ZebB2quQvzujj?=
 =?us-ascii?Q?Ap98Im8/UcTJ9+DRWD12WRp3LrABwRDNyIbq5YtqisRex3O+PJs6dFd5MRhU?=
 =?us-ascii?Q?t8VbzFzdNPIUL+urKtQDhf+5zEuSvDWLt3fnQ6fIwRDje11ueQCdNGamfUmh?=
 =?us-ascii?Q?KR7vuU0U+6Dd9OaSXwushPqMTIpqzyi+fV46w6gOvE1nqzZ58bZkVUII1FO9?=
 =?us-ascii?Q?NIbLPga1vlPIO1ayvYMlYJFgY/GPf3b3r6yEhQM5KUV8upP+2en9XHPnjgb6?=
 =?us-ascii?Q?+tAeX1xaM7FUVMwU/q5TtpkRYx9znlJPUki6R9AkMQa+pAG23gDcOs64wwcH?=
 =?us-ascii?Q?JKWkfPEMuozQdlkhH71qQkpeGDaP0ucPDy1/DjfWcZDYDuo7XRZZQKbc3uMh?=
 =?us-ascii?Q?Vg34vPRifRhkOT0VZdqOwZo5w0DZo4MhxeZ/eAzpXw7RTyEAM+ckqvvhFQ1v?=
 =?us-ascii?Q?jv1qb98JCQnau5xKHqogZhob+BIvajU+gwOym5jOkzihzdl4MMyw3F/MugbF?=
 =?us-ascii?Q?snJ7/anL+yzvSwJE4JWhbub1VlCHkAhH3KC9DWyvcVvJ1GtQDsivgB8TjPMa?=
 =?us-ascii?Q?ywTH6AAVbYpac7616af5p6GfgaiKyjTwSlHEK1UnBSMR45FRDtyBbqZD9z+U?=
 =?us-ascii?Q?Jwg+QxtiL7lNAyDUZKaJUG1mOF5bNxZFPEPh05CvjiVGLqpOpBavpG1bpVGh?=
 =?us-ascii?Q?43iibmjVQcXNNT3mAOavAb+QEvuroxLuwxJ3WkAqwAx9dOB+Qn91dD7jaVUW?=
 =?us-ascii?Q?JUKooqTMmmvwXMf9OiRG9fy1K0sZloGRarCd9Je2vLQqLojJJj3LtK1qW+rr?=
 =?us-ascii?Q?AZlYtIY8be9vGEvopWB0LTqIm69ICWdSbS/Cks+GmxeMQgE/PlqJXLZRRjOj?=
 =?us-ascii?Q?+bnWul+enJ9F1/HzdX7yRwdk3FQSkFo16q5u0MAp2wR8Vw0QBzgYCMC1keTJ?=
 =?us-ascii?Q?o1uCx13K2JR1QvsWt0TgsjQg+ChFby+tGcqrLr9I/PYN7ehwjrgaiGONkMl/?=
 =?us-ascii?Q?c3FZnarhFB4bn80Ehq6N2fwytf9py7sKLo6SdO87daEuQJajbmTwAeYkJQsT?=
 =?us-ascii?Q?0CthCvYCSQ0zc4LQr814EFqxXbjQK1w/n3bDcn1zihKVVh51dAtznVMJc4FD?=
 =?us-ascii?Q?ZPCopf+HwJjUNOS1VTY/vxFt16C0OHC45fOmpr/COmeQT9s1x2FxAU1jQ5bN?=
 =?us-ascii?Q?i2n7WJiMtlYqukdSXPeiucjOsOGHZ/YFjCo51ha0XFMpLxnncyfk8lT9d43U?=
 =?us-ascii?Q?md9wCbqL2hdH/qhTK5/1VmrT?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9b4fca-de18-4070-4a76-08d8d7d4a6da
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 08:26:00.8456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fyLq8LUHX0lf0ejNrkNe2ZrXJgtkqUhbC9uwJtpyCx3MA0C4wiGnzvxu3XHP8IZBVsJ5toZ57I5d6e6VqUdkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5171
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be multiple reasons for EOPNOTSUPP. Sometimes we cannot determine
which one it is.

For example, when we set up uprobe with 32-bit perf and arm64 kernel on
some hardware that does not support sampling/overflow-interrupts,
$ perf probe -x /lib/libc.so.6 malloc
$ perf record -e probe_libc:malloc -a ls

Before this patch:
probe_libc:malloc: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'

After this patch:
probe_libc:malloc: PMU Hardware may not support sampling/overflow-interrupts. Try 'perf stat'.
Some 64-bit architectures may not support 32-bit instruction probing.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 tools/perf/util/evsel.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1bf76864c4f2..aa56511ddf60 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2697,22 +2697,24 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 		break;
 	case EOPNOTSUPP:
 		if (evsel->core.attr.aux_output)
-			return scnprintf(msg, size,
-	"%s: PMU Hardware doesn't support 'aux_output' feature",
+			printed += scnprintf(msg + printed, size,
+	"%s: PMU Hardware may not support 'aux_output' feature.\n",
 					 evsel__name(evsel));
 		if (evsel->core.attr.sample_period != 0)
-			return scnprintf(msg, size,
-	"%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'",
+			printed += scnprintf(msg + printed, size,
+	"%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'.\n",
 					 evsel__name(evsel));
 		if (evsel->core.attr.precise_ip)
-			return scnprintf(msg, size, "%s",
-	"\'precise\' request may not be supported. Try removing 'p' modifier.");
+			printed += scnprintf(msg + printed, size, "%s",
+	"\'precise\' request may not be supported. Try removing 'p' modifier.\n");
 #if defined(__i386__) || defined(__x86_64__)
 		if (evsel->core.attr.type == PERF_TYPE_HARDWARE)
-			return scnprintf(msg, size, "%s",
+			printed += scnprintf(msg + printed, size, "%s",
 	"No hardware sampling interrupt available.\n");
 #endif
-		break;
+		scnprintf(msg + printed, size, "%s",
+	"Some 64-bit architectures may not support 32-bit instruction uprobe.\n");
+		return;
 	case EBUSY:
 		if (find_process("oprofiled"))
 			return scnprintf(msg, size,
-- 
2.17.1

