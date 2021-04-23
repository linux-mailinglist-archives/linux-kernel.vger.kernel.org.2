Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ACD369075
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbhDWKgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:36:38 -0400
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:38542
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242072AbhDWKgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:36:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3beXnUMwXZKO9QWvKf0hHw6WeRx63XEkm9V9LMxztyfif8Gs7kSy01D0ku0iiAuX/dkQMi5G3TGHp7MCeSEbMmY1n6hHLAv9JXZkEToDpcuRGqPr20qqknDoyiDB9Dc7a/Hhe5NGJ9GZXbOW6H60kGlu6P8316p1p++UFtMGeD5tvImdC/MbOMkVOOvn33Tl+2oBCGtSRUblG+dztyI4lRH6FMg1KNsl83dmoyPvVU5hVpWen8XS6SFX4YWnVnL3smQXaP9aHeJv7Z+0By2nKi2kGzRUys2MRFOLq1u9FMWXtCG99VT6nDImObL0qKiNFabRShfc2CdUlbGkwQDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH5wqHUN9VDLDKFW3Rv5PrsNRB/SD0EOsVwV5A//cdk=;
 b=DUic4RALXyXfa90HHrMiXmF8dkC7XYXdJonkualn7Av2jmgM+9aC0GCoT7tGOxI0vImxaFhR0nu99Ldr/3jOD/PNgkV3XainyvH0DXGPjBsrPqfCUT9uhhY2ODps3vwP3avaXFGTnjdgctYIR3j9VRhnPnf/QTkqsXn7yJnBg7kAx/cIOJ8JZlxFbi78ucJg4NxqsT9uted8k/JkkRtimgPN4UtJm90zNYGzfgDgZsCXZyrUVyGTY+3Vnjt8pxeLSu36hwVH9ltn1PIzaHv8+I+ttnb0dOp/8gyc1dQ96uyXL2JLu0wnfAcA35TyHtRj33J7acuYNvaZ26fGwsxVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH5wqHUN9VDLDKFW3Rv5PrsNRB/SD0EOsVwV5A//cdk=;
 b=jAHaqbG10UaI/BJmgTNM3OZ/+9XM4X9QcBTXXyYBZid83N8e7Dxh5UkLwLdDE9nsocDGr9HhLafOznVxVZUSFVoJStpaPwY5+pi3jXRjYJ8uvtCAzUpP7qY5cSo+oX05a21SAqb0+03a6J7LKS2+H8+D1PKwCAEIKy/D39fzqNI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR1101MB2192.namprd11.prod.outlook.com
 (2603:10b6:301:59::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 10:35:58 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 10:35:58 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH v2 2/3] arm64: syscall.h: Add sign extension handling in syscall_get_return_value for compat
Date:   Fri, 23 Apr 2021 18:35:32 +0800
Message-Id: <20210423103533.30121-2-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423103533.30121-1-zhe.he@windriver.com>
References: <20210423103533.30121-1-zhe.he@windriver.com>
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: CY4PR19CA0041.namprd19.prod.outlook.com
 (2603:10b6:903:103::27) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by CY4PR19CA0041.namprd19.prod.outlook.com (2603:10b6:903:103::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 10:35:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f28e30c-dbb0-4d32-afd3-08d90643939e
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1101MB219235789875C118C26353128F459@MWHPR1101MB2192.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQb4Xtc3URswsbP0UHi73MaMObWyT5y1UWASUG3g7fuhwEL4EYMstfjAEbR02MTSjoE1t17toiZALySrkdRnM4ReMMasnl94xz77TdNOmdsXDi2CyKYvqpRSIQiFlrQfrM2vQwONsteEUGPNMbp/YqVVNrlES8TIcKhwxohEyYzckmuy/3S7gGee8DNDIOvj9TU6ZMcdDHY7mmZgN22kVTTTf+Jsvk2ru7Fm+d7TH1T94N8B7u+R3A2Gp3iR6yyoyFsDIuDz/8qvAOapWxyAUSw6Zeu4QKvRBL10/vjAjwGcomI9E7SQLoYEd0fhruUr8D5CxGPIR/u/JjmYukbPmjT1U32uzXHyD4MC9g5YUwKSBqGt78kwVzp2OnebIzAVJC1KW9vlLV/KvmSQjVto87Y+2Io95llw+VM7aSiCUZmEi/UPHOSRti1tWKm6C0GgEPArhyGbT6lcvYG3lAWZPSEm2vu+5EZOszhKRCZO1UK2Yg70SVTACDX3yoYbEL/bZQ8rToD5h9JZnUXvgT0Y6IqaLyNJH1YasoMu9WaRY9RlAgwQHX5cX5kvJjRsEcMNbonNUh58MpjJYlUcs4yXgSaWWz4ezkfLkixz89MqGjptjVtip7+b2JeZG8Ot3XFoojysb3148Tvp1whT9ikeEWMK85Dw235Ww5pZCzOpdMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(52116002)(38100700002)(86362001)(38350700002)(8676002)(6486002)(8936002)(6512007)(26005)(186003)(16526019)(316002)(6666004)(1076003)(6506007)(478600001)(2906002)(5660300002)(66946007)(2616005)(83380400001)(956004)(66476007)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?caomrY6hgNAKBbvoXixZHPre/wmowBpTGRWkh0DkadTgIBDXSJtUcbRGEhX/?=
 =?us-ascii?Q?GgX1ODnjOCNEeHKXLBifmgK4n1FgfDN5447Oowvq4s7fUOqxGDFsJsbEZo67?=
 =?us-ascii?Q?3dLePjhPgpLowtcx9qIXbSkYZ8K1YN/OkoIoGR5zlsKx+sP28sF6aJogIaSX?=
 =?us-ascii?Q?yzELnJtZV7zjVoxhpjBeDjKaGJq6Q659Bog3S2avu4m9GZ/EEeBnPxU/Dbpa?=
 =?us-ascii?Q?eJz2otYVEd3Map6IUZNlZornPgFg9ElL+oYipRKIVFqzsE7M4ENdYzOnQbx4?=
 =?us-ascii?Q?5D/KMmvEvM9/zR8/zlBDtfGWQehqyBasv8YNLMOItxijoLPQrGbXEl96OWGy?=
 =?us-ascii?Q?D0FsetQJ7s9NhOcvpmDr3K/GU8e8tO8WPQ+iDa9e+N6WeL/Aq+Aj42POCSgJ?=
 =?us-ascii?Q?Ud388i/nKJp/d/44Yl0+a4mBoGpQlORlbmAi7Upc0W4RdrnyD7Vtm1+HY6HE?=
 =?us-ascii?Q?c9nmUHh80mREkoCA6ASUMJEEhn0BNV26+2hfczd7YaeUuQQWnIYr0eUerDUX?=
 =?us-ascii?Q?+N8LPdijcpZ9uWtzdQ5kn9oV/l2w2LmB/8Pt5UlK55eq+8jvzPO0rS3gTH4J?=
 =?us-ascii?Q?5HWxnLnGEE2ThuZtKcXxhjUptPDMau9XESHROF6xl5RS7Wanxbsb2UFVYpuL?=
 =?us-ascii?Q?Zr4KR3U0nw0kWreaq9uuNspWiP4LvcNUL2FsXT54tSCPD15fm/ImTRfIlhgP?=
 =?us-ascii?Q?B+xysCgbSfn7qiOXdd7kwzTtsCYxHahkZAFiGHQHrebYjzo/JHArxryBppCi?=
 =?us-ascii?Q?5i87At/SXBYUvJL4f66fO5KT72gJKkl2ZImrIvBcR28UI9goefrzkndlp9Ly?=
 =?us-ascii?Q?LaD4QUMqylktqgu93Nkvq104ETKxYzrvTtfvBnbDzJ9ztIXivtyEphWi3IXf?=
 =?us-ascii?Q?uf98aW/SvvSc3a10UM7mIEqBJwrToWNqgml8jLtpJ/B3lzfim8gzzDAYvcb3?=
 =?us-ascii?Q?Wv9zsPaFANmTQSTsaFAlikXtNgHQskY9VuCDL+lK0t8HUntopc6MBNEu5JpY?=
 =?us-ascii?Q?q7tfrHSRmmXt4U/98jTjGVFza6x0Tip2JhJ5ns/MDBwyJkxOLDCmqED2F5dU?=
 =?us-ascii?Q?guYQ2V861SPwWqquf/lIBWj6LIGahI85clwvh/QGF3F14Urug+uuDWzLiHiT?=
 =?us-ascii?Q?qksx9l39CHPl1AbEIFx8tHVmp0Kue2BWNenlxFvon4TY6MnhGxoN8Dy762ZP?=
 =?us-ascii?Q?epoxK9845Ux2AZxLoKzQZkpHYXyaq0q5KiEpy06ps+ih/0MzCRs7jtDpUGaF?=
 =?us-ascii?Q?FlKOzFShmdA7S/Z7Y63uJngIT+lm3KooIzgm3gkif414gcXPhDC76llcHcZa?=
 =?us-ascii?Q?jIfkFzCb2Fi6VcjPBwVLbKoE?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f28e30c-dbb0-4d32-afd3-08d90643939e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 10:35:58.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfBm4xr20QaNeidFkyp8vSIbKrXJuxQ/z22S6gDQM4TihvtS1/IEcGB0LxRIsRq+dZ3heaALeppvLDTmfWOMVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sign extension handling in syscall_get_return_value so that it can
handle 32-bit compatible case and can be used by for example audit, just
like what syscall_get_error does.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v1 to v2: Improve error code check suggested by Mark

 arch/arm64/include/asm/syscall.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index cfc0672013f6..c3b5fca82ff4 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -44,7 +44,20 @@ static inline long syscall_get_error(struct task_struct *task,
 static inline long syscall_get_return_value(struct task_struct *task,
 					    struct pt_regs *regs)
 {
-	return regs->regs[0];
+	long val = regs->regs[0];
+	long error = val;
+
+	if (compat_user_mode(regs))
+		error = sign_extend64(error, 31);
+
+	/*
+	 * Return codes with bit 31 set may or may not be an error code.
+	 * For example, mmap may return a legal 32 bit address with bit 31 set
+	 * for 32 bit thread, in which case the untouched val should be
+	 * returned. Otherwise, the sign-extended error should be returned if
+	 * it still falls in error number range.
+	 */
+	return IS_ERR_VALUE(error) ? error : val;
 }
 
 static inline void syscall_set_return_value(struct task_struct *task,
-- 
2.17.1

