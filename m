Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F1936DBD7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbhD1Phm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:37:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35900 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240052AbhD1Pg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:36:57 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNxMJ009843;
        Wed, 28 Apr 2021 15:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vwYCHDfbt7BKLHLo+ss2/nJJUfHWN0jvHKGoLeHZaCo=;
 b=oLXGHpHN9wz46uEymM5RlCen00Cgyic5F1qiOtGDI1a7kP249Xivnmgn7xjdkRSFNg92
 wvqmYMTNwIS43QKPabSdBT2ji0IdyXbFsjzIgABdA2JrBEeQdc3rTIjVGTkFtQoXLP0y
 4Pw0L7wZNmxaWR6u1gvu/sn+4gUvfpBWmPySuEkEWhbDwsyyEQlnFsYSYkLiq6fEUt96
 NhWCDZu8Xv86ornD+TQcQf/704JjQy8IiFfLMQEJa69nyL2vqCZidX/QRjz02+PvnC6a
 A2ICDgfYoc8WNrn9ZnGFgCmcS+qVSMMb7N9A8APVeHW5oPGdPHG1E/TcWRAaH3dLy3fg Nw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 387a2mr0ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:55 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAY003673;
        Wed, 28 Apr 2021 15:35:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr8yitq4taV49s2rQmlgywLcbLgdP3CLJmXBL3kJvOWB5ylJZT8RS9QfbTHXoT0QthSIzfY3avj9rOkCevBZ680MwY1QxfqmF+km2Lo0dGkTB0v4/OYoLeq++UkAVd2gyS6pDcJUObnoUrKpojtd2M5k9CqjbVpMvv3ao+oQYjvVWPPYOfuBaY7UCzg+kfG38GmkVIgeChFIhxg2QlNLBH50ujjXAU5jVtggDMqJXS0wSy22MZpgJDD2oDwl7Rrawi7odqHMXIYEUT1SiK0TI3k1hP0LhpImIS4TNSnBhnP6/ejaM1ui7M/SH7mxzLJHyGSJ6gr3C16GhrkUzFmVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwYCHDfbt7BKLHLo+ss2/nJJUfHWN0jvHKGoLeHZaCo=;
 b=dJLxR+65NsB19TXcesnCrlkhSU5DSYey88dEb18o0Jb9ulyqEAaDIYAVAbMCP7+DwvT9L+VRiZJZ/mb3dc5KG3yh3Hy9vbcgm/O5VtGOG+sqAvBephJdkntwKE0pV8h6o+TRG+TbXPSFOE/aGh66aKQOnkVhkoJ7Tu8Ec4wWgRFw6HoRooxhkEUGnM8TeH9ot1zAgb4bFRe8aLUFnWPeVhQpvIcQShAP8WOonwYjTXJLMny3jIo6FKsZdeBEGgRTEtdhab6os7Hr2KHCLbsBwheRKf4VKZ696QIEa+bly7tSaxTnQ3wGHIvX3oV3ZNRtWdJqbzgN3U2uco+aeTYRBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwYCHDfbt7BKLHLo+ss2/nJJUfHWN0jvHKGoLeHZaCo=;
 b=zLXCy7NJmHPb1xWuqXRENaVwqhrw9aNm8VoEDkvpI9V3eAWT1kbUKzKe/yw9KBM94rgdlnKEeg7Ib3yC6/JNMnXNDNsm7X8s7lu48J+voY8cO50I/XGuVUX9CqOETwCV3AyzyMwKFIr2r/qRuesa7UOCX5WjZDdxkn5flLfAKe4=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:50 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:50 +0000
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
Subject: [PATCH 16/94] lib/test_hmm: Use vma_lookup() in dmirror_migrate()
Thread-Topic: [PATCH 16/94] lib/test_hmm: Use vma_lookup() in
 dmirror_migrate()
Thread-Index: AQHXPEQq8K5BkAo9t0u8GKSwaH+7Lw==
Date:   Wed, 28 Apr 2021 15:35:50 +0000
Message-ID: <20210428153542.2814175-17-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 77b4e041-edd2-4a41-6de5-08d90a5b4d72
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB449786166B60ECF2A6FD2CC8FD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: miOgwM+YAawHEf9jMyCWpk58QuyH2o+0fE/7aSUjyKQMWT6SxcktPW1nFqmgU7EPz5F3wywRIAebk8go1BYpsQkMBFoV4g1UpnCEoVO3QxjlbZfEsWU5xA/e/9rMd6IQBVKdHFBib/7ipzNpFH/uD4U0fv538C/jsrhyNa017OPdgUz28SBg2ZDt1ZkiMswqY9dj58099ikREmEEI7TeXMdiYAdBMV4BA40j0AuSxlYZtRtGQ34SnT9gmMzAWsuoZWwXv5enMLUgl0WP2rkCkzlk9Qpp0rs90Y4mVnGXv7QZSZ0eAM+Q1EGV0oJhJqy4y2xagyF+sMCB9Y1sEl/9+FzRto/y+yPEA1QRnvfj5smuobehlsALbL5OFcYcA0iu43A7KOcKI84gfDZHLiskBDgn/0Jtwv2kSgy6MhzAbfRU78onnlnem5zHPGGPAnpFTgvftk79LOPmUVJHP+hm4Ru+f3m9gAVXnBR4q+JNqc8SHqrMj+4KEDMM+e+5udHbIgu2FnEju8ncKeYoBP/afjpBakr4Ugq3y0vaAijke5r0PQLSGxPNw22+j2DfuYkALNdptPhGPC3n92U1aiAfSBb/e32pMVjwOeDpuYuSG18=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?WrKD4KyXiXUOLunXEiFFffEpRf1k//gxIHfXzCxTx8hIU1r4tUZkv/K0Ub?=
 =?iso-8859-1?Q?fZuCHqOZBuh8R3/HZlOOWDDYVylnJrU4myGBZJHxwiIZeVwkOtLwVHcbIJ?=
 =?iso-8859-1?Q?OaRi5jwmhUnyN3sj34IaYQR9Kb9vW6lmT06dpP1BkXWav1zjiJTMPwEM63?=
 =?iso-8859-1?Q?bO6i8G/V0FR//rvZrs34XBN5MHEHajZJXvw0TumoPqPtbLGCAiGhMj3clS?=
 =?iso-8859-1?Q?xRufVakhKQstScuhIJVs9XfZOfg3owxaNGoMHKUd8HswHf4JNYV9pA5UQC?=
 =?iso-8859-1?Q?lshkietmkfzbQ814/WF5N3ageHcjySaWBa7bChQtAlV5qWJQCvvbXKlmdu?=
 =?iso-8859-1?Q?re3UfHgALyDJJ47/wTWNtc1PCOwL8w/NMMks4W7ErVN1C92/bQlekFuqFX?=
 =?iso-8859-1?Q?OLv+KSZDHG+LIOlEQuof6bW64bc7Q5RbBuCIrIFcqe4ovtWk5ETMSp7soD?=
 =?iso-8859-1?Q?yH3/YDFnGq0tPbIG373pWgTyThmRJJsnFbViLEEbAtKc+UjIwu3YSm4QDD?=
 =?iso-8859-1?Q?+/7alcLC8sF9RHntoIgQTVgtxKKQfMAQjgbyq3TIyNZDgF+R7wr4yF3WHh?=
 =?iso-8859-1?Q?heFm4TwIRC744PuNvSzUuM6quwouudp8/jWUTxt4NDv8hmW9pzUMl9tvIG?=
 =?iso-8859-1?Q?vSbmPLcUtriBbhwN2+1J9WK/3sFdQyzhq714VQ44Udv/NyBHjmTUiintoz?=
 =?iso-8859-1?Q?5EmBGK7pAOv4CwhuUkSzWHqGbgV+dVxujAvppAoAlppkwyyZl6s6CTgILj?=
 =?iso-8859-1?Q?IHP9gk1OHssbOl7/hK15OO77063nSLs5BSTsJr5SqblSssua06WnWf8bfU?=
 =?iso-8859-1?Q?xapSrfQhbLZ9c3SdAuHOv+i82y7NDnRIf7iT36Syy9p0lhWb6EAh3TVCc/?=
 =?iso-8859-1?Q?4Vyzn7Nxi65WhGYSmePdleSSNn6F5nNDmcMKG+5zfvHLnNyC1lqoj3tAbK?=
 =?iso-8859-1?Q?nuYaZ5bkQ+cElhy0ufcROtrGEIUMpt1/28NZeEnkN8zSE2hewc9X1T94N8?=
 =?iso-8859-1?Q?hZeV3jmyhm9GjrzmsUtOEuPRGs0kBgSdDjYVkeZDOYhirQsZItZl1VMxW5?=
 =?iso-8859-1?Q?EWRwVk1ncqa7z+ylQ1FbXMdP+thFHu/rdCbgTLpkRSsRTM0W+ac8vCXxcZ?=
 =?iso-8859-1?Q?32xECRSNfz5+581kIJhXH8nydLmp8jMSh1nt+A4DqRFNWVRNz0zCRZ4+uj?=
 =?iso-8859-1?Q?innExpQw5b5GEsEXk64o3uu9zT41KeCGNCj7himM+QIiOdQkaVBRd/SDhU?=
 =?iso-8859-1?Q?AgaYvJh1Va62piRe0irO4pNGmcCkTxfnXUx+n5eTNfJIkODaThoRNBsWh/?=
 =?iso-8859-1?Q?NoWu6L56GUqaU4dfMOfxgT9EdS+QYCfoOwX4FJfl1sKJD0D54Yl9RHFQXJ?=
 =?iso-8859-1?Q?Tpn8xo03boC1fAjMtjsIB895v7nkQFrw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b4e041-edd2-4a41-6de5-08d90a5b4d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:50.5043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEZjQfh3Iupore2uMYjVwjdSVOJjsVvZojCdkoP9NYLVLJO4ZpMjX1vAFTFa7gcSh5ey7EWvCAdtp+h3ZPTioA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=883 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: 0Q75y3p7IS2WTQhLLpTgtR-wAaIx5KcU
X-Proofpoint-GUID: 0Q75y3p7IS2WTQhLLpTgtR-wAaIx5KcU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() will only return the vma which contains the address and
will not return the next vma.  This allows the code to easier to
understand.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 lib/test_hmm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 80a78877bd93..15f2e2db77bc 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -686,9 +686,8 @@ static int dmirror_migrate(struct dmirror *dmirror,
=20
 	mmap_read_lock(mm);
 	for (addr =3D start; addr < end; addr =3D next) {
-		vma =3D find_vma(mm, addr);
-		if (!vma || addr < vma->vm_start ||
-		    !(vma->vm_flags & VM_READ)) {
+		vma =3D vma_lookup(mm, addr);
+		if (!vma || !(vma->vm_flags & VM_READ)) {
 			ret =3D -EINVAL;
 			goto out;
 		}
--=20
2.30.2
