Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4344936DBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbhD1Pk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:40:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58790 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240429AbhD1Phs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:48 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMZPY020193;
        Wed, 28 Apr 2021 15:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5qysJRVMnmqzUaP88+n5Ugl2Mz69g7FmfQGmIN8UNOI=;
 b=S1MpKw/qHOpHS3EnLhw58Usy/71VJIBuL9bHmtv6nSRWKpgY6X3etMWfLLIx+dOX3Geh
 4Z+TPIldzHWYApyQzUS+UY08D18dQBlQH6sbr9XWArg8cc9b96qjt3LlDkHpb7OoqGc0
 6GnJW6k0hlKNTs3zhhODVGEJT1VRGYeXnW9G2093HfvMesxmrK+EnIMDzXAzMeVHDRht
 DRxyfD1Jo143QwVVLviseoMZQpH1kRI4d6uGuLj8W4yuD2cf2a2hdL7W5mL3ONat+zUq
 Jsb0cRWU62R4kccPqs0HAKFrGQoywCODGYOnglrcDHZ/DqfHkBpj2B4XbCbZOd8V+w+m Fg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg52d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:46 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWJwN016127;
        Wed, 28 Apr 2021 15:36:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3020.oracle.com with ESMTP id 384w3uuaj4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwMpJgj/wWV70TYbrkx2Gn1o5RrSJXNE9JpXgoapllsd58AOmlBdtyQKp29ArNcXGKnxrjqre4edm0T3llA6bPP+9r4eKObh+7N8GdnBklwERm2f+ufkKa9u3O0K7O3THQ84FNjvf5BWjIxoiAIWyvCXhhfPJuJ8RwsvVBf7l+q71tn4N+6saeWCItRHnQ0S+6Kvq2L7yo9mgzBW4rtc3JaxX86Ye8wIQSsJBRFvLi9Yh0s0OZ5az20U0XtQigHchs9cfhHz2+pyeYRaBYDne3zwY/EhTFiAYFK+kMd0v3iagje7+CI9hozQ2gHCbrpqXA8fy0symxnA9pP+XEnYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qysJRVMnmqzUaP88+n5Ugl2Mz69g7FmfQGmIN8UNOI=;
 b=XRQWp4+/WfDF0xfcYIQd7sFaJgQawQLbLQ5UjswCb0pVyPK9uHSLDLdO9H1eCrUEgwPEZrXist4jHEJR5RWJc1Jl62BXQPoBjyFi0TjHXHqTcbCZ/dw3AAW+wNrsAwnIsrFrlt0MvKVrby+SVnglX50MpG+jy8Z7zowQZMtZbX6xLIbYG0SKCAeuf57MIWmtsjODp5KAFi18ogte+yCxLErKieU+DyftJ8dvXjLjV8VjPO50WU7NjObaF8V/SDhhIVCuGGkXwjE0zX1mhJ+ixpXGR/tXcSfy/hvHaID4MszYO1lJEMl8y7zRdP88nHCD4KkjdoVkZN/hckDeXLX+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qysJRVMnmqzUaP88+n5Ugl2Mz69g7FmfQGmIN8UNOI=;
 b=l779ei2ySOufsRD5u3MW86csHfLM/tiq2nGZ7Of3RzBcd5KvTcgZfN2FOJDrJCZnfV78ZZ8PQd8XZ0r4zhjrJRwFKQyPYDKa3eNugUeOU7+3feLVmlmBB8AQT4KAMe/ab0AODBMIMW2pZdJ9PS1CZqjb1OarW4dakIgloo5HqUo=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1982.namprd10.prod.outlook.com (2603:10b6:300:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:36:38 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:38 +0000
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
Subject: [PATCH 38/94] mm/gup: Add mm_populate_vma() for use when the vma is
 known
Thread-Topic: [PATCH 38/94] mm/gup: Add mm_populate_vma() for use when the vma
 is known
Thread-Index: AQHXPEQ1vRs0vBrIxUqHuI8bmYeYEQ==
Date:   Wed, 28 Apr 2021 15:36:08 +0000
Message-ID: <20210428153542.2814175-39-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: f70ba50e-4943-4a6f-62e8-08d90a5b69c7
x-ms-traffictypediagnostic: MWHPR10MB1982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1982E6979E73E6B451CCBAF4FD409@MWHPR10MB1982.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GgPPmT2NNioPM/oK4pZOuemN+XGKuVtU+yvoP6DAIVW57vG0VP6mc6M/j85gRRyCt8NVe69fAVmujY4TsnZSnqp4CbOWGADTeof2aQ2WWK0AV/Z7G+x5rABx8ypl6Ceu/o2eVIEEoWT6m7GtID8f37L5yeqJsSCETPS/M1YX7Tj0ybDDLHIWX4LkekJ+YwKA3U5TyQNa+5fKDMz/HY0e37r1/0hVGSO36K0SsZJ7B8RmBYjgAkXNNWYjGbLioLC3Vu4/xYjgx8od/u3nnblXj0l8+/fgPbuGo1ntOlU3wDVlN9up8TkiDIbHsqDIfofJw6zQkB0eWXNrb83RjlD1npSUBJT3LKN2pttFXTDMNUhBFfST4jPWV52s1/Qv6ZT1VQyGl/Ud3WXC7Ip+Ikie86V4gOzdESOJCFFzZxE2ULCyJ5qc9fCrQXQwvSjK1sbIniZoSvrBLARzIJd7d6HYHSZfLz4xj0T5ZXdrqMIOcSfqhsGNYvT/dMW6eIAC3UWsODZWiGW7VF8DWaghgAl8GY5CoqNseNKbZ/VC2UlTdwCjb8GcWRLkWJ3XO0MT1vMhrm95dLFota2TOj5LVSZP/i4qyfbMIZtNskD0hfKJSrY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(2906002)(8936002)(6512007)(1076003)(66556008)(76116006)(83380400001)(66946007)(6666004)(2616005)(7416002)(186003)(26005)(4326008)(110136005)(107886003)(66446008)(54906003)(6486002)(71200400001)(316002)(5660300002)(38100700002)(91956017)(478600001)(64756008)(6506007)(86362001)(44832011)(8676002)(66476007)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?mKu/4huCn92eL8rpzWyqS4mYZErBgQ3FXXKhKdL7dFLix9P0z5/YIME8w7?=
 =?iso-8859-1?Q?YyusoTFDaI9p89tH/7dzmaddcPeRN08xIntRgNhuLHPVNjD0u7FqWB3j6O?=
 =?iso-8859-1?Q?yFeV9T2hrV1UDcaC/KB1DKxp3DA/4AbUVl0pgkTvu7HB1MkA1pJ9E+36HN?=
 =?iso-8859-1?Q?G4+X6+0huOIlOvcGwk9+YZRhzU0kFcya2yKSQUnYWab+x7xaRErKxDNuKZ?=
 =?iso-8859-1?Q?bQkMXwcXay2gBZBpISt0ByLYj32z3oB2VjHcEVyEDpDBAcnqwXtqkDOx2v?=
 =?iso-8859-1?Q?RKDcGcsDygUutD6m87/2ShCxrAjc1hIxpBGMDG93lRmxzjHLLUxjB8Nl0v?=
 =?iso-8859-1?Q?F6lBiM1zdY7bboapXKyD4422giChJfWg49IrnrcN7mZhJOBCcnnkt3LTzE?=
 =?iso-8859-1?Q?rF82+TrwUDyKK5outVV/PlutHF69NqYx6X9ckCB4dpMkRe4CbBztpZmQ9w?=
 =?iso-8859-1?Q?CiUBesoRU7qaIyYJKJrQsUdTPejE+Miw4y1kAxLbZ6M53Lw/JEe3chDiHv?=
 =?iso-8859-1?Q?WEggX9YwMENfkj3LDheKI+Bdx2Ccu046zopF6pRwfQjL6jF2bA4f9bWjs2?=
 =?iso-8859-1?Q?Brb1pLtkmPj3oxCqCgYHJ42lTmPsa6bSmxKMMwXdCFLqpw0CHoZKHb/bX0?=
 =?iso-8859-1?Q?YoIxLoRUn10oto00FvblLof6XM9tq3NySVeAUaV1aX4R3t03BAXoKMcXPK?=
 =?iso-8859-1?Q?0KUvPBQTamd+GgjuslWrzw1j4SUVRsSd5IaAQSc0KCqx+G8+50CNVucAc8?=
 =?iso-8859-1?Q?irjIZ2Jt1rnP0j2WEzwFT5YWjNoz9Y1fPYf72zfp9XnjlICVhteoL5k1rF?=
 =?iso-8859-1?Q?KFSbaDefcguuZrCpYabf36LE71Qq4Sme3FLdSozRrFha7Ps4J0cl3WuUJK?=
 =?iso-8859-1?Q?Usa9yd4DkRBEutD2XnCWLpglx+FPAH+quozefshCeTcl4TkMBjSXNXS8Y9?=
 =?iso-8859-1?Q?/Sf3Y4YlB/M60VTPoI47KWVE5AFKi651/jHG9/4Ri9ErHR5jNrFEl9iijk?=
 =?iso-8859-1?Q?kuwNg6gHcaLQYNR3LBhdNiGtx8DepGwNw7RfdKBJcMbohZXkOe2HhkzLvO?=
 =?iso-8859-1?Q?MnaHbt2ROLXp8JgbGFAEUI1ROhowmvF7Rwu/hu1ybSiAhjIS78kRPCU1gA?=
 =?iso-8859-1?Q?QEDTTXmuCLIcZVOnsgQdQ6xEFZruqrF1HiVql9YjzOh2igBbCnd8JSok+y?=
 =?iso-8859-1?Q?rAmZnRKHHaO/mreERYIYRvDTAF9MFa3uQ7ukIutc6tMnZXwsw6g02cRn8i?=
 =?iso-8859-1?Q?P8Hv825+Msg2bfS02GmtgO1fi4Q1eqH7VC4DhInI81/7dtNjw94qzZHpPG?=
 =?iso-8859-1?Q?/z4jEV5IPe9gDyvdz/czjzJXRGsro6ybHtauxyOm7+k0ddMCPNC+uZi4dC?=
 =?iso-8859-1?Q?ElEDU0QCuk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70ba50e-4943-4a6f-62e8-08d90a5b69c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:08.1345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: torBeCZrfcEN+JXvSeq+VkEa7mVRPNqD9ghx0Wh+Cso0gvNMAHyk/cQ/4H+R0p2JDtsROwD6I25UACUOCm5VGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1982
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: B-Y0rfAlYZCwPRDYDGInLwkfUpJ5pcXj
X-Proofpoint-GUID: B-Y0rfAlYZCwPRDYDGInLwkfUpJ5pcXj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a vma is known, avoid calling mm_populate to search for the vma to
populate.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/gup.c      | 20 ++++++++++++++++++++
 mm/internal.h |  4 ++++
 2 files changed, 24 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index c3a17b189064..48fe98ab0729 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1468,6 +1468,26 @@ long populate_vma_page_range(struct vm_area_struct *=
vma,
 				NULL, NULL, locked);
 }
=20
+/*
+ * mm_populate_vma() - Populate a single range in a single vma.
+ * @vma: The vma to populate.
+ * @start: The start address to populate
+ * @end: The end address to stop populating
+ *
+ * Note: Ignores errors.
+ */
+void mm_populate_vma(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end)
+{
+	struct mm_struct *mm =3D current->mm;
+	int locked =3D 1;
+
+	mmap_read_lock(mm);
+	populate_vma_page_range(vma, start, end, &locked);
+	if (locked)
+		mmap_read_unlock(mm);
+}
+
 /*
  * __mm_populate - populate and/or mlock pages within a range of address s=
pace.
  *
diff --git a/mm/internal.h b/mm/internal.h
index 7ad55938d391..583f2f1e6ff8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -346,6 +346,10 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) =3D=3D VM_WRITE;
 }
=20
+/* mm/gup.c */
+extern void mm_populate_vma(struct vm_area_struct *vma, unsigned long star=
t,
+			    unsigned long end);
+
 /* Maple tree operations using VMAs */
 /*
  * vma_mas_store() - Store a VMA in the maple tree.
--=20
2.30.2
