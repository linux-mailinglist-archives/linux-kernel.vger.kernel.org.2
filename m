Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6A93794E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhEJRDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:03:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51812 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhEJRBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:01:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGs35R073825;
        Mon, 10 May 2021 16:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=R5YaIiOIPcogBMiRGu0ElTp5Suy1rDI5DigjpTd5UYI=;
 b=HsIsdan5e7md03oi4Y0Xf/0OTTDEN91N0TvAaK74JjO9vm0PEAiNe3Q8fqxrhU+1SF2j
 5zsL978jjp/rXZCX0UdD3Q5WQA1oMB+ANoZgDVB98QSX2Zu7s2fugOQ11tdbeHJVSBe9
 RCHBsSd+aJGKf487RaBE37pTZbgaqXHGvvTW3ybJlQ9lWH9D73PbVbuzUnsd2nkdzDIC
 cJbLvOIh0DSf/VuSOUcn6vQkTN+a9VazwK5WJxv1Eu47FyzXcmJi3l5Tc1/KequRf63t
 yUQSq7nIPf6J0ooKQPnuSN5K80+ynrg7TM74mT+BvGZjA9YNUxwf49E3i9QgkdCXa/ZH fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38e285b77s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtfFg036499;
        Mon, 10 May 2021 16:59:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 38dfrvs50x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrnTqCsy91F+C/Nvgn8Cpf6UBH141L/qbOg8TpCVGyDYtXEjpd9iPwHZdR89/g+s5/dgU0skEnToDZpGxE5Dg6odi0dBiFoSW2S4a3caEqcmsBi677CjN2APoSb62kIBXII9en/YAt1xam4cnLkdfn7G+ZbfE0RHcXMJ4tsHe4GofQoJ+LzDAaFQoxbkPCvhqerFvf+wwQsK4cv9tm/gPRY4P8FJIhIXcU7a+BW/XQmWExBaDLDZmlQlpLr7D7S4lhPeZ+pewE+xylzdQj5PcnnM8guFURgRrTOGZK9sdrEteir5U5NSlhN3hU8Ly4n0affVbGGNraEL4VsQ9Mt5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5YaIiOIPcogBMiRGu0ElTp5Suy1rDI5DigjpTd5UYI=;
 b=kZWQ9mq6emEIw4roeT5WiVxLfZspzeymgtg0ykARNq6su0FTbyhV8+13SWhqm19qSaHvMiaooClvJyRB5Fc7GmMEXTVmeXOkJX7Vk/mkeQE+JPgHuLKkOoHhtHqsf6STSpWXKgp+jQ4ck1gvSGwSNFRdAPcW84xgMtdzlvhYZ0Qez/lux8lYKz8x7zRILmqtwGLivLucDldQtYZVqlRVPmYVtQymHu0/xnMdf6lm6KXA39iRbx7lBpEYgRgcWkqLF7Zt1MSgYLFGN4X9fupLngiGmQFVswLryzzKClW//uZ1f4tXTTf8WJCt27lezz/7KWefE6PR1g2oPdB2aX3W9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5YaIiOIPcogBMiRGu0ElTp5Suy1rDI5DigjpTd5UYI=;
 b=HwKzMVZD03lMtKnFqDl0SnqUgyKaZ9dTEF1FpKNCJgF5QOYxWlxDG202wy/ribI7tyz7UffQzRqfoMKL8rk4FzfpgRDUPg8FCTnRCv1cHU2qGMvyPZ+BooFfS9QVKvlXmJdqVY1j9QvPesF+9oBmlUs6FOzUrNtXrM6nYMfJvg0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:54 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:54 +0000
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
Subject: [PATCH 11/22] vfio: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Topic: [PATCH 11/22] vfio: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Index: AQHXRb3C3iM8lSkalkiXrBF32J/82g==
Date:   Mon, 10 May 2021 16:58:53 +0000
Message-ID: <20210510165839.2692974-12-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 323fba9e-95f3-4980-8adb-08d913d4e4ab
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769A16556D29FDB5BF4A5F6FD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JYJVX9tX78x3lV1+fbqYQZiS6cBChtfRhnHTcKCIPdHEvea8AyqA7mGgSVuAI7OK4hjI9AfnZv9QEIZBdRo01PelphMVenEURgy12RDMhp3iVzVJuUwJe0hepojCIjaOPkKRECKvRsYq3hLmD+tAniG2sDRU0u0piRAAMU822Elwt0mDp4yzWvogW3nKbf7d4kR0HIPVFspZXBbaP/Eggd7jcwi2rcWq4yOlXuPgO2CxbnBV78aclHH00rUtmEfiFnUkhcQ6UP3tOybCKaklWh3kj9yyKa7D6hFn6RyivcRcNCYu5PNgFGWkH1MXldqd0tbZj0noH0P6j+HpoIggQxU7h8TqSySUJnDwdwhHtMxmO+WtCPDDlFt1KdUJJLLodXVoitxqjD2PzxURwUjeT1mluokZ6Hp01lDr9qij6zK8n6KvPopqHqIoTc38buOy1as90Z+hp4/xGeZJVnFzoIBFl9E95AZ7kiBJ75sylCzVZQV9xq6V6wuHcNDwb7tmCc+YAcUlXXDitpGI2LQJdR+7+jfHD1YHNbq+lap4Q6OCHng+bqILPZzKBSzktIa82NgtKg8PAWd7cVjVtZIotf4EM49DvpFQRkNK9IvX4w4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(4744005)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?zY88PmeZW8gUj4REQ25Bxk2Hax0xuv6glrm34EMsz9iYIeFT/diSrZzMC3?=
 =?iso-8859-1?Q?B0Y4nXcQ2xlYNmwD+lqj+IKiiReoS2H4+4NQexLFq0a0MqrU7G4DtCG0PC?=
 =?iso-8859-1?Q?zvvZ4+h2n5rP1AvUY5hFHafuT8RcCMUGdzLMrKf/4UjNsZ/TwA17L6eDsk?=
 =?iso-8859-1?Q?Z1AVQLLHjIsE74NbCyOPaEj9lETmvRoLAIiW1UGFmmpnlmuuasTij9Ns4o?=
 =?iso-8859-1?Q?KgaBIIRX+oyreVGDqiA8D6P1kdMbrKeV4BSj+CBL6my7Lpm5kAEMYrbqQI?=
 =?iso-8859-1?Q?K4oZ5BXuTTGUYBq/fiYP5G4fLDDX6GEm5pNSkh5aMYnZ1VIbboqdmmGKMO?=
 =?iso-8859-1?Q?NVfjqGlWHLUdwiK7WlqYQWw7slyByp2Ky+Cef1YvchWwgJwT2I7/e2FwXL?=
 =?iso-8859-1?Q?T9ZrpKSf/4+f2X0bGseYtYw0YxXVKKc8/MQPfs0WZD//ditTslmFXvx5x6?=
 =?iso-8859-1?Q?Fbqmr862KCEnE6IASlqBoS+YRSnx63F1EG9CEGIZpYflIs2isgw60o8x8j?=
 =?iso-8859-1?Q?1p3yp8mp/Ok0f344obMT/zJw3hbVA87uuTVTSnX6o8Pto+V2sfqrDxI1+2?=
 =?iso-8859-1?Q?GX6Do2KvO0BGRkM3KcmAZjNW+oPnWsI66foGWn69nq0pZMb6jOq5zVgvB4?=
 =?iso-8859-1?Q?f1KLoxyY3dLDDFBr47asinL6gNPIeWk+0V9N69wI6lOMBV+s9a4sNU5cMo?=
 =?iso-8859-1?Q?1Grz9r+aaRmLQQyCV+MSp9xhSZJpriqZwfGVEAlckSsL/hBhRHQqBliv/T?=
 =?iso-8859-1?Q?VuoaPHenj0Ju3Yij2aAaD3CNXb0OySyfBKVLzK9a10e8hx2xhDrR3f4AlG?=
 =?iso-8859-1?Q?qJRZeUs/ynXH2k51i2BLQd0b7+cRdJPLfrlfyftTxqKdFrp/ZjnDohU0CR?=
 =?iso-8859-1?Q?Kbx723AlGn0sZBY7Z5L2Gk8Gcb4lghhXC0INxfophQ+UR2wG3t028bQTjQ?=
 =?iso-8859-1?Q?nK/e+B6afjFZ3mxdsbYAwLRLQdwnLKbf6YCNQZcSh7LBxBT28kGbbT4+/R?=
 =?iso-8859-1?Q?L0M4KNdERflBUpNDOYiNW6OYOKAjwsl6i8CxWLyERutF7hWEwQ8gN+c7+6?=
 =?iso-8859-1?Q?NMFtJs1kHKf11lnlpYv7/4aamB5K1zNbxcRpP74lLHWlaFHF7jHIZJQrFf?=
 =?iso-8859-1?Q?UdNDXJOuwkp/qst6eNCoChuL24iE1XQrDZwfg762oZcF1YBNDpsd084u7Y?=
 =?iso-8859-1?Q?TJ7GKnN3hXQlFSNCdiVXIyrNyeLInJneBxOhNLu1Dm2U+9JjghIzQ+3l3g?=
 =?iso-8859-1?Q?zS7rGZcX6WJWUPlYvmnGED087mCk9avOrwjTa/iw7N4qWK4W76QbrwvbuB?=
 =?iso-8859-1?Q?FjxedHQmsmwvz0/NidnoIC/144Ym/I4kTlyqD7C74tMQFFq9MaEUBXqZSp?=
 =?iso-8859-1?Q?ETWxin57O4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323fba9e-95f3-4980-8adb-08d913d4e4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:53.8808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3F9YDc50ldHa5BEWHtJKXrNvojorqAkGb3kqAPTNJbc+UuAJFxD/isjnEQGh22AtllZIgUcycEUxsaS77662g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100114
X-Proofpoint-GUID: xpbc4otmZ6TJ2wXVrlf8SvXKIQ3C6ulV
X-Proofpoint-ORIG-GUID: xpbc4otmZ6TJ2wXVrlf8SvXKIQ3C6ulV
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() finds the vma of a specific address with a cleaner
interface and is more readable.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type=
1.c
index a0747c35a778..fb695bf0b1c4 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -567,7 +567,7 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigne=
d long vaddr,
 	vaddr =3D untagged_addr(vaddr);
=20
 retry:
-	vma =3D find_vma_intersection(mm, vaddr, vaddr + 1);
+	vma =3D vma_lookup(mm, vaddr);
=20
 	if (vma && vma->vm_flags & VM_PFNMAP) {
 		ret =3D follow_fault_pfn(vma, mm, vaddr, pfn, prot & IOMMU_WRITE);
--=20
2.30.2
