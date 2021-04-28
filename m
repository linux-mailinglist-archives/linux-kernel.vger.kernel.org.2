Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A14D36DC33
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbhD1PoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:44:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2324 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240468AbhD1Phy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:54 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNedH010520;
        Wed, 28 Apr 2021 15:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=La/Zb7bp2vdfBa94+PhmWCJuHnX6ies1bJFpkLUJza4=;
 b=qsmdfeGMwyEuE73b1AZ2d/eYHgSm321EUmp9S6KiGtmzVC+DG4T+UfOpk8xvbk47piIM
 sRz/RcaZYGxZoOQFJVleyI1h+CTLv9TJpJoEDKoPfstMtsaMwVIjmf5F9kmmbRAHNFsw
 bjiNgOIXNNXBC439Tqlth+AMlgvj8m8uyywq8vWsKAU42drLqbHasfhgFi5lPi/BQO3m
 PHOqQvWCUH4Q0ZHYHdoyMTofuBOFuAHxOKoUCG6d5SNb3WgcIz6kAq1/ZZ2OImi8UlXu
 4JBoOZbnP28SvcDKDRI17q3gyrF/ZzwgUhoVMtJTZ+BlbMzzdH9r0Kpme3EfYjGUqccA Rw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:50 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAx7018431;
        Wed, 28 Apr 2021 15:36:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3874d2759n-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBTlzsVlUs4B1D9dDgUJzYhQp7KlgGF6D3J+eWJdUXkZCeDxz5BEBjMIQFTCdw8b9p6dtuFp9sWgZmFOuDOryT0C7+KnyUC0v96yUqF05OkrxrN625zqj+cS0tHEfZxs7CoM93VlQ1e2bc74XFhKN02YqU2UPwVxemm12o5aIfHudsrVMH3PN1f6Pb0gTqVSwV0yiNo6mAAinZEQ4jc+6o/62hpo1GA293ABGz0CG9PpgKHLx8hN2g16PfrRxinKamDqzrRLM6hqaTe7saO6+emYvhUL8xXUGcSz5kX9K+8FoZUnfn5Dx2DiKqoBvvZUbrR2EkDZI1inCoGbrcDw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La/Zb7bp2vdfBa94+PhmWCJuHnX6ies1bJFpkLUJza4=;
 b=R9J4hEmXEGsOZUFIddoZWxxQIOz8+76UkvaoRY+3uupLo6l3AGXZILYHiZ+Z2DblvnjHLiM2DTdxI+4ZY8qFoi5wpjT21cDA5p+E26ifwu6vwqQCs4AdzQsJgmmyB8p3vp6KAm03B5QbJThgtigkK4pT3WlKv0I9OJwxsbz0933vxbrz9g3zbtA5vhBz0zl/04pO19G9LRqXM5e4MAEaZcooJtigu1xWrx0ki11sWRJbHf7bseiHtPSOBK7ewD5omFnC6Fv37kpHnsuJxPMdZBcVD6GGQQuNF7a82o56WkKxmk5dEUbHNDsBICYPyxCmHalcq9SdtmHzv03ZURWb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La/Zb7bp2vdfBa94+PhmWCJuHnX6ies1bJFpkLUJza4=;
 b=W3YGO+nlQ8kqPr4ts7xyCwGHyeO0Qvaxl7gBFNkWqXaX18nBQp5Lnlyff0jFnKhcKf7mOZO2fGZ7wKG1ZraGVD4Pqt4Cj5Ym31LtngGYMqb5GeGprjTm9ljBlhjhlLYkr2jbBGsWS6zg/1wsWotDivOttcpBqEr+izXo0bMMDR8=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1743.namprd10.prod.outlook.com (2603:10b6:301:7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:36:45 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:45 +0000
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
Subject: [PATCH 53/94] arch/arm64: Remove mmap linked list from vdso.
Thread-Topic: [PATCH 53/94] arch/arm64: Remove mmap linked list from vdso.
Thread-Index: AQHXPEQ58hjBnML5DkqRwrFxwp+g0A==
Date:   Wed, 28 Apr 2021 15:36:14 +0000
Message-ID: <20210428153542.2814175-54-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: df04cc21-a8c8-4ae0-a57f-08d90a5b6e39
x-ms-traffictypediagnostic: MWHPR10MB1743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1743A98A73DC841E7716A376FD409@MWHPR10MB1743.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3kVb+UToFPoz5IVQMpzwxBDJnUrqD42gYI2XWMO9StxnCEqCInDetytqlO89p2bj/Xu/A2yrdpJAuYQc8Xfbvec7qhQ5tYAzjEXra9pq+b6J1df7+yCNKBlIGGbHMtoMvjjo7Zh32oU9e8Bn/Zaow4kus6OO/DoPB25PQeDsvqSyuA420xu3Kp7uNWUZCiH4xJ49ivrSuKVikrGFTHnCN9YqsVVtRd1RshJInDg42BgjNoltRGeoBHMukKQSLmqJrWpR8kZdK2WVlrylKBIaR/INzFvqtoT1ufruasVq1/dOKc/exbU0Axl4dcJlyNsncOF1viN77wiK4Vbdem8zN2vvM4X1Adefa8ngnotIiq//WbbOgKkuHKVBJpgvDQ1uNX8B4hPGuRoR81MZy1zqcSVK4xULQSD2Oj0P1jYWYMUR7OFon9XK49bFTvyYQCiLXA1h4I/+su5tCLEGAfPtLL7VjJIhBTKP4XXI0GNqjI5EUglPdX94FXccnKfuJ/feSlXTBkxTQIDyWL0XrYrxZZsIFY5qf8+/mzmMxhaapYTJVN8fK1zglEcB/UmGsOKJj0w0YDowyoA+b7D905e+W5G55tt/HmAHHIfjJvAANwk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(110136005)(91956017)(316002)(1076003)(64756008)(66946007)(76116006)(44832011)(5660300002)(66476007)(66446008)(8936002)(6486002)(8676002)(83380400001)(54906003)(2616005)(66556008)(2906002)(122000001)(38100700002)(6666004)(478600001)(36756003)(7416002)(86362001)(6506007)(26005)(4326008)(4744005)(186003)(6512007)(71200400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?/cOKbbZqH+3lvRe3LC5CeJMRDi14Ahw6Thuy5LcoNYuHJfy4meIzCF07gr?=
 =?iso-8859-1?Q?glM15ofhX71dmwZ78bPqLKc4McD7FGwc0lzzFjxsT6PCzUd7u+JwD5eWZw?=
 =?iso-8859-1?Q?QcvJo1ekXoNbm/59YyEewOZCGV+dTnMb95Zl3jlpEOau1LfNxjy5F8mr87?=
 =?iso-8859-1?Q?M2rqqj3azzIGuHZT+2m2CLnwup2ikroa6oRDj+yOUXLBpV1as4IIZ6HrjW?=
 =?iso-8859-1?Q?SwiBkDkWJntPHEZC5ZVatZJ6wR2MVO/WeZVLHVLdjqVDdYTqBzMdKCUO70?=
 =?iso-8859-1?Q?khtMBBCPcDKJCDrV4NvrC2DDTC2bwE73+7QlpWRNe2iajGltYQHoYbB0Tf?=
 =?iso-8859-1?Q?wPEChSjXogMOCtwA9E9Bct56NbxxCDpshM84KhPbt/T+Km/f57wfD/NWkk?=
 =?iso-8859-1?Q?241WiujMyGwiEDyUSL04zSU6k2O0Knhq/sgLFtVB6ssbkglbuClR+zHQjd?=
 =?iso-8859-1?Q?UhEMGyDz0h8dcCxCtg/4RJnnkfWK7MAR4wk3AXWPnC1lI2lq8NDIPReFb4?=
 =?iso-8859-1?Q?/fALWqVaUJWbMMRJ7P4V0fiv7ITEKh+0uU966B9CE4EaBOTltQGdsIhTj+?=
 =?iso-8859-1?Q?2NZrX2QSIdyCbxYsQ1qFBtpmNXe7gTQgOJWKic0Zw83F206zUIogKCrPMs?=
 =?iso-8859-1?Q?IyeRPCLdKXAe/qryf0xTa+WFIyCt8ViWh871apD63I0IE1VjAPGvQBgOsc?=
 =?iso-8859-1?Q?7XuqWonwCS1ZPy3O/B6t0sK8Z+mfPK3tHJX0h4IF0Prfft3UsYCJ8QURGv?=
 =?iso-8859-1?Q?+/DgoQtVbVbJ6hVpl9TrRlQCo+1MN+uaY2mREnhs+W/ZfpDbncc5J74MAT?=
 =?iso-8859-1?Q?wW8LPooSuHVER8LO/k+G2OEOE2nzNqLE6E8hOfJ+3IE0TwUZ63ThE0R2sg?=
 =?iso-8859-1?Q?BDmtvBqG92WP9TtQpM2AM4VZJyqf1nDWsBtaSR4+pGFi0SacHP1ElYYNt0?=
 =?iso-8859-1?Q?oQmYbdO+y4Ln9H0hgk+mG9z0NzZPXVK/D3hcSFFTuzWfFprHa4FHWslv1u?=
 =?iso-8859-1?Q?8dvGvEkwK6ZexbzKVWuG1xjQ5v4CP8MYcYapQYrOVOxV2WLuZBl4p/k0pS?=
 =?iso-8859-1?Q?ugFViDApRTAExbaFMiplnHWcblBR7d6uKlqPXFz/DjSKC3hAlMZv5hKXWK?=
 =?iso-8859-1?Q?mb7oSTPJzJ8eQJk7/nFPIpL65CnHOBvZqlTqDZzsm6TdXuSSAfqNEoMddT?=
 =?iso-8859-1?Q?atZEGNmiez0HBTWE8++p22Q2myKpKSb/SCGV33iKTB2K5PBQsXBT8RDHpW?=
 =?iso-8859-1?Q?FBFGwuMG/7TXBVFDUlOwdoDFHU/LKn5wxTl+aJhWyuuV6VwQ9jdp7aovtl?=
 =?iso-8859-1?Q?1pM3Eu7BLfq31JZKJdP+UDYNYceDxA9jLBrOH0lglu8PhsKFjJWl2HlZ2+?=
 =?iso-8859-1?Q?We9dUK4fKt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df04cc21-a8c8-4ae0-a57f-08d90a5b6e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:14.9355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LH/M/Kvnrw3zDvYHZMqgrX9zf1c6WqIxMr7tbzsQOk5zYCuXPwmnj5C1351stt5W1vV81ttWgqf2J7ZpryW62w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: eFYKygZ3QpJ4MSjVq4VUc7iMV3tbz_Gl
X-Proofpoint-ORIG-GUID: eFYKygZ3QpJ4MSjVq4VUc7iMV3tbz_Gl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start using the maple tree

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/arm64/kernel/vdso.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..57ea81fbe04b 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -136,10 +136,12 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
@@ -149,6 +151,7 @@ int vdso_join_timens(struct task_struct *task, struct t=
ime_namespace *ns)
 			zap_page_range(vma, vma->vm_start, size);
 #endif
 	}
+	rcu_read_unlock();
=20
 	mmap_read_unlock(mm);
 	return 0;
--=20
2.30.2
