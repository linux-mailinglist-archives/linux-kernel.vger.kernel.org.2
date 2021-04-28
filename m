Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97AF36DC35
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbhD1PoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:44:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5156 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240495AbhD1Ph4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:56 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNedG010520;
        Wed, 28 Apr 2021 15:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZVjAVSL4BtI362jGZG4Plx15Oo4iEU/0TFJ7870WUws=;
 b=WkQIhw7fgm/O6vbImwI9qQ4GSls4KG3bqXyfEElTvcNSgiOZEWUV3sBkbh3RV2KdRMbE
 WT9M8qoMUcfAepilTnto8hQ2O6CJ2DMejQEeXXWDblTPh9dzqZ9mmAWnEyOnoP1nz66Y
 cZJEYCAiu/g3YUVFMaW9b3Ly+FCZibEo88dN3TlMDfQSi7DspdF9UmQRiwdTYz3hA+xE
 L3vIlumb7yswn9cXVrCmiw+YAqgryv7qIiV+VlhiWHzUr8SfmaajOoVNmfV+oywQiOrx
 nzanMELNJQqJ/b2qMQ5TGgbYW7zA2BbZmL/Cz5j5szeF5Fg2st5NEDzkwN8ex23X6TMa 6g== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:49 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAT1030176;
        Wed, 28 Apr 2021 15:36:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 384w3uuag3-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UknhrnNQ6dK6z89GyktwaS5GQViLeC2jeEA2DYr8QtkUvSfyodNrMMaWqq0tkKyRRAA0EtlXF50iysogdBXGjgS3pXXUwIRPPN1cUz0ML5lNcTy6sCF47LLZZOGnULhOdUuIKJ/cNvkLNMQpzyEKyMDjjA4IgcNcRjBpkRJy8cy8tTRoXFmu28yuEAj16Gzgtr5mpl+a//0d9fXtsc5zGjrFwxRUJYDoErhd8PzQ5ZolJ3WzPLf785E2jWb6Y8IaBLuw+M4yltlZ/1clXo77idluv45nZ+fRzTsvo2IUlJjX9mxtNMONXuDxK21EWIKkm0GLAE3vQ67DU4o538kGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVjAVSL4BtI362jGZG4Plx15Oo4iEU/0TFJ7870WUws=;
 b=FCf+NKGSoOfKRWvi7DLg6p5jal2hqTw6CPOSdHyVtS149ipf7zoAOzQS2U7IVS1rdIfUZu2YgpjzA3CPifZeokKH2IYgnQKIS54QeMW1YTaeUe87ejoPU+7dZzJcjS0GqbnF+iMyy/MC2hin02jzNaRvYExFP++GToIBI1n4Qg2zQBxoUnFIZesKHvPzr/TTxQT8f9hA/hi69LbHLLzVxHg2pNqycXh/iRr/S+26vUN2eqYH1SdmrA3LEvb504p2vQ4sBf/B3kI7ThtfH/Dye1tedhEDcEXssEXPRa3tqp0LKSoG8C2RwR0Rdj/UwTj8EEMCGnpLMJgHBhE5LLDpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVjAVSL4BtI362jGZG4Plx15Oo4iEU/0TFJ7870WUws=;
 b=HhOcEJBOJP7x/wyNaCrDfKxi5UVz5WuDQk2fZ24fBV2h6osE/mw6Fm+CX91iZ7rsavXUkzG+Fk66Kjp193qL9W3DR5Oq02rP80wmvdz7HZz3jIcw6XdR3It0pQ6tqGjb/dEn/gHc84jebXbyGv4+OTA4jz8uDbPkKrDM5HrEZ3M=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:46 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:46 +0000
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
Subject: [PATCH 55/94] arch/powerpc: Remove mmap linked list from
 mm/book3s32/tlb
Thread-Topic: [PATCH 55/94] arch/powerpc: Remove mmap linked list from
 mm/book3s32/tlb
Thread-Index: AQHXPEQ5yqMQ+4LCgk2H5dMsxH8uuQ==
Date:   Wed, 28 Apr 2021 15:36:15 +0000
Message-ID: <20210428153542.2814175-56-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 08d10088-6c66-44ee-8d91-08d90a5b6eec
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB451597B994699F079E346936FD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/HzEoAoCuRPLdFHyvBjUIJfItQcNYulh1KskG0MUso0iIhYGRlh0PEvgaC1FARVg9rwCxgo7b3PNVV3uivaBj7jt1gNf0wGMmJ4eXfV6J6E3yS+33OM9VsYQP3YeZDncXwT9vyVjNYZ2xPajZtYYn/B0qT2j7tmi6k8bnDbGWb10oHC3+y71DB15IFOP6hATBvnYhLDBFjuBh14q6FH6OaATi+KWzw44L5sjLukU0XND9NtAtFJF3hbiDnMF4RWpnwlfTCMi9D9muMLemxAc7+8Q8aEXXfQsTbfxMNcyHJ0bLvWpW2ivSYOyU9HpI5a0e8mTaJHxlAjIS+YNdWa5f6eoe4E7ANfYR8zdUfHxwz7f6tTBZvH0+Awwk3nEYWByoYitbL4nXKCiOsJfW6Oi7PBbsZyhot3bxF0ru9BnWx0z78YZUEznlMc5+G86QAlJ4JVeLUhTq64m/M4bxzrqosfLxIglJ3xvCh8xSLPXQF8H8axybs7TRNzyIdzgd0PluPKMwzHmC/7oA7MgPLPtQf4/EcLmWPKXi2wAFjPurA5lk9rNpf218W7SsESIEEggQH2QNaRazv4nyjDV5ddPjnZkdvOsfUtKN8njfotvV8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(6666004)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(4744005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Ms2H6/vgp3jRWmxaYsKPpP59Zy0KqMrcKmFbHrjVw1f4XlS3Pildo/nLBb?=
 =?iso-8859-1?Q?MqIe1mO7GBRJX4nTdRDZRri9pPxdZhghS/knVP2y7vZFyqpdkP0AIoi5X9?=
 =?iso-8859-1?Q?E8yRcovKtvVKHUbRnFg1XtIcYh6Hk9pvPglAe1Nj0svA10UxNCszyDbl0H?=
 =?iso-8859-1?Q?8Mq1rkg1W7EywNEHmxcUbc1a2rXHnnSqV+1qQgNKu6t0I5qmFWoqjgrPK8?=
 =?iso-8859-1?Q?mKP2EZKImDOKoSY2j/Igo7fEQJJpnmptMIJ6C7NaAGIwGvvY8qSyn6Q7sZ?=
 =?iso-8859-1?Q?2hy02IAkKQFzZIPgC1LZkF8wscWyZxtxDpLMElcMcVpGVlOazIEcDgQibR?=
 =?iso-8859-1?Q?pJ0E7qDgK0XmjQLxwg1UVHAuPThUg791ovT/qn5GrL6aHsAql4Z3cQCOGj?=
 =?iso-8859-1?Q?ljnJneuXsSlIW1BKlvUh8azxQCoJo1flfAuhUN6jaAAR7qqhEERG0SidBD?=
 =?iso-8859-1?Q?fLs8A/lz4eT49rnu5U5PYXvn1TKSnzdJNYfmsyAoyGw2yNtg1SQEhBi6E7?=
 =?iso-8859-1?Q?Gr0awrTx3e8D0zRp0uGigHgCv5Kc1PlWdJxxTHDaapMJ4uEghmfQ1x68w4?=
 =?iso-8859-1?Q?pBHpO188ZXgsSK/voq5JPltoviBwJP58LR59wYxiD7gnO3AbvcORhueqjC?=
 =?iso-8859-1?Q?6EqocjN4DWBIQpPUg0q9nJ+cdSoTHkWUbonOoYhCCv79Kj9bBtPwMs4yRD?=
 =?iso-8859-1?Q?EhGXqX1kJ6378ZsyNLA/uH3VmFNSe+OOijVbMyJovl+mAwEe2mtlxAS2xM?=
 =?iso-8859-1?Q?0JImRWHpUalOukcwfUzccbWUAUDBSRz064XBAG2N07jOP5O3qP/NVnUwhr?=
 =?iso-8859-1?Q?KaerTLv4dxOv74k3MjTe2QTZZIjxlTzH2RWEwnkCU8jrBjC/0S9VXXTHoF?=
 =?iso-8859-1?Q?UTDELy7u3O7A/3IxhHavVMlj+eaKlsB+mr4c62HUiGvbNB1Z7/UO/YwCPM?=
 =?iso-8859-1?Q?HXlcIvRu7Uui1gBMMiGVDEQSt3UL2Uumb8jvy2/TSFcIKH6kc5fzpYO9ME?=
 =?iso-8859-1?Q?hgQDMsIZ+6hxGWutxe+vhpVO3gd33L6DMEoBBQHvT48ObeSlZ6/p67dOJO?=
 =?iso-8859-1?Q?Cqf/QSMfy/qj693SxEnUvkYTnxUQ7hFtGnQIauoJGIgM5f3OQLU+JBwg6J?=
 =?iso-8859-1?Q?hWhTeNLfes1Bw6pMmY7CAeZAlh218Vv29LZ1PcTUYjUgzCiAsXvH/EzLtH?=
 =?iso-8859-1?Q?J8njABdBY9IeqVqwBCOTirWg9Kl2k/ngasDVzoYDZTE+7aUJssWbvJw8M4?=
 =?iso-8859-1?Q?pCFAxz74lQ/rgQwnbK0s5LiQgQCavgribJCcCkXOWoZbGraTxXSlKpN1/O?=
 =?iso-8859-1?Q?q7xGBEQ6c5N0PQ2rWZ7ZIdhKXakVCbVd7H8q8l6nauvqPc6obXHip6byB8?=
 =?iso-8859-1?Q?oIniLtk6D4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d10088-6c66-44ee-8d91-08d90a5b6eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:15.8861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zi/742poVvi9mlSkgo1okqCrKew+UmiAjahYrJ9xiRB+zbRgdOi3IZeOppu12UkItYDOMrLFj+7nRSHjJmo0ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: D05VuALdkC-t9liLT0eFNenplfB0RTU2
X-Proofpoint-ORIG-GUID: D05VuALdkC-t9liLT0eFNenplfB0RTU2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
