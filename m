Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811E4421C11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhJEBg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61412 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229612AbhJEBeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:06 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951Ooio023948;
        Tue, 5 Oct 2021 01:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=V5qpaCz/mr8CT4B2S43tOfxGzkL2jGk0OwfTrdxVPZ8=;
 b=aNO/CCohT23d337zBef8aKdGiB6reAInUkEphAdYcV7SVg7J96IeVGxlMbX6yrg2yaUA
 Le5zsMDLFRj1wclWNSzUM3mkv3WbEKrLn4XwF5Pfp8bSwHf+A/Al5OP9/OskcWtPwF/g
 Rz16pEkOtqHWWYCxZoSu57+mRMp69gkRPxKDD82JANirE98vvG743wc+1UNIRDseYpmb
 k3KaP5RKDhIKi/AjyZMZkrjs/g5bgm3//20c+Mvl8HDnQZdx7FU+DIUsa1nr2OVMu2uE
 Aqmgy1BEmor6pumqMgzoKaK+rXNUcXDoH66yWj1BbyAqOlcM6dZe8F8RReU/861+NgHb iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43gkph8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3q056799;
        Tue, 5 Oct 2021 01:31:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGJGPOSPjDBTQHTTfzfzB5EU/rthn3ZBl/Mey41W3gWPIowdN4I+yls2jTNwbXtv7sW3isf0tZdaSvnHuRNheuZONM/sniSsWC9lK04PCzsw5NWbYZYDzxwB3Sv6sLFxHhi1yJTCvcAyOCfW0vV0gUzcE7YhC+YkpfMtH/EpJF4N83qUXlnUQMPLJie3l6N9ZWJDxzzIfhv3dt+Cx+Lgr1YhDdZye0C7671DAfCL3zdBHe+4XJVuzGVsL+brL+GM6vShnUFiPcKYJ5xjP18MG6j/+t36uXfCMgBiOC4vwlHqrI5d5TKt3jOFCK7av0/wINcncyialZU9M3IoD4XkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5qpaCz/mr8CT4B2S43tOfxGzkL2jGk0OwfTrdxVPZ8=;
 b=gfO0M8Vu3KRFSFsYWgBsUqxALpA1e0eptL6QUVmOllQpf7Dv+hTf5j1nxl6azot2/mGRsaiRsn+zVBEoLg9xtDdPmzQBvEnWBPWGuntUJlEvqICJTPP6dApVf8tRGmPwflZ5J6NdkSY34951m+jCOOOiPe7KWZPn+hY0XK9qrq7GMuZcBNUUKklnDsyR+bzMaF1Udjxu1Fv5a9EoIc6ms1rWkjMMOV2tFVUHosU8oNlIdpQ3DayqZdwEYMYQrO3MjzLWQ1M64PbXyj7z1P42nKkC7sPNEIZfRYAkPwfPohqmRbc1k1fu1kMWhD+fEC0EwZp5KBEb5AKJDeWOQIO3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5qpaCz/mr8CT4B2S43tOfxGzkL2jGk0OwfTrdxVPZ8=;
 b=dx/jByQ29B9U0QkU5tLuHehYBV0y9NdsfM20bi8bppJxPvNgqy7xPt9jyg8buMjUuwELMTkxn91P2XAi+Be07/85MFYCgQF7SDr24mgHJ3uheeFLjssrTfpwQ4eLf3ICrTXzXAI8aI+N/QvOVS+Q1TBeLYoPHgKrMtz+6Zd64P8=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:22 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:22 +0000
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
Subject: [PATCH v3 39/66] fs/userfaultfd: Stop using vma linked list.
Thread-Topic: [PATCH v3 39/66] fs/userfaultfd: Stop using vma linked list.
Thread-Index: AQHXuYijZR18QGOVckCImC/Z6w8VfQ==
Date:   Tue, 5 Oct 2021 01:30:53 +0000
Message-ID: <20211005012959.1110504-40-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 7dc322b0-0428-4cc7-c74d-08d9879fd6dc
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044BC67DED2698F2B364252FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bk6p1mbJYFOZcrQeWVEfUWdVlOnAOhiiemxvFrAfbvFh2r/eu2D3AKBVJScAWT4K+xq49MxgY6uLP9KMp64387PjzSnm2yYVgQvFG3V6wacbf51crtTafINcX9b5yxFvUjdzVfYLzBm/JlTV7Q34imH4mbwVLyLp6J2j3n2CVTPz9WyIGWXX+286JjIH/x6NKdtfwzOeg7ksj3lhGyBFYykrqCbiPQxOinezjfTTYOwke3mAxWPcROP6n15JE2/qVma9eRePXemmWXIS7ehMcqoo00y2HGPOPa5M0OIWrorH1gq8nqdOvw3BcEqJ/g+wTccAoMgXlYmZqEY7tEe/V2Gi2+vOGivaHzL9ZmQn+UAVHIE6yDDtGQAaQ2fKoIrgYDO6RdGtNHTedZ0iaf/ZlPelolRnnyjXMJnCskiCVSnKLQwWLiJ4j51IynRKRYmEDh2FtgulIjctwXlbWV47UGK9lGINXY1rEVHoykpC1HUcUyfuzHVv9cpF/B0FeJ4mRYXTSIr+nNwyb0OMvy4xeT1NccOCd4vWCZK8yYsORNXUKwscGclVWIsLaefzD7z4lJ92skAZfqBzVd6NEZozHGlRwgmNXsnKOyNtz+8oPl8lIYDpNjXJtWNIgYOByyKzAxZf6TX1omnjMa7Brl0ILltJjjgLDzvwMNaWMATRO2GvnCvuIcHdjLaLt0unk4xCzzQjvRJ6gJrSYUWB9PZjQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KVDHBCex7kylyeru821i8OkKmikBI2KjuSiWjV4Ai6e0QUtGIJoAuiOmsv?=
 =?iso-8859-1?Q?ll5j+YGc21HSVQsITjE9djbz6V3CI8hCYz+H9ps1nwMGJPoLmqYJGZIxOr?=
 =?iso-8859-1?Q?3LSSuA8Unlv/V8/Rq1LDtnFcAJTFnsWdKsL/pCYdkFNDY71SqqNC0lvRHy?=
 =?iso-8859-1?Q?hQt7+/PZg0UsvH8J8HF3SHGIl2U/ut2PGUb2AG/2wbbLSDCswi/NEtUxDw?=
 =?iso-8859-1?Q?kd/nfHtbSTxa0OvcvCVRm3w6SOusEpzUXbssyk6e/+JHtoq8knUMaOgFex?=
 =?iso-8859-1?Q?FILvUtZ94ruq2J+z9QI+wuKoaYBt1AmUczB8KqmxgBzE/6ucb7jaCCOcpB?=
 =?iso-8859-1?Q?AKpFSNvRKy/xZ6xkH8mKRa3y/Kpk45yvBEbOD8E0TZQxq5AKZAARDIG4Gj?=
 =?iso-8859-1?Q?OP4vGkZrF/qN7U5zSA80NSZAMYSD62c4f3ZuEouXd9LicIFK9jaMGohoit?=
 =?iso-8859-1?Q?EtA+jpCgzw9m9FGiJIpsRbimvDh5H9CpeF5yn0fJcN9bF3kjmunagAjocT?=
 =?iso-8859-1?Q?HI9gCoSVwyoPeD/My58wlPOouHNHg4Cr7ahAg7j4Gcs0no5UyGhmC8xWQt?=
 =?iso-8859-1?Q?a9DJyZJkZhpkbv+LXkNmKxx9OkBhfzdrddEr40unv6v9/MUCba7ASjWOeI?=
 =?iso-8859-1?Q?4LiZxTiVgOJdl6E5+OI/pp0ODhf/xTLQDeVteQq2ZHhKjSpoixa/7USNHa?=
 =?iso-8859-1?Q?X20AFw73smzX8QxmYUvuLsImzVQVyCKDBNTW07AoXkQT+VdtdrWPpdNRmS?=
 =?iso-8859-1?Q?znPwtJpvTbWFWdygruVxtOnMCdqeD3of2MbcxlHHeRozrNxqiMm+0nEroi?=
 =?iso-8859-1?Q?fH4kL5ndeeWWQUxhQRyBqK+moHT8U7cgYXlsv071gruNmnRosMYV8fclgQ?=
 =?iso-8859-1?Q?D5rHDlh6y/j6Y9wsWOrfhrLV35Oh6Kcyk1KWq4KjmenhVY84M7CiSRCTo2?=
 =?iso-8859-1?Q?E46EzwiPRXfwQsyt+bPb82cgV2OY/SMtMjraFgGkSrPtdUz2R09cMvdvjs?=
 =?iso-8859-1?Q?wXdLcpbOz23+5LsOO0mjaNFJ9fxCbtV2w4z4CTx0mmxFo2XyhvowM3t19l?=
 =?iso-8859-1?Q?LVxsD97axYxSTVaEsUk3Y2siIbznfMZaj3aaRgpxvV3l2KE5YEpfxIimFt?=
 =?iso-8859-1?Q?b8x0PzVs911CYMkJ/QE7fBb8EoPpOBHBSXou87mBrt2SIMZr4ECZC4Sodr?=
 =?iso-8859-1?Q?IjD1CuehLLUMks93Aaj+bwPCQ86o4i33caV1eQsa00fCb8OU7won3380C/?=
 =?iso-8859-1?Q?px1aUQtF2cBe7wSUR33ot0MVFHOxnILR5el2ZKt+RHbL+LGTOWK+40QGR5?=
 =?iso-8859-1?Q?x1FXzHnDFNe3l0uc7Zl8YdjqijODJ5TUaaLT30E0dFuJeigqGu7QdZduY5?=
 =?iso-8859-1?Q?vvgnOJ4hmH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc322b0-0428-4cc7-c74d-08d9879fd6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:53.4693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QCvqUQ7LqVFn5FnMzZfD+htxdWvsdxYTFwDY746LIOrhEJfqFtpf0n6WbjW1pSwxdrsCHR3uV9ySrG7nGLcnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: 4vPbTnq9msns1Oj9RshWAjZgW4pDuO6e
X-Proofpoint-ORIG-GUID: 4vPbTnq9msns1Oj9RshWAjZgW4pDuO6e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Don't use the mm_struct linked list or the vma->vm_next in prep for removal

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/userfaultfd.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 003f0d31743e..bd181f922999 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -606,14 +606,18 @@ static void userfaultfd_event_wait_completion(struct =
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
@@ -798,7 +802,10 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma,
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
@@ -817,6 +824,7 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma,
 		unmap_ctx->end =3D end;
 		list_add_tail(&unmap_ctx->list, unmaps);
 	}
+	rcu_read_unlock();
=20
 	return 0;
 }
@@ -848,6 +856,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -863,9 +872,11 @@ static int userfaultfd_release(struct inode *inode, st=
ruct file *file)
 	 * taking the mmap_lock for writing.
 	 */
 	mmap_write_lock(mm);
+	mas_lock(&mas);
 	prev =3D NULL;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		cond_resched();
+
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
 		if (vma->vm_userfaultfd_ctx.ctx !=3D ctx) {
@@ -885,6 +896,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 		vma->vm_flags =3D new_flags;
 		vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 	}
+	mas_unlock(&mas);
 	mmap_write_unlock(mm);
 	mmput(mm);
 wakeup:
@@ -1281,6 +1293,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1323,6 +1336,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
+	mas_lock(&mas);
 	vma =3D find_vma_prev(mm, start, &prev);
 	if (!vma)
 		goto out_unlock;
@@ -1348,7 +1362,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	mas_set(&mas, vma->vm_start);
+	mas_for_each(&mas, cur, end) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1466,9 +1481,10 @@ static int userfaultfd_register(struct userfaultfd_c=
tx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
+		vma =3D vma_next(mm, vma);
 	} while (vma && vma->vm_start < end);
 out_unlock:
+	mas_unlock(&mas);
 	mmap_write_unlock(mm);
 	mmput(mm);
 	if (!ret) {
@@ -1511,6 +1527,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1529,6 +1546,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
+	mas_lock(&mas);
 	vma =3D find_vma_prev(mm, start, &prev);
 	if (!vma)
 		goto out_unlock;
@@ -1554,7 +1572,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 */
 	found =3D false;
 	ret =3D -EINVAL;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	mas_set(&mas, vma->vm_start);
+	mas_for_each(&mas, cur, end) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1640,9 +1659,10 @@ static int userfaultfd_unregister(struct userfaultfd=
_ctx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
+		vma =3D vma_next(mm, vma);
 	} while (vma && vma->vm_start < end);
 out_unlock:
+	mas_unlock(&mas);
 	mmap_write_unlock(mm);
 	mmput(mm);
 out:
--=20
2.30.2
