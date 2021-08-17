Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A13EEF80
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbhHQPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:53:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4906 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240190AbhHQPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:31 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkFID022513;
        Tue, 17 Aug 2021 15:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Lx1GWcDIbjleONuQrmyJyOgkhqs6os+pisVZKxT3iuQ=;
 b=Clv44DvrL3BHgskMR6R9K9Zm9uVL799Bqpxgj2RNh4FVmBcPhZxpKgNdSWOZeeBIcLah
 Rgx3jH/lt3WR02QORT7yZEay/pz/IdQCzTLZJc/NrKVu3z2i/37ae0hAuPTn1wPECCOY
 wy2gnveGOoixN5pxsbHKZlb2mTNLQunWT8QFT0PeXT1p74SwNLMkQlv0qMKC7WfwasjV
 ZDYyBR30brtCpnPa9tA/zOEPGC37TG1j+LwIM0C/t3ycyFzTcJTbR2wPG//QrKR80SwN
 lOubJ2/StRpFHUTK6amByp/1aZyqI3dHQzO0AASYFwCWdZXMt4uZ7KqCJeGhytivrEzy XQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Lx1GWcDIbjleONuQrmyJyOgkhqs6os+pisVZKxT3iuQ=;
 b=wXPqn1nQhBwP/rkqiiFEqzdogv4ft4gK8f6n3SeFf0r1T6SiH+hsMUdA+SGEyt6GVeRg
 I7vjlZeWKgpl6ZKgGLh6BfDdQlHUNzy1OSarCoCGxhD9V7iACMicqujLifa5c94WH/IT
 DNdCeSUBBdDoxCezt/7hPcfbidmYjFm5AhSUDpu7k10aIvKyiNrrFO4+XL/xoyO7OUUx
 HLDsceQAtCcMjgKIh47qHn9XaSDK/M0bYvMb3RCdpJAaCCSOycINKUGGqdVs1W2L9E9s
 yPqObB/U50cglXkZBV8wtgyT3yIhMILvRpFwqaTKMfYdQMnbwGPUkDI2xF7jD6NvrZIV xA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgm8y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFksAg094402;
        Tue, 17 Aug 2021 15:47:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3ae3vftdbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYtrUZVmCArxcbj8S6Fyig9pKfyC3JoCSKNqdYmsGRhUeVVNJYtUTI9UA0o3gigeUHpLAdnEblnP6yiNw4TiQBBU3qihlk4cwKgxkn5MxmQAedZndRVHaoMCJSwLiGinfhX0dHqsoP/58BK8FyFG0qvRsbrgCXrIW0zymjJXosTBSI+iAyYbvAt/FJ3rByD68AyM9g8YqswznL5ZC8jV8FY+l5lhJcc0bVwcSF5OOz7GWGXwzoantc4j0xysacJ1ZPeiPHEsf6EX3UlfzKH7QUnC4CEnyslPEDjNEwm4yMw7UV1OIeQnDMmlzuIfMDVO5dstCOH3O951xQEzv7CKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx1GWcDIbjleONuQrmyJyOgkhqs6os+pisVZKxT3iuQ=;
 b=oF3HTsTevwScY6waFTrAzDBFzfwg14YHi1Q/lwUygBaVMAZLaBB1ZwZF5zIPhLQAZ9Wyfzb0t6tg2U95GKupKfKkamnSES92d4cQmAZwEkUoPwv7uvgJk7rSo4H/L1liLGKKjIHI1RLQHu+CHIsM+G/TlYwuRTEAwqiJV4Rebplk+y2E28rvrG4kNXSnafyDKbfD6hBICrjTYKeZU1jpA+SR1M3BZZTj7MMqnFwO83gdGQTYxRDTH8XjUzTBVpqmElly10zJshQhTnHZtevSkZGm6bu5znzRebM1GcSJSjuISQPV2g9NFYp6xE185ppYqaPqTh/jsLVU85ZncLrSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx1GWcDIbjleONuQrmyJyOgkhqs6os+pisVZKxT3iuQ=;
 b=JAUTkH6ZSDIjSbDm16P5yjEjGQfbs9+kH0UbTQQYcU8XMebPfG99EhAOtsoxQvN2Pbvdf/A60cvuY3inbe/IQxGKjWTMoDS4hs4obAyREM+UmvFZsvbgmrl38aNfNYmN36yInDWZGI0a9eSUxb6/Cms/gsH5O5eNoEunln18ESc=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:13 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:13 +0000
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
Subject: [PATCH v2 16/61] mm: Use maple tree operations for
 find_vma_intersection() and find_vma()
Thread-Topic: [PATCH v2 16/61] mm: Use maple tree operations for
 find_vma_intersection() and find_vma()
Thread-Index: AQHXk38l9oGMosuoI0mQqS98xAMg3g==
Date:   Tue, 17 Aug 2021 15:47:13 +0000
Message-ID: <20210817154651.1570984-17-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: c38e94f0-28d0-4799-7b97-08d96196486b
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4236FD6C13EDFC28C5C754F1FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTma6He0TWYfJdstF+hWCKF7l3GZZ+VryX5kHqp4RaJZjIByc45QXwqDDP0L5/KHwG8DJoD9w82eTMdwD6ZaI9jXs5xcUE+yooMTm/HeqZ9RPyKYcTDIJsmeA8qJoqUsPS6z7huBacvJufomoC630EAEzEa0YQygjcGaP9Kl+tsOlaKiAd2bAXc/jJcAIlVgsoyjoABdy1opoGarHEwLZGfHvDVCBAtM2zMCKvQGE2D/Or/OA8LXwU9EYbZoUsu88iRy/i70hOIY91LGahNYDySKOmbKrP2raBsNpjo5SgPkitHU4vB5LEuPVv0kFIvBNQlQMNRCZ6QhLrjXnxl2vge+pIXrMFcTfoMvqmNtNiEAdxJgES9xr18EgnPyKhq68r6cnUO/hyWT3O3A8/UTHKoCVuSSH/R+byD+fZE5lWmQv+GbfvbkcVK8nrEgkuCADrZ99+aqMZYfrGM0lmcpdb7hnKRCoe3GjRCKZmraJCorhTy6du4pzp2idMqxBcfRpIrj3KwFg3CZ5zV0o9oyDve74BKQD2mGoytMTVlLhJgxLjR1sFI05g5C6LFTAQkivh6SNdwp7miONqLfa4/wbUEk6jS5b1hrpvISTqhTY3dKp+AaRBR3RF3EzocQE9hncImWKALjf5N9tHmeAYU8VZ/2WaTWQPp3qXrzR9dm9heFYSU3EGtzuZeJTyjJz7bHymh03nPh5t8hG5qTJYRMmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WOPLs8iLOA6BaoQ5CJDrHuZO5OWlWEjpC/H6Xlorxr//I34JMswTigPEQB?=
 =?iso-8859-1?Q?zq6wT+mnSOK8LHZh49bPyVntrwmXzIeGZskDXgkz6w118xLuLAzYPLMDR6?=
 =?iso-8859-1?Q?g0RD1bgV9utsaiyKSnU9Uspt/65u9HqJRnE8bOBcLP1ACwPZ6FHuQBW1hL?=
 =?iso-8859-1?Q?9sgbE6D9f/CFrvm/D1r8IGvK4ujQM/kp3g2dwfjTOBSIW403XWP+FJMDsw?=
 =?iso-8859-1?Q?lbw3UllRXiV7237okgpFcOXYB1OT14RxO1+tXPWo9vfv622Ah/mjaicu3p?=
 =?iso-8859-1?Q?PR7yBfsTbrMeq5sRwwexw6PRT82Ja56Q6zcAxwIHZQpxJCvq3JnZXQLnR5?=
 =?iso-8859-1?Q?7pSpkFOh5oUwCZT8L90l8noTjPcXOjbtOGfcx8lNmLeipNi8FaUA+cKNIU?=
 =?iso-8859-1?Q?rSPrIqn57f6YypIA2MlOtdoO88xW2hWqoA579wbvIG9ji2mkkAWDnZAdR8?=
 =?iso-8859-1?Q?JqVnqsoukK5qxdW8RmXRJQzOMB14AheSb5BpocAbwjsP2vnaq87mMH+pl7?=
 =?iso-8859-1?Q?JyFNsVj7M8xHc0B0mBjWWJI7aOJ/1xUUwiwG03w5JXSdnjgovSI7jySuyY?=
 =?iso-8859-1?Q?f8kvSZ7r1M6YIdLPuD+8Vv/CqYyy5gJsMb51T4m5yUDrMbNExhUhWe5A4G?=
 =?iso-8859-1?Q?1X7t5bUiHyRvrG5pHgWeAwU2tSr5yB7qeoM9x8Q2HuD+oPRkZJblwy/1cu?=
 =?iso-8859-1?Q?gSG68BkqjrASqIdVCsm0to9aGbkDxBygyHmrr5WNuMyTqtn0FAq/b0ae3J?=
 =?iso-8859-1?Q?zzcA01+3wdHXcC9ODTX51fjxiFlIhVW/nUK3ueRJiFcQfCoLDhb5m91jkk?=
 =?iso-8859-1?Q?p56nhBr7y2At1v/Sp98nrlWPc9oAXAkEV7Bg7TIfAqqQ4Xjtjf1fuCmq1L?=
 =?iso-8859-1?Q?CFiYrvzbOwFwZqt+VoWf/fPUbtLiau+3cSgMUMQc90qh96IH+kTe7W8O/d?=
 =?iso-8859-1?Q?w60vTM4pyMdvZQtlw5OkoE2+hJGtrApESLmCSmW8zLdAejDyfhgmMmsZxL?=
 =?iso-8859-1?Q?SiVeDTJDWKq1odbwlyAhAHDZarIpBGr+y+//h18SPMWr5a0k/CKYjH5o1V?=
 =?iso-8859-1?Q?gALkSi7+XJJH8Cdh3DSZHXPzKgbfJrpWrDcIx4/4TwH4Sxz/MZ/vP0mE9p?=
 =?iso-8859-1?Q?IxpKY0ZheKHd1mAZs0uCYELOTe4MAOUlp6rdsnZGChojsmleHWm7lE0TEt?=
 =?iso-8859-1?Q?ddiHf0jXTjODjmG2u2UowrJewvM2MZAeyaMX2SwnCS232eEsz80zxZSWsc?=
 =?iso-8859-1?Q?X2ajgb6Sjxz2wj1CXqPdE3cLigcYwgRIGt/urnhFs4M7+Wubz1K4jp+7Is?=
 =?iso-8859-1?Q?ULlSBPnf+zC5ytewoj8G4S1XSzK2JN34Uwul+U0Q9Mj5mWfHZgsjoKJVZR?=
 =?iso-8859-1?Q?25lO66Gxjh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38e94f0-28d0-4799-7b97-08d96196486b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:13.6582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5C7KnWTq4Um7vheNlWOpCqDUL3mdIk7HsbdDU09jFaG3h5PjeQnE/XwhyMN2kxDYZoTZbocuQY1H82q5pGajA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: lDgnOjE_L5K6yLdhtfoUD_hl1ox0W5BT
X-Proofpoint-ORIG-GUID: lDgnOjE_L5K6yLdhtfoUD_hl1ox0W5BT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Move find_vma_intersection() to mmap.c and change implementation to
maple tree.

When searching for a vma within a range, it is easier to use the maple
tree interface.  This means the find_vma() call changes to a special
case of the find_vma_intersection().

Exported for kvm module.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 25 ++++++-------------------
 mm/mmap.c          | 38 ++++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a3086474d8d2..10763bd6fccb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2774,26 +2774,13 @@ extern struct vm_area_struct * find_vma(struct mm_s=
truct * mm, unsigned long add
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsign=
ed long addr,
 					     struct vm_area_struct **pprev);
=20
-/**
- * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
- * @mm: The process address space.
- * @start_addr: The inclusive start user address.
- * @end_addr: The exclusive end user address.
- *
- * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
- * start_addr < end_addr.
+/*
+ * Look up the first VMA which intersects the interval [start_addr, end_ad=
dr)
+ * NULL if none.  Assume start_addr < end_addr.
  */
-static inline
-struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
-					     unsigned long start_addr,
-					     unsigned long end_addr)
-{
-	struct vm_area_struct *vma =3D find_vma(mm, start_addr);
-
-	if (vma && end_addr <=3D vma->vm_start)
-		vma =3D NULL;
-	return vma;
-}
+extern struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+						    unsigned long start_addr,
+						    unsigned long end_addr);
=20
 /**
  * vma_lookup() - Find a VMA at a specific address
diff --git a/mm/mmap.c b/mm/mmap.c
index 3d88fc87c289..9b86f47f7387 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2052,32 +2052,50 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
 EXPORT_SYMBOL(get_unmapped_area);
=20
 /**
- * find_vma() - Find the VMA for a given address, or the next vma.
- * @mm: The mm_struct to check
- * @addr: The address
+ * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
+ * @mm: The process address space.
+ * @start_addr: The inclusive start user address.
+ * @end_addr: The exclusive end user address.
  *
- * Returns: The VMA associated with addr, or the next vma.
- * May return %NULL in the case of no vma at addr or above.
+ * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
+ * start_addr < end_addr.
  */
-struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
 {
 	struct vm_area_struct *vma;
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
-	vma =3D vmacache_find(mm, addr);
+	vma =3D vmacache_find(mm, start_addr);
 	if (likely(vma))
 		return vma;
=20
 	rcu_read_lock();
-	vma =3D mas_find(&mas, -1);
+	vma =3D mas_find(&mas, end_addr - 1);
 	rcu_read_unlock();
 	if (vma)
-		vmacache_update(addr, vma);
+		vmacache_update(mas.index, vma);
=20
 	return vma;
 }
+EXPORT_SYMBOL(find_vma_intersection);
+
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm:  The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return NULL in the case of no vma at addr or above.
+ */
+inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long=
 addr)
+{
+	// Note find_vma_intersection will decrease 0 to underflow to ULONG_MAX
+	return find_vma_intersection(mm, addr, 0);
+}
 EXPORT_SYMBOL(find_vma);
=20
 /**
--=20
2.30.2
