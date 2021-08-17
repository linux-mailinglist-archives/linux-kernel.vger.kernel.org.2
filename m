Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4DF3EEFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbhHQP4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:56:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39108 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240102AbhHQPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjfH3011256;
        Tue, 17 Aug 2021 15:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NgHbYfinvdVgWDQW7IwU52VY+f4rmH+prc+Snw0JnEg=;
 b=EdvaFfez8K+lRB2cxn2L6CJZgeSJOSEe4RUNPTLU8mA3BzqfySnDhHchk/3dweRr4y8W
 biGQpndfIgvcvrCfE5TGS0E4ygZFjwRfKR4NHTyEDmlOsa0KXvPQ/808b3wqdMvq0Wpx
 7yaQMubQMfVgp0HQE9ZQUjG8kt0Mv34a7wtOXcGFvKojVEvbjFsewr/VlKyw5OwdotDJ
 G4OXHMQL0aGeBXeOTXs9LyRSH8o6f0RCtpIB+stObXNyAztjCWmpNjUA5QnfKQSY1rzv
 er53y7qbeeK/zttssFzz2+HLh65saCYkJG1zDQb7zERKzsIiAjZg3EzemcrpDrRH5rxc uA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NgHbYfinvdVgWDQW7IwU52VY+f4rmH+prc+Snw0JnEg=;
 b=Ud6x+7A/3a2KtXMpdhIh1gCaOo+nzeUedRIH2Kw48VFhmGnCgWORVZ8W4laDXXvVKsKP
 CE+xu0X8rfI5Ot+S0/38Ba7jORU2niB8tZggqeNRTXOBWh6jRzGVIXvSL2ONJoChgKpp
 B3ydv49dnwU7h3l8vaBYtY3GQbDKD2VyKytbT/hurpRzE/qaAVQaqBO2nPm7HrmIKZ4A
 KMxUVRt/gZbwInKsAva7cc4OcM856MhXqYmSqrYcNaQKM4J9Qd9sVqQXEEbua1iBcKC4
 1H1j5VTi5hKjAAkKgAARwl4wF/64BzwYSlZ5iLLJ0KMWrA5UeNxW24MfVgSrkF8eKNS9 MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7d8bvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfe158706;
        Tue, 17 Aug 2021 15:48:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS6kLlnebM4hkG6j9ANUjb1itWkaPRB7vT8MMVML9OMSdVY6jsHOp4t59I01ngITRLlTz0G80W3yln11XP0CeCSa+MUttkElc3aTSCB8KSak6rl8WfxfbiY5w2hfaGuvlQcfeWwN5SHHJeNefdFUU3PLOG9DRTdMe1GA0qPmIviBRzKwjYBOfa6UPZgtqcDZvdL2kRCT+CdyFCUsgy24bjqGBL9j4ucZjIZD0DqCd7FkYrrrk0MGJMSeex4Ajazym34tSdMsQU12vJZsG20ew1ppCkYuO+IQ/1cr/OPtrM7+uy32pN3BYciWTjugZ+aCZYplqsFRITFzx83RYzJnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgHbYfinvdVgWDQW7IwU52VY+f4rmH+prc+Snw0JnEg=;
 b=IxJdc8uJNHaxflv/qPz8b6ysMebktex5/IG58n0jezpOnulbCIShFUx4HeDPVcKAVt9nWBVDHEx4Ser9VDPbkZfh+u2zdPWkgsKzuXvYaK1+Dhf9o7TidBg92XzJBeTtaQ5QlxDIN8wBsG/xIRV1WPzLNQzn0+O50Cul5E8ywXmBY/pwAKYGHTGygWCw2hYXdVRyCLt5nqSu/hCdcWtJtE1d61xvj93cljpAoT85VuEF1eM0K9O23dUQiBBQL5L0RaTO5VlO4Q1FGOk7TsTIY5od6cOHUbkRq3jWf2TZ5uQi/mzZPUrQIDmPfNY+yJAcUP/f2LkJYoIzaCvAKagO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgHbYfinvdVgWDQW7IwU52VY+f4rmH+prc+Snw0JnEg=;
 b=pXdBzBSffuf8jMjDtokIEfKHO+EkawwCErRVEDEJauE5G+4CfZsRmzKdiRWiWv2PMOPtqjnYn5Sdsf300l7isMEpdiOU1tKpaxFcgeJDibaTnaO3gbOgtomPx9OROSmwIocYiCHiyRFJCPfLQWSLBX/IojvjKpB/PCcsdqyXCw4=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:56 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:56 +0000
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
Subject: [PATCH v2 49/61] mm/ksm: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v2 49/61] mm/ksm: Use maple tree iterators instead of vma
 linked list
Thread-Index: AQHXk38wFMvr7z/G+kue2uABJWOmeg==
Date:   Tue, 17 Aug 2021 15:47:31 +0000
Message-ID: <20210817154651.1570984-50-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 6434ef5c-c062-4882-8239-08d961966209
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB358026154E50DE25C1D0B842FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9NHZReGUPZYai3ZvMs/9i19rEu4wmw0E0SdT7iTvbxUhd9U+52hIxSAQMnGO5dWSYbhSDOeP4z68QexNobQyQR0+NzYgvkNBoMmpYflP+c8oJ70se9Om8bQZmD9TUj40nRdwasODm0OYPYzT+UO+6J2F2URkvDrf/PGTezgC15QKGRyxWF24l3nnrJI0Rm4tTFPYHpKpz6f/TaUrBHsNtWKd60M9BX9eSunzqCxwj1Tdjq3/Vc24L/CSNibSWszKOkOjVD9MMrMoTrUwTql3/6RD61stPtBP29Xkc3DoWb3X1rloHwTOfKL8jnXoq+d2S5YELYL5sakhWrnFjVeYwBG5BQ+Dsrsmco5ZO7MUoB6aS18/CFt2rBf9WNTHC33MRSU+b31d109XEQanlDZ/UXFceSZ/q0fW/KsmzExHMwUhlYSQuEM1/dhhpPJ/oV15KPOQhUksrI3ZzVhlS4MU0yWdJTWwAZWqCK05kKX48L3VDIV0/h4mH/6Sl3uhlmeUhu8itmyzOrQC/VzOfENMywmEOtXG/RfrP7qGPeVSfOYj1jaNyLDqj1p5zI75E9JQAeOYivdPugRZM+yWseAiRPLJQYYWN63X+zm2/j52HHphbkE4nx5vTJBth0GxzCzV6YPma0Gd0++C7Ym4pNfyg09rBCXx/yC02Ws/jTMm7/tJavaL9Vj7/YkOTcmmw0/nupzLYkx3e/rKP56yKAtnzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ueXuKtF1/8VzC3SM+4vcCXlN0EQJO/5XBpN/CoYBiVHb2CkUvoD0L0lyZD?=
 =?iso-8859-1?Q?yK/0nDJ/Xi3lcxx2wc5DehQNV6tFcN8ezW6pz/5BQBD9WlznDjlEcfCZtn?=
 =?iso-8859-1?Q?RSKzh56fVN0pmFcZqmn3hqXtmsxbtLtaR8jNRqJ6d2bTZ/A8mnGbKDs663?=
 =?iso-8859-1?Q?SxmfOu7jzLpN7dhid6066NPPrUtG90x1t0gqbU9pPcuJwqOegv33asj1cB?=
 =?iso-8859-1?Q?n2VMcgn1O0yVUOwUiYPekl6HOMYNx0w3b90Xb16GCAd5dwvZ6xlKeARIrL?=
 =?iso-8859-1?Q?2lc+CHlybYCBLEhp4iTje8LeCsCm5cJyESalIlYuuVW05B8bK0z3nxu1Sa?=
 =?iso-8859-1?Q?SlOKlQ1q3phnjZEUdDdD2Ag8UA9+JLlPFMyfnOthRjM8wRLGBmiSR6YVZc?=
 =?iso-8859-1?Q?fIQbeVYpfQyCsd+5FBZEe+U68MdBC3PhtjA8IQ9fG5ve7/01wEsdNLdLtJ?=
 =?iso-8859-1?Q?K1jRQ2F6YIwDF/ppsGG4Av4TlhKl78Og0EP701k4S5lIPSyDf6EyV/X/t1?=
 =?iso-8859-1?Q?y+YThEQgOIkMC64v33eOsvIEpbDerntsXOby1bjoH/h39x6VKgn+uWnlxO?=
 =?iso-8859-1?Q?telFFWemKZdGTsjGaUOeunyzv2XMplK+VmBd3p4rzuCBzPWuW8sgWfLVEQ?=
 =?iso-8859-1?Q?3PrdyKWTlVsPrq3dQutUELlk1mtQr9dMFQG/PWN833jYCriVN7zgBM4HJH?=
 =?iso-8859-1?Q?2QRNFBsyvq2SH1oJ7VfIU3CN8Tmcm6Y4hefdw3OV+f7FbZEocH966BFc9v?=
 =?iso-8859-1?Q?n8C+YWIrkrhwkj1nxIqrzVzmPnsJHKeF3geg0KrbYvqPfwXWoN0TXUVaXX?=
 =?iso-8859-1?Q?+MsN0/roaMTUx8EnChHjHG4mE5b4u5Hs1cTT+ij/FYg2raWHMCsNAgiqm8?=
 =?iso-8859-1?Q?mN0hFMaSFZSw1EqTMvDl+DtI3SpsZwVRxBccmlc8FjPwWajB0YBhSUwqS8?=
 =?iso-8859-1?Q?MAhbOH/vMAovDy9PfstomtncvXpXR7QxEsLAFY9Xt1BYSc6Hn83O7/OuHl?=
 =?iso-8859-1?Q?3G/2r+Ch7LKTSyhsM4w5UTW0XqHdUe90SlOlzmkqjSwV38bIjM+3W9+xbA?=
 =?iso-8859-1?Q?9Mcx5aEmr8NVwHAUDNcL2II45WJLGnOP1U5sRbeld2my9IdS/4Q5LE+pXW?=
 =?iso-8859-1?Q?C1iGmk5atWhYmePC8MRcUZo91kb89Sdcf6Ykge0vDdReA3S/g7VuV/eK7D?=
 =?iso-8859-1?Q?UpdKYXgZX3bPaWqgvldsq53Jz/rtGB1OfWr3q9SPd2yetv0kbR9EfFlZIP?=
 =?iso-8859-1?Q?gdO8ZTgq6jXFnzGcU5wmpNvyZG63trUR732+ToHLCqgTCVlia7J7/QdN7c?=
 =?iso-8859-1?Q?+ifgAWA9cNC19kCb1pVwayTShwx+0ukkWJQ4tYcP4ki8zNmIUlrllWXemL?=
 =?iso-8859-1?Q?LMV3Bfn/57?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6434ef5c-c062-4882-8239-08d961966209
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:31.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mu9jGWOE+nv+gm5MTFsU1eJVrubraUBvyMHU9vj39a6ZWzFWmojSKjotNY1EZkjHu6jDGc0jsOS++fIHzuvroA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: 18sPcykODzqr6HfjYeyciDGUG-tvIVWC
X-Proofpoint-ORIG-GUID: 18sPcykODzqr6HfjYeyciDGUG-tvIVWC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/ksm.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 08092e6f0b73..1e2218a81bfc 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -975,11 +975,14 @@ static int unmerge_and_remove_all_rmap_items(void)
 						struct mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	for (mm_slot =3D ksm_scan.mm_slot;
-			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
+	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
+	     mm_slot =3D ksm_scan.mm_slot) {
+		MA_STATE(mas, &mm_slot->mm->mm_mt, 0, 0);
+
 		mm =3D mm_slot->mm;
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		rcu_read_lock();
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -991,6 +994,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 		}
=20
 		remove_trailing_rmap_items(&mm_slot->rmap_list);
+		rcu_read_unlock();
 		mmap_read_unlock(mm);
=20
 		spin_lock(&ksm_mmlist_lock);
@@ -1014,6 +1018,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 	return 0;
=20
 error:
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 	spin_lock(&ksm_mmlist_lock);
 	ksm_scan.mm_slot =3D &ksm_mm_head;
@@ -2228,6 +2233,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
 	int nid;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	if (list_empty(&ksm_mm_head.mm_list))
 		return NULL;
@@ -2285,13 +2291,15 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
 	}
=20
 	mm =3D slot->mm;
+	mas.tree =3D &mm->mm_mt;
+
 	mmap_read_lock(mm);
+	rcu_read_lock();
 	if (ksm_test_exit(mm))
-		vma =3D NULL;
-	else
-		vma =3D find_vma(mm, ksm_scan.address);
+		goto no_vmas;
=20
-	for (; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, ksm_scan.address);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2319,6 +2327,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 					ksm_scan.address +=3D PAGE_SIZE;
 				} else
 					put_page(*page);
+				rcu_read_unlock();
 				mmap_read_unlock(mm);
 				return rmap_item;
 			}
@@ -2329,6 +2338,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
@@ -2357,9 +2367,11 @@ static struct rmap_item *scan_get_next_rmap_item(str=
uct page **page)
=20
 		free_mm_slot(slot);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+		rcu_read_unlock();
 		mmap_read_unlock(mm);
 		mmdrop(mm);
 	} else {
+		rcu_read_unlock();
 		mmap_read_unlock(mm);
 		/*
 		 * mmap_read_unlock(mm) first because after
--=20
2.30.2
