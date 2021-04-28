Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBD136DC12
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbhD1Pl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:41:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18678 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240322AbhD1Pib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:31 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFOV0N009944;
        Wed, 28 Apr 2021 15:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hDZGmBnLFoZxTmxMTUiWr9veQjpQ+jihztD+Qaqbejc=;
 b=g1XxAYqbuMbj+YqUVp25u/RjxzZvA2FJ5ZStBqUVwXrvH9lMsxb1kRUzo718STlpJROZ
 A2qVqAfMCpWYk4eChi5oHS2DhyFIoXpAgVZQbHoiuoYJpV/bo2e6nW2aacj8hFEH34WB
 TWJaS8P5u/8V74Ak36AomiKEIKnSU/w4KJy0F743LQwjykO/K9pFpbFUnMqTK07jE/Dx
 pzs93PJtFGQIdVrrB8B4180IVr2cWOmmb47ex2MaBm1JLnuVGBveSf2kznI95SsFfZbB
 rcZ+ByCdO3diZ5fJJFteF1w6eJQhk57wLINGOf7gU2kGbZyELuSji/L5E+jWRbGSaUwd ZQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 387a2mr0vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:23 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAxD018431;
        Wed, 28 Apr 2021 15:37:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3874d2763b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrsBD/Pe1rcnXafLpcRiaIk5SKHfyAKO1LA3VQBvpoGyePQVdrlzrHmKUTwvXKxRmg6c1ptPdEqfVz5ac4aqKY0rnrNMo6PxTIHaKlsU8xKXiAHdTOfL73dDZsu1LTu4IReLhGUNHw7IbcI5xiDN826CEFa9MMdwqTNYjGWeyCZOkVyXu5Z/X6RGWv7zoIoKTQv8OTvNCVhHjuLfK3xPIDjmty1Q4wAVgvSnZbwO2N3aecFFMx+tVWdF+iTmU4rgh1ZT7v7rMqCmXCLgL/kpOB0tX62X6AAox9qHuCrVC6rjZHqzYLjQiMyRySkGlQUIE6L+9T4OLCpegmWtwzg/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDZGmBnLFoZxTmxMTUiWr9veQjpQ+jihztD+Qaqbejc=;
 b=j5LeVUtQ7wcuSQ9dRJt7bjHezLFTrm3uGur2viWH6aZY1IJozj83AgUOVS9Oinqlx4sTPR1VsjRehFoD908BSRq9Cdk1xTuNpdAB46CXBgSWqIbnL5igKmob767LQ+fQ2m5HDTyMPRH+P5vH6ohVM0oOBh/lutTxps41kjQKrphOtv7wjLh7Siy9Cnr2uHMer1JACnZYWw36G3ZNNZwdr9fcMJecm5uMIWg3ugoB1qRA52Ldxx5+RYo7b0PoZUB0l6LvhTnyUCji5UNGXfbZBQoKlLEf5r0lNBgaVZMtwQwPlbvaSbL3IHEEznuoCfWhJuB5j5KYZ6Qb6Ze3kd6Xkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDZGmBnLFoZxTmxMTUiWr9veQjpQ+jihztD+Qaqbejc=;
 b=ftOD290a32QVqdnykt+swAikMn+W/bVclls05oRPUWj+WBkULWD9FrF3C30TjeKU400tqSK1H0Oh6b27e/vsneNabMdm8lktHVXGyW3KskuaXwjceCvFRi917rm4ABEc7FsK6iyw/Vf18yPN9Y7AMTBu3kM2ZCJTqS1rTbfTPOs=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:37:20 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:20 +0000
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
Subject: [PATCH 65/94] fs/proc/base: Use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH 65/94] fs/proc/base: Use maple tree iterators in place of
 linked list
Thread-Index: AQHXPEQ8zyjRZowth06UYfF/mSRZJg==
Date:   Wed, 28 Apr 2021 15:36:20 +0000
Message-ID: <20210428153542.2814175-66-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 78829a82-7ca0-449a-181f-08d90a5b8337
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB45151FB058C492FB27BED87CFD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BGWXGLnzPuTxzVTIf5UrPidgfcKeE+ppC1mSEb3chUyz3dy7KtRyE5kvEta703q5B2R7VA9+fiotn6s6ebqU/gkeQA0C17WCXfkmHlSF5cVSMyHdtWX8hWd7KLBBdBCsJy3Ug1qmL72GsuxUP2yCYjD9QnoPbR27GKZ9zjByNaDBEOW6PjPNlBUP7Hqgn5jO9za1oGGBBPsz+LvRm3ODddIVJh1FEbKuXvNxWPCCprEsCkJKbf+J0I992z8MPloS+uYSsoRLd3UaIcggpV7fjNQ6B1ywsThmyyKerRRKlEAMG6wca0IR+fBP/NXhYUWlAGoqVbOwXkUU5QaDxlWP3ydOOHQHlp9vBQxwFFpZQtNEtQXTM0BiXG/hUueQm9uKKYZ58RxXhw+F9XXAEaNSrjVR2KmULZ9MbHBxUxUM6+6A0JGJUNgFXOKWgosSRqGrC6ZY3MKpvOAvr2Epi8a8QZjZEsPWVjMVYTA1o5XzTwETuQWfXwJFXsj+O5Ry9kZx1T1iRENWG0Zn4DIms1I264frryV9+Qqa1sljt1S5tacH4znVzS2ZK67KUIbf/LiV2ROXBTyKLfAL6L4E7tbzy2UlcAGAFgCVz8hOEQe0+lE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?suR8/gskPxNF04b08B3HiL+9LwwdfnNTBZ5vU2619Y04SGq8Cskl0pj9QG?=
 =?iso-8859-1?Q?NzT0StEcmr9P7tNiOPO+dHQxFkJ3MSw1vKyr483rAihu5kc5qCScPA3gQy?=
 =?iso-8859-1?Q?hmP3jNoG4m/vhGTTW9zROmL6pS8UqyzZwX+I1dAHKmuXMxoezcYcc/Rjpw?=
 =?iso-8859-1?Q?3tM7xMTnBihu7N/bIBPnfsAFMUHURfDCS10LZQ1v/gAc14kt0juZT+VrO5?=
 =?iso-8859-1?Q?OsZq0wwREW21Atup5tJ3qh/aBtArtKrBKljG0PnT9oTsXXqGOaVcFSTZl9?=
 =?iso-8859-1?Q?fchUDpLVgrWjoPW2Jv8gUNRBwJ3D099xY35w3vgq1Ox60HdEa/oySHXxun?=
 =?iso-8859-1?Q?Caq5LPsZCZZNz6LMaaFPpSLSQUCUeYY9bv/O5RC6XtUnGrqnPSP0L6u6W9?=
 =?iso-8859-1?Q?f5Xl05/COIYBCgcwnylRTSw0QqE7MDesiKMbJDD4seBDIGXq4CnUtYzlY+?=
 =?iso-8859-1?Q?m4FcvoxqLTfTicMwKJ0Ad++wS7b02RyS/MbYO3KyFWDTtSbC53Y0VP/Ie4?=
 =?iso-8859-1?Q?3qfo7OMzbyP1CUfAX9Z5ndIQtyu0GYK9lzxEGp5ptehQaLKFWdzdbDE8D7?=
 =?iso-8859-1?Q?s8/obGGxUIR4WZNewop8TwtWRY+ThE3gN2VxqW5rsIryGr2v2/KAAEcncb?=
 =?iso-8859-1?Q?FbJgOj3S/EuXzgTGkGb5OS3TfINY8B8M/0Y/WFXY2fP5Az9FJjpr9E2zzx?=
 =?iso-8859-1?Q?wF5I1dosI068zN9n3W2CnGoENU9qFEQP3G514QUin3BF3P5TDfUJG5AgEE?=
 =?iso-8859-1?Q?low3Dw1/aOVtXcx4uaIMR1ziU6j43UoDe9ehhTuE2tfEqOlpUQtVG2Ncds?=
 =?iso-8859-1?Q?ubageowjkjI2cO6zXl8fi/yBkKHHduBRLe/n6fdZwuWxTo6t78cmbXQyMO?=
 =?iso-8859-1?Q?MupJJYfGTWzYtcmgMuQg+fIdHw8VtM8lhgFLivj9gVil+dIG8Mw8uwf9kN?=
 =?iso-8859-1?Q?K/inOoCuN05yPQgg8QZbECzpnT9GuV1JkqQffYcRVFp+WLcQyK6AjNgID9?=
 =?iso-8859-1?Q?rAfqrOw8Zj3czCl0t7faDWolrkksPM17OLePSa3OaGWRIiFxvm++eTl4Fb?=
 =?iso-8859-1?Q?A+ruQzPHW8pr+VilA5Qrj0rvBWhb/BkozsjkgjpVsmaVa9aR5JpBDwGAyY?=
 =?iso-8859-1?Q?NdPSFG8FbyPPFMesnq9qhDwe3VSd2NgfUfnPqWhnAwT37hcglSfP2dU9Fx?=
 =?iso-8859-1?Q?0Q2hoSDFBB/UjH7izpz99DNkvLVmu8+wMwgcsn3s7kFf3uQ3dIuYn9oeu7?=
 =?iso-8859-1?Q?+m1+WCg1wsV91WsFlyIVxNiKESWAxfWc/2lsg3rY10LbXL8dBW5TWjnGUK?=
 =?iso-8859-1?Q?l029wTBUN0UOti5k6V+rzLqDbXtNXE4jMiIFFfc7mUWW+KFjwzzZ11yBTJ?=
 =?iso-8859-1?Q?m+9sN6sYpr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78829a82-7ca0-449a-181f-08d90a5b8337
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:20.2881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1oK1+5Hcvzqql1aO5Io4RpwGuMmwqCcDoXBplnZVBk6DghMu4qZr3789AFKpzGBPR/3NX1yrCU4HRGIIKiYPRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: a8neoYptMqr4V7fkF-1BeuDjIP3DWcU0
X-Proofpoint-GUID: a8neoYptMqr4V7fkF-1BeuDjIP3DWcU0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/base.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index fd46d8dd0cf4..8f62ab2e77e5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2315,6 +2315,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2340,8 +2341,10 @@ proc_map_files_readdir(struct file *file, struct dir=
_context *ctx)
 		mmput(mm);
 		goto out_put_task;
 	}
+	rcu_read_lock();
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2353,7 +2356,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
@@ -2371,6 +2375,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 		p->end =3D vma->vm_end;
 		p->mode =3D vma->vm_file->f_mode;
 	}
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 	mmput(mm);
=20
--=20
2.30.2
