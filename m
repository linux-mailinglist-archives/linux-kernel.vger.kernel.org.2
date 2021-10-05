Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A3421BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhJEBd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37796 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231509AbhJEBd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:29 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951BZjC010255;
        Tue, 5 Oct 2021 01:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WHjAZi4EVBUvdMxrcFaiiwl23L4DVXsDdqob1VzA6R4=;
 b=Jdf/FUg7VeaZEBvyesOE6vHvrzWoS3v8ltjck6sRgUIkysgugwSZFlUCllhyeh3X1vbK
 KZqRgAYxiBPzTqFSMv6JRZVruron1XMGaQqC1huZwmKZQu3JPkSgr8LJyijkGe9Xd1mW
 oYdC5nXWqsk5YEWMW5ywugv+BPQ2JaAWTUL/+TXboDEON6gSo4mxzpG2uL4BTK0x22V+
 d/XBFTlH88t976loo0e1N4CGKsQhOEq9Ded8qXS1SfAQ+rwPoMpgyj4WPZOiyTX5HxD3
 piDQVFAJfaVyHak4hSPnnZwC6JGtIUqVjVSYV9VGA6pBIVfDxgtTSrAy1LXCgrfZ8APR NA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3upv392-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdGC141646;
        Tue, 5 Oct 2021 01:30:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSivPsSgGH5VD746mvD1rlH7UuxozzCPcAeN6w08CwfP9Ubej3yH1HErvpTDro63aKxZnHczMcMSmsK4Y+QJnu2vKfXSybOY5nUvmYgVEA/uynVVdry8F37Ea9esM+2/YCn4iEK+2+mNAG2HELbMqBA81XkyS25hlcsGqNkLVmlmv/7HyTEGgRAmVhDwktrjECEbHyQ3PqWrN95oaTOekp6gW7gUCIVC5Nw/EXUOwABMz7o3a3FtuPDjEXUiLLrpSubaOF0DfsA6fjuuVS+F8vwjGtoZ8PZWVSNeCxoTZS9BovolzkvhdorvCz0Ing2NzVNGMroMAKvt6K5Y/DupAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHjAZi4EVBUvdMxrcFaiiwl23L4DVXsDdqob1VzA6R4=;
 b=QtyyWpzz4WwNs2ClH/6BZp5gYgpZ5S7JbRF+hf0ipBdvXrVXSp+T3Y8JVwyBym/pgikvfq6GlsRoFjAnKv4AGyaDq8j3hNxjQJK6fFDJySUlMYtVxkVDNJnyzHMyPFewBab5QaeEHPBKLQokkYy0y8Puc2Dzvdn1ugTnM0KL3JfTqXjtQYe1uPSCpnO3Ws1MlW76PYVJkLDsaCZxTGUX1nyENnm0mlXFb+Hc7kSw1XhsDhCI3nZWKiIroS54k4qLIjfT8TKCSkwiBMBiiMNpwdFYVO48pJp32bEMwA9oPnhzs6kHuf7Mrc/FuiDIJJDmFCCGxMj0qP+n+hvKFPp+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHjAZi4EVBUvdMxrcFaiiwl23L4DVXsDdqob1VzA6R4=;
 b=rHjJV51Sum0mdIsHQFyRC133autyRZ5hv9nnxVo9bp9URqGwdQr/KSGhZzYP3rv1SyN1GW3Sxh9t1k+gNMiQhqIQfHDcpkBq68X2M72G7c4uSHkapoRHbTPmu6QUEoxkDNQpDi42NcbOoK6X21jnwfCvc0NxuoUMYS6CkUyZbNM=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:49 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 29/66] arch/s390: Use maple tree iterators instead of
 linked list.
Thread-Topic: [PATCH v3 29/66] arch/s390: Use maple tree iterators instead of
 linked list.
Thread-Index: AQHXuYigo1AlosNw5UeuJ98W6cXpoQ==
Date:   Tue, 5 Oct 2021 01:30:48 +0000
Message-ID: <20211005012959.1110504-30-Liam.Howlett@oracle.com>
References: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c055a913-b02a-450d-bf14-08d9879fc386
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044CC88D2E752479CE26E43FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TT9hZASySIEH8nGpdnKTmd+f6FEm/3019zAOsdLUzdOpkxHFCkOvbnXn0RKdVkge/WcoRL9685d6ISXHBWw55Xk+BPhrf+SuK44hrLokzdaeinCChoQZF6+bN6E8sh5dpXA9J/zmhY3VcxVHeEaQXxwrXPqxCfK3Mj2CVhtTr5errgZxjs26Xx53GoSuFQlDOgY346KsvaDDT+YrUs4JzYN33z0Z8w5odRcnEDfQbCVeVUBoikhrdEWeOYdpWzl+84RoYXk8GHG2T0zcPVSXdg7dMr0n0cy9NoJvM7VjUK6QvUZJX/4rV23X0k55Wsi1bO2o19HatBuzQLblhIJK2EgAUjQ9WcfY0ieYHqMtIWVGxYkPTDY5CJLf/x4q6zvcElWEJYUuiRLUTE2iPPp8pV0zkbs2ms0bgM66B7ZbwtlC4V0RnLH6pYjeyMRBVA22n4wE+3lFRqhHHwsLjefQXYlqTqMbvfKi62nmLmBbGqD6wo8oljJfvPv1rZcrd9zIIt/X9w27sr3SZsU48CMRaVK7j7vJGDcJJEuWBLPOB5IRs8OXTlAJL0rjTbzib0MvM78voICk6MHWhMnKOvPHALnf0CGzeOQyeIRuN8QlMkcW8/lXie4sH9r7lem83zUiJTwFilop0m0K5bMRzK17o2rN2aQ4tH6xwuXgv8PzB0hHnLoxAGY/od6zLTdUKYVUZKjADlg4kYHUgp67WyX4BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zsqUgZ0FJMLf/Ge8qOJ05bGeNeXS0w4ZoyWCY3nlWuQy4imcRH2/jkPnf6?=
 =?iso-8859-1?Q?Yx5QZRMVnRa+i2mEnC62AtzxikROG6bla41OV80d4Sq7oNMCTSNskLKw8u?=
 =?iso-8859-1?Q?wetZo37VXF4gGJD5TmK3N+Wo7Qxvv9AxV8GlML9bMzWfNJRC4BvbTq8RZY?=
 =?iso-8859-1?Q?xvHlzU6aT5eqwB3wdLDw1MZlRITuu/1G/ZuBs6SDUfR1SEe9O6gHnuGmxE?=
 =?iso-8859-1?Q?SluWajXfDvfBCu/+KMsyJakfoCw/Qu4iZRmoG6kQWZGYceMckla9ksovH/?=
 =?iso-8859-1?Q?BqAgQttA+zRPVespTSNUMS1EdZYh6C9Er6wZ7uKaLT5piLuZPmPuDNaEK5?=
 =?iso-8859-1?Q?NON1wEyU9idLidLeIYYVF3NHcgWFR3KhLWJ9sPaWYPYLyU5aaKIJYeQQPd?=
 =?iso-8859-1?Q?GEMmic0mowog7bRNLp6U2jRfd3ugsS8ihPmenAZh9YMC2DcPyzYoYlpL5a?=
 =?iso-8859-1?Q?2xBjHRP+v10zZy3/xo4eaoiouVY14u3NFQ2VS8ot/omt8sTLqGGkqBd2oJ?=
 =?iso-8859-1?Q?pRTAXidq/7Qyh+TJtK+RjuvyTmUm5FLbejhIVQhZbHLbEkvyVWFK58kyUa?=
 =?iso-8859-1?Q?sN6gCgIGrE8tTgaNKA5q24JCHyFpsRKC4dF/YSHpt/lZL+bJSIRQ3qJemX?=
 =?iso-8859-1?Q?VdESwPDwq599n98wmqmZ9ZTCOcEJPWuHkGGguD9icPfu+KEu5HAqI5mq4B?=
 =?iso-8859-1?Q?KWfusf4nEAhAhjZJVAIW3LEfTAMxVFjMGJAE12VMp1iBsdurMCwu6eweyC?=
 =?iso-8859-1?Q?2FCi3Q3Yr5nnG2Hb2PMTJfHli3aWi4QvMZTZ3zmOKbAJAvA4rOcb7tzrBf?=
 =?iso-8859-1?Q?8e3EuXO+OkpHlKk2tNt0AFMkJqaFdXvHi5fHY/3Ha58YU2sO2Yt19GiL9q?=
 =?iso-8859-1?Q?Vhs2sLC64lzy4tGpl8oy3y6zdwdi4nGJCm8vyUZIyajM5ejtl/DtPcNY5b?=
 =?iso-8859-1?Q?AsFM8fDf5X8qUQ07d8Wxz0mb2Xrz6uBAZBbonryvtFNizHXQvHtSOfZFLK?=
 =?iso-8859-1?Q?fqnL4w6kkL1eAe3WPToZHJZlo+uyHURPyTBIX2gDhCLH28NdM6QJuStgIP?=
 =?iso-8859-1?Q?S4OCYCI6gu68rZU24AmIAOPYRkx2mNb3OWGBTd70/2I3v4kMCfGRXv8Bf+?=
 =?iso-8859-1?Q?9Ousc7vtfgVxNHSMSYLh2yqjdEH5WDcizPleO5xdThiVph65F6IJeR06YM?=
 =?iso-8859-1?Q?+DqEO9SgXWngE7Q9BAdHoV1urVPrTLWLZeIWf5ia3vBrLWkSgtTd/4tuGQ?=
 =?iso-8859-1?Q?i6cWm5RDXf04Cu+Er/fUPYE4MbmQL9sNdlbEHy9nomCMpqJBh4K7Set7kq?=
 =?iso-8859-1?Q?vYR89gr+aVc4WVyruU18QFEyNqHP5olxb1Zw7/ZeFt69c7QQyxQ3s5o+ww?=
 =?iso-8859-1?Q?y64L1VKBFH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c055a913-b02a-450d-bf14-08d9879fc386
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:48.9199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VO5402ht8P8FBmS4A8gez1NJGfwaWJUfp0qAMVJ33kTSdjN12wR/Pb06KIrXXAjXKjbvbqYU1w0taD7giOOGuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: phLb1XdYSm9vsrcqRogA1ehJlal72fqY
X-Proofpoint-GUID: phLb1XdYSm9vsrcqRogA1ehJlal72fqY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/s390/mm/gmap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 4d3b33ce81c6..fdf7f1d17549 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2501,8 +2501,10 @@ static const struct mm_walk_ops thp_split_walk_ops =
=3D {
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	/* Must hold mm_mt lock already */
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		vma->vm_flags &=3D ~VM_HUGEPAGE;
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &thp_split_walk_ops, NULL);
@@ -2570,8 +2572,10 @@ int gmap_mark_unmergeable(void)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	int ret;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	/* Must hold mm_mt lock already */
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
 				  MADV_UNMERGEABLE, &vma->vm_flags);
 		if (ret)
--=20
2.30.2
