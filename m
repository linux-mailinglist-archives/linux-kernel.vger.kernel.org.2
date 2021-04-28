Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6401A36DBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbhD1Pj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50202 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240260AbhD1PhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNxMI009843;
        Wed, 28 Apr 2021 15:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+7uGbek7X51L7CkHa980O1x6KwfQi737YcW1/jOdNoM=;
 b=jXLEctEGrwB05fo/pjq/d/eti983IeA6YFiIqn0DvGbsMBTnvBGAXaXKW6D42DvTnQOT
 C1Ajm2HkBYeS7qeI225k6j7TTSx+H/An3/krEOaI1U3LtYTbW1J7sMHgr+zKbwaEYjcQ
 cqQC8+9enoIhIT6oIW6zqwBbrE5UMXuLW63CY5Vba5Q5feFmrLB+vB8q98AaqD5juQk0
 5t1Mzej23ZRigFzlI5tgT2xXVgJ9VSYovPMCYQIjTvSX4UwHD7Eqd+8uuwDTbX1NWMW9
 PXf9CIuPF+zzgmGmXjMdX9aaCnHrITe8bjiZaXafybvspSDgJlh4maTVVXJLUbCoUyGE GA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 387a2mr0ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:54 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZorD158269;
        Wed, 28 Apr 2021 15:35:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3848eyqw48-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahbhlFigJUZJ8ujspBzEoHw4fxzLWEZM5DXlUKqi/0L7c4zTTajWOnA96bm2auhWIZ6xiCFSWGnfy9KzWhKwvsTLX5wNFNhT10AA/oC7Qr3Hf26ccvDBDOnXUVi1LpVnrBk3FbPx/IA2zRzaHfQwY3YB6qA+FMt0ftlnYHiSqLH1ZkdOyyJMtaMcPp7vnMCQTEr1TY/pW5mZq9LHpjIA9f526yfZQdgkHAHO8a4U8yUq40cPn3aVDxtc+1kK5jPHCkIQi6/5VTSPq8BgErPfcaFZcUyoMznVWpIzqTzfpAiFXDlPHdganyXnqfAppDTc8ZdwwglYtwDbQX/bWA0/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7uGbek7X51L7CkHa980O1x6KwfQi737YcW1/jOdNoM=;
 b=Vc9os3sLk4RA8FKeplfLffV8SOg9AT0C72jNTTRo1IF9U5HBPhkOPQ7qL4V//jPu0eCtQOLo41p6KYg8wDI0G105s9NmWYwq1L/ppoO27NRczvjBXv37oSbnSdY3fqyaTSUnrYYUo7MxIGCBAUBtpKWByxkCrnMDfLGuNHeRaUam7aqown1G0Yjq5MVF6t3RtLTbQDemltXT81veuoMU5hR4Q5f/giHxo4X4yDwblkLpN8i47loo8GL0mgHw43qAomVmFNvLfzZkaa5c5tOlrQRFJUP1nFb4bCo+u8vZGBcoNKQbAq6OdW0L7r2taDndSoHEvAncn9L9ov41TdOUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7uGbek7X51L7CkHa980O1x6KwfQi737YcW1/jOdNoM=;
 b=VxNrNpcsR9kpWrNW+LH8QYJIZyLXuYs8K9wm91qTkKJ1zHA/FDrsqQwsoFJ0X0qu7lfJQBoMlgSIcpV567cLJ3XeOyq8hlCa2GTsmwUTJquuoG9M/CmZd6rLuYBLxi0atst+rIx57pk/yNUOj+7JshAiv1F4iR2/B1yfPXQn1i0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:49 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:49 +0000
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
Subject: [PATCH 13/94] media: videobuf2: Use vma_lookup() in
 get_vaddr_frames()
Thread-Topic: [PATCH 13/94] media: videobuf2: Use vma_lookup() in
 get_vaddr_frames()
Thread-Index: AQHXPEQpx8KtavYfOUqcvBaBbmALmw==
Date:   Wed, 28 Apr 2021 15:35:49 +0000
Message-ID: <20210428153542.2814175-14-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 2cdadb11-96df-4364-726c-08d90a5b4c81
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4497A5143F26877AD393F8A8FD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1J3Z20yx4uDyMJqZrh83gashMm/uMuJ9mTiAmkAWTzbi39DQr0LgMlrXWVveqG6A7L6eSWaw16LUc8WGx0bSXvgJhZUFQuQLHXc5kJXN4sxbeVMv+EGc6nS+ZYRcQTkm8sjfO+NqRWMo6tHY2xyvlrOGgDUosAmtTJmTyutqNGOs+/pBpB2hQvK8O4/bVC0T+sfW65DrtHxJqfj/1a6fM2Igkju/o/H88Ri0Km9NwWjO1lC5Z/8U/nw2PuWTlXMrZf936XUjwa16HrAvv3gbxZWZ35tyIMEFruDOOMei41Wgoy+Mtgv2K4P0pTJTentEggwYDD6q0EWs9B/blWuUp2MKz4J6YgOfSFrx8X8TFWBGVDl/8Dugd53MxM6lTttTORRhy6dt1CO3w6J0aba1PHUrdoVGjsIzwTZuUT8d1Y6xOuOpAUZfrhu95IjUCJOmlaDHLgPjb9cHGQPppWm4bCt62g2HVrR8i3C/gbPn9j5OdNgEHp205MKAuDosUuCK0nKO3ZligD1UIULErVEPY+cfsaE9AcT19nd9Z+bvtlSar9TLZTszvbo2Ojbibfdx0q0+1ZAd7/k41h9+BLxSTW6Pu8HreTclmrHDt3oOffA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?CsiheuwO60Jg46dEdktO1wEKxBW+GU+AWeMQ97U4LkcKlkSGxrF4G1CbGF?=
 =?iso-8859-1?Q?7bebhF1jvug+5u/khUCAZOWqlazD7RP042szmmpCZGcoiPGP7GvMoFLJeH?=
 =?iso-8859-1?Q?NZ1/1DBU2351xwaJUfeRXnOwtRMLk+0pxZKQ6azIWxHFKsgBHNR0n2+/3Y?=
 =?iso-8859-1?Q?VGEm+4rF0dU9PIZqBox+YdkrpWn3XXgBbpUHGUr4WGr4hC6vwhCMgoxVTN?=
 =?iso-8859-1?Q?j15TN1sQapQPgT6BCO/qmmmlJZATuFkrPyoUX7nopbLPitaveh6OJ894d6?=
 =?iso-8859-1?Q?2bDuSC6mrrSSCYBvn0ZVHnd1t0f/F1RUbay5KppsceMnK6KCorH8clv/eW?=
 =?iso-8859-1?Q?br/57ueZq2/G52NRL0/236ohaiLkNwDgYBhCvd4Z7aSahH3E/HQZqq4s65?=
 =?iso-8859-1?Q?bUmd47RxXNp9cflVZ7/oy3CcRBzIiWHhc5pyyJRjJ6jGdd0A8cKGcMVcDh?=
 =?iso-8859-1?Q?c3mSSNaXmxrd+Y0AYWpEsfIHoEY3+A1sHRwCTiPSF2gWFQHZV3cl2sA28r?=
 =?iso-8859-1?Q?KxuAYM/P7JO4FIY73C8LMGw5m41v1N1Ojjb9Ru1ip+v+QDiJOAP5HKNcXx?=
 =?iso-8859-1?Q?c1c1Jp7HTEewRrs/CTjcIXu3G1zB7HzCREcwgCJc06iCvl2t4BCjQE7YG7?=
 =?iso-8859-1?Q?ezHN/9tHjuRe8GEuYv2qwiHtCK4zjShXH0vuz2n2wHcajHo9XlMTf9Ev7A?=
 =?iso-8859-1?Q?5zKLfhBOJ68LBHe6Gn6YPBe0fnVBq+nl28yKSucTJqEoBrBub3wjP/bmTT?=
 =?iso-8859-1?Q?o/6srUaA+b3Fa6zsmcvguElZoOdIgeVvWEpSeVY6ZplJVwEyVWlqZdjE1C?=
 =?iso-8859-1?Q?1PAdVSY3cFv8b2+WRmPOu6E8Q48+GXIFwZC9a5USJR8cydYpgaitXo9d2X?=
 =?iso-8859-1?Q?FXBghHn91aY6dE+F0MurfucRcqEPblvcGu3HjmloxaEchHmpNE2X6Aa9SF?=
 =?iso-8859-1?Q?xSfnMN9by9XRREuGVHNBjyIGWZD2MTz3DmN5XseaGds9y+y9O99PEP+UkI?=
 =?iso-8859-1?Q?ZSR3n5GdG7G8LmOQtowtjmfcgazRulosKgf2scyvK7rloQsmbKqBAsTBlY?=
 =?iso-8859-1?Q?oAwxTERFQdW3gZSX1R0cjsnoUWyu6mw92t611SX/qFcG0+nq5u1qrbFEz+?=
 =?iso-8859-1?Q?C1UggYC5wLITfT6MbjOI6kH+T1DFtEkyI/15Qd1VHV+CnhO6oflTf9nktS?=
 =?iso-8859-1?Q?oEuKp/2QDto299RYmmjZDiErj1YvsHb/eMkZv+yECb6hLNI87dHtj9qu1F?=
 =?iso-8859-1?Q?sfZCTj8zgMuY9X4+2JTXSR5PuLXPp1mSv0IfpX+htz8X23PTuEP6IjXnXA?=
 =?iso-8859-1?Q?XKODn2Lo5Xg23GtmfGZN2zPu5mm8NYkv5lwyc0Bz20Cv+Z9f6NrN6q+6OD?=
 =?iso-8859-1?Q?hD304HfbfT0UoXR15j6Lpdw8oxNTyT6Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdadb11-96df-4364-726c-08d90a5b4c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:49.0169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCjW9klqLM8DYceF5p1bPXndq4eE7MrHU0VLvaehvNLMMp16TsAOYSJBg9+X4O828Y7AJWmmEP5xjL7xemD4lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: jQo2FAbljSgLldhVbhUZY10jsV6oUVCA
X-Proofpoint-GUID: jQo2FAbljSgLldhVbhUZY10jsV6oUVCA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() does the same as find_vma_intersection() with a range of 1,
but is easier to understand.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/media/common/videobuf2/frame_vector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/=
common/videobuf2/frame_vector.c
index 91fea7199e85..b84b706073cb 100644
--- a/drivers/media/common/videobuf2/frame_vector.c
+++ b/drivers/media/common/videobuf2/frame_vector.c
@@ -64,7 +64,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr=
_frames,
 	do {
 		unsigned long *nums =3D frame_vector_pfns(vec);
=20
-		vma =3D find_vma_intersection(mm, start, start + 1);
+		vma =3D vma_lookup(mm, start);
 		if (!vma)
 			break;
=20
--=20
2.30.2
