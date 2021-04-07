Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC735755E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355846AbhDGUBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:01:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35114 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348996AbhDGUBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:01:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137JwmAp134201;
        Wed, 7 Apr 2021 20:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=8Kqxui8JRoAWIf89KFsTusIvCwgUK1cX8gkkV3t5+Ew=;
 b=JeWoRr4Oifw1iYreYr+ZVEJXvu0ZBs0+2arbjCj5s6jsz5IX39CkQ+ypgGpWvfKcWRKG
 HhckeaxFg7Ilo9eDueWaWs2Z4RBR2DPULyWM92fJM9BWIWLkVEUK61b1BLlJXS8ys/cE
 qM3a9cJiLidl3Xo3Oljax2uf4Crdu9jP81e/Se6NL9omqsQVyGHcH+gwDCfpGZBSE/Y+
 Pz5J5/0c7gOaBhgM1Rt0jI08hoa7Au/5tfTE4FRu0H4tpg7n7PSFfoCHOSjZY7SmAid/
 OTHzbC4B01lMMBEbUNtereMXmWwWvd5Uh1heGZWs7i8aZvBdz/PojOOsa4cBzhojCehe Aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37rvas3tju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 20:00:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137Jxxs6118365;
        Wed, 7 Apr 2021 20:00:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 37rvbetb3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 20:00:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6ZSomYjhUkn4feN5CWcYXpuyteixLhF8YvTR7rcVvv68JvzwYgKjr08aT03QBSV5kNaNdMcYP7YgAIeEKhak65c3TRzbmtNEs+OiFykTKBJRPKZsHg5xXKH4XGfeSk2f9KwS+JUj51jSjj6PbjKvIuZfBhBghyeoPmp+hCT5QCyXquIwg39CLGGS+wct9623C3y6LRm6EKq8hnOr2qK/tlWw6wymRIsu1c69IL4QiYKObfrnf4P1YUSR0Pn6jLmJ6YbB+sE3FiD5QKePaRionwXKWEcCvFmy3pQVt2/fOBSxiTG9jN5S7QknEqaCD8UNGH08M2e5SnOrTan8/N3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Kqxui8JRoAWIf89KFsTusIvCwgUK1cX8gkkV3t5+Ew=;
 b=jLgXPZvhgGibLNe3NyFtePZoLIica/Gms1IYS17y3bsEDFBLgH+UqBgu/kG5cSMvKfrsRP4iCH5vsilabqGJj++hDKXVBBJirKEPmH3FQ9HWj5bw5Jn0fFaONjRPndk/vINAnwq/sd/9m40/ThdizR0hT7fAJmNms5mutrV0hVB9wlgP+upXb4Jbvxoiv9l65ImN/YrCUhxvzHJT7T3NkZbDzRd5iGHG8zA/dPlKABPHRBS9Dh3j0axFeMcxFABjuZoPyZFt7c2gZEyqvwrYDSyTfVy0k8Vg+TF139pq+wy3QMUekVRBfW6M8sZZZwPmTEQYoA2oeUYipzTA52sqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Kqxui8JRoAWIf89KFsTusIvCwgUK1cX8gkkV3t5+Ew=;
 b=K4f4rvlbpZ0xDjesC0T5QwrCbRAm9654myuPxuXqRry/gxyR0Q9pH1gN6eUQUiRMt0X5M8ErC84kK8Ih6DDxSXN8nZUtU9SYpzdxh6qQ9TE/EZugWpKryDHhehAevjosGQgNv4SYJTF7/ihFeU06N9TkE77+sA25gfdfb2HIRqc=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 20:00:45 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::1ce7:260b:b004:c82c]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::1ce7:260b:b004:c82c%11]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 20:00:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] arch/m68k/kernel/sys_m68k: Add missing mmap_read_lock() to
 sys_cacheflush()
Thread-Topic: [PATCH] arch/m68k/kernel/sys_m68k: Add missing mmap_read_lock()
 to sys_cacheflush()
Thread-Index: AQHXK+iyIuMLgWgYKUeCSICFVkyJtg==
Date:   Wed, 7 Apr 2021 20:00:45 +0000
Message-ID: <20210407200032.764445-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.0
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36835d51-f9d5-40c3-48cf-08d8f9ffd502
x-ms-traffictypediagnostic: CO1PR10MB4545:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4545BC6AA63EB986514057B7FD759@CO1PR10MB4545.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D503oNJmMw7f4n1eI6eZI/1GBlomgB4NrM41Q7BI/tVMScMTi+McgKLsv1lDCr50tni8Col9HH38fOdE+3EceYeXAVQUQ6TIFcvOwvCxLZOpYGPUQ6dleX5AWmNTnfb7jKLOXAp8tZjfaIji1RMrYPKustl0e9CKiS0VwgSWxpzN0J8o+QOH3f0NtfS+LJEMO2xoMfjvibRFPzOhUgVGvNostQza2I4sPJpzEgUVxEJlcnd+sl/gyDqv4hW3lmEVLkN2VCGpEdSPxxsbF+RRpqmav02JTpt1T7bCNZk/OQtNee2ZH23JIdCFYF8WIkMki1S9q+HYLXDLqP5W9sqitkp8h01+15g6Snh6L8dGevdORej/+VWPGiYvE7qvzzY3b1H5MeU73YZhdneWQyfbxQ55yTATbEvlsz/MYW7jc4daEq0onWDJvH2JkpQjjHdGFHVaOaI7FYLPkCfryU7rHYESgYG94pOJ62M3MRrJwDjUGAgoPCOXWaIXQNIAFRy0cosVSFjkFWZCawuFqS05npC9qTq2WdmDSoR6fi4lLpr+vqjviKmoIDzeRx2suZoPAyw0LjSxwNLAMQQQFpc3klcgRQWLRPW0w7rX8cey697jAe1iZpfAsRWItr4daS6+X/rlwNh+6Oz6pCr6KVXrUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(39860400002)(346002)(2906002)(44832011)(76116006)(110136005)(4744005)(8676002)(1076003)(6506007)(38100700001)(5660300002)(86362001)(2616005)(6512007)(26005)(8936002)(316002)(36756003)(186003)(83380400001)(66476007)(64756008)(4326008)(66446008)(66556008)(478600001)(66946007)(107886003)(91956017)(6486002)(71200400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?3aKPpU87b6Gs+kQ/EjkO9paO2fI72n7fkR4hHCHBsI4FnIhiZ1QXlSgsrb?=
 =?iso-8859-1?Q?teuhtD4UBMCF05S1QJWcs2a46Oay+PvlPnOtptMMV/zTX5qVIijnLUxDND?=
 =?iso-8859-1?Q?eRS8i72tbLu/xRE7XwW3pZfw1q/NYl//Ec4AUg/bMhSyYwLSMkKvB0B9qY?=
 =?iso-8859-1?Q?T3l3m3Xk8UumQrdEqOxazntG/6mJW5UiEVXT93dBSpsCpTTUx18eUpOC/n?=
 =?iso-8859-1?Q?GyUYMW4XhbtXKg4ZrwqbVpg7V4SoGDHpc9km+8/FJrN2B1kEgoHgCnby3u?=
 =?iso-8859-1?Q?g11f2GH2n7GajRWyj8RtqkVMbhttO1+Ko0YUvpynOTO+HhKjQSNhxHRlQE?=
 =?iso-8859-1?Q?Smv3kXcIyRxpfjS8p8RJouEV75DdJuXJso5o7VPdSYX5amL22p1xuQkcxO?=
 =?iso-8859-1?Q?NLvnZ2c9K4+zzcKL9DlBJBWqrQTnV4XeLOWvcG4OJPhn2Pq7WOKvJ2DHsR?=
 =?iso-8859-1?Q?22GZ/yIK3RRHkf3ycl1j4vBN0MfdVknghswdXItPhF909LoKx/x0tWKrKg?=
 =?iso-8859-1?Q?a7uES64DrnV4NhYrB6MWmU74X0+OVTB6Io7xTFgjS2nmF45UGuDEs9mwCB?=
 =?iso-8859-1?Q?72dPr4N6WqX5xTh1OE8tpUbw8L3c+9xCmXQzEYdZCA0R6cmLGc/0vqmS1K?=
 =?iso-8859-1?Q?0KdPSxyR3ssDfnQdbaWsbLuZ6OkATVZ7xkgU85XQL7cX0Uh8pN1QPksKnI?=
 =?iso-8859-1?Q?JO2bAKb3L+ZCxJlvJDsJgCjwB2PFDC28ex4GrqQMebvUk16JXZhitRbnhl?=
 =?iso-8859-1?Q?UYt+Aou3YMLNoDEmo8gNKhzB20cOQ0G1EXM1ab1YrnoJDEnb2CCjRXdQk1?=
 =?iso-8859-1?Q?hUbCR7PxpL/htJwsXU7YNnu92bKZRZ7x4H+nxyMPr1+T2lm/2QyWhxLqwN?=
 =?iso-8859-1?Q?KvZev16WFoF6RZE8Umu2l2YZZ1GRxaSd8dF7iJ5ZqJeYp/hRup7Fglwnlf?=
 =?iso-8859-1?Q?BinqKETnEMdRY99ZZ+AwP/BA488FqJ484KvReq9yqQKNDXVwn+zAB8acTK?=
 =?iso-8859-1?Q?zioJyxeBXvxUaWBiDOOSSzMRLfF099v+sXQmwS+9hPDN/Z3+WF3tG4fF/g?=
 =?iso-8859-1?Q?ZGEEhOLeVB4YPt7IaDlZSENgeakRl/VxMPOs4FqjHsT+Ezwdf/3emyUPjE?=
 =?iso-8859-1?Q?ZfWJlMc5tVsN8ck8TDpOn60E5Q62cpxTTt7hRmxc+/zNg0NUf3E6h07t4q?=
 =?iso-8859-1?Q?RrrZngRxBukKjzqzQqlcpsazIqTsvwnSCJ0MOpBRldT2VUBPE2i7Ss51j/?=
 =?iso-8859-1?Q?AWXz8S227OxTuMtOIJFYC1OCVyt+bfTJYT6Ks415slMPapti3jDEu6ieiZ?=
 =?iso-8859-1?Q?k6w3kmAf2O8RsQVmshhCZbDCMqEnY9kSufYCsLZDi35bBhuEhUdDBzeRCa?=
 =?iso-8859-1?Q?u6flug7Oy2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36835d51-f9d5-40c3-48cf-08d8f9ffd502
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 20:00:45.7229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wr1L5voWVMQEqBAzPERgBCBCx+Moi1fNAThlx97LwUqXIfSmIzBF8QlJdgD+ns9Lel7n4Fn3vc40FX243ZnxjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070139
X-Proofpoint-GUID: nBbS18TFfE9GFUG7Pqjux0aXo7iZlNVL
X-Proofpoint-ORIG-GUID: nBbS18TFfE9GFUG7Pqjux0aXo7iZlNVL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the superuser flushes the entire cache, the mmap_read_lock() is not
taken, but mmap_read_unlock() is called.  Add the missing
mmap_read_lock() call.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/m68k/kernel/sys_m68k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index 1c235d8f53f3..f55bdcb8e4f1 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -388,6 +388,8 @@ sys_cacheflush (unsigned long addr, int scope, int cach=
e, unsigned long len)
 		ret =3D -EPERM;
 		if (!capable(CAP_SYS_ADMIN))
 			goto out;
+
+		mmap_read_lock(current->mm);
 	} else {
 		struct vm_area_struct *vma;
=20
--=20
2.30.0
