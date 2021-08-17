Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F35A3EEF92
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbhHQPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:53:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18800 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240214AbhHQPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:31 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjXng006885;
        Tue, 17 Aug 2021 15:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=72JTWJW37lhUgd3wUchvsvnYqI07blc9G0gq+USOmww=;
 b=I6bNuOh3SPI495+D/WQ2SutYfGYMKszAI+DLVPBfjP6CNAiX7jNHrhcnYOerzWZl1xWT
 2Xk2rxkyg0Pn7aKyeaaHlfUv2XPQCZbyffSmwPKFa5+yBMdTcZ9FZFGKxWsy4bFZL0z9
 SpADSy/Afrp7r+CAV9qW4QwwgFcL+o1T85nq02j6OlU9/Q/6gEP3wcw1D4dCv8bpSbZF
 KmPwz+sO6fxI8EFYZdohM9hsTntJqIUMDanGAUtDNgq/bhKEIVAYiimH3lVaYe/JEvfq
 q6HJOwhGs6wN0k6P4O4bd0i0PnNuW2MGizZU4FJOTaxXyFZjx2+a5+2OaWyUfHZCPSsk 5g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=72JTWJW37lhUgd3wUchvsvnYqI07blc9G0gq+USOmww=;
 b=TBG1OIYPuXG5uSp3vNjipjhEJuFGDHADkEBAheO8ocFDUWvC6tpQQm+Zk0C5ZRVzI49N
 GLhwcMZ1grIl/Nv+nJmtUR76/oHmyg40thaFIZX53z57d9IrhhuiBHKD4lTNAYFglXRb
 RtdOhqUGEw8swlSDgmOc8FRjaShzIIzvd1J3DqOKROHUZx4TSfvvXXRyCETEBbFiTptJ
 JEcVyBjqhqglcGrHAYuirpGqx+3dnSPFhXWui4eISaGKmb3UXgqwX9b3TfmF8zl7Mqhl
 qQyaWkTKUuMVvVHNou3CmWFJkM2NwDV8gXWPBE5eAd+S0ZXfwmwfFMCbqdpCn3p4EGKB 5w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbc9ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFksn3094410;
        Tue, 17 Aug 2021 15:47:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3030.oracle.com with ESMTP id 3ae3vftdg6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVf5mRQ0ZWm3+IB3l/MSHEMhz/NWoZFYjpFNAjkl9dr1Gdgl8jnTPZSP00BUeNjmPWbl/JoLH7jlRoyWlZh7VY5vdzzTdTa8z84VHrhtDRcR9cxAq16CJiF+YcJ7qogFpK6CWfe0b/caCufLO4HVTD9jTImI+WRwnwSQTzWfrLfyq6zsACZ64VzhLDpJ6auVLPu+flbW+R42TjpCysZkrlqU6HaMGCx2hjGElR5tPLMzVT1d7bdh6rgie5Vk1QHM3PaXxN3IMwx7SEInbLbw3Zy3gx84bWqEVfBLVrwWHyEdigpPMXDFGmj3EXdICDVpe7JxocFqEtxfRJ9QOBCx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72JTWJW37lhUgd3wUchvsvnYqI07blc9G0gq+USOmww=;
 b=d/9uhzw12/apaLZN41pFcbZKf/QBms+Zm0C5G9SeW3kM/+wYm9ojaz+3LsQbNTFUWY7dVU46bL8LkBmk4Sx5mOnMPYTNK4kDt4maVqYuzHnFO8vts8O6TbjMU0a298UW36IrE/aRBDQbicd+D2/x/lanymDZg3Py0EYireNWsEtBkoXsrDRKuKVTprUDVYon2nXvs5AyVBTewgZ356UlZ3x3odwW9qy8NW6rcICiHQ8iGA8nZKJ0aHABJ39+izDzWWfx58i7OnxeOKB9e7Q61yCNAhuUsDLN/jdRKdI1QD6EJIpdKwLJ1mds7gBJPZHSmTNyEr9Uph5moE4ZSaSg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72JTWJW37lhUgd3wUchvsvnYqI07blc9G0gq+USOmww=;
 b=dFKEskpn9LbiyscJqp78UrWPSFphACVsT3Qi2i24arVsH6PNer2sAOQB34H4Q2H3LH+klDBVkshJS7htVWMI5MJzatifYimUW/FzXmOEEu+EXuG2XyQ4pHX4ta6TrV5X+UZy7nT8pgoFvCJoG+CBYe+dfngNCLeVewWOatAE7bI=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:22 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:22 +0000
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
Subject: [PATCH v2 28/61] arch/s390: Use maple tree iterators instead of
 linked list.
Thread-Topic: [PATCH v2 28/61] arch/s390: Use maple tree iterators instead of
 linked list.
Thread-Index: AQHXk38qHsA/u1tuOkyzs1tdVWLUzg==
Date:   Tue, 17 Aug 2021 15:47:20 +0000
Message-ID: <20210817154651.1570984-29-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 3969b12e-c1ce-4da3-f545-08d961964d65
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB423690A33A9C9C6002D8D714FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPzBh10nKlrwk72LPCmXCEHp6omvv9xrCR0UcH11MbsGZH12g6I+uO1X2jN9xg1CGKvmqA4wY+Uy4OHRWj1tnEy3g9NBycXsPAXk4cwNWRamjlR9aKL3YHjpfP4kuhX6tlm6rPctb/fLaFjBevkd2RgRV5TDlECT1h5rsJp5QUOO5lH9Jyj/UDfneEMQ4yyElvP6nMEBgyVDvanlQDWwpIwCqR6h+WIi2xj+3K0+ZJgE/C1OiLmexjRIQXlwSU7ftWhT2B4sz90vdk4KArRy4JXeAYqsUO2WrrEvcj7WOLhXfltswaaEh1WPIvOVA6lFaSn0JETN0Q3oBYWHpR5jFsrITCH7KhSwlTfYV6dAwuJ1RysyFGzzRd4L7bv8/htMlzbRJ6QJoalp2cx1O9sjmjf63HBgg0FWhTeKz/LrUpXFci7oBekfjg20KLOECUCgePm4RDvsTngG2d5QZg7M5wNWKOWTi2fJGUidbKZ/1P74vJuDI7Ucu3C634zB/ZwGR4JZxqc3XINfMINAl8TBuO8k4VoUwW4Xzos2+Ec0mcfz6IFGYe+/ndhUfl887x57qDnVEdVjn2682OObhtMSayxr9qB1fuJGfrsgXcOc8Lv7SrDmF5vs46GDCXLwqFFzyjU9PAWaSXlBsld04sRojQNYrh64SGoFH9JTmoLyKPxD3fL2wKSAlmKGlx1Am7aG9WC3AlAMNcSebvtBXIKHGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/PlnPUb3w0eI8JAYm4HuCrTw2aO37b6lubJUNidQsYyIRBbdmGye76WwO1?=
 =?iso-8859-1?Q?Ndc5X2rwe4CT+i60ShO8tsB+50JZRPJDs4UnpWGCy96XXfB4W2nhxebBnv?=
 =?iso-8859-1?Q?M2ykVYUJq90JzQKBlX3QwhMfyHgqmdsSV9XGpUcSHRKkCrzopQf+nJmHOp?=
 =?iso-8859-1?Q?X6me2PHwfo8hFE9GjL7qa5NIpiOlk73lVqLPBZlHuMDkB0kpPgb/a0AwRv?=
 =?iso-8859-1?Q?GuEXuvbAVY32VdQJ4XSHXCbS6NNYM3WuQfaC4om7n4GG3uiCQmbkj9skHm?=
 =?iso-8859-1?Q?qMAHg/UDv8/WVyyGh/Dc5kCHv9A0OVzdicN9bB4gtY80mIvSQHqkO66EZS?=
 =?iso-8859-1?Q?Y7JHr4bhIJdkedUCfRxIb/CkFAZno9d8qamHN1bfAgINTTDOtker9ZjUb1?=
 =?iso-8859-1?Q?ectkPViMOTOFNHfplyBoFaXl9v84wGUILixOAdeiw0aA26oss0eeD1GdGI?=
 =?iso-8859-1?Q?TpxLnEsGNgsNsrdbeMAv2btOU1UgSG/tuRborRo1Wk0n8prYPVKgOXv3Kg?=
 =?iso-8859-1?Q?dqk0Fbh9aFUfmNzwL77eI998cfy2rbC3T9kyV9gMwf2Xut8VqANbnz2mHQ?=
 =?iso-8859-1?Q?dTp3/kwiMo9NupzG0x1egBX7fzV6wC64Kq75d8sNbLgXAge1NWDAzhv9+4?=
 =?iso-8859-1?Q?K4fhpvA0UbSLVThqb8WzugM9lZo8/3bP1iGngT8U9yqBU07qh2E8S/0Lz9?=
 =?iso-8859-1?Q?rdvacwDRRsGMUJC1P9STdS/QpPdxoRwDzxgnTyD81edeAsNVwF2kg+XePj?=
 =?iso-8859-1?Q?jkoS7lIpIpxqJWL2lXYUdWjwyVUv7evFUAe1O7uBJh7zH/wgcAUo/3UnC0?=
 =?iso-8859-1?Q?qj69OCCSC2kyFn9BmsAx7IDpK4YfnR42A//ey9V/IMZqWA/dgFqYVOP724?=
 =?iso-8859-1?Q?jLgsCx9uUIGkXk7thS1vvnvG9mQ0LnPDS5G1GGVHrrsl/XLhWNZHznnKgq?=
 =?iso-8859-1?Q?zQgW35xXO0RTMhaG1dkc0jyqq2gMTrhVdw/6SoUMe6r2V9DxOc3S8cBebJ?=
 =?iso-8859-1?Q?L1Yi2GI68i1WzIPVyoau7ym/xfI9iLZ9LZLkOmMXJpN1U0Wz6FGHOLaq36?=
 =?iso-8859-1?Q?/0yyqPF487UH/iTwyG3ZiTXpYD+sQJ935R6aW+ls39enpf6IC4oJZ5G9uK?=
 =?iso-8859-1?Q?Qht8IPVElk6/ety/ggyLpOzdAg0rHGSA9BmDsKE26qEJpevgECvdBVn3sD?=
 =?iso-8859-1?Q?bvLQbgixGaqJsKhkLE89YAtoUs1a9dxeax1nttA0iZvJu1vzO4E8ht9ltq?=
 =?iso-8859-1?Q?RSGqjyTZseK7UwINBHO+s6wDmtt5SJL0i1Z5rt5nZ6CKw1i4u8iwUBx2n7?=
 =?iso-8859-1?Q?+tacGmshZNamaECrDEgG6ltwYcjgxxNYuIfn2gGsQlkeyV0tRxwe1U8o5Z?=
 =?iso-8859-1?Q?Qbs3CJj/tA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3969b12e-c1ce-4da3-f545-08d961964d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:20.7452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gM+oo+LM+UysZrZtEJlGkQ+vdBB+MaPQ2jqQK96C+a7BLPnDepgnhwveIkYspMOJVP1sFbvOgHHCbu93xKBMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: E672o3xzc8H__e3UouYuKeOCXQT6KFNt
X-Proofpoint-GUID: E672o3xzc8H__e3UouYuKeOCXQT6KFNt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/s390/mm/gmap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 9bb2c7512cd5..77879744d652 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2502,8 +2502,10 @@ static const struct mm_walk_ops thp_split_walk_ops =
=3D {
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	/* Must hold mm_mt lock already */
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		vma->vm_flags &=3D ~VM_HUGEPAGE;
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &thp_split_walk_ops, NULL);
@@ -2571,8 +2573,10 @@ int gmap_mark_unmergeable(void)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	int ret;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	/* Must hold mm_mt lock already */
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
 				  MADV_UNMERGEABLE, &vma->vm_flags);
 		if (ret)
--=20
2.30.2
