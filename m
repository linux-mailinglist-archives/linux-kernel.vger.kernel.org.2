Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A563EEFD0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhHQP5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:57:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44188 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240142AbhHQPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:11 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkHM2018102;
        Tue, 17 Aug 2021 15:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=V5qpaCz/mr8CT4B2S43tOfxGzkL2jGk0OwfTrdxVPZ8=;
 b=EUJ1Do5acVbb5VZ/K4TtX7tSihA8y8kfYVFaTmp0p1o+uvyYsbMUUTBDn89rvVPEcf2b
 C1NH66fYWdQO6YP9gBD51o+JImU4J8eneOc5/OozwPs02tm0P82ZLGcbj6nrt+xwh9wS
 SaSOZT3ZeCc9fLF905kHWit2kh65/QpMbf/wJ+vCluBgRoO5fwCnfPtUE3F0rqWJtnHE
 2kqO0QHFj4I7QyaPNBloxvLvmvbNVEzvvENcDe7DWF4fbxPRGxwcJPY1FqIjxsqUXhfo
 fT+xJFULxnvvKj91+OjTRP7cbdfTmivjlO/1cMfrX2dsFODUMt2rMJSutMRr/i3msWWP ow== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=V5qpaCz/mr8CT4B2S43tOfxGzkL2jGk0OwfTrdxVPZ8=;
 b=OvNKyVl70e1YHKULbd+LlS9sVHKCqamwMm6Alzl2uhNrJL2ANleN8iqzLCgiMjKP9FGA
 yZiddr2EYKNPKZUXQwMc+WScL8XRStjfhJkZ3NTZAsBMNXsLUdo2fU5gcfg/3rjzsbxc
 3wxWr4k2fjdCPHNBx4IOtRm/VykQ82JQLlbCj2n4lOYXIFz1J5a3qheCrfVLEE1mj4ti
 7TvskZbtyeRs6cfALVxa4YnnS+vrQqOq4JgG5FCawzKOIXZKKhrOFBS1qVpbStWULs6A
 fezNCfyB4i7VWQlrKawTTyb3rFavavwqqYorP/9BB+XmsnluPvsu/9jYGowlXlMHF3V9 LA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3Od174039;
        Tue, 17 Aug 2021 15:48:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2r9-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyxjI4sh6kcJYC+Lp9068HTRjE8J4+5U8aycBngza9+9xVdKqjE0Lf+QAqyZ2I69shKZY8pAKGVf027O3AnPpfTg9HlHCXFMf/1z4GY79bcyUNCa7CJRDYRbsDTOlKSu8Fn0Q4psSWQqQHvWwvCfzH2nASLAlPD1UPXGGJHrW3Nx7G+KpyayTz6/nzzhCE/K3VURyyj8naIIO4c8mt5HDoR1UDOY2RjophbLBYuabWxnnbWjbN9G2kB8/auM7edgTnR6eo9Rc53MNO2XtboilAyR2JsqGwv4YwrGK+40e6hbBSLRwi2HqPC76QFMKSXPwT7DEs4lXO9/25Ou+p2knw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5qpaCz/mr8CT4B2S43tOfxGzkL2jGk0OwfTrdxVPZ8=;
 b=Ld8KoXX2rjAzG+oZlUpSXI+FAzdaLKUyd/bp595AgOI5DeV1rVRniT65Q9WkxOKRWqD6r+LDyE+KtEGxlD+HJLEm5Bo78x5KpsQIQe7t46SXxqZU4pg5BwikbHzqI2vclkHn+pu1ocwCxk12nZONpdO7qxbLjOz6E7ggluXw8nheICZSkjn+CXUPDvwq7+FKHD5Q0r/AaSnoYxEeHvYSc3UCA9iz6AtxIPRW/arQZpmskJna/c6LkfpgPjliQpXE9I4myUUL1RfDceGL5PTBNVtalLil/+6zlHAoeC5zH7gceK8Me4ag9RbB8bGEQtqEvMiPimz1u+lK1HfzrtaxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5qpaCz/mr8CT4B2S43tOfxGzkL2jGk0OwfTrdxVPZ8=;
 b=JnBFcWGSD0BHxcXF4NlijK/bOU/Cw4H04Vs0Dh7f+TfEE4rJb/Jg7udevIlcl6/LmphwDVf5QPuf9daxUZys0pb1T4XdkIrPcGuttA1iU1ajJQ+lgeJl2wNqZ/Og+v1GK4/0J++diGTNx7ZwWw8wb7voZ0E51zXRw1B0VYcCeFw=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:53 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:53 +0000
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
Subject: [PATCH v2 38/61] fs/userfaultfd: Stop using vma linked list.
Thread-Topic: [PATCH v2 38/61] fs/userfaultfd: Stop using vma linked list.
Thread-Index: AQHXk38sHAtle9Ui+06idLwpkbxIwQ==
Date:   Tue, 17 Aug 2021 15:47:23 +0000
Message-ID: <20210817154651.1570984-39-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 1306f7fe-8d73-4739-5782-08d961966061
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB42364976C36E31A6DA7596B6FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lw0+WFyeDi4wDQreYZVV1Q7Ei43trAuy0hM5BDjuWHPjQGJjFaUmSybkoUhyTtd5QRTFK+CPdaVsOu80CD2GVGtCNmI4VCrOkcMQgErNYD5nEVkWoOr0g8L/tBnXDMmAu4NClDD+4FZnw6N42KwzfHeqD70V0QxQigR0zGiL1jdcvK5LPGFdjrX0TRDsx2bLGYlbYUXlnR92L3RbJxUoGE+EiSNH4WvEbp4yLL1S5vK+NI4hxbav3OR6MPRvgn8NBe6g9pe76t8J1hwc677eojO1om00n39bzxaZYpZsBljdJ19FR5UiXWWN3JvQx30eU6VKiXcxqecIdTLds2/FsuVofq3aAg99XSLktyYqLUXau3SjL+QybL1VXneMitCESA7spsugUNqP7+gEhxkEPIRUYhLMc/Rue5y0+rKz2YbaL0H3SNBRqLWdWT9TdYaUz+JRwRcboIQqaR8JRqrXPtnXkoIJ/Wj1RLAkDN1jiSYH1GzSFAuSZ6pz8/oydQtDf5qlSmYPwuuIYnR4Cs7HMeB2GwsTzxjKjra9FyUzs9qafgL+L1Nu5meD86eudDYilWQDIAFcASHOZUPBmXzmFiGsQSu1Ci+HGUAjT5KZN9ur48fgSVbj/ktqwPlcwjgT0+WfigZDKG4SMvRWfAtEIKuf/h+VlyVt9ET5movvh9WsR8uZNBAOOSobyOSAXPLix7reYg7eog+DFrZ7Rb/Tig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6666004)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g+za/e2q5VJfDiG+5DI8gi3lnUWVFjujNg2KqsH3V3f3Sgd408L7tGY78D?=
 =?iso-8859-1?Q?Y1Pk5lRcmQK/TWac9oNpzNC7RIys+yD0Kw8mcMXcQrb/hYhhcqTOHgNWyB?=
 =?iso-8859-1?Q?LEjtt2VdK1moN9fE96UUSyCMD2w65h2A4IMWiIIjfQKGVAROE4ld3eo1vo?=
 =?iso-8859-1?Q?WjJXwS8lUsuXEokxloK9z7RQzV9H1ZxFukb8nu3Np99fm8ZxodqcqrX0/z?=
 =?iso-8859-1?Q?PUYWGbncEuIBvb79o4XyX11PMDbUc1zsUiy4kB6SYw7IZQjqby53cs3yvz?=
 =?iso-8859-1?Q?nrIZLvTORbCneTMg9me+8Uzi+K5X2GAeu/Iv106Whr56S30IdftaiNz9PI?=
 =?iso-8859-1?Q?Ed+2npUZuuj1kHBFK8mWb+qjNr9hT1BUTuQgNlcYcr13S5PoAjPWyjzF28?=
 =?iso-8859-1?Q?/13VxbL7Zwrd2ULzscgAs82j9Jzv4buX9YO9YkoSErxr/ULmhh0GEI3EBG?=
 =?iso-8859-1?Q?25KhQPo0dcQBOdE4EBVsicpjx7xMMQfLcmg77nudcNw2hLX1dxb0U9fyL3?=
 =?iso-8859-1?Q?Y9OpMjk+t8h1xeFVbsrnjTAmFOEBlM7/cvQHf7PQBChIamJEEwVd1gbKWh?=
 =?iso-8859-1?Q?vzOAYxW6QAQj8rcLwY/qpwNCOTkQL6hhnngBwdpVQfnYbAVVdT5xXydNq7?=
 =?iso-8859-1?Q?LSgDWQS7PAtGb6sNRdj6aCq6pc0bNcLqFQCuo/XWtKyf/EGTb1yga3w0bL?=
 =?iso-8859-1?Q?hb2x4F5UrxIrVPqUpAlhWjPT+/yNrgkK+h6rIvSTJzGYfeFml0uJ7WzM/D?=
 =?iso-8859-1?Q?htppIpYZ63aSTVYLK5ctE9TW4Ds5h22AWELFgoyvdSDtsuQG5xUOUSpjaZ?=
 =?iso-8859-1?Q?CLkg05X7xg56R7LY31ExHo01mOcGSI+u/t6gA8Z5wYaSyfSrqrn6Mwcup1?=
 =?iso-8859-1?Q?9xz6akl8E53CTnDE500MDqXn1kXjiRADSo1o8AkWXLbITNjox61xy2UCQ/?=
 =?iso-8859-1?Q?NB1y23xUsjn8Zj8s1ouSfvpgVyx0ExPYiT0I7ohcqzwWfP7YCVA2YkTZ4N?=
 =?iso-8859-1?Q?mK4uyUKqb52G0vx66+2GHb6NZQWf8FfSUpdJ7rg/qcMcL3PrjWaIUMyOwo?=
 =?iso-8859-1?Q?UMrYTyZODLeU2YXX2rdGwnek0sF06dVEefq+B0CL8HHWyp3WieBpwk8Lyo?=
 =?iso-8859-1?Q?Vr987wb0J5g5jL4v2Co/Ca7g27F4Cs4qy240riIRmEMSl3J4DPbINuLwuk?=
 =?iso-8859-1?Q?3arhmfvF6hoEkOWAj0cSOZzcZDTpOdHaIQKk9Y2Ppa/dLwYyB/D8du21HO?=
 =?iso-8859-1?Q?7O26jF8OtC0nKHKq+XExKXFUpTdNyfqeJtAv+DlL12HRKidef8Gb4D2Wx6?=
 =?iso-8859-1?Q?dY0z/VGJYsYZ5UxkN+cjFaXBFJqGJLtMNDv2RuJKGvRSuXsjxkdksL36y5?=
 =?iso-8859-1?Q?t+NENF/g0o?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1306f7fe-8d73-4739-5782-08d961966061
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:23.9202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0MUivmrOVSQBNIdxx4S2S57tKr/cBmCP9e/20gz9kQ1Sn7lw7Gncm5ac0H+H5AX1y3ybJzWmgK+4LAblu4DmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: 9YNoeBvOTHUVUrfVaq8W1UPvUa1OhWvR
X-Proofpoint-GUID: 9YNoeBvOTHUVUrfVaq8W1UPvUa1OhWvR
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
