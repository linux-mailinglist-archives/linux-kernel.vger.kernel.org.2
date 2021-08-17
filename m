Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F314F3EEFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbhHQPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22608 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240310AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkDb1023520;
        Tue, 17 Aug 2021 15:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RWsBZyRGV5ymmcPz2MuSnU85rCU1P9JsAtjGK0ht3xs=;
 b=zlhW+Avgu8tm23p2VRmFN6ipraTLMj1jKtqAlOPO+U4bISu8/MUsSbkDUwwnBP/L6Mzl
 RmeewhJWN18uw2iGuJkytJ7AJ6vn7urCGeGMLWYr7z2QYM2OG/x6siX+oxLHXYo69kiB
 oKDi2AGivrIJA+uPFV540ZpYtsZykD/tP64K+umX9oAS0w8b90IL0082VJ/as4m8pDCL
 WMkqpQUwGUuQMo24cuZAlbSv+YMI0J5FElZwTriHlSJ8rbnQFWum5Le/j9fRe193SkmO
 kQBhi2fXaX2cO1v4yYNIMAsC7NlCl75yX12u5rW8Y7TLHqRtuQVSzDkhCkfYmrzO8re+ cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RWsBZyRGV5ymmcPz2MuSnU85rCU1P9JsAtjGK0ht3xs=;
 b=Cuzwq1THW39jLQZ1KMZv5HSJbnTm6CzLvXsENOT1LCtsaxUDCLBEJTAnTzNkGGRAtCO+
 MblnBek69CmNmsU5x4EV0tOw0nSAxcYR8xDDFO4dywgEFvSJkGH8/EFB0qYRAkYO6kW1
 5AAlkLVkbO8drfZddS5KY3MjjKwfzVsDtyHZh4oflzXc8FEkn01en6zbXll7C/otz8l6
 YOfzRD5Uv2dwWA2ySRsrCfHi9L3CXpfhsv7F+5YWAkDv4m7fGnS392qhvurPK8yzdGgd
 QyEVwT8WBEt5aiwz4+BqECymymeFB3SHh9dIRbOOFxW3nRLMzfuix7hWSwOo8sk+d4Lk yA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd4ke7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfZ158706;
        Tue, 17 Aug 2021 15:47:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmWEW7nEcLCgQOTN3Ep4sSAa9/8mrAMLPIHiCpA3f/CxxWGqFql8zEVUYfkOJvUvzcn2Uf48kQz0kmBPTJ52JqBTr8Aw6b7w4O3lCS9kMQK8fQnNaSp1Fajakg22JN7NQZAqxp/i6izTHU+14YmUnK4xO9EgRrFqoeW5CqNXaQLxLhxFbcl/FvwNpkNYuv9W43t/ItxAlefigqalPG47Nm6xGbUQDkiDx/esxTYTYyLqRYbhbVF4LdWahnpNjIg+PG/wIufrNrctcKS0IG/JMk+ZIcefPJIbtgvCJ3eDqMtrUkqBdfmLoCcHuDF/KIs7UxwP4bUh1GQsxMf7jinO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWsBZyRGV5ymmcPz2MuSnU85rCU1P9JsAtjGK0ht3xs=;
 b=eI9zOeheh8MtlyIme04Dufo+FDXErWb8ZuIhtcVM6ir6GVvOFfiLQloBzWrpjcM88xWfp8DaeCT75o7toaMrdulaEmaQXrgjApdqgMbG72z+Bo5xmsLoO8KvWJiUB9+KGkrNZK8Hap4UX4xUjlvlCIfTApaYfQLNEp6wTvUwDHVpioQZ084t8omfpIDW9H/y9Vc0eKL7nADlvnsGTMiqOXD+QL09LTGXDm9vWUjP+ruzdYeqQya0lkPqaQKNzYUJUO/LtLpZUgy/kPdS4GibZzWC09LK/B1DcqzRsujeYNBfM2TdS4MazLWR7L/sj9nauZ6wT5lssUOHYidgnV3pBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWsBZyRGV5ymmcPz2MuSnU85rCU1P9JsAtjGK0ht3xs=;
 b=oEixLW9Oi9UO7uglT8gv5UsP/McgVmBcM4rSt3XYMq88nElahqpovxvIOaQVg94+PtY1+aO3iZR0nCTFAFJVe4ZbLD2EkD/F1/7OhSj7RuDVG0MmOfXk3CO9aM7pL+T7Czpn0Fr2SlcBjxs7n33pBi4RcJkC1rrHpM2xbq18vpc=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:55 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:55 +0000
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
Subject: [PATCH v2 43/61] kernel/sched/fair: Use maple tree iterators instead
 of linked list
Thread-Topic: [PATCH v2 43/61] kernel/sched/fair: Use maple tree iterators
 instead of linked list
Thread-Index: AQHXk38vrLA6c1d480uY27TLeBnJBQ==
Date:   Tue, 17 Aug 2021 15:47:29 +0000
Message-ID: <20210817154651.1570984-44-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 9622519e-a898-41b4-45fb-08d961966135
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB358081A12D1C5BF8237C34F2FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WLSFdvNSjmindaAPwxIpstHf9if7NiIUnqgDoAac8mHzC1fJ8PuqRqbUwZdoTsXRHHMxoJYLHYnY8ad/5BG7GQ/xnRMHPbuZgAm7inZQ+Nnc6ysh1ZRK8q7RMD1NBWmqhIT7SfY+SV8gSZ6yl7PF/sqVQzNywsx3gUs2giVIY8N/fkz7iVwIwQWlg/XemNf+c22Bno/5i9wuOjpIuEZuKjfugzFvsKuSkFi/Qqn8ZHl0vLtxm6F8/0+HkWsDdXz+7l0rNuFBR1q5SqDeKKCsm7S8ejOp1gLV41UEEWrwvbxItGSphye/EWT8Lufx6eee2tEMT0YusF2ZgCRK/LImOBE5NJjyh1DnxUlL+NjbDfHPzyam0QzsAkqL7ywjDKYdaW3OKQb9Iie3+UUcDjBPG3FQqdf6h/x8pB8k0RQQYHWdYKjCqk8ch6Izck+99LGdnhXDbzP3ka/UU5NzNXFBkFOSGAiyzNj5EJO6NK5FeziS3FBfJocy8Ix6LOwcEAuI2sUkqH3Fqaz5B8hqldXsczl1lT0cT16CzBwe1ijsmb8HCjAzpB6dA4Ykw+TWEYfqi5uyjg4ViRH6dwEcouIrjd25FUALM/eMzuK79LqX/2T46dqL0EDQ7pT7SRgj7CCi+M5ZLjUVepYgICnDIBjfMzcbjBI6qklPI8j4zPfLCACkW5qwJsPAcoN4gd3XamNqGdBSXDkycqAn5uMvKyOkKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A+jnedSHJxa3W8Gu3bQhvhtvXM+tUkJMyBFlPed5ztFLEdEQzGq9AIOQ5O?=
 =?iso-8859-1?Q?yr61mo+AI6AY++wr5yNJVMFSN8yvOJ8S0iRFQODXgToLoNXtnSJZMamKo7?=
 =?iso-8859-1?Q?c8AeeiIYhFe9q7SFDmEtZd6StN0vpqHamkSIenAIPN2O9Fn3XwY1NIbrEu?=
 =?iso-8859-1?Q?s6mK13QfyUNWe168VSOWC0rxCcMKMQMDCbjKvoxPfX3we8ndl5xMeSTp9a?=
 =?iso-8859-1?Q?e7Mz/oEoGg+r/RyebaMFFpBz6x3aiu0b6Zu9ZUmPfRefojm6eoG+AJ4vo8?=
 =?iso-8859-1?Q?M9r6e6+Cbto4g20t7xZgWQPdAbFi2Mwagwk6rlnUFSPJe/pHDb5XEyEwcJ?=
 =?iso-8859-1?Q?vqJLK9vyOCSR1/DZVuYHmzknmPBfAjgZ8gLjnDU/0MfhjaPLQGwqB34uL4?=
 =?iso-8859-1?Q?mMR/s6gtAMhopzkp1V12z8Kat2BY5Xx1bXYWiKfoZPLjoXg87pNM35EOI6?=
 =?iso-8859-1?Q?QbF3/7EtMjDx4dEqYnIJR4K86fFYimoIP5Ra12ImgbcLHlzU4uNgMjSMu0?=
 =?iso-8859-1?Q?Dkb75WSqyMPsc6sbj2iaI4FvZTNFnhlj7pzDgOe0n0JcZqxRedjnoCqK4k?=
 =?iso-8859-1?Q?38AK2c9QPHPWMO08NnspQuLcMA2l7XOXltGmrcdaKKjNvma1DVF4noBNtc?=
 =?iso-8859-1?Q?1YdR5oybhoLvpIqPYKu1Lj/16SICphRkBNAzv4CQfILA693OtcorhNY4XE?=
 =?iso-8859-1?Q?RVcR3+hHYpQTMKaS18eiL79NpPSwLcBWWDn2doahgkX/W7hiKmfs0z4kkx?=
 =?iso-8859-1?Q?Xwuc3uHXWRnlWaEy7/urn1QSD8nhQLlNZW6mMIIIH+MWzz0BugOlw0YlMc?=
 =?iso-8859-1?Q?Cw87VvJzecojT5zp1NEfQbV3DwnIJysw4an2bAsoVKkDo2VvxB8bC+4N0A?=
 =?iso-8859-1?Q?XI/bqrnwf/T3xB0M3f1QfvIGGlKrvuM6dSoVt/R4bJhSOe0AOVbHIvUv1e?=
 =?iso-8859-1?Q?gQ3K8GK13RiMdJ2fz8uTZBRaLufUyihisj91WLcnHF0LNKGSSETXrKLc5w?=
 =?iso-8859-1?Q?VV4mVrwudVg2ewpr30zOWRlm2w7+Ezl2VWIxAzOPy3V9RAdYVtE0WUP39v?=
 =?iso-8859-1?Q?iN0FWjQK6N1owoIsxu3BjjhnT/8DsYKO7ujHLbEs9yiVwIqjcQRJHNEzYB?=
 =?iso-8859-1?Q?7pzHa1x8Dwbx315Om5BvMRgVHJ3iuJfgoMeoszj16zb0zOrA3t2nPzrK9m?=
 =?iso-8859-1?Q?rmUJK3wOTz/uOV/RX8cTJS60Kxzow0zfj37DCX2L9jwy7OFlegtG851n8m?=
 =?iso-8859-1?Q?Cq4tfJqChoYQOjHWArxnM71VpeiBIYQ1lqW+HxLAzlvV+DU2oex/jWABXu?=
 =?iso-8859-1?Q?f949oCmoI8X7FgSa1GUHsldXBsifJsHRto+tlH4vtLapY5Pk2HPisKU0T7?=
 =?iso-8859-1?Q?RAZ2NctprZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9622519e-a898-41b4-45fb-08d961966135
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:29.4291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tSPVPP+dJWeabWDYmr1Jtiol9GZMtc8nYhfZbD6PfXJpeyHwQUiOrUbzykz0W0AJ/qmgXaHhPMDcJ+wW0jGBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: gdbF9UtSrX3h4CVtlR8Rv7Dm6px2pP0U
X-Proofpoint-GUID: gdbF9UtSrX3h4CVtlR8Rv7Dm6px2pP0U
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/sched/fair.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44e44c235f1f..154fce44b38a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2688,6 +2688,7 @@ static void task_numa_work(struct callback_head *work=
)
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
 	long pages, virtpages;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	SCHED_WARN_ON(p !=3D container_of(work, struct task_struct, numa_work));
=20
@@ -2740,13 +2741,17 @@ static void task_numa_work(struct callback_head *wo=
rk)
=20
 	if (!mmap_read_trylock(mm))
 		return;
-	vma =3D find_vma(mm, start);
+
+	rcu_read_lock();
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start =3D 0;
-		vma =3D mm->mmap;
+		mas_set(&mas, start);
 	}
-	for (; vma; vma =3D vma->vm_next) {
+
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
@@ -2791,7 +2796,9 @@ static void task_numa_work(struct callback_head *work=
)
 			if (pages <=3D 0 || virtpages <=3D 0)
 				goto out;
=20
+			rcu_read_unlock();
 			cond_resched();
+			rcu_read_lock();
 		} while (end !=3D vma->vm_end);
 	}
=20
@@ -2806,6 +2813,7 @@ static void task_numa_work(struct callback_head *work=
)
 		mm->numa_scan_offset =3D start;
 	else
 		reset_ptenuma_scan(p);
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
=20
 	/*
--=20
2.30.2
