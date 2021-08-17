Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02BE3EEFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbhHQP4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:56:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29944 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240324AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkHqS018099;
        Tue, 17 Aug 2021 15:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AKAQ4/XSRXKFOqdKGDnoM8c/CAh3erBlNPjdXLIdJ7g=;
 b=OEnUcKqT12LA9hcfgKQps9S1cw82InR0BuXNml6Q6j04xmugVx19Dv8QzmlS1emKh1TY
 rrBQKLZa5958BxFXvDMcg6YMCmfDrz5ynPuAlpMA5PQqIKqAey/21gM2GSzQpKg5d0An
 DxHfPyrilrnciHuHiePp2hgX1sH1EwCyblNOCIjURzrUZhkppKln7AGXjHTE3RaEjaAw
 9nUjOzUoUNdS5SiBcK78eNlcvuUI3xnEjrrCR4sk8tUucphPjf7+fEAOze/HfTtlXcAV
 UQEIE8lFYoPUbwdw3i5plaBvitHl7zjcxv23AaMwHy1qJJ7lk7UIFY9EmejbgsLnyQ+W zg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AKAQ4/XSRXKFOqdKGDnoM8c/CAh3erBlNPjdXLIdJ7g=;
 b=kOFSh3y0NhXZp16jSLAfoOp16eOnFCeDq13QsZ57Hd3cN3P9EVuCIQApi6QyZd46ZnpC
 3YCuNKecwLWKJkNcGTbPSdFw/RY5SrPqXyu/7hLf6eNLG9JHjKm5MhyP6EkTTG72oVYA
 dWBTKgdHuF785aq7vAoN9x9Em5um7EyaiWdEZ3VICIyjvuROAbnT37Ptrt9Q7BLC+3j5
 8TfWpwPH5QOzrky07K4leSGMyrlD4bu7vD1gc144nkAvE9ywwdXJi1RGJp2JrYFkoPS+
 2B2GSf3OI6oEd/xtQsUr8KrdkCdpyLJRTNjPqzwreKuzqbTBwgPPGRqC9HWP7Ywbs8mq OA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3Of174039;
        Tue, 17 Aug 2021 15:48:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2vn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J20cqftp2mrbhzibNcTSqHNM8kRRlEt1EzftwNYEbswNs8C7FICEEfd18Pcv6lPC0i7DcRu9vc5V5x0JccBACPv+GsgbnZyZDuIZPpN3+CGBfZW4ltYOtf2s0NV3+mIBp5n1cnVr1RcPnmg1dV3We+nSFLaQaYIOluGJMv/YURAS/p1Ztld/sZ/5VruSDDvN5RuGewbMxXqj6RtXVub6beMexJ9kuRSoKF9j9tBL+fXF+ooeP3mNuWkAcSiz2MjvYgfx36IctSdOGDYUgzzMCqivqR63txKG/5X5syU3sBH3fZCipVzOcJsU6eM30gvJxXXychOc8CeYcDCBH/4dGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKAQ4/XSRXKFOqdKGDnoM8c/CAh3erBlNPjdXLIdJ7g=;
 b=nZsihmNg7KzEh63/sQpBUpUl2vUBpwI3/K0BtvrH0TP+CEF3c0i98SXlE2qYaUNOK+f5+Zhbz+I1eEZ/y5vS8ocWr0EIUIxd11ssPNNp0TcBOpN2LgYrumKDzq5dPRX7cmYwjsWVaPsEHYR9jml2Ap15W/l6BUSMbsv/gpj0rP7FwS2gBRHzQVoEuceRU6/y+r0Vg5AqZzXtpK0+WQS5N4G9TWBTSn5aUjTZ7wEApzgAXYjxDB41IRDPnZLccqdbC5Bp9QQ6Xjbh5lDvso9Altd5dl9mdjXo3VHwnwDo/SEZMk/6wjATlgKplncGKliC2GcVBDaQIVlPQWobI79Kyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKAQ4/XSRXKFOqdKGDnoM8c/CAh3erBlNPjdXLIdJ7g=;
 b=CK3kMfwTOt/BQx7OtCNripKrUMT3uRtbQjq9YS7Nm+der1iKPmT4z5YBqqx9R6ow01qTD5x/dRxc6kfw17ImVurZENTNBDfrHJ1Gd0Gf6t2ziPDn3Tw9hrzwC3IcsptPwFh7BL7xDnR1oBBBVA+22+870N0bzyWdDsDEY3Bq5sU=
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
Subject: [PATCH v2 54/61] mm/mprotect: Use maple tree navigation instead of
 vma linked list
Thread-Topic: [PATCH v2 54/61] mm/mprotect: Use maple tree navigation instead
 of vma linked list
Thread-Index: AQHXk38x6jaz1VA4SkCCMoYWqmHpYA==
Date:   Tue, 17 Aug 2021 15:47:32 +0000
Message-ID: <20210817154651.1570984-55-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 64c2946a-603d-4aac-ecb4-08d9619662f3
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3580B48A59C052FAFCA65C64FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jAGfit7aQ5lbcTFozugd75wl2bGr/F83ENwH60w5Z1l+57/oEwCa3MG2dn32UvI8qRF3IPqtW02USnSsea4ovOF1llm5NYM2akYt9ZX9fYc9haJUR2nr8X1q/XlJMh7UxCnk620cUQU4ecWCDKf4/61m7/pY7wzjZOUpLKw4XosIzsamhrvSWnCvlGcWkiN+fVQpj2UzHNLO0HfVk/xcZLQe9g4Lk7eiYQC7jHU1LMNE1nmgsYmNKmJBORDKBg0AkTsXqzO8rvvnvz1nlmcJ2HSkIU3RaMDJ89v+IqaGvMiWRX76/k1oHHc6Dg6KkZjbd/CTB+n8wVB7usrVwSSMXKPw9RI6Ur6nqDqm46qzxjgn5VE23RgOBW3xHgZ5ZqkN47P/YVIczJqNNvIUVqwhiZ8FkLo+0BLtpYBXfu14kAbpiSDL76mMdPxdqnOYn4nutbREkEtau/REJMctUbgmt1OKqbWO11JFXYvpAbmTh2RYKQcPXvXDbM3AXaLSEy1Frj+UwDDHLk4PyKDGI5a23ftf9PE1rBh4q5zgs0w1ze6/a1vJiU5E76MXErs9fv5utGabMnHSwKqXdYDjjDr9t3ZWWjHHj3B7RixpX7uaouo7/smHN8QMwQbjASaXaehyJebXCO5iTC65FERmdrZYR9rfkO450WlSI2ajo4pNvbKuojxiYEZbKTjzVhxMKEL4eVew1LzE1lob+zd4teznlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U5b8KlAPiymbkDhZtJDR43lh/vsOZCNyGuMM+Xp42WSk7lzLWKczlgIA6/?=
 =?iso-8859-1?Q?Bz4V/tRDllxxr7RVccgXDiFp7YiGlJLbc9QESnQbfr/xW0nUI6o3ZMKkl+?=
 =?iso-8859-1?Q?jPTvmeNxU7ULsBmVYgFECBBGzUwxBfaZUBVitO1msiIDC4qhx3/yk/oJen?=
 =?iso-8859-1?Q?gRLCgltDBW7NPmRztqSrePyChqNoHnSTh0tqK/UYIlY0vysjnMgr/Ky11Z?=
 =?iso-8859-1?Q?sHnMx0+H+A2lY8mRy8D0Op77N5PH5VFXfi9k7cKEJ82QVOk0PtLvpTAi5n?=
 =?iso-8859-1?Q?pDO45iFdyI0xSGASO8RPG7RrK+fTkTntj6qrdVZN62QGFn0gWiczYA/Jar?=
 =?iso-8859-1?Q?apmMYLqB0UktGI5hp8TstL/RThDqQ62TMweQl+87XDK3AmNns9TqwfQZeS?=
 =?iso-8859-1?Q?iaAsXhVpi5Ehf2g26j5zKYkbvD2nyQsRh3AnDtvGRAqL1iwdj/v9Su7Om1?=
 =?iso-8859-1?Q?Q9JNwOxGSy6IGPE8zkqjYwPVUVYd1aoATIamFrrz9keCXK/ovX12t1Aqfp?=
 =?iso-8859-1?Q?F/HnV8eA8+8NxLROohykC/kQpxz9+6PL1WMZJ99pGkHXsItUALC9b3uY9h?=
 =?iso-8859-1?Q?uy/0G7RtawzR5hasC7OIaAVU8yTlC47DrqvH34rGE5VpuLYnUC9B68K7Rb?=
 =?iso-8859-1?Q?39OaB4ZmAzsNx5fkS8/PlwkIJi8nz5z9Pioa1RCXqjZVLD/fVJQisDeJgX?=
 =?iso-8859-1?Q?4rTtEHQvbZax9xjb7GZyr6jYCX4V3/ZFfK62yA+7dzRnFqgsUGA0hk03VH?=
 =?iso-8859-1?Q?IYzock7NMIlEpfCVil9W+wslXLtf60XBoghStw7c2AMQ5RLyFoJ8DfEayI?=
 =?iso-8859-1?Q?rHvWX2WldekiJ3hFvH7ug7beNqqWxD1l957GIg2FJSpWlUki5cTMYH8R+9?=
 =?iso-8859-1?Q?DDgZIHfx3cy8KQOfj0ljz4ubZvmODsbgY2Gh+w8uqKCqjZZOcsj9o3NJ1D?=
 =?iso-8859-1?Q?tu17SWyfCCtmPN//Tg3h7m/MxWghVbQu+/19vYLO6k9TNT6W8MqMNHRKTP?=
 =?iso-8859-1?Q?Zaq+PZj0uxArcXqwFcbrnkCc/Ufl9/pzP4ce42EvLVtXSt44FoV/9Xrgiq?=
 =?iso-8859-1?Q?4ZZ0PST93Qdy/evSRWhMuBwBviylmlUfnoWqqOYtV9dsGRA9eOTRcVyt9n?=
 =?iso-8859-1?Q?lj0rC18AfUbz/omGwKFZ+WGcbF3y+rke6wz4grUMpEsfj7X3/ju85qyaWz?=
 =?iso-8859-1?Q?ZmA9hxPu/g85u5BR6KwBeo/igkqim5Mpegp9qxRPx3UjTuFU4iLT7ZyzeF?=
 =?iso-8859-1?Q?wICJNIhSJE9HyA1Hr1/GFzmP7yFM5lhO2QgQEmxBWCHoRlxvqwvdWmc52W?=
 =?iso-8859-1?Q?JkZPEmwXmNoaFS2fF/suCIlXq1OunDybo0v3vUkAsR9rHemqu7M+BsmEJA?=
 =?iso-8859-1?Q?aDVpT2ULcR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c2946a-603d-4aac-ecb4-08d9619662f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:32.4588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBQ6kBAb5sbhIKG4fhCNNe9C6m+bSz23aMyYpwotijZI0kkPtWcVOk+zneFlg5PivAggSiv/92LyEuSM9cc/qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: WvYjoXZY_2RbOJD-DQXd0n-GAsUXhuyo
X-Proofpoint-GUID: WvYjoXZY_2RbOJD-DQXd0n-GAsUXhuyo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mprotect.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 883e2cc85cad..a4041d2c0dfb 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -528,6 +528,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const int grows =3D prot & (PROT_GROWSDOWN|PROT_GROWSUP);
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -559,11 +560,15 @@ static int do_mprotect_pkey(unsigned long start, size=
_t len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	rcu_read_lock();
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
-	if (!vma)
+	if (!vma) {
+		rcu_read_unlock();
 		goto out;
-	prev =3D vma->vm_prev;
+	}
+	prev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
 	if (unlikely(grows & PROT_GROWSDOWN)) {
 		if (vma->vm_start >=3D end)
 			goto out;
@@ -644,7 +649,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 		if (nstart >=3D end)
 			goto out;
=20
-		vma =3D prev->vm_next;
+		vma =3D vma_next(current->mm, prev);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			goto out;
--=20
2.30.2
