Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC6936DBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhD1Pj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54210 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240307AbhD1PhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:13 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKnmF030215;
        Wed, 28 Apr 2021 15:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=L06j6rP64VR3bQPAfjIeTK+Jxp5kfOQbUD/PncEaYRI=;
 b=jJsJCksP6bj8xJ1LgpLRgPU/xKEZE0KNmlajmsKGL6vcRdLaGx2w76kUFbwWL9moyHLr
 QdliqVMnp95pecr914gN9v/DiJBiZVuC3hLES240FQI7sR69+A9NtYtV3VGDF9sEFioW
 NDDrGkwA22KcEkIXh2LmtrAqOu0bp+7F8SQ3HZFI7v1QSRyv8kbprjEmVrtYm6OYTUMJ
 A+i/9VYaoPqdN5UNr8+70OwcMNnGTs4Rl/BhcNei9MdT+y+lEKeFAtupkb6YMYJ+xKy6
 7e71H7NJknG164llA4c37QwKqcfKy1H4BNn8KtFlT6SmOEvD9g7H4Uqwr80JH2cgX1YE sg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh61x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:11 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWRiw016446;
        Wed, 28 Apr 2021 15:36:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3020.oracle.com with ESMTP id 384w3uu9su-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2FdaQF9leTc7l3emT2dPTpk4SzSQFnjUNYi6zaUHar4EPOjIYiu3jFiHKMHwK7ILxQWrBTbaKiLV5LC3NFCVxsTYaurvte5wbjIWa/f91eclcufbwUfAyBuNWFQ9Y8rAATjDPwC31OvOH/W6D33SJ54X4Ae4DGw1dFRjvOeEIdQdkhKonb/96E4ArYVaPttNpT9BsYprqqJzm/sT/euKyOOCvNZvkmFjRQr4KVAerpSIBfCRFbhMy44QWdcU1U266MKu/4xtlwOC4bHn4LRHUxEKHEQG8XZ4VcpruscEwUSXzqKwTsiFqmzSW0JttjGwMKomoCIeXls45AHAhbo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L06j6rP64VR3bQPAfjIeTK+Jxp5kfOQbUD/PncEaYRI=;
 b=gOPJaczt0KzMu67R4AU86E//DOX1TEE+djY91aBSjDCQjlf0oiyxUL51+PWSgVxoXNLBq6Oc1KHUMebaDIR6ALzVZjC8CVz8Wyw3udM9+GGfgFWPwx2wi/gcUmSJIMiuzYX3Vp7Gqkvn6Ht1rJFDSVD7Wnw/vbL7KOx5OMQVqPIp2Z1yEDzAH0CURYFtgXosNT5CrkWk/K86ZhxVx1EsJun33azfsfeYKQMEV+L0UUlEaMGYywZ5myAJijZFeHx0i0a7uxWM8C7kDFQGwoYRPRYPZEaiGkUHKu1lfu/BqvgiVei3ev3iwd/TnZ+zieUJkGjNWh81KaOqZcLCXii6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L06j6rP64VR3bQPAfjIeTK+Jxp5kfOQbUD/PncEaYRI=;
 b=vkfCYYwZa/y1ppFC0HNXBtcq9CY120LZAvS9MHvUqymayU75M3YmEKUSk7f/E/HjGgryuYCt0WceUvi60z83gaFwO8FZ2NchAGsMltw8f6TPa8b6XZj+mjyOY9nJd4/snRJ44Jmi8RZUMawRWIh8tBUAAoKV0rkNSiJbWzfIVvI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:05 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:05 +0000
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
Subject: [PATCH 29/94] mm/mmap: Change find_vma() to use the maple tree
Thread-Topic: [PATCH 29/94] mm/mmap: Change find_vma() to use the maple tree
Thread-Index: AQHXPEQzL9yMZm5bA0iNsNMj/1H8hg==
Date:   Wed, 28 Apr 2021 15:36:04 +0000
Message-ID: <20210428153542.2814175-30-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 42fa3815-5052-42fa-f1a0-08d90a5b5607
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769D660E6CC43738ED97845FD409@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2fTReIPowgE63tkVzAQNb/dYeIfGXOownAWBD6GvZSRlXckL8fd/MC/biK6fFmEfBJkVSZt5UReMo097zk2esLTIG00aw8IAwjhb6N3nreH28tDN+797VgBiFX7H7mr+cstpM382gw+A4lJa1k7q/KJsm7rN1eRLSOV/a4fShKK5/v4U2tIKQRulGWAxcsG9PH5gddYsD+HdcYJR7tPcAAmYGHT1j927qoj95ZiFszWd+3BhpxDsFuMtRB7EVyfg4KvH68Ewgd4d/ssgwcWqsNfOn7UQGnEhnIuhztjfoPgEtfrlkSDR3lnCelBn185Y4ovrWVuVSym2kj5/3wdaXn3UUa8ZrlaO/yq1x2VPlIVuP6Ah+WRMyrzRRgc1N6X6/0Vw+Ivzo31QP3ToUQaqcC0GphoCYzdCGDhhdBLK0Mp7vS7O64WN/mKf1+IGRTDffnjhbdqh3vpUs0uC4QH62HqQ23W6HD8+1TNWTgw8JzXKyjptwBqFGi690qfnnI+HRDhxl/xWi+7xhEo/d84sjjfw5/ycbSn6yuqyn4YnCxMI9oTL3QzN5zgH+qxvMcDEwsC/s23qmeHK47Tyh7Be96DEA1ukxpxCPF7uiN5V2c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(86362001)(2906002)(110136005)(83380400001)(66946007)(38100700002)(66446008)(66476007)(54906003)(8936002)(2616005)(8676002)(66556008)(76116006)(478600001)(36756003)(4326008)(44832011)(316002)(1076003)(107886003)(186003)(6512007)(7416002)(64756008)(91956017)(26005)(5660300002)(71200400001)(6486002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?WfwsmbamC4l8DT8GLo43HoXrcMcgU+TUkwLmXVsP3nza6Kz6blGdfAELG9?=
 =?iso-8859-1?Q?JjVF5a9jpS/jtNVg63ZWNr3jymLugziLr5C4YqptTsRkFokeUOfWW1yPeg?=
 =?iso-8859-1?Q?URzVOx74v8oaM1+OWri1wyh9pUEpYIBafJ/x1yiQhmrK/eY667rRhdsKtt?=
 =?iso-8859-1?Q?69B2KgrFAdXYZ4XJhVbEmyqSLA6FDEMnzyDOZ4MUp4R8DffcP0xR9f/mAN?=
 =?iso-8859-1?Q?qrSlYqck68SfM+5ei/oZo01ehj0IG+8+W1M2ubLGHUwpVuF1RYPKTCpHBM?=
 =?iso-8859-1?Q?lbLWTPWb4Eb2qtuxCIvTp5uJZYpmq3kJmsBh0Onj88I7XqJItjoik78ojx?=
 =?iso-8859-1?Q?koVdsFJUNB9klv22x4SqaBizCVSM8GNaDStwB9jOU33c8MdqsFy31uQ1CJ?=
 =?iso-8859-1?Q?UmUZT+BSO9w+DKZNwD67EozTs1AJmQUNWH+7+jK/CI4IBYCZyrS5JC1Z2F?=
 =?iso-8859-1?Q?oPt/E75c2JmyqBT37C6O8ZWssTBGNbdxWWM48DiMDUiNSwA5Wl69AI6a5i?=
 =?iso-8859-1?Q?LK4hpZoy9W/QmFq7Kad/gpuB83HMb+0a/bnIl3DQ/aC1Ypuesx6dIV0eYc?=
 =?iso-8859-1?Q?15Q6m5hdyD38nd85RoQJaZukX59tiwlBYuMjTwK0UYN7aPAWT6RVo6iQgs?=
 =?iso-8859-1?Q?Cq9jHi1hd0Rj+cmR5yjWNkrgcTFo0XnQLvNXhTNL2U0CzKLnHUCznCYu0E?=
 =?iso-8859-1?Q?LbDqd1Db9+p1I84utZWsrs2GCcJwEYajHL5W8JqHpFxKiKG3Z3Zqtp4nwY?=
 =?iso-8859-1?Q?DMl9bzq3emHioSdqTBDtEEgXxOCzYWalVVyJs/3qee2Xi3lE9Pjh6lgsTp?=
 =?iso-8859-1?Q?4xr5x7pyhtiL22nL+d8kssel4wOztaYZ9kWiWIRY4C2HF3xe1mnGutzsrf?=
 =?iso-8859-1?Q?UUGBlryqQly7B5cLJkWi6J8KWZ/gVteTKkXyMNXbSknTN4LhXVY+x3TJuV?=
 =?iso-8859-1?Q?z7897UuEzPjHnm60WBRaOl6AFV539/sVJtXq2U909ThHerYeYbBj/sY665?=
 =?iso-8859-1?Q?ynYZMi/Pez1Ef7IhwGYBG0KEF+WjmAInR1Ojv0DtN66LHnJPzmGZ/5CbdG?=
 =?iso-8859-1?Q?zpsVO1Y+5uYsZaoV+k0PUlO9ICHye2qUza56EsN1VV9Fl8pNTMKEtrURKe?=
 =?iso-8859-1?Q?6OO6Wa6/zxweuP4MGLfr69mPuycbwb1LikG3U4OB6hoz10PhvydWVWXeTO?=
 =?iso-8859-1?Q?UsGA9QYo1BHK63ObeB+w3MgkpY8eEcVETjuTClUqAPPFKHA+TpAxxW3n2M?=
 =?iso-8859-1?Q?Co3gA6r0LXw9i+GtAvGmZnMruJq+f+9/TbpWBkDKyEISA11JJYd1RxQmlo?=
 =?iso-8859-1?Q?fiYYccZEt9VUh31h1PoyBD4hNqvxYGlLERx3adVqQT6+VNW/JrRBbyEMT8?=
 =?iso-8859-1?Q?X6QEEsFGYn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fa3815-5052-42fa-f1a0-08d90a5b5607
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:04.3172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+SoPRaa4enkeXJ3zE6qidRyt5D5bQEqdzslpBoJSKEShrbO7OKMtmDmQLB0DvC12fdl5a+UsnWRv409Plniog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: s_GK-xeoQrzaetHTp3_lFzfCWh3SfSn6
X-Proofpoint-ORIG-GUID: s_GK-xeoQrzaetHTp3_lFzfCWh3SfSn6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start using the maple tree to find VMA entries in an mm_struct.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 112be171b662..3a9a9aee2f63 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2483,10 +2483,16 @@ get_unmapped_area(struct file *file, unsigned long =
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
 	/* Check the cache first. */
@@ -2494,24 +2500,10 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
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
