Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA73EEFCE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbhHQP4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:56:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44182 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239950AbhHQPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:11 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkHHb022539;
        Tue, 17 Aug 2021 15:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TuEBNzpWnNBhdfFW3SOXF0TtGq4rVXOyu6mXnFF/bUM=;
 b=dp5OvBsSiiST+CmfYrokT7EioVWLxgvPbwamAztvx90wEuo5rcRAjeJwjXyI0rz+D3Yw
 EeOuemc4gUDembDHg7hV5pkma/5+tqG4JsArkwWVNqPVkIFN4DQ+4DBWq7Laha5A2yNW
 k1mA5zgUi+TCNTesW2BTANs4rNUWQeNXxZH8YNBdmNtU3ClTFVZ+gNKb3Jjox91P/2mE
 UHKOVmDVtTxEdnRFYG95ZAVAy7CTM2ar+oenmiSbNJqF58gE99nwki7kPP/+g5tyIhWB
 RweIqwQxAfHLuOms1QxIxNSq6QYVMI05wL5reVTtXTRtFTSmtG+TtbqkzSSlNL2nEbX8 /g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=TuEBNzpWnNBhdfFW3SOXF0TtGq4rVXOyu6mXnFF/bUM=;
 b=et/RGUOP+y/QLCPs0Pvgy7z7vQ/xN6D2x28GJG600nYmZrXa742h9cGr7mCgkjvsXSy9
 XyaBuFBvFKMaXomjibgE1iKDMra1QM5mXmVFT0fxASl1qAB4j0hJ8c3lBhEHwA1X3Fby
 38DRYJXS392f1w6oIKK9SoAyXRifseSMF3uHdR0cqsby96NcxCb+l3iMMGu2WYwdSyaZ
 gwgav6m+y4WqGUUEvsI/wqiubd8dJYCnTd7Kr1yST8fZjA12ANCi4+MAaYN5QoN97v0q
 mHDPwOsrzGJ6tkmRHzQDX0TYH5VJ4KAAjPzyNlp9U2gEtoYBVqzrVEPpZm7YmT6c2RHs qA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgm90b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkt5O094615;
        Tue, 17 Aug 2021 15:48:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3030.oracle.com with ESMTP id 3ae3vftea7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecUFHCPRKwV9hC/haB23zVviP8dCD21NMiy/GxF/ik6C/qCMgKuXZgTjHpvip7URJbz4pDZ1AfLHK2omhzigCn3SWMaELc2rKEv6wrtA4UIengW2+tWSopURBZBQTZn+7jWxlXkb6qyzYOz0WU/BVp3W/j3tCPdmVGTLv+uEJK08/SWrZcCjSLt17c8FCKyzwteHBpVUFG8PYj25EPWluqP5ukYdj/ZnsYr4XbPCNVQL1MyaT0GOjoYU5LXUbpNaVjpFGNNkOUicvdV/bm4hbqG5w3G1Uj3JYUc+P52uTXxljvW3yIAkr3cDoU8zrIIeJ1JCeqP2RC8oQK+DbT/OAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuEBNzpWnNBhdfFW3SOXF0TtGq4rVXOyu6mXnFF/bUM=;
 b=KvtnMHhdrr6KIsxvrZjRLU6oTjADCaUr9xKjuqO6niUSjJb0WErUWFKNzp4CiU4vjNcWN5Qabd3ilxZW/x17uYnLSqjXyz5ebkBX8zDdSiEVz0L7kPJfZW4UvTiNRFc4vRu73/EHxYjD6pSx0YCzlHlY1mqJVHa7vP578VCfR5RFvxW6GBMtQ0ZdvOriO+YcR+c4lKkgUPebKC9bIK/yI3uRofdXWG3cmPrsdSX6letTJ88Pdi+Xr5rsOdmrtU1hMwGIGkHcYMVXngJY8E4IbLZWYUdAuMcpMvwW6DxrKZmnlFFcdsdT2iqgTBalwcfT/3zfHjOhH+dLin1Z9RhlxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuEBNzpWnNBhdfFW3SOXF0TtGq4rVXOyu6mXnFF/bUM=;
 b=rfJGXJ072814DGgQ5tC08Udj1KLeeezycgUK5VQqPYeE0EsNpdWISKCBCeT8FC/MOf+BYD0JXzN1BAn4MWMTgGlbJOM//pX9Bn8w+ty4yke735qqx89Gx7DsLLRQUsH/CVnmT+F0kA0MtQuvd+6naMpE6FdNjGSL+QviOvmKGyw=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4091.namprd10.prod.outlook.com (2603:10b6:5:155::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 15:47:59 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:59 +0000
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
Subject: [PATCH v2 59/61] mm/swapfile: Use maple tree iterator instead of vma
 linked list
Thread-Topic: [PATCH v2 59/61] mm/swapfile: Use maple tree iterator instead of
 vma linked list
Thread-Index: AQHXk38xlwUKls+Jl0Kew0mVTSuQVA==
Date:   Tue, 17 Aug 2021 15:47:33 +0000
Message-ID: <20210817154651.1570984-60-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 3df37fcb-b3dd-4d4d-a29b-08d9619663a2
x-ms-traffictypediagnostic: DM6PR10MB4091:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4091A47A7152F6C043D88945FDFE9@DM6PR10MB4091.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zITsEOzMFhn2SF1487fOZpdP9VvZfzzZqO+JuitSySW5yW7U8dtZ/0kc15enFq5WDOo12mOa25i8JiXmfMzqEdK5cYuX0B5Xd70o9aQ4zgoQbNezqH0gdkPLgCKpBF1ScdJteMMwv14QzSkuFf7UxAFwEKIt+f5CK1D1oc0mVxqWbV1JcXz8kJXw3wMC919vPGsyl8USGwOWf+vu1spjMGeVAPn/AT8TI/GGs/99/my/DJJ5nYKX8vwl1IbyiZIjrAnn07mS2g8NgkGGjUdmFXLe/FkdpY7uSvwl/s9nyxfoELyg5L6U2m/DbgvT+SGtglbXG6qafPsUoG6aSchu70EMgXnEJNEZ7GhzhPY03AmxrTM+YeW9vjBRb0NfUPuNQCDXmabqnYVnlGGTXA/7786vIGeXORzP+6EYupD/i5VCne60ySNV1+N0IuSIVDO5TkxwIuTM8NhSvnRZSeP14Cz+oxt6IImKotK+nYBD3+60Dn/CYRE9M8bIwpwuvrovvjoH967jkhZsl7HJnxjkve/m96vVhXKkmxrYq85Xg/Gkpeqv+jR70V78XXDm2LGDoZonL521uHXZJW+EERyiveq0RoARTwNJFV4wjYxaKmXUQIrypQEFQrxTCuCrzyJctARGxP97twm69e8nI3jmOBcfEsSo5aiL5v2KQcmALowXvtxtAKq5P2LkE7rFTEFuZ+ZCwIu7CO9vV8mjOoI4Gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(376002)(136003)(396003)(38070700005)(6512007)(4744005)(107886003)(4326008)(44832011)(7416002)(66476007)(66556008)(64756008)(66446008)(71200400001)(66946007)(8676002)(1076003)(76116006)(91956017)(8936002)(122000001)(26005)(6666004)(54906003)(186003)(5660300002)(478600001)(6486002)(2616005)(36756003)(110136005)(2906002)(316002)(38100700002)(83380400001)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ecFPEDsiIJ75dsXf+6OzlpUJ45U4ynQc+EnZXIGW42FfcBjFVCqtigkU8j?=
 =?iso-8859-1?Q?JYQDbEc2GO+8XeHBNSQSEn4Jq206uNxtuvOv96SDyAM/gc5ycKAW7p/aaq?=
 =?iso-8859-1?Q?0PuTQ9netDcdWbbemKaUC4m9UX5kE6LFDWJxGDKdo8RCFfmeWX/OLllSst?=
 =?iso-8859-1?Q?siunY0f/rxxO9hMtUY5yy3Sdjjfw60CQGZlWgCVeNk2zP+TPnkJN8OkKAM?=
 =?iso-8859-1?Q?3teAdOyx3wWvU7Sg4NYAR4foJOOgZBDDo+Of2+MnvgyfB2VVBJa4hxqwmD?=
 =?iso-8859-1?Q?Jui0GM+Z4sXZbx6EmJnsvb2z+8A/knPbTZZDm0bIcw51+mfcCMaOzZwLzM?=
 =?iso-8859-1?Q?H79SDe0tJND4pT/WY61MDAS3vVBgwAKsD5i6JKJw8KJ7beUzgl3z9kD1BE?=
 =?iso-8859-1?Q?OhM67gZ6pFwmWKdrxS9TmYjEphzTSdZzJ7iat09JKQXYGpYGszf0llsK/v?=
 =?iso-8859-1?Q?gSX3WtgaUUaLBiGIwyh7s2i7O2DxRI2C5nDN28QPw1mLQrRoDEffAoLo1C?=
 =?iso-8859-1?Q?Jc7QVMEyVALW1UzfHiTmpkm1O1WVOCaOJFxX5TZf/5FcladmvnDfA/I1VP?=
 =?iso-8859-1?Q?K41zPz3QQS1ngrkf2Vdp8iOeC2o04v8/j7ILmM60Aga03F7hJ0JktOrAmb?=
 =?iso-8859-1?Q?bizXRcU35/NdRzVzf7W1NUqO53HUlcm2E6XGN+XQ7VFXdv0xHX6CEuJ03+?=
 =?iso-8859-1?Q?Xf7/xZG7SAfp8f66pMOIkm+dibhONOUyGV3nqGoRYuHdvcAHzpXbUnOurt?=
 =?iso-8859-1?Q?xsJ9OQC7ETT/9os+REJXyc6vip836Ad605wllptGuV/LE0vQK7Y5RR4oBZ?=
 =?iso-8859-1?Q?OxBRfymgv1FGMs4mHvnezQO8O5H2w8I8gpK4PzFl0A1/Tb62tLOnAjlI8i?=
 =?iso-8859-1?Q?mDHQiib9kOy0RMTfoHl4fvNj48B7v7EpJNlkdkP7IDrPNNfWM2+vpDm89T?=
 =?iso-8859-1?Q?qv+jckJOcedL5j2sfz6go539i9DxmLnLJcSDwWWiP6BiJZ3BWO978fmwZP?=
 =?iso-8859-1?Q?j6Jtyt3WrUeF/ES2k4xyYC4ByrRQr2UegLuPoqyfWxjU2KPIkaIhc9WQKK?=
 =?iso-8859-1?Q?h1MJB5+tO+neYuoZY8syUS2YErSwNwZ1vH+Ei3kLcYJAx7yLeXONErWMJu?=
 =?iso-8859-1?Q?2VbkrpD7LVAQy2NjgLnwWOdRLm6GoC7tKyLLpXwFfQqSheYZnzIYfq6VX7?=
 =?iso-8859-1?Q?1JWc6qeu49TuzwqYVcgQ4tMNnYOy/e0j1l1rxAXxNU3Amldj/fZico2aGm?=
 =?iso-8859-1?Q?E/JEwxfS/w5AtTqmXyMMnMazPg2pMeSD98cJGvYkCZcryvO2uLaso5/MAb?=
 =?iso-8859-1?Q?J5mtbfrv+GshPE77olseQnUam0VTrcdbyBFoasEnyStqFqfQphZOP8iDGW?=
 =?iso-8859-1?Q?A82x/YSJTE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df37fcb-b3dd-4d4d-a29b-08d9619663a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:33.7014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxPqNmz5hZvo2sjW9AQZgYmRjHeoU1FgsDBUMBkXMcw6LBRj3Fu/2ZJjy5L7vW00PYM7RUYiFDJVZnHVB03JWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4091
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: 5gu05HtTJem_InjPzuPUnLhgLDT4TYCB
X-Proofpoint-ORIG-GUID: 5gu05HtTJem_InjPzuPUnLhgLDT4TYCB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/swapfile.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index e3dcaeecc50f..32c40aa75e85 100644
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
