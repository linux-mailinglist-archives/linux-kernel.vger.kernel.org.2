Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B59421C0B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhJEBgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50978 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231233AbhJEBd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19515wf4024348;
        Tue, 5 Oct 2021 01:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CbqEZwlDb43+5r2KvBJBFgh3lhqi/TyyWUEXWRJj6t4=;
 b=w8OiJxBsohspmxu8Sqd38fvHqvCd+SIhTUtGKoaRvEgqS3UA5DgG78YZvCBjIYSCIdGz
 GeAZGEZoFbcI1hQCXvE1TOM0RVx/QzxOOF8zVbgH3TXStI1gdmdJO6XQIc4jldZTYHBy
 tDv80znXvoo4OBF54urhsCBfZ47fG15xEmWBKYDlgSB1DGY8mt8qW93ZLnILnFg2uLJi
 38utaiPEaOhBSW6ZrsRI3/iYpxzDPiRfdZMNFJRh9EG7UA0BfHJBkzAKTzRW3BDiRTec
 5PSbZVIl3wbmqfl1QbmVXzcKTHvrA6tXEw1HTsgiQHpt7IXfmf+LrHAId9h0INeVOKO/ 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg454bvpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHTP178361;
        Tue, 5 Oct 2021 01:31:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3bev8w0386-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt6euwHNcKHSVRFTjRImgctEpCVddthf6glWK6voMkCdMkL1ljN10sY1oDUTjuB8aQOa+Yk+FqgIe+R121u95CsOCMY6r8E+a7i8lIzHHfKuPSHPkmePEUvLqVUGt7nVUanhYi7d78tRA1JprG+dTEha2fCIVkAQsAQwiSt2eCzjtgKVLurKhp2UHoxyTHjNqxcojB75MGs3VnuqgyvwxtJk3g+vaiJ+y9wNXMveeiYwWTC9tKxIPBaxU8REu9aB46tn46GYg7NT4gcjiAkRjYF0y5YqQ9kNXmJeylsEtjYKvH7x6m0dZ0IcD4fsmaDcnefSGOljVbeAqyJBJL2M7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbqEZwlDb43+5r2KvBJBFgh3lhqi/TyyWUEXWRJj6t4=;
 b=Q0LM7HmGE7rcj2xSqmMpkvkc8inojp/27MwcE43QCS44Sz5Lo3lGLivODt+tLxWATDL5oXoei+I7ixNw64lsx/ew1KG0hNsX83mWQvWPC067ko0rlQDtTPpCcp/V2xEsMILKWgrfdF2tiLu2ygrPYodnyDshkE1ugC0Zi0oRAIthFdiZh+qbc+OWHW/fie/lk6gAhNj5hfMe4XrD6rHkw847mfc9Fxd/0QWJxHhjEgjc2ksR+NBKwHjZl0Fz26nljv0MUx4hzXQX+HgLSB4mBy8HDcuL6wQ5iSpmQp2HD92gN0pfA9UFcYsKy4d8gXJ3gwEvrQux7YcpUbSVK7b2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbqEZwlDb43+5r2KvBJBFgh3lhqi/TyyWUEXWRJj6t4=;
 b=SfMuloWw1EszcUe+TCYWholh7RbnmQDrZDaovWDlW5gC7nbNClkaZy/GDXK7ELb2+8JjUNXacjYCLRvB4Uv7ohw/iOQGorf/nj3WgOJ7fIvhz8wDLQDL/mRH8vXIdofIk6CJiz0OT7iE3KVugSF/R+tOlKAxhs2ujy294vViPSw=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:24 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:24 +0000
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
Subject: [PATCH v3 47/66] bpf: Remove VMA linked list
Thread-Topic: [PATCH v3 47/66] bpf: Remove VMA linked list
Thread-Index: AQHXuYipZhT/Qm1HUU2dKFVfr2/EaQ==
Date:   Tue, 5 Oct 2021 01:31:04 +0000
Message-ID: <20211005012959.1110504-48-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: f792b7cf-e562-4e91-7720-08d9879fd7f4
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044D62F21E408B5CC1AB6F1FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CrasKYJmM0GNmKL3Gmukylc+8xYSMimQCVL6qdUTGpnvXRRHWD5ZOtC9ixWHSnX/wtsrnp3cgb1dLWMDJKoKEhE21nkhjX4F37+C85w2JpUIfariA109S6eSjVQX+xOTog9yDIwLdtD8KEeyB29QcYLNJQIDu/SxKgoN2rd8Kux6EoidWUQ/R1PkETm8CU+QYsphuNeXyI7IyxRwxIKsX4VHKUA2eJK9S8AwTol9T0g3XBDYuHQsg22bclLWGGsLx90AWD2Wnvj9zcBdHbcQz+4h/q6TujEI9zLkUAnQHXyD6QwotH0O/LohBELvTr0Y//dwYrNn5u7Db0dhCzfd4WVwG1iY/TQ7gVGiSAACpGzTO3xiV1SMcZTpsvYLjMJFj8ens7VVJX+Ag7soZpPlQOI+vtFmiWeJnCqPpfq5fnMjmIqZsiM7jHqzYdfct9dKv1g54C83sqPWKV4R/Jb89F6DgcQFJK/HuBBYqOHIarFvpWvtQW19Kynr1Wi0hFTeIQZZkB1Kkb+zmAPU/vY6jrvQmGTrzLnMHw3foc+PomMY29ag12vrql/YNs+D6Yq5DHoxTNKTODQ8T3HuRY0tPRFpeQmO5C/YKXQYhx5aaybFRxP5LyXFa29HjsPmWhjIYrtiNATdKfbHe3jQTYhiqJV4daRSeGXx7m15g1U46DTaPok8g3xfUntq7l0x7tVr+09Uzb0SQwvDpzA1Jb+Obw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BIZqptDhCLVwmpNBkx5OraEKKQi28a9oeDNn/Tu2kfaMehonuyKykl+To2?=
 =?iso-8859-1?Q?13dY0K6jJQ63e3FxNVwJovFz5Qf6RKv4MwGTn+SQ3DbgNR7fD6UngU89GS?=
 =?iso-8859-1?Q?4t1v/RuSlSLf+vEfNbRRH1kK4+NrPKsChk/jP4UhgiPfTD3f9ItH4UlvsZ?=
 =?iso-8859-1?Q?qlsPx69Lh1vLciqiTQEGv1Q/T8syIE4wZIKgqrqgX+1MDoQXDTEZPoWjY6?=
 =?iso-8859-1?Q?UoKhfx5QjgTJYfoGQqDMmFMIxiOcoXYUqv7ngXaNkWIanTfgapHxI7yneE?=
 =?iso-8859-1?Q?GC4YwwOqzsnhfcBtOt1CC93udsdeb8Hq0NL6/aaUIErqCLq/usjzUyfZ1S?=
 =?iso-8859-1?Q?Ag7cYva/4MXOT7MBo0pSrfKCw2yA0zeysDPiaGZg7F/XWvnT7Db8nZbCMO?=
 =?iso-8859-1?Q?2sBJXCjSsUkKkxkc0hssRut5Kbtu3JIzibHzf0Du6R/jzxnLaW6q0K32zY?=
 =?iso-8859-1?Q?KmWof1LahO9Pssw3wzm9fZVwdsMi6mGVX0iqex8FLF7miFy9knEhr23hEH?=
 =?iso-8859-1?Q?0rm5529nOhi2bL7zb7EsrRMsuKA1nouYauqRtpLPA54ZmhQfOfj9SBuS19?=
 =?iso-8859-1?Q?pVFf+o1i1+VtfujLwUqEoaQWndasbzi7Pp13I+3QsmP0l1xD79Do7JTl6W?=
 =?iso-8859-1?Q?cRcf7LecEQBADI45Ri4pveFvh/JHoVSuRrVrFLq+VI997qal+QYFmIMReG?=
 =?iso-8859-1?Q?Ez5pWewJ0dKH9ivAtZXsWe5hp/BEryYKxbUUbXkuuaUPjXoDRhuY33YIxh?=
 =?iso-8859-1?Q?fD0hllKBwsAGrAJ1boEojbakLVCdXwA+Zdxa/9RsmCN5d/+BEoqjB/nUXN?=
 =?iso-8859-1?Q?VMsZE/CGW6m8MyeO6BUg1T/j4Ye5L5bCyMxty1J44okugXv+f4JQK2Z5oO?=
 =?iso-8859-1?Q?e+vUBtDgatAYAxV8rvsnsPChKbIXRydbki9TBIzgAbFVT5IzJR1eu60lMn?=
 =?iso-8859-1?Q?RgMR8yb6C5k4uCZPsDIdlDnSMzvGjUK7/GrehDW0EH0ZIB8omTrZrt8zAR?=
 =?iso-8859-1?Q?Tc5SlgQVVdILGetTfk9bjJYcqDtUxSljtlhA2PU1O3DGyMjzGdBGRTMCRe?=
 =?iso-8859-1?Q?6zUxFHt5kHT8UxVrdB33XEGO3qxSyfgRvAfN4TuhFkT3i0pm/RSjA40o2m?=
 =?iso-8859-1?Q?P2VCIaIocX4KQjIIzcAGFEKERtvh7LcFgiUl0YVb3RRUdHsURraKZHH994?=
 =?iso-8859-1?Q?yIWeFs3JxMq6CHB6CgTCwcNRKo9EyEl8j1Q14hxXZzwPRoessVv+lH6UAZ?=
 =?iso-8859-1?Q?6n02/NDRjRcdfUDIRAthxlLk6s6cJSqTc7sMUWCUi8k7WDDJOkEw9M/VVJ?=
 =?iso-8859-1?Q?L8ctaqbE32j79ues7QcRib4kqYJdNI6j5fc80fdVyjiOAhNBoqLCvpfwXn?=
 =?iso-8859-1?Q?5vK9q1b2/m?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f792b7cf-e562-4e91-7720-08d9879fd7f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:04.4680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8y7+IkjFzV+LxdQs1Q847xEjslnFPm1Gwan/IRxwepa+e0YUStEHaYc7i5kein/VPO3aXrB/NXHLc2hcrnGSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: uXgc5jGEbnyDQqtnd1zejnhe3OlGV4R6
X-Proofpoint-ORIG-GUID: uXgc5jGEbnyDQqtnd1zejnhe3OlGV4R6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_next() and remove reference to the start of the linked list

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/bpf/task_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index b48750bfba5a..2c01ea85325f 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -299,8 +299,8 @@ struct bpf_iter_seq_task_vma_info {
 };
=20
 enum bpf_task_vma_iter_find_op {
-	task_vma_iter_first_vma,   /* use mm->mmap */
-	task_vma_iter_next_vma,    /* use curr_vma->vm_next */
+	task_vma_iter_first_vma,   /* use find_vma() with addr 0 */
+	task_vma_iter_next_vma,    /* use vma_next() with curr_vma */
 	task_vma_iter_find_vma,    /* use find_vma() to find next vma */
 };
=20
@@ -400,10 +400,10 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
fo *info)
=20
 	switch (op) {
 	case task_vma_iter_first_vma:
-		curr_vma =3D curr_task->mm->mmap;
+		curr_vma =3D find_vma(curr_task->mm, 0);
 		break;
 	case task_vma_iter_next_vma:
-		curr_vma =3D curr_vma->vm_next;
+		curr_vma =3D vma_next(curr_vma->vm_mm, curr_vma);
 		break;
 	case task_vma_iter_find_vma:
 		/* We dropped mmap_lock so it is necessary to use find_vma
@@ -417,7 +417,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info=
 *info)
 		if (curr_vma &&
 		    curr_vma->vm_start =3D=3D info->prev_vm_start &&
 		    curr_vma->vm_end =3D=3D info->prev_vm_end)
-			curr_vma =3D curr_vma->vm_next;
+			curr_vma =3D vma_next(curr_vma->vm_mm, curr_vma);
 		break;
 	}
 	if (!curr_vma) {
--=20
2.30.2
