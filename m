Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6275A421BE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhJEBdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32262 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231200AbhJEBdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:25 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951DWvE019244;
        Tue, 5 Oct 2021 01:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jOKEBeqUdNIGuNIf1dln08O5YJigBOo1pWuIZqhtwyc=;
 b=mwhsKzO/nrhhApcxk7Zr6Q1vc06tQdGt2JpfkWtdHZfKcZXBp6uF+VZo4VpbpfrKvxWT
 trmG0gtxftsx26Jtqxvo6vhV8yRsMrXH3KrbsM13AkHpR34Iq3uqVIVqesbzlWlqVHqV
 p3ip+MwrmXN8w+iQtVgtMEi2K3AFfuuRQ8l/ToHuctoqp68a+W4ZMTjEpZRggzdaFy4F
 OGs4QnInT3jERNO1dibfmOPrN8cBaeteTayDn2HJWo3UP146pm8fRaokgyhB/ywleXGB
 Ten8iKdOzBgEaJd4WJ1teQe5JeQQ4uO1ljCGyC4J1cB2rVTbtNT3vwk7UlN1RRAK9RKW wA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5c99e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdGA141646;
        Tue, 5 Oct 2021 01:30:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+oVy2i6/DHWY0rPyubj+wPrPagdHwDbF4jC7+vAPdV84QglbqayiTDdlDw2UWQmE08VkfUPB6gICxr+1aBAh4PIkoWZNwFwegFMaJYS/w0Z0XUVm1HMgwhzhan0Ijq9GnDDxLK7ArLftOYG1UbJ31wEqYbD0sP2O7fulfHLF5IiHlYwOPwLUadn2u0pvyDTRgjoEAcMNlsqIBLZidYe7HPMxsJe1LPkJ+0e5GX10ZQtHooMCX7KhEfChXD/Eu72cyR9W22Pqs786Q13Cw4BvfBIewodtN6pNb89/crmHnGtaef3pv9Xy3soegUaYnKkQGXcQLgwlV2LwAVDW9WjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOKEBeqUdNIGuNIf1dln08O5YJigBOo1pWuIZqhtwyc=;
 b=a/b5vM4jV3fvgwFAOEGGxQi27K96sJ3ewvC5ZICzSoJxePjBSHeMB3GuFffmC7vl0FtwKXG3So1Jc+IGlx1muGgZR4gUyM3vII//s4UfGy0IChpJBc6wzjJSmKfCBvJxLbz+7fV2p7BxHiCqrYH3uRgrrinWv2Yg4N2JEbSVmDQd7pFWC3KKC2755NjEocvQ8ugAwTa9NDzgY1PcEeH2srFgl3K6KNwh/A8vy4g9HKUxcvfLIoPSWu26bahHsv0Y8c0QIC6Y/iUxgnKpjFMH//dwZhwdQfuGOQvvwJEvdzjX8+C95qZx2qfkU3nuD6dp9/LNJesVyLyRW0HHNKW9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOKEBeqUdNIGuNIf1dln08O5YJigBOo1pWuIZqhtwyc=;
 b=U8cQQlo/ab77Z6DC18Jf4Qd5aGMO4Y1GAxmxFHrQOcUhPyMv9H4RLpKw0cIfF3DRsVFJOn/y7AZIYyhrkFs/Wv5kXCMpE0inCBZnrPiW6mzsgMSVjj3YIpbXeiSHntYQtlGRi5zUb2MkRop0HhAWzLZjENJiPzoGJn7hNgOXhaU=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:48 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:48 +0000
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
Subject: [PATCH v3 27/66] arch/powerpc: Remove mmap linked list from
 mm/book3s32/tlb
Thread-Topic: [PATCH v3 27/66] arch/powerpc: Remove mmap linked list from
 mm/book3s32/tlb
Thread-Index: AQHXuYifpOSQiqS9hkiZRt2nU3d6zg==
Date:   Tue, 5 Oct 2021 01:30:47 +0000
Message-ID: <20211005012959.1110504-28-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 0021da90-3b3b-45e0-e3b4-08d9879fc270
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044C619680E72B615FBD7C7FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4GD+Yo2xyNf6BW5axeg6KmJ1Hdv2fme6f3cniww2UuMYsF0HG0xIBpECSoSa8ajs5TNTGOoQch/nZFS5pG8cSay8kShMutx1FcUlcjuuauTzXHdagGAhPKZR8hPh04nki3w4e2jhwLLCpA+SV9wiQ/CPyzpN9zkRI7cGoN5mg0JAgIksvdtlBJ3jVc4E/4LmRtdrFFSjkkXP0ZiWmTfYM7HJuQ8ceCmS86V9NiTj7PYCp5jSz5Cfbfok3ZBsVHDhmH2/qHJuDpOcGOo5q+Pt0mOgy4GkcLbMsVBo0w0PrTp8g7yulSor93VyQpmjGofsGlwMiaKU5hTaOKOe7efQAGBgO1RbTfqFL6HQS5n5AU7OuZR9Yv8bSIeuDn0ENd1PvVKrK2RWO9i05by8m9V+8+tt/Vwf+d9p56y/vIM9dHbJM+zr2TU9EY+mIRCrMuLbCAoENv1mSTl0A+AY/hTIgaA7p3A8Sn0L69KOmgrhE9LNrs/XdRxpTy5EP/bXns4h7KwGHpGYUrkNl35ZuM1REd4Oy6CVdknWmtD2eEAW2SFigsxQKdn17730lYI1bcMIJ9UaqxokY/vNkRF32dlICHLY1v9kpDAdQROadGMKnLpxVT2XYXF/ockmqSfrYEjCdWGbRlDm5hKaMlXW0jcad3CiG2T6n2HgXme8j6kgudyqNhQNqse3K6h+RO7aXILlWSg9PoTHkf6p+a5DNdVo5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WFZgCNx9R31MCocUvf9HW8LjrVc5lrjYxlFcTER52/4Rohh32D72kLBIvJ?=
 =?iso-8859-1?Q?cizI76Pw+tl6z2Bbn09lZkrVvCq7mfw6OBeZDdKuLPpCLtILUAP+wuJfmt?=
 =?iso-8859-1?Q?eSzgpDHNVhnz89VSPwn1qD3wcNeQsgCP5czsFKOmSM7YwIK0PpjzqbrZiR?=
 =?iso-8859-1?Q?JOQtaH8pxCVYZMLEWcqw9QkGMbpEh+kBGBXaKVMaUZT5DzRDC6w5ZZcaes?=
 =?iso-8859-1?Q?A9evwQ1kfyXzYbMXacvvW4PWf9ymLBuC+PRDueFa6+RfFobg8spD0Ye7j7?=
 =?iso-8859-1?Q?ggHtpe8JVmjmsNlBJAAikK65YPNenBT0/CuFhmBgGKp7q9clIhceMNOeqN?=
 =?iso-8859-1?Q?yQ+VNBNZsNkQk500wi4KCL87TlgYKQqQzmukG4IPDfdHsOEUIgnIklUn2p?=
 =?iso-8859-1?Q?Nhw5j9HAOQSz6blXJ6raZMVlGb7WJelGt1sALUjU3z4Udo9SSICW8ktAq1?=
 =?iso-8859-1?Q?kE9bF8LsqjGYSr4Jdy2jd/op13UCV+b13yV8QRJLVUk8SEX5AwV4AVF1CN?=
 =?iso-8859-1?Q?RHCVNrxFvxRBZf2roqOEBrwzOYaXOwsfSMSpKsVWgha0cvBzX7V/97R//7?=
 =?iso-8859-1?Q?Leq+FUeHAMPEOw2rN5h2U/je0/q4iPgeP2CkWhlOQC4uzPGjSDY0nI9B4b?=
 =?iso-8859-1?Q?3gUheg79/Z65ogTvNLxE4e0qseu7i1mubOOG0fpB7DznUDpMcsFcQttRVW?=
 =?iso-8859-1?Q?/ZYdao/YC0+jxPr1wf7ZxqxUQ/QIVCXq8qASBOYh7YS5fi9LXJhfjpOUfb?=
 =?iso-8859-1?Q?AJLadKk3yQkexl7ovKteeMS2nOcVbDZa0YjXvm+ujBWL1kMc7uagGQHEt+?=
 =?iso-8859-1?Q?kbLMXQ+y1D/LHCsHMyySKpjB1kSDZEenwpqdS8fz2jY5XIrps/MbDrYZjd?=
 =?iso-8859-1?Q?58OlI9qVqYsraOYkz3qJOfrW47gbdWa8VR2mxiq39l3wbB+ZyRXOvXA6le?=
 =?iso-8859-1?Q?1mP5ehapE6Tp8xbugVrVCWslY0d+ssss/pT8TpTbw7NvSMWCivgVi1GyGZ?=
 =?iso-8859-1?Q?BcbVA9HxwEgc1wizwr8bk/Iqzuorqm446eNleZrbdK2P7xZhPGym6Ey6CU?=
 =?iso-8859-1?Q?LUhrV/Jl6ei1p7WmsH4EfaqBeX7XD8J9lE8dFypeHtHAA8nkfJxjgwnT8f?=
 =?iso-8859-1?Q?OkY2FnQRo1LBOgPQXzr9HEUXQTUeXKl3O3FAPMIlipqDOZO5PSKPbcNj5S?=
 =?iso-8859-1?Q?4oFq1nkLVZ3hqv4+L8DwWukqsUIRqwgLHitqq2RvQ5DhYTmxYQM2gbsw7J?=
 =?iso-8859-1?Q?oDvV/+BBnSijUSHNRGXfJS3W0PX1vaJBgidiCEUotUqzS+2dM32xqdBaX/?=
 =?iso-8859-1?Q?VddeXIsxnnb3TFYSKmERg5lNCspFj1mE7dCrvGfZyBai0bSQqnk9KTkmty?=
 =?iso-8859-1?Q?ISeUf34sUs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0021da90-3b3b-45e0-e3b4-08d9879fc270
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:48.0284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hC/NHZfMnMxpuuzy3AjmWOYj7cZC0Tw/ibCG22J8YqItEF6JEKKlnGaEWtyUBweSx5ngHSxZLP/6YIL796zOQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: -ggmDeG0IGUrcWjpFC8maeKrTmZcsgKA
X-Proofpoint-GUID: -ggmDeG0IGUrcWjpFC8maeKrTmZcsgKA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Start using the maple tree

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/powerpc/mm/book3s32/tlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.=
c
index 19f0ef950d77..2c8b991de8e8 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -81,6 +81,7 @@ EXPORT_SYMBOL(hash__flush_range);
 void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/*
 	 * It is safe to go down the mm's list of vmas when called
@@ -88,8 +89,10 @@ void hash__flush_tlb_mm(struct mm_struct *mm)
 	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
 	 * but it seems dup_mmap is the only SMP case which gets here.
 	 */
-	for (mp =3D mm->mmap; mp !=3D NULL; mp =3D mp->vm_next)
+	rcu_read_lock();
+	mas_for_each(&mas, mp, ULONG_MAX)
 		hash__flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(hash__flush_tlb_mm);
=20
--=20
2.30.2
