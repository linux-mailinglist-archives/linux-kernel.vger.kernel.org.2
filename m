Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183EA36DBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbhD1PjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13252 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240236AbhD1PhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:09 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFM7Fj009825;
        Wed, 28 Apr 2021 15:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CFba9kLYW2h6IO187knyCHLJzPGJVUCAoTGaHvrBGmU=;
 b=hN0/cyWkkxkPK4U3Kl7hNPY/iNgeuVnnFMEzwzkuRL5xgs0BO/fZXOTPtgrYMWDtiQM9
 9nnHJID3U6rCvnXLQffFxuPZgHAo3QMPniNtLvd4Q5LOfmqb7Q8hnoo3BSuLavzQGCRq
 JCq1cp1GS3E7A6qdzNKgYwTA/WyIwNZ2ezHfDKaEfDjq0Z7ZS+EUtmKcecy20v90CQRL
 aVv7GfmSsVjza6rA0Lezicsh7/3Yig0iI3ZUrKS1lr1vve7OmNkann3VqX0KMkpABg9M
 r0vPQ9VKFY3OCPkG8H1qn0aHkn5j6vjqvVOTpueqd18ksJjOYoXGyouM90VkgoAfW2cn 5Q== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:08 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWRiu016446;
        Wed, 28 Apr 2021 15:36:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3020.oracle.com with ESMTP id 384w3uu9su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR04hXNu1ZGvtX1aJ8Q/e7zHV+EjKorhfwwTZ8NdNgASf1x675w5F49Nr6JNhwlwTCswb/8ilj33j41UCjo4aNMAoqc+wKluFkwE7iUCgArvgHJOJKoNHVNyj+RMy8SjkVmvhyHhuYmaQ2ZUw69wl8/M5ITPNCrEtZ7p1+XaRsfXgmAVNSgla0EFyXOnkrba5mW8u0ae90n1a2MyMtLfcLP3mA5/JeAl5QqWQh+pfTI7kLOR6fkrPhPB/PVcc3UAAWmcO1wJs/5IBbdidnKpJPyT3HTa6E01tAb+cx22tdHJNFzKRaAehw80AzIcF+QLqyvmBjOYOd7dxV40K9RUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFba9kLYW2h6IO187knyCHLJzPGJVUCAoTGaHvrBGmU=;
 b=JJzKip3fKvbgk6QxodZ49F5GfVXi4d4I4PKtQUvSGC21y75/SvWht7M7P626PpkrHlJyQxD0YgX7EtlkDJB5VCEZs9kJWRmqiCzhTlw8VMwFNE2un7QFi5rFN/zmXl1EzMB8pGkCCsbeVV4/CrRFoEvuVNDLp2Sz6uhJDo7fgSrhFJJ8rub0ZrGu/FcqOVhdjdHIsHPorRPuzbQGO2g1iLP4TVD6zD8f0SC74h90dnZ3u7Tf4TbmftPHPSY2O3MaHARrNA9CVB3Qwed8427y0t+tsrtE22IHwtwB1H8kQPUebZUIaQnml83lmbOClthsdw3V6Ys79vewD4CQaUCa+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFba9kLYW2h6IO187knyCHLJzPGJVUCAoTGaHvrBGmU=;
 b=wMZnLjL0DXuEpkwh7SM2oEHjSrSJwEbPndUbsMFRyY/zvJaYa9N7lL3m8DnxjzSQpQEaQxx+wr6lorUlH1Pv7tNtcH5N04YSu1ia7YlHdlKN+2SkydhvwjZj8gjjmpnM5jc+vwe4GcEhFe03jxZIqosrl8PsijVhqwPsUlTs/7A=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:04 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:04 +0000
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
Subject: [PATCH 28/94] mm/mmap: Introduce unlock_range() for code cleanup
Thread-Topic: [PATCH 28/94] mm/mmap: Introduce unlock_range() for code cleanup
Thread-Index: AQHXPEQyXaQ8zSclo0e9BgEBMd1PgQ==
Date:   Wed, 28 Apr 2021 15:36:03 +0000
Message-ID: <20210428153542.2814175-29-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 66e6f176-843d-43f3-713f-08d90a5b55d7
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769DFE97E8C3AD42248C4C3FD409@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PIRyPwsHrXn1qpIHCmw0bgqiB2emBoYbyr+7b51Jvj/q8rscmnCLUtZ+ix+1fiM89gjk0p+/YVeYrEGM9IjLCNOTAHNtiE9X3YevpOj3G9Venf8XwrfjpDGNqxnBqCDvZT6BhJcP3ILIWNv1/HJN3Ffa2o173ATQjKR0XQ3PYg1R+qdK7J/oxMGhl9mMMVNprwo2sPOFuB46Fxsesvj/gaq84futLUaAIBQzvkrNGobXsitzp7OimtebgOAt4kQXC3SZUObR1y1fJTFnPZD0VukkSbEVga+oT8YnmCgWc7tTB9IWMf4QS50tVGg9qK17HeVebTFNeTrDNr/WxlvXGWt9txSzcTgc2dfkPpo/Y0zMo1qMLdmE94es6NK4E45n/tYqNllIRnKrDTNp0Af5BmUKq7Kbf72jsPHWvz1OazH3GQ2x6AIqIZY3nYA5YYlf1gBxUr03z+Y2QI+6mYoVto2yPH9tzP4D1X/+RNEoA2Q0dMzvAnCvgqghalLKi8UbcgEHwCxM0pkqYH9XK+YDwuweVT3TpPHcMIPc7rVhumjSma4P6aiYtLIBivBk0S2pl3ZLdufn7+woHDuREn6sOq2BYrinSPOzzaGanxBa/l8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(86362001)(2906002)(110136005)(83380400001)(66946007)(38100700002)(66446008)(66476007)(54906003)(8936002)(2616005)(8676002)(66556008)(76116006)(478600001)(36756003)(4326008)(44832011)(316002)(1076003)(107886003)(186003)(6512007)(7416002)(64756008)(91956017)(26005)(5660300002)(71200400001)(6486002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?KFuDJchG/SctVIcARt47L46OQgkqYYtP1/DtJFtsyTx/SrqR4PaXkSY0Am?=
 =?iso-8859-1?Q?xlLJo5/QGMiNseC7son8Ki0HhyehEDW/q92LY+Nhiwci7IRbtd9i/aZGA1?=
 =?iso-8859-1?Q?K6KRsujBSQ2ftuy4s8kOJOF7alEY9t6lU9dUsDjl2vpiqApUqoERvBTLKn?=
 =?iso-8859-1?Q?wug+5Hey1wDtqKPmTUBj5TymcDV4br7TkEd2R5YH4EIi5sOi8MZbwKkIyt?=
 =?iso-8859-1?Q?3SXnmOnhLjxmZUB5ZlWRoIhBgBJnEQi9Uaep0wHR7rNWOVMpzpWsL1D/0n?=
 =?iso-8859-1?Q?k6SBn+RfJTzxqTmXvj1/rA03dPes9Gp7LS8/h440tpLcKUSTTJJW4YqM+y?=
 =?iso-8859-1?Q?lhc2lDLXfIqt+NQ1q1LlePyieSi5FomeALOxkULlPz6Z4fp5YzvPkYs+DQ?=
 =?iso-8859-1?Q?4Y82TOQT2154xwEyb89WNI2A5VAgzhY8LKm7f2dF40LfSyM/YceE4KZXeH?=
 =?iso-8859-1?Q?Lc5+vadFrxNUXEHMF75cSISqybHrH49DRpNk6nWgfzusbQkjrNMESQtja6?=
 =?iso-8859-1?Q?JJgxUgKhwnZ9neHoQZAiUmyEGWBIyBD4rPwhQbgp/z01sJjBraj1tt9wPL?=
 =?iso-8859-1?Q?vw14fuXDP6RkXX9n0G7Y/d/CktN79fMm18CiSl2HrDDxAZGkcji3hcu3+P?=
 =?iso-8859-1?Q?y2LSF0bU1USUDoYgaAGNwvPuKQXaxB7K46Y9bwLnqVhPWHviT5/rsgbjB8?=
 =?iso-8859-1?Q?66Y3gE/MdQFQAcy5jagSWwnFSkb8t5LwHGtzik1GMQ6j3BfM8ifJY9FGsw?=
 =?iso-8859-1?Q?zSk19Ti7909692+eFDnQu20kjn6jgSoPYNBqnOLQchmaTk+8nGND4zhMKg?=
 =?iso-8859-1?Q?5ytk93ryZe7ora3qstlJqFOIX3WOMP3e7xGSMWk/6ygV2C/L3JwddFwzB0?=
 =?iso-8859-1?Q?wDDbGAOjWYwtTeVyqM3yf3gZHlchjrKgRrZUD6c8YXSluEWTkiPXLL//bh?=
 =?iso-8859-1?Q?qlXbygl30BrP4KEqN6MkMzKgRqgVKHb++nWiUgANc1PXk9dN6eTmGvTT0+?=
 =?iso-8859-1?Q?r5URsV3fZP1xwQ5Ajz615rlZL+FDKt4Xn6uS4WPx04iiqolh8MZ54SPS/w?=
 =?iso-8859-1?Q?4AE1bFZyod7Z4w4USonDjTlPTQpkXozPXPnlsjzcmC2Hyo7bUDwkCHgqjY?=
 =?iso-8859-1?Q?fAYFzH7UJ3KgXIae6DFTR89UUreoadLtLMP8asTtZQmhC21r/dp/kdQQD1?=
 =?iso-8859-1?Q?qTQzqeTIYgGl116pUiZXLAQ/6RWrwlvIFly9dULlDqQVBJQz9MUGgg/eJP?=
 =?iso-8859-1?Q?jeTIu6nL8HPmI2z3xjFSlgWenqyc8ht7m51KGl9A+cY29IvPlyNUk1uB1F?=
 =?iso-8859-1?Q?Yxhyf/cffd1xn0fDdCxazi3BQ9uY0Fa7CO0FUds+1QO7ojDMbjFWS5iSMk?=
 =?iso-8859-1?Q?xe5+o5e5Bx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e6f176-843d-43f3-713f-08d90a5b55d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:03.8934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpdiB6iL/rE73WwqnjjTyqgaOSzspl4c3vFDX7aLmz6Fqdo6xQxz8MhrraSBrhkrLAlfRf+mOSnidxWYcOsd9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: EgiI-pJx26HDgTlCQCYRQOieaNvHUAO8
X-Proofpoint-ORIG-GUID: EgiI-pJx26HDgTlCQCYRQOieaNvHUAO8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bce25db96fd1..112be171b662 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2992,6 +2992,20 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
+static inline void unlock_range(struct vm_area_struct *start, unsigned lon=
g limit)
+{
+	struct mm_struct *mm =3D start->vm_mm;
+	struct vm_area_struct *tmp =3D start;
+
+	while (tmp && tmp->vm_start < limit) {
+		if (tmp->vm_flags & VM_LOCKED) {
+			mm->locked_vm -=3D vma_pages(tmp);
+			munlock_vma_pages_all(tmp);
+		}
+
+		tmp =3D tmp->vm_next;
+	}
+}
 /* Munmap is split into 2 main parts -- this part which finds
  * what needs doing, and the areas themselves, which do the
  * work.  This now handles partial unmappings.
@@ -3080,17 +3094,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	/*
 	 * unlock any mlock()ed ranges before detaching vmas
 	 */
-	if (mm->locked_vm) {
-		struct vm_area_struct *tmp =3D vma;
-		while (tmp && tmp->vm_start < end) {
-			if (tmp->vm_flags & VM_LOCKED) {
-				mm->locked_vm -=3D vma_pages(tmp);
-				munlock_vma_pages_all(tmp);
-			}
-
-			tmp =3D tmp->vm_next;
-		}
-	}
+	if (mm->locked_vm)
+		unlock_range(vma, end);
=20
 	/* Detach vmas from rbtree */
 	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
@@ -3377,14 +3382,8 @@ void exit_mmap(struct mm_struct *mm)
 		mmap_write_unlock(mm);
 	}
=20
-	if (mm->locked_vm) {
-		vma =3D mm->mmap;
-		while (vma) {
-			if (vma->vm_flags & VM_LOCKED)
-				munlock_vma_pages_all(vma);
-			vma =3D vma->vm_next;
-		}
-	}
+	if (mm->locked_vm)
+		unlock_range(mm->mmap, ULONG_MAX);
=20
 	arch_exit_mmap(mm);
=20
--=20
2.30.2
