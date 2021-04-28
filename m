Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B825036DC05
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbhD1PlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:41:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35860 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240375AbhD1PiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:24 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMtdO020250;
        Wed, 28 Apr 2021 15:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ayb7s8f+Q/11rIB1K4s77TXUY/X25NVmEsrg+PwcYTI=;
 b=tczdzyeOUVAzOBtZg4blImp02WjJgm9LNe8mDIHpWen44DmODYTWsilGilJe1LlM4qvU
 mLUATBsLqYn7RfDt0FjXO8rxcmGiLS2YWQUmzMtLFnsjC/oOzyx3UpXLZoZXBR1wVSqb
 D7Q7CzQXu3GXc4ygrEiAUpgpVbjg+CD+2N4i7z64r9hsuKl4sI484jF5jzHDBHE6W5bN
 utcC+lgrR1PeC5wzoiTsSJDriFaJIN2yPt5lO7lorzUQs6FRv41sPZIMDL9YpdZu+rdo
 GlKgKVU6ntDYUPvXp0tOxdcDQndYewLtG2/zQthsN94nlVtcFjmY/Q2kwTPtAytivdva rA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg52u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:24 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAxE018431;
        Wed, 28 Apr 2021 15:37:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3874d2763b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhH4+Q4GHQuqsY3n+BiFmzB3/N18AL82Z+jywyuqfqaDvHNwXk6cGZUxdVnzGuSBNM/byEdUBFh8onHqllXK5FgOPDqk+bEcRIdFfgdMDsE7QNN8BCZ19Ix2lXr2nUfBsWlEZU2p3oGaOmrQlK9YIcmniBwYH2PlQikSKKmFqTCGZZvmq2RPfvDuTN3qEQVcyOsTBhtQrCLiwiH1vmz3/rAai4rmGyjOD1dJICSGa0cWJamCeSkVUQG0ObZCVZ436OwicZ1Z25kyRbYvyzGog46qBDfkXFvt7ZlWXUfVdiSC3pedDgeMnDyLIBOVjky569xZU+EQPL+sqST5Bme/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ayb7s8f+Q/11rIB1K4s77TXUY/X25NVmEsrg+PwcYTI=;
 b=Ius+B5bhlYzCUsj1djJr/N7bGHTTL77FvvJuHmfWpREqqTMzduQP0LD9GS+mxTW2AAaNGQclZLg6S/kjPqJqAV6atX6THIIxTtlG6Y1TlBUIMy1thmN7MXFHNLIx1zckpIdsCb7vabXOgkCwNkS6bJie1oPGggnIpiMkTN91jqv+rzasRb44iZmlVo3bm3YIsRBFYKsxZ0rJhbIpcCunXAaVro9+qDtD25uhH41gcehn2yrR0xfuDTGmmrUorEaaCwwWUeJTLlYaQv2sKAHRlNwNCBdSUor75Bf31hhSOajW3/r+uYE0HHIUEeFK/N3+Bz+KGWbcuEtVfSXZUq6TyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ayb7s8f+Q/11rIB1K4s77TXUY/X25NVmEsrg+PwcYTI=;
 b=uVGD8d9O44H/bKnqhSOr02cv9q/tWaEl/sNpFAXRQYw3GScwLuk/FQqEiEEv1iFtXGf0WnHdLOQ6VUCQhjDddqdrE3pXW4oGD1R7KG9/DyjhFUc+cXW0a9nbREL052iupYdK1KSoc3f3mj0La+DTgjAq+2aHqZImdInkeJgXvoc=
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
Subject: [PATCH 66/94] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH 66/94] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Index: AQHXPEQ8/XMOfQht/0y2Sh23XT1RFg==
Date:   Wed, 28 Apr 2021 15:36:20 +0000
Message-ID: <20210428153542.2814175-67-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 722ceb8d-12e3-4c01-82c9-08d90a5b8368
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB451577AA21AFBA6D280563C6FD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hb5WhUfFm+b/hurV34ZCRHHDML+bLEQoH/2TxX+uhHWCvINeXu8FoRr8f2KND3Ew/NpoAWH4uiAh0k1RTtWYa0a/cQrdPEZ1d9t91l26uOp/683iFGBK5DRmUdxVdoDB1W5mYqHK3NCdNpJDbh0oiOPhnvvVr2ho+PlG055Bb4kVVNnjXyg+aEWAmLjDKHO2rMqXnyXDIenWAYVuwvmO0KZ44p4MSxW3QzqudlP29sJHfG5M6D+ul1q0MHoz8sG1ezU6ijRp0sAK0FpS9ekY8Rb6Ukfv/eqiRd0n4L0Ysn9IHtBWb/J5mlDNSamEHhvDZqcB1aSz569G1CrSIabxa8ZrYILIjzI9mmnAUJnD46kyW9Qk+KqCMjPthVgcIngw+ADJ573dYk1mDnF5w/SogZJeT4Mj993tqNVosdtJs6wSRVSZ+pNJOZ33Ym5kj9a9eguL73ewr3XNcJCOafekl7A5+mIbhbxtf7guqAvdHeBE1hQfCb0T2E229ym6029UIesJBTUstG9kzsP/2Ae2zPdy1hxN70IYB9ONZ4vca3q+mGmxbsKC3nW6MR+aiSW1Po29AiOTmT99Mli8+SkIt8sSBTDPQnu8rlz8Zm1r1OU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?G6tmSk0juYey0cof1FelcvZ2SMjiypKhEnyvfOMlLFdCz+fDxl4kK3V9Zx?=
 =?iso-8859-1?Q?wGZCpHIlE6jy/FyJwLor2UbFG/M3D+fi8nB2U5BK+vXwXYd6Jf5VNBMNoR?=
 =?iso-8859-1?Q?1ZzNpcYCSeK2YSGbQpMED0HkSeZOG40VJ3rUAr650Og216THNIPJMMU/Oq?=
 =?iso-8859-1?Q?R1fp4Y84EtLZpFZsrzDmq6IAGgz9PzgkzLsMtERumaxBQeB/mx69Yd8IGO?=
 =?iso-8859-1?Q?DcnW97isOcoOS5PI4iA/uf2L8cTvU4FMKVnbZhLHcNrCBLVS04YcywViZ3?=
 =?iso-8859-1?Q?ns/L5U3zhP/7eXbCXVNfHieSjUSqAras6tEc7DuLAdw79yxkPjIpxJRb5F?=
 =?iso-8859-1?Q?57ZZmvAXRbcAht8baEJcPGPaDimON4HS6teIyqS9ZYMT1TwA2HmKnaXwwu?=
 =?iso-8859-1?Q?T+VrxSq9R/Z3v0q0AYKnipYPrnp41HEj8TIendIPfuaaQHST3sbKbKs3Hu?=
 =?iso-8859-1?Q?VaYgHopsJr8B1/RrBBQYulir90dW0kX5JaWxhdHMDajfxDJHyYd9vGdtXM?=
 =?iso-8859-1?Q?fvVckC9JKio1Y11KNPXhr+//gQXiqzwUA9i69bel6nPq4xf7UrgGXr6e3f?=
 =?iso-8859-1?Q?bVFWJT0p5QpZJj9yn0Eg0U+agljZOdk7lwn837a0mSMb/SFMSskqP/XKG5?=
 =?iso-8859-1?Q?gJCw9PEHDbESdeJcXTZLmdqLcbP1OCubTB0ouH4BHYxr7dn+TKFw1c4BFJ?=
 =?iso-8859-1?Q?nSzyZqo/dHs62kk8aSL4OTJhnCwZcSPlcOkhqp77lrra1iWtnu+0KKNByn?=
 =?iso-8859-1?Q?Y+8zBp761YcPnWCWSdif2X0HMGM2/0pZUz6UdFD8wLqCMM+D9sbJxP4LMH?=
 =?iso-8859-1?Q?crnz4DDfQVb7ROvHoIdpnO2/0y5xQuPHkSv6uX5AAhyuMnOv20bZLO6QEV?=
 =?iso-8859-1?Q?WZf9NhmdzNA56+R2EfFUvL4debWv/tVhHwYKIirHjOtWJsZA2NnWhU1rHx?=
 =?iso-8859-1?Q?xTNManv244Tie+vDnnxPTzJW4HsFvKBYD+wYK6UJwANyfJk4jNzHPqLUXq?=
 =?iso-8859-1?Q?LnXVmbS//6/BORuBSaf2OPFsV0XjCraY8L6qezdj2QEkVNr4Zx85I4DqZj?=
 =?iso-8859-1?Q?wIsRhTCVn2EnITjloT4vPjVKys4tRw07X5Rekhd6wUV/Pcyl7MI6gUIlpD?=
 =?iso-8859-1?Q?I7eCfG/OAznDMLR1/PZPkgGu+Q+vQ08ufH3x9ZIH2TsZJEBnhkXmNWd3Aa?=
 =?iso-8859-1?Q?wkYLX6UFQle3xTYlSdLGacQ2nD3eqkrtaufAkUTAxK6NXzsd0ru99umSqK?=
 =?iso-8859-1?Q?YGInlLH34DEGG0Vjvgr9WzZR3cUQjmz8bjaxE/+MV8hVyb38h1V6p5r1lm?=
 =?iso-8859-1?Q?a9e5jNWbfVEsm/h4w+UFu3dUpocUExk+/uqneMSgm6bUWIA4yPROAEQnGD?=
 =?iso-8859-1?Q?ZWQT7eDfT3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722ceb8d-12e3-4c01-82c9-08d90a5b8368
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:20.6949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OU8Cpo4eBBApbvLahDaT1eawZmttwWrO5SyD2TtDGriPScCPSC5Fx49F7JgV3jsTDxZysL/EHz3mfXmMFoSuRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: 51pzRv7ucTbo0bOj7siGC_b3TjFDAPoY
X-Proofpoint-GUID: 51pzRv7ucTbo0bOj7siGC_b3TjFDAPoY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove references to mm_struct linked list and highest_vm_end for when they=
 are removed

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/task_mmu.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 503e1355cf6e..f7ce3cc60cc7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -164,14 +164,13 @@ static void *m_start(struct seq_file *m, loff_t *ppos=
)
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
 	struct proc_maps_private *priv =3D m->private;
-	struct vm_area_struct *next, *vma =3D v;
+	struct vm_area_struct *next =3D NULL, *vma =3D v;
=20
-	if (vma =3D=3D priv->tail_vma)
-		next =3D NULL;
-	else if (vma->vm_next)
-		next =3D vma->vm_next;
-	else
-		next =3D priv->tail_vma;
+	if (vma !=3D priv->tail_vma) {
+		next =3D vma_next(vma->vm_mm, vma);
+		if (!next)
+			next =3D priv->tail_vma;
+	}
=20
 	*ppos =3D next ? next->vm_start : -1UL;
=20
@@ -844,16 +843,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mem_size_stats mss;
-	struct mm_struct *mm;
+	struct mm_struct *mm =3D priv->mm;
 	struct vm_area_struct *vma;
-	unsigned long last_vma_end =3D 0;
+	unsigned long vma_start =3D 0, last_vma_end =3D 0;
 	int ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	priv->task =3D get_proc_task(priv->inode);
 	if (!priv->task)
 		return -ESRCH;
=20
-	mm =3D priv->mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		ret =3D -ESRCH;
 		goto out_put_task;
@@ -866,8 +865,13 @@ static int show_smaps_rollup(struct seq_file *m, void =
*v)
 		goto out_put_mm;
=20
 	hold_task_mempolicy(priv);
+	vma =3D mas_find(&mas, 0);
+
+	if (unlikely(!vma))
+		goto empty_set;
=20
-	for (vma =3D priv->mm->mmap; vma;) {
+	vma_start =3D vma->vm_start;
+	do {
 		smap_gather_stats(vma, &mss, 0);
 		last_vma_end =3D vma->vm_end;
=20
@@ -876,6 +880,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
+			mas_pause(&mas);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -919,7 +924,8 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D find_vma(mm, last_vma_end - 1);
+			mas.index =3D mas.last =3D last_vma_end - 1;
+			vma =3D mas_find(&mas, ULONG_MAX);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -933,11 +939,10 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
 		/* Case 2 above */
-		vma =3D vma->vm_next;
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
=20
-	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
-			       last_vma_end, 0, 0, 0, 0);
+empty_set:
+	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
=20
@@ -1230,6 +1235,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1249,19 +1255,21 @@ static ssize_t clear_refs_write(struct file *file, =
const char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+			mas_lock(&mas);
+			mas_for_each(&mas, vma, ULONG_MAX) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
 				vma_set_page_prot(vma);
 			}
+			mas_unlock(&mas);
=20
 			inc_tlb_flush_pending(mm);
 			mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
+		walk_page_range(mm, 0, -1, &clear_refs_walk_ops,
 				&cp);
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
--=20
2.30.2
