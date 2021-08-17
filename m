Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912503EEF9A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbhHQPyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51922 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240267AbhHQPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:39 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkHuA018094;
        Tue, 17 Aug 2021 15:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NvANh4Aqf2SswLdydsX2QNVQzKfTBIFtMllKRY5PDoc=;
 b=jSFbMuX89uD7U1H8T6d/+LEq4iDSFQejN3+QUj4Jdl/0m1V9Cq94Vz7USppblkh0iihe
 t2UmPbfNqn86dfm1U7B9tEtaQzEgYHzMS+QHZKXOHn/qGv8749BWG4oQSFgPnI7UWDq+
 ELxrk/K/gRePYmqGih3DFJ6vkm7I1rfq811H4zkaSx6nFGjbOi3Tz3hi/HTj/owc8Q5Z
 5Mqr0uSH4QxZm+6uaHa0MJ4B8gc9gqlSDg2l6YfVsCJKppUPjCQbcR3iKuCkdy1szeJ0
 D/Ut9Qd7iJkwl22p1bpBs8I6uA4P7SzisgQGyQ0lXVDkpdjaPOgOVvn4tm6iK9CcfIGD 8g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NvANh4Aqf2SswLdydsX2QNVQzKfTBIFtMllKRY5PDoc=;
 b=RgL9AbmspxT1iyeNHJ1Uk8qICKzuK64FeL50pY77hNvCGxgNVM3BFBPPHDRaJnDN6X3w
 ow7jIk/1SouazsvWx2dCIlkf2DgYY5dBo/w/EGjm/FG9Ey7oJX4EXONyhbO0m7gK5WQ5
 kc2L9orY/hD7cJ2cl3x0mPoKYccHAva9UBTJcGoVGUI9XF8LxQDEBSRj/7XZzstJs1DC
 r0rTQHuZfJjuCzRCglSJ6B0I8qM/kfjyRovAA//7sQE451wcN9VYSJsni+5q70UFYx4X
 sVGE6wnzgA5wg6CnlbNukMLxrW9uFLtNolLTrBj7fOnU72BbeM4efPKwkNLQHii0FO5u aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmhQ158764;
        Tue, 17 Aug 2021 15:47:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3020.oracle.com with ESMTP id 3ae5n7su0r-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnRpmqy//VT4icIrFxg5/gHikaoHbQqKAkeNUahQmvEpHGgdqf953R7t7nngvh01FjyOzC6T15lvfp1xOV1TaYqt7yxxiEPkmkGdx7c9VB/CA2tYtdcsYRKTQfPTdsrWBzps6RnpIRKStvB6AGjecHTlTSqZhciGIvgbkMTlOjGLn/h+n/9JoQkn7PkDeid5AdO4V2AMhelWmaUe1qaurVeQ/HvEsqbXvLeB7OyGhiGg6eKyUD12XsrKl4eQfp6l1uyrV6Jz7LFbJAFM9wh3dFksehuQRM6CVPRNEPyvV49vcSmICEhCmw94aG3XrU9ViEGpDVUX7WRYhIwR5a9luA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvANh4Aqf2SswLdydsX2QNVQzKfTBIFtMllKRY5PDoc=;
 b=ecWbVcwwV8r35c9DRwajGjirx6vVE50ejUNuA4C4NrfiF56MeJUmcuNRLdyXvU6034A8PkIwXrRmOoTjcTzy97Iak87ZBv15loJJCMgV18KeJUcivie3VcRoTw/11UYM5nktxl+vZlKaaOSUovqHA/y6hUOdcXzTNMnAYS7bcScVm6frgutFJmvVf8j17XmQQqv5zdKhe5WP57jnzycYYCfiZHUDA+bmzteeJDwiGZya6u8FhXXLSZqkb1DbfERmk7n+g7E4dV63/bVfZhdslpqcg/X8W4PiNlUUPyIn4fNplP975fYLVjvFr/5wUJ80ClAL5EyFDmNr4Ggyzgv9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvANh4Aqf2SswLdydsX2QNVQzKfTBIFtMllKRY5PDoc=;
 b=mFtBziUjofsm5zrKEbh+92/rYDYykyeem3COt7fb1Wt3yiIBBu2lEFhvmrUsg7BhLI5tOCcCCjmcSIxqz2Y1ojClaxMt+5FX/gNa+URYAIL1/Uig9wQYJTesUcdwq03kEVqr60aMHmsV0WrG2y0+GpK1uCH3ogSI/cfWfOmSfcQ=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3097.namprd10.prod.outlook.com (2603:10b6:5:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 15:47:12 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:12 +0000
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
Subject: [PATCH v2 11/61] mm: Remove rb tree.
Thread-Topic: [PATCH v2 11/61] mm: Remove rb tree.
Thread-Index: AQHXk38kuOi0fuhFmk2xO62p7QuQnw==
Date:   Tue, 17 Aug 2021 15:47:12 +0000
Message-ID: <20210817154651.1570984-12-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 5395959f-0668-459f-3dcd-08d9619647c2
x-ms-traffictypediagnostic: DM6PR10MB3097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3097EE34080130631DFECB90FDFE9@DM6PR10MB3097.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P0qJFMD6M+vl5PlnCtGvn0sC5i/Wj+s9gO365R0FKAkH5hCjqVqRLz0rLTkRQcTjRdy9+h+aBynZisys7aai/2rcweXeQ3B6eE7DsPhnh1x3dydI+MURcZTyE7ad4hJaIcNqdlJPc4QSCaeSXaZRayAYVAm5cHfBcxtVyQi6lAyQMwikoY6EaWe97Jq7E/9l1r7a3/p/8qkl0iuhBroq8Mj/ad0LDznGajB7XyH+HDXcFa52dp1toqgh0uBmQcv6kmZWPfDVhPofA6x4fUgaqCCYNyJ0hdGkXkXBjrX6G2GgqZBSq7QTJCvF9Y6osaros4/w8arMVG1TCImqfhNDyz2in/AM9GA9U+zCqQePGS7u0f6/62euv+JyxQW+vPzFXc6/DaGhsCIPaenf3eC08+4RsFPOg20wSSTDkbO/zCaLJZ5jCjzgrI2C7fng15uJUy16KH6Iz1ynhGehN4paWQWeon6AnIBeY6OGmnISEJ/+X6bIWZgB3PJlt24nwvWcqR1j14JghpLgKl2eDjXBE+6Vea7jolhn0phMgUiByqn5tLooGOm/ddxlcMv6MR7/IZkkMFsZUi4M2G5fxAugZG6fw2L/wQ8+YPeo7kkd/xnYUTxLvXI/+naAxpUZuE2ALLIbfKdM8wHgn4h4EqXmNumK9augbfy/HstzAAa40YfZNfQAcPonXIEH4pzNWdIJ/hyIkOo+XnHJzcEfciradA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(6506007)(2616005)(54906003)(8936002)(478600001)(26005)(1076003)(38070700005)(110136005)(316002)(5660300002)(36756003)(30864003)(6486002)(71200400001)(91956017)(66446008)(122000001)(6512007)(38100700002)(83380400001)(7416002)(44832011)(2906002)(186003)(4326008)(107886003)(86362001)(66946007)(64756008)(66556008)(66476007)(76116006)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sZe2vlz0p3evO2AHmIU+CkCnvOjcpYgDnBJKjWoviar+F1pPRrxYRvq+Sw?=
 =?iso-8859-1?Q?MrbjJrRpIIiixlx7nj69cuc8mcjalvCg7R1Wv/rHS40leLCB0ckVLdgYP2?=
 =?iso-8859-1?Q?nEiTm4DibAGvbihlUJzeOLsUfmxkV4WZjO23eOjTTgqEEdhFOgtOZOKzFm?=
 =?iso-8859-1?Q?2b4+4DCIroABSVTOTnUdeIJewFoifquxgI+tJVL0JTwbsOR2cSOwv3n4X6?=
 =?iso-8859-1?Q?vHU6Rn9mVndLOmeYf1fAxzHoiAt8Twa5uUoyG7CmnZrHd02U0agCDY0j5P?=
 =?iso-8859-1?Q?1i3J/uyhkaH+/pdw+4IB5X0M0nDllaozvSs65Qd92YwizzNdcDlQAELF0d?=
 =?iso-8859-1?Q?Z2Y7/Pq0VpbZPDqOqKE27TBnRYvNhVvPpLb+fyqGEyJ/gvskTw0UjY8LCo?=
 =?iso-8859-1?Q?NId/v44aIDJk1o2aeCkdn4QQVV0dRl3kIzz+30DDDGjFJpSwwgmI0TkZvF?=
 =?iso-8859-1?Q?PgkLd3Lj/cjUcZ1me/TxvQpLVgThLu1ImUkcGDYMHb0s2suKLoxa+gcqu6?=
 =?iso-8859-1?Q?oYyA0N43Vlh72bPOy8MLNKhUf143KXWMumR9LIzSm3Mv3JBq2AzEloilsK?=
 =?iso-8859-1?Q?+VZitBHGc+X8VCmqQDbyjKjpkgJxjhHGDnQ0OiJ+KdSSWEff4PgW9HeHj6?=
 =?iso-8859-1?Q?TbzUu4nJcNQbaNSCXNj0cnKosd4ZZl3k6v3imy/m3kOm4UlFW8wbs9FCiW?=
 =?iso-8859-1?Q?MuyhZUYz6gOGFLQhDeyI4i7NByjLbaOe5rFlOITDfaOW5uPjkwru6YWolZ?=
 =?iso-8859-1?Q?aaZ1YchZF0mlFRkH3d6Ii2YhPCcalcfWTjK4ugDJVOAAyOxEST9pwnhMkm?=
 =?iso-8859-1?Q?IMxKn17S6ayfsxx0Ks/GVut81lQxJQ5ssc5deqwj1vHkZC7ut8CrdiG2XE?=
 =?iso-8859-1?Q?NMcI6Kwjva6URX3lGEg84RapfYVJwsuVqVBzfekuwtIYThmZt8Q4CTiMLn?=
 =?iso-8859-1?Q?Y7y6cUdtGazqNTZItjtr9YY64G0EyL2Oa/13sjf0PLOJs3r+SG8IdYiDBw?=
 =?iso-8859-1?Q?78UkYnaUtX7MIMFh/ARmdNuFcBcLLJR1kWLTa2Nt6gz9l3R8/UiEeJ9toL?=
 =?iso-8859-1?Q?KWVN4x09qkBjtQaro/Zesl/IeZHCSIGZ1fj2XU7qNg/whvGg0Ay17/xXKn?=
 =?iso-8859-1?Q?AkYMr1wUR3e6BM85q9UYvfSJUnQi8PtrYCsgbZHI3Sg18IK1FqjB2e4SAp?=
 =?iso-8859-1?Q?xgxnTwAHU6RFGsH/pCHLwTcxdHUz5RNuOFzMGM0PDbQUAYdqNqEc3b+dej?=
 =?iso-8859-1?Q?RV+ed6q8RCajGzTEFZfDpqeR4TgGNEQ2V+OJqk5ABexNaBeKz5mTc+QONr?=
 =?iso-8859-1?Q?XnOV1r6H0WmkZiekHlq/HdRzQqO65tuN5FlsEUIjDmiz4TI/Hvtbot9l7Y?=
 =?iso-8859-1?Q?wkHbnYI9gA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5395959f-0668-459f-3dcd-08d9619647c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:12.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUWHb8Ab5SXrWLxlClSY6Lj1siMX1T2y12BC4aZdW1q29XKHv84N1QYLsk6Hh7WY7UKH8KrkTXAF1sWdtK708g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: rT88JhZCPfaRNk3tErch-lwUu4CyvVPI
X-Proofpoint-GUID: rT88JhZCPfaRNk3tErch-lwUu4CyvVPI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove the RB tree and start using the maple tree for vm_area_struct
tracking.

Drop validate_mm() calls in expand_upwards() and expand_downwards() as
the lock is not held.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/x86/kernel/tboot.c    |   1 -
 drivers/firmware/efi/efi.c |   1 -
 fs/proc/task_nommu.c       |  55 ++--
 include/linux/mm.h         |   9 +-
 include/linux/mm_types.h   |  24 +-
 kernel/fork.c              |   8 -
 mm/init-mm.c               |   2 -
 mm/mmap.c                  | 527 ++++++++-----------------------------
 mm/nommu.c                 |  95 +++----
 mm/util.c                  |   8 +
 10 files changed, 185 insertions(+), 545 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 6f978f722dff..121f28bb2209 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -97,7 +97,6 @@ void __init tboot_probe(void)
=20
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm =3D {
-	.mm_rb          =3D RB_ROOT,
 	.mm_mt          =3D MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.pgd            =3D swapper_pg_dir,
 	.mm_users       =3D ATOMIC_INIT(2),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1aaecca36e23..2ac01505592a 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -54,7 +54,6 @@ static unsigned long __initdata mem_reserve =3D EFI_INVAL=
ID_TABLE_ADDR;
 static unsigned long __initdata rt_prop =3D EFI_INVALID_TABLE_ADDR;
=20
 struct mm_struct efi_mm =3D {
-	.mm_rb			=3D RB_ROOT,
 	.mm_mt			=3D MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.mm_users		=3D ATOMIC_INIT(2),
 	.mm_count		=3D ATOMIC_INIT(1),
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..8691a1216d1c 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -22,15 +22,13 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long bytes =3D 0, sbytes =3D 0, slack =3D 0, size;
-       =20
-	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
+	mmap_read_lock(mm);
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		bytes +=3D kobjsize(vma);
-
 		region =3D vma->vm_region;
 		if (region) {
 			size =3D kobjsize(region);
@@ -53,7 +51,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 		sbytes +=3D kobjsize(mm);
 	else
 		bytes +=3D kobjsize(mm);
-=09
+
 	if (current->fs && current->fs->users > 1)
 		sbytes +=3D kobjsize(current->fs);
 	else
@@ -77,20 +75,21 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 		"Shared:\t%8lu bytes\n",
 		bytes, slack, sbytes);
=20
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 }
=20
 unsigned long task_vsize(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
-	struct rb_node *p;
 	unsigned long vsize =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX)
 		vsize +=3D vma->vm_end - vma->vm_start;
-	}
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 	return vsize;
 }
@@ -101,12 +100,12 @@ unsigned long task_statm(struct mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long size =3D kobjsize(mm);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		size +=3D kobjsize(vma);
 		region =3D vma->vm_region;
 		if (region) {
@@ -119,6 +118,7 @@ unsigned long task_statm(struct mm_struct *mm,
 		>> PAGE_SHIFT;
 	*data =3D (PAGE_ALIGN(mm->start_stack) - (mm->start_data & PAGE_MASK))
 		>> PAGE_SHIFT;
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 	size >>=3D PAGE_SHIFT;
 	size +=3D *text + *data;
@@ -190,17 +190,20 @@ static int nommu_vma_show(struct seq_file *m, struct =
vm_area_struct *vma)
  */
 static int show_map(struct seq_file *m, void *_p)
 {
-	struct rb_node *p =3D _p;
-
-	return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
+	return nommu_vma_show(m, _p);
 }
=20
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mm_struct *mm;
-	struct rb_node *p;
-	loff_t n =3D *pos;
+	struct vm_area_struct *vma;
+	unsigned long addr =3D *pos;
+	MA_STATE(mas, &priv->mm->mm_mt, addr, addr);
+
+	/* See m_next(). Zero at the start or after lseek. */
+	if (addr =3D=3D -1UL)
+		return NULL;
=20
 	/* pin the task and mm whilst we play with them */
 	priv->task =3D get_proc_task(priv->inode);
@@ -216,14 +219,12 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EINTR);
 	}
=20
-	/* start from the Nth VMA */
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p))
-		if (n-- =3D=3D 0)
-			return p;
+	/* start the next element from addr */
+	vma =3D mas_find(&mas, ULONG_MAX);
=20
 	mmap_read_unlock(mm);
 	mmput(mm);
-	return NULL;
+	return vma;
 }
=20
 static void m_stop(struct seq_file *m, void *_vml)
@@ -242,10 +243,10 @@ static void m_stop(struct seq_file *m, void *_vml)
=20
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
 {
-	struct rb_node *p =3D _p;
+	struct vm_area_struct *vma =3D _p;
=20
-	(*pos)++;
-	return p ? rb_next(p) : NULL;
+	*pos =3D vma->vm_end;
+	return vma->vm_next;
 }
=20
 static const struct seq_operations proc_pid_maps_ops =3D {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ce8fc0fd6d6e..701cd8fa7750 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2651,8 +2651,6 @@ extern int __split_vma(struct mm_struct *, struct vm_=
area_struct *,
 extern int split_vma(struct mm_struct *, struct vm_area_struct *,
 	unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
-extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
-	struct rb_node **, struct rb_node *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
@@ -2807,12 +2805,7 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
 static inline
 struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-	if (vma && addr < vma->vm_start)
-		vma =3D NULL;
-
-	return vma;
+       return mtree_load(&mm->mm_mt, addr);
 }
=20
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b13fa84d5134..514aca4fe9d4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -405,19 +405,6 @@ struct vm_area_struct {
=20
 	/* linked list of VM areas per task, sorted by address */
 	struct vm_area_struct *vm_next, *vm_prev;
-
-	struct rb_node vm_rb;
-
-	/*
-	 * Largest free memory gap in bytes to the left of this VMA.
-	 * Either between this VMA and vma->vm_prev, or between one of the
-	 * VMAs below us in the VMA rbtree and its ->vm_prev. This helps
-	 * get_unmapped_area find a free area of the right size.
-	 */
-	unsigned long rb_subtree_gap;
-
-	/* Second cache line starts here. */
-
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
=20
 	/*
@@ -427,6 +414,11 @@ struct vm_area_struct {
 	pgprot_t vm_page_prot;
 	unsigned long vm_flags;		/* Flags, see mm.h. */
=20
+	/* Information about our backing store: */
+	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
+					 * units
+					 */
+	struct file *vm_file;		/* File we map to (can be NULL). */
 	/*
 	 * For areas with an address space and backing store,
 	 * linkage into the address_space->i_mmap interval tree.
@@ -449,12 +441,9 @@ struct vm_area_struct {
 	/* Function pointers to deal with this struct. */
 	const struct vm_operations_struct *vm_ops;
=20
-	/* Information about our backing store: */
-	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
-					   units */
-	struct file * vm_file;		/* File we map to (can be NULL). */
 	void * vm_private_data;		/* was vm_pte (shared mem) */
=20
+
 #ifdef CONFIG_SWAP
 	atomic_long_t swap_readahead_info;
 #endif
@@ -483,7 +472,6 @@ struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
-		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
diff --git a/kernel/fork.c b/kernel/fork.c
index 9ef5661abbd1..4311715e9266 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -475,7 +475,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 					struct mm_struct *oldmm)
 {
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
-	struct rb_node **rb_link, *rb_parent;
 	int retval;
 	unsigned long charge =3D 0;
 	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
@@ -502,8 +501,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	mm->exec_vm =3D oldmm->exec_vm;
 	mm->stack_vm =3D oldmm->stack_vm;
=20
-	rb_link =3D &mm->mm_rb.rb_node;
-	rb_parent =3D NULL;
 	pprev =3D &mm->mmap;
 	retval =3D ksm_fork(mm, oldmm);
 	if (retval)
@@ -600,10 +597,6 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		tmp->vm_prev =3D prev;
 		prev =3D tmp;
=20
-		__vma_link_rb(mm, tmp, rb_link, rb_parent);
-		rb_link =3D &tmp->vm_rb.rb_right;
-		rb_parent =3D &tmp->vm_rb;
-
 		/* Link the vma into the MT */
 		mas_lock(&mas);
 		mas.index =3D tmp->vm_start;
@@ -1100,7 +1093,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
 	mm->mmap =3D NULL;
-	mm->mm_rb =3D RB_ROOT;
 	mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
 	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index e4a058f7e8b6..e5b2c618cbb6 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
-#include <linux/rbtree.h>
 #include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
@@ -28,7 +27,6 @@
  * and size this cpu_bitmask to NR_CPUS.
  */
 struct mm_struct init_mm =3D {
-	.mm_rb		=3D RB_ROOT,
 	.mm_mt		=3D MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.pgd		=3D swapper_pg_dir,
 	.mm_users	=3D ATOMIC_INIT(2),
diff --git a/mm/mmap.c b/mm/mmap.c
index cec8ba0b598f..04b9dec91bd2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -38,7 +38,6 @@
 #include <linux/audit.h>
 #include <linux/khugepaged.h>
 #include <linux/uprobes.h>
-#include <linux/rbtree_augmented.h>
 #include <linux/notifier.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
@@ -290,93 +289,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return origbrk;
 }
=20
-static inline unsigned long vma_compute_gap(struct vm_area_struct *vma)
-{
-	unsigned long gap, prev_end;
-
-	/*
-	 * Note: in the rare case of a VM_GROWSDOWN above a VM_GROWSUP, we
-	 * allow two stack_guard_gaps between them here, and when choosing
-	 * an unmapped area; whereas when expanding we only require one.
-	 * That's a little inconsistent, but keeps the code here simpler.
-	 */
-	gap =3D vm_start_gap(vma);
-	if (vma->vm_prev) {
-		prev_end =3D vm_end_gap(vma->vm_prev);
-		if (gap > prev_end)
-			gap -=3D prev_end;
-		else
-			gap =3D 0;
-	}
-	return gap;
-}
-
-#ifdef CONFIG_DEBUG_VM_RB
-static unsigned long vma_compute_subtree_gap(struct vm_area_struct *vma)
-{
-	unsigned long max =3D vma_compute_gap(vma), subtree_gap;
-	if (vma->vm_rb.rb_left) {
-		subtree_gap =3D rb_entry(vma->vm_rb.rb_left,
-				struct vm_area_struct, vm_rb)->rb_subtree_gap;
-		if (subtree_gap > max)
-			max =3D subtree_gap;
-	}
-	if (vma->vm_rb.rb_right) {
-		subtree_gap =3D rb_entry(vma->vm_rb.rb_right,
-				struct vm_area_struct, vm_rb)->rb_subtree_gap;
-		if (subtree_gap > max)
-			max =3D subtree_gap;
-	}
-	return max;
-}
-
-static int browse_rb(struct mm_struct *mm)
-{
-	struct rb_root *root =3D &mm->mm_rb;
-	int i =3D 0, j, bug =3D 0;
-	struct rb_node *nd, *pn =3D NULL;
-	unsigned long prev =3D 0, pend =3D 0;
-
-	for (nd =3D rb_first(root); nd; nd =3D rb_next(nd)) {
-		struct vm_area_struct *vma;
-		vma =3D rb_entry(nd, struct vm_area_struct, vm_rb);
-		if (vma->vm_start < prev) {
-			pr_emerg("vm_start %lx < prev %lx\n",
-				  vma->vm_start, prev);
-			bug =3D 1;
-		}
-		if (vma->vm_start < pend) {
-			pr_emerg("vm_start %lx < pend %lx\n",
-				  vma->vm_start, pend);
-			bug =3D 1;
-		}
-		if (vma->vm_start > vma->vm_end) {
-			pr_emerg("vm_start %lx > vm_end %lx\n",
-				  vma->vm_start, vma->vm_end);
-			bug =3D 1;
-		}
-		spin_lock(&mm->page_table_lock);
-		if (vma->rb_subtree_gap !=3D vma_compute_subtree_gap(vma)) {
-			pr_emerg("free gap %lx, correct %lx\n",
-			       vma->rb_subtree_gap,
-			       vma_compute_subtree_gap(vma));
-			bug =3D 1;
-		}
-		spin_unlock(&mm->page_table_lock);
-		i++;
-		pn =3D nd;
-		prev =3D vma->vm_start;
-		pend =3D vma->vm_end;
-	}
-	j =3D 0;
-	for (nd =3D pn; nd; nd =3D rb_prev(nd))
-		j++;
-	if (i !=3D j) {
-		pr_emerg("backwards %d, forwards %d\n", j, i);
-		bug =3D 1;
-	}
-	return bug ? -1 : i;
-}
 #if defined(CONFIG_DEBUG_MAPLE_TREE)
 extern void mt_validate(struct maple_tree *mt);
 extern void mt_dump(const struct maple_tree *mt);
@@ -405,17 +317,25 @@ static void validate_mm_mt(struct mm_struct *mm)
 			dump_stack();
 #ifdef CONFIG_DEBUG_VM
 			dump_vma(vma_mt);
-			pr_emerg("and next in rb\n");
+			pr_emerg("and vm_next\n");
 			dump_vma(vma->vm_next);
-#endif
+#endif // CONFIG_DEBUG_VM
 			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
 				 mas.index, mas.last);
 			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
-			pr_emerg("rb vma: %px %lu - %lu\n", vma,
+			if (vma->vm_prev) {
+				pr_emerg("ll prev: %px %lu - %lu\n",
+					 vma->vm_prev, vma->vm_prev->vm_start,
+					 vma->vm_prev->vm_end);
+			}
+			pr_emerg("ll vma: %px %lu - %lu\n", vma,
 				 vma->vm_start, vma->vm_end);
-			pr_emerg("rb->next =3D %px %lu - %lu\n", vma->vm_next,
-					vma->vm_next->vm_start, vma->vm_next->vm_end);
+			if (vma->vm_next) {
+				pr_emerg("ll next: %px %lu - %lu\n",
+					 vma->vm_next, vma->vm_next->vm_start,
+					 vma->vm_next->vm_end);
+			}
=20
 			mt_dump(mas.tree);
 			if (vma_mt->vm_end !=3D mas.last + 1) {
@@ -441,21 +361,6 @@ static void validate_mm_mt(struct mm_struct *mm)
 	rcu_read_unlock();
 	mt_validate(&mm->mm_mt);
 }
-#else
-#define validate_mm_mt(root) do { } while (0)
-#endif
-static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ig=
nore)
-{
-	struct rb_node *nd;
-
-	for (nd =3D rb_first(root); nd; nd =3D rb_next(nd)) {
-		struct vm_area_struct *vma;
-		vma =3D rb_entry(nd, struct vm_area_struct, vm_rb);
-		VM_BUG_ON_VMA(vma !=3D ignore &&
-			vma->rb_subtree_gap !=3D vma_compute_subtree_gap(vma),
-			vma);
-	}
-}
=20
 static void validate_mm(struct mm_struct *mm)
 {
@@ -464,6 +369,8 @@ static void validate_mm(struct mm_struct *mm)
 	unsigned long highest_address =3D 0;
 	struct vm_area_struct *vma =3D mm->mmap;
=20
+	validate_mm_mt(mm);
+
 	while (vma) {
 		struct anon_vma *anon_vma =3D vma->anon_vma;
 		struct anon_vma_chain *avc;
@@ -488,80 +395,13 @@ static void validate_mm(struct mm_struct *mm)
 			  mm->highest_vm_end, highest_address);
 		bug =3D 1;
 	}
-	i =3D browse_rb(mm);
-	if (i !=3D mm->map_count) {
-		if (i !=3D -1)
-			pr_emerg("map_count %d rb %d\n", mm->map_count, i);
-		bug =3D 1;
-	}
 	VM_BUG_ON_MM(bug, mm);
 }
-#else
-#define validate_mm_rb(root, ignore) do { } while (0)
+
+#else // !CONFIG_DEBUG_MAPLE_TREE
 #define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
-#endif
-
-RB_DECLARE_CALLBACKS_MAX(static, vma_gap_callbacks,
-			 struct vm_area_struct, vm_rb,
-			 unsigned long, rb_subtree_gap, vma_compute_gap)
-
-/*
- * Update augmented rbtree rb_subtree_gap values after vma->vm_start or
- * vma->vm_prev->vm_end values changed, without modifying the vma's positi=
on
- * in the rbtree.
- */
-static void vma_gap_update(struct vm_area_struct *vma)
-{
-	/*
-	 * As it turns out, RB_DECLARE_CALLBACKS_MAX() already created
-	 * a callback function that does exactly what we want.
-	 */
-	vma_gap_callbacks_propagate(&vma->vm_rb, NULL);
-}
-
-static inline void vma_rb_insert(struct vm_area_struct *vma,
-				 struct rb_root *root)
-{
-	/* All rb_subtree_gap values must be consistent prior to insertion */
-	validate_mm_rb(root, NULL);
-
-	rb_insert_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
-}
-
-static void __vma_rb_erase(struct vm_area_struct *vma, struct rb_root *roo=
t)
-{
-	/*
-	 * Note rb_erase_augmented is a fairly large inline function,
-	 * so make sure we instantiate it only once with our desired
-	 * augmented rbtree callbacks.
-	 */
-	rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
-}
-
-static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma=
,
-						struct rb_root *root,
-						struct vm_area_struct *ignore)
-{
-	/*
-	 * All rb_subtree_gap values must be consistent prior to erase,
-	 * with the possible exception of
-	 *
-	 * a. the "next" vma being erased if next->vm_start was reduced in
-	 *    __vma_adjust() -> __vma_unlink()
-	 * b. the vma being erased in detach_vmas_to_be_unmapped() ->
-	 *    vma_rb_erase()
-	 */
-	validate_mm_rb(root, ignore);
-
-	__vma_rb_erase(vma, root);
-}
-
-static __always_inline void vma_rb_erase(struct vm_area_struct *vma,
-					 struct rb_root *root)
-{
-	vma_rb_erase_ignore(vma, root, vma);
-}
+#endif // CONFIG_DEBUG_MAPLE_TREE
=20
 /*
  * vma has some anon_vma assigned, and is already inserted on that
@@ -595,39 +435,26 @@ anon_vma_interval_tree_post_update_vma(struct vm_area=
_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-static int find_vma_links(struct mm_struct *mm, unsigned long addr,
-		unsigned long end, struct vm_area_struct **pprev,
-		struct rb_node ***rb_link, struct rb_node **rb_parent)
+/*
+ * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
+ * sets up a pointer to the previous VMA
+ * @mm: the mm struct
+ * @start: the start address of the range
+ * @end: the end address of the range
+ * @pprev: the pointer to the pointer of the previous VMA
+ *
+ * Returns: True if there is an overlapping VMA, false otherwise
+ */
+static inline
+bool range_has_overlap(struct mm_struct *mm, unsigned long start,
+		       unsigned long end, struct vm_area_struct **pprev)
 {
-	struct rb_node **__rb_link, *__rb_parent, *rb_prev;
-
-	mmap_assert_locked(mm);
-	__rb_link =3D &mm->mm_rb.rb_node;
-	rb_prev =3D __rb_parent =3D NULL;
+	struct vm_area_struct *existing;
=20
-	while (*__rb_link) {
-		struct vm_area_struct *vma_tmp;
-
-		__rb_parent =3D *__rb_link;
-		vma_tmp =3D rb_entry(__rb_parent, struct vm_area_struct, vm_rb);
-
-		if (vma_tmp->vm_end > addr) {
-			/* Fail if an existing vma overlaps the area */
-			if (vma_tmp->vm_start < end)
-				return -ENOMEM;
-			__rb_link =3D &__rb_parent->rb_left;
-		} else {
-			rb_prev =3D __rb_parent;
-			__rb_link =3D &__rb_parent->rb_right;
-		}
-	}
-
-	*pprev =3D NULL;
-	if (rb_prev)
-		*pprev =3D rb_entry(rb_prev, struct vm_area_struct, vm_rb);
-	*rb_link =3D __rb_link;
-	*rb_parent =3D __rb_parent;
-	return 0;
+	MA_STATE(mas, &mm->mm_mt, start, start);
+	existing =3D mas_find(&mas, end - 1);
+	*pprev =3D mas_prev(&mas, 0);
+	return existing ? true : false;
 }
=20
 /*
@@ -654,8 +481,6 @@ static inline struct vm_area_struct *vma_next(struct mm=
_struct *mm,
  * @start: The start of the range.
  * @len: The length of the range.
  * @pprev: pointer to the pointer that will be set to previous vm_area_str=
uct
- * @rb_link: the rb_node
- * @rb_parent: the parent rb_node
  *
  * Find all the vm_area_struct that overlap from @start to
  * @end and munmap them.  Set @pprev to the previous vm_area_struct.
@@ -664,76 +489,41 @@ static inline struct vm_area_struct *vma_next(struct =
mm_struct *mm,
  */
 static inline int
 munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long =
len,
-		 struct vm_area_struct **pprev, struct rb_node ***link,
-		 struct rb_node **parent, struct list_head *uf)
+		 struct vm_area_struct **pprev, struct list_head *uf)
 {
-
-	while (find_vma_links(mm, start, start + len, pprev, link, parent))
+	// Needs optimization.
+	while (range_has_overlap(mm, start, start + len, pprev))
 		if (do_munmap(mm, start, len, uf))
 			return -ENOMEM;
-
 	return 0;
 }
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
 	unsigned long nr_pages =3D 0;
-	unsigned long nr_mt_pages =3D 0;
 	struct vm_area_struct *vma;
+	unsigned long vm_start, vm_end;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	/* Find first overlapping mapping */
-	vma =3D find_vma_intersection(mm, addr, end);
+	vma =3D mas_find(&mas, end - 1);
 	if (!vma)
 		return 0;
=20
-	nr_pages =3D (min(end, vma->vm_end) -
-		max(addr, vma->vm_start)) >> PAGE_SHIFT;
+	vm_start =3D vma->vm_start;
+	vm_end =3D vma->vm_end;
+	nr_pages =3D (min(end, vm_end) - max(addr, vm_start)) >> PAGE_SHIFT;
=20
 	/* Iterate over the rest of the overlaps */
-	for (vma =3D vma->vm_next; vma; vma =3D vma->vm_next) {
-		unsigned long overlap_len;
-
-		if (vma->vm_start > end)
-			break;
-
-		overlap_len =3D min(end, vma->vm_end) - vma->vm_start;
-		nr_pages +=3D overlap_len >> PAGE_SHIFT;
+	mas_for_each(&mas, vma, end) {
+		vm_start =3D vma->vm_start;
+		vm_end =3D vma->vm_end;
+		nr_pages +=3D (min(end, vm_end) - vm_start) >> PAGE_SHIFT;
 	}
=20
-	mt_for_each(&mm->mm_mt, vma, addr, end) {
-		nr_mt_pages +=3D
-			(min(end, vma->vm_end) - vma->vm_start) >> PAGE_SHIFT;
-	}
-
-	VM_BUG_ON_MM(nr_pages !=3D nr_mt_pages, mm);
-
 	return nr_pages;
 }
=20
-void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct rb_node **rb_link, struct rb_node *rb_parent)
-{
-	/* Update tracking information for the gap following the new vma. */
-	if (vma->vm_next)
-		vma_gap_update(vma->vm_next);
-	else
-		mm->highest_vm_end =3D vm_end_gap(vma);
-
-	/*
-	 * vma->vm_prev wasn't known when we followed the rbtree to find the
-	 * correct insertion point for that vma. As a result, we could not
-	 * update the vma vm_rb parents rb_subtree_gap values on the way down.
-	 * So, we first insert the vma with a zero rb_subtree_gap value
-	 * (to be consistent with what we did on the way down), and then
-	 * immediately update the gap to the correct value. Finally we
-	 * rebalance the rbtree after all augmented values have been set.
-	 */
-	rb_link_node(&vma->vm_rb, rb_parent, rb_link);
-	vma->rb_subtree_gap =3D 0;
-	vma_gap_update(vma);
-	vma_rb_insert(vma, &mm->mm_rb);
-}
-
 static void __vma_link_file(struct vm_area_struct *vma)
 {
 	struct file *file;
@@ -786,19 +576,8 @@ void vma_mt_store(struct mm_struct *mm, struct vm_area=
_struct *vma)
 		GFP_KERNEL);
 }
=20
-static void
-__vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-	struct vm_area_struct *prev, struct rb_node **rb_link,
-	struct rb_node *rb_parent)
-{
-	vma_mt_store(mm, vma);
-	__vma_link_list(mm, vma, prev);
-	__vma_link_rb(mm, vma, rb_link, rb_parent);
-}
-
 static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev, struct rb_node **rb_link,
-			struct rb_node *rb_parent)
+			struct vm_area_struct *prev)
 {
 	struct address_space *mapping =3D NULL;
=20
@@ -807,7 +586,8 @@ static void vma_link(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
 		i_mmap_lock_write(mapping);
 	}
=20
-	__vma_link(mm, vma, prev, rb_link, rb_parent);
+	vma_mt_store(mm, vma);
+	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
=20
 	if (mapping)
@@ -819,30 +599,18 @@ static void vma_link(struct mm_struct *mm, struct vm_=
area_struct *vma,
=20
 /*
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
- * mm's list and rbtree.  It has already been inserted into the interval t=
ree.
+ * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
 static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
 {
 	struct vm_area_struct *prev;
-	struct rb_node **rb_link, *rb_parent;
=20
-	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
-			   &prev, &rb_link, &rb_parent))
-		BUG();
-	__vma_link(mm, vma, prev, rb_link, rb_parent);
+	BUG_ON(range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev));
+	vma_mt_store(mm, vma);
+	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 }
=20
-static __always_inline void __vma_unlink(struct mm_struct *mm,
-						struct vm_area_struct *vma,
-						struct vm_area_struct *ignore)
-{
-	vma_rb_erase_ignore(vma, &mm->mm_rb, ignore);
-	__vma_unlink_list(mm, vma);
-	/* Kill the cache */
-	vmacache_invalidate(mm);
-}
-
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -860,13 +628,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	struct rb_root_cached *root =3D NULL;
 	struct anon_vma *anon_vma =3D NULL;
 	struct file *file =3D vma->vm_file;
-	bool start_changed =3D false, end_changed =3D false;
+	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
=20
-	validate_mm(mm);
-	validate_mm_mt(mm);
-
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
@@ -992,21 +757,23 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		unsigned long old_start =3D vma->vm_start;
+		if (vma->vm_start < start)
+			vma_mt_szero(mm, vma->vm_start, start);
+		else
+			vma_changed =3D true;
 		vma->vm_start =3D start;
-		if (old_start < start)
-			vma_mt_szero(mm, old_start, start);
-		start_changed =3D true;
 	}
 	if (end !=3D vma->vm_end) {
-		unsigned long old_end =3D vma->vm_end;
+		if (vma->vm_end > end)
+			vma_mt_szero(mm, end, vma->vm_end);
+		else
+			vma_changed =3D true;
 		vma->vm_end =3D end;
-		if (old_end > end)
-			vma_mt_szero(mm, end, old_end);
-		end_changed =3D true;
+		if (!next)
+			mm->highest_vm_end =3D vm_end_gap(vma);
 	}
=20
-	if (end_changed || start_changed)
+	if (vma_changed)
 		vma_mt_store(mm, vma);
=20
 	vma->vm_pgoff =3D pgoff;
@@ -1024,25 +791,9 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (remove_next) {
-		/*
-		 * vma_merge has merged next into vma, and needs
-		 * us to remove next before dropping the locks.
-		 * Since we have expanded over this vma, the maple tree will
-		 * have overwritten by storing the value
-		 */
-		if (remove_next !=3D 3)
-			__vma_unlink(mm, next, next);
-		else
-			/*
-			 * vma is not before next if they've been
-			 * swapped.
-			 *
-			 * pre-swap() next->vm_start was reduced so
-			 * tell validate_mm_rb to ignore pre-swap()
-			 * "next" (which is stored in post-swap()
-			 * "vma").
-			 */
-			__vma_unlink(mm, next, vma);
+		__vma_unlink_list(mm, next);
+		/* Kill the cache */
+		vmacache_invalidate(mm);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
@@ -1052,15 +803,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		 * (it may either follow vma or precede it).
 		 */
 		__insert_vm_struct(mm, insert);
-	} else {
-		if (start_changed)
-			vma_gap_update(vma);
-		if (end_changed) {
-			if (!next)
-				mm->highest_vm_end =3D vm_end_gap(vma);
-			else if (!adjust_next)
-				vma_gap_update(next);
-		}
 	}
=20
 	if (anon_vma) {
@@ -1118,10 +860,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			remove_next =3D 1;
 			end =3D next->vm_end;
 			goto again;
-		}
-		else if (next)
-			vma_gap_update(next);
-		else {
+		} else if (!next) {
 			/*
 			 * If remove_next =3D=3D 2 we obviously can't
 			 * reach this path.
@@ -1148,8 +887,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		uprobe_mmap(insert);
=20
 	validate_mm(mm);
-	validate_mm_mt(mm);
-
 	return 0;
 }
=20
@@ -1296,7 +1033,6 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	struct vm_area_struct *area, *next;
 	int err;
=20
-	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1372,7 +1108,6 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		khugepaged_enter_vma_merge(area, vm_flags);
 		return area;
 	}
-	validate_mm_mt(mm);
=20
 	return NULL;
 }
@@ -1542,6 +1277,7 @@ unsigned long do_mmap(struct file *file, unsigned lon=
g addr,
 	vm_flags_t vm_flags;
 	int pkey =3D 0;
=20
+	validate_mm(mm);
 	*populate =3D 0;
=20
 	if (!len)
@@ -1860,10 +1596,8 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma, *prev, *merge;
 	int error;
-	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged =3D 0;
=20
-	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1879,8 +1613,8 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			return -ENOMEM;
 	}
=20
-	/* Clear old maps, set up prev, rb_link, rb_parent, and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, &rb_link, &rb_parent, uf))
+	/* Clear old maps, set up prev and uf */
+	if (munmap_vma_range(mm, addr, len, &prev, uf))
 		return -ENOMEM;
 	/*
 	 * Private writable mapping: check memory availability
@@ -1989,7 +1723,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	vma_link(mm, vma, prev);
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
 unmap_writable:
@@ -2025,7 +1759,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
-	validate_mm_mt(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -2045,7 +1778,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm_mt(mm);
 	return error;
 }
=20
@@ -2336,9 +2068,6 @@ find_vma_prev(struct mm_struct *mm, unsigned long add=
r,
=20
 	rcu_read_lock();
 	vma =3D mas_find(&mas, ULONG_MAX);
-	if (!vma)
-		mas_reset(&mas);
-
 	*pprev =3D mas_prev(&mas, 0);
 	rcu_read_unlock();
 	return vma;
@@ -2402,7 +2131,6 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	unsigned long gap_addr;
 	int error =3D 0;
=20
-	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
=20
@@ -2449,15 +2177,13 @@ int expand_upwards(struct vm_area_struct *vma, unsi=
gned long address)
 			error =3D acct_stack_growth(vma, size, grow);
 			if (!error) {
 				/*
-				 * vma_gap_update() doesn't support concurrent
-				 * updates, but we only hold a shared mmap_lock
-				 * lock here, so we need to protect against
-				 * concurrent vma expansions.
-				 * anon_vma_lock_write() doesn't help here, as
-				 * we don't guarantee that all growable vmas
-				 * in a mm share the same root anon vma.
-				 * So, we reuse mm->page_table_lock to guard
-				 * against concurrent vma expansions.
+				 * We only hold a shared mmap_lock lock here, so
+				 * we need to protect against concurrent vma
+				 * expansions.  anon_vma_lock_write() doesn't
+				 * help here, as we don't guarantee that all
+				 * growable vmas in a mm share the same root
+				 * anon vma.  So, we reuse mm->page_table_lock
+				 * to guard against concurrent vma expansions.
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
@@ -2465,10 +2191,9 @@ int expand_upwards(struct vm_area_struct *vma, unsig=
ned long address)
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end =3D address;
+				vma_mt_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
-				if (vma->vm_next)
-					vma_gap_update(vma->vm_next);
-				else
+				if (!vma->vm_next)
 					mm->highest_vm_end =3D vm_end_gap(vma);
 				spin_unlock(&mm->page_table_lock);
=20
@@ -2478,8 +2203,6 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	}
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
-	validate_mm(mm);
-	validate_mm_mt(mm);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2487,14 +2210,12 @@ int expand_upwards(struct vm_area_struct *vma, unsi=
gned long address)
 /*
  * vma is the first one with address < vma->vm_start.  Have to extend vma.
  */
-int expand_downwards(struct vm_area_struct *vma,
-				   unsigned long address)
+int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *prev;
 	int error =3D 0;
=20
-	validate_mm(mm);
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2531,15 +2252,13 @@ int expand_downwards(struct vm_area_struct *vma,
 			error =3D acct_stack_growth(vma, size, grow);
 			if (!error) {
 				/*
-				 * vma_gap_update() doesn't support concurrent
-				 * updates, but we only hold a shared mmap_lock
-				 * lock here, so we need to protect against
-				 * concurrent vma expansions.
-				 * anon_vma_lock_write() doesn't help here, as
-				 * we don't guarantee that all growable vmas
-				 * in a mm share the same root anon vma.
-				 * So, we reuse mm->page_table_lock to guard
-				 * against concurrent vma expansions.
+				 * We only hold a shared mmap_lock lock here, so
+				 * we need to protect against concurrent vma
+				 * expansions.  anon_vma_lock_write() doesn't
+				 * help here, as we don't guarantee that all
+				 * growable vmas in a mm share the same root
+				 * anon vma.  So, we reuse mm->page_table_lock
+				 * to guard against concurrent vma expansions.
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
@@ -2551,7 +2270,6 @@ int expand_downwards(struct vm_area_struct *vma,
 				/* Overwrite old entry in mtree. */
 				vma_mt_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
-				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
=20
 				perf_event_mmap(vma);
@@ -2560,7 +2278,6 @@ int expand_downwards(struct vm_area_struct *vma,
 	}
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
-	validate_mm(mm);
 	return error;
 }
=20
@@ -2693,16 +2410,14 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, st=
ruct vm_area_struct *vma,
 	vma->vm_prev =3D NULL;
 	vma_mt_szero(mm, vma->vm_start, end);
 	do {
-		vma_rb_erase(vma, &mm->mm_rb);
 		mm->map_count--;
 		tail_vma =3D vma;
 		vma =3D vma->vm_next;
 	} while (vma && vma->vm_start < end);
 	*insertion_point =3D vma;
-	if (vma) {
+	if (vma)
 		vma->vm_prev =3D prev;
-		vma_gap_update(vma);
-	} else
+	else
 		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
 	tail_vma->vm_next =3D NULL;
=20
@@ -2835,11 +2550,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	if (len =3D=3D 0)
 		return -EINVAL;
=20
-	/*
-	 * arch_unmap() might do unmaps itself.  It must be called
-	 * and finish any rbtree manipulation before this code
-	 * runs and also starts to manipulate the rbtree.
-	 */
+	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
=20
 	/* Find the first overlapping VMA where start < vma->vm_end */
@@ -2847,6 +2558,11 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	if (!vma)
 		return 0;
 	prev =3D vma->vm_prev;
+	/* we have start < vma->vm_end  */
+
+	/* if it doesn't overlap, we have nothing.. */
+	if (vma->vm_start >=3D end)
+		return 0;
=20
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2902,7 +2618,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	if (mm->locked_vm)
 		unlock_range(vma, end);
=20
-	/* Detach vmas from rbtree */
+	/* Detach vmas from the MM linked list and remove from the mm tree*/
 	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
 		downgrade =3D false;
=20
@@ -3047,11 +2763,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
  *  anonymous maps.  eventually we may be able to do some
  *  brk-specific accounting here.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len, unsigned lo=
ng flags, struct list_head *uf)
+static int do_brk_flags(unsigned long addr, unsigned long len,
+			unsigned long flags, struct list_head *uf)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma, *prev;
-	struct rb_node **rb_link, *rb_parent;
 	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
@@ -3070,8 +2786,8 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	if (error)
 		return error;
=20
-	/* Clear old maps, set up prev, rb_link, rb_parent, and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, &rb_link, &rb_parent, uf))
+	/* Clear old maps, set up prev and uf */
+	if (munmap_vma_range(mm, addr, len, &prev, uf))
 		return -ENOMEM;
=20
 	/* Check against address space limits *after* clearing old maps... */
@@ -3105,7 +2821,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	vma->vm_pgoff =3D pgoff;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	vma_link(mm, vma, prev);
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -3225,26 +2941,10 @@ void exit_mmap(struct mm_struct *mm)
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;
-	struct rb_node **rb_link, *rb_parent;
-	unsigned long start =3D vma->vm_start;
-	struct vm_area_struct *overlap =3D NULL;
=20
-	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
-			   &prev, &rb_link, &rb_parent))
+	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
 		return -ENOMEM;
=20
-	overlap =3D mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
-	if (overlap) {
-
-		pr_err("Found vma ending at %lu\n", start - 1);
-		pr_err("vma : %lu =3D> %lu-%lu\n", (unsigned long)overlap,
-				overlap->vm_start, overlap->vm_end - 1);
-#if defined(CONFIG_DEBUG_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		BUG();
-	}
-
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
 		return -ENOMEM;
@@ -3266,7 +2966,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	vma_link(mm, vma, prev);
 	return 0;
 }
=20
@@ -3282,9 +2982,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	unsigned long vma_start =3D vma->vm_start;
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *new_vma, *prev;
-	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma =3D true;
-	unsigned long index =3D addr;
=20
 	validate_mm_mt(mm);
 	/*
@@ -3296,10 +2994,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struc=
t **vmap,
 		faulted_in_anon_vma =3D false;
 	}
=20
-	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
+	if (range_has_overlap(mm, addr, addr + len, &prev))
 		return NULL;	/* should never get here */
-	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
-		BUG();
+
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx);
@@ -3340,7 +3037,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		vma_link(mm, new_vma, prev, rb_link, rb_parent);
+		vma_link(mm, new_vma, prev);
 		*need_rmap_locks =3D false;
 	}
 	validate_mm_mt(mm);
diff --git a/mm/nommu.c b/mm/nommu.c
index 3a93d4054810..eac5ca450bef 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -552,9 +552,9 @@ static void put_nommu_region(struct vm_region *region)
  */
 static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma=
)
 {
-	struct vm_area_struct *pvma, *prev;
 	struct address_space *mapping;
-	struct rb_node **p, *parent, *rb_prev;
+	struct vm_area_struct *prev;
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
=20
 	BUG_ON(!vma->vm_region);
=20
@@ -572,42 +572,12 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
 		i_mmap_unlock_write(mapping);
 	}
=20
+	rcu_read_lock();
+	prev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
+	mas_reset(&mas);
 	/* add the VMA to the tree */
-	parent =3D rb_prev =3D NULL;
-	p =3D &mm->mm_rb.rb_node;
-	while (*p) {
-		parent =3D *p;
-		pvma =3D rb_entry(parent, struct vm_area_struct, vm_rb);
-
-		/* sort by: start addr, end addr, VMA struct addr in that order
-		 * (the latter is necessary as we may get identical VMAs) */
-		if (vma->vm_start < pvma->vm_start)
-			p =3D &(*p)->rb_left;
-		else if (vma->vm_start > pvma->vm_start) {
-			rb_prev =3D parent;
-			p =3D &(*p)->rb_right;
-		} else if (vma->vm_end < pvma->vm_end)
-			p =3D &(*p)->rb_left;
-		else if (vma->vm_end > pvma->vm_end) {
-			rb_prev =3D parent;
-			p =3D &(*p)->rb_right;
-		} else if (vma < pvma)
-			p =3D &(*p)->rb_left;
-		else if (vma > pvma) {
-			rb_prev =3D parent;
-			p =3D &(*p)->rb_right;
-		} else
-			BUG();
-	}
-
-	rb_link_node(&vma->vm_rb, parent, p);
-	rb_insert_color(&vma->vm_rb, &mm->mm_rb);
-
-	/* add VMA to the VMA list also */
-	prev =3D NULL;
-	if (rb_prev)
-		prev =3D rb_entry(rb_prev, struct vm_area_struct, vm_rb);
-
+	vma_mas_store(vma, &mas);
 	__vma_link_list(mm, vma, prev);
 }
=20
@@ -620,6 +590,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
 	struct address_space *mapping;
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct task_struct *curr =3D current;
+	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
=20
 	mm->map_count--;
 	for (i =3D 0; i < VMACACHE_SIZE; i++) {
@@ -629,7 +600,6 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
 			break;
 		}
 	}
-
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
 		mapping =3D vma->vm_file->f_mapping;
@@ -642,8 +612,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
 	}
=20
 	/* remove from the MM's tree and list */
-	rb_erase(&vma->vm_rb, &mm->mm_rb);
-
+	vma_mas_remove(vma, &mas);
 	__vma_unlink_list(mm, vma);
 }
=20
@@ -667,24 +636,21 @@ static void delete_vma(struct mm_struct *mm, struct v=
m_area_struct *vma)
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	/* check the cache first */
 	vma =3D vmacache_find(mm, addr);
 	if (likely(vma))
 		return vma;
=20
-	/* trawl the list (there may be multiple mappings in which addr
-	 * resides) */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
-		if (vma->vm_start > addr)
-			return NULL;
-		if (vma->vm_end > addr) {
-			vmacache_update(addr, vma);
-			return vma;
-		}
-	}
+	rcu_read_lock();
+	vma =3D mas_walk(&mas);
+	rcu_read_unlock();
=20
-	return NULL;
+	if (vma)
+		vmacache_update(addr, vma);
+
+	return vma;
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -716,26 +682,25 @@ static struct vm_area_struct *find_vma_exact(struct m=
m_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long end =3D addr + len;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	/* check the cache first */
 	vma =3D vmacache_find_exact(mm, addr, end);
 	if (vma)
 		return vma;
=20
-	/* trawl the list (there may be multiple mappings in which addr
-	 * resides) */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
-		if (vma->vm_start < addr)
-			continue;
-		if (vma->vm_start > addr)
-			return NULL;
-		if (vma->vm_end =3D=3D end) {
-			vmacache_update(addr, vma);
-			return vma;
-		}
-	}
-
-	return NULL;
+	rcu_read_lock();
+	vma =3D mas_walk(&mas);
+	rcu_read_unlock();
+	if (!vma)
+		return NULL;
+	if (vma->vm_start !=3D addr)
+		return NULL;
+	if (vma->vm_end !=3D end)
+		return NULL;
+
+	vmacache_update(addr, vma);
+	return vma;
 }
=20
 /*
diff --git a/mm/util.c b/mm/util.c
index 2b0ad4e810d5..af8508e07a8e 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -287,6 +287,8 @@ void __vma_link_list(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
 	vma->vm_next =3D next;
 	if (next)
 		next->vm_prev =3D vma;
+	else
+		mm->highest_vm_end =3D vm_end_gap(vma);
 }
=20
 void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
@@ -301,6 +303,12 @@ void __vma_unlink_list(struct mm_struct *mm, struct vm=
_area_struct *vma)
 		mm->mmap =3D next;
 	if (next)
 		next->vm_prev =3D prev;
+	else {
+		if (prev)
+			mm->highest_vm_end =3D vm_end_gap(prev);
+		else
+			mm->highest_vm_end =3D 0;
+	}
 }
=20
 /* Check if the vma is being used as a stack by this task */
--=20
2.30.2
