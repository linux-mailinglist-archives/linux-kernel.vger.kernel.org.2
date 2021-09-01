Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275F03FD2D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbhIAFUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:20:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58472 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241908AbhIAFUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:20:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VNagGf006758;
        Wed, 1 Sep 2021 05:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=BCa8K4lpHRODXYRkfCr2IfmB3tBqFM1CSbgs1TNN7i8=;
 b=Ni6Zec3P+TGkhsxj5f6j4CAM4rQ6n5UccRSmtwn/Walr/ZLG2ZaviE1IbkBKYgRT/xe5
 LpDAXoB2azwBuyIPD1Uu4dWhxOImuJCcWmKOeneOWEn+chY94Y2zh2mP5exwx7mFYOCM
 dBIcAOegWhM+WncLHFzQ61IgYy9AOjOikbRw9gN0KwHUNsQjvYc5NtKFpwn6XF9/6sfM
 8vOAAg0Ix3dSaIa14U5JOdhmFtWLLvlagwY3nb7tTnM5zSlJYcqcmX68yliMKgrQpK8H
 wKXAB53ZLRxJJz2rSbV738hBMJm4v80WeQ4nHiQ43YFK5eKvuiYXae3hsncEtqb1uywZ vg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=BCa8K4lpHRODXYRkfCr2IfmB3tBqFM1CSbgs1TNN7i8=;
 b=fHkWRpbu35lq+L/PBNRlY3V6PmviHZ647NTJIBSZwQbSr5b/GFdaGey2V73LeTg0qAnZ
 7OC15kCkPx6P44ERw9lanmjwRkGvEWahXSVTj9AWoQQOsrc6bsuh/gtHx0hf6VzR44s1
 sC4FR8egwI4OJczDmtpB7zDhTTiILnQHpVRU7lTdrrIYf5KOv7TFJALo3aFxEe9cipma
 iyaW2YKnhRSuXemOpa22iYNjL32hHWdXwXqgyspX+EbnHPXfKtmhJUgOymkTNhGmoGwO
 LhD2+GvvWMquQaQP9avgwlvs2Q3b5y9beUD+du7RnyEKugDdP4vTWZ+wYBM1M7poDQPa 6w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asdn1ueh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 05:19:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1815ARFb167343;
        Wed, 1 Sep 2021 05:19:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3arpf5s5tp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 05:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbXjMmnSBRifEyUyXVlnIrraoBV8yjvcMpuSEYzthQNvFLYCAYmIN4GqRJf4Hru0uSCB3Z2gIlXXmAnmCawB/ylW+oH+ShE4sx9ju5HBrGFt75Pl/9OT3eEc4pZaqwEl72ZC1j1YRthtx8Osq19TwEcWxszZ8fmHDqZ4cT+o4lLbEWtu7H0yuRtDSHtChkAwi7xMBaYnDIbSoY5gKGCTc1XA5bPFLxioQuou4Z+EPSeQEG/9GtqCNRImMTZLAS0opChraU+aM8g9DlWkmEEv1E9Db9Mq7Kqf7mCP0E57WnDwGWpVKzFpRo5HzZ2UCEhBkf37uAd/8IIJp64+n78tFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCa8K4lpHRODXYRkfCr2IfmB3tBqFM1CSbgs1TNN7i8=;
 b=Sbb5vx62CeSgYJYNQnRQ65vWe7O+UaiMvMTkoQ4Za9mbTYFElnYEdAIYl2o1xliKTogXXn2MnjJbbuKaefjAVqv6KFQQmxnQEJJgVMdNfBd7SWbLRvKThViF/v/G3emo5Iasrt/JeiSb5M5C6qvXpApkDC/F1/xZ3cWxuWKHKL7gwQ9qi7BLAAHx2JL5227WrtOTRawlXMlHD/Liad6O2VvZWJDB0vFNfmTiq0gZgMVeIDCbk5YilxhMQ2drJLCjZ84sO04gTJktx9LjWUF/Nr+LnMyWQ8zN5Fg0nkgIfIp+0lFxJXI6SZeprq1vyxANAp0LLKOK/yjve1crIPTbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCa8K4lpHRODXYRkfCr2IfmB3tBqFM1CSbgs1TNN7i8=;
 b=Te7L0k5u/WAV8JJbNjWedZd6ilawIDyl/BvNBJs9hNCVRcApakfv1IoZLtALWB5/pZ1J2+oxxxb+/gwXSHlC1lEQ/HGXvRZqUM5w+bjyDbU1gl9W5srBpB2/pdTFM+2Ko1BVLBdZdaiAMnnE5ZL02V3Aupc4LeaH8c2iQswuBhU=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO1PR10MB4691.namprd10.prod.outlook.com (2603:10b6:303:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 05:19:29 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 05:19:29 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     geert@linux-m68k.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] lib, stackdepot: check stackdepot handle before accessing slabs.
Date:   Wed,  1 Sep 2021 15:19:13 +1000
Message-Id: <20210901051914.971603-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901051914.971603-1-imran.f.khan@oracle.com>
References: <20210901051914.971603-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0014.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::24) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (110.33.47.182) by SYYP282CA0014.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:b4::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Wed, 1 Sep 2021 05:19:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a36f81d-bf42-4e05-91ee-08d96d081291
X-MS-TrafficTypeDiagnostic: CO1PR10MB4691:
X-Microsoft-Antispam-PRVS: <CO1PR10MB46913505FF5C666E49BA20A5B0CD9@CO1PR10MB4691.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQPNTxhZkZxL6b27y4qjmT5A/gDLvydmoAZ9ualJejWk7sz+k4T9+13V09H2anMaDEFncKeTeQX5BxT/9v+puaCu120+BJ6u9/Zz4CdivEaU0FO5uyMZP2v1jJqeRBB4vYSCtzOzIoIJUW5GFUWGisGbV6l7e4Y79tk50datT2AjFc+HjrOOjYxnVE4sCczmHs5OJK77rGpEJYKRxCEXxCVa0FWZEalG46A4Gzi9Ft7WbI7LS8dSUYy+5K3PDKDkYlB4fxLaSsHVRX8oTHK3vmlFS34fi34WrB9cbXrySsJS40ATGfbAojZdGFxp5zE0taeaiGJjeLfoDflumjHlnKBpC4Y1P3D1fOHIulfCDxDwtLJd/MXuLhTHHckCEy4fgr7CuRg7jxR+KsYAFy7ibQQ2wL2sbyrueR473gl3jK7Ve6TTQzC6PYDNyTrRiiuel2VDATX5NcCsJ5WNHLwiA7EHAJeZrHWM2EE3DrO4O4d9tqpZdV+yaW0wo+hAu29zGZtvYUgAsN51kciI72SJluKPtsEDzBEqXGzGQRU/o8DhPBsL5dpKJeRW8PhuC0iRQryxGuO98CCCPezbhz+c6EYA2W/0WExgXbiNnLiZXHEmSmkAFqt87uEo5HvZrbQDeoickqdg4BGiuUyH4GttL0xbp6La57rmnsxRzalAKYxtsNN3ljNen7+A6XNbPw74IDJsVj1Vlp7YhD2vb5zKkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(38350700002)(66476007)(66556008)(36756003)(86362001)(186003)(5660300002)(2906002)(508600001)(1076003)(6512007)(956004)(6666004)(8936002)(83380400001)(316002)(2616005)(4326008)(52116002)(26005)(6506007)(66946007)(6486002)(103116003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kBKnuAGUm9XX34NFIjGZ13eKQWojSSqOd3et9nZ3Mw7/UFt1v6iH37A2ocen?=
 =?us-ascii?Q?MFu9yPmcIV+AEq82hpI90TQRo4fdHCRsaxgHrIhiBzB+NMMwRxDTqa3kyuk0?=
 =?us-ascii?Q?6BOOdO23/88WmPG8c3tpm9LL+iGCo5FsL+18SOT3DmdvBfhmZFLE0wJZ2sSD?=
 =?us-ascii?Q?3xq2+7brkBozgk9+3Hkaq6v3g0a/cBbsrCmpp5C8sMSaiichtdmQLKvQ0r0q?=
 =?us-ascii?Q?f7TR9G4OKaM9fGl88PErpKFyAQgmtQ01DewubcB/VsIZO/pwH01PiHHiAiyD?=
 =?us-ascii?Q?ZC+OagXGqEqGF94pWy0IYUrv81boTK6ZBPrL/Lt9+DP1GygT2xffPqV23Kch?=
 =?us-ascii?Q?82Y0vXPvxcnNAXdbZSOCR5H+hN2nFjPY1t8+ym8VZYmRKg0nLArnhOTiZmmO?=
 =?us-ascii?Q?YA28M5js0eQon8ug7YQrKL5rTxIs1JfQPEQjO82C1LVNwia24fT8BKZdIGKA?=
 =?us-ascii?Q?0ROjzGZG38hxxtwbBv+q8e5WI83G3bJxJkp1IhI6x5Kke+SNivjtf0kVuB4s?=
 =?us-ascii?Q?hKW/GZKFRHOwtBBAG7PnRTxZEbKqGK1zvWjJY3Cz/E45/Ly5yz2B7+RMfyQw?=
 =?us-ascii?Q?eciNz4YSXB7Js4xfbUKg42CToYZh/dn5LSlKBOZJrlJF9TbtIhU5gc4TIR/e?=
 =?us-ascii?Q?Ygn0VBdJhg8Yv8eKGZlRt7CT3dqsCILCKRSIDdgIDrGzm/HCtlaMQptZ8yFj?=
 =?us-ascii?Q?6vD11ciG8swC2tBf5rU79FAx9nqyjXzlqVV6alX6PpExAErQIIsibGGWBdrz?=
 =?us-ascii?Q?lqjn/E9wORYz+LZajZjGT4qplXYCRv2Pix1kq7Q201fMDW0dVKn6c0h5ttER?=
 =?us-ascii?Q?WdtFpvxZLms/rF4JdK0XmC1NaqO+HN/9WCkd0LoZz9IcS3ntJXwEeR+53Ops?=
 =?us-ascii?Q?pC0G95VE5sdMoK9HtSqM20kLQbrHv/7KdBLXMsWHTJrOwetXefw+igBnU1en?=
 =?us-ascii?Q?hSETpYBzHn++GBxWFjzwDn1ILGnVZnJIYpi3QKL5FuKVnOCNs/xZsjUE53Gy?=
 =?us-ascii?Q?nQMoptp3WL7eAhR78u9sUSxYqoLlIAbtijJoX3MEnl+7RWKWS9NOcSZTK+Pe?=
 =?us-ascii?Q?dFyCktmXjzWogpgdWX5P0LVdK0lUjU+zKGjXE6syd7emPb4hd2hypY5eeIwS?=
 =?us-ascii?Q?cns/cPcPVjV8VPoJuRjje1sOR4QWckSLawzwRTkh+QZebxOCz3TWK2sztLCm?=
 =?us-ascii?Q?swjxLgQD4DhQDKy6quuk5T+AvcMgQf7kHw5njOtVpArLv+mheFMhNXEhebTr?=
 =?us-ascii?Q?ClDafRk3HOriQNWbKuNZkAW5PAhUNhxy9yUKzFp6LbAfLtXuGzvA75H1lLOu?=
 =?us-ascii?Q?BmbHRMctd3MZuf1nurqNMGc0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a36f81d-bf42-4e05-91ee-08d96d081291
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 05:19:28.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AxQdss1KMZm63OknE81rEIy9tOxfB5dwazWYue9Jrd7milRiW+j5iVhvGTAEnQcqIaEF/e63UjWBx86PTfBFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=984 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010028
X-Proofpoint-ORIG-GUID: NdpB_giCvMDlSOHM91cLouFCPN902inm
X-Proofpoint-GUID: NdpB_giCvMDlSOHM91cLouFCPN902inm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stack_depot_save allocates slabs that will be used for storing
objects in future.If this slab allocation fails we may get to
a situation where space allocation for a new stack_record fails,
causing stack_depot_save to return 0 as handle.
If user of this handle ends up invoking stack_depot_fetch with
this handle value, current implementation of stack_depot_fetch
will end up using slab from wrong index.
To avoid this check handle value at the beginning.
Also issue a warning for nil handle values and when slab allocation
for stackdepot fails for the first time.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/stackdepot.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 0a2e417f83cb..1d42ef9ef766 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -232,6 +232,10 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	struct stack_record *stack;
 
 	*entries = NULL;
+	if (!handle) {
+		WARN(1, "stack depot handle is absent.\n");
+		return 0;
+	}
 	if (parts.slabindex > depot_index) {
 		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
 			parts.slabindex, depot_index, handle);
@@ -303,6 +307,8 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 		page = alloc_pages(alloc_flags, STACK_ALLOC_ORDER);
 		if (page)
 			prealloc = page_address(page);
+		else
+			WARN_ONCE(1, "slab allocation for stack depot failed.\n");
 	}
 
 	raw_spin_lock_irqsave(&depot_lock, flags);
-- 
2.30.2

