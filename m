Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FAC3794D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhEJRBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:01:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34184 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhEJRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGs5gS173243;
        Mon, 10 May 2021 16:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1aMlLMcX0RqPA2m6lirialtj5uOy3HgmwQz216pJU8g=;
 b=owwuPq7i8PftI55jiec4xdPwQnP6i6GHtwi7OG1z3lJ6a3kMs7BYTimhUnZDI4cI5BkR
 IlJqxPnI1RxWn/ntHKFgr/Plkb2MNeY9cvAK0wiyr2BjCiJ+jkpP6hPmLiUTLhghiy6Z
 awxSpmUR4ZO8p43/nHY+xo8HopZejtmEX63ioY100ICDxMH9eR9rBJYkZDUoRSkSSGHO
 z7wUP0BE1j1LIqy8usV51C/2nCuU60oRkSLg816pyBV7BndJT6JoIuvfUpMqgQ+8ufNr
 A1Bsmr27hDHkpNOi+nX2HtgdnsiCVtAIA+8KgTJKJMefLTUDG2LW6avk5N6BSBeumHPf uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38dg5bc2fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGucHA109288;
        Mon, 10 May 2021 16:58:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 38djf74j6a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9j+9v06RMlYnNWzgRbBawmTy00z9Lo91CpYS7dK6f1oYr1OxSaBBDFq7PUeOt1wvFudOq26ZTjwRleuqOh/cLs9cLRrSrhuaSVc1HpHe5B8Fn+OpaeBs9SB/sP4yEbtRGTDWqaKidXGB1oEo7Ek95TTvCAwz0LCgWg9MHo4PJzkovVFJFq6EbXelOq1LEjz43/XQgpnb3YCZlOuGMFYXfHx2j5fy/nqMCattB0MknBDZxbe33cOStXYN6Ezdbt1qOsmuwsuMr831VKyCerRYwriqKr2Wj45+lvcKkYmPbu37Xs0MPEhlcUaNANq58JjH4v0pz5W5KHyXsihjKtkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aMlLMcX0RqPA2m6lirialtj5uOy3HgmwQz216pJU8g=;
 b=LjStVxiJ5hyTrN2dZkag7l0JbzwdqcP47b+pDGUvEnOp8EOTOGKfxyZa75JKICaMXc+bIvPWw5LwMbiCLuI52/7PwHSnk5hJnzS57/+bQVMRFH7vGj+joALpt4AjHiOxhtG3zjpDvJKIwgWbYH1BVoBHj13KTrxtE5zW6GLJDnkhQAAfAxie9U69EiDsOrgZzotGloMPJfm+iGLYYTh84flY72qyxF+3d4sS0TvlaztT+s71+2Aqso156OPH/RtFEomToEzvDYmq/cZFCwXYa295yQt5Z2ygIQ1Qj84VVIowRscYX1dCi74oDOOjee9LxE04thCRIT8CDrBCTwwgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aMlLMcX0RqPA2m6lirialtj5uOy3HgmwQz216pJU8g=;
 b=Ii6tKxOaPd+KqY7jT/t/koyWq0HfAz+tyVtuwrQT/eyXQk7S+NHRxBdFvonXJC9ggmuSEvWvw3XfHhvSdzeSIc0phKWl6tV5LcUYFV5Oc9F1S2pVSgDFeq9qfLM/NCZ+XrpxSJhYwF1iQuHqK2F9seOY38uTmJ1YT8SQbC5ASfQ=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:49 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:49 +0000
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
Subject: [PATCH 01/22] mm: Add vma_lookup()
Thread-Topic: [PATCH 01/22] mm: Add vma_lookup()
Thread-Index: AQHXRb2/5QqU4ByieE67cOKQO9MokQ==
Date:   Mon, 10 May 2021 16:58:49 +0000
Message-ID: <20210510165839.2692974-2-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 2bf6420f-2b5b-425e-693c-08d913d4e1ca
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769D9609C19340694A7AC09FD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LwV/AoGpRI7bWuq/hMOb1My2zMNgnEb4YIshW3z8vmJN1cXUHJEsWYIUX4lxH/rmW9+2L+7TT+uUuD4twA+tUU6j6vSh9/xDo6Ncjeyzg0Q5W9oqsL16hL4vgN9Er2meYOj+EuGVNwlfDr45vHM9fTeIgudNV74mXs5zYb3O3+8xGQPjUuppXSpO3wOMuXzPlUyR5mJCp4kN5XFP3hleXJXiBw4oCPVUatHdOSsE36vpHokdmsCIQJjGKuV2tIgjrO7vfPOxLuuRf0aTP5k+B3fiyzgJspfIYxPcbO0EgUIyZxkp9/w/z+fdzJ6HDjOGAU0fTCnKEotKiKzAK8VESExJCvUvFUfF/OoXfc2pPzD6V3VxPj6TQCIp07nGiQtQtlCSvSirXG0TfCFbLhxTzMdKHGou9kYF7Ypyc6i8U1JZsfp5ZpxCizI4no+u+jBIbcQvv7c9CgCfFeH1nvIEsPN46gH7N13h6IF/osIHtQHLxvpGER0vHoxYXHQ15+PIfk3hZoSGeWryY0499FeCvxSnhduqY8wA5Dl7jhtrM0x3NUGpVLmR+6ZrH4HJm7VTmFxOdjbNe00q1st5VdW9Gz1SHCTWFipJkCLw3iIiyrE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?+82IKxJFP2Mcx+J4BomEdLW1MjfXhvQEvryNpGlChWPoPNMjva88NjFcez?=
 =?iso-8859-1?Q?bCBZfsBrmlHgpYiHsjiObMoey1LGOBjqg6kaZJdzbcVoQDS+Zpymw5A+Hd?=
 =?iso-8859-1?Q?pxgDT7F+mpj2VbeepEy8r0YGYNko2XyOUcgv1GBd1d9+SsWJGB70KvSlZg?=
 =?iso-8859-1?Q?508zVl7mBtAJDO3arIpASQLKeuNUV5bx8jKuRcU63EiXWthLMelfKULqmm?=
 =?iso-8859-1?Q?4+l5kCc5zBZ/ffXV1qhWyJosYDKEl0UWNFsNxdSZV1WWPfTkg+PihG/lgi?=
 =?iso-8859-1?Q?EIuCkfzglfYoRHrW76q7TrSiW+4fBjE8qGF170pXmuSoDT9JwONPUTZkLN?=
 =?iso-8859-1?Q?6kckJF6Mwrbm6vxGNoMsJmuzWAnx15JXFSoO8xmxRjcdbT8AVzF8V4+lIV?=
 =?iso-8859-1?Q?WPDOUv5I6vlZIH5pmpumg99BwXNFCipOnjOab0waIjmG2FHsvyo5lT7O4R?=
 =?iso-8859-1?Q?PAKBZF8qMlTcuD7GrIGN3wkJ5bWVLOoSMqT3uhL3QvfLcoVwmzblYZwXme?=
 =?iso-8859-1?Q?AIEwGOVhSYpGVorvpz+LxNEToXUQ7UPcMy4TURGuHz8gPRbhkob7G0nU/l?=
 =?iso-8859-1?Q?pRkQkrYzlYlvxhtLx00cddtURmAN8ni21xRoebn00ARgiAa5U0wiNApjNo?=
 =?iso-8859-1?Q?2RpwewGemmS1mjGt4wDCyTkHGcORXNzUleqRJfVLHzlfFkfuIJ/QasHP75?=
 =?iso-8859-1?Q?tVAzzxFNvN1UkKcqIUk5WZLYlKKqYtwJjdsk2Kldu6Y09U8L1oO4YBCE5U?=
 =?iso-8859-1?Q?5bXy1FYvkSn1GeEKq4DZiU9Nx0l99EjUio1D0kRfr6nJ3MhK1JmYm3HDbN?=
 =?iso-8859-1?Q?6NLx4dA09t6CmH2HgkyUi6aLtlLgIxJG0MJ8de+6ixDcf1h6RxTSFxh7+2?=
 =?iso-8859-1?Q?Z2mPbLeZc167CKeX4JQBfyQsa50nTq8jPjXFp2KYr7Z+pQPZg9dUm2/zHs?=
 =?iso-8859-1?Q?tJK5DepbhfKr5or/JYv7MomrBgIYTVzD+vV1rOiQaF4nFAmf15MAVCl6H8?=
 =?iso-8859-1?Q?IdiM14Ek+hpDss4Ue6+zOlqoz0rDsPc3o5NW+bZp/2xMn/wWwOoEem1vpa?=
 =?iso-8859-1?Q?L4weBwArv6X3OVS2GbUYxH9s4g1Z0JyrYDvgKVD1YRJYPI3GfWksIuza1e?=
 =?iso-8859-1?Q?OpiSvbCovrcviyvYUBywycfiNwIta1R13ijTa7HZ6qDkC/zmbnPZQG68bI?=
 =?iso-8859-1?Q?efxCK4h9bIeXDttpMtgZlHCQt7vqKAzrTrvCQIQPJ4h487ZNwj+zmw/sbi?=
 =?iso-8859-1?Q?TGeW0oX+banFZ+jGbb8owdRuG8G/SioQZQW3dS2FUUuG1U716VUy/N8HyF?=
 =?iso-8859-1?Q?67ugCXyo3aM0Dz+dIApxIWJFPM6JQb6B8Hi91AQuz5He3peWrCPyKuv0dZ?=
 =?iso-8859-1?Q?l+86l768EY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf6420f-2b5b-425e-693c-08d913d4e1ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:49.0679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utsi3tdF/azWTin62yKOs5X4qMhIwOaRISLFIq0JNB006ENP89qDPLp1RA0hbaAWIwCeg4lgq5+GBRk9l5IegA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
X-Proofpoint-GUID: 4LsPsiV_wRsNMI7Cw8ozY2bTmNfhJZCm
X-Proofpoint-ORIG-GUID: 4LsPsiV_wRsNMI7Cw8ozY2bTmNfhJZCm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many places in the kernel use find_vma() to get a vma and then check the
start address of the vma to ensure the next vma was not returned.

Other places use the find_vma_intersection() call with add, addr + 1 as
the range; looking for just the vma at a specific address.

The third use of find_vma() is by developers who do not know that the
function starts searching at the provided address upwards for the next
vma.  This results in a bug that is often overlooked for a long time.

Adding the new vma_lookup() function will allow for cleaner code by
removing the find_vma() calls which check limits, making
find_vma_intersection() calls of a single address to be shorter, and
potentially reduce the incorrect uses of find_vma().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 25b9041f9925..5f2a15e702ff 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2689,6 +2689,24 @@ static inline struct vm_area_struct * find_vma_inter=
section(struct mm_struct * m
 	return vma;
 }
=20
+/**
+ * vma_lookup() - Find a VMA at a specific address
+ * @mm: The process address space.
+ * @addr: The user address.
+ *
+ * Return: The vm_area_struct at the given address, %NULL otherwise.
+ */
+static inline
+struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
+{
+	struct vm_area_struct * vma =3D find_vma(mm, addr);
+
+	if (vma && addr < vma->vm_start)
+		vma =3D NULL;
+
+	return vma;
+}
+
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_start =3D vma->vm_start;
--=20
2.30.2
