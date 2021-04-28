Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3436DC03
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbhD1Pk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:40:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50538 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240308AbhD1PiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:02 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNxMN009843;
        Wed, 28 Apr 2021 15:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fyb5hREfQIAc2RgkFIAo2K97u8aVjNLMFf79wOGPuNA=;
 b=sA867aSS98X2C6X3mL0hy6HAXKemQTdNucg57QAbiG4KNZwaXtaPzv67a1tAZEqIwH+Y
 5bbY+Du8iJ7zzip9UYGlI/++cUsrBcyIuv3zRPbl2eAYkvqeOFWWM/DtngCoFhVPhC9V
 sA8sYYsijUhX/2CWjeGDmGbryF3mk9X+G+2T4H8NBM48NxXcVQGE4iGTtwmrcQ/YHr1a
 tWePDVNCYVmBkgIR5o986d5est3N8QJUYpcbEciSVnVe7DiEl4xv5LI/UP2qvsmz9zKt
 /YuELluB8F9CI83jFtnLxulsa1+dtb8Bpl8swSkq8sPLPgyLoyNbGPxMSuS4AMGWWrHE 7g== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 387a2mr0v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:53 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAxA018431;
        Wed, 28 Apr 2021 15:36:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3874d2759n-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QChtD6aCS+1w7HsgtTlv517qFZ0PMMYuXi+lXHjJb0e1V+m91jumIAfHX526sCp7yV4ihlyT8pO1jeWJ7rnrf+uaz9zXNLlT/ntAwO8jh7x1+oSASt3mFeFfNV2VWBWNQkqfs5/Qf/s9kKUcqcTkflyB1jdu8jlGk+90uBspD6YZaY1n2wZuGE5AgSpyv7rlM8HlATg9OKE7BTerin7ZBTEESYTT4P5xMG9OgzA5KPmrxQpmEOLzqyIifYptenkHpBBhkLRQHP1Pj47iyCy3uMNkA2gMYrToVHgoicITYl6oM69Z8JVtpwNHdNEs2u5k631qLAYjlFecpYio/38VdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyb5hREfQIAc2RgkFIAo2K97u8aVjNLMFf79wOGPuNA=;
 b=BuXMjLoLKrxXjZaIGU912kbElz0o3xVt09VQC6cqFm9rn3SfM9PnrFtK6P3JDKijnuwM/cZ6gkGg6an7ynZlklalZaITYjR2NJJsGw8rnA8teZlm6Nj2E5sG9OyFI8+rBqXQB8AoEv1Nj8n5d2QHyO+U1SoJ1eyx6vdfv9bqD18+MBbqyne7CTai1nZ7loxdAMeKUYH4tfywmmCNopvkxVtmO2qt0M3i+9R87n0My+pnydnZ+pepnBzqvAWDJoLQRvGQRLDg/fmO3fAW5q4uk5LZ+Joxqzyd8+cXVp++f7snBh8zhxmMLdPgfjGcCO7+zpBr3BQjtiAljKZHmyeQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyb5hREfQIAc2RgkFIAo2K97u8aVjNLMFf79wOGPuNA=;
 b=SFlyX6pxUS1AuTWQa+SGKy2ZUCmWIv/FreTqiWBrS7uEnw32I+wu4piELKOiOJL0p33ebQq5bboBDHKJhPj2CUDoNcWtsDfXbLYQZo9iWXMSSPu3pH3wJxQkPxnI9Ep4sWlzPogQEEwupioTDlD6xyg8Mj+WAMsFg8N2jL4V5CM=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1743.namprd10.prod.outlook.com (2603:10b6:301:7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:36:47 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:47 +0000
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
Subject: [PATCH 57/94] arch/s390: Use maple tree iterators instead of linked
 list.
Thread-Topic: [PATCH 57/94] arch/s390: Use maple tree iterators instead of
 linked list.
Thread-Index: AQHXPEQ6KbN2mabTWkegOEXb92mk6g==
Date:   Wed, 28 Apr 2021 15:36:16 +0000
Message-ID: <20210428153542.2814175-58-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: d6917c2a-34f8-4f97-9584-08d90a5b6f76
x-ms-traffictypediagnostic: MWHPR10MB1743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB17437AED28B144161DCBEBDFFD409@MWHPR10MB1743.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kqKyrphdvLJ5GsRLH6Wjj2yh5IJDK25bp5UsZnro8GiaoAzndUZf7AZwY8EaP/2HPshOyL8tRe4othhErc8ledyVuKrg86xOtA+tx78nkD8xLjTAfcJXcj4o5F3pswcyramc9soUc7nJqjc/lc4V1To7szqEZQVANEHBxWvO4VLfFe6qohBZ7bxV2RecsA671rbmUbHMmWxecBP60BNkKiZGHL7AQ2UT0aQxbrl30Yh0wJ4UhbujGXpI+jt9ko9l0ULc/X/FGAzd4a2MoyGj0D9PUHxOVjc/nZXCqmDJkeKW6paIZagE2oNdwp5b3xvlFcavA8VyfkWvCDZFq6Uq6iQCdDm3R6oDm6Fs5Hycz00NsZGCLXr8pnJrU21RtqY0vpMHwf7QGh9kruR5IVJxvo/zloBgFwhy5CpPVARzpDdZSSfsnQVvT9TRnojL67LzSu4lxMNa9HjRuWAjLh2iErwGVSiZmh0mjp3MLyOfqSiTEHyLGLlRrB6V/MtXkfhwJV3wfSPTQ0LU17wLHZonCV5bZ0FHkH4sNlgtlN9E1vBV6uodflk385L8WtqEKcS2ymy0//++wxeb+2RTY+37xP1MEytspmHNrplZ6jfJ5Hg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(110136005)(91956017)(316002)(1076003)(64756008)(66946007)(76116006)(44832011)(5660300002)(66476007)(66446008)(8936002)(6486002)(8676002)(83380400001)(54906003)(2616005)(66556008)(2906002)(122000001)(38100700002)(6666004)(478600001)(36756003)(7416002)(86362001)(6506007)(26005)(4326008)(186003)(6512007)(71200400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?WapXG7hHuM37fGbsffMjYU0fzHDRdwxMGQFTvZuTGIxP7J4hOHpv39NTdZ?=
 =?iso-8859-1?Q?dXwssK/uoGkRvNpw7yNOeC6rP7pNehcDPICAme6XfutOKwqUJQ3sDX+sQe?=
 =?iso-8859-1?Q?TJH94ydfk3FJtaNxBAw5HGw+Ad3e+FApDaUG6GDC2vnLOOyvRiJlRIAzQR?=
 =?iso-8859-1?Q?VyWtEYaJCEOYzpo3jbF8WOKUJ2jYPA1J+M44zR7fcCxur0onA3X7PHignQ?=
 =?iso-8859-1?Q?6kvBwJhfW+CQ0ANkd7BAQT0FxR1fyiu17aMabVd9cJ+kq+nIrfAGqdkWiN?=
 =?iso-8859-1?Q?AJZ+QnOxvSczT96GHonop90jZksoQqdFohvONp0BTvbyRM4VX7XgkHiegg?=
 =?iso-8859-1?Q?S1iwuopvloEMFzeHjwooWXXSl8lKMKEfB3aPQOv1PPUpn86Z+ZOQIPMAqa?=
 =?iso-8859-1?Q?WyCUkyNND6SepcNYa7F9KFY/ZEVeYmkIj+Yd/mwv/ZBlG6rN01LEEQ3ENZ?=
 =?iso-8859-1?Q?uTQlBqVbtoNBP8lOBoasi2ZK7W4VQcNE3eaamrQ/v+Tu4HgZibK02P9fAu?=
 =?iso-8859-1?Q?sgD8JKgOdtin28c6uGsE63bG7JK7YOcxPcK/Fg8nrve4nuA+jjHWKa1eR3?=
 =?iso-8859-1?Q?FTQvsgRDiUxbaS2WV/uvAiyS6cmqtUMhga75UD+beXHdc+oSuAPLflVMTV?=
 =?iso-8859-1?Q?mFned4kISdB1cQqyaU/oJrcN2O9DoT7VFVW5Lf69ZuJ32QHkYbdRA/Xz6v?=
 =?iso-8859-1?Q?Yg+LtIpvifImW+Ap/TZKXcY7NwCASQeZZxlXvEsnBekwVOoXpmFjoQZJO9?=
 =?iso-8859-1?Q?/EHhjKuVWFN3YwKr1gXRMAxCz+uLrMZJ6DEp94DpxkWJUheWDdt+kjQu0p?=
 =?iso-8859-1?Q?vRdx3tS3VTGlGA4iCnJsF2ktROoCh+A5tmtiB8T1vpnhtPROgJ4TFbqHep?=
 =?iso-8859-1?Q?Szt/cttfmsVOApnGNiA2y7pO3QE5r1rtSuZ0Su/3v3HaTJDF7+4sAQEniX?=
 =?iso-8859-1?Q?uFcVxCmOITLxPm1DMk8wH9mErMITRdPBvo9yPs+Q3dOjXRR6WvpeEv/rys?=
 =?iso-8859-1?Q?mDEhhvisZp7dRRIPtJIHQpg1d2zeG4ZC3fPeLsX+AI+NOPkjIFhh9+nAF5?=
 =?iso-8859-1?Q?j1NgD1gAhToUTE+clb3nPF0ETprRQcvbI78tldzW2XMfGRH4vHRc4QkU5R?=
 =?iso-8859-1?Q?lghmMKAIR3XUmTVl3w+pqLJcit1lzHMlkmyCY2rKCUVnevTJAB2S4SOGHx?=
 =?iso-8859-1?Q?MMcbF+H/hQMdyvGLnq1k0KzRFAqicEMqdyt6YnAFougOCekRrdmxqb8qBy?=
 =?iso-8859-1?Q?pVZu3Re3kzkgjbvkpiJQvho0ur6an9/VjvW7MW2pQ5+9SatGOVI2JZ64dd?=
 =?iso-8859-1?Q?uKTxuZYNPKXnPjEkCT4jIwd01IvgDj5RDAnvNs27JHCrp3ry9k9VaFzv3g?=
 =?iso-8859-1?Q?zbCdjpZnnK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6917c2a-34f8-4f97-9584-08d90a5b6f76
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:16.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtuksegaZppirmmsmfD5qvp/bmsGsDd+WLaEW4/KyU7P223qK8ymT1GGvB7zapsYzZiDawuNseqsVmbp2B8XLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: AISJUSzO2lXpY4gJlcF8ZdYTVLOs5dS5
X-Proofpoint-GUID: AISJUSzO2lXpY4gJlcF8ZdYTVLOs5dS5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/s390/mm/gmap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 9bb2c7512cd5..77879744d652 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2502,8 +2502,10 @@ static const struct mm_walk_ops thp_split_walk_ops =
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
@@ -2571,8 +2573,10 @@ int gmap_mark_unmergeable(void)
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
