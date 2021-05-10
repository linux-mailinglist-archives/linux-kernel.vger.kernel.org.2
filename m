Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9363794DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhEJRC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:02:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41408 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhEJRAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGsJIs078803;
        Mon, 10 May 2021 16:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=olIov+wfEwryys89fPVdpMMOEHiP33GcMeI8pliqtz8=;
 b=w2dqo+sF9P/Ugcis4OBLLmkNgjaW4v43zSzHRXhJyHXd7Ih0Kdr5++GOiLvMVJI7x9h7
 XcU7RxypbaLTYj1ZWzmvEN5cuy9Pa9MXOtbvRieqLNfxnObg25NQfSY3H5ZNgoZigh49
 AroS9/RFBANdAFNQ7a9KzLVQrq+KAWks0PW1CqkU+l6hQl+Dy/8QYhu0m9+SbE+I0CDK
 OT+ClMXhco5BLG29Yum2RTVF4B7HctWjshuGWirOOAolQCZ7g4hLf8sPSkwS4N9GHqSH
 xJ9Xrb5R5cxi0rHtY6yJ/OkyyQ7UQWMJkQkcWU9IBjxUB1B8x4OuHT0w1ZdcdDnAcwTI jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38djkmbxh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtx3R001777;
        Mon, 10 May 2021 16:58:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by userp3020.oracle.com with ESMTP id 38e4dskqwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jryFHvZPh3NeBx+p2lYOZHCaRCc5+edxprR2QDfbJFlUy7fCibXeSKiVw3jhEIOkcgDTzPprNVQJksiZHkEOYp/A29yLcKJ0WMmz9SNus0rCOI2jJoGGuekoEvqj4+1IoZ+cYLQYI4xFAeJ+8rPlFIP2hUuRxdG1wcIbmBcPfJ47T8Yw4KacgZCSiT5yHNovUibA+Hmr6Q09DXxZU8hZNAeV8LkLvzYzhV5O/Xbqjx400F1243Hbo4mum8bZlqVtnafl+8sl1EQZhW6ekswK9L5TwSpnaayG4mB3AoDWVu1LgQ39eVYdnd25SZW5JrIrPc0VnzK1pivBdg8sO5xqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olIov+wfEwryys89fPVdpMMOEHiP33GcMeI8pliqtz8=;
 b=QB1kpt7mc6J6cUQ+uqKpQSXO3LAJ1QV4BwbhEb9IqfGD8rODvGF5tLPaPDMlSSi2NgnpumgiKx+EM+yvagw+2kVA9vR8RyA2vakpxgV7sz0+e3ckp/s+S2q4EuRE13leY2PyZgB+xg/qDl95ICqwCZlT6eXEAZ/qC5Ik0te6AqHdzqLy9dgdUMbcgAjpvG1n8QXAlkTyx7b+pwlDIg52qFKp576mwjq5y1uNRBE5HSJkLFzTkpV84Kgih2iMAM/0V5ejPjQypNgWH51vISbE2UBwHh7U4VM0ujK15DPfzcZZrRqt7jHB+hAIM6eZi6xigjzrnNt44y7M6I9pWxSPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olIov+wfEwryys89fPVdpMMOEHiP33GcMeI8pliqtz8=;
 b=KOPIwp/jUEj0oUjVRdrvzrCMUGnv7zyIoQ7J4dZDHg3O/3u1bskJ3lxQDVjeUdY59JtMP3jKh2MHif4M0QOH74awExv2FB0keOEt7cAv95uBmESBetYTcYdOO/l9pKwhdd/rCfDIjQtJeuaTHZcYIV9yu5kpA6wMMviwy6hnr4Y=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1437.namprd10.prod.outlook.com (2603:10b6:300:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 16:58:56 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:56 +0000
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
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 15/22] misc/sgi-gru/grufault: Use vma_lookup() in
 gru_find_vma()
Thread-Topic: [PATCH 15/22] misc/sgi-gru/grufault: Use vma_lookup() in
 gru_find_vma()
Thread-Index: AQHXRb3DbZrpe6RAZE6feBS7use0Lw==
Date:   Mon, 10 May 2021 16:58:56 +0000
Message-ID: <20210510165839.2692974-16-Liam.Howlett@Oracle.com>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 7f288ebf-7ca9-48e7-d58e-08d913d4e5f4
x-ms-traffictypediagnostic: MWHPR10MB1437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB14376143B37A87BD76F34D03FD549@MWHPR10MB1437.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hg/WFpsTglpAAJKSR9vyi9QnF6MQMtnUp5pflniYhS076gXPZnXPY4xRn++o3ahoRtySWdeAX/kW6qXrzWCnGrqqiuvILBqSiCcjh/kimDy0+pNSdMJCiH+7Ie7ysy98vHle3VrhHXC+PR08dZXklcKPyBY7GQMkYh3gEQNsm7/snEgMY1nlWGrjzaGOly2LOSrSHyzPxbP8aLYUWxT8PRCvbjf5KkNOCdDijYcLhZ+t9n8AY7GFP8TAmIR4w+DnDTnhr8jgJ/ypEUYlHJ1XYbsmA9+7FpF5yqKXJvGwq/MQX5tXlp30noxTq3Eji3n2esI0Far3OULgO76d8HhIEpBzutJOJtuE92nV1DoJ7nR8hedC70jxroQdbKengZNo45h+GHSaXsv/rea2qokj+0BQrReC50dE06ncWbDIyT6vaUyXlIScRDjZ98VfIdSISfxVvvPENCcYJPZCfzABfFJChGWcQGvyyG70AbA/JDwGBYOBU3X1TG3NzlIbF+xUwK6R4/1y6typRPvnEJQFwDzKuQY57i/ss7IBG83spji0jPRq+VGgt83N6EMjRgL5BKo0XWR3NrV0/8unr4gpJxpxKZ1K1gsUeOVV/O/isdo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(2906002)(64756008)(66446008)(8676002)(44832011)(1076003)(6486002)(122000001)(66556008)(66476007)(8936002)(110136005)(26005)(83380400001)(54906003)(71200400001)(316002)(6506007)(86362001)(5660300002)(38100700002)(4744005)(76116006)(91956017)(478600001)(107886003)(6512007)(66946007)(2616005)(7416002)(36756003)(186003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?QcXtYiV8XPEDpHMdsNfPKmBmhGIglByqtVFi9G9nyPf1iZcdkwI/yPKgDQ?=
 =?iso-8859-1?Q?TXdNLsQigYtULpKBKDNDKQTH5CKkI8Df4d13OSY02Dr2dN5op1BjFH0ucO?=
 =?iso-8859-1?Q?W4inlOWFbOVmOIqQBlFWtAqCTdGATT46opG/EY2Quqygghbfrt5wvYeE7r?=
 =?iso-8859-1?Q?mURbCAHll9phqpxk6kHeNRnOingqtO/DJKko5O/O8bDSIXYHtz/SVj6X7a?=
 =?iso-8859-1?Q?nvx2+cMLlFUM8EqKs92o9c8ROi+WWRq+TSH/Rwq1WUGALIJTSSXyEZ9l2N?=
 =?iso-8859-1?Q?+c4adYnv4KfJncy9QMiooyiHfR3QeZpmnkD7CfHZE0bXprebhlmU9qihu0?=
 =?iso-8859-1?Q?kJYjAG+wUAPQ0P6eoTlY3lQVU8khF2MoWc+oTHr2Jc0cde1kmIB/fVdxs2?=
 =?iso-8859-1?Q?0wStln69YCex+2k4cpdk1mvIBadLIRrWNnoIOTC0MM5meIaXUwXi+5LX55?=
 =?iso-8859-1?Q?qw78tNa5Lgkz40m6CQpWrqBRrIXbetHooUfM5pTznmAMoLAS5yliiiafNU?=
 =?iso-8859-1?Q?uOGBElM47FjmfMe3aj8/5/1UygnIXnkwfkbfvWB0Qa5j35/lRxncpwlBRW?=
 =?iso-8859-1?Q?7L7mEeIAuv5ocNe89eaRyLRAuhbhJw1CV/gL1tAMQXFTnQbjfksuZCKur3?=
 =?iso-8859-1?Q?RfZes4RCPJx3OgBeR7Xd2QwRs2eiWX2j4+PmnLYDJvcJxMq0JygB/pflzN?=
 =?iso-8859-1?Q?D1VTmmDMnOVndioYfy6pQpXhdNBG0MzZzUCcCnuEY2AiBKLz/ewezse4b0?=
 =?iso-8859-1?Q?0XPd/6ov0rFdFp5jR+G906p0FR/HpeJpTdGKiKYZnCxhsVQ1nzPyu6PNF2?=
 =?iso-8859-1?Q?QdZS+kjzM5cjTFJNHwxScJ7027dSFUSc+viuuNwfac12nti8T8yFQMAIo3?=
 =?iso-8859-1?Q?7RHqV7EKIY8OynfsU860TF3z4Xc8u8n5UTvPJ8VnDXdp30agSLR4dRRL2j?=
 =?iso-8859-1?Q?nkC4xLQwRpEhb8pT/IemfGD483fvux+r9sUJ+lMeAWBNzAQcQSLWvroBge?=
 =?iso-8859-1?Q?HVCOwq2WUJ4o0KYycDXCqpOzsTWXMGd0zmXsaQwJQn64yu/38dNIdpolct?=
 =?iso-8859-1?Q?ZQUJQO9Jj3iFQdgztn/r3xeD0MWKSxdiy0QC9iM2sEg/sHBZkg2z/Qw23w?=
 =?iso-8859-1?Q?PSYZgBY9oVTHM22CLux8WzrICJFFB4TKyARp4dlG5LKm5+rF3Utzfw22eq?=
 =?iso-8859-1?Q?FONhw5t2xIRDweOfUWG1Wf4v4aWDjMyTmoWNmN0oewB3d+gznNDWbXj3cW?=
 =?iso-8859-1?Q?UvvmBrFWu5GdN9aqvz6hPwOYptX/WvXmzBs+hNNyYJKrGxEOLaDHKuF7pd?=
 =?iso-8859-1?Q?yOZryb33QAB+2OggYoZ2hPUVkZQ26HalVah+O382TG+xRdtdVl+FZlsCDZ?=
 =?iso-8859-1?Q?Qs/fWY0VyG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f288ebf-7ca9-48e7-d58e-08d913d4e5f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:56.0568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pl3Sael4nEy2oLKWveWR4Kr0sbMkkCmHq0aeuaKaOnIlmLWWNOB2BX0fs+FreEQqnj1EXbzAsqy2Vl3FKl7edw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1437
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100114
X-Proofpoint-GUID: zNyU0AojRcZ0UmxmLBzwBmg60sr0HnK8
X-Proofpoint-ORIG-GUID: zNyU0AojRcZ0UmxmLBzwBmg60sr0HnK8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/misc/sgi-gru/grufault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufaul=
t.c
index 723825524ea0..d7ef61e602ed 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -49,8 +49,8 @@ struct vm_area_struct *gru_find_vma(unsigned long vaddr)
 {
 	struct vm_area_struct *vma;
=20
-	vma =3D find_vma(current->mm, vaddr);
-	if (vma && vma->vm_start <=3D vaddr && vma->vm_ops =3D=3D &gru_vm_ops)
+	vma =3D vma_lookup(current->mm, vaddr);
+	if (vma && vma->vm_ops =3D=3D &gru_vm_ops)
 		return vma;
 	return NULL;
 }
--=20
2.30.2
