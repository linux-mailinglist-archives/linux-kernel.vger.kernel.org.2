Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9502036DC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbhD1Plk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:41:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18286 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240607AbhD1Pib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:31 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKnmJ030215;
        Wed, 28 Apr 2021 15:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=E7J+WcSUJ1r31e7hf/mrFCkYLeNhw2hBOH9Esm1/sbc=;
 b=taAEHfbGKnpe+H3QYihbF2UuP3SIW6Sjs1UHPvCNYiR4ONuZPdU3rD9ZAEJ4Xs2B9tkp
 zCN9eru1zkTj4C8HUrYocfkO6g/G1+b/vBFmeYMY/CHhOBKc45+p/+gP+fcmnPEfpK86
 bUM52BJdIIogXSBqkeEvx2u6pFQvBffO1UPIVt6zbITytigjK4GFLF3xT4gcoh6wEC4T
 DDdhT2GUUuSi2fbHpZeQdWKBq/xxxDZC6xaGtqYmQ5bZjFWQ3aNoDEu22ssSufiGTPeL
 PJv07iiNdSgbKr2vm/338dRRTcvLIFTzXr6Ri6TSyhuvDiSz+cPKWgw6wH9ByPnElAkl fg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh634-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:25 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAxF018431;
        Wed, 28 Apr 2021 15:37:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3874d2763b-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0dW6iJBOAcQ5KLMWpwwhPofngghGih//mNt4w34p/hCCXUOuLTqoVGiImm1jbVLGqeINQoD++B3N1bVqJAUCzrMGvUdnGaO2FrbIGpkpEC8bIOY44svX6gR1/B6x/RGNvINWZBioN/BiTL15Tv+UFT7FkibfX0jrxPAEWQnu9tTYs2iQ7estVpIgQDJrEXGMrYXFapM3vsXqsgSCJj7mtfJpNpZt+7KtjFNhBt9KYPYf0SQpkBjpKEsq3YXuCQKFKcEE1UnwcEZq50lLZw/YArqIrnZLNDcD6avP4ZyHNs5Fr5KlSZFo5rJt9gTFsylH0CGH+yXEnMIgpDRYsikuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7J+WcSUJ1r31e7hf/mrFCkYLeNhw2hBOH9Esm1/sbc=;
 b=oVyHiL2d/Bk7ZcZEQgIXFsJgg77pgYI6gA/hpPG+5MYeKR86bRkw1OOfu/QR/8flkLZzmIvnopC+BOP88Phu0+fynd83iQF0OrbswfqMkqiJLNDPya7XiJwlmPMBhoDi2RwZV4oTl1lyWv0vbjsCPNPZDABCz8CRDmVrXL9Aw/JFsZzbv0wMKPMOcSjB0UR5lgj4FhrP1nnjyzmf//HHfjHlaVBHB4dr+ZOPWV10eKwDWpeSzzFe3KwCOqkMUggtf/uT5SL7ufjUPmhewk8eSW2lHvr2/MrV0SHNf53YCePsZN8nMW7VresYKF9lmFjvu0O53lXKUkZvsNup8VG8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7J+WcSUJ1r31e7hf/mrFCkYLeNhw2hBOH9Esm1/sbc=;
 b=XPKfc6cUPhwI3FifcVpxP1xrgc4EdjJd8BjQiowM3Cbd3sHhcrGSxqDX2mI1AGf3p9RBS6evCQxjO/WnNk+Nw7hRzej6aYpP8FSpS/xsfq0oZEix3WlSnrhz6PgWAi41Wuxh6iEPECDkZxx7wTd3F6OE9LF1mdsnAiOYagZ38sk=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:37:21 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:21 +0000
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
Subject: [PATCH 67/94] fs/userfaultfd: Stop using vma linked list.
Thread-Topic: [PATCH 67/94] fs/userfaultfd: Stop using vma linked list.
Thread-Index: AQHXPEQ9C7hnZQsvrUmK0HCksURthQ==
Date:   Wed, 28 Apr 2021 15:36:21 +0000
Message-ID: <20210428153542.2814175-68-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 947d15a5-af28-4391-9273-08d90a5b8396
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB45152DB4858DECEAD36A170CFD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cm+wzhElB1SXMMZdx03PnH48eQsLm+UxVZyv0J6YDaFW47Fel9o4w8ETPWefzDQMaM/BZZul0tRrs2USmaOCJsVAmQQMRxLs4JVRpk3IrovI/sBCdwSf8Vnz11bvFqvogQBctDvxkWlzZACR9LsnEgLQ2Q5Kl1noWS4Tm3rzIPS25EUoit5WSzpa5Ac/Poi9htRL5/wNidBdBWma44o0NwVm0Z0R0Rq5/47K+J57ZWYn1CgHEdx6fwHdAl5azGrLipcXfHVPm3prGl40B3p+rHvg6rvw/NlMSousB1MEvfldacpWpTBrHXK4HAcyogXMVZfpWa+2VqNB+mHzYsCfqFCCIqvDj2SJ2qpb90VBEoSN6xd4mSVNgR6tIGs6t3KX3IZ09px+FC7JSmT+x7fy1SwDQHpx9T0tPbHbaY3EuETG8tg15sDDIRIjdLLMyPIxNQ+D5Ut5XaTUKtZQA8shOgwDDNrv/4nJlxe/V16K2xCoJgCPnNsDduFR8naMO3iBWqd630+hdUXS9OsJKn1v2ckZLDCXMNfOjtXZC9kbSwcdR6LTLIhgQWnl6a561AXPmcEls2hVc+A5hW1QowtXOsbacQGRoUT1bmMA9LBcFy4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?JHNTWJldzNRgmC1DZuwQ0+YSxI514IW4GTWnrCIbA5F6FVR5UmFf3zWdjE?=
 =?iso-8859-1?Q?pOsF3ohEK/sfjxujpU6sGduBjkmFarP95BTKuXz06e06bE/lH02YOJG6a2?=
 =?iso-8859-1?Q?JaBIaeK9gvOjh0Elrhic06J/oq8uAHTycoPDt2/rAz+Gtgwfa9QRK2l3lI?=
 =?iso-8859-1?Q?yzMg7XyXvdxyYRskRnCD5mSTlIZCu70jHyrsdmUJYOQ6dKSUpVdLt5tSvn?=
 =?iso-8859-1?Q?KS6eb4luh1mKZtmwl4GyvqSXYeAF7gV5cVmsDNTb11M0wYbwWsVcouwf40?=
 =?iso-8859-1?Q?ZW99TWf9Iv8WVYITO8USmI4S8ehdNoM+CvxZ6XsZdKzQ38CaMpOa1e6895?=
 =?iso-8859-1?Q?vmrFYGXez7soUUN0TWucxZgaAje7iONHyslAyzXdvPzXqSs1hXoB16yRew?=
 =?iso-8859-1?Q?szU+VdXTQhm/WK136IiR+fZy9GdYbFxnqTZ1wmrGNQ2RGua4rnd82PTSX9?=
 =?iso-8859-1?Q?NRsnfN4iiniedzeBkfdRU4uoSFKxSdtaTbDgcvUtK3Z9HKw5Jjonm/D2Tc?=
 =?iso-8859-1?Q?JoGjH//Tlgo/iropO4QiTsa/r05pu11glw+2kSgxmsKNb9oM/4yWiYx8Vf?=
 =?iso-8859-1?Q?40Ujg7M9MVmmz2UhygNl68fK0niuvoq+0zG2r7BxBYOp4eLi+epHlwwDYF?=
 =?iso-8859-1?Q?lebNWtobYQu66DjRBqxFuln+KabedJ/oAcfJHmiYJ58yc3FOPwZky5wFig?=
 =?iso-8859-1?Q?nNu1Q6vn+Nd+baefFP77Rfo+8eF1XNGsUEJPbb19f/8mOI8sMUFysC4jw2?=
 =?iso-8859-1?Q?vXT5LBG6sDEHXULF/bWqrQiIdVu3U8xEdgvDJtfPbayfBw4N4YkH6JZ2+D?=
 =?iso-8859-1?Q?+J6/bZDq46DYoym+2i4aSBhNwckXFPPcco8QG6jn5L48wHBSFlXCR2UzBm?=
 =?iso-8859-1?Q?LkdMTkBC1zMqktWx2YqkVtdovc5h80sHVWCxFSAWS8Ty9sN+sqLb0BjMqy?=
 =?iso-8859-1?Q?N7yvW8yrzjmQb4tXf+x3S6r5l4CFv+Mj4r1u/CUgKxOOvdlZV4h901n6Pm?=
 =?iso-8859-1?Q?YFptKM3QXkNjlJ/JDHBd+T8aWlTUlttpdKnTtmS3X3EYqcrUpv6hPVjJPo?=
 =?iso-8859-1?Q?+uVUzbeMeLPT17+L7mUk7iZRFm18opqGSAkLYD9XsTo75aCM7cnC6fKVdW?=
 =?iso-8859-1?Q?vUSfaToL0dUkav3JNxfc/6C8QSNexmyiYdc4UOqmJgEr64RS1A4cR4E5Pw?=
 =?iso-8859-1?Q?Yrtop+CODe69mKWhwH6/mrFslT4JNo3sGwHE/5KciZzI1I/VmYZxjDDTWM?=
 =?iso-8859-1?Q?PbJYlEiDl6ehsQVfCIMJuOakIQtAwFeKUYNU+vdSy4btAlfhpSjMQspL01?=
 =?iso-8859-1?Q?go4XjValIJOmSGN675DXU43ir3eqEcu8UXcq6uXh8ifeuaQuBSBeoXDthh?=
 =?iso-8859-1?Q?lxX1uB2PAK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947d15a5-af28-4391-9273-08d90a5b8396
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:21.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qc/BiNNK6wl3r9Wa4vNzk8PJT0MiPgvqSdZNx0pyZ/6aNDgFkLjiD942mKYD6usT+GwgWfOipkUPT8Skfs1D8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: 66nSosG3hAUzQI8GCmNtbsNBRo29BUMG
X-Proofpoint-ORIG-GUID: 66nSosG3hAUzQI8GCmNtbsNBRo29BUMG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use the mm_struct linked list or the vma->vm_next in prep for removal

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/userfaultfd.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 14f92285d04f..1fd0f5b5c934 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -605,14 +605,18 @@ static void userfaultfd_event_wait_completion(struct =
userfaultfd_ctx *ctx,
 	if (release_new_ctx) {
 		struct vm_area_struct *vma;
 		struct mm_struct *mm =3D release_new_ctx->mm;
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		mmap_write_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+		mas_lock(&mas);
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			if (vma->vm_userfaultfd_ctx.ctx =3D=3D release_new_ctx) {
 				vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 				vma->vm_flags &=3D ~__VM_UFFD_FLAGS;
 			}
+		}
+		mas_unlock(&mas);
 		mmap_write_unlock(mm);
=20
 		userfaultfd_ctx_put(release_new_ctx);
@@ -797,7 +801,10 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma,
 			   unsigned long start, unsigned long end,
 			   struct list_head *unmaps)
 {
-	for ( ; vma && vma->vm_start < end; vma =3D vma->vm_next) {
+	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_start, vma->vm_start);
+
+	rcu_read_lock();
+	mas_for_each(&mas, vma, end) {
 		struct userfaultfd_unmap_ctx *unmap_ctx;
 		struct userfaultfd_ctx *ctx =3D vma->vm_userfaultfd_ctx.ctx;
=20
@@ -816,6 +823,7 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma,
 		unmap_ctx->end =3D end;
 		list_add_tail(&unmap_ctx->list, unmaps);
 	}
+	rcu_read_unlock();
=20
 	return 0;
 }
@@ -847,6 +855,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -862,9 +871,14 @@ static int userfaultfd_release(struct inode *inode, st=
ruct file *file)
 	 * taking the mmap_lock for writing.
 	 */
 	mmap_write_lock(mm);
+	mas_lock(&mas);
 	prev =3D NULL;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
+		mas_unlock(&mas);
+		mas_pause(&mas);
 		cond_resched();
+		mas_lock(&mas);
+
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
 		if (vma->vm_userfaultfd_ctx.ctx !=3D ctx) {
@@ -884,6 +898,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 		vma->vm_flags =3D new_flags;
 		vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 	}
+	mas_unlock(&mas);
 	mmap_write_unlock(mm);
 	mmput(mm);
 wakeup:
@@ -1288,6 +1303,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1326,6 +1342,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
+	rcu_read_lock();
 	vma =3D find_vma_prev(mm, start, &prev);
 	if (!vma)
 		goto out_unlock;
@@ -1351,8 +1368,12 @@ static int userfaultfd_register(struct userfaultfd_c=
tx *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	mas_set(&mas, vma->vm_start);
+	mas_for_each(&mas, cur, end) {
+		rcu_read_unlock();
+		mas_pause(&mas);
 		cond_resched();
+		rcu_read_lock();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
 		       !!(cur->vm_flags & __VM_UFFD_FLAGS));
@@ -1469,9 +1490,10 @@ static int userfaultfd_register(struct userfaultfd_c=
tx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
+		vma =3D vma_next(mm, vma);
 	} while (vma && vma->vm_start < end);
 out_unlock:
+	rcu_read_unlock();
 	mmap_write_unlock(mm);
 	mmput(mm);
 	if (!ret) {
@@ -1514,6 +1536,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1557,8 +1580,13 @@ static int userfaultfd_unregister(struct userfaultfd=
_ctx *ctx,
 	 */
 	found =3D false;
 	ret =3D -EINVAL;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	rcu_read_lock();
+	mas_set(&mas, vma->vm_start);
+	mas_for_each(&mas, cur, end) {
+		rcu_read_unlock();
+		mas_pause(&mas);
 		cond_resched();
+		rcu_read_lock();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
 		       !!(cur->vm_flags & __VM_UFFD_FLAGS));
@@ -1575,6 +1603,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
=20
 		found =3D true;
 	}
+	rcu_read_unlock();
 	BUG_ON(!found);
=20
 	if (vma->vm_start < start)
@@ -1643,7 +1672,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
+		vma =3D vma_next(mm, vma);
 	} while (vma && vma->vm_start < end);
 out_unlock:
 	mmap_write_unlock(mm);
--=20
2.30.2
