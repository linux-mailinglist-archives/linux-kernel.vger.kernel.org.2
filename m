Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17CA421C14
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhJEBgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63242 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232503AbhJEBeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:08 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951E6mD023902;
        Tue, 5 Oct 2021 01:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4e391fRRmEEUCYzgLdYlKaQHU8t0T8rYp4sk9ADFjvM=;
 b=jushLbigLvhIAYpxj5zhM80ZFEnzGSSYc+ofefpUNCh6dBU2QxRblJGPu3MxNOyuCVu1
 wfCb/rgZnqldQ9La+MHKz91avQdMt5gvZeyvhy9plHEAEO6rhFJ3QfaFbdHVtYCWk5he
 D3WwM6+eYfmWcCcTP0NdUPB22zjGAd7Mc6OLtDjqbSBFBmnNp4zwkven93SrqJbu4ht7
 BDBDVjzjv9gn73INAEv6IEtBxozPyM+PVp5BRtcVWSHUUgASYTWDtlPsk1s/jbdm2kCV
 BgM9FZa4niuiFGW3q2TMnElQXYWhSBiJxRLZf4frS9YYCVHBsvb/6oDBP1ky2Pf7qSzq UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43gkpp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:32:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UIEb178435;
        Tue, 5 Oct 2021 01:31:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3020.oracle.com with ESMTP id 3bev8w03ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cnr3cQA4n8O3ROD1a2oeOdXIb+IOXcEHHcU3PfGsgGzEfaC6sdF4tLE8tkD906z3AGnYAeikzBmXrgRTsEPXaSRMQTSCunc16XCFY/43zdC7635hDdEtuh8fJYMUaeWVPxKfEW68Rf0cGMQremmKnufCpSQcVVh+ACT1qiCGBhQrKBlrO9FeeWdXNRmNYDXkN7ZO/TORP7OWu3+smxT298YHLKQVUUYnmdzIfApTH2Lq7k94GUbSFAd2QflL4OpTyXHD0M3Ay412dtSJvMUKqmqvMZbkWmo5aP+vkNOvmvkHj5gXW9HZmB+8RpAeTQUUBGKhqAfXX4qxKi/XoJwhHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4e391fRRmEEUCYzgLdYlKaQHU8t0T8rYp4sk9ADFjvM=;
 b=jbKPHp1hQ4fo1kU4qwUTTBkUOKRMgfjKRXm0BihgEZIY/B+in89BedUrj1NtAM3fVgUWpThvBkA2sdrMbGsmvMO+aIlzlYEF1Jzn0+UBrgRl6eIrp/4+DI/i7UVGkirlK22WhSo0yFWwB4wQGlSxNv1gkZi0eRmRy+FUs5+U0Btvcdae5EV4oB4D3x+USlZet8ADATlDV2zE4YeONKUYcCUxRZ1D0Af59uuRt184FQ4nZsp+VleLw50TKmjp72477j0oOLgqnzA0oQ7c4HRYT4FV0ZZf6WCN9eGlzcUUUMxGBn8ojBf3mkdrElXwbAaOxEjCdU90x9fjOpnYZG0JKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e391fRRmEEUCYzgLdYlKaQHU8t0T8rYp4sk9ADFjvM=;
 b=F6vEWYRv1a/20tOVlzdoSTS8NNCT+lP4ogHe7WUcg1yfo3HEqWcxJFNAhOyfy1NjCyQZMifmgcJ1oHLYkv48afr3w0SlVloPi2QKlzJErtsDiEH7ECrZI9s0xZeRU1gucYrvjpA8Yf2ngOM50RSibfUeUf8kr7ONDKxZ/z7E/tQ=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Tue, 5 Oct
 2021 01:31:57 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:57 +0000
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
Subject: [PATCH v3 60/66] mm/swapfile: Use maple tree iterator instead of vma
 linked list
Thread-Topic: [PATCH v3 60/66] mm/swapfile: Use maple tree iterator instead of
 vma linked list
Thread-Index: AQHXuYiu52pnOJBAU0mXmC2Wdh0j9Q==
Date:   Tue, 5 Oct 2021 01:31:13 +0000
Message-ID: <20211005012959.1110504-61-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: cb2a7ccf-3a2c-4595-cb96-08d9879feba2
x-ms-traffictypediagnostic: MN2PR10MB4288:
x-microsoft-antispam-prvs: <MN2PR10MB4288D4CDEC9B443426ABDDDCFDAF9@MN2PR10MB4288.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zjhxhe4bPMxztWFGIKAhKNxWWqxTiin1j6LuGwiMp/sa2KyzR7mBh+ZlaxHcMSMqW4yG/9nRfzW753GUj6sY0An6WVlwYreBR7s56K0faKquxRpDp/TRYVSqjVIdtiZKSqJEbut6RvJILnCCnWHdlyng9IVbfHKx7TZG0q5aemRO5nSiINa4XI6Oa1bo/9AsuciDNyQxpCJByrozBAjY72ouhCOuf3cP/mz/ybTRF40gHgkELOU1fmyvhaAt3jdA5egB0MwuLT6ZvKAQ9HgRO3qN6rA7jBI8XjWAbfvPvlGAmBhGlV/msFaDLccPnzj8fgnkvhVBy8qisGxozR7fTOXifFwn8nqsKjM4JWsXg1PcLtYMPx1JOR5Yx/G1okMvEANxWpHSRDfpRhGxr8YOuKwjKbQYss2JsRIDgN0HlbSRoy0YNb4WHXXJtTnRRLOryZe1eja83Fry0/iFOm0LGy7asGOr/gNHFV65lKRqN8OvJm/OPGgJ+zzFLGDq7CgSkLYngJm/JggVppwy/H9n0egyXSV2VQyocdgWBZRU6trQz32GVDq7F6lyGE329WDH+WZ+nBsCReHinPaPccF4Dw2pXnCHML358xPHD8ZyicOOX8tmdG6Lp0w8kSECaLTQfFgCPg5W/mFVxbeEP4bvqlxt58/1PtsBnAtgPznxd9VTP29BO5IaT2HZk8FtX2N9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(38070700005)(71200400001)(8936002)(76116006)(6506007)(1076003)(122000001)(316002)(2616005)(44832011)(6512007)(6666004)(6486002)(38100700002)(508600001)(66556008)(66946007)(66446008)(26005)(86362001)(83380400001)(5660300002)(91956017)(110136005)(4326008)(2906002)(66476007)(54906003)(4744005)(36756003)(7416002)(64756008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F54Dmbu0djVm8xYFZ7XfWPp4FXnp5KLcBf4/6G2tWrzaj1TM2bZfw0TOSl?=
 =?iso-8859-1?Q?iS0R155YBe9XR6MxqGel/3yT3Rghzhv62EC/UM9g9edxHVOuAEo3qkXCPn?=
 =?iso-8859-1?Q?DIstvAhnhF1/dpWr76JLUUH9GARc3JFO3JwwSK9d0Iew1CK2hhO7iPwuGq?=
 =?iso-8859-1?Q?rVVrn9N7fKjviKUhKkui2Zds8sDFZRqmFqJP+RiurThWHieXe35GzjwTct?=
 =?iso-8859-1?Q?TQQpChfn6gug3N1tSCVX5shnTyku5kvvs5BBhWCwtNSQxq5dnOgZ6YyC/T?=
 =?iso-8859-1?Q?VtacLhkhFsHZEaF6/C4zG0J7coUrnEpMJ4j/+1OpifQ9GwHDA8ezzIA4Dq?=
 =?iso-8859-1?Q?Wa14SYLNfI276JIHB7YgPff4p7FQ3YLHjqfTR/tO8gye7Hiv4SctQcVbB5?=
 =?iso-8859-1?Q?ZvwN2KLGNCQAAOZ/UC9WD+yV2pwGPonT11eITjaZA0Brp6VQEJUFF0pInP?=
 =?iso-8859-1?Q?KQ2liexcT5i2JJlKmemqPnIyAwXAkafBewTX1xR3JlBRt57jJyghTbjn7u?=
 =?iso-8859-1?Q?/10qBwMfAvNq2or49yOTxE6R3zuDEY+BcKE/pCfgXsz49TT8UP+E/J9ZA+?=
 =?iso-8859-1?Q?Fd1sKUnW2wHmL12gxDnCY/l4gqKH7CZc/C+bO6hRK50yYYpj0+VB9+bUN7?=
 =?iso-8859-1?Q?RAN61zrOJxtZlwPkIlB7ygyUeQ9Vi2pnqdqNZoFk7Pk9hY/wZ1jFheNerj?=
 =?iso-8859-1?Q?r+7Ej/eDGB6GrZtXpJcfGHinR5/c3gwdJhzCySu5zaSyqa7b7iD2YsSnp5?=
 =?iso-8859-1?Q?JMyA2/+8DB0HgLWgw3UGN7YZE8X6YHBtNHu/bbiyUtL182pFkKvTi2BmPF?=
 =?iso-8859-1?Q?J+4GOqwcZ24LkJrAxqaqa2Yysl2gN/z9mE6b/+6pkGgRzQuGa/WzvTdMDg?=
 =?iso-8859-1?Q?OqftIDol0F7XAJEnC0WIaWGlhR4mcLs+thfTIEZ1iU28YT6AktvtmENEKH?=
 =?iso-8859-1?Q?0ANjm8QibsKZfoDncT4WQF2kcRMwcjwy6gulpYRoWPbru4n67er5gDqygX?=
 =?iso-8859-1?Q?aTR8dMaTH7Y1z5+PNHKTp8YmuqW52m75WT5K7U38NGL87I9KDLbK+BMlRP?=
 =?iso-8859-1?Q?CNZNDUj2Q/t3zhWsLIx7uDEDZ1SiUY/fo7BM4FTbivLt7ZoHZf7Quz7WGU?=
 =?iso-8859-1?Q?dxYmuUu7s/dWyvqU2/b5tkDyjC09ZOaulXijcb0X8Z66AFpbqbVR8OMqMq?=
 =?iso-8859-1?Q?z6h/C9ekwsdBwyK8e5rqV2cvN7wJYh6a47K3dGgcAmMW8QZ4ZTguKpuxPo?=
 =?iso-8859-1?Q?kHFMpROn3NFxzSfHpB+W9Buv6+zwSeHGQ/IJ8MaMCQpwfhft/dOaDhkpQc?=
 =?iso-8859-1?Q?VXURa5Ut5mTg/8+uteX54i6W0f98SLhFEOi11MVE9svXVbVc/zB9TvPmhL?=
 =?iso-8859-1?Q?+2tH0M5f0/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2a7ccf-3a2c-4595-cb96-08d9879feba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:13.2400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2ETnytbq20yF/HhOBOJBTIRNarGyNj/TUzj5Ve+QwqTQX6/UPUBLS1XA3ECEXUpARsdxFK2S0A+23dKpg/rlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: btG2D4FhY_wjy-OwWCoBvq-Z0gomNR-I
X-Proofpoint-ORIG-GUID: btG2D4FhY_wjy-OwWCoBvq-Z0gomNR-I
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/swapfile.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 22d10f713848..f71695adde6c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2103,17 +2103,24 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type,
 {
 	struct vm_area_struct *vma;
 	int ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_lock(&mas);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->anon_vma) {
 			ret =3D unuse_vma(vma, type, frontswap,
 					fs_pages_to_unuse);
 			if (ret)
 				break;
 		}
+
+		mas_unlock(&mas);
+		mas_pause(&mas);
 		cond_resched();
+		mas_lock(&mas);
 	}
+	mas_unlock(&mas);
 	mmap_read_unlock(mm);
 	return ret;
 }
--=20
2.30.2
