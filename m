Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9A1361AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbhDPH4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:56:36 -0400
Received: from mail-bn8nam08on2073.outbound.protection.outlook.com ([40.107.100.73]:34656
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239096AbhDPH40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:56:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXorA1axn5BcTMo6zPtOI4yxCGTtMuRyfUdChwD6vO290DT7qo5vRL3mXqEDOyw78fJlE9ZzrTASDZCK4DAvYNw9yiqPanj2+1/O0ttjVa+ktRqK1X1TTzD5sYoleoh4T9AT+SxS+gA1QhtACpr7b/l+/6wpvDEbLt26fHypVASuv3mAU4ilZEl/XluC4FqE/t2G18MbwiwSnOsl1vPRNlJknq/+gAYlBQzdNpmvhBVtGzA44IQBKNnYOP2wwS19SGamIM7yOtoShh9EaXn76nvAfjdGYiRNS5WRA3woMVEgY4SYFQx6erBMmNy6CpXrIzAzjhx28eY5wMHeVBL+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZVTrKhkVowLWU9xiLvZT0CxlNRi6H9KXJAaOQMmH+c=;
 b=DsXNAnS8+OsWJ78W25WC6s55Hk8WEZ+BjZgX0OQmqz4Bu8yylZ2N/0Jqcx7Ndk7ktzsGFl4FOh1Q4U11leUCrni6oCFPG8kW9jZzoR58D8AwB+WD/kWwpWYak4eX/jWjtzaot8xyvbr15xe6NtwkEf77DvpIz95iTheS53bByNDXvoD5Wa6EpIMb41Wgk/hCasEu9rykoNc5yPCpharpCyctIXqEohObHM/pvTA7PDXRv8ZiHLCmY7E2rDy5VobKpYxlRO2bmSRNc+WUNojsipzaWIW6YZY32GmjQOpwwfQSBGR4G7l2gTHHXO0Jy5DBCC37rf9Ex58hx4fGb7S5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZVTrKhkVowLWU9xiLvZT0CxlNRi6H9KXJAaOQMmH+c=;
 b=AjLrIdraHcUvH2pUnrpc1Vw3dNLE86ZudRY4j7n3nk1gYxB9WoiQfWtyL8XoL7F/vF2CsJYI50YKqMAhiAHYCfvu/FE8xoIQXMJR5PJWxOY0+arB3EzXJwqgDO0ckr81EXiAVjvvNiwnxKWr2HsODbSlXlFFObJBsSsXu/JXKbY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MW3PR11MB4763.namprd11.prod.outlook.com
 (2603:10b6:303:2c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 16 Apr
 2021 07:56:01 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 07:56:01 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH 3/3] audit: Use syscall_get_return_value to get syscall return code in audit_syscall_exit
Date:   Fri, 16 Apr 2021 15:55:33 +0800
Message-Id: <20210416075533.7720-3-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416075533.7720-1-zhe.he@windriver.com>
References: <20210416075533.7720-1-zhe.he@windriver.com>
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0064.apcprd04.prod.outlook.com
 (2603:1096:202:14::32) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by HK2PR04CA0064.apcprd04.prod.outlook.com (2603:1096:202:14::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 07:55:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb0476c-83c6-4d1a-0610-08d900ad1382
X-MS-TrafficTypeDiagnostic: MW3PR11MB4763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR11MB4763C55E9BAE88DDA6C91EAB8F4C9@MW3PR11MB4763.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sV5crO9FTR06zECdFeRSLT4aHABBssOEiAuVNxHLc7WX8lGX7rJAog+nrIXPncrmf8ZosxUJ0LoAsTvFnfGb57JGb1jbHbkehDt0izkCrXRrhMKdPibZygGMegmATGJsHfQ/IWU9qb2d+oHrk38FoRHz7XAAJRmdZQFg82tER06F4zl4mKgeiPLR8WkyU7jM9+H5Nq/qdoI/VVxjkRqldDZu/yxpZOixiP5giAQBNlAMWtzjXfpx9qlhEdC139+HQxnxpeH5xYisMAJK7AmhpMWNJq/A8HzY76RYUz67SwKv+W6JOn1CCIywZqHAiy9Q/x80M+Sw9q9jmt1cpHxsOJGHTsLcAJpYaNWZVqGFa8cRAIug+yREMW1JGevjFDm/r8z/DzKH5Y1zqbGDBsv9K7qyP8jDLXEQ4yfMtaf9ZtABmm/4Zgf9V9V5oh3PTzuZMyFVOBHKmtLl4RGpIUf1Q1b7LWYfidBnJa833Vw6oWnmK4ZZPmQ0+qIG6n902RoBABv3/zT5cmdzagraz5sAURNs7R8EvpYuMcj4MlPUtvvsN2qeYF/1INAo9Bu5bb8yTiP3nKeIdLqETja+ucGn3nx3f4NhRBC7onkaoeMknSL+9S8y/wkpnL85VT9VsgLLk/ns/3G2VI/OySOacPnoLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39850400004)(376002)(16526019)(8936002)(38100700002)(316002)(186003)(6512007)(6486002)(8676002)(66556008)(38350700002)(5660300002)(956004)(2616005)(26005)(1076003)(2906002)(6506007)(66946007)(66476007)(36756003)(478600001)(83380400001)(52116002)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N02V4nSZszpMWwEcVGeiCzHvo/IOI1RQHBUo5NZ3UAiDCpNMzIq73Oi83eje?=
 =?us-ascii?Q?arE8OyYufe01xCW3/WEhKF5lM1+RGRpG+/Sa+fX/tmNazyilrynN2nDJfqCi?=
 =?us-ascii?Q?CiJo2rjb4wQ8g0X6O5gFVyzoZTZ8Ab1Vtzn31qtmfpZUpZtFManfgXawugjW?=
 =?us-ascii?Q?vewUC6jTecy8h0bAhC1pOerQ+JCfFNGlBtzTRwUQ52sWJjVJN1YsrEm9ZKIu?=
 =?us-ascii?Q?K67zp4Tu9MDOgCWzMVLxehSYhDU/Qak5eMDZyzhOqbXchVJ8dJi9vCw85SkB?=
 =?us-ascii?Q?joSDnIQY5pjVMbKs8oH1f4UuOoV7Pq2bYwaTh7eTv/BDgbp6VjxTh57PiQwG?=
 =?us-ascii?Q?FmHvElujNlkRKl7Gi4smaelPgltgElrSXiF4m2Pw/n52VvsbApvujpu/UuHH?=
 =?us-ascii?Q?t1JPCPxyZzAuWLjPEMyivTseF07Qxf02CkyxNiUH1DFjpgEGTjPj8dYfFXhH?=
 =?us-ascii?Q?aYyPe9j1ATGrDstGfZKu8173HhTLPLvfbQAEsqsh/2hkUNdYhIui+ladnCof?=
 =?us-ascii?Q?hpCSbRow5/K8qGQE4e2yi0+hMfS0WgE84YBY0bluqdRpD7K4mcGOQnQH1orv?=
 =?us-ascii?Q?3L7GSMs0G1Iz/I+gbHT0K3Fg/HrtwiWmxwOv/CSE2SuM/x7jXfs0pfO4ou4o?=
 =?us-ascii?Q?dgMphiCebIZDMVkFagA+RD2mm9W06z4RresW4rjVWku9gd+GjWmo88IOJbSD?=
 =?us-ascii?Q?lEuw760HejpPjVTDO0PmpEptwso8eazX2RwXg/VCNQXWeWGy0bjHNjqT5+/Q?=
 =?us-ascii?Q?S8pkSDY3qH7CvJEaXlCyKszSSAt5EWJbaWZPfhQOjZBQu94s2JC1FGeSHx3u?=
 =?us-ascii?Q?b4AiUlJkrEC14egFDSPqpmU+ZruJkDbycwpNn4Zf87bNbhOa1faRxLl0lE2N?=
 =?us-ascii?Q?PtamrLS+Y3gRkmH7dFlEJ6VLh5CeHkrqaSbxXVVzezayctRuaSz9gg1GOOBd?=
 =?us-ascii?Q?4IOTqWbNknbRULgX6iqkl0NwF1uGxeF7HEHRfPm8hdoX/w/Zryon0VattWEg?=
 =?us-ascii?Q?3KmGNv5rzauugSphJlQPg8fFOP5KyktGtq5tZTffPVnf8TYWDZXvrsAosRDP?=
 =?us-ascii?Q?+sbLbGZtQG9wPQ3usEQYpEd/2KJ77jOOWaAK7dggIMN//RxLcIdS1d003WPx?=
 =?us-ascii?Q?GVtokrcEcova/YYkoKVWmxFTj1Q/LgZd1YubVLlU47/gWe5WV5ex+nN4mal5?=
 =?us-ascii?Q?zlMkpuWy7NxY9CDNxtrO3dglXR03hSbc7otKzlhPpqD53fRJj3bHHSZClUXJ?=
 =?us-ascii?Q?KIqwqV0DUOL1amXdRdFxwJW4LEHY7Y4CcdICKulNplSIQzn4hawXMD/oxIlW?=
 =?us-ascii?Q?q3EdQGB+TXR8y2i+9jOQNIIw?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb0476c-83c6-4d1a-0610-08d900ad1382
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 07:56:00.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0WOdpcGQCz2rL3kor2VcmxYLODquTr7rzr2bftT5HO7GuTxNFM9oZO6H23hEcgziW4IrDU6II6v0JEXnb8H3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regs_return_value for some architectures like arm64 simply retrieve
register value from pt_regs without sign extension in 32-bit compatible
case and cause audit to have false syscall return code. For example,
32-bit -13 would be treated as 4294967283 below.

type=SYSCALL msg=audit(1611110715.887:582): arch=40000028 syscall=322
success=yes exit=4294967283

We just added proper sign extension in syscall_get_return_value which
should be used instead.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 include/linux/audit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 82b7c1116a85..135adbe22c19 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -334,7 +334,7 @@ static inline void audit_syscall_exit(void *pt_regs)
 {
 	if (unlikely(audit_context())) {
 		int success = is_syscall_success(pt_regs);
-		long return_code = regs_return_value(pt_regs);
+		long return_code = syscall_get_return_value(current, pt_regs);
 
 		__audit_syscall_exit(success, return_code);
 	}
-- 
2.17.1

