Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2063EEFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbhHQPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1774 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240279AbhHQPtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:00 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjfGg011256;
        Tue, 17 Aug 2021 15:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FLMB1raS0j2cCgAFeyTR6twrpjI+vtNl+tj7PSFykN0=;
 b=RjOSPCMgz6Lp9janCkEC9JmvXeQYf4/Ic/fOaVj5ymKvk3PiLCm0HS0nvBMkNAFwoJUl
 2ZYHKD00yPopstjSpUdQKudWNxmlsv2ax4M2bQOWnfoxWZj11Jlq+vVfEi9JGCtzggXu
 rzq9te8f0pGZmqONwlxoFP47gMPOZGb30CV7VtR3CdpEOr54Ny9ep3UptvfCF03euo7y
 x3c9NwZOCbnZ/e9kbLHY9eSClRgyjbX5vgkJPjny4eNbXQZVPn1vnJymzt0lryzvxjkp
 Mgk+xSBGfurLaI1f4rz2PK7HhYTlh+qU7+s4LnS23zS7quhbS17BheOqz32yYEFgCyiE bw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FLMB1raS0j2cCgAFeyTR6twrpjI+vtNl+tj7PSFykN0=;
 b=ahmULAWjByz3cu2fkpj7QHiwaWazjfvbQyeYCJ6HkW/TRxjPqvIISjaF7fZgzUN847t+
 P11ivO6ggOllGAQ/zYUAKcleoYrzZGS3/fhM+gdN8tKQc4zIlTtzNF8GQ5455W4ctlMV
 8PrQ0ipF61Z65zmMekTb6ILifd254AMfSggPDQri8yt1ke3cptRdkLJbigjnfpNlO3Ug
 C20SKejrYos3rUS03hj1onpYEnoH+khHDE0b0Vvbd+DsMXvubaIcluhK6u/CNN1EvxIz
 9J74IeRR/X51smhB/F/Dx7NK98trnCK9CcROstuIVWAx2ei991aVSAxpAg7ixN2uhKtR 2w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7d8bt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFktxr094445;
        Tue, 17 Aug 2021 15:47:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3030.oracle.com with ESMTP id 3ae3vftd83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcpiYGyD+EoX5TEsq/tcd62zZ6RV83zpsX3dMA9b/ztggaqaQl+2J70daOIXJ5Ue2TenEtRLq5uXwUneP2xAROeral1927MgPPP3H7IVxQlRQpVwI6QfnwFx7uXO0pL58Qu7y4MpR+m2zzch/ns1sAd/is1VUtUePYv3AHB3DeTdfLNbk5Izs/rNIbbrYJ17xkKy9QqP/w5XrEFlHgCBXeTGXZ8/CxikwihAo6t+smOTDYfSgNfSZEedV6/l6lNI70vuvhiiMF80rsl2zClmMV9bn4z7tu2hfzyVcYYuJya8AAYn6c7f2qyq2IV/gtqs+Bx07WU6uCww89JQtWiPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLMB1raS0j2cCgAFeyTR6twrpjI+vtNl+tj7PSFykN0=;
 b=XQ95mpqH2QIYmAkXTJSuh32rL4wmZ6OGa5Z9nP71GWLlieStyIuePJWo/T/Zqtu1CJdi8JyOnpEheOzi6pct0S2VqU7iTKiPsUPp/gh1Oqb6vAFNEimJG3qVCOKa71GCeADl995hwRMqePg8rUY8sVS0YEjh3JgRuT57dhmqPdtBf5JFEGgK2LsqGj847VYfO2RQFQV1qvcX7osap/CVfnIOd5Vhc0HNV9K7ZQcVQStt6V3cbOTRyXYGkNbZqWGVFrp3vtGje5fO7BUdGdyB2bIOj2hVKSOEr9Xsq7J+ML4AmQL+Se+yetmz7SJr4H/zUhkva+nJUH9N+/b+0TNUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLMB1raS0j2cCgAFeyTR6twrpjI+vtNl+tj7PSFykN0=;
 b=d9PV/r7FDsCwv4gx8nyuMF0nRDQJ3lqVM7USXBlzj6wGFRcVDsfhv6r9Hhp7tFuSJYYMObXBp/hvRr2FPvOE7O7pjUPHPO2+3LniSarTzxPqeNPALfQEouripTiptmPKo/Rq0AagdEWwaUgiUCd+efdXCwZUa93kWeiKdOHOEvw=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3097.namprd10.prod.outlook.com (2603:10b6:5:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 15:47:11 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 07/61] mm/mmap: Use the maple tree in find_vma() instead of
 the rbtree.
Thread-Topic: [PATCH v2 07/61] mm/mmap: Use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHXk38kwCeAQ/oOL0OIFCaK171Rgw==
Date:   Tue, 17 Aug 2021 15:47:10 +0000
Message-ID: <20210817154651.1570984-8-Liam.Howlett@oracle.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
In-Reply-To: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d05a3b44-e90b-45fb-64ea-08d961964724
x-ms-traffictypediagnostic: DM6PR10MB3097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3097114A5F8B1714309948A6FDFE9@DM6PR10MB3097.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iACIY3JMG8b+hnOpzbKi4+v6i0RxFMrQWWlc5f4nyOYMDUe/LxxRAyYDpVfSee2NdpwJaGgg41QvQ9y2i2F9hpffvCtz07CPIoOsAaNP3cl0MAmXGUqcExjlrC56c8ZCRp5E4bVJSY1NHZdHniJL0SisugbGkwipdMH0DjzKtIG0BEUFuhXBT1tL0D+z765qhShIKjnc4L/QM/Owu5+2zieM20nEvtdjjPI/ETKSwPxnVtNqnYQGBQyXN7hqF6RW7JhqRaKwCq4OghX/4lFI98lp/7+9/AQlcKC5M1JCYOdS/6fxCpT8HERtmg5XE2Msyw4FZoOjc3hUDUBHvh87rVzqPQ5Q5yO3x/ttxvEb3h+DExkXFdKtuJnlG3SZQsxp1/tggozCWW47eqRwWsMSX3cnvMX1bftMf0sGfljbMgQKVtEPnWWX3kaOWqc1xFlCxfW6KzyXxX6291+C5qcUKhN+YWrjorw6xRmoflLow7N4BltHycafEKNKWCl1/7I8jaSeNOTNjEJPQy67rLmkhMPP1/NmNwzjoHLlQl1/k+X0KJPBwDbFJGoRySK5vYurgZRQbRDyxIkpSsleV8HZ1YeCvA409lWT6wM9ohCdB6+mLRf3be0QfV9u9YnVQA5EQM14VqIm/kVhwkIdjuKRKxovxZLfJjY+PX8JmNXhn+nrQDou7stj0ugUSii7k9AXOy7LbVWHFW+xSYpkpQ+2gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(6506007)(2616005)(54906003)(8936002)(478600001)(26005)(1076003)(38070700005)(110136005)(316002)(5660300002)(36756003)(6486002)(71200400001)(91956017)(66446008)(122000001)(6512007)(38100700002)(83380400001)(7416002)(44832011)(2906002)(186003)(4326008)(107886003)(86362001)(66946007)(64756008)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jl6tsF/8SseaUGbsUrm5PsadV6iffR4fiPfwjDXNRaXs7p/++dMQhxLFDK?=
 =?iso-8859-1?Q?clLQEZE40sliju2bFGbDheFUvUVZ9IgoEg/B7DJ8y3ITezDAFa0EDt7ACE?=
 =?iso-8859-1?Q?wzFOnX8so9hHr6SiS5md5s4ugyez+wL2bgsISdRixOUgoRWd6rMJwNMlCD?=
 =?iso-8859-1?Q?MzsrGdbZO53efv5K/Gz7QVvN+QKbDFEK3xb6bwneygnbMiOgfGkeg6I0Ou?=
 =?iso-8859-1?Q?WYqu3jFMorrNGkK8lJFwieniYJYtf3y8D9AO/PpKJKewoK/XlRx3rLODU2?=
 =?iso-8859-1?Q?05K4SpxuJd9z+eCwjUHwo+skzutbHzLvWAs/iep0KBB9Gyn6MwuCMBe4oR?=
 =?iso-8859-1?Q?VDFJW+aLfSKSgbcRVA3cvtMXn7UNTfruRyDYCrNSaWyANGEHjSWoIElKPj?=
 =?iso-8859-1?Q?CvgP7659DSTOV3jZ4BlB0kPCWUKjgYEQTVWIpvlY6ExAr3eT6AKpcWeVMm?=
 =?iso-8859-1?Q?Padgnx2X58tRv0iN429tXl1oPRFps0CA61tfVMGZOXckuVyNRncMic9+xj?=
 =?iso-8859-1?Q?Kk4MDuocJm3BiWzCZZ87p/PCfUfBGOu+FiTXr5K5NmFd2oUwh2m71X3WZZ?=
 =?iso-8859-1?Q?kcg6hKANVlEnVVsZ/JHtYoQ1gBcwUm20JG10yDojZdaxezOFR6iKh+JltF?=
 =?iso-8859-1?Q?btdIafcF8SCT9KSxfOqBqdYUrCMWzdCpkhmDnSce+kn3/2BZitixBpxPw5?=
 =?iso-8859-1?Q?DVGKiGDZqJbR4BuvDGMbY4tzUdXzrieqIm46zx27No42a4fEclFo5O4ZJk?=
 =?iso-8859-1?Q?RHYfdmKb89F7+4Lbde4o7DNRcg4R7r5vHCMdWbNP11jxLr3vpSMZ47Ot6z?=
 =?iso-8859-1?Q?vi1ts4bP4MjG43Zl6Mq5lRChGp37288WcbL2Lceugohh0v2JOmbWFpM+HO?=
 =?iso-8859-1?Q?gNSYeHEvPCNOtnVxh80bCPUOwJ14sQM/Xy3auCtPBFcif27Lio8n7piOLY?=
 =?iso-8859-1?Q?TqeKa1F/ReN21y7IEAgmenVgvcIDT8I7DS9DXK3t2cNcRnssyA8pB+oC0q?=
 =?iso-8859-1?Q?wuAs8qx4MaBtRgFZoN7aKiDW+ZMd2gAX89jGXT80VZ/vAOqLh5hrmE/jDS?=
 =?iso-8859-1?Q?NtvZChpsESZPcG8y1sLDb8CU8tuZYCmXECF64W1ZE7B/8ZPED6icSoWIn4?=
 =?iso-8859-1?Q?W/CP3id9LJPvNEJ3uLf2GznJghyyIV/A6omQ4WClogL+S33m4xmsJYc7XU?=
 =?iso-8859-1?Q?IWKXl1BDafouUx6iKUxWtI/coQkH1SqQ0tUjJ9sC7SVp9rvIWFH1LWKfjh?=
 =?iso-8859-1?Q?caLgzrkJGTa4uO7p/s9eTs/q2jfMNBu1/L9sQ7Q5AkfljiDCL8/TZwhId6?=
 =?iso-8859-1?Q?BXUX8ZugbmVsWAswArUsMngI0ypLk7QFRhzZfpV8xL1S4GQDVzoLHIIRcK?=
 =?iso-8859-1?Q?atPKI8wMdQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05a3b44-e90b-45fb-64ea-08d961964724
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:10.8276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPkbxQk5ChID/1Y9kO/ZuZOCJFSnqyU7mtTbIariJ9BG2DM7O0bk9PQRiMrcPankRpL7t6zSrsWc8WcW5981ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: mqGByb-l9mgK9Xr8O6Z2qhBFPjxn1Kik
X-Proofpoint-ORIG-GUID: mqGByb-l9mgK9Xr8O6Z2qhBFPjxn1Kik
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Using the maple tree interface mt_find() will handle the RCU locking and
will start searching at the address up to the limit, ULONG_MAX in this
case.

Add kernel documentation to this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e891977293fa..899747a75d5c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2487,10 +2487,16 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
=20
 	mmap_assert_locked(mm);
@@ -2499,24 +2505,10 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	rb_node =3D mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma =3D tmp;
-			if (tmp->vm_start <=3D addr)
-				break;
-			rb_node =3D rb_node->rb_left;
-		} else
-			rb_node =3D rb_node->rb_right;
-	}
-
+	vma =3D mt_find(&mm->mm_mt, &addr, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
+
 	return vma;
 }
 EXPORT_SYMBOL(find_vma);
--=20
2.30.2
