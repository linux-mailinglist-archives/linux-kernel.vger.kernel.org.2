Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49C63EEFB8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbhHQPzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29956 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240333AbhHQPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:03 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkHqQ018099;
        Tue, 17 Aug 2021 15:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=++gcCdGM8uVYpNf+4XchV9rALNJhncj8MsZUY6bEUY4=;
 b=VoOcjUt6w1enOwsZaJM8a3T6NfSmYw1Vjqx3smJBTFOucGGtLSQwQ5WPJbDAr71xj/S8
 MCu/CVfF1NxGsPCBDLCWAY+axEMs8bYKGSAKogN4ReuQ7Vl5ekdtDeL8hEI6PsB4r6zL
 lf5Eno0sfsKjol1qZBBObj3x2l75ZLMgsYy4m25YG7NjewJODn+eUXogRMUEi56QjoPg
 9e9CYLlQ9B+X+oca1X5/WZjfSgo2BSt3YWdzJPA9nqUGVQrXu8f7rc/tOAcmIGEUxjJo
 ugaPSnQpeWrZR6mM8FOmjQRSp3wasqnD1UynvfC0vxehRGOsBO0DKc9o3EXBwyyvv4lI gA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=++gcCdGM8uVYpNf+4XchV9rALNJhncj8MsZUY6bEUY4=;
 b=ppPRszhTlRN3up+WTff2oZ/3qFMmbybABSEAJCbdU1dwWypemaVaXRI4BKhNPqpt47N/
 k1rRjUjArdo4sdkNR8LPG46orUNdAW6GljhfQeW6fhM7gsiXiKoS/WVXf8paYmfInlVr
 Qrt+DzQnLjd/KeU3xTBA3e/rPk9SRwqzubaf9sjaV4mu0KtbySZZCW8lL+i4LMU3s/Bg
 cisQI0CoO+RA43u1ubSNK7Hxl2oaU0sjEvGjAzKGLn3aDOXJkN/+MzGg4c0mtjqK1oT+
 Omyfmhmh2NdKW2OSVqQXew+B7S6cGf1AcWQmuKg3CJZ3A0kq0OcuW7zjm+HMuHwCuL/R 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFktw6094432;
        Tue, 17 Aug 2021 15:48:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3ae3vfteax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZKsCeXVUxa97Wv2OFzIfHjKcojWxc2jHH0RApU0r1Qrze8mWe4en2+Jv/1pJUskPz4BXv6udq68ryDilepWi+k2w1FMwYGK/5exxM7YkVny3LY/s6LKIpQVml6XjS0/DiZXAJX88KztDFxE0hR3WvOLYo4A2t1xtsfxcyyqhfYIAG+QPHpJp1g85H1CAP+QuVJnveRSr0d2jYStHXGcF6KNsugMoelzbqpKWzR7FAivq1pKcxWlYiIBhN5IaxmpbmtGibyrjOotf9M1VBnLnuJx+rDEy7VMd/AvfP5umlbkv8WdoG6pxdt/tzn3n6DZpYZTdtRVuj5ujdQkMeetng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++gcCdGM8uVYpNf+4XchV9rALNJhncj8MsZUY6bEUY4=;
 b=Uhk3qnu4z73Rz1WMO9aAGlOnr1cypxXD2KUz34cGZ+pf7cpmvWBiPqQUKKvXT9l4uhoxEPVaWDOHpYsQMYvxiJkucAv4y5RXEmaPGLRpLxjMDvt9IfSCVVxz4U9hroS318Mbs+LMRDRuXlZruEC8oxjSwce+DQlsJ9AZ9dOSf+gJdqu0WM3VEc+q5ekHWJMF/4PFM7VunBXyKMS7DUt9fu6pg7PySa287JNDKfgkIPr8DWhaxlt7fzC3+ILmTgGHa3WgqMv3hNdxie1rqHKXoX3ctALb0FG7+QtXcjHFd7KFHy7zZE88I1cjlKwQJ3qf5piUnSZIvznZ0zx5X/FKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++gcCdGM8uVYpNf+4XchV9rALNJhncj8MsZUY6bEUY4=;
 b=rdsP0vkSFnyun+o19BWtVGiAgOdoQ2MD46md0Rse5c58j79wRvPUvLFHNx6O48mAMXdm97pNWcS/ZxB7InSKsi9k+mcC3MWW8T9c8qN/HVtYhhoNyQvpITpi2VCHyin0hfasyv1xDUkGPCrWfXQDjmZKo879mizyFbwcZVTlScg=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:52 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:52 +0000
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
Subject: [PATCH v2 30/61] arch/xtensa: Use maple tree iterators for unmapped
 area
Thread-Topic: [PATCH v2 30/61] arch/xtensa: Use maple tree iterators for
 unmapped area
Thread-Index: AQHXk38qWQKD7ns3skSY1UWWnaNhPw==
Date:   Tue, 17 Aug 2021 15:47:21 +0000
Message-ID: <20210817154651.1570984-31-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: eb98c071-bb4a-474c-c692-08d961965f82
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB423684DF1FEF0FB23CBEAFC4FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BWDgZPLhE5j/eGo08PKibm51IaL+OkeaMg1zxYLm0AHMcOjUtPtEyvgDLM1/fIiPz05gCkjxX8kAtryB9SqGrr9bkwGBcDAp5cKGQ5+N92E6OSTp6Nr7NT0/BiGAz+iwTJhBlku0NggR0o4YobtBDue+7h0Xg+Aji7kUdyhwmdLbd4xG0TqM9UfJSsElS/+x9gqykvRUuZ+Brdk2EEu9DtLCnEDjoVCXSTNfpYjiL5KfTxF89stik2UP1W6VPlDf0MZgxbLYre3eZDxRv0wj90fcqh6uNRZy+2sc7Mp+aQXfHZCl9oENcT6RxInGJgPoMHJQ33MpZc4bb9ASZ4GXBNhh5UWif5dVzWvw9Vl9RF+HJYRxD8fo33jBdVFa+YgKVl4hppKQoTE9omzqUzLtZDxNQj3P67ynq6nN9AMVhhhgEyeKAvhUORkzeV8prhvUSb9abrPbSrjGDemI4Rw5IdUmFj3eMHYzpd07kiN5yHWpfDFnD1iI+ZO99TL6lw3i23HYfXsN4WuCFsPxZMZl/ZiUE2GyNmID3pwGCH4bcRlHWYV0qB31fdAWGjnuXg5Vrdr9m2S5pOD/OX/hJYP/G4lUuJSiA3UjyKi4F2Bbgvns5R8egz6nf8HWsBsxCi0owJOGxYB4FsvmXrjwfXLIm3NSSRH8MJvdqxSkHh5MH2p30NQpiASM6tnbtBptjnMntb1uHAtlc7kzeDWk57ieaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(4744005)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6666004)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d76827CeHRQmDCWHtcIOSLTxd0pu7APEGMOru7pC69okvlDw+fTzHEIwVP?=
 =?iso-8859-1?Q?5sEjzOS01SIaOlVzv0Li2Vet/WWsMBR97ZR4mFlEXGePgdRgpraRFHPZef?=
 =?iso-8859-1?Q?nnzKItyE1JTSwMHHaRwIr2k1AkVwvfKHOmp+myLXDUj0AAws1MLWfb1DoA?=
 =?iso-8859-1?Q?5QpE3/XMfdL8f8WWaLeX3ynU1+aj6Jj+XDPexJcdHcUIatXgaZNbPpRRGv?=
 =?iso-8859-1?Q?U5987icMDV2clIT7Y7Pviqc5x7rE00w8vIuhGAgiY94bre37KORsrHGxLe?=
 =?iso-8859-1?Q?ahT9pSDdiGPI7GTI47yKE/pMVxY6TA5GJ1G9ZxoXAFyYMrvHsvnlVLWt02?=
 =?iso-8859-1?Q?aBTnUEgVBmhe4Zj7Xp8nfWQtR/UQ69gFoi1ZxVsoQVDq5fZa92PyczVg9t?=
 =?iso-8859-1?Q?oCDcYD5vMF3UaMQgZ7q8aE/Dah1RPahX0Egx1GuyCa8MZuyLoPnpRZJ8M0?=
 =?iso-8859-1?Q?U6WOwqU9S9rnFxAAIzdsEWtAw5SaMW5KM0cBMn27NlI14bsjWOf/+QW39o?=
 =?iso-8859-1?Q?9EpobZESg2xGPZA9J98Nx4qisENJr0ykl695Wv/za+bcjtVWA9nosUZTiE?=
 =?iso-8859-1?Q?+znC3oAGpZnm59BAqfwMbSYmB5lYsLSH/38GQ5fe6F9ZTm9//DPb7BJDZK?=
 =?iso-8859-1?Q?M2Xwu9IDftHTwnOG4aHtKyj/NBZzksAIAH7wk0OyPEv71sPaxFFfBYa8Hm?=
 =?iso-8859-1?Q?iqIb4eVAc2D+2rcOEE1o+CVc+b8wbRy9F6mEo5wgn2DLUkDwfwsCK4fy8s?=
 =?iso-8859-1?Q?8rvAZEJ+TQBj2xOZx3ULpTzeh3PUhf38JG0P2DRJbvZZQfc/69UU4f7BRt?=
 =?iso-8859-1?Q?9o3PyOKDDRH/HO0ba1WRy+4Hkm6FiwgI3TpJlUQWnr2Eyv5P6aqjK2kpow?=
 =?iso-8859-1?Q?lLPCg9i5KvqKHUunl1rrhAVHQY9EASPkEoIwqHOecpy/jEYYA6a9c9GtPz?=
 =?iso-8859-1?Q?u0/1cI+UJVz2B3WX7ilOwNRWrOMF1juLQ7caUwbj1MrExstpNdRnc4rtrM?=
 =?iso-8859-1?Q?yY+9eitadvsl+l/D8e47nlyeqRNvl2b21oUZl7CvyK+wuDAh2D/D3szAbz?=
 =?iso-8859-1?Q?SMLZ8E5+QKzRymBLdyB3fAVCGGfA+jP01nOmmUtFE0AoEVuoL2TO3nP+cq?=
 =?iso-8859-1?Q?rowoKGiDBd5hbSLcNmSqTi74+fjjwbQzKb57NZ2ERhFGNxB1rK1poY9ElH?=
 =?iso-8859-1?Q?mgQNvvuxJcE462icYiHzX3QVKnXcCWLqHAYbc4HOH6ipzMBkfelc5vwLjD?=
 =?iso-8859-1?Q?046EMYWxZqDNy9gMMh6+u97+YNNQx50fZhD9MUG7eJZjUr2Q5Px2mIebJz?=
 =?iso-8859-1?Q?HdswofU3ERVlvWG7X1KA3lCQIJeCSiiKJzgeWuBa4rvrPAwVYViOv07Rbb?=
 =?iso-8859-1?Q?yKBEQ3aeti?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb98c071-bb4a-474c-c692-08d961965f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:21.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ulWzpACcSOpBFMIRsiAC1TYyGz3JxawY+o7Ug4gtVyN6O23LCAbNrYeYYFi6tnJuGcNziSDslksBTPDb4xWJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: JwZA6U40wCJHCc8UIX3u-7rlRP8sztpW
X-Proofpoint-GUID: JwZA6U40wCJHCc8UIX3u-7rlRP8sztpW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/xtensa/kernel/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 201356faa7e6..118fe0ca7594 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,7 +80,8 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 	else
 		addr =3D PAGE_ALIGN(addr);
=20
-	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
+	/* Must hold mm_mt lock */
+	mas_for_each(&mas, vmm, ULONG_MAX) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
 		if (TASK_SIZE - len < addr)
 			return -ENOMEM;
--=20
2.30.2
