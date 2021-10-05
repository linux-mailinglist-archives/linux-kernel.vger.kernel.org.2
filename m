Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91390421C59
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJECLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:11:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21174 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230237AbhJECLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:11:34 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951BZ5g010255;
        Tue, 5 Oct 2021 02:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KRk8xpjN43r76rHt5v8h+KrzzRMX3z8fvDDt+SqiRpE=;
 b=DA5Mlvxw2Gq9UwLBmJ7Ug69307u7DyI97434ra8OVYA6dgSJOsjSessj5wFumbFUmQl5
 tVsGZSHrcFvpxN7YQNX5vijnfyxa9ZDsQwlexUqIoMht0qqVtZr0HwaN3z5iyVk31JFk
 C3g5deraeu7V7ecFROcXrB/1pPVkpFkmt0kyP9xHIeZib6WqhKH/pIkuSb1/rwysEx3i
 IzxlqvdZvVLWxUvH1qodhxfysqLYvfYKR4qySbpYv59hxnjKnfJdKOzWuCyAyYVDW42P
 cQ2iGNdODuS0uiMoI9+t18OfU7oLGWt8tKgaruOsjezE0F8gZD8tj4BZ1/yGi+Ttnxza FQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3upv8s6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 02:09:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdG8141646;
        Tue, 5 Oct 2021 01:30:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDRLd8ScabmHsuk8FyihfNYRZvw0MwdTKluRidETdsAAAjCx38ltLL5XaatmSY9YRxE1lw5V65sJMsVZlvEVicHOpx/VGWdeefUizeT70SZyWUvZlqJ28jzsfTSD1zb4zsb49bMOJH6x72ffIfZtMn0wAuLlmil6I/T/nBB710UTAbJwpIK/puo/wMc0HdhFDTmbIHRBR+/I+pNjVxUn/ExEuD6HBUwvXi8SzgEAoPVyuNzl7a+430l9Bn+7905t8DVtk5LpvDzaVL7V41vzp31qCj3ryq1g4Y+wuGzC1GFbzqAB8efRww8syVLI4Wsn83Mxt/coSoolDZoj0gr+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRk8xpjN43r76rHt5v8h+KrzzRMX3z8fvDDt+SqiRpE=;
 b=n1G+d/1S75kXAxSRHFnr4udYjTIfSaJcO5k8HugCDuQmiaH7kHgJA8VsWRZgugu77oK+chxyJoc/qvHvGO4JfmO+PtGJ8LINGjhnd4gPHAz/bm9U1uc1Rtggj5MOSeAvNPBXtRyNfAB+L35lU/fM8pyhOJlOj4OpIgXOPg56Br9T0k0u0J+Fcz0oyDDovw1xT1s522W6U2rkcNy9XemXwggvm1zfOtB9MIvn5lGkwFt9sHMKyFMyuEL6t5DBg9rylU2wor5xQxE2KydR2NURLkzlpbhZdStA6aYFGVd16xSkmN/rGUvhlRlNymQn3XCCfg7EZH1KqFHj2bPZ3ms6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRk8xpjN43r76rHt5v8h+KrzzRMX3z8fvDDt+SqiRpE=;
 b=Dz64qoum3sL1/HrFt3Oq2zh11WNQPoW+23nkfjyKSiDObX56xOxvMsTfEbN6FWVn69Ktpm0u8D9Q7pug7fjzFQEnNZhZLfmerYv9aauwXENJXowgBMutQ94iF0rdMS7t72jaCX8dj1xWufWkbX1/mHvWLTnvM+CUj/Am6dWeABE=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:47 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:47 +0000
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
Subject: [PATCH v3 25/66] arch/arm64: Remove mmap linked list from vdso.
Thread-Topic: [PATCH v3 25/66] arch/arm64: Remove mmap linked list from vdso.
Thread-Index: AQHXuYifvsGhPbhCnkqWBDuSj5lHeQ==
Date:   Tue, 5 Oct 2021 01:30:47 +0000
Message-ID: <20211005012959.1110504-26-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 473c70eb-cccc-4927-c561-08d9879fc1f2
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB504491E73EE283C5B7A7FC7DFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tAT27DbBT4kVcSvgYhWyV85iqiGh5Gv4Pv2wUTc8mCBNtn2DxdPidofVAmInZbDkB5FBi0YtVK+sFTi3+L2o7QD2iF6bC2Q9IszlQHJ50TnmXG0wrZJCOepkm2hnDiaDkXtmAQmwYRXXASRVkKNOgAX/2VxDfV/MZsuP4dS+LfbmUkzsztNqo896+/ZW8bFK1PwQqx/Ka4PKqGmV+DguG2oWNT5kFlHbss9WIa1GDW+Lo+y/PokAItkY4zgRzCAeGrphrXzjuakkJlUeyJ2wCK/L2dRjGgrJwd6s8dTrXIRMX5x55AJNX2SpBOLSH/FL5lTU/l7uTAtLbWLoo/LZvaPACw6MdUT2yGSSMTOn+3UuvB99h/ac2l/PNl9DPPhU5ygbIeKf2MLsd9bscwQ0UVvOafZFg92qYkpGvx7RCCND4T+bdpbdjo/Pn6zQcrBt2wRVJR4U7ZpKpdeWHz2+mPRLI0BWR34j7OHrR25qkt8CgyrOr0C3TYsuym2rn+pvGHgrGHnZOGCvHQNKldTOMHuRbJRhd/laG59q1FcAN3vJsRO2utUrqdoNiEnPPtbg3O6xwYIQGivBtzupMyG5JRSEucY1HlB/HjwoVDAVyBvda1Sr5bILtCL35kafPZX7kHxHSvXpX0qJhkcHkKgD8/8v2Pzws5wOdiDgpTUyDVgQXF5Nu21ZVCmEp0uMLJMxd3RW+zxjyzK5gu6yP1OvQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(4744005)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mPwEKFJO/Zgr9G9JK8WzJ6vLsUEwk0rIUTYgc20VhTiTWoeSp2v2CqNt7p?=
 =?iso-8859-1?Q?A4M9tmg8ZDd/H09axOCMTFJDDC367cOyIVu8mN6hIqrmv62XscI1P/NS/6?=
 =?iso-8859-1?Q?/eogddF2KRv8WV06IzInJJWC53x/s6LRrM95cSP6ZGH8S/PQDUPBZJvDVV?=
 =?iso-8859-1?Q?rmOjdu4x1ra7SNWhLuFjKXybXvBg3WKOGesNPmlEsOH0VAQCL7xqBoBzXz?=
 =?iso-8859-1?Q?4hKLPOXVhMe3ao+LNK+2Vr9IckRqmzCVlo/5DESRYvcuxXqTa3W/hP+Vsc?=
 =?iso-8859-1?Q?O2Q8Fxk0/9UpAdq5i7mnvkSYRPscjn4nVjpkNcQkCOAxsdZtWUHzCWMyw1?=
 =?iso-8859-1?Q?uZtvq+2RwAGwTLjB7yCN52cAmPzDNLp6BawcZV/H6p9pAzX/Wwivt+NZCJ?=
 =?iso-8859-1?Q?0rDR97Q9+gbsGtb+Rrwq9Wx7yz0//ybq3KkwsB6is56i5up4b/6HT2tp8l?=
 =?iso-8859-1?Q?+r1uu4FJjpbMEnhcFVeRKdeZigyjcBlL8d6PW7KdwhAK5O6tZCAHi6s9JN?=
 =?iso-8859-1?Q?sdYnD1Aiah52V43VvP+f8v5aQhpGTdzSQu/CHR5ZUVzoldh+cSSTg9i0dO?=
 =?iso-8859-1?Q?yQ0sHis3cCaQ9O6xl+rE3yL+Z5vYLD2PJiCJ265UJXy98cxku5WrMh2xoo?=
 =?iso-8859-1?Q?gxoLnN2dSTt50BbqtvqgCdaWwI3Ih0/Inyj5a9lUfrExwHdrVK2BYkqaWy?=
 =?iso-8859-1?Q?j4/6JOiL7DgnW+0d3Zlv5iiqLA1V455gO/6qFbzdOyEhqE1s24fUXzp09j?=
 =?iso-8859-1?Q?jWoI0gJz1BaPY+v2bkiDhIhaVk0JhPPm7vC/In8lpzPQLxdZDrlZjqh7kd?=
 =?iso-8859-1?Q?sBbOoMFrDxbKqBFIzwh/lsKsRi+/pLKnBT+tGbRHTRd38PD3lh1r0MT4bt?=
 =?iso-8859-1?Q?C32pXVow6FG9kfXoPL+gw922A+EvFlmE07pBlfxImCkRzRMFa1GC7AuGEi?=
 =?iso-8859-1?Q?CXZ8kfZMLcXlK/U3yqjG8e/8jlLXodH4czMyy/gtaOibk5ENH28T9Lu+fy?=
 =?iso-8859-1?Q?GIRzECHzYkjGSMDblo+mOKpb1s8r6dn5HzpVs6vJgwe/OMIewCJxzqXcSA?=
 =?iso-8859-1?Q?CtrjaihT9Nl0SaU6HNCc9oxvZUZmr0XpvOIvSBym5SkCY8JGbR/CMEHc3x?=
 =?iso-8859-1?Q?8kpHYLVa3/Wi7lnAtKQEufsGONsbzMcnm2kb8ZFsIuMfo6W+lEng3hXMC4?=
 =?iso-8859-1?Q?AX4YKE8HLaRJYpSvFXUN3B+GJ1c+uVmn/yQxyxEs2vt9womqHV14B77NpT?=
 =?iso-8859-1?Q?PdrEnMNJYBPkqwiQvv45SO9NwU2Gqp1kGkyBGepfoayuIHXRl0gXvZbJXx?=
 =?iso-8859-1?Q?TQDG+y52d7H0MGcPJ1J4CJDJ2J1Dw31zUqRYkwYHFOlq/HWx5ghiuw0I/d?=
 =?iso-8859-1?Q?WdmmqSSgV0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473c70eb-cccc-4927-c561-08d9879fc1f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:47.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VIhQLhmNgqAvEXZwZbOW8HdiX6+nYp2beifhBRWo/oyirnkQXjIrH4hcRJRbsfTSM9ntExXsKy7pVcVlLzfXjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: nkGtizzAux7AhXoa2vzwD-iFqrEsGFPZ
X-Proofpoint-GUID: nkGtizzAux7AhXoa2vzwD-iFqrEsGFPZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

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
