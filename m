Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEDF3EEDC2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbhHQNx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:53:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49202 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233288AbhHQNx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:53:27 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HDqNun020021;
        Tue, 17 Aug 2021 13:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=M5MTXadbxzVruRDb6NjuMvqpROeKPGbg+k7VH+b8Bwc=;
 b=w4pUwMeggXSKw8wBebezYycuN8yM8/zeMep36ezCaQxXtDodjlaImE63spwQv5EAC6qx
 b4pmbNTB3XooZIv0Oe57uEzo/0yPIhDifAGCSACD32GoetWOIfmuT0bdlaplgBxEc+1k
 +3IAKmSiVZag5xLPCBFPrw3mBG+6vFeZUvzOak8N4AgvozrF5PmjzIULy45MhyzCo1o8
 xtF2SfU2gSTCaPjuMNVr38XWgz8NEqfhP3t121jaVugE+DK0tPqhL3umNkwBFa/pLXX8
 PM7TqCMFm9I8ozC99XzVrC4XlGkj3BcBNwW+B/FY5wxNCq6Vsy24Gf/cQQ/D0P3krVLR yg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=M5MTXadbxzVruRDb6NjuMvqpROeKPGbg+k7VH+b8Bwc=;
 b=DKoq/BFu/OYjFXjCBvJDuhC3eVdQMyqlCOtMTz91opjTMBA9z0og0CoLK7yFa8ihO5p9
 mhyAKl/9kHDX6Wc87YhfrRJxY6dn0t27iOp0W8VSm2lVU/q3OiTW5rlv18XS1zl0BCwM
 STRByHwAD8uS+W+GdTv93LpMrBbVh4fV7mhP6vBjreZAE/7LyOrTTc/nS/4rw0JI9YeG
 QHA5jQ0gRiEgub01efb60Kw+QIrbYpH21kyjMyXDiyMp3PZbr53LJ1o4LcjpdWVGC30l
 7HS08CeMTvW9PciIYNY+8gSMaxRLvhK5FeCraubrrVPh/NQloM5gO2MDyivJkTfA/bgm xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mr0y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 13:52:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HDj2nO166583;
        Tue, 17 Aug 2021 13:52:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3030.oracle.com with ESMTP id 3ae2y061my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 13:52:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZgsJie3ItL1ehh8bbJj5ON9G8wpXQbFB0UBnBTCHzVn3iV+ohQlWzHmeMY/qpRDuliMXz98rHN0tmb5i1KjaKwaCQJ0XaqHEP1SoDSKx6RfpjUPTKxtsiepqX09frGctpb1HBU3oYCBuTBUsd9HRg8qjNFrUDYguTR31EP4POdGiFmxaXY9azYU+dpt/dPpacZ4rmBIZM8WG3rm5G6Wy5WrUmrreCyq+HaKiHs4ON0RBQeX2NclNGwhXdt/1K7nTl9RPKgq3q1bV1ywNA6K+k4q25wFjOiJFydfp7V9FYAclLgg2x4tkNxqz6f0ON6TYeGVb6Y9qNnsquYlhCZMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5MTXadbxzVruRDb6NjuMvqpROeKPGbg+k7VH+b8Bwc=;
 b=gPTnrf3ZpzhxCnIlBO9IbIibvclYyeTwi8ytaOTylinJSLqHDbjO40/FNg5WLI9znDNImRVj29vKM0p+/LIpqnaUeOv2NSW3gI6cQk447a9Op0aAxcZgXPSJcHQyudyQ4SGkTRquZO+4R3U+wJRKMVIVd8INEJFqyCkiC5ypz9zAZo2f1uNX4bK/+mxmuBB39cQJwTWZWqAOGmEZb4H+xqOtJCeolzt6lAfY4qFZojZbTlgBVtFwosTB/OCiyd0pcHLLSGMc84dhgryWJnfOdd8CgqA7Om3LaFt0BigT/998wOpD0q4aKFmyoczyVZBU442QNowbmCRXeukPHjPfGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5MTXadbxzVruRDb6NjuMvqpROeKPGbg+k7VH+b8Bwc=;
 b=NUE/6tEpWGxRHfeYk819ulMskYH3XtvyAmqWszd+DZnMxx5rpoKX9jezupHxULBMiAjWGPt+9wXtiwbRJHSeMmhY3RXqcfbleWgH4KWv/yYouYc3bvNyl3KL2n52mzy/OJjxDT6mQ71IThliJl4TgLBwuXwlxCfPK+DSRDu3JwQ=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3500.namprd10.prod.outlook.com (2603:10b6:5:153::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 13:52:50 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 13:52:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] remap_file_pages: Use vma_lookup() instead of find_vma()
Thread-Topic: [PATCH] remap_file_pages: Use vma_lookup() instead of find_vma()
Thread-Index: AQHXk28qYXojRB8Cb0aFH4j7RVywRA==
Date:   Tue, 17 Aug 2021 13:52:49 +0000
Message-ID: <20210817135234.1550204-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad9e0067-f36c-4c49-1c4e-08d961864d4d
x-ms-traffictypediagnostic: DM6PR10MB3500:
x-microsoft-antispam-prvs: <DM6PR10MB3500A03F4BACDE7C47B5DF19FDFE9@DM6PR10MB3500.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lOreYjtyd7pbZFxL8DQ0oPO9HdvitPlLkkxZHByWhf59a6JXpbP9UGaloXnbgs68LPlAgd5mtyTnQTO2wQZngb746OKLs4vZQsmYr3oYLVQYecjfqOzQ3HCuhouboSVj3x3BmqL/whjJ3Yt8iQhY/HHSy6IbwjQJvQfhxUb6ReZC2tW5vYBJJHnm+W2NCoAM3GV1pp4HsMPOdJuukkazrSX6v+d8Ge/PAcCBf5vG9GMkPhvdeAdXOS7D2YUncJ5luc/qEy0FJKG7ZXdEv09lBJQFEGS+rGToIUwrsRW8IrM7Ka13bG6DYWS9Ip91Ck5FzsS6Lohdyq+livEVmvtFK2bFCJjZB8OdkgAaBV6tWzfUT1/qeBMVvdk4VEbncKAmnoUS0vMAJzXtutBFScUZEihvGkkxTrcbpX8Kcgftnv4bDEj0JVLbXqVrja/J2i18vXmtFfm5lBg4FtZi/yBnRXZfXO6Wph+LcvXBIu+ayduXDc5x+vSRKxdOZLlB+WaIV5kqOUqg64YTFcg2/rBBdtchAvAoftB2bN27b9DUpXspqkQh/PpwTAFFgspVGyPsez9bUyfp1CExxI0n/VLFS7QoCT+Mf+kp63kzO1tAKQvNAQ6W9vDakuV27qQfEmIqRvXBTXOqoiLifIKygh8++CLV2r/fQnAwc0+fqLBIVf9/4RAWZPplTgJWggaWvTENlXTJvF3KN50p4WoKBkMYGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(396003)(39860400002)(44832011)(83380400001)(110136005)(316002)(2616005)(26005)(186003)(71200400001)(6512007)(6486002)(38070700005)(122000001)(6506007)(76116006)(91956017)(86362001)(36756003)(5660300002)(478600001)(2906002)(38100700002)(66446008)(64756008)(66476007)(66946007)(8936002)(8676002)(4744005)(1076003)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nLgxG1qEikcDrlgderaRRFRAIqwUBd/RlZfnOxRvPAqfh4nJWKVSS3W+za?=
 =?iso-8859-1?Q?B7HQPDPcaKadnt//htDBMxVtK1Yh1A42Uzk6TuSEEBrWdV1oIAtCO9l0Bn?=
 =?iso-8859-1?Q?TfLNIYKJqzJm60Rt7clz8Xczsxokn+XHADh9Tzqy0TrRO2y2nc9zzwkHAI?=
 =?iso-8859-1?Q?cFQhtEE8BcGEuZ1YjIEP/pWpis3XbcQazRoZQ9vTnbwsaDZiYAlaSFpRo9?=
 =?iso-8859-1?Q?gTRU57p/B76IpyTdVTNin1KlBCMq/EXlftUgwlGXgf/mQrvJG+Gt8iYhJB?=
 =?iso-8859-1?Q?/K6n4qMlLT37Pj7ddDqxjefE3xZcCaY5OklLGNBbD8qyZW87oXY++MUvW9?=
 =?iso-8859-1?Q?K7gySKL7CZTcfv4xEy7O7tKbeEgxtldDVP4vFGSdV7tyLrb470nx8P89JZ?=
 =?iso-8859-1?Q?n/R1dcWm0jvFYbwFEW0FRIWzdGLsT3nZWURoSMZqK34KEUT3EbnGHnkHL2?=
 =?iso-8859-1?Q?8YbKJPTImYH9uCVGPS3aH2IQgjN5ashvAqHTAPCXyHesx3gEnY1GS57nR5?=
 =?iso-8859-1?Q?hEJM2Zbh6ZWMfrPNj03/hl0nlAla202CQ3pu1K6EEr7+kno+VGmT7xNTa2?=
 =?iso-8859-1?Q?U8NHnOTqM/2kcf++fjvXAYtsmkFPl+PLcLl/PbN4boz1c9NhE1Vpw4IGtF?=
 =?iso-8859-1?Q?CKGkQXl4W1RVfejjse68i9WeY0XUuwBDDhMvw3ytj3qkDxOERwQR9W5GkE?=
 =?iso-8859-1?Q?vyT/9Ivzz9LuCuE1FesYilT3sXJk41zAjNP7TcmrSnSodN57xBFD+41gQX?=
 =?iso-8859-1?Q?ZpaDtQIoQVuao9UKpi8Vuz5om07TaHvteSbgpMUn4TJQlw0tW1gF1iFggX?=
 =?iso-8859-1?Q?b+iqKycf6sLYTOUPdzAJ32ysTSGZ0l/X8X1zLREfFPMvfb6GQe6jAnTRwO?=
 =?iso-8859-1?Q?Qct5RrpPprZpC4emnV4CLNrodnj7380mEsyRFlWzP+fjcujsxKt9Lb7kMq?=
 =?iso-8859-1?Q?ZAVimuooPu1KZCqW3yhG1FMvY+gVVcd28S5bPLEhQJV0DAuKm5UQTsg5QB?=
 =?iso-8859-1?Q?WNs0LRcYvuLrr0Hs0fKX/Tnd7OxFkJVLTv2zcc73Jk6w4ZbozM/gVupchj?=
 =?iso-8859-1?Q?RmO1ajFyEcskOJAcjg1ds6Q0sIC2yl56LhdXgcE/1f3cYbxB4rZR5m9Ahl?=
 =?iso-8859-1?Q?zurlEHjZg56EeOyTHBpdtx4PQ93YgwvZoeA7V3/GHLZCFHfnmsGxUmN1bH?=
 =?iso-8859-1?Q?IW2yeWb+QivxQ6Ok0qCt6MXZmpZQlQjR4yYetV0lZc15xl6ildbC5oz2dB?=
 =?iso-8859-1?Q?/ffVpafc2LmdL/dQonz9NjlZhx4PvmGvzEtv+lSAkxVYxVRPWODX9zYhNm?=
 =?iso-8859-1?Q?RopD9juqy1O31oXlXyboB5pTPuJh73yUM+t0yaXW18AHTGio5cqZ8nvRL0?=
 =?iso-8859-1?Q?wUKmifiTlL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9e0067-f36c-4c49-1c4e-08d961864d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 13:52:49.9071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTxtIcMZ9BIIJHwVjB6Fl+DO2pb/WackfnvdAeCGWfKaJM/jl+mpd5DLyedroAA2Fq6YNUg0dGcqofNtlCCwiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3500
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170084
X-Proofpoint-ORIG-GUID: ti9DyQXLuerugOJAZNvCJJKfOjxMk5RK
X-Proofpoint-GUID: ti9DyQXLuerugOJAZNvCJJKfOjxMk5RK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Using vma_lookup() verifies the start address is contained in the found vma=
.
This results in easier to read code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d9aa54be6244..1a23d4575cc4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2994,14 +2994,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	vma =3D find_vma(mm, start);
+	vma =3D vma_lookup(mm, start);
=20
 	if (!vma || !(vma->vm_flags & VM_SHARED))
 		goto out;
=20
-	if (start < vma->vm_start)
-		goto out;
-
 	if (start + size > vma->vm_end) {
 		struct vm_area_struct *next;
=20
--=20
2.30.2
