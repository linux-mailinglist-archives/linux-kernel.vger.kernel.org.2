Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A182D36DC09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbhD1Pl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:41:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17014 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240601AbhD1Pi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:29 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFOtGR015173;
        Wed, 28 Apr 2021 15:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+/5mtMi7D+lhYEZjSN2flSJBf+TsbMw4dnu8ylA1V6c=;
 b=fLnZyL3FunBJ18ttPNgESn5YvX8ufI8zACRiuWu9Dg8AtYYf2/xTCAbXqI+nDbbjEEs9
 /AMAH3ZC4BbkHl9O7wSKtqcoexP3XpQd1zGPCg9YQyyHxIcaopX0PGLoddVCONp1Qg66
 1eUPeAPU0a+6T3CEEBsk0r5xY7QaR70jTJ7X5DXJouvWJ805Xb/soq7WIjaXqb6zVoYr
 PwAFU2Sukcsn+ShxMkVChkA/1zK7N5YRbiVfWeiqrfNeNmfKxFmXBFh5w7eVeOKwqV3j
 NmUm9cH5YzJrU3roOPtL8MGE+oKgt/3njH4RU+clBEh7NBuM2hG3o9+/PtrJcUdQpfsT cg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:28 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbQoU164727;
        Wed, 28 Apr 2021 15:37:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3848eyqyn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fknoAf/raL56PveJY+ds8cgq9eobU6lFG1fBQJ8J/v1HfnbBqNIfbktaWjdvSpJVE3VNkwQILnlnng40Jwr5BAVylqstUfASBVvEZCep/8PMhHXhhqb5uJchy/wdys0AQkdlNGfkU2Nx4VHartDc4jHPWzPYxnXbq05q91PgVI70bW53P4Q8P5w2SPrKuUsuHAn0qWKimoUi0nQFj3CtYtr2HfwiqPgghWtyBscavkxzIpLSekO47K0V2EBc2WY1oBuTP2XZbYn7u+jTR7HtMkbbf1zm1v9Sit6O0IYBryY3yI21Derz7lGOsaASVmgFVkqD5nRQ0RJBHIOzYQ2nng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/5mtMi7D+lhYEZjSN2flSJBf+TsbMw4dnu8ylA1V6c=;
 b=PelTSUcdH9tb/ya355nR5c9nXYmFFqLV/UO4PW3NIBZnieoNw3UwX+unkzWeakqVG71hXcrYyNFPcIYm+lPNlk2fVGuHkkJntCd7+NHqwslRPhPmR0UlIOU4vuSIuMR+J2LEC2Ajkeq5Ho3iH0mzKYgIVHdShpev2IpblBS1cO/GzeVWVr2BRlRHy90WB9HrzZbbmx872grFnsQZ6ZczyXxNJr7SRzvlMWgT1II9YQKnkEDgWPkNwlcmjBlC1yJmvomp+++1pbXgshWPf+VtnKYTtj4vhwn/4MtCy7HtUHWagkfCnfXa6Cyf4b5/x6qHpGche3HrcJLbbIKI0MoLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/5mtMi7D+lhYEZjSN2flSJBf+TsbMw4dnu8ylA1V6c=;
 b=ZwSYwwrCeDJOryo/5Id7/d5btJIVWLb1m97b1qoO1I+2oKz/YP3opV9ZjI/j/62Fi69hOufUi6d7Cx+MP4jm4PrRqd/P4BkhRU90q8C26roBCrcifd9tRXDZluvK1aKpoCFw+E2WWDlDC8GWFNsA8u28xp4rq1FxaLpBouCAm0c=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:37:22 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:21 +0000
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
Subject: [PATCH 68/94] ipc/shm: Stop using the vma linked list
Thread-Topic: [PATCH 68/94] ipc/shm: Stop using the vma linked list
Thread-Index: AQHXPEQ9aZ/+Ako2W0eO8l+KHRK1lA==
Date:   Wed, 28 Apr 2021 15:36:21 +0000
Message-ID: <20210428153542.2814175-69-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 8800843d-0540-49a7-6d79-08d90a5b83d3
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4515654182045529A10DD0C1FD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gDzqV43R738acXDJP9EjxDKYugllqPQ/5hMxL/ha90oz3arTzrvzRzp4G9eZMwNkvRe+v14SlqjI7M1uQVpEIitzJWBHt6KiUguLrAMQE0D0DTB7hej9mUNjIRwvF7u71YumjFBYcPmKBPc1mi5F3D3GL4rZoWaI7ppEH2yHkve6QFtECthlr5K8oAsLRV+3tkRWYH62eIRxVhkibbBNCSEsfe5qUIZveSz9l18hTackH2ti7G33BD8g6ZVdEHyD9IPiSv/KHdRTKopqf5oXKNLQYTh4XbAXquYoQbKEv8T7DgzJQG1CmTHe6BV+2uEXBPMfpHQbYimqlfMG+u/Sk1TScNYHvS0ctVLuaF+iGzwGsQXdtYH243s1WxuelUmvE95NCe4RTA1gwiHdolxiPJpWyuOH9AoQhXJW3Bh/vfBtjzSJuOSkT51SCR6CxLuG/HAM3rNIp9xvPVVCzNjO0h9HbohosYZit46gTqMFHLnAQjoLUaovfxyaZTkc50itYsckjXhcOWJJsMYTtE2C2JXZcH+NzUicEMEIOnOjk7P0pKoujYRt3l/kF7zomRF7G5fysAFnJGvWDbK0IDsgpd1ivcw7Nfheavk3SDutarE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?RDI1wVGmN+PRAVA1OYXDowKianCxThZeGH0Zvo9HGvZu/ckAgcA8QR1wql?=
 =?iso-8859-1?Q?wv8NHaEzXy10rLQPCMuvHF+zX3eXuaXCi0qsylTkcldWfkYdZHZR6e9u5y?=
 =?iso-8859-1?Q?GZmSc2lamr3Nd23uMsU1kgww6h4+YwsVU6Ci/+V3dL3sbBY6yULKjYtBN3?=
 =?iso-8859-1?Q?jsMYYJXWayUohNVLqT9Km8vyLsTXwqDLWSUbHNFZqKhMYzdEKTtrTF6mYy?=
 =?iso-8859-1?Q?+TP2OWti+yT69vWo/+b8FJqz3zDd5yqQ/sakUl4XSEeq/bXY6GdX+h+Jej?=
 =?iso-8859-1?Q?x81LGaNhJNIpTMqWy15WqKyNmhqYtjq9nt1Rl2NLC6XW/GtEU1OkQ0Nkwo?=
 =?iso-8859-1?Q?WGmyaWh0X3/pWx9xfXfVno5NpIXBoG76VrGhHL0hChA+a8wTG+z0pRxO+C?=
 =?iso-8859-1?Q?yLNYMjgaRpcBoXhU46Mb+uc7ZfRVHMH7YIZzgPIOV45OJLhLznAvlnut3O?=
 =?iso-8859-1?Q?2iAqliNj9MO3mU10TVy5zf4Cq2QHX/QDoaP+aJtLjxnDtdw9zyen8LqMaN?=
 =?iso-8859-1?Q?nNBE/WOZjlbDBHAZXza3LP6lDZA52cuC+S2IqlQTLLEG4O9S/VJodASzXE?=
 =?iso-8859-1?Q?7IkQxbKAp6Lsn7/eyzu5UlALjEah2lyyRGDBMHh9GCPfXjCFk5g9yhalrE?=
 =?iso-8859-1?Q?4KOZjROSmsCaypZ/7gQxIz3zGEvAm9sm2k8jOrS9bMUPUIn6n8wxYqDm4N?=
 =?iso-8859-1?Q?/a7gH8VHRVzfRHEhv9Wx6J2NCWGMwBXOgGZFD/875ReBn0OWjEMdk4TkwR?=
 =?iso-8859-1?Q?8T65PdFhVqAUcZv5VszDKh0Vi2R4rrQPBon6hZZoMzW9mvAprxq0JgKt5v?=
 =?iso-8859-1?Q?1OIOtyToNe4ilywBYTSnDjIYWW+Vc5z9cBD7lNaFBvM37HtNh9uxGCPuYz?=
 =?iso-8859-1?Q?qv9wZxRMwNsQ+pJEWkV8fTd+SPg2upzTxuMGRezjUWwTy58NBj3jjbgYTf?=
 =?iso-8859-1?Q?8eYLICoCbBkZfACHp7de+hEFr8XPRpyaP/Gs829mCMX+OP1DsRWnklsmw8?=
 =?iso-8859-1?Q?76Wt0XSw1Hnw4VdPE79UxB0ts8htBIOiAVZKqzXdkUJ2C04E7uuK3vlXlQ?=
 =?iso-8859-1?Q?uAKCmNT/kglHLbBwWMOI/aDg/q2bZJCuHS5sVMrCtWuCqD+IUozUphp/gM?=
 =?iso-8859-1?Q?xc2bQOVUiZfZAgzoiJvfeiMnUpiBT7s1rHpRpc+p/XHRQGOLu6llZpMqda?=
 =?iso-8859-1?Q?oz6aCeGR5dwEOPS9DgRE1+H/3KaBz6R7NTZoZysNDNjamI9myFlwkX2/1T?=
 =?iso-8859-1?Q?lfX2UVDhAu4U67TKe5Cv15HoH9UJrGXwBXMukeBQtIcoyJGpyCPCXmhgfr?=
 =?iso-8859-1?Q?Y8kTqeuXd4jTy2KfLRwTLSx2AIPFdzvNRy66A/DDHDOsRO6cCnyMGSs9Af?=
 =?iso-8859-1?Q?OlC9CwFHCv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8800843d-0540-49a7-6d79-08d90a5b83d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:21.6845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c0oZCEU+zVp3YXKrkFfoIyycB8h2K7FVywBw9RVmvrpTc5hxJu1vKPa9QiF1Ja6R7bAuUrbQHrJZJOvEmDytcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: VZDOaKVDeij00pmrwKdHhR7AxDSlJWlS
X-Proofpoint-GUID: VZDOaKVDeij00pmrwKdHhR7AxDSlJWlS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When searching for a VMA, a maple state can be used instead of the linked l=
ist in
the mm_struct

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 ipc/shm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index febd88daba8c..e26da39eccb5 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1631,6 +1631,7 @@ long ksys_shmdt(char __user *shmaddr)
 	loff_t size =3D 0;
 	struct file *file;
 	struct vm_area_struct *next;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
 #endif
=20
 	if (addr & ~PAGE_MASK)
@@ -1660,11 +1661,11 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma =3D find_vma(mm, addr);
=20
 #ifdef CONFIG_MMU
+	vma =3D mas_find(&mas, ULONG_MAX);
 	while (vma) {
-		next =3D vma->vm_next;
+		next =3D mas_find(&mas, ULONG_MAX);
=20
 		/*
 		 * Check if the starting address would match, i.e. it's
@@ -1703,21 +1704,21 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size =3D PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <=3D size) {
-		next =3D vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
 		    (vma->vm_file =3D=3D file))
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma =3D next;
+
+		vma =3D mas_find(&mas, addr + size - 1);
 	}
=20
 #else	/* CONFIG_MMU */
+	vma =3D mas_walk(&mas);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
-	if (vma && vma->vm_start =3D=3D addr && vma->vm_ops =3D=3D &shm_vm_ops) {
+	if (vma && vma->vm_ops =3D=3D &shm_vm_ops) {
 		do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
 		retval =3D 0;
 	}
--=20
2.30.2
