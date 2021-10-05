Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777E6421BF4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhJEBe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27044 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231166AbhJEBdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:38 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1950qIPc029448;
        Tue, 5 Oct 2021 01:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=75l1O0pEP2Xo7Dd+zOvHCyADspnFAZHpCcmxQLCYSTw=;
 b=Dfz6qDGYZaQJSx4h5RNCiSU5dLTDVfEyZ3NRm3I8WS2B2nRViAom9aWCMH2ks6fSmq79
 EwCL/xDZuHDKUWHLdh+5Rs+yf1I4vYJgENuXoj1LM2IMFtvX6cPcB7MB9XII97m+xowd
 eQ+3oDBBugszE11cPjQZPy6v7fhB5Afl1gFudW5de9mw4vR4Fz89nQhXz5dHK5XvK0Su
 T2jauWkOWkQVYoB0pEaClKOVl9FaljcpdeErFsnazB6Dd3IxcAUx1I8GUjDyTefzH4sP
 bNlX9WFkILIOpc96220ldecl6mjSbwCdY7AriGypgSFwNr8yxpr+QvnioYpIy3V3+QF9 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kkycq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3r056799;
        Tue, 5 Oct 2021 01:31:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNqglBBZlPxlOjyFohHJxmSCP2SmOWMGrJ1xqGObDmQmN9T1Fs7pgHx+cHdXKuXLelasf0HBw97IE4myXF2qtWVAG9gNcLxfZsDAyPaEppM+VYt0+yB89HI3ZyqTztuDTnHIl5Ah9NHquDwUrH3iRsEAxTmxC5RlD4/7MRZt5MPoSr0C33Tpk56sCTJddw7eVfEa1bqfVBmz7EGjZNlOq7MPjC7li7zRC9yFyQdBhd4ov6/CtyKMlf/CsUPTObaGg+SjjYWnLg8vgzDzKR6lefnQFDaXXu3FX9Lvug6wKOkHNxEl4iYgtnzg+68sITg75YOI/6ey4CvCSVJIoaS09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75l1O0pEP2Xo7Dd+zOvHCyADspnFAZHpCcmxQLCYSTw=;
 b=lclMJbKGAmvkOPTT9pDjCL9pZrpizuwnd/HqIKzU8PveETGcPyiZ+Rmjy5LwyGWguHqtsJgwHl3Ju9Irou42+MlpvcTSidTyfimWyXXhhnH9bX66foJ2wj8VF7mM40Rn6DfPrsuYpVF9f/vwFLCcUPW8By96I04AqM2iU6+ojdyvXyqgKqFvRTFI5aieZPGEo0NhMadiwG+SrwPdThINCqzgwH58PTVCTXcqDKlAK+j2J+ud9yrmMfNLRjApGteCND1a+3HY78Eb9cFpaHGyLtV4/3v9zoWG/BPBztNAWDTkyGt8yiRT8RUS55KGEbtQlrYk/QfpTZ967b4lVFuxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75l1O0pEP2Xo7Dd+zOvHCyADspnFAZHpCcmxQLCYSTw=;
 b=M8TK6O7qXAJTpPKQRNGqAjJJLLiMMUXOmq2CYQGjhW75kibcQSEIi+tugF4Zvg04C7MFIGA2hyVg0Hxcp2BeZIeg2gCGWXl4/v+kqvqbOlufWx6nbA0ANojO+bueO6mi024GVfSYX4cu6xlAiWcLPJKU5hp/g2LfRFFCmQkAHN8=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:22 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:22 +0000
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
Subject: [PATCH v3 40/66] ipc/shm: Stop using the vma linked list
Thread-Topic: [PATCH v3 40/66] ipc/shm: Stop using the vma linked list
Thread-Index: AQHXuYimguAjLZY9E0CMmWD4d9McKA==
Date:   Tue, 5 Oct 2021 01:30:59 +0000
Message-ID: <20211005012959.1110504-41-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 3d8bcaef-e351-4142-3e62-08d9879fd6ff
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044DA82CB0E221604FCE04BFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5S2ri9Mp/s25K2LhIWWp4BFeHDLy8A5G70LVObXIRDGbVQmyi0R+XG+ThDeKH7ZIGkVH8xyeQ83/lGMXxAcPbVXya5xkPunDFmIzaEWiTO7jIWi8Fe6M2nIi+osQsaKk4D0mXJaEm7+i1LdOXTfsOWmG4OF/KcpuBmE0bS02GEYSpMrMUkM8Ds8MvPojkJTSEnlBPCrb2bFEZUgxNRNpW/iTCVslyDfJc/eHxN4F97trtJjhhj7cK4OWrkq78bLOGpG1BleGN0BNI8wZzTsH0pmPWF+WNEQ/i2tnPRK8JTUU82vOeYnzbeY4RQwYcvp0F8PbPyDxpgTGmMqh24nODw8Cd2vb8egRFrV/kwjw0+fWl4xTR83Mw6Gl++IDEZ7LwbcYkVX4qhyvSscx7oGqeFMPh55AI0sYckF7wNY5L2RCS+0+F6/CXWRs/OYPKM7xUfGtqM82OgFuLX5GsVPUrT24Xe8vqxAFWmuOSP1By1LVX0bynPh2iBeRsYCyrIz1MlznqtaQPbptQteWm+hSJnA4/xCZSc3GqCtWJWtRAKtGQ/H0ZIzcNAxzUIBYTqgasRPNjYi5TtyC0f1mwzlxyIVwUVO/LyRL9BXMimpD+qlTpyhPKDOzQMYdrHKHDE3wO15jb1XB+r1NsEoOC6JQoEgcoFlfbBWy328mLLuRc29zTQId90TKd52Z0726rDx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wn5+xIjhWL9QpQB8qtIUiEfxmY4Lfdw7HV8n3bMG9/8IZKgJJMkcAAlRXY?=
 =?iso-8859-1?Q?G26cyaJs/KL9ODQFK38FxqxEfKZYZbOuo4sH/cDkKAYLYUx9MjSRPxKnGX?=
 =?iso-8859-1?Q?w2Im4EKe83fZ78z4ql+R5P74IwvxPKTKb7tuoIejFF4bh2Xm/cOiMriqlM?=
 =?iso-8859-1?Q?5/AiuDZabl5RMmOo5KNdA8x1R5bF9s2R9xjUTSCr+VkND8LWSIcukCPnuf?=
 =?iso-8859-1?Q?K6YTwxeJfslQ9U3DDF+ks+2VsFNcSsk1Mpl4o1mlmXgsEf/6GpUg+FaLTS?=
 =?iso-8859-1?Q?H6tALGuiaGm+od9r2x3MczVXsm2wtfqXfvAfdXqjO+K49X8k9Upvd9Ho/B?=
 =?iso-8859-1?Q?kQM0PF46+CoLERv9pmz3vWJS9T1pMRgg0VYZNKJXrtqi2ZbbkQZNd6QaVe?=
 =?iso-8859-1?Q?2lpvcMl7ZMDdYaYW1U1m+80J4mi0pyrDfpDl94fE09CyQTnUjNXkuM3Am2?=
 =?iso-8859-1?Q?Gp7S1XUrb9YFOrSjtXfhUN/gzEap3b/WEspuiKv3U1+tY3lam62hxAcQdz?=
 =?iso-8859-1?Q?1g42pDGT9PyyZ9kyVMcED3Cw0mZliGcPtyajoGhfIjNo09ErY8hBt/7zGw?=
 =?iso-8859-1?Q?zKLoLnvtaFmFbzhjqiPpABdWnRG/v6FieRfnzRYXtBKJsLZ/I2pIlT1hZu?=
 =?iso-8859-1?Q?E+djq3p/3kMk9R23JpO3tK8PS1bSFNR8vFpYm6y7NGKVqObBdl9za/1mI0?=
 =?iso-8859-1?Q?zvckkgFQAWv9s+SyFAlC4Qn01ht87vqwsWseKBpkGEwem+QsrfFEoi7M+s?=
 =?iso-8859-1?Q?K59icDufIosfcGqByMCfo7eV1/JFvQ4k6Ixn4MXhZnLrGDw/tnxrvK/J41?=
 =?iso-8859-1?Q?nVRAs2thqJ4fvbwAVP8eDgqHsM6EoP++xer/nsse2ZsrSvR3AKCfSgARNw?=
 =?iso-8859-1?Q?JcjMXhB1Sxn6XTHNmroaiSqmIiYjNY3wNs/JRRs+2ZvfQQUltd5czuzQze?=
 =?iso-8859-1?Q?UzXV1zG/E+Jy2V3LtZ7Sb1vMgOW/R5H/EHvbKocYYbIXXFpNBrSziHi28o?=
 =?iso-8859-1?Q?srkob0NBg44kqcalCzvBeJVx/tLIivlLpUaAZMjaQEIRKWAM/MRq3aQRFh?=
 =?iso-8859-1?Q?dRUTf0gnIyozugFxUHboCsFQyb4aIFcdvqHNCL5Q+Wg5upHfYgwWJU+VVo?=
 =?iso-8859-1?Q?aNFbLcFBaKAk3kOUHaEZ7rl18s63NkZSybgO8k6C//F7Ie7xxN0oS5y0Jc?=
 =?iso-8859-1?Q?1gbqtHVdlLMGiGUNbDAV+vMP0QY7kc4gXyjrycOdBeZ0VCMWHYKsHJV408?=
 =?iso-8859-1?Q?Z83ApSDAy/GGRYKWCm9tXEcpm3DgczJ/1eq71Zmnz0ktbMuuygMYTQYh2M?=
 =?iso-8859-1?Q?xLDoleBckEl6UnJRGNFYlr79dmwpukf7REQodgDpVA/iHaeodQTi5hUleE?=
 =?iso-8859-1?Q?3QuJg0ePKY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8bcaef-e351-4142-3e62-08d9879fd6ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:59.8187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xU/Qx5SQT3rxUJtmmBDucei+vWoZqq/aZ5zRp2Js4vdiNMB4pQVeAbrZLZ4RplKuIV378x3LfrB3FcvBLkd/Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: p84xfhHyHgr9Jvke0bmZYw9JnIgzkmUA
X-Proofpoint-ORIG-GUID: p84xfhHyHgr9Jvke0bmZYw9JnIgzkmUA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

When searching for a VMA, a maple state can be used instead of the linked l=
ist in
the mm_struct

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 ipc/shm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index ab749be6d8b7..ed6628679679 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1631,6 +1631,7 @@ long ksys_shmdt(char __user *shmaddr)
 	loff_t size =3D 0;
 	struct file *file;
 	struct vm_area_struct *next;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
 #endif
=20
 	if (addr & ~PAGE_MASK)
@@ -1660,11 +1661,11 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma =3D find_vma(mm, addr);
=20
 #ifdef CONFIG_MMU
+	vma =3D mas_find(&mas, ULONG_MAX);
 	while (vma) {
-		next =3D vma->vm_next;
+		next =3D mas_find(&mas, ULONG_MAX);
=20
 		/*
 		 * Check if the starting address would match, i.e. it's
@@ -1703,21 +1704,21 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size =3D PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <=3D size) {
-		next =3D vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
 		    (vma->vm_file =3D=3D file))
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma =3D next;
+
+		vma =3D mas_find(&mas, addr + size - 1);
 	}
=20
 #else	/* CONFIG_MMU */
+	vma =3D mas_walk(&mas);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
-	if (vma && vma->vm_start =3D=3D addr && vma->vm_ops =3D=3D &shm_vm_ops) {
+	if (vma && vma->vm_ops =3D=3D &shm_vm_ops) {
 		do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
 		retval =3D 0;
 	}
--=20
2.30.2
