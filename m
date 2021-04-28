Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6E236DC02
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbhD1Pkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:40:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240480AbhD1Phz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:55 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKkAZ030196;
        Wed, 28 Apr 2021 15:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=j91Wibf89bpxJBBaVOT7PAvv6NDUb/WVm9mpHfaVzd8=;
 b=Dke2WOGigO1iiP+RpVAIOvP/8EHhiy2F0S22Q6C0VsA7yBEHTO1fuKG0Yp6Ni1b2y5sS
 TYHFX9o3pv6KxUz34v03ZCNviiFlVBN1k//HUJJQTLtyura1gczwPpOg7pyUDE0Ok5MX
 LL4jLbVACKQUn4KcMmgg5prezWO2FPYjIUvV9C8uAxnPGubg+rJCtxZ6uxCDUpjHZ/9r
 T45vcf35LmbGRixqR0PbOmm0cSWwFZDTLfSY2pBSsx1Z0ohgGG2wMZ/9iLXE/56KwgtU
 HukS0DK3iLjiNPNvEyIk3dCgYLBMplJLmUBT8AQtaaWMGBcie5Fjam9b23DnrV8tLtr1 Ow== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh62k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:52 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAx9018431;
        Wed, 28 Apr 2021 15:36:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3874d2759n-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hz4kHDS+x48X2Qym5+2dCL56OKtpcMjV0sxzxs22wFKIGZ4W7WbUWPh105uRvJwJBB73ge/0rzu1jRtfCISR9K6jiKPA26NFrWJJ83XGsECISt/snW0BtN8xP8XfVQ6DLIDET0PqstTVnBg+Pa5iBHWWP9pddfY+r2gWyfh083mTQbsTU58xIF5ISdtmreBmVil5xVYLXJC0IvMJfky7Z6jst7Tdiv7tWgQNYscEnm02ZM71WmWVEDm2k0lj1QiLB5wQMreZ0tElF2mEmu+ljhC5I8IO7rkB+N3N2ncEbn58o+zGcVEFkODS3Yd3tXcVe02d0uVp1Rbp/+yvr9Pxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j91Wibf89bpxJBBaVOT7PAvv6NDUb/WVm9mpHfaVzd8=;
 b=ViLH7Wjrw72jdVcKu6KX8gAcJJiUGJo4+xOMNIh67/GGPVfyVF9ttgqZZDV7UTR2/jPuL2uzPxGCua27LVsfu42iAo020XAO8EKuAidXl5wLfwk2+iLjB4BxmpZhzwkdyRnjr8Re6XkJqtWdziqrE4BqPMmf0WgDKvI49futqOHCzxYFySf0wTGmUdSeSuEHeoQkVU5LqursBJOEo4g4JIfWHJdYSJqcf9VwTChc6S1j7hW3dnooQ2+7RRsoIvO/7/84QWOVSM2k1df9QxECpL2jb01snAGDH06XIkYAkWu6lvB+uCHkMhiNnq4OLWlhC5Bc49Z3TI0PqP+P71nwmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j91Wibf89bpxJBBaVOT7PAvv6NDUb/WVm9mpHfaVzd8=;
 b=IMuHeYBHc8mChW3d4KUxj4VvENQw8FOs2RDIGrKQLkIpHUVmz5IyQDTVriRKD33PmW+CJ6kgAPjt/KwY+zxtQxyu6gxUIvJ1SGOmA+AXoMpoD50u91w6RSuQ3oMPTvKVtnwHm08zMuRRarQ0hCX1BbRXPEpJUrVsez2KMfcnkuA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1743.namprd10.prod.outlook.com (2603:10b6:301:7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:36:47 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:47 +0000
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
Subject: [PATCH 56/94] arch/powerpc: Remove mmap linked list from
 mm/book3s64/subpage_prot
Thread-Topic: [PATCH 56/94] arch/powerpc: Remove mmap linked list from
 mm/book3s64/subpage_prot
Thread-Index: AQHXPEQ6df2igs9S70CVUGfBaKBTxA==
Date:   Wed, 28 Apr 2021 15:36:16 +0000
Message-ID: <20210428153542.2814175-57-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 2e230de3-d582-420e-bfdd-08d90a5b6f1c
x-ms-traffictypediagnostic: MWHPR10MB1743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB17435355BDB24BC8E6045C2EFD409@MWHPR10MB1743.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yo63MLWK6t6VmV80Udja8cwRfAc3PnCLQ3tmqTSd803P11hIBgmGgBringyvTfgVqJr6EsbtJH61OesYVW+N0qc+K4GM6S2HXq8M43j20oVl85WNFg8h4T7fCU05XcTzwAx/xbJqMdLQ6nvolBzQSgyk6mowSZpTy1rHCv8/ZbsrtCQGVk4Zu+68rcnK0NY0M1vp+RtyEQHrLy1tH8fK1WxeDT9Cb+ssVDF3f/Xm8r0LCXUR8y3jQ+UhfHezfk09eVt+wlEQoK31QJrXA+Sa1OsYqgRyjaicShQikr7sivkHHSUdk7xQdeiMiSwUPImz4BHAgB+SBfPwsWXypLFXCjLZgNqjxHrZddkhkOJnkcF7iV1W6VW5Or2/knGVdYLALjOCrth/fcig2EnGoXk6UBp/B1Qw35r4ln5Q0GExY0p2Bm43of05C/hl1hf0fOr+l8dr8S5n12Vt2AFrTwwlddqI1JlHx/J1W3Naz0l/qQ2RYZwe+DT73MDUMqywjCGUwFgEnBvxTBxpy9PzY6rmabDSLqNx/H+4SK/aOMpa24CnudnOk/E66cdMiSP8VZNScnQ4oIxCwlCIT+al0hnmy9XOV3LoKv7uppMVGRoMomA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(110136005)(91956017)(316002)(1076003)(64756008)(66946007)(76116006)(44832011)(5660300002)(66476007)(66446008)(8936002)(6486002)(8676002)(83380400001)(54906003)(2616005)(66556008)(2906002)(122000001)(38100700002)(6666004)(478600001)(36756003)(7416002)(86362001)(6506007)(26005)(4326008)(186003)(6512007)(71200400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?mpS8ZycLaXr1aXWjxg+JxYs1HDBWXCKhgYE8xWi2Kpt6Bpj1DlnIwOuXPQ?=
 =?iso-8859-1?Q?KUMugBHtTO5ZMS79x8b+sKnxWi3qiQAZpDHbtJ5hmaJd/24A5qivtMwi/5?=
 =?iso-8859-1?Q?lfV94fjRWYo9lIDXiPmYgBQ9kk4ClTkYDe/uK1TRd5y0WWPvZObIOo4Ptl?=
 =?iso-8859-1?Q?YXvvvzwl3Pdkgvk3NTVjYXSDOWFqf3AWC2LOVeWmsFHUBm5nHQZsqqE+MK?=
 =?iso-8859-1?Q?arOMtC1jjJLpAksv0D2gTuxeoVWJDoFe6Utor7wa8ODmtNoWEapl1KsZFk?=
 =?iso-8859-1?Q?PfiJoK0+yJONz5QJKRXDMcwa6DiNwz29TN2TmT9aOvtzAFXR757jf7tl6S?=
 =?iso-8859-1?Q?khS5jccLX8GcEO6CyXmCERcVWcmyrvgmb737MYpfSxK2xaxiyOa4GqxdaG?=
 =?iso-8859-1?Q?hfADqa+KpdKLz/g8DBBBvH6BRCtpWK/vMMZtjGNVH33fbxMNQ1enV/P+9/?=
 =?iso-8859-1?Q?rogj8j+nze47YdxZ4LQb424DWHq4G2uaDpnPiw+4BBXf8Tft97QqKYMX9D?=
 =?iso-8859-1?Q?7Ho9JfAIyo4P/sfQRxPW2OIMa49aDkKkmX+kcVgEGduwWZhFwy27BYPb4F?=
 =?iso-8859-1?Q?1IHEA1bpPLVKZ894MxWE2b33rpttMOjuah2FdDFmtOyPYbFXipQPwe38cm?=
 =?iso-8859-1?Q?WVgUMj7/LBBuVkhFRSelrcuTjNPJVgQbYEQPgA62U0inxoy6u3meFvd5Cy?=
 =?iso-8859-1?Q?DxYbLVFm3eNYd147VFOlMkXkSvinedRDy+7CzLISavmzzsmZt1/V65am+t?=
 =?iso-8859-1?Q?4AAifBIJwo2+1KSM2DXT6fHUs225PWFB/9fZF5U859F2xisW680RR7cGye?=
 =?iso-8859-1?Q?4FtyANxxDEdv/CdTxlsVElcS/E20mGZwfOAgxh9KmxOUnF7B73hyoMGEX6?=
 =?iso-8859-1?Q?h+cwyVic9dieQlkG4cSPG1xFiV1+IhdRp6VA1s1E5wASvilwgRNOa87y5u?=
 =?iso-8859-1?Q?IBqW+peAqNChxhRiCUjw1/hN4BLqt8BuZeMBDvT5cMnXgiOEJcnc6Z5Mdi?=
 =?iso-8859-1?Q?7PRJRLX7d6bvL4MlzYDFcd3xnhtnGNDJ+JrmzQMU5vlD5TWsH2NbgWyoBc?=
 =?iso-8859-1?Q?rgTXHRp0JTcGaCR9+AbFebZaT33tVVBQSVeEirbFlhqIZVAmo3/kolkfEN?=
 =?iso-8859-1?Q?aYPXhCjOd06CPcPVRMDKR6CJqYUedZ7PI8ogirKVCkr2lQ3uA26ovxzUP5?=
 =?iso-8859-1?Q?Mq2IC6GmtsAjmRySmxfg/KvIzRL0DZkq2vBmnm1yDdvFKaIGxtnAnPwQrg?=
 =?iso-8859-1?Q?CBLfgXRgANRDwYs4OOAej3Lg/Q39fimA0SfxGqFbp73amAUQgf6uU/ziN8?=
 =?iso-8859-1?Q?ihfznYWPxBBj79RsmJB76AxxV2mcWbwgOM8fZN2LwjRlV9EDUCw77Ih3DK?=
 =?iso-8859-1?Q?BY7dnR7o78?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e230de3-d582-420e-bfdd-08d90a5b6f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:16.2469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZUTOE9l07kU+Qgl/9Ge2fGSc6lEem4lkfVKdeM1w9XuImbgLiBGuq4vtYVqgec+fMpDGucLJwGsMiy0PiYnzxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: s_6WuqljPfD1TFrivDAU3sd4iSbuQn-E
X-Proofpoint-ORIG-GUID: s_6WuqljPfD1TFrivDAU3sd4iSbuQn-E
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start using the maple tree

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/powerpc/mm/book3s64/subpage_prot.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book=
3s64/subpage_prot.c
index 60c6ea16a972..51722199408e 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -149,25 +149,18 @@ static void subpage_mark_vma_nohuge(struct mm_struct =
*mm, unsigned long addr,
 				    unsigned long len)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
 	 * VM_NOHUGEPAGE and split them.
 	 */
-	vma =3D find_vma(mm, addr);
-	/*
-	 * If the range is in unmapped range, just return
-	 */
-	if (vma && ((addr + len) <=3D vma->vm_start))
-		return;
-
-	while (vma) {
-		if (vma->vm_start >=3D (addr + len))
-			break;
+	rcu_read_lock();
+	mas_for_each(&mas, vma, addr + len) {
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
-		vma =3D vma->vm_next;
 	}
+	rcu_read_unlock();
 }
 #else
 static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long ad=
dr,
--=20
2.30.2
