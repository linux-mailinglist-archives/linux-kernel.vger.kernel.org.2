Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE71D3EEFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbhHQP4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:56:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44056 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239873AbhHQPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:11 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjTxc006859;
        Tue, 17 Aug 2021 15:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fS8cZLKkrHj/F0zQr1H/K4jEWGHQRa1IH5YGaFNZGdU=;
 b=Yt0FYRDfl12Xk1+Mw3EZeR3I5iIJqBF4xAXJ3qgzUyR0LxK6hiv7Ahl3HLjkZJEbWKk7
 77eqov1qCgTJ2KkCA4HXs7DdgG3OQbTuPnD7F+yNCtJbuOyPr7i2yUlOKdqQXLWixnEx
 3xuDglAclKzcC2adzdvtiCJuo81qlMG2eV8OUBxa2KEgVlUZ24bRNeY9gbjZZtRoWpSx
 kxiwKgnUFQX3w1a2Bn2dcSrjKeek3Auubif6YhvC6yRVRaHIvQLlE5W+zrGzwqV2xCZJ
 e9KEu3dZicI5iibZEMHRArMqGzQtrzSHSYebu6MtU3pmP8tAULkQf2x0Gx4YtlVwD0Zr 3g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fS8cZLKkrHj/F0zQr1H/K4jEWGHQRa1IH5YGaFNZGdU=;
 b=ejegl+BJalZiOnCF+zR9ZUTYdc9dX4dJppbCXesJVAYdBjcM/DSetPtTrclfNuTsTnSM
 CQvl9BbDvBDOnio3Tg6JrLgwivPuxOxxkCd1Du6wo7Ms97ylPWeAYjc9mWeexLKhBYly
 1Hp9f9at4mGZAwM/q/WHOeXg/k2paDI3ioxsaqxEPCcNtLEfUjurKbjaTBpVjl93NetA
 y8+hVXsQ1vaCGJWVn/Z2fR4D6RA3pvtiZNvz0YKcRVgbmgLibe4YnXXwL9Er3PXbPRte
 IK+g9d+opFWX5ypC5z5m4YnWCkWa8uQZfxRnPVJtTO2NtYi9DZ+7rfQSvooicOcGKRd4 Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbc9x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfi158706;
        Tue, 17 Aug 2021 15:48:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2rlNkvSnjMNwa65ekbCyE4f5iLcc6ulh1Irtzlr1BopemVn6ZtlxgpxyYH0SzvYH85VuoqLfkRktluIcbKsVlN5P/X4i798KuAGYqiDNCzxzaY/Dde7gUx3OqhXEo950V5zT81H/35sF+Dj0yT8GoRVCbqIaJme6SEYTdnpoh0iNilzazvyQTWYJXPs5rXdHR1pO7KJe2nwea/0gKnk99p4O+64F6iZem1uR5QamStRH8+wVD1zJWk+C54dBjrkO8oxboRi8q5FFHScE06wi2xHXD89USm0QRYpO4ZMFfPWTqW2mYTJ9vJLpZlENFQUOHO6ys7YWLFJJXoQXgoKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS8cZLKkrHj/F0zQr1H/K4jEWGHQRa1IH5YGaFNZGdU=;
 b=mMFd89LGzfk9EV+CIsVcch3JDSdfzyP3AXvxW5PhDAz37QmuJkQRi748ef8xzSg5PFEOmwK/IWrV4Qb6xgoq6Bx2aGabJDb0PISK95hVFkOOjJ/DF5FicZagxdGehdrQUVzqKf9Tq54bUE02SvCnqPpisy1QPo0ZBBk/TCu9nLrLuU+OyOSlev2ZUyaH+bO1iMqSZtUc5BrgO8yN83RXmN6W8f5VBrhxEoC4gaU64n55Y+cXf8PvtYuq8lrmuAkfPsrpa9mB20AfcNSp+/mVQ7M6dhlOwC1FHrK163JwOtCbRARa5u6CfuVpwPTE07bem3C3vnqhekt+ZUZhGqhTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS8cZLKkrHj/F0zQr1H/K4jEWGHQRa1IH5YGaFNZGdU=;
 b=IFmwHvpE2+dcdJx9D5u1RvgowDVA8udxEjpEOnBRwpp89EM4/slDo+8hwJilUImsAGarIy1DA1v4DLqLAxPkeE6NHMsOv6Luh+RL2ufThUiORHc8AJCS2FoHFRWH+IWTkvn4DkKVGLP+epy3HLa8DnVFkGm0pC/xi2fmT0vlgk0=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:58 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:58 +0000
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
Subject: [PATCH v2 57/61] mm/oom_kill: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v2 57/61] mm/oom_kill: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHXk38xccKM7ah0Lkmm8L45r57zWg==
Date:   Tue, 17 Aug 2021 15:47:33 +0000
Message-ID: <20210817154651.1570984-58-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 74ee029f-0cc3-40eb-e71a-08d96196635c
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3580A2D27A599DFFA0AE3E83FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:208;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lXoBehaESRJF47W19hHPTo8+nd2tS00J3oTWCWUt8WWof4YYEJJIyWVYcLU6LukmMDVKTkHJ8ta2jV5D+sDOG26tm2fhH8DxgonB9Yg0Zk9zoAs5IoV5/yORVTTAP7MV2hDmQaNX+gdoa+RNrQXpf1FQ2jWZF841rYZheit62P5h5puAp+aE2gegtWVgUGT4s5FuuGL0K3xKi5u/wfGBp76XiiqHTnPSM+Qt1lADtZ//hhIZ55p75n2V4lBEixSwavcbFbwqOvhvOF4wGD8jbtgS1VrG9NZU6s1FqPXfc2SZdgaLS/E3rOCpTX0+JdzDlLG78yDTyCvTCf5aIMLwhUjkipHt3GzPR7XsSatCl8kQQbbUb3/E7K6RW1Y1r4A0IcfNMyhqfsGDSubp/SZZ3BSZECgC8+5ksK+YuXTI5/pOX806eOCikcvByAwHA92WEEF3yL2DqOZ/EHzanTh/fd0jMx3l5KpzxgEFMMGlTdwBbvn5p5UJTDGRTwUuQGsyk3pKYkcnZzz8Aw2GWHDsmu4Qp6vcws35u8Ub8q2yyIYvhO9NuJ0xyL3TibdO879AIZTGOA8hqESCu4UEwS0yjAwT3xM0OeBZVLIXELXdZkdUOenBDwz5LXgx9bHgqnsB1Q/e6J0f84ADPoKw4ON5NyZy3h6RPvtJ8NOg1B+8zSLkYfKDOagYF6QD9l+LfU8gfhHEE+e8UBnLLDLVYUPMxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(4744005)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gdkyJGUw8BE49oJiyLaFzmjHd666xVZM7tugEqifqcdBln55iP1aR5m0VS?=
 =?iso-8859-1?Q?Z51AKiAgtHpYuKNdbQ3APa9aO2htpkY17v4HGX1UIRRyHgPxpsiDk6jKti?=
 =?iso-8859-1?Q?fZOo5kjvJDbND/bnpqubTzRku5WNQUmzO+u3imTM9yKstv/MOILUGmr8tA?=
 =?iso-8859-1?Q?g4r2DNax4JeRazDI9iP3KhYEApK6lYK6DkOwWbifdO6f4B5cLI8SKT/33z?=
 =?iso-8859-1?Q?YbYH0cUTRdY9aAWorpB24dQP3aGxAn1ygbZ7GmwJiJUNR+6wQ/yVTPrDQd?=
 =?iso-8859-1?Q?U8U2a9rmy9fATVD8Ogk4/Io3ZwDqVWSIj64aXDrRtOUNNA0UqY5N5NSpWc?=
 =?iso-8859-1?Q?HvMd2QuDCJ1Mdq3oWKUCRZSlEzf9obdTE4+p8SSNdnsjeXLt3QxHtv65IC?=
 =?iso-8859-1?Q?/ViYLVwoxXswYvl0RdT+RLhv22mmTnR1FhlaXpY72f7QfYOJjvEoiK5o4P?=
 =?iso-8859-1?Q?62UY3IU8UaMCxEexlkLWPWqI7l3ByK1I3axcsewaUAByqVcG1hF6TFEROC?=
 =?iso-8859-1?Q?ReDAL4LWBok4v8gtjNaQp66AcBM4yQACEJ2HK7m0voIA3qAx/qsJhrRA5Z?=
 =?iso-8859-1?Q?gfzAhImcqX+7XrGrneEmo44Wc7SxLfgX2axoVyzTR5gwZAev3/erEUtFmv?=
 =?iso-8859-1?Q?ogAv8K0jnATXj58ELdxEky2gBuhjjrPAr0jX9zrKSa1mZoVWOx10NLYkCH?=
 =?iso-8859-1?Q?RQh7Jcq/+SwTnQZ+bZv834J/4eUtC/XKB9aA8pFNFqmYuF8shHqDk3Ut4B?=
 =?iso-8859-1?Q?/Gq1J0QK7pjGFKk6l30Uo1OffuXPzvXJLH2x4c1AnNLmOrqBQfx+3INe2h?=
 =?iso-8859-1?Q?5oIWYw2OA+729X7RQjKk6Epv++zQUKQtOuEjc1vG/iaTre01Y5CGWpRU0u?=
 =?iso-8859-1?Q?oIrU23XOVJa4cjeJASJYxlFZ9OoY1WHiDLf3MmuWb7mdSn+K8SdvA6qdJK?=
 =?iso-8859-1?Q?na634r1uapbWxr6bFJQ47sDhNLiXZaVpLO4F6a08nMhFpMsySrNR1PgwhD?=
 =?iso-8859-1?Q?CfP9l0M9d4zHEYw0CwiCnLNZ5FuCsII2rEWHjHVG2l56du41d9BOqmW9C2?=
 =?iso-8859-1?Q?tlB/Uj/V2O0o/+e9C0sjs4K/5e1GUROtlp0JOC1bilDkIAoUcOOLblx0nY?=
 =?iso-8859-1?Q?+rNKjFuFq/vy2pyycJJQmA3b34dKg7n9qY5VEPnMrM4MFbzcEj1ai4jiVk?=
 =?iso-8859-1?Q?jWQgaLq85Ryp9FDv7tz06k8udsiwNXeF1gXmYiktC6vzbftL+D1sxfhwmj?=
 =?iso-8859-1?Q?JQx3mojNOop0rEeoeH7xfqb/c1DaKL7z4qxHVwFMUlciMtnaRj990vV4dD?=
 =?iso-8859-1?Q?UU514A6lVIzKfd4oZSG8hkLiS0NfXA6utNBZ+Unud9nAiMR3AiWVx0ZzqT?=
 =?iso-8859-1?Q?Gm2Lz0WIR9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ee029f-0cc3-40eb-e71a-08d96196635c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:33.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ug+QWEzeugI3COC3cTLZg/g5svdyIr5QltdgOkq9r6/34ACMKdWl1/gq7N6tS+4oCMgVLFj3AGXSMs8M30H/fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: z9nhQQqgdVbxOHyOMnuUEr9GULANq8kB
X-Proofpoint-GUID: z9nhQQqgdVbxOHyOMnuUEr9GULANq8kB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/oom_kill.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 431d38c3bba8..40a01f334735 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -519,6 +519,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -528,7 +529,8 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!can_madv_lru_vma(vma))
 			continue;
=20
@@ -560,6 +562,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 			tlb_finish_mmu(&tlb);
 		}
 	}
+	rcu_read_unlock();
=20
 	return ret;
 }
--=20
2.30.2
