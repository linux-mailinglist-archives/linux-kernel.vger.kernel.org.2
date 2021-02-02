Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1530BB86
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhBBJza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:55:30 -0500
Received: from mail-eopbgr700075.outbound.protection.outlook.com ([40.107.70.75]:38240
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229632AbhBBJyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:54:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFdIXHyIBBTm/ynYMn+Ov4yfImJJMfZ/8EyCk/M+U3uxj0J13xBXu/G0n0KbQYSPsCa+O1tg8gQB3X/TDtuIkiMPTu1Mp3gV2yShVAVRqdM8FJ6+cM67QT1HrojlxlT4xDKhU8dxwZoNe2InoHcydBivt7Hg+fgkjSpOr89x7CMMkmRVdXJFrAhRK+5jC/O8CT9RGa4QH/MWfvB/Rnpfn+OcKbLqBRXJP7jvx1jLRzt7315zHqN78b9ds3+zJ5d/xqDId0IeAZKRPF0yvoO5vr9sPKuHuV4Q5loNDz6BVKl3zBQXpCzn1vDYnRKOsJqB7labjtn90xRXTioFFJWnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRJVD9yVbRnCzErJLMX8w2LYloWQ0uRHL4E4lzNJ1/g=;
 b=le+DQncVoeZm/svpsoISDVkF/2pki6sZbMqhFKMWABKwDt1YHVhifkKpGQIm4hRf6G7gHitLHppdFLTKtrUT51X2hb2bJwX8TRJ9YxJUerJtEUbssjapR0C2UasIcm8YdcVW+HmPANAK5g5pXL0I6SXLs57MXNIOoN+pTQBn3/VvGqVDjtDWLIKLsAtq1giNahIX4cxHAGmnh1OdliC90W34WxC3Oq+7hNfb8BjxFS8EtR1E5BQFdJjRKLF598s2KI8MsaLF3xtY4zp5rfxdoHbHEXbevGbzFAYie3qeIAfW0ypg8G6CUQW1PO26GmfL3n+eeI26Uz1Ce5XtNBDQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRJVD9yVbRnCzErJLMX8w2LYloWQ0uRHL4E4lzNJ1/g=;
 b=JB4i5BRBkkdwEsJeGAO0PR3QJtWyjx96E7SABMaFqfZ9nfMyMa0Ki+5NpL2U/pCr/4hp+fdSJR3nVH0wJA5LaVXTJaS+cQAky+QbziYPbhwhBQwl1eb+hn5B1/5cbP3671HVJKt+xfsbX4AmezcRUNDToLmB3vOYAJrdyYVESsc=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB4877.namprd11.prod.outlook.com (2603:10b6:a03:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 09:54:08 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4%6]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 09:54:08 +0000
From:   yanfei.xu@windriver.com
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugetlb: remove a meaningless if statement in gigantic page initialization
Date:   Tue,  2 Feb 2021 18:12:09 +0800
Message-Id: <20210202101209.72795-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1.wrs.com (60.247.85.82) by HK2PR02CA0163.apcprd02.prod.outlook.com (2603:1096:201:1f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 09:54:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb40a5ca-6d24-449b-ff12-08d8c7607bde
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4877:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB487708320D93622AA3512152E4B59@SJ0PR11MB4877.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Em6pGIP2ok1k/z3DcL52FKxXwcSeXY5febP62AvHenDOVGfTzjVgDM5GRTcBKjoRdyPSPOuf3PPZ0MwdjlIxZnnWfvqdCU6YUtsj4P+afM1JZ0LeLwk7dyuYCAC8N6ir1EeTZiVs4XzdCu4cCW9sIh2qZEfN6C73FFhqlfd2CqZGNjQUSqM35CZTZ844qlKLNEu3qRknjvD6CVT6KQnQARcZMvEUbvmR8WCFgEg4+UsVz11T+gDW9Tm/NrHNfyFwWxeQ8VAZLN3UTg4XHW4PnZRgQJF6nj7h5MwZrFifcgbJHcuuJ4aUbYUrSPYhEFVhhlZ1wU4SEl6NTQPUQXNAbP+AYvyme6GQp8jg7uj3nc7D62GsbHGehssEfZUfFSjl4ng30OtM9CnhocyWDFrNf52Wv39lTrwUeGJSGCpHbrblp/AFPxFNzlC+6ovfWVUk4kIXm4oGc8QrfeOyN1ENkA8U+18BLE/AeNHbmK1C74K1TrHQzidkPJsObAqO/QBcvxjdHxyabkg0eAQqqIyXTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(39850400004)(396003)(316002)(956004)(6512007)(52116002)(36756003)(83380400001)(8936002)(16526019)(2906002)(6486002)(86362001)(26005)(1076003)(186003)(6506007)(478600001)(4744005)(8676002)(66556008)(66476007)(4326008)(66946007)(2616005)(9686003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dcyjRmt46lCzD1AaqDrXCFHwd5LFjTZM33DK+tGm5NUZFkurDcUyJnUcYyzn?=
 =?us-ascii?Q?UPkNBbK4Ujt8mV6fP04WhlclAVC2QL4zM7P1u4cjms346dgFqnEZ017/RKms?=
 =?us-ascii?Q?t8e38/A0Kal8ufsz+7jxsowoCzhKpgFIOxDo5iwt9txLW6m386FLFOcEM9/N?=
 =?us-ascii?Q?8H183f3FuFS+CEYDrc+6VBsx9nC+dMwAVuwKqjlkjKXJCyKsULlb69//UQFS?=
 =?us-ascii?Q?D5AoaiwIHs9BcDrZUdOp+po9esmVwc3Cga/0MyvvuyUqxwtVLU63WauKNqSf?=
 =?us-ascii?Q?lpghoLyh/LLdlXFbQWR1ykIfqI51HxygW324rms4xfYYVtsmtggkDEC/pbk7?=
 =?us-ascii?Q?y9p8DwQRGeNJYu/k6+4SqzI2iff1o8fQ4GUX9oBMalGMDLMdmwx9b0RxCsd6?=
 =?us-ascii?Q?r7nel7cwPKVzHjYI3j8CYQ9OO9xPBy1cOWr+7z0e7/dtCDcUdNkVA+U+CJBq?=
 =?us-ascii?Q?q0jo7577gTARcHKV5AzOz/ZTWi48uSXAu96aTktGKWMcTOm/3XHV7Ojf0stg?=
 =?us-ascii?Q?KN7QT4MDdt3dIRFN+RYfxFwpkEZmK1OqA7siGy7AjHZ7iByx8LasOj2lzaYJ?=
 =?us-ascii?Q?jlJ929stuA2Q74tDfBEvu17m9FAbf7sOR032Ii7Ev0NSW9QB+W57gQJSXToE?=
 =?us-ascii?Q?otK0v0eSsENJpdzP7H9g+shdHAPPdRevuQNgeltA4teR68TajaubdtsILd7o?=
 =?us-ascii?Q?/0Rrvjg+TE5b2gOPsUHZ5R098CxMTODaLFIj9mu62TcyIV8IzRZjWLQL9wKp?=
 =?us-ascii?Q?j8wHY0cyt8W+cu9+6CIAk95TxKMMliM5XDNamhURKIJKJJMuvxXz8vyr0c2U?=
 =?us-ascii?Q?rknK1CYKpehsWx24eGOsb4RYZ1E3sn9jFKRMRD36BAbcnoOl4xW9e570MAR+?=
 =?us-ascii?Q?/373/QmIf/9JTneK6KEGNPEvjKO79GtLkF9DXSTihaV3qeb3xyE+5wpMLwxA?=
 =?us-ascii?Q?KVcNhZhfVBGcsw1clSF9gxIUcpBEwDbfwbeOOxu+92DXDg3LqiZYEaGveED9?=
 =?us-ascii?Q?9Lh13RRKZevpTjUzsjFMnOU12hc6OAISluBDaNQbRELzuRIKh330/bmVI5U8?=
 =?us-ascii?Q?VWjpfa57?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb40a5ca-6d24-449b-ff12-08d8c7607bde
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 09:54:08.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCnp0WoFsQ9NWYDuvefiBeYy3HW/hCUi820Wthhb/3JhMV2HsEKM5OiPhHmj+XxnAyUKEoHSQEd7oO81M34yZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4877
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

Gigantic page is a compound page and its order is more than 1.
Thus it must be available for hpage_pincount. Let's remove this
meaningless if statement.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/hugetlb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a3e4fa2c5e94..73d602f8c7e2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1501,9 +1501,7 @@ static void prep_compound_gigantic_page(struct page *page, unsigned int order)
 		set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
-
-	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
+	atomic_set(compound_pincount_ptr(page), 0);
 }
 
 /*
-- 
2.27.0

