Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C584336DC18
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbhD1PmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240634AbhD1Pig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:36 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMebs009359;
        Wed, 28 Apr 2021 15:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rpe6+hwrsyXNRUtq6oZ0hVBT9Nih5UAPi1NP0jWUlk0=;
 b=fOzJiLh/ZAWucAFTdmrbEJGCdpnT6ZvdhhMIlTSFuylUl/ey1JMwNRZ8LYgeD9/ocEmT
 EBTjMXFzqn/4ey1uUtIuyN7zt/a8oJGIDzZgUFCWrY4Ks4hPIPiR+unzbPxkB0ZREJBY
 i1cfei1RXHO7ugrl7yUnMT0GoR7hj4cF9LVpotKF+JnpR3LpMekbSDbnIUngBSbkGgcG
 AQ06RihrB+TPFSClFAQiKkG/VpXw2A1NJC5Jfqch4r2eO6wtsrFusw1qOzzsx6AutdvW
 bPmzQlpfO+/78BY9nmAnQaH/mJwaJX3LAz5am8okCHOL7JMXQUa0YveFE90KEQ5tD7NS BQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 387a2mr0vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:31 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZjx2021758;
        Wed, 28 Apr 2021 15:37:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 384b58qq07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4BMGnk6CrdjCa2DBaOE1uvWcLZYTnks7OgR8jYsq9+cGfb3sOhJopWZ3cKQWNjatkqybYKxzEHsouLyGuiGDtPg3ucvr6DI4rghh2tklGv7gciCWuL1IYVVT5rZMj5t+oMBK9ioLiNPr+BZDVsVzDFJyYCTJzgaJB5OCoZoi+tEmLoNNlaGYYB+OSSSnMudjgh32Y9Wn67t/aNVI63xLbxOe8p7B0P1W+n+58MSJ/kRZOxiQxLvG2byxCblc8/JTEuQQi5VzU7f8tOKdY3fmHum34VlJVHQMsOKw9oJPtxz7xcaQaow5jn5HTTUhf7cmy/iZfDyZrdxstOe6Ugbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpe6+hwrsyXNRUtq6oZ0hVBT9Nih5UAPi1NP0jWUlk0=;
 b=XQc1tr4YEWcRZ6nxqfO/4EuZDYQIwe32c9bivbJsi53FjWjShtxQ8TDCnd5G/xp+CJ3SQkI6CN74FKu7It7C6kF6EhdabsKvj0oAKRraJzTE2mmNmruYJhYVHmJnEAfPmzkoVGMbHTWUGzc8EbOgl3/3jg+l9DjfWWqyqi5zX8NmVVQrpRZQDoSqQdW3O9QtGR7LXCXwkCKcFm0P/pB17vrAcAJ8AthjB4O6tNE8+d5GTWK+RTwFVkFZYDhv9b/5+Xa05yNH0g9sEGufgpCJ+b6u5etizYsKXrk4Mf8vgl6HYT9TO7XLrE/Br/XAI9jentNKWz6b+G1dF+Vfv/8alQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpe6+hwrsyXNRUtq6oZ0hVBT9Nih5UAPi1NP0jWUlk0=;
 b=zPJEoKC+jQLMEg/XCSJgS3vHIkcJnLdI9Xqp/nsnE02Dl9R7Qk856rT46N2FRQlU808vgUb14xXy7uNIzAdBIQvq/LiS/ptrH8XqPhtSAm+zZLITF5t36xX+BhQ+zel3dJx0Mml1I7i0PJ7f+45IJRSbWx3/GDpf+HaQhJzQJtY=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 15:37:27 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:27 +0000
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
Subject: [PATCH 83/94] mm/mremap: Use vma_next() instead of vma linked list
Thread-Topic: [PATCH 83/94] mm/mremap: Use vma_next() instead of vma linked
 list
Thread-Index: AQHXPERBeyB06BHI2kyeBuu+1h4XJg==
Date:   Wed, 28 Apr 2021 15:36:28 +0000
Message-ID: <20210428153542.2814175-84-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: b81cf40f-1367-4530-2754-08d90a5b8721
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1871BF862E1926CA213A0339FD409@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OeZ2EmYixFuyZOQbSbbzv2cFbx2KRtJmUulO4qjGw5nAWd/Il2RF7rYeX+r51vTM3cWGw3pRsY5TjNGx0SxUdE3V7/mg7OQbuBcgKsOmGj0Nz9F7EwfzhlskHmv/PhFoNcKImnMLh35VAJMPNFm05xTjY+cy+SRPX8DFxqkoCc/Z4KmsYK1IzZ19IfVfz6htEEMckt7r68RRPokalOtARQCB81qd+sBCYDo9QvfGpPRmKZwoWyck0Sved56uEGoUAY3KMNxlGDvU89609JA7TarhOuHtegBBKdLvbLUMNd8GpH7tJtHgbL3pDXb/Y7K8Nq3WhYB3Na1UzVqtHezFBTK4ay6iishtH11ijTxWuAaJTwAlYsc6N3k3rfS7ZF35E9l65fD31v+Sh1VESY38e9v2BMB41BHBkA3HQhOWJdEtv3cx+rpdXYnAhHNfMGf1VBpaOdKxFgo+4yh8nYI/eyFOH93MaMgCesQ3m+ugS3D8i7IaKSL4CP5i2VQu4vvzZLDk72bPoHELbIokY4DzV73RTcO2SJE4Q00ZktSsFa/7DHm/+G1G7DcUYdsDPhVbauhaojNp/yLEsMvwFIzYLNskd6eVSKfmrheG0j8sGSA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(186003)(6512007)(66446008)(6486002)(66476007)(316002)(107886003)(5660300002)(66556008)(71200400001)(110136005)(54906003)(478600001)(44832011)(76116006)(6506007)(36756003)(7416002)(26005)(2616005)(8936002)(1076003)(122000001)(38100700002)(83380400001)(8676002)(66946007)(91956017)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?oR2TNl0A34JbTydebgVUWnJR44qEOjsGHUwZZSISzXFC3F42bKEQBoSsu2?=
 =?iso-8859-1?Q?OhcB+sPgYvWeEcKOMlOWZR+sG14kPYgeh3xbodpukeypJq2rY2GMdD7gYF?=
 =?iso-8859-1?Q?wUCboM2zxYlQTN+9iSp+jTVHE8k1CdVDNMfhloLh7Fxmk3Q0Yno7F1/BAA?=
 =?iso-8859-1?Q?xlUOu5YBtrACy+tihLNWzcX4u/ia9pUFd6hAJ/QLDCL+mkPR+SVM0ZxDN6?=
 =?iso-8859-1?Q?WGZyhYr/DIxXzJqeK3t/9FEjGlVDbzSb0c5aaLGfNp/qHhQ62pphgF2pKu?=
 =?iso-8859-1?Q?cbh7fgZfkdYhJtdgqgR8dV9ab/jmZd9nYDdTC5ViiQiEyflJqOcnL3Sow3?=
 =?iso-8859-1?Q?3WN58+jv6843+TO1WH2Avljj7huCkHr5GU1gqawSyFpDgY8gS7n4L0RiYS?=
 =?iso-8859-1?Q?O37h3Wj309joqJ4Geu6likDW/YCb3dL+9vc+9jmzTOab0pyVM7GXic6j7o?=
 =?iso-8859-1?Q?w6ucnB7NbHbQgJ8rzln/eRqpNTzXIqNJM+LdCV7Gi63YJFrwWIaW6VYvhP?=
 =?iso-8859-1?Q?99CfEt/xo5HD61PpFt/qQzK3jEBebFCuXyfJ1UAEJ9ytNgpj0H1AlRa01T?=
 =?iso-8859-1?Q?Mj4wuva+OhNvmBCeaDIV+2h69bswJCIOD8+E4P/fFwRVAfszG2BApds7s9?=
 =?iso-8859-1?Q?5Ihu1D3d88Os5tnFxf5Mwc/XcI99tyx6sR9i9JHZNIi8XLAhQTcNkdVgL0?=
 =?iso-8859-1?Q?iFLxpvUNzqowrS+B1fasCF75rPalLdc5VvHOalgcWhtJua5QJ537XqG9Mj?=
 =?iso-8859-1?Q?AYT+bGR3dK4EtsbjgYK+uLBPxSiMWaZcqT2cECHhayPM8xMsgZ5zUbicIr?=
 =?iso-8859-1?Q?p2aNXHS+ovJW1noVmVQYUK14fvdzMzWl4AaSf+TxZMOTD0Q2Ox2+YO9UP6?=
 =?iso-8859-1?Q?4rubV2OSJ26eHq9vldIA5GFIR0stzaHO8FaKirh0uXEotv8k+6sF9oqf8J?=
 =?iso-8859-1?Q?CdMO1J5XVmrFy5fxyJOXgw3uyMRm9hJVToD7CQ2MUjrBRMMKgxYdJ6PPM7?=
 =?iso-8859-1?Q?qpza6Pj3H2KDW8MUHAHZrvyYdcB23G7XjuG+9MBpgClRqHuMqAVDMEIu2J?=
 =?iso-8859-1?Q?4s2w3duDctBsXhQcrM4ox9RdxdhNy9ioYVguL8H+rwH6q8IjNhD1DQDEYC?=
 =?iso-8859-1?Q?U488vDeWHhBQ+feNoB/UfzJm+jXfNzz3E2aS0EXz1DN03WwaTeA2jheqV7?=
 =?iso-8859-1?Q?Ms4Qm9Ip0EVd0hLaasq8i4MZXOgCZGHg4C5PMSQj5SWt2NigZWWY4dbArv?=
 =?iso-8859-1?Q?suwPD4oH2Yr6Q4T+9xGhjapwCEgn2OjtaWKSf/spJAhAPfQygLPmcC/70D?=
 =?iso-8859-1?Q?Va6RdUvQ5/uXawiwlqwU30B65PqmuHbe3DWplqNIreyezoc57yPhu47ga5?=
 =?iso-8859-1?Q?idrFvQvlbN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81cf40f-1367-4530-2754-08d90a5b8721
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:28.3086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fgNmoxX7MPBYt66c0FCctR9/FpAjgG8vxcn8/2FhpI01JMjNVnpmowSiQ7lGOIV9Bw4BAdtClUSz6u1V0IsFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: t8C_YPSeJht7zjAiYmAwwAXsfZXjHXAJ
X-Proofpoint-GUID: t8C_YPSeJht7zjAiYmAwwAXsfZXjHXAJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mremap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index d2dba8188be5..3bd70eeed544 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -623,7 +623,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			vma_next(mm, vma)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -796,9 +796,11 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end =3D vma->vm_end + delta;
+	struct vm_area_struct *next;
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	next =3D vma_next(vma->vm_mm, vma);
+	if (next && next->vm_start < end) /* intersection */
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
--=20
2.30.2
