Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA403794C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhEJRAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:00:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41378 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhEJRAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtC06079446;
        Mon, 10 May 2021 16:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yWaflRzHqISIK2zve/6ZIE08BbX8IA2HEMcWf8/0+b0=;
 b=kEj1XN5NoWIROIaa0QM5qDKT7x7SB/eKOCZYDmrxXGs1ahu9ONzHTimkjuQAiB1Izy5/
 vOzgztlRTYmD8NZHPGxF77QN/sbusdqsQFWiPwAcNpEkkx+2Tk26W4nNkZsKup/blu6W
 PX/zGdFaCTZdu2IUxQvlFbqsE77VBXmb1j0G9tTIFg3mBw8bj/NTD0A6zN0xxgPUR6bi
 unOlg+FhVxECwNuZx5Lj3LsrcYE0pElaTuOSoLc8TAXDxFtQ6jTs02morLuFsIEKNTsy
 1RQzPKdK+aiJEsPyUHN5eA0fopHbBXlF6e3y4QShj5U5TjH50LH78KdMQ+fhddftNd4g sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 38djkmbxgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGucHG109288;
        Mon, 10 May 2021 16:58:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 38djf74j6a-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXknPFThCRoHdbCkl3oVYSx5Dn+FXB0tT6cRsVmD8AZdBJQ2nutd/QVYstcQGQq4rEymICv6CuPBbVeUmkU3VRvuJaCpaCpxJRyg/GG6eF/CoDRBTOcc5irI2I3zBTa3NvTlWIaJNVNMWxUeGSIkvJuoGbI8pZ1M82/Jdi3ak8cH8LA4Lm/q8rYh4PWXzl8g5Eba/wcj2Yrqdx6/FoM3CO46sURai83ZwEvCzL3VIbBMzScOcL95X9ubGUY4YsjiJlKq1TfEQHwasoE4Bn4cDoHhh2ncWNxPko+kxaBRYnUM9B3zSSh4++auTQeKJeGtJaVfkEu+FosnUYLwxkP0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWaflRzHqISIK2zve/6ZIE08BbX8IA2HEMcWf8/0+b0=;
 b=QC/wygyWJEMKfvz5Fu8sKbiBzacwB34WZpyXsBPl5Sl0+WTREgtjBbHF6zQtNwsDHoNPW5L0YIov/kbvXBu5iYUxVO/uMlHH3dVmTfPX4ZKuyVnvbNRq5csq1bamUiVy5xNNQuiLYpqkX3LD2vr9x83Vr67MAVs9cioRwoeA3Bz662qun4kE/1sd+S0c7ecJKw7LQEmsNGNXg9EmZ3yQJC3kFwHdFT6QhvCYV0pzpiJ23XARXPeZo4FPaCGxPTVMf+4sX3O3fssKqpQ1mVFCPskdFYygRUT7LRFZGTTqS7VH2ldnQgxH+l0YXmEHdSAg0R8HHTCLMForkVrKgAcYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWaflRzHqISIK2zve/6ZIE08BbX8IA2HEMcWf8/0+b0=;
 b=UrLi83XCSohvhznXEKix7zlhnDyMBjEbIlCi3OzYVme3bno4EALMOid+H+1fY9yTAm3ZIRqEbNKLx1eYEGMB//QafOGe5VDDnL4RNfGGw8ItPnR7JyXsXmeQhNFdJ28vNace+FISYGPu8NDzbTnigHGdrjxC96dKz+VQLZ4cPnE=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:52 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:52 +0000
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
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 07/22] arch/mips/kernel/traps: Use vma_lookup() instead of
 find_vma()
Thread-Topic: [PATCH 07/22] arch/mips/kernel/traps: Use vma_lookup() instead
 of find_vma()
Thread-Index: AQHXRb3BEChK21xvUkijxJY7Dadk1A==
Date:   Mon, 10 May 2021 16:58:52 +0000
Message-ID: <20210510165839.2692974-8-Liam.Howlett@Oracle.com>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: e59029f3-6244-4912-cd7e-08d913d4e395
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769E333E88DFFD967AE8EDBFD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y+REH4oojO1+/hJ/nN2EErSQtRKhV64n3KDHqF6CkSidOIt5K9YW9aSqxQKiMnUSRqFaxDQ2Vn3CR89RGA0D8dKHiTCS5JRjBQSxYMyctbfpKcWc9bMI06OYp9EBDT2lXcMkJbSLGqbz0gMe9VD4AntoOo1okUkJpN86mNTSbs5CZZLLqoaX7SOcGlV8XDKG/NfxRDNf5ZG3n5/pRl1r4VrgbvKHa778hgRBbFSVb8aNOQ4vwQc7YqKo/Yl/vxbIqGT48/HSmpCk7KZPaJ1cYyR35WXite3mndlSF7uZxEmZTNE4i8S022L7n5NazofNLWWDordHjH4mMON3p/wCs15ka2tMRaLY2AeHMjAy7MeG+fepeuhpd36NnxjguEcVFz79rNeZb+NlKA5iE9ISbYEHdmvPxvFy5HvJg35H7kw7Qsg3MrsK7r/4al0r06+SuWNC39s/eUE4T5VmYS5CAM4LuBx1QJHFoFwLhg8QE+jqFxp1eaCRQEV99nA+8uGH+DwQQAuMvRNXaN+4kQg+5ZOELuc2wh2UFhzHEyFDfRyHrpHnqNvHvB28sOzHqr5rxBS8HeQsGV0va4+RBwaC1ouMrhsrsuKMricqqAqH5kY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?//2Vd/d8a66brM1Luy/xWpag8RyAwfqalBqyJ8NQrLt+JhrSBmUJKmLVis?=
 =?iso-8859-1?Q?/Y89DHQcTBlxNzX8p66YnQJw9JW9SsOC5kdu9cANAecoYF2YkDdQS2P9Ws?=
 =?iso-8859-1?Q?xsPSp6dkEElqjv0UTqvlk+YcT98kqfYbusre7CPYNSb+UKz84Zg/rMkzPW?=
 =?iso-8859-1?Q?1vQkkfhCwWGFluIB48Xo9C1lilT+nH8PMwEg66iUrZTqM/oktURUWw71sW?=
 =?iso-8859-1?Q?Dihif2YNky0w+EODKCFQByHAXiGxBb3VErJXllMNvP2ZUOohy1JGEeqduX?=
 =?iso-8859-1?Q?v/0mrlAY83SW74PMS1KYxcfiIiK+bI6A3Y/gSYK+A6vzXln7Hj95sNzNpf?=
 =?iso-8859-1?Q?BFvYSbqtdzAxD3GbPweT1Djj17VxG8s6Rl3I+BtGNfMtWUP7rXiqEZDrsu?=
 =?iso-8859-1?Q?p+wKNwCIG2H3JKP7tCy1IjpWTb2GdqsvUpAr1DFqpkutyk38NZHg4ulyUy?=
 =?iso-8859-1?Q?lxwOlViNnrXtMg6U/+NegiYhhplWeIItV2HU56oYW/utcd7c5PkVKgR/0Z?=
 =?iso-8859-1?Q?BCjNtgeUEeWFE1wxy5LR0xfLCy3EbqKZkHZSUH1+EU17TGu9Kad5lGpUIq?=
 =?iso-8859-1?Q?9+kQjTirp/3m6vFOuMnVlebwVyPEAC0qNPXVqANA26sjauaW2qNziCPni2?=
 =?iso-8859-1?Q?oVPT3tRUrHfAOgdhZQAZYn5WwDzbWAkVVHyZ97RZu0RcF6kODAQ2oHSB1G?=
 =?iso-8859-1?Q?+h3H4SPcmNVvGdeGJBmdvxgJ9uZ0Zqfj7m5JEIKujBhxT7mTVYy5cH7CF4?=
 =?iso-8859-1?Q?LRqi+NY5ianf5MjtZuXcyT0CZ/KpiWfQ7wXchrpSZRkPBQqxtqoXX65TTz?=
 =?iso-8859-1?Q?eIwZEkClLncGuqVXFTG9v2PqJ6l7H8RA9QKP4HzgMqHDD6LPmEEMtXjssA?=
 =?iso-8859-1?Q?AYYDYbfa+ccPQ5hyCHM7IIocxK3Q8K5iO/XhzcQ0c3gl38c0ce04okJkcD?=
 =?iso-8859-1?Q?WqoDbjAoXATBl7KNO1aHdYbaHqg2XapyIXMXq9ypiC91MaQF0a9OiO3Eir?=
 =?iso-8859-1?Q?LxQ+2rN2oDY9JBVF+jkEZSod+dqLXCZSokXf74LVhKLGNet5yg5k19iftt?=
 =?iso-8859-1?Q?m81tIuHVmqoZnybbPgRBqsm20KFaK+3xIM0PSvFx0kHN0Ax50P9PVxogl8?=
 =?iso-8859-1?Q?BXSBMfD6yXwgSZJau4SvD+NdSKyjmGwWGF5hVlV4/wawkKelMZMwU1O2Sw?=
 =?iso-8859-1?Q?/NOGxexbWQawjvGK9ZWrlhfvFlo0aW0gkf2CQti7+ifgUW1niQUHaxjTFq?=
 =?iso-8859-1?Q?rowwMPK+hqjGIx8M06iLnLGHWyr63N+UEuXDUs8Ved0lsPjrKKgGPPXMjO?=
 =?iso-8859-1?Q?aPtUJKEyaIYKauwdtg3uraYkIydSNxOZMpBbK9mC9WS5KJDLm759RHSWqf?=
 =?iso-8859-1?Q?U+gklX4eBU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59029f3-6244-4912-cd7e-08d913d4e395
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:52.0406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPccSOI20HoPdqo4187cXnh451XW56X/6xxq10rJqmSmDC/xLOygVa0dHfneW35nns17Tf7VlhsxIri/9n2BPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
X-Proofpoint-GUID: c7PCJiAuMYQssyJeYicK4Lx_ywH9ba3O
X-Proofpoint-ORIG-GUID: c7PCJiAuMYQssyJeYicK4Lx_ywH9ba3O
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/mips/kernel/traps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 0b4e06303c55..6f07362de5ce 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -784,7 +784,6 @@ void force_fcr31_sig(unsigned long fcr31, void __user *=
fault_addr,
 int process_fpemu_return(int sig, void __user *fault_addr, unsigned long f=
cr31)
 {
 	int si_code;
-	struct vm_area_struct *vma;
=20
 	switch (sig) {
 	case 0:
@@ -800,8 +799,7 @@ int process_fpemu_return(int sig, void __user *fault_ad=
dr, unsigned long fcr31)
=20
 	case SIGSEGV:
 		mmap_read_lock(current->mm);
-		vma =3D find_vma(current->mm, (unsigned long)fault_addr);
-		if (vma && (vma->vm_start <=3D (unsigned long)fault_addr))
+		if (vma_lookup(current->mm, (unsigned long)fault_addr))
 			si_code =3D SEGV_ACCERR;
 		else
 			si_code =3D SEGV_MAPERR;
--=20
2.30.2
