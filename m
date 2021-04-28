Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6836DC36
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbhD1PoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:44:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62990 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240526AbhD1Pis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:48 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMZPd020193;
        Wed, 28 Apr 2021 15:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4eBr748Dejqvq3siC5tt4zvWpxgBmkBnta4V95SUFSA=;
 b=yYg7kemK00ndMNWwNsrJIagemit9Ca3+yZUIb2G/4GPEBeyIVmID/LNTv7AVPkzp4diZ
 LhS3yQMURJ+vHjwKv7sFXP8cuvMIK48etM+0eTgm2zV6tHrGU6BAclArHyfshNWu/NhY
 PkfYQ3XY5qqJi8Lb9dkgL7TSDVBReW+KYWt6TzsqBnVNuPdEXZpWEu6/t9iLwIsbzoXy
 VdUDcpXgsiou1ufJMTrWkeHbMQI+ETE8K3BruZq95i6ZAJ/MWgBA8/GTXjrcR5u73Lch
 +njEZhNASnehKYqZnGJJGWRVb8e7+DhwQl0/buf4qZg9oqtQ7I0Ejpoh0NpL4wIfm4lV +g== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg52y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:29 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbScq033031;
        Wed, 28 Apr 2021 15:37:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3020.oracle.com with ESMTP id 384b58qpxp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1h6JBK8kUwzB6te/CB8SzuA0ygd9nVs58/xi+Z6sg31P+c9+F8OzdgAXT+vG9z1b+68GhDCi+kLzBKY7LXKL+o1Is3/EQZ57im3njVzRKikGd3M12U3SVa8Pfj2sun6It/WM46rBY2gzij7QbafmTqej8iV25asesSqw4/9yOP92NLzvKR+VFqpMXv6jE1Kq2kzSzBIKPKGamh6GswFyLO8uI1t97r+dq0gFelYyr+T8mTKc+T+tVZsI+qgruvOmdDQFvhtocUV5Ii6dJ+IaCdPhdDfozPJud8YwbR99EU4HWOxnWhdTv8s36mlIN4Dr6m5ZHN6uu5DE8TPXU66eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eBr748Dejqvq3siC5tt4zvWpxgBmkBnta4V95SUFSA=;
 b=Lrr63CEv3p6SOfYgEscBWSW6lHY6DumYNuU8vsChW3mcYtg40Pz5xn+IvVR5eYaXN8vEwr1XIpER9lFh5Qzq1A+CaKm5ec6MyiNIsf+MypuBZ4u7Rs5xQ1xaeZp+mfQJagLaT0iq8k4a8F9gAqqJMZ+jf6ASbxfdlClJs4m+YlR/MR292EnHNk/F8W/mtNsW6lq6RKnC9N0Soj0hPdRHXhb1Su69TQ5hLANhnhyJd6Gq5OCAO28m+120SYwO/JNwjpVgXGJtXOEE+zRsAD616iobQxwR2NM7oBU1cTEE4Y7JXjTR1HkRUMIMb5oAHWYCs9lrZIgApaJjdKCNm/ydBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eBr748Dejqvq3siC5tt4zvWpxgBmkBnta4V95SUFSA=;
 b=BzmEmSLE6hztsKwleAUXziMFie/0NbxYFbHGlHGCm2GEc6iyRLTkIh23jIS2/RCuVvfEUxJxL7GiQRXJPsH/M/mQ0rJgagsEVrkyUjyaWAdkW0wN43XBFH+9rtEmqgF2o6doY2cJfVwD9tJIR0MpjhxnuiqIrRPKIElHgT9OXSU=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:37:24 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:24 +0000
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
Subject: [PATCH 76/94] mm/khugepaged: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH 76/94] mm/khugepaged: Use maple tree iterators instead of
 vma linked list
Thread-Index: AQHXPEQ/VsOlig9t4kuNbf2bOjDp0w==
Date:   Wed, 28 Apr 2021 15:36:24 +0000
Message-ID: <20210428153542.2814175-77-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 866407d7-71fd-48af-849f-08d90a5b8583
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4548699966014DF467010C9FFD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jVIXPGp+i3Tt37UxSN36H4QTpfD5Fc5YE5XVJsc5feRkaJFOi3YTaUB8bk4p/bY1ogVforAU/uyzARm6JLiIkwn/eV1k0AEhbEvp8voecZKJV5P8AYE1NHChL88Roui8aerf4Nxe54sl6n5P/Oj3KJrCTfpBwr3KCYwSWVCP4jodktmzex4/r+GoBa7sEZUGSAzI7icDr2R00ui/NqLYEFNGhTG9JAz2/+wzrxWdZ7mZOWMW2czq7V6DUGxeQa0wwa3J9a7mhWy/WFELwN/XyXyXGdWCs0Im9gvXP6rg+GD5loDTc2gnAO6KzYpqJv0tI8jhRm/l2d9s1unGLweTq1gvkpuVEL47ZTXV5BSKNhiY/iriFK9O45eOMW+aVlU/JC53uT3Q0AJRM2z/KxGCMP9q2WUu5M23CYkef4JT79GoA8rL/ERTL+ehgfivV/yZtT19i6GSXQK3E0kDD53qUIDlm10L0+7aAr8m8nKRDl1MvIMgh1198pg1T+mf4fxQ20qRCSTVkzonH8TByqIV9hPQWAi0wI2cVBXbsN8Gjj3N0BXTZpv7YFFIbXpFYrlwUGD7K+KIFri+NtezUrnYZ412WQpyAS8b+ZgkkUVrKo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6486002)(71200400001)(5660300002)(316002)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?U1UQaAdh1EfTFjMhngccwjKkLsZWZI0VNUnn3pC/x50OrY1rj5F9WHnrFW?=
 =?iso-8859-1?Q?3NP59ya8L3Jl3SqjkusHuIAEA5Wr3bRRvbiRDnVBX68+1oDcwh1fRN8TaA?=
 =?iso-8859-1?Q?MbhXwLxhTggvapw2yyMVcog/QqlkN03fg8FZ/e7V1esNX0oPugZ95IAKHl?=
 =?iso-8859-1?Q?YyS5PnI/RyzSQFS1wgu0yG7c3wS9JzAR6PMkB77LJ6JAgk5g5s+gisQLIQ?=
 =?iso-8859-1?Q?2MJGoV+fWRlsiMpOwQhsgsVWR7sNM5RmFoGe93m8WqqaGExmLPyawpmcWC?=
 =?iso-8859-1?Q?E8Zq0bdgA3IEdwpIXJT/2bmddnYica2MVG9YUeSSFz7VzXNBsmlDj6qVsb?=
 =?iso-8859-1?Q?gSrEn58Dto13JB33h69WaSVddEk3VRzx6kBrIWR+mAPv2wIZ5VIA8w6oFQ?=
 =?iso-8859-1?Q?PTrwE8F39ml0Igms+ABE2tee/jRTWAtbVn9upKYmbobW8LofVsCO3WbYCj?=
 =?iso-8859-1?Q?b21jeSG2N0A6LgXIqHxF8YYJOXsUIFCOEhuwEs+5pi/ZOE26gvLyUnlgED?=
 =?iso-8859-1?Q?DsOEdkOezKGKAZz1IOoS4Pm08hqW08uM+Kph5h6vHFQf2d3xHvs3NQk7MN?=
 =?iso-8859-1?Q?iJkB6BQIaMxYtfMLlaruwEJ+qJUjYgtmZrJtgRKwrvavrohA7GfZqMXtz+?=
 =?iso-8859-1?Q?wpKa4jt+XnvuXB5csJ5Wlykjmd/7QIEsSwQbVePUnlDcbzqYv6o24W3EMw?=
 =?iso-8859-1?Q?cy8WHuD50o6rZ0InjSshue519rgrKnfit8TSNh7E42exrW6lO5op00+7mW?=
 =?iso-8859-1?Q?+SJ48ioup6GMcsL7bBUNtDR8QeS/icsWy8kPGgDrZS2BnHxGVRxdYhaFBx?=
 =?iso-8859-1?Q?vWIx9dSSZ0Ode5eyY3ipzVeWwB6AefEx3GjHmqCmgYRAM/nNum4RW5SLNp?=
 =?iso-8859-1?Q?/9WJ8PZhU7pHCZxj3ZgpxoB7YaFIyzjDYW84pD7qJ954lE7qww+Fi+rtA/?=
 =?iso-8859-1?Q?sse4mupUvrUNIYyM42wbuZGf5S+FETgbLpD0zfZ16RseZXry4ZFlqNhJja?=
 =?iso-8859-1?Q?3iO8t9sAAK8mAGaMO2Wvoj2wu6ppdKT0zFATOdMMpa0TRZUNJPyW7B4Av5?=
 =?iso-8859-1?Q?AVlaV6A2Ap5c0ywgtOMj7npaVLvKUYIc1wu0S9j/MYt8F6soGlggBD6dXK?=
 =?iso-8859-1?Q?d6j6c4usHgxpdcxDVHyBtiP1c7IUzIe/arw5FTuYHuQo1rwIyn/Efwk9AZ?=
 =?iso-8859-1?Q?L8347WQU2/XS9M2g26qQlF12oB/nPcPMXGwTOI6+01WbQ8gRhZqlndlC0n?=
 =?iso-8859-1?Q?zI5naLqj1i2OgMNYLZDwF3IXETr2+l8mlPpBKvj5q95/EqZMs3NjpYl4dh?=
 =?iso-8859-1?Q?hm3pE6hQv40RlvfMwGSiYYSbphNIeCW+LHDwn4IrLTjG6lUD3bEBW5Zd+A?=
 =?iso-8859-1?Q?hXlH5vTOMn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866407d7-71fd-48af-849f-08d90a5b8583
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:24.8581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8p3+t0o5/3lW2p4dLl2rlCvT8mZ6GFsU4fBkDvqjbeoKFhsrMOIvVjwgyuBlbV4nUXuWgx8gEeL1vsA0NRebw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: bXXS4M49IaGTGJtmAsWZGRMF2XMFqke3
X-Proofpoint-GUID: bXXS4M49IaGTGJtmAsWZGRMF2XMFqke3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/khugepaged.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 33cf91529f0b..4983a25c5a90 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2063,6 +2063,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned =
int pages,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int progress =3D 0;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	VM_BUG_ON(!pages);
 	lockdep_assert_held(&khugepaged_mm_lock);
@@ -2079,18 +2080,22 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	khugepaged_collapse_pte_mapped_thps(mm_slot);
=20
 	mm =3D mm_slot->mm;
+	mas.tree =3D &mm->mm_mt;
 	/*
 	 * Don't wait for semaphore (to avoid long wait times).  Just move to
 	 * the next mm on the list.
 	 */
 	vma =3D NULL;
+	mas_set(&mas, khugepaged_scan.address);
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
+
+	rcu_read_lock();
 	if (likely(!khugepaged_test_exit(mm)))
-		vma =3D find_vma(mm, khugepaged_scan.address);
+		vma =3D mas_find(&mas, ULONG_MAX);
=20
 	progress++;
-	for (; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long hstart, hend;
=20
 		cond_resched();
@@ -2129,6 +2134,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned =
int pages,
 				pgoff_t pgoff =3D linear_page_index(vma,
 						khugepaged_scan.address);
=20
+				rcu_read_unlock();
 				mmap_read_unlock(mm);
 				ret =3D 1;
 				khugepaged_scan_file(mm, file, pgoff, hpage);
@@ -2149,6 +2155,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned =
int pages,
 		}
 	}
 breakouterloop:
+	rcu_read_unlock();
 	mmap_read_unlock(mm); /* exit_mmap will destroy ptes after this */
 breakouterloop_mmap_lock:
=20
--=20
2.30.2
