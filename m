Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60A436DC25
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbhD1PnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:43:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64760 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240448AbhD1Phw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:52 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNedI010520;
        Wed, 28 Apr 2021 15:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1236/yjXDuEcCb4/5odJn8u6xtn9cui6m3hQ6MFzjZU=;
 b=vm7YZQN5fMk+Knb72H2S5OLb98TXO17wA/xhdO3vVKkn2DCNVfFu4+nNWZ6dp5sn+VQ+
 HEI1ZLq2sfCSzjmgtnmRTm/5WEKM/dHo8A2vnjOxw7jCqEFMXu60V9AzGryVe/OFqgiq
 tvfQEdhkDfVrPkTP+ubi0tovA0DAGCF5bOHywEBS0337/ovYkXkvhqnkEMmwOu5rCMmZ
 caynJvnN06FmqaP5bBlBJ9IYMSIXZjp/r47IRqJsjDm1mOLcOMakQvMksDSo1y6YqrYn
 tN8pPxRi7wYI3krKmeHv9NofDpOyvMzavJLbsE5jLjyWG3C43ZBu+Lcg507ydZfvl4eF hw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:51 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAx8018431;
        Wed, 28 Apr 2021 15:36:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3874d2759n-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqE3WCSZiMclrk6Fxs1YbzdqVRbIRBWM9SRhvoAj5gvb5ecegNDxHGEwX79WTq5ZiF2Vr+6ZO7WkKaCiITCXx4CvLWwZUbQ3YMCo82yRrUCibSa1dQ589Bzy2WjXQJekLRJSlil5gqoLlU9yNG1F+jGb63K5U8el6nFsphAl7O3CBl4gfB6Zi7jfqAtWHev85HibPIMAEXXjuJr53NqR4XYixvtt0IdWn2GdOcife+iPGi/RKNjL7ZDoGQkI4cgxLXdxbh8MBHFRPDLa2Xewgmq4co+by4j79JsVsFt/GounvTuzLIyTOgcjg/QvGAMtOe7IeaJGW/DJNNV6G/pwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1236/yjXDuEcCb4/5odJn8u6xtn9cui6m3hQ6MFzjZU=;
 b=Vphkd4dWyJuOMe4MXAo4SINGlHTyHucEDFTuqb7MevzSovwvYAy/zs+C6VBcGl7omYtVxRmOWXYuY8/DFZBtlUDs+TTMIgcFdJx8LgDUrODfWKhJDEELMAMkem0P06wYeGa3wq0i5tvg52bHWNdzv/jtvjRaidTTtodfU/ctaGjo3/WkmlM7MwKXtkX49aFpiuvf9zyMcVT0m3WPQHb6l9h/ijGE65UO3UJLiKZUl5YVEDZXEZnNt/CS5lC7Jc2K/yT9/NhkigHSurJwZSfLdZ21iRGvr8EHCWlGD6VfuhaSvzoS4JVk6GnqhgrH7WDNkzjJJR0k0DDQDd9WY7g0LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1236/yjXDuEcCb4/5odJn8u6xtn9cui6m3hQ6MFzjZU=;
 b=V6AswDE2+cpHiiw4f44NH9M85H6qCeRMGhSzR0F4RmW+mjREmyZq3u43AW9p7C+gNu8HfrHynIceGRiL2ZLrqaAmm2DVyQNgvSNyF/d/zOQvO1QjNCbL1lkFGtP+8nCCcfsTZSRtlucUnuNdzCowXoW+sVvdETzf7ic1QxE+DNQ=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1743.namprd10.prod.outlook.com (2603:10b6:301:7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:36:46 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:46 +0000
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
Subject: [PATCH 54/94] arch/parisc: Remove mmap linked list from kernel/cache
Thread-Topic: [PATCH 54/94] arch/parisc: Remove mmap linked list from
 kernel/cache
Thread-Index: AQHXPEQ5kJgl2G0NBUKuLENhUljoww==
Date:   Wed, 28 Apr 2021 15:36:15 +0000
Message-ID: <20210428153542.2814175-55-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 6b98dc0b-fda8-4df5-16b0-08d90a5b6ea6
x-ms-traffictypediagnostic: MWHPR10MB1743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB17439693749D7080D6431A6EFD409@MWHPR10MB1743.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NbmFpwF2x+WzftBzLwpj1kfTlLpLB9e7k8b4QS64fQmbklGzkUjhcAWwZyDiC3XUKIr+KCtTVsPDQ1V2AfZwkB+mcs162Fxkw1GpRT4UBNeD4w0zghNP0f5eq1dbfCBAYGvJunbYJr0zXO21z3WpLXBC6yK/Y41OlsvjcON/6WZMmHPstJbkaUQWZI/60DJYJIHG9OGR98jw4zX6vA9V5s3mzVWrECYXOju0Pr6MlplZ6OgG1zCSA6zhSnx5lA3Ia2hIhoJTbqjiurljjfLOYrzQ6ERH5JpEc8gYVcSxnTuYqL80iJWqjAizToc0TrNVnAKLX1GuaL4FxAL6yg7FTTQC9+QD8PoWyyMu0m2nWEzA256HQAaTNTuZ2oK9BCGZAb0RYQEr2gwhDL1cYNhlhmGTGgS+LKwUbNkNPDYwbkMnkGsYacwOGOW4aJWsmxfW8dLKc7Wq3lkc7V2VjmYXPBoCeXWK6dGOrq3TawOloiqomk4/bfOi3RfwQeWouGeAA8tQBShz7SC+SH3ff0cemgS+kKbK4u4xpwOccbBxO4UsUVAuvpkkqFV15PXGkC2JT6cN1bgPSaDXpj1j2GyOcTpVckT/JrZpl3+r4hWdzig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(110136005)(91956017)(316002)(1076003)(64756008)(66946007)(76116006)(44832011)(5660300002)(66476007)(66446008)(8936002)(6486002)(8676002)(83380400001)(54906003)(2616005)(66556008)(2906002)(122000001)(38100700002)(6666004)(478600001)(36756003)(7416002)(86362001)(6506007)(26005)(4326008)(186003)(6512007)(71200400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?NkSzcOYW/lvSzUlDRreBwAA8wr+4Qmwfn3ezHxW1QOGmNCGlyKfoKT+1yG?=
 =?iso-8859-1?Q?y3/qQTs1ckGvB84snAqq7bs4uc8aUllFDUefQzrBafHrlTCJTXwxbiMF1k?=
 =?iso-8859-1?Q?YajzOUfoesbD2jypry12z9t4nhyfZwnc2lWEPSYP1s9IEJrdWF4toH4CKp?=
 =?iso-8859-1?Q?Mqk0XkdG5Zc4aAXjPwcvQfl/WSgVbSsjRoMv2PSg/uPM3tyR6lHkMD7dPf?=
 =?iso-8859-1?Q?gJdChDxdbwmrr2s9HPe4FuZ9l4sQ2pWSKtHlXrVtOb+g+qS84DM/IJM5nl?=
 =?iso-8859-1?Q?URLZKY/LlymewaNQKjVj8sCKwzuNXblgJhzp7BfgS24fzW8kE2XFItP1S3?=
 =?iso-8859-1?Q?vkp1pLf2nLcFj+7Vw8HunF+kn1wnr1nbgmkczF9e06P/AguyhpWOLjXKQ7?=
 =?iso-8859-1?Q?bxD2HvKZ8h44iYe7tCBve5ez2IFC8cdZ//CxmV0UPkAfmajh3diP42ZBDy?=
 =?iso-8859-1?Q?NlVcOTkZdiRvYMlwStmS1n98YkuPQbOEt7L2Jw3NojmUKAehVnI0Y8Z0P+?=
 =?iso-8859-1?Q?rfYKTnh841gptWjum016jJ6HbAX3Yk7vhMI7X1JU8eKOfvGRMUCVEEesv0?=
 =?iso-8859-1?Q?uYv/5mMoaXlKnqzjfQTRY8c3XsH4PO7pCRcu4tpLNvcjg0E60hLCkEhXKN?=
 =?iso-8859-1?Q?AlyWM9dBGTmpm3kyBeq+JyfHqHZvBjHRr7U/pFuVdvG/zQuqA+Cj8nQzi4?=
 =?iso-8859-1?Q?BTJKnU+WxB0poXfDLt0ecoEHKPXPGuMO1QX1p19eY8uUiLABrJQ3C9fbzg?=
 =?iso-8859-1?Q?4r6jRKZvUZJsiD9z42bY/dlHmjYsybNo8L/X/6AftwCSfU/x3q+SPgYMaP?=
 =?iso-8859-1?Q?BEsODMUYW0rCy4ddOmosAGApy6kzJ/+06ZTa0BlJohK4nu8gR79Dkvzm/D?=
 =?iso-8859-1?Q?X3TO52c4qykbe2bAs5BLMSstTMqffIUBKjz2vKOCiNnguV64S3eGJSJvoa?=
 =?iso-8859-1?Q?ue7UBaCJoEQfA4SAsNU1GC1s4tZJY2uWN+ak/bqe0FQQ8s1+GIR90N9Ers?=
 =?iso-8859-1?Q?MuhOrU/mcetdwB6aGib4iG9+DVoDnDqMILu3yxmBkS2nwXjZ7lXE2p4gpS?=
 =?iso-8859-1?Q?+06jbJ5+O3qOE3EZwGkHJFGyu5xQTRx8sy0hnh8klbGZefTrJp7hApwauX?=
 =?iso-8859-1?Q?JxfU3bAc8wbJ6jGcuY91PqQWyv0J3RVQO+zYZ/h64gouXHhQBbkq40sfqA?=
 =?iso-8859-1?Q?B12io0yiJnDMXrwX8BYklRwiZYVZTw1uM7diVSfwaujnaQwR9vWeoe7nns?=
 =?iso-8859-1?Q?aTcH4YbGJxNQThx3Oxw4pDDFVi1nS/gaB/WfQoVjcj8xHnENDzY79uNKvu?=
 =?iso-8859-1?Q?4l+P6wQT9N3vLZd3zwLILGAtNLOfMinuqkHdYQWiF8Ib+oXGBxcqv2mPbQ?=
 =?iso-8859-1?Q?YLf2nq58mh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b98dc0b-fda8-4df5-16b0-08d90a5b6ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:15.3903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrNuwsmZIKBjcN7puc4D9C7kdOOCkDSEbQlAVV4zp32LGIeKWr8fT5OURo+PLQC6HTWwh//MVniIyvLQEI9LNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: 4SxOnZ5x7XZWA54ohSVIdStUU9GBDawv
X-Proofpoint-ORIG-GUID: 4SxOnZ5x7XZWA54ohSVIdStUU9GBDawv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start using the maple tree

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/parisc/kernel/cache.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 86a1a63563fd..bc7bffed24ba 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -520,9 +520,13 @@ static inline unsigned long mm_total_size(struct mm_st=
ruct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX)
 		usize +=3D vma->vm_end - vma->vm_start;
+	rcu_read_unlock();
+
 	return usize;
 }
=20
@@ -548,6 +552,7 @@ void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	pgd_t *pgd;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* Flushing the whole cache on each cpu takes forever on
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
@@ -560,17 +565,20 @@ void flush_cache_mm(struct mm_struct *mm)
 	}
=20
 	if (mm->context =3D=3D mfsp(3)) {
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		rcu_read_lock();
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			flush_user_dcache_range_asm(vma->vm_start, vma->vm_end);
 			if (vma->vm_flags & VM_EXEC)
 				flush_user_icache_range_asm(vma->vm_start, vma->vm_end);
 			flush_tlb_range(vma, vma->vm_start, vma->vm_end);
 		}
+		rcu_read_unlock();
 		return;
 	}
=20
 	pgd =3D mm->pgd;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long addr;
=20
 		for (addr =3D vma->vm_start; addr < vma->vm_end;
@@ -590,6 +598,7 @@ void flush_cache_mm(struct mm_struct *mm)
 			}
 		}
 	}
+	rcu_read_unlock();
 }
=20
 void flush_cache_range(struct vm_area_struct *vma,
--=20
2.30.2
