Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E273DD03F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhHBGEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:04:15 -0400
Received: from mail-mw2nam12on2111.outbound.protection.outlook.com ([40.107.244.111]:28384
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229792AbhHBGEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:04:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ3C64el0F+lus91K7gAjqZk41H1eh9pfmFBFs5RkrPyY2UP3jL2DaHW/TgKA3/MzV1vEOys4f0MwJKbhQkberlt68Wv1fnsNpef5dGt8ZyEfJEaTxk//mM4nQZYzy3KVbGTHZvRqwe+PSxmMnHVHKg6G0Yf686FzHK8QVGEfC5bmzkRWpDCHbmLHGY34O4KejeqA+RupPdZ5ZYFYqwPwo3XYMKClHGUxD+hfZI0LdHLrTT8ttx16IeIGZdij2+v9ks3m0dZNb6ggHmQ3uOFs9GbO/tsActc+H9Aam094BU74RnmPL/5Qh8ie6DU8K1mJV/gGQUNsofx5RV1dpu7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po3TeAedALQKvroDcVS4zNrEY2Cm2HQyhfcgbizwQ/k=;
 b=TFFWms9VCXTD1jYBMuLLv5IAcVsh3vjBeIlOh/mz+t9EsZnxDUT3QNUHOaKkxLRtzEiEUSNMimvg87cMNEYpu54gojSoYicwvR/8ZQXutzytlQbY2vdjILG+VMVLVnWkr2KkrIxkc7TTw+Vz1APkAM1vOoFzSuDiRmO377LBraz338CUlbm51gN8wmTJpBLLUOWwYbk1qDStV2c9An9J+fkH9fA49Pj08hJJGcepAmKkgW9A+1h4Hs0Yjpy9+yTf6k89XxDW8LSStNHkD3MNc83PM8aJ/9OFR+PrPUvei3ORzvh2WiXye9sAuQdtANdW46/ki+axwPBLad6Yt52RHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po3TeAedALQKvroDcVS4zNrEY2Cm2HQyhfcgbizwQ/k=;
 b=ROOauOmVKe60yGY4k7XSuJomCc4nFuCv4CZUKmgN5w8GkSVAPZIhvUIsZnHRI/oMfNUAusUYXIAim784xCnb58eSpzxgw5DFjhoEpzH/VPykxE/7JBYVISIVtbgGXpy8Tav0gXh7hIVyTW8h5yw67GCN4c8tw0TB1HdABjDrbVQ=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MW2PR0102MB3403.prod.exchangelabs.com (2603:10b6:302:2::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.17; Mon, 2 Aug 2021 06:04:03 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::9d11:11d3:b589:400a]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::9d11:11d3:b589:400a%7]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 06:04:03 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        opensourcereview@amperecomputing.com, zwang@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] tracing: Fix a typo
Date:   Mon,  2 Aug 2021 14:02:34 +0000
Message-Id: <20210802140234.5383-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY4PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:910:14::15) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj.amperecomputing.com (180.167.209.74) by CY4PR15CA0005.namprd15.prod.outlook.com (2603:10b6:910:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 06:04:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab45223d-b1e3-4b82-22e9-08d9557b53ce
X-MS-TrafficTypeDiagnostic: MW2PR0102MB3403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR0102MB340369876DA940532E7BB8C0EDEF9@MW2PR0102MB3403.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1M3kjhjsKc1m7afVO1sPZJbYlZG6WQQoedfI4wR/o0BvGecgNRXDFsHs6pxplysD2Jg2LFPbmoOrpi/fvRPcW7dSJYEHIizpuLQZsnBXWmDpJbayMlTcscDrb5Xk95Mzs9rgGC76bWyjzMXErB85F4jWa8UZRQ+KXNBZP1oJ8PtAOP4+GKyAi3dkezgsmiLppzp4BhdFz1N0O6sgE5VdT9+umFyfrQYNQ6lTiqma7QVlU0KYxmzQwA4zIdj5Sogto1yebaDJ9XU21kfmeOyd3n2g65i9Tb+a8cW1KoOkuc6eHw1MltB4anMsKG0AJEGgRHUOFLf59YAWuqs8doJivcGDsdx9LQXCWa4vOCQYg5flS10ojwDFQYng1cM3QOCJcYeVhHNgroaQcq70GAaTPDoacCzP7xC9PVxjCkELV9ta3JUUjTyPypvcAYPdYHg1DUfswVkNleC/jvz1DS8EURSxj9+9IX1OxmSRl4NFkFALYCXnPcrrfdaCmsGtVEAwHRSTSzThh3ABnTHobvpQSXRiZEpy3i46zZg6JepAAPVcnJaNZNspqQYYbzR57MHAwg/TkvaDAnHSTLOuqDtFjsWSqqd5RBOEZYMuX0MVMtAdL0tVtKrKaExWacPDFyaniHrn9rVUqqi1kPX2tLmljcuwgjLyAABABbHAy7aoe+y88R4JXR9NXKAwkSs1igVGfvtSXDJgot02ZyS2Qvu8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39850400004)(136003)(376002)(396003)(1076003)(66556008)(6666004)(2616005)(86362001)(316002)(5660300002)(66946007)(26005)(4326008)(6916009)(66476007)(956004)(186003)(38350700002)(4744005)(8676002)(52116002)(2906002)(8936002)(107886003)(6512007)(6486002)(83380400001)(6506007)(478600001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h17cr8uzdYigwXwuVCHPfrfH4dHBGJGS6QitsLYRkh+jmilyFpet8nOMZpKm?=
 =?us-ascii?Q?OdKvS7FCV1s/hF09qNZoOThimS+hnpPG3BJ8korgDQeJFyq85Rto3zIUVWjs?=
 =?us-ascii?Q?+IbPqH5AbEBCHaMbJZV9qUU9eJhLXJ0HxCEGC0E3nImq/NOlkqG+Y8rm75kn?=
 =?us-ascii?Q?sY/0gY8PMeF/MDcRJUJcLijSDVTE6PUgx+kowAE00zjyqE7OWDkUvYIdzcIf?=
 =?us-ascii?Q?PDAgLFcHZ8Wktj/GlvCTP//2hflAQejp/6YGVL/Q5E3dbLlFjn0lTYmsu3eT?=
 =?us-ascii?Q?WC7Fnn7ACflWMbVunjGfYWFPdFpNIyQ5h5Uf+utylgmMZl3k6MxZHlbNgMzk?=
 =?us-ascii?Q?m+eDmkii18Q6A7j7qvXeG50Ieh1SDbn8B4g87lB24qRtz/W46Da0ZTWmQBYR?=
 =?us-ascii?Q?ZBAutQiTrdyTIW6xfns0AyUI0zhrOTjHd6UAw1m3ORGZLe2V6qcW3DlqyHPc?=
 =?us-ascii?Q?Bn6S0IVuKd7QbZlg/gr0cTcVatIh7aQTq99rvX2/mceaNuZclf54AzICLsx7?=
 =?us-ascii?Q?YWR8d1TQbiTeyrMVucVDpBcot0s7I4VWupzPBkpCaNWOPtJ3rxdH04exPEfW?=
 =?us-ascii?Q?0Ao8BvQpLox0s7en+cMnI8ToGnCaFsDvxaySaw5UaG3SpEB3hJa/wj9UkiBt?=
 =?us-ascii?Q?2JxWRrWBXDN0PzYFWB1+1fbTmt9QeQ8Z8qV+EsQzDLuLRoitp4tm4tPl4cE8?=
 =?us-ascii?Q?XERFwZVlyNlNZfpcvcVcTuO7+kN9mwxUq0BnFpthA4KUd3vJv9bNDAs3R23N?=
 =?us-ascii?Q?XNjU4gqI1Q2wHwssqlNrtzJYYuynOipSffKKHylkGYuL/4iWwohsJR9GfCCv?=
 =?us-ascii?Q?Z2HliZXEnap0K3I5bTIwkEX32/SeSeuRbCniKddBWyXZ4eZZObPcjdt48095?=
 =?us-ascii?Q?SVvvgCRcTeRiRRAWO4t4GKm3YkNlBvL1N1538AYDxo8WZGhfJQssNIrlySrl?=
 =?us-ascii?Q?SLkAW5rGd3Q8EJLJtMoh6YSRme4oc9VE9Li8C/YBCO38TbzhEjDQlvfM2ags?=
 =?us-ascii?Q?n0PmGk45mYNAJMJusR5ZVvF87zp98E2woI22gOUnnrxo9g0j9RaUPDgcKbpM?=
 =?us-ascii?Q?KWY+qORaCaZlYixZyr++fOPatqScyBsqltdFxk0P26f8Pdj2VpwTTCXeOBbU?=
 =?us-ascii?Q?nUW1EGZ6UjFC7kLtrlKbMFkknc7HV2ByZh37vbe5nYUcG53wc1/rZkjmV/QZ?=
 =?us-ascii?Q?dcTmXLdZFLNCcdLhdskZ0VQpecNJrdzJK1WBSo00vkxU2kRNOy8Sew6RCMGg?=
 =?us-ascii?Q?E7pbEXNp5Eqxhzi5d4stQ10/8PRVAbHsIl65sdmj8owsGnpsLoHo3/Ej3UCk?=
 =?us-ascii?Q?/lAec08W3BYZgSThYxonx0j6?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab45223d-b1e3-4b82-22e9-08d9557b53ce
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 06:04:02.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDiSfMgmggMBGoum4U1tDTCa+GhhPIPVlBZJwp6ZeOJ+7uPayO4Wyp+BLLe+P6t7GBFEmWcMAlL7NSMkcOjnikauEIIB8jJJNqBrTUekU1XOaVm50eGZAXIwbbdu10Ve
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR0102MB3403
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be @prev_pid, not @prev_prid.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 include/linux/tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index ab58696d0ddd..28031b15f878 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -475,7 +475,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  *	*
  *	* The declared 'local variable' is called '__entry'
  *	*
- *	* __field(pid_t, prev_prid) is equivalent to a standard declaration:
+ *	* __field(pid_t, prev_pid) is equivalent to a standard declaration:
  *	*
  *	*	pid_t	prev_pid;
  *	*
-- 
2.30.2

