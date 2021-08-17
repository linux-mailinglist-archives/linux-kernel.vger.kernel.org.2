Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C5F3EEF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhHQPwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:52:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38310 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240237AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkEMN023526;
        Tue, 17 Aug 2021 15:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jOKEBeqUdNIGuNIf1dln08O5YJigBOo1pWuIZqhtwyc=;
 b=iPzB9IERqP1a1CeA7QhTqfF1LKkV57EznPt3VO11eqSHrveipf/oVu2R9aXmi8I6E3Wg
 EYNi9p5dGPuYxAOw9ypco2pjLBkF0Bd9xW49r/Br2jpFYcHibp5EeG/D/vdiNlCeAyUd
 kWRuOn710OiPoOWIDZ1ny3vx9+4jE/PYCktAU+oddwV6sEqlV1+k0GZeX3gf/nUrTXcU
 1+CsGKe5tpNoRZksyjqKE79wg51ThwyKNe/Br+NsB06PRRxFgDcXziVy7PCQVdJqe+Iw
 ynFrU+Ure0q+HPvnq/di4TKO0nEsi3KbIhNWZD5xRqclIgxxk4KgDvkDSk3rKfzPgtJh 9A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jOKEBeqUdNIGuNIf1dln08O5YJigBOo1pWuIZqhtwyc=;
 b=nWk3Zy0aRZXVRDtNRT1tPhlmBOnGwzRo9OY02Z81jDp/m79Kz0G6X668BWXVsxfqIQUg
 MnFlumqTMDcYvcryW5DHYAJP/FKUoMdsawAw3Xbdn/8V50moPidllk1unIldEQh8v20I
 yep6UVFe4yVG1rsIMuzcZK4TEBhY2N6TNpfvsQ5iu/h9gfByOw2MOkz9CrDUfwnz6Rm8
 kCerGqsHT7B0tjH2hDlFSoHFPmEVJlShIzWTo5D3IEHX/r/b+M+RJpfSB9qqWXyxqrQT
 ws/zJRoh4ggOJRwZOCD+e3326lQXaI19CslOqBTWQdLyhSOsFbJASkhHKHvL/DKrk/qf dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd4kcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfA158706;
        Tue, 17 Aug 2021 15:47:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3ae5n7styr-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeI3bFDfFF4ry2LLSezPZHaE/p9SfsRA34h1UyQFazXui+XA34b5g9LGaF+QKn4Tqu4Vb7/K9rRIwr9cZI5LE1Qt3D56lFWoUOam5HRQu86Mjpyk5/hFl/M1FhbW6kEFB6Xhrp/RevYTI7nFW57ZGRWl3NS0huIYWLQBpZ9Ux0fKwBruYUmjxwaA46BFze0KUvqvCSa+QRtZISNrZdxvkrijWYRdv7xpK+8hOxOOVnYB1bOm8Z/St3ntb5/1RKQUEuGE9ZobDJmMI3POyl+R/aG7sLNyGbrBP1JqVqXImeTDTFlaTKUmbSycdXTPwKpef9MnpYVFa6KWYaXVutdkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOKEBeqUdNIGuNIf1dln08O5YJigBOo1pWuIZqhtwyc=;
 b=bmloC9mgfBhff0JwYuLMRMLC22OTQg9mymzVf4oBieRHuzvjlkzs1P0HCV6Q8izGD0wBQqHEwGMUfwx5hWTupuU8FkVVHwETTJ/yfJEaABZmF4c10uOg2nPRQlqftLKF5WpoQHSLttT2CoAw3wZ2fpTU+b2ROIXu02OyanvP8WKaRQowAbUujbew6ZDExEd20aFIWieyTRFpfu1d9stvP0bk4/wiYYzGlUVbOKiwr2Z4wSOKCrVjSNNNs6JNVKi0XD2ajfoExWCBUVph779kCOqrLB/CF3OyYZecjO/sE0JG2YFwMTQtWjjCqdEFUZFmePrDRsgF5dlIzIBt4f6vGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOKEBeqUdNIGuNIf1dln08O5YJigBOo1pWuIZqhtwyc=;
 b=hUMCkxWv8pHcA49LLrlwrA1zWJ0gCTr4afopdmESek51ISvWeveWwKoD0FZtqN4THh2rkaAuiLvrIpU8MHizWLMAiiORc+9eMoCxyo0r225gGTmVkMLNXwNVuaDTGfhU3pXKE7OI57qlLXX2J+cMlpGTeSa5daDSslTu1pwQkTc=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:20 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:20 +0000
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
Subject: [PATCH v2 26/61] arch/powerpc: Remove mmap linked list from
 mm/book3s32/tlb
Thread-Topic: [PATCH v2 26/61] arch/powerpc: Remove mmap linked list from
 mm/book3s32/tlb
Thread-Index: AQHXk38pX98s7en4B0iYHrhphmYqFQ==
Date:   Tue, 17 Aug 2021 15:47:19 +0000
Message-ID: <20210817154651.1570984-27-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 0a5329b8-a50e-4ddb-c8e9-08d961964c37
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4236E3108B9F1BBE2B0B6221FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wkwCZgrpPQuudO2BQNyhMd2pOLlEwicMQkM0hzq5Nn2LSKBYm7OP5zSasZwIV6niOv/xod1ogFGeBbcQjAJQGZ0KLe0VNyivaLycvbHVGTjDUquZWx61r1D5YSW7ofulICqRRz1xEVhBnTSz2shE30Lv25qbi0h2IvqI/rZxubF+ASTMDtwFO+iJ6w2657co953n6Bge9vu+ZKg6njBBzziEGuvjzayHxcwfy2xdGZ3bhx7CJ+Ho0whirZBCNFK3IEM+sDuU7SseRp42ANw1JMvevNOC0tQsBikgbHTHnxJe+7eqQ7+fBBZGsSh139Aj/00LicbgHbw8wOetyTQu9aOoUi70e7cN7I3rU3xrBTCorCnIViCnjbH51aBMAb27MoLHCJ1i/CgBNy7rIGluOW0MwvOgMoeu7up65okuA7YcIQ9W3vknvf/rtImhk/1cu8Ry+l94/ad4hQofpfyW6lk5PEu+ID5EPIjc7Xz4eOPxeheACIOOVam8BbQVs6XAWEIqwdDyewvuWsJRv+3U4tfuvmmDv8RgbncBEETJUVdKPPfZeF63+us7TzivGSgKH/6iuil++9VN41dFdfG1FDGw1pbMcaDJlg5dxeHzpQ+rmcOh5Tccp/41nG3wIPG34r9U6q157Rs3KFXGLY2/N/ezomX5y8nSYIJQhXg3EuxjVGfO3ksE08PYWKPg8B1LPRteBfctwxh5PjD83SJV5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YvLZu+ZXeKGjXj0l8wSC60PReN4kJuhy3AN8z2GL4n4Ta42vTWeRcOKV2E?=
 =?iso-8859-1?Q?WF+sDpCUW5RcuIjmoScnptnmJ09NnXD3x10qgvOT2ixBA0Tlst6Ru+9Tb5?=
 =?iso-8859-1?Q?Er1SworjORSkWVj6+wavnTPWAx7fqWu++ficS/cCc3o1IZlc4lvSC9arlp?=
 =?iso-8859-1?Q?8IyeZMUJECy67TcsPjNdayYJ89Cn67BnC8uf+lyoGFewCWNsHo4OZNw5e1?=
 =?iso-8859-1?Q?nc6YfT5E2nSBjfwrYi5lkDDdg6yUcNjVJr6tYq+X6uMd4NiHJnWMJhya3V?=
 =?iso-8859-1?Q?Gl/npuRD44PgXLLbuB9CbycsLFV4NopuEnNRp09E7Majj3t0uFiqjr9Rrt?=
 =?iso-8859-1?Q?04VDsViYf7twWxbGw+4L2Oz3nItmeYmv38wfCuNI0vaVfNof9s40hD0HN5?=
 =?iso-8859-1?Q?fj4ITGHrHrxwY9x7JQpa3IKakWN84iK2qSojXmZzEBWL/hJykrkSd2hJ6j?=
 =?iso-8859-1?Q?6cGQkiFSYc31hqwcdT3xmAdazw+9SahfnyBqFZorkMM3744LJmaBVQ2XoK?=
 =?iso-8859-1?Q?M1042oUbDmfzgMGzWb2GVHt9ziJvJokaGN5cvbHlUqvIMhzwV7P853OGEs?=
 =?iso-8859-1?Q?Q7vQIfzyrZcDzPqIDIhyq8HrMFCAQNU9TJl3XTLxR5RM63INtNtQA0jM9t?=
 =?iso-8859-1?Q?5T0hG8xtEWvsKWg84S1m1GqhTwcIzv4k6amg3y/GeF8XkrPqHwmmFCaZCI?=
 =?iso-8859-1?Q?mO/CrzpcZ+U1Xvm6S7r/SCSu9zZJveTwfnntiY4HSJDoWcaoNiDFXtpITH?=
 =?iso-8859-1?Q?v8VcoNRwq7QvHegbJ06FUq5y8pMfnts+WyE5qO+gdPlhW84jOyFdZuq7BA?=
 =?iso-8859-1?Q?pR861oX/VPgfvLyzrTE/J5M36Qga5h8HTQfz6LRtNqY2V98dOhSSU3jv5z?=
 =?iso-8859-1?Q?dsqlSLVOQhMElAP00DSYyVsETv9mUpSxoIWMTps6yzXvG+Y7c0FEJhNaa9?=
 =?iso-8859-1?Q?6nPGE8aXWjhi75sAUIHpo3NCgaZMYN6ul8aE2Pegcglcqvg/xC/CY2RnCC?=
 =?iso-8859-1?Q?5g4+aiwLlJqKitPROm4lN/BH6A3PX+P8Siua+kIyEhWSr4+45U+JYvS95E?=
 =?iso-8859-1?Q?dbRSDVx+kZUdzTEYtNkchH+SDQnWc2+6srXNhzsgLxsXMahvQXpcX+TA4+?=
 =?iso-8859-1?Q?WpV+JRY+Z+lfwINGxZtwktJM/9p5lB/QzgCA/qZ+EDLNtmUDGPzNqd8Rdg?=
 =?iso-8859-1?Q?k02dHw8Bo1j8y3RunvOOxUAe68gN8ITUn6D31hQUxgwCKSq3AQwz8eup/M?=
 =?iso-8859-1?Q?vB3UpA4OQ8omaM8x+tprzX0V0BzpL7XQxZLT8Y56WfRzmS4ShuYKxU0uoy?=
 =?iso-8859-1?Q?kDjyyvCwLRa6vu/Yc19kwMoq6ZF50zPO1w9HG8vgsehNrhZRmSw+4SzmeG?=
 =?iso-8859-1?Q?JBab7BRJ3E?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5329b8-a50e-4ddb-c8e9-08d961964c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:19.9805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MnfkvHyLXn7B00WQ8KjmCPcA1CBkvVAFesLRxXwAgqxfgdNy49qzFs3mZZuiy5O8qRqq1zzEGAD196aVfXGHcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: q3dcj1Kpr6w_uzHm1Aq9yD1C56deG4CN
X-Proofpoint-GUID: q3dcj1Kpr6w_uzHm1Aq9yD1C56deG4CN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Start using the maple tree

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/powerpc/mm/book3s32/tlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.=
c
index 19f0ef950d77..2c8b991de8e8 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -81,6 +81,7 @@ EXPORT_SYMBOL(hash__flush_range);
 void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/*
 	 * It is safe to go down the mm's list of vmas when called
@@ -88,8 +89,10 @@ void hash__flush_tlb_mm(struct mm_struct *mm)
 	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
 	 * but it seems dup_mmap is the only SMP case which gets here.
 	 */
-	for (mp =3D mm->mmap; mp !=3D NULL; mp =3D mp->vm_next)
+	rcu_read_lock();
+	mas_for_each(&mas, mp, ULONG_MAX)
 		hash__flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(hash__flush_tlb_mm);
=20
--=20
2.30.2
