Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F5E36DC08
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbhD1PlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:41:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40360 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240596AbhD1Pi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:28 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFM713009822;
        Wed, 28 Apr 2021 15:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dxeWZ/p4h60t4Vk81nHA2GfWNttAddyDRoRUsVd9u8o=;
 b=CwGruKViFixyT/+/A6yLgdVo6O6iMVuvy3IhUd/A/vs3n2l4ZSrE905D2sYRAWYNsT71
 377kbG00edCd4JvFnTdRqO2s3ewlYxM1nOsnR9pWAoknUcTdJXTCXlP2y5kTlyy2J9sW
 2hQpsM0yBPlTgpUeDUatdWN3BoDfY1PPzRqa2R9pTrYduzZcbj+SOn0Cl18txaANwPcI
 dZE1M3r9qyIYKQXvHqgkyLExy/4LgNHmOdoIddoIBqjodKEi0L8baawN3WpS6B5OyDFQ
 4O+xiH7ViJMsXTksDv2tflfUgJhEKjEVmziPwUG3HsxcpuPd1N4BuSOEW6DYWYifF4t1 EQ== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 387891060c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:25 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWZKO146776;
        Wed, 28 Apr 2021 15:37:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3848eyqygy-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRaKrTHwCha8CRO/Uln3iBcPgZRpMHPqu4KBwA+KRYv59XSXRSvQ1ocBf8K2aFF2YTn7ctxPdamKaVwpI3uNtzqp+lYk+ePnMjD970SeVGMuXCum5BFezMlFfMdBk7aExMcgczwK+dhxQrbskyod3RN5UJh/LKoJqiSAtPRsgeBeJjfh7edAUkSI/0x29bYMV9ovCSJoDj2yXOh4hbVt2FCsqlo+y/WMh8BZNMy94MsXnM+Vr2yjrD2ABFoaztNIAI/fkyEsRlvR0nKt0NuSC/aVQGM+JoAgmefSoTNHzJ5vMToYQzwH3D+nQsr8bfxBkEb+zvIik3idnmctQUnabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxeWZ/p4h60t4Vk81nHA2GfWNttAddyDRoRUsVd9u8o=;
 b=flddDp3gsPqsD+RvkF89bLNvngRoyMh0AIypJlRMj3pEAos0coBlCev2KBhSQs+yWaf5pWiHBx3hfnq71RhROutxp4rMqpAGspmWyjYNm4c+G5fsidHjZRknqq/x6RtBkH48J55HwyaBTlzZ3fctZ4vqaJRiWFs+HcG6Ij44XsrgFbzy7bwuYkbQ1B1bRHS2MGf2YPhlgUYIyLE0H7LFyCliH7w72v9qOanTqDGGH+dRP0Hs8Cq3z1JkhOae+mRZIMpFhhiO7CVIOAzyz2TRrncj5j6Z5ML93SSq8nktvT18wmJ5x9v0icniq7KWiO2Tc3CRs0H50CkscaO2eI12ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxeWZ/p4h60t4Vk81nHA2GfWNttAddyDRoRUsVd9u8o=;
 b=e6QiASt8/9rNJblXiUhceu839Tv4HsHyd0P8+0brTrNk9jN1PKvYGt2ldthEEMLPFXrALaiODPhhPlqEqO2cPc18iPwao/GjBKQGus7DFBNojTu7A13xpKV9dBY/oKfl7JqFtorBTE43liCnoZitN2rDzQKq2ycQyrxmg8LlSeI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
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
Subject: [PATCH 63/94] fs/coredump: Use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH 63/94] fs/coredump: Use maple tree iterators in place of
 linked list
Thread-Index: AQHXPEQ8RV9sAzkGh0Ko1bYpTQrPqQ==
Date:   Wed, 28 Apr 2021 15:36:19 +0000
Message-ID: <20210428153542.2814175-64-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: b9db9660-eb1d-4314-afce-08d90a5b82c6
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB187154D4C7D03973B9C3C450FD409@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46gfaVL7RowRuDKbPSQktHDftOHZVzPLuMsDAPttTicpcPOXs+rJBviHlJBBA39N3ZUHiS6hDKdCDST6jSdBj4ZM4mWzxf2qmrHmY5DAZUaBc+kSgU3dIQXIyD1WGihKkbHzfB8HvOCbCZFRMl6q7kl9ME8Je46G3olgA8qK4KzonFTELnRBdoyMuz8lDJBi2jdmMCA3ALC8y+iLlKIvx+xwVmuzSXo2YdxhqtZgLTvhp6NPI5k1qYSAinWXWqTDpkQ+faWMZyiZ8KOefHa5a/Ek2ADJaR3D00RtTkQkYQND2ofrkeN4PcXvcARtnVTldvu+PB3qdG9dpVZhBsN/uCWCF00uoxwDhXeufBpVCKEOZeeJPr5ysVIQmoMFBmEhrHFNQkZRc3SpcgbFtHvhJqGY1jKDdwlJtKGKBxYkFeYtR4KUL14SCJdqbEE2hsIFvM9MvdyNxs99oq3uVewKBwMndRwICaHpuN9dZbV8aMBWpIi3ms9wHlswWKvTJ0n3qZc+AnXZkPNpkp6a/h+PIG1uBbOOLJVPoSyyNI2GRRV66FCjkvOiEMOKfOeU09QY/PDz8WzEgdy2CLRo8p8VMCma9VNgu8sui/GiCvtvU7I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(186003)(6512007)(66446008)(6486002)(66476007)(316002)(107886003)(5660300002)(66556008)(71200400001)(110136005)(54906003)(478600001)(44832011)(76116006)(6506007)(36756003)(7416002)(26005)(2616005)(8936002)(1076003)(122000001)(38100700002)(83380400001)(8676002)(66946007)(91956017)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?WTyEiF9dhjU9W6chxMrLm4wcXOE7PMfYpNhcIC1/Di1TYKw454Ng7YM+77?=
 =?iso-8859-1?Q?YPGCaKowF2ihJUIdVn7W/OmHLEFrRQUNzSkI7UDNC9iY5z0pmA9vxI3acu?=
 =?iso-8859-1?Q?1Q4HM95pzoFmNlExg4x/Amer5vSA5umUvuBcnQbqH6Ujl0unMp4aYAZbr6?=
 =?iso-8859-1?Q?+uXvMiZ76ZbuU7PSNa45Qt259KNggztKqIZPZlGso3rPY1maDPCYQJetBv?=
 =?iso-8859-1?Q?TaiSBsTE4e+oObjA28z6j+/i2jT6G2pc+fNtYzvxT0+J+QDITkSA8vq7KX?=
 =?iso-8859-1?Q?u6WREiBMd7WPvyGQwjKI2+lTewVodDzE3TjtWgWVFK/FO2ayEr4pGosHUk?=
 =?iso-8859-1?Q?zuCwAC6PaRFQNWzfjH7WQkdMKuEN5zMXftY9KRz0ygL9Yag11xII4s+glV?=
 =?iso-8859-1?Q?Udpv0uQvZnsN7JrOY7vYEQZw+I+cByXhKqoy8G0YFbJeaKNJmW/L/4bIRa?=
 =?iso-8859-1?Q?5kzpQIrvA8KGmEN0Jfj71YML2hkNbX4hcImaF+flTDZNxXPD48yuYfPTD4?=
 =?iso-8859-1?Q?eDc7FlHvTYgL7L3WDf8KayjLMTRyGo/4gHkSDnfmflqgvDxfnGX6r5BXof?=
 =?iso-8859-1?Q?Au6+R1NkziU/+co6C3/hqlT90OvkaTGAfHGOZumYoBGMXkeCWOpuAoIZMe?=
 =?iso-8859-1?Q?yTs8FZY8OBoI83SeOqrkpfGjsbGXxid9qb6QXgIRGcvQZ8Y+oOderm4x4U?=
 =?iso-8859-1?Q?ZLyJjuV8ZeCXAja+hu2DQoWhN75vuD3HYc8Zw5ueeuZBnbMjOy0RJMV+ka?=
 =?iso-8859-1?Q?idxt9eUOSQeRVDbR4hqEhAcbaX3LOFHhkYJ9ktrxWTO1o1JRuT6BCNLbD+?=
 =?iso-8859-1?Q?BsA7+i7z/VSqz/ifkm2yRr04zSgAORq6XTG/83CI9VZbLkwHBuZElcz+8B?=
 =?iso-8859-1?Q?0G+O1BOqArV9PVkgjexuXXmytBMdc0IzguVTLwEbdhqNX+oT9xU28U0MiQ?=
 =?iso-8859-1?Q?RR52yRjaqaJHPXDMb1/FgKFPdnJUVzB2mj3iFZoywAVjWhREiOOWptgKXB?=
 =?iso-8859-1?Q?jt4oDJwuz3Y3W4UgnXHDwuc4HVcS20RhtuTrm0JABf16dmVfN2pRpWyf8D?=
 =?iso-8859-1?Q?bXIj9cg0tOZIVxQEVd0LHlgDt7wDd9coyyhdLFnubfhZ5HhAeCaGtOrLBX?=
 =?iso-8859-1?Q?0mm92HpZu8IH5skqBjihxnXG/vpcRdkr86eGJaGxAiiOBOB2aDlYYZHrLO?=
 =?iso-8859-1?Q?SaMJcGtgKCU8FoxllEoeaa78tG1z6IJIS/D0MXppCkQzwVdC2yUk5Vpirh?=
 =?iso-8859-1?Q?QvcxOmLyGG91IJphbAGZ6ENvkrGzctN/jDjiVXq3sjY2HUOsYo8YG15FJx?=
 =?iso-8859-1?Q?37A3sZjFfc2ndZf/9b4dhWS52KnTAOvSXTevfl75Ybqtr0e9VjKY7teOSK?=
 =?iso-8859-1?Q?+iQh6lTc+s?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9db9660-eb1d-4314-afce-08d90a5b82c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:19.4755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQ2rQSvl8Boza1m2B1sYzfoW+0bLs8IgSsDegm1vkPJMIDC7ZEJ0hsuQTVBMrCLDdrsX2AeZEwAT5KJ1wLYyKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: xULh18BqX0BtQb4SRAnXoCuWITDhwrzd
X-Proofpoint-ORIG-GUID: xULh18BqX0BtQb4SRAnXoCuWITDhwrzd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/coredump.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 2868e3e171ae..b7f42e81d84d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1056,10 +1056,10 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
 	return vma->vm_end - vma->vm_start;
 }
=20
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
+static struct vm_area_struct *first_vma(struct mm_struct *mm,
 					struct vm_area_struct *gate_vma)
 {
-	struct vm_area_struct *ret =3D tsk->mm->mmap;
+	struct vm_area_struct *ret =3D find_vma(mm, 0);
=20
 	if (ret)
 		return ret;
@@ -1070,12 +1070,13 @@ static struct vm_area_struct *first_vma(struct task=
_struct *tsk,
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+static struct vm_area_struct *next_vma(struct mm_struct *mm,
+				       struct vm_area_struct *this_vma,
 				       struct vm_area_struct *gate_vma)
 {
 	struct vm_area_struct *ret;
=20
-	ret =3D this_vma->vm_next;
+	ret =3D vma_next(mm, this_vma);
 	if (ret)
 		return ret;
 	if (this_vma =3D=3D gate_vma)
@@ -1113,8 +1114,8 @@ int dump_vma_snapshot(struct coredump_params *cprm, i=
nt *vma_count,
 		return -ENOMEM;
 	}
=20
-	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;
-			vma =3D next_vma(vma, gate_vma), i++) {
+	for (i =3D 0, vma =3D first_vma(mm, gate_vma); vma !=3D NULL;
+			vma =3D next_vma(mm, vma, gate_vma), i++) {
 		struct core_vma_metadata *m =3D (*vma_meta) + i;
=20
 		m->start =3D vma->vm_start;
--=20
2.30.2
