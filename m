Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5910E36DC34
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbhD1PoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:44:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40482 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240461AbhD1Phy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:54 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKnmI030215;
        Wed, 28 Apr 2021 15:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2nEuSBqmnDCAcwv1Iha5wey/s+LmRfYmZ9IkT0E6jq8=;
 b=tMjPO7hLDOiU0FvA3/mzXhSIzyoWzliFGbfTrlcWybWiQY4yo5G3UPmSGdWOuHiMxIid
 G57WFTqrfaJ3g7Qd+MNt2a+U4DeH5ZT+QPRZd6ONnfZeFe1Pwgv9z1vXzLlie303P6OY
 x9NCUxjbIylwllePiyBPC8LJY2ZKGdlC7nUehLDjnxvxk4hM7kHWhrItPBiPNc6NNj66
 4dNidbDeWWJZ1f3Qa+eA+gXLEiG9DXcCtqhUyWvq36XUczCgR8ojTo2vbulzvi+DTZS1
 yaENK81weU+ilv5f+D32u/DcycAkBBamybwdZZEEhqOq98w5TxOMAODNcB/meKJxNOhl +A== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh62h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:49 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAT0030176;
        Wed, 28 Apr 2021 15:36:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 384w3uuag3-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUB1Y5orZP0JZl4Pncm2QqVqNgBLRnztS9OzrojxydCXuSLhy7vCNCB3YXhUU7enTDaK6OruEimwBRgZEOZEJJkXZ3PsASWuu6h8azdcpZZVuxLR0mJduD+VffNM1nWjGlYnuj2aAHkI76PCcUUEaC0R+MoWnq7UpFxqWSClUmDBoAgBGE4TKIdWTJxkW1Sf9KjQLfKOd0GrmsK5+0SSqugdaGffqi0KKgOLGAShOzQEvPIWz3eXJ7uflQjjKL3MBrrz0LPcivfSZ9VBgC6yV53Jk8BL+1FS5JSLbk7MmcZ7RA9W6oZLilCKetLeQzBdJJXfgIUUFRgvZYYd3noE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nEuSBqmnDCAcwv1Iha5wey/s+LmRfYmZ9IkT0E6jq8=;
 b=UJ8SsegrmRTM57m7HvBMYRWPFsY5dm0gkPqF/GjSXJzUz0RwnZFUZZqQ+6jjjuADtCya0aNYtsf7gWgZte6c7vcwywae726tby0hvE5T7YJ5ypMKuGKZQ2vLVGA6Ank9x8Ns/AvJ179lnnwfiD4EBWu2iv96+TIKzo+W2SE6Cs1Tg8Lg2znEGzJJxSkkGQmsrR3oqBm70wTj4E4KW6ll/QQT1vgZyflEofWw5D+8NJw3m6bOhA4VNXbbjGj5BEcRtdCjK+xxBIur0FU4+OdfLHZjwH76KJaw2RlvSCrlbKz8EDeuj5PBAlFvmV5UV9MA+OcAZnyr3XfcNqnn7e76mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nEuSBqmnDCAcwv1Iha5wey/s+LmRfYmZ9IkT0E6jq8=;
 b=A5dVX4JZojHlgUXhZMMA9XmpXKMT0wMhs2Ono+jMJ+QSb1fhm3jKoecSt+q/w25MBGGE2d0up/eltHAnlh+mbzRzlWpNP+mAgpKDvyYQIBLeLzuAcyBZhqeBKOPjGzYdJ4+MeBBt/HmQBmcDtmJcdN8LffMaykC6dwrjfvW+mDA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:43 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:43 +0000
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
Subject: [PATCH 49/94] mmap: Remove __do_munmap() in favour of do_mas_munmap()
Thread-Topic: [PATCH 49/94] mmap: Remove __do_munmap() in favour of
 do_mas_munmap()
Thread-Index: AQHXPEQ40mRUSQVK+k+oYRQpOW1U5g==
Date:   Wed, 28 Apr 2021 15:36:12 +0000
Message-ID: <20210428153542.2814175-50-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 4e740602-b553-4ff1-3a4c-08d90a5b6d2b
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB45150416B16D70181FECB57EFD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Q705wSb4t6ntVhUmWBlKznddFgsvZ+8yxHsqMj+hOIsi6YwamV/31uGIAep+BzSDHfg5xhWIatN9Vd3Cmd9Wtv6xltX4PTsmN3poneofBPaX8Mv5WxA8xX5AZ7J5XYVK+nW4ptzYk2X9h7uBNtcCUPQVIcYlTLj1dmrZD8J6bNnWhF31+v5yubvKrBhArrNC4yNXlDcQ4xfCk90eidvUFc18YQiSjvlHrSbm06iSV0PbFu7vnQmv2LG1wSCR37WNXr8pW3cl1Iv+RT4eVufKzOFmsb8KpajsOC6d3RyP5NpgnUJOSjn4XEjb6hYrYbLJuxmgF4h8VGNA0y3+f86pgmIi0VKiUrbrgAMMrQROFOGjDodiplRX2isyXsd/8M4zkxB+QggUSLYjkC6pVFMSPUZ7AawneYbuRGISfoLsIXhQlMIiGHdo9ACfbg9ahBpSLWZk948Q1TusUj2k/q8p1Z2pe77fRAJjsJSdCG8kmz+BOrbvazTnKnrVBNpk3XVzdmd5amP/mnxD+sz0TxC8ipGqnw/5p/zHAE8ubFnRebGod7bndjWTKQKzAW4fkcSNoNZqY8E20GXVkqVGDSmuWamuMm6UEUorkLzsYq0DHQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(6666004)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?jSXiB0bdJLn48dUauZzYa+9CrV8i2jUg9OWSjSSWXRQ8LDfcy2U2779mFr?=
 =?iso-8859-1?Q?5mIEjtzI00odZWxGWlEzxcBFQFPexL8e7lYD/OAtsvwOtPGgqFtyFT1wTA?=
 =?iso-8859-1?Q?cmvI/7u1Ezuypo2rQ+n65LIFGuJavtdurRFWCiMP0P2VsYHcTkckVlGJpq?=
 =?iso-8859-1?Q?asItAjc/8me58gPK06hTvWfq2jBK/E3RiYHpOB8f8ps+3hDy54RzRjBlYY?=
 =?iso-8859-1?Q?WmW7AaaXWV3Ct9eoLZTbZdB7JYpJ2HBtMIudnIX4WI2Aav3UKSBrZa8ujZ?=
 =?iso-8859-1?Q?KfYBRF9kK+faAhvca5i69uzdn0mNiedktM5kmO/bnDo0TBfxkO9GgS8EIn?=
 =?iso-8859-1?Q?koCI2Y7yMFKyW2CPjql4koreRkFR+BauUqwi3DEXSBhG0HNlbYtmuDhySx?=
 =?iso-8859-1?Q?YCsrcjk7Mdpsek8o9O+3r1dVQ0xUC4pNS2xuXlNTrVo5G4JbRqcXGZa0eA?=
 =?iso-8859-1?Q?sTbPLaBJHc5Aa3y7IlRz+EP95vljDvZ7/eXxpmLKLgUr+xtlgw//NizCGZ?=
 =?iso-8859-1?Q?SUA+g++01hYTkdbfTtZfgpp6+MlXdip66dwFHb2TxyVVAmcbFN7dkkQN1l?=
 =?iso-8859-1?Q?HU5KeHwHput/l/Ht0PxeKJEE0DAtaAr2grdk5kNmdGRMAQypwumvchQlKS?=
 =?iso-8859-1?Q?/Fa+T3P32D+2j+JnSNFsunu3p9Ak8uk49HG2D5Ob62gMsjMNI1VB0Pgmkk?=
 =?iso-8859-1?Q?l7VG21PDdCtkxuymI4tOilrT1sbLbDnFWjI4C7Se2w893qDIalklkLP0Dd?=
 =?iso-8859-1?Q?CzWjla3oFGlFxW9KOAfv0hIffKmuBFWhcy5+iH2ALPNgn5rNANrXvt7sLN?=
 =?iso-8859-1?Q?vbSfYSPpl/R83bFHQJRMXL4l2XjOZTztkVikScrKUo+wO2VUqWzbXcl8+m?=
 =?iso-8859-1?Q?s4sMacJibfNE1v8X65NnvkO0MjeDM6B/eEeejUA9CMTu5KuniGr3xEfi6c?=
 =?iso-8859-1?Q?KpAKKez9zHPdtpEsnmZ5shZdh3dN0bqDxXL2qUEReDajgk/vhvdk5pCM+p?=
 =?iso-8859-1?Q?CYISaFukXN9d9SIlPBgBDbcy2BYrD2QzNg0jfG7kb+ZS4IgLGJ9WoYO1j6?=
 =?iso-8859-1?Q?3o14crT81mmcrV9YAqDIp+5bbTpFuMvp21TXjtYei5ku+AB7SbUqb/QCoQ?=
 =?iso-8859-1?Q?2pqZ8ghGRmSNfWhY3MTqx20JUYZB5wzDJOoLzlwLjYA8wVFT2H2zQGv4qd?=
 =?iso-8859-1?Q?1Ly/A7Zi1oofJUk87On1/Bym2K5VJL5jDVN4+EYpISTEamOw8h6uSiQlKP?=
 =?iso-8859-1?Q?jb0HhRoydaM2/5vccSFPBqg2C4Spf4mqTxxd/fo/acc+HIqis69SBz1Aw/?=
 =?iso-8859-1?Q?36z6xVVV3DbPgn39ByOzJ/5uo2XD3aMrVFv70gsFXVdUIJ7rwDDlPOO9Hq?=
 =?iso-8859-1?Q?LlOccJDIna?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e740602-b553-4ff1-3a4c-08d90a5b6d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:13.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOt6UHTeozxVA9GigkdtOyzGxoWSXcZ0qmGm2i1vA89KqWhAK4YGx1CNLSGXNJAfZnY/9nk9ycYOyexuLDXWog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: 5-kZI3ThsnT987Z7yf-2kyMPdvy5nuI2
X-Proofpoint-ORIG-GUID: 5-kZI3ThsnT987Z7yf-2kyMPdvy5nuI2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export new interface and use it in place of old interface.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |  4 ++--
 mm/mmap.c          | 16 ++++------------
 mm/mremap.c        |  7 ++++---
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd8abaa433f9..cbc79a9fa911 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2604,8 +2604,8 @@ extern unsigned long mmap_region(struct file *file, u=
nsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
-		       struct list_head *uf, bool downgrade);
+extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+	 unsigned long start, size_t len, struct list_head *uf, bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t le=
n_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index 3e67fb5eac31..cf4aa715eb63 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2574,13 +2574,6 @@ int do_mas_munmap(struct ma_state *mas, struct mm_st=
ruct *mm,
 	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
 }
=20
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
-{
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	return do_mas_munmap(&mas, mm, start, len, uf, downgrade);
-}
-
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
  * @mm: The mm_struct
  * @start: The start address to munmap
@@ -2590,7 +2583,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	return __do_munmap(mm, start, len, uf, false);
+	MA_STATE(mas, &mm->mm_mt, start, start);
+	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2834,11 +2828,12 @@ static int __vm_munmap(unsigned long start, size_t =
len, bool downgrade)
 	int ret;
 	struct mm_struct *mm =3D current->mm;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D __do_munmap(mm, start, len, &uf, downgrade);
+	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2975,9 +2970,6 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	arch_unmap(mm, newbrk, oldbrk);
=20
 	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
-		mas_set(mas, newbrk);
-		if (vma->vm_start !=3D newbrk)
-			mas_reset(mas); // cause a re-walk for the first overlap.
 		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 		goto munmap_full_vma;
 	}
diff --git a/mm/mremap.c b/mm/mremap.c
index 04143755cd1e..d2dba8188be5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -881,14 +881,15 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * __do_munmap does all the needed commit accounting, and
+	 * do_mas_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >=3D new_len) {
 		int retval;
+		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
=20
-		retval =3D __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
+		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+				       old_len - new_len, &uf_unmap, true);
 		if (retval < 0 && old_len !=3D new_len) {
 			ret =3D retval;
 			goto out;
--=20
2.30.2
