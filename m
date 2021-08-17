Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9773B3EEFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbhHQPzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22448 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240303AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkqVM017407;
        Tue, 17 Aug 2021 15:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=38ADzQw+1BqiOT69SlKw4e/zE40Nn1cKCIIJWRU5ZjU=;
 b=L2S+0qWaXd2Hbub6BP0tm1z21LzcNrFJVLw0ehQ3XnoSyNbFw9LE+Ni6f6SUq9Igq1QU
 5e9Qh32PeCEVlzwjHonMCnfuRDIff9LL+FMQi3WKOGd5w6NS1ebaWdPwRKe8p1dJrkV9
 ASybyW1ajC3qbmpKwx+hvYq17WweA2aPebmaLBA87y0QXAIjZLZLCjkXU3qlu9Lj8yqO
 oc+irX8tB6Jx2nYvS7NfCo9nUa8/Ci80Bl4JopOskP8iPdu+2fAoMkJtTD7HLFue+vFl
 ucea01KLQJNvdbkdzbo2jxZqdGCFgQbqbrWorab+kYsqk/wORWmjn8xN7GZIiZHOMQyI /Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=38ADzQw+1BqiOT69SlKw4e/zE40Nn1cKCIIJWRU5ZjU=;
 b=E3USgawhEweiCXB3DU/qX4JWn1rcCB9ygAJT0j5dtcM7t7M29JKhVJ66mLsDlUtTyZM4
 E4F/J2bmPGcrLV35mYuu7r0HUJwS2g1z6sPPklJ1KGIlDV1SuYIof7/jet3B2tjXTB7F
 47leKy41sAG/9pS2u+g845wxa1p3VeeWFKJX1Yq5JkgiGpo8o8c5Ot2rNtXi7lUoAZQD
 flXDK8SzOUEK0+CJ14NQMyV4r0SgXyPri6fUjq7fUyASvhOrSHbvA9kyBNbrwar0KuF7
 bbfMwLoo46u2ym0aS/cgbmV1adaWhkxgnHoCPuR6KPcJhO21TiOy4n2Suscy32HKgBf1 ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf0g6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3OV174039;
        Tue, 17 Aug 2021 15:47:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2r9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApsBG/eRY+Yejz9jwyBx3es14qr6acSFaKd00T9aKYO9IU++dSzKGztVfqzTbGgRHX7xaLDXH72p+eLXt5z092IZBAcPY78SPnyux6A8PdIRQXgLgeS7HeyPlqSWvTjXjCzocSrn9trFpiHWIV4uV9r+i2qKvxaKC6n/GpVCf8i7ewDHDLjsp3PrYRrUCz+QMhiH5QmVRoHXb6mEc/sZjh0oShG6g47D+iO9IJp7CfigG3To2NJR+KPmPtFSYkd9vj6pIYImq47Eax2woyHV2InHQfQ/MijMgFgiwnoKcEwn3pVfjTB+5OvTAjXsmUD3g2sBTyeiuZt6KxceaUOJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38ADzQw+1BqiOT69SlKw4e/zE40Nn1cKCIIJWRU5ZjU=;
 b=i3yDT6x54Iuup1nKexaFmgLvkGsEZflhRvGKRDDvk0xPEcnFqT2BWo9In24X/yLYvUVs5Dj90YVhoY0/CclHSNFYmZ/lnkUdMYsQtvFAfOBn+gyYPR/c07N34GwVbBb4OK0x5JsZ09TqZmuLR/fyPEuoK9l8uiAYhMuSKtCd8jaTbLGQJEbfJxf9+/uE4E2A9Jfyatp5bbKyPV0SAp0pvzfW1gCLOjuioN3aop1ONqwXXgkoroeiyuGb4f8E56+LLqOI0zal9kM4LdIJ3JKtQXYcekDxxkiWpSsEryZOQ8ktyrTKTDzXs4SqBQepHQ2NvlBxWzmIwNEz7HABS138pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38ADzQw+1BqiOT69SlKw4e/zE40Nn1cKCIIJWRU5ZjU=;
 b=K5HwfHyMFeYqE6rMx/SjNRTPmDsRZgIWttlWVC63zC2E67e6VHNTKt+6zk96GACPliGrGHuW6isznwyP+NB+14o05rD7RpIL7YQscPqyHms2kJbiz/pth0wphBqf3Ln6saF9rK8bL2FVHzc5GN8qegamcGgBWfvdDA/AklWogMA=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:53 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:53 +0000
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
Subject: [PATCH v2 34/61] fs/coredump: Use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v2 34/61] fs/coredump: Use maple tree iterators in place
 of linked list
Thread-Index: AQHXk38rvOT9QIVrm0y+o6GXDU3fpg==
Date:   Tue, 17 Aug 2021 15:47:22 +0000
Message-ID: <20210817154651.1570984-35-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 20963f5b-9cef-4b6f-d82b-08d961965ff6
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB42361866ED45F7BBBB9129D2FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8z8UsNwpuj7iPchoVhCq19dYh7LX+qah1ThMVpcnJGyd7+Rs7OEEWuOC0UprHu/qRWRRP0NALenImoqP/GS3sPwFN16RXNLGzubbiYNjcv0/8lm7bIodgPAzgD9thpWlX3tnaQLTUOFVdpBqn3GHU/8klospkppSf5EMJ+bU03d9vLblrwZumL9POP0TgjrfLBI3e+mBIb22lCvkFPNsrXPnXaYSFwmutcAYumI6pLJvFE96R449K9hNNxDd/24uukNtr1G8qTJCrK0Q0hJ/mbWrYVwK78NIPf7/V+odNlZook/9o6/i8Eu/maVhQO0IukUXz3uCBeyCR+t+eHVmxaeAZF1+1eMnIYjuVB1NWBPO73pTglvYaroX2hcNhSmQ6lSi2gwjwkhOJK3A9EPiN1j8MmW7KSHQNRvzhiCD3Cca589F+Jib13zRVT9IEhiqH5PPiLmHmVjYjNMiV2i6WyyXrp0o/aKm4SYWltPRdsXGsYIc2R3aO5CUGMmK0fCWQBh1nCOwjZjBmGwJp5DRqB2J0n6sx22r9E8fiDIbEVUWoZSg7vGXbpfOXM7PEIge3siRl5L9bTj3ixfAcs8SfJl80LXda+0ZIfiL90xsvi7Kfrw/wu/y8pJDYFKhDw6/bKqHeSyydmPp4gHYxsFwrC03WktOZpBDQHLCO8TtrnLR0GQ1ATTQurMp/1aEzSReTrcNVYd4DsrJfnaUSBh6Hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6666004)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?t+XwHcuIfOqVb8PJbQAVFvjVuWCWQOnGirSWKJSJ0ZpW9p+IgyFVqLrJHI?=
 =?iso-8859-1?Q?i9aJ/PnetxKoq4KOOQnNT/kjnWqfhFMpL4kRCYWF7U6J7CqNPWKcbG+nzn?=
 =?iso-8859-1?Q?hzgz7sHDsccYIe9Wp2hk314BIxRlR4akF0Rh4qBi+55RJ+cOKSW52l8uQ1?=
 =?iso-8859-1?Q?ZMO1u8o180IsirweQ5HWB8sOemm0S2PU3VxhWd/D/d07ONJ3NA3ufhfVx7?=
 =?iso-8859-1?Q?2PukIjubYlFKVBwK/WMKO0TPM2QU9ikivo1WrI9imybeiA+bNtV92orUe8?=
 =?iso-8859-1?Q?qhFPIiG2Rm2jC8bM/qXLBgCUHbHXH0C+3rREMcLLvaNQsyEOMp3I2sypQm?=
 =?iso-8859-1?Q?K/0eW/sxD3B8XO6t/87kPwS7fwJyw7HXm1UBYpSaBj4rFx7coakwX4tAxv?=
 =?iso-8859-1?Q?oBcvGsgMlt3b0LiBmrEezMDDHQPuFLFolahni7edUPDZr8mNWoMKUINl3R?=
 =?iso-8859-1?Q?IlZW3ot570wLCaP/DoUVAf/VG8b0huJr5NKUB60EMUUcHACzvA010D/npG?=
 =?iso-8859-1?Q?fnizpNzm8/5DsnMVqTEU73buSjTvv6RasYcCN63gBbGpFH5Hky0m2TmMjC?=
 =?iso-8859-1?Q?NvoEeWlYRvKMVIodfrhn0QII2KYL7WDg7IOHnedXa8/boF5o5TcAMmyNGZ?=
 =?iso-8859-1?Q?nWQjGyIVqauho3dxcyY9cieIxBkfpO/PwkeAucyw9kpNBU1aGXeXHUDEtx?=
 =?iso-8859-1?Q?YJeifAGohS93/JGvxHrri8y0DPbuseGceC7BGoyXLGA7eChvVAPvmWfDfQ?=
 =?iso-8859-1?Q?kG/Jy+gqzCz5cR2JYqJ8q73WohNjPNo1KFxulQv1cutXPEFFK6KsRlmdbe?=
 =?iso-8859-1?Q?7b7m8Y/AKH7Mc7JnPqPRBbQdAh1DNe97QHzrmdouFJlx+eYfaVRfury2DM?=
 =?iso-8859-1?Q?MvTmQN4nsy9wePGzdjRxbpzKkYuhCAVNXFhI0aUTT6JjM8y2m2Ff5BjBUS?=
 =?iso-8859-1?Q?8MazJo/eFKEY3R0X2zsIGPRXH6qHfpecnDcb1nPJmeJJ/h9ZdidHgj77W6?=
 =?iso-8859-1?Q?eC3vaJbXJOaBHhB0fNkYBx8MG+SwljNn1J0TOqtNP5z567zxOPT5UO7Bee?=
 =?iso-8859-1?Q?yG3lwq017jro8RoEE7df3e2qcTX/WE6s/2RxJTQzn06ATt6dZbMtKKtumL?=
 =?iso-8859-1?Q?F9e3JT6rVffTcWNsLhWjkaRnIld8MewdwS5GXAccl7qR0r5UuyULfKZqRi?=
 =?iso-8859-1?Q?sUNh/VT6VacWMOTa9uICy2LA0iGDIKPKAvo+KLkxvxkQnGEQtgCVqkP0qM?=
 =?iso-8859-1?Q?ly9kwJZsQS2cAEK2SZGGm6em8/aW+v1yM1u33J26KXgvVzG1NciuShYJwp?=
 =?iso-8859-1?Q?4PE6pxRylhCxrlleBujEKIx0kVpSW+Ru/CBemcA48OcDYpdM0M8jCiF8Iy?=
 =?iso-8859-1?Q?gILDLLu0bh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20963f5b-9cef-4b6f-d82b-08d961965ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:22.7812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDm86Pl1ZAxPt25+oDDeYU57nyEMeab+FAJW21Q3Ib+Z46mXYaodIcRbpWt5QH2o3d4udLPo0tVEnge9j7y/Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: 8QmC_YZ_hzdGrDg6VhXp1MBPt3azgQPB
X-Proofpoint-ORIG-GUID: 8QmC_YZ_hzdGrDg6VhXp1MBPt3azgQPB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/coredump.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 4b3c75732c97..584a9742aa27 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1063,10 +1063,10 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
 	return vma->vm_end - vma->vm_start;
 }
=20
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
+static struct vm_area_struct *first_vma(struct mm_struct *mm,
 					struct vm_area_struct *gate_vma)
 {
-	struct vm_area_struct *ret =3D tsk->mm->mmap;
+	struct vm_area_struct *ret =3D find_vma(mm, 0);
=20
 	if (ret)
 		return ret;
@@ -1077,12 +1077,13 @@ static struct vm_area_struct *first_vma(struct task=
_struct *tsk,
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+static struct vm_area_struct *next_vma(struct mm_struct *mm,
+				       struct vm_area_struct *this_vma,
 				       struct vm_area_struct *gate_vma)
 {
 	struct vm_area_struct *ret;
=20
-	ret =3D this_vma->vm_next;
+	ret =3D vma_next(mm, this_vma);
 	if (ret)
 		return ret;
 	if (this_vma =3D=3D gate_vma)
@@ -1120,8 +1121,8 @@ int dump_vma_snapshot(struct coredump_params *cprm, i=
nt *vma_count,
 		return -ENOMEM;
 	}
=20
-	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;
-			vma =3D next_vma(vma, gate_vma), i++) {
+	for (i =3D 0, vma =3D first_vma(mm, gate_vma); vma !=3D NULL;
+			vma =3D next_vma(mm, vma, gate_vma), i++) {
 		struct core_vma_metadata *m =3D (*vma_meta) + i;
=20
 		m->start =3D vma->vm_start;
--=20
2.30.2
