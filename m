Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D529636DC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbhD1Po5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:44:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60246 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240768AbhD1PjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:39:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFM3In013796;
        Wed, 28 Apr 2021 15:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Yh7PzuDUWjyJAJ7MXcHop/Qws2HDAa27PNCspeXlX8o=;
 b=gvprX5T+/K3ZLnK/B/e/EZI5grHJVv8zpB73a8bgmjJu5VsBpuJxiuVcN8l8eHXWW1OC
 iYcQnMZTJLd847o1uQxjzddlpw/EzlqYUkDMA1Fs/oULkLHiYcoUO7EgifWJLI6IZk8w
 MsWax+QXh9nlEeroaTA35/wWqtFkLpJNO3FSHaTGSjD1Bp5J/6CV2cutGn+Ews9BRqpR
 Guh1paCTewUGcYX2RiSOUQBwx8P6mQ+SKYo4qC3pHbQTB1cBZyiaEp+M3T6yViaPGkDY
 k/fgtE4OG78wM0x4IxaQlH5+CXJz/KrBYE3HXvOIFxlt75wBRGTQKgUZff44qf8vdRkl eQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:38:04 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFc2RP027246;
        Wed, 28 Apr 2021 15:38:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 3874d2773f-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lykk3xFDPrSaT6qt4nkJ/8xd/Z3zl7XN0vztCF3TRlsbuOFm//0UDemORtawxMId9eLil/Dln3D3403bAL7+3xI6zzNaUM6Rb+tKssX4qArvmUalEbFWiTC55aqtnHi8ufEinXNVypOqh9BFPi//L+AZBx1IZitomOvoUC+gtmABfrqyXwEXDCfPd/gNpHmCrYLPmqKZMryUki2QcrfnpHquIDRQOlGVgxFWN/zKRX/hTM9+WLOxVx5VKVSkpCsdNSt0mpmnKgbwwhr17p72vMgp/k7LNHXu7MM352KC2weKGI/8OJUpowhedmCV8cBJswp5v/XDU+JsG9hCmAHYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh7PzuDUWjyJAJ7MXcHop/Qws2HDAa27PNCspeXlX8o=;
 b=RewcjgWT4e3Zhc6T8hinTm2jF5rvtwBkc71Hjghz6a/AqGlbyIYplS5yPfWaVRF2NIgZoN8bW7ThGWeqlJ+UCPMcSgLBNtX41fqzqC3voW1KdTEfvK94kRNJ0MCRQcRN0jdOHn/N6x5vZ/B6L6AunfY+MjvGST2xfk+C+fS01DAutQihTLJMn3Q4Dy1X5A3KVa/vO7dS1U0G2eb7Qb56KDLqjEelv2QPsYzvegwcybX2ehGFQyQ768AtpZLDBWhn6TH+78OMUVb7eGPZhKjQk1Vg+W0w/2/jLvQdOsqqkOk35TfHfaNa6XquH3LqgduiM5kaglaN9vs/umWVCe7LGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh7PzuDUWjyJAJ7MXcHop/Qws2HDAa27PNCspeXlX8o=;
 b=SYs4fw/VfjR6TT7uuzn16CZAcTZuM1XdU76DKbGSCpwpiXZmVis55TF2Mx5ey7g0ggOPJw/5IF/dyspP2Z4ydhcCBSmd9acIeAbRYProxFvU6MHm308JPkfxWVXNzFDxDgecwxj+TT9Poi5N0f64iU1YjFoQ7M9nVpvlGx3CVmc=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:38:01 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:38:01 +0000
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
Subject: [PATCH 93/94] mm/mmap: Add mas_split_vma() and use it for munmap()
Thread-Topic: [PATCH 93/94] mm/mmap: Add mas_split_vma() and use it for
 munmap()
Thread-Index: AQHXPERD3sgzzL1RL02DDjtlqcDZNA==
Date:   Wed, 28 Apr 2021 15:36:32 +0000
Message-ID: <20210428153542.2814175-94-Liam.Howlett@Oracle.com>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a9267b0-ccbd-4e06-f3f0-08d90a5b9b4d
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4548B6681F3F66511D0C2259FD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vrXMjUjyYNvN1lLrJ26HigDZQ+mAQ6z/wFxyH3jw9A5kOuH5yyWJ58eZfxBs4qnyFhpB4y9+Csyajj3Ar2ygOV8AiqRoxcDKVPfW/65/3rtU+aqZqKDj6DaaLRnM0vKBAgb22ivZiDW21Es6PvHtulx375TgNnIR0ldoROi7lSDsJMENL2qS6GUTAqr2VFURXyTOMnucBCHwpmoK3jwi0QEzWLWEzgGPYtpLhvUGJXIxH56ZzMsWcbwrlnIm2cpC4v8PwfZGsV4gpRzNxJgHxRSZ0ZsOiSpe3qLyfxplspoOVeintYXpF7S4b1Qti2BY/ROgjEng7aOlSHxL+2Y+4VG+pr/yk5SX8JgfuolkmXlipFpZ+u4wGEwHxmAwlpMJTlONlK5sq4ACOUmPLxgnpCnL0MdzgyYi08kCPCChQHtVosiL4OpZkP2bpft9DRzd6bU4eh1iYkcb2cQM7yv4d2s4Ob29ecFUZTkypUdwDJ4ff070D7Z2deb3vyMquY6C7SgQE8qflWM5vwy0k2yZfud6cbm6VGRUwk+AsOTQ44wP6idDzP6JkHTtJlcn17tHxAHgX7oToX2gvCvZZhb36wBrJEAxmHfR45agvWZ6PN4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6666004)(6486002)(71200400001)(5660300002)(316002)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?QlyDGbATe1ZpK4ZVHobXc11aG4mTxdbu4ZkRxWUWO8cPF80Me0Ii+7Vm2o?=
 =?iso-8859-1?Q?5uCK+AVOP3gPT54e6UC/3gNVpYuLvFaabmpZT8sSG0Ufmfc8EjrtF7i12C?=
 =?iso-8859-1?Q?qRtMmt4B5teLwCOF3zXxN2A2J2hHSUvUbyu/Z5SYZjXCWyiH7x7pAmBh03?=
 =?iso-8859-1?Q?Nly+Da27glH6Co5RHfvz6U1k3piZJ34PYDcSpUcwfkceAQ1i+a3neD0ZuC?=
 =?iso-8859-1?Q?/fuexF1QQRDrpOrSbi6Tcxj1LQAscgnerWPVKOch4tnTpDVrKxLoRCvSDQ?=
 =?iso-8859-1?Q?rW0/iRuuEBUXwQUobZSHCBfNmlBvM++j7gmyKLYcE7PB7mDG8dL6VQg8T0?=
 =?iso-8859-1?Q?dPZ7IBYxLsLo9+qHY2JgekUL6qgOpX6Zwt9TZt32t7Suo94X5XMKUkKcC6?=
 =?iso-8859-1?Q?XsIxFhS3HWlA85Ltcx0aA3Ep6HpOR5UghJwLqPvyjpJa5kNIyKH71A4nQS?=
 =?iso-8859-1?Q?d1aRRMxtacqhORGv40lK8oLVOtb502B7vdWRcFUZIA+Jx9McghcfwXHvtn?=
 =?iso-8859-1?Q?mAUtyv9Yip67LpufyEKcqKtLsuGJL5ENl+xtQT91OxNYN6iotNBxiBaWas?=
 =?iso-8859-1?Q?yZyk7MZ9C0Gu+EhrDvEiRWNyTKbgVqWtjrToyHwWT9p0UQUYWe/FUpe+2g?=
 =?iso-8859-1?Q?PPwQ1P2GjAyTGcChhokjNRdNT9enKLaOfW6wdwUXYjQzLW37XGwkOuFHRh?=
 =?iso-8859-1?Q?pEFvYYN3pM01E/NVqehwanKVTFvaNpfhz/utGKSnkx3Qg0k2457eiyHOQS?=
 =?iso-8859-1?Q?C5A3dQCvkbzTlBL9uwep2K1ITkA3MFf1h02INVh2iFBnTuHfWZmK/J9csI?=
 =?iso-8859-1?Q?tyJY7QDQ6Y00mvbuMoON6+rFrNb5PF0ezJ8jfbTmWiyaHhBf0urUoApGzl?=
 =?iso-8859-1?Q?Rsx2+RliBYbJbsf2SfpYmN6vgQcoqtEV4ZOmKx4AOLEYaOvGUMB8e9AZuW?=
 =?iso-8859-1?Q?VKKcC+Jenvc118CiFxKF+KFwwB+SROD3S+IH7PcxcZpZhL84Y6ot7hh85A?=
 =?iso-8859-1?Q?iA+ng/9EbIV6GFH2yknPrByI/bPxuTbWoda3VZffA5imLh0SiccB7uwlBj?=
 =?iso-8859-1?Q?S8iyHgLNbF9ivK6P7/lCbpWk3LHkeu+8E8n7x7YKN+KK7zhi69+qJBBA+b?=
 =?iso-8859-1?Q?W+wgamGssYVdGq9n3goK1RXiuqCKOkZXuX/g5/iXGcHnD1v805ZYRACgmr?=
 =?iso-8859-1?Q?mDtpuUdT25Vr+42jDuN1mPHECsh50XAFprHvnC/VR5Zk2rmdwoecMnDESK?=
 =?iso-8859-1?Q?bF69Vr5RjtQ3BH67evSwH+9QMVjEvZ77dk6KU1BLPwpRw5P9siXffMWOql?=
 =?iso-8859-1?Q?wjA8esHH/wDIm0S0CA7OeiqzPHEHtBlZ2c9Kq9vZW6H/GjPWLvqMTXQN7D?=
 =?iso-8859-1?Q?FePD3YC466?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9267b0-ccbd-4e06-f3f0-08d90a5b9b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:32.3218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4aYUPOJw8l+rW0cfbLp0J4wLdkk/Us6dtYd6deMBE6PkJCx+/u3Di/IQBQXM4QrG4QKBi91vNuaFa7/nQ693Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: 1v08-ndGKnGx4cwHLi2DfbKECeWRkOsE
X-Proofpoint-GUID: 1v08-ndGKnGx4cwHLi2DfbKECeWRkOsE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the maple state when splitting a node to not have to rewalk/reset the s=
tate on splits.
This is also needed to clean the locks up

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 185 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 175 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ae1ffe726405..5335bd72bda3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2182,6 +2182,178 @@ static void unmap_region(struct mm_struct *mm,
 		      max);
 	tlb_finish_mmu(&tlb);
 }
+
+/*
+ *
+ * Does not support inserting a new vma and modifying the other side of th=
e vma
+ * mas will point to insert or the new zeroed area.
+ */
+static inline
+int vma_shrink(struct ma_state *mas, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff,
+	       struct vm_area_struct *insert)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct address_space *mapping =3D NULL;
+	struct rb_root_cached *root =3D NULL;
+	struct anon_vma *anon_vma =3D NULL;
+	struct file *file =3D vma->vm_file;
+	unsigned long old_end =3D vma->vm_end, old_start =3D vma->vm_start;
+
+	validate_mm(mm);
+	vma_adjust_trans_huge(vma, start, end, 0);
+	if (file) {
+		mapping =3D file->f_mapping;
+		root =3D &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+
+		i_mmap_lock_write(mapping);
+		/*
+		 * Put into interval tree now, so instantiated pages are visible
+		 * to arm/parisc __flush_dcache_page throughout; but we cannot
+		 * insert into address space until vma start or end is updated.
+		 */
+
+		if (insert)
+			__vma_link_file(insert);
+	}
+
+	anon_vma =3D vma->anon_vma;
+	if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	if (file) {
+		flush_dcache_mmap_lock(mapping);
+		vma_interval_tree_remove(vma, root);
+	}
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	if (!insert) {
+
+		/* If vm_start changed, and the insert does not end at the old
+		 * start, then that area needs to be zeroed
+		 */
+		if (old_start !=3D vma->vm_start) {
+			mas->last =3D end;
+			mas_store_gfp(mas, NULL, GFP_KERNEL);
+		}
+
+		/* If vm_end changed, and the insert does not start at the new
+		 * end, then that area needs to be zeroed
+		 */
+		if (old_end !=3D vma->vm_end) {
+			mas->index =3D end;
+			mas->last =3D old_end;
+			mas_store_gfp(mas, NULL, GFP_KERNEL);
+		}
+	}
+
+	if (file) {
+		vma_interval_tree_insert(vma, root);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
+	if (insert) {  // Insert.
+		vma_mas_store(insert, mas);
+		mm->map_count++;
+	}
+
+	if (anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(anon_vma);
+	}
+
+	if (file) {
+		i_mmap_unlock_write(mapping);
+		uprobe_mmap(vma);
+		if (insert)
+			uprobe_mmap(insert);
+	}
+
+	validate_mm(mm);
+	return 0;
+}
+
+/*
+ * mas_split_vma() - Split the VMA into two.
+ *
+ * @mm: The mm_struct
+ * @mas: The maple state - must point to the vma being altered
+ * @vma: The vma to split
+ * @addr: The address to split @vma
+ * @new_below: Add the new vma at the lower address (first part) of vma.
+ *
+ * Note: The @mas must point to the vma that is being split or MAS_START.
+ * Upon return, @mas points to the new VMA.  sysctl_max_map_count is not
+ * checked.
+ */
+int mas_split_vma(struct mm_struct *mm, struct ma_state *mas,
+		  struct vm_area_struct *vma, unsigned long addr, int new_below)
+{
+	struct vm_area_struct *new;
+	int err;
+
+	validate_mm(mm);
+	if (vma->vm_ops && vma->vm_ops->may_split) {
+		err =3D vma->vm_ops->may_split(vma, addr);
+		if (err)
+			return err;
+	}
+
+	new =3D vm_area_dup(vma);
+	if (!new)
+		return -ENOMEM;
+
+	if (new_below)
+		new->vm_end =3D addr;
+	else {
+		new->vm_start =3D addr;
+		new->vm_pgoff +=3D ((addr - vma->vm_start) >> PAGE_SHIFT);
+	}
+
+	err =3D vma_dup_policy(vma, new);
+	if (err)
+		goto out_free_vma;
+
+	err =3D anon_vma_clone(new, vma);
+	if (err)
+		goto out_free_mpol;
+
+	if (new->vm_file)
+		get_file(new->vm_file);
+
+	if (new->vm_ops && new->vm_ops->open)
+		new->vm_ops->open(new);
+
+	if (new_below)
+		err =3D vma_shrink(mas, vma, addr, vma->vm_end, vma->vm_pgoff +
+			((addr - new->vm_start) >> PAGE_SHIFT), new);
+	else
+		err =3D vma_shrink(mas, vma, vma->vm_start, addr, vma->vm_pgoff,
+				 new);
+
+	validate_mm(mm);
+	/* Success. */
+	if (!err)
+		return 0;
+
+	/* Clean everything up if vma_adjust failed. */
+	if (new->vm_ops && new->vm_ops->close)
+		new->vm_ops->close(new);
+	if (new->vm_file)
+		fput(new->vm_file);
+	unlink_anon_vmas(new);
+ out_free_mpol:
+	mpol_put(vma_policy(new));
+ out_free_vma:
+	vm_area_free(new);
+	return err;
+}
+
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
@@ -2330,12 +2502,11 @@ static int do_mas_align_munmap(struct ma_state *mas=
, struct vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			return -ENOMEM;
=20
-		error =3D __split_vma(mm, vma, start, 0);
+		error =3D mas_split_vma(mm, mas, vma, start, 0);
 		if (error)
 			return error;
=20
 		prev =3D vma;
-		mas_set_range(mas, start, end - 1);
 		vma =3D mas_walk(mas);
=20
 	} else {
@@ -2353,11 +2524,10 @@ static int do_mas_align_munmap(struct ma_state *mas=
, struct vm_area_struct *vma,
 	/* Does it split the last one? */
 	if (last && end < last->vm_end) {
 		int error;
-		error =3D __split_vma(mm, last, end, 1);
+		error =3D mas_split_vma(mm, mas, last, end, 1);
 		if (error)
 			return error;
-		mas_set(mas, end - 1);
-		last =3D mas_walk(mas);
+		validate_mm(mm);
 	}
 	next =3D mas_next(mas, ULONG_MAX);
=20
@@ -2518,11 +2688,8 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
-	mas_set_range(&mas, addr, end - 1);
-	mas_walk(&mas);  // Walk to the empty area (munmapped above)
 	ma_prev =3D mas;
 	prev =3D mas_prev(&ma_prev, 0);
-
 	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
=20
@@ -2694,10 +2861,8 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	 * a completely new data area).
 	 */
 	vma->vm_flags |=3D VM_SOFTDIRTY;
-
 	vma_set_page_prot(vma);
 	validate_mm(mm);
-
 	return addr;
=20
 unmap_and_free_vma:
--=20
2.30.2
