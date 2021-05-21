Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B0338CC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbhEURtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:49:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48498 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbhEURte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHT4Ih142878;
        Fri, 21 May 2021 17:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qalgSsVHFuAKTk1n9xV6ooONkJdN9gDooPl+5R1TsJc=;
 b=rbTO6JmLvq23GP3zz/LQTXEaV29U8EDWjXJuFpLuBQC0ZBCWhIz4l6+Q5CYPZuPwbTU5
 wuGx46OWX9zqwtzI5ABNO8jpokB1oV5o9hsQ88mjHQlBTNYDhwzNxXmvLs18E5Dt/EAc
 FrM5l4mbwUNol+JgaCgoM+z+jdsEy1Us/IK3mK9WUQ5ImAcGKJiaBU9R9/gSFQ7MM7+a
 QxSul518B1CZwEQ87Wa7vJmC1LNXru07r7UYzFHMo5Asx13D5XGavkG+Eo4KtIXYwXry
 WL9zsMvdNL03vxres3wkGxrwSbVa2Rd+FGU7WBCwee7oIaJpLLrSkRV5w1MbhlrVDRhb Cg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38j68mratm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rW189475;
        Fri, 21 May 2021 17:48:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjyWeuNcd14Y7pP8RwR04ukRdxjUp2vN9RQnG1EwCHHOEfzAJlQpkG4Rt4lCkW2ohUaTo5g9/Wk5jrrJ/cuD5ULK4UNOmkHvnEHGo1kjkJgm1iUToLNopV9GhMvipLikJdbldalwzoYgZwD1Uvhg9v0bxHUt3fqfZqsPJBOFM3Ntw9x8UJcxQ074YIihejqJdYzgwyEPIZqoYee7w83Fc77ItSpiCuOLFWRNfXdoHaW4aa7qfgcpSD5doKlSXESmbgx7eKEhw5h2IAQA4HFO0QUQekrE0NuIodIPzEOTzrWUawwT6f0dGBljs4q0xRVLGK9AIbd2g6v8NyIpzpKMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qalgSsVHFuAKTk1n9xV6ooONkJdN9gDooPl+5R1TsJc=;
 b=HG9qsMC8FeMh4z5mn6RG4ZkEyXKA/xileAyaYZFnBfK0GI1Dqf9Zm1douzUUwlnWsAGsvjnnNbtUYNlkFc3evRvnZap7LaT5kGFUJF+PgDmNRxsnXl+Rs56Bpc1HV5s6E2siw6z3gooD5FEMtkWPr9jDL7Vexad97WsMp4jLEwYLuZ7QGJ/RJ5+lg1CJ2r00rl4a+/MBpPmH88la1RiwcTV474gPEtJbG2xjUcZhYtcCBfgvFFFnYvPKOZaoU7aYnZAsk2KfvWaIHmgYTph5PLQmyjXSZIkRZD/WfFav4Iy3yrF7bi3mkbnXnPnsvrDlMmhCpwIU8O9Z3KGB2LAaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qalgSsVHFuAKTk1n9xV6ooONkJdN9gDooPl+5R1TsJc=;
 b=GnFbNhxjZHQ2wtTOGfo3Fo5HLvjV0rdQIwwSh7dF2sn7AkjBAmwYohZtxdMLi3T1AITANFP6U+XxP1WrXR1S+wmG3oSG8S0loIeTIEEfio5n13ey9rE7yirTNQHvDvE7nzG/g/IGU8ActOLM6NqtdIuL+5J4iUTY6bdv/41bgB8=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:01 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 08/22] arch/m68k/kernel/sys_m68k: Use vma_lookup() in
 sys_cacheflush()
Thread-Topic: [PATCH v2 08/22] arch/m68k/kernel/sys_m68k: Use vma_lookup() in
 sys_cacheflush()
Thread-Index: AQHXTmlx2XDwjbqDc0SlT2Bi22L7tw==
Date:   Fri, 21 May 2021 17:48:01 +0000
Message-ID: <20210521174745.2219620-9-Liam.Howlett@Oracle.com>
References: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 517586ea-7a20-4415-87f2-08d91c8093db
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB446761E31A5A328CC41640FCFD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rRfWpB3jUWtye19+3sTrQBBI1wYuMTn0f1+4paPNelVfNhMLoOcp7ORRPpzsSixPBdxP6nZUbgPDJSulUq1SesmpXggjM43KaHtGFlWvsCMyehYPnn2lIfqgmZLhw8DEBNN9gx+Bh1+49ty3uufPcHsapn05gCGF5uskdjltoRhfu/4F9ov+T7Dk7F1nsG9Ls43bsum939juhjlnzTj3ButKuZEjhhhTh00BN1zEDMOSXkIYIqa912Ky+Od+kLF6O+jP01xmNexDM8dndCZ7jxu9hOPaSUc6W74vcRVHMG4IljgrKaIltEU+EH7WAJyxbIBHf9NlmODY1fG9fGqQbgPRWiOVl8t9VWlz+dvUOnUtoSYrjIHrPEbWW02enz6uGTw3si/sYkVDqop+IFDeggoklcCSy3dQDncETWPF26QCF+EOPpe0ybSumcw8BdGEjEBOtUbGXCXQHh4xuwYgmkfUGpNSPX8ltaKSmKM+JzJtmoZt05LJTr+QhEDJeK4JtXqaJRH6/7ml0IXIuoSiqf8J1kqg+fOzG0ylVrtA7AhN7a1tneVhAKT9XzzM/5GVqqUr8m1j0tACORwJ5ckKHn7VMq1XIIljH/1VuLTydRA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?tysKxYZnmSCnZpTZVFu1FvnFqIa9McIK0TwgJ3F+C9k3S7b5ISRHNAPr7z?=
 =?iso-8859-1?Q?GbMzq/yI6Ma2sGlsHgZ+FyGm5j0O9AliggbvvII+eSSO5DQ9J4Nd6sv3Wl?=
 =?iso-8859-1?Q?epNBixqvno1Qlabvw0ioccmSRLzJGV6JjhsteayxwKLV2PiDbbuBOG2WU7?=
 =?iso-8859-1?Q?AnMHAM3GJbVwxzXlprXUHsOnED6ZLWyXY5aRONXD3j+fVgLPjUSx1hcs8f?=
 =?iso-8859-1?Q?eKn28gEAhfvFDKHjs/WNrWXO+ODzhtHF9bbzgvBNmY6GnU8PVIvu0AVM9x?=
 =?iso-8859-1?Q?6un9NxdL/N5gxe8hF7xjBZI2euzcfZ3vtDCG3V2PwjnH8/XwQKFPs758KN?=
 =?iso-8859-1?Q?K2SHbjMtOLNy941AC6VTbzF8v3esB5bh23WY1AckhwYyc+T82tyg9XpScj?=
 =?iso-8859-1?Q?3VeCUyDRQ9YR8n+VlmQ0hhl/jB3eTvkveKUqjvxCk9qA5WZ6n3nQQKNsXi?=
 =?iso-8859-1?Q?2b4425h9B71KJ0ZV09No63frKYQy89+HPOYmo1GURObH3JzYsSDO4rfPXR?=
 =?iso-8859-1?Q?WfVM+tr9fw4nWrbu4L1f2OrKzvMsZOfAap4iGPEiEEu8K7XLPrMcepa+97?=
 =?iso-8859-1?Q?TDDDv6GuMWkagmNLId1eZ0wZjIkVhOnVoG5IQR2oBZACUEQ0P1XJuGzx0v?=
 =?iso-8859-1?Q?QNXrPGkuLR7oLy2gwI4ZVLCj1VlkByfK4DxCp3SN7l7VnSy5TRnHs2QqzG?=
 =?iso-8859-1?Q?as/js+ct69fzL2iPdQyp8upnQkErTmeIKW7vjStW9FrMognw0z04TYoMZ3?=
 =?iso-8859-1?Q?LGRv1GgE0R2uc3vEGnvD2bFcJ8WCGdeMIG4OxaudPQGiRApJVBRW6vgauJ?=
 =?iso-8859-1?Q?8BiRcqY/EsRkDIXnRfCUVao5o4TddexZg6/5o1nBfLtm/I6H0rvPW3UpN1?=
 =?iso-8859-1?Q?xRu7Qe/0EdNbIHRP7uHQlChkGBBxiBtjjRG9kE4kCjCZCVW1LTXGJmiRz/?=
 =?iso-8859-1?Q?iS+xB+fmm8W+Am7EaHSUyp/mAIy1Ut4Fz2taHg+CXmtLN5wXuAozb2QTZQ?=
 =?iso-8859-1?Q?H40eOx2OqJORi/yVOQ5Cwgw82IX1qaJkgSDi086TmXx1DZHWlxmskgqJUP?=
 =?iso-8859-1?Q?BkEiXCiw3aZ2+jrWlY1sbCEhCYupsvfLxU93xcTl33uvLezj03xUR8BFlR?=
 =?iso-8859-1?Q?7wijffw/VtWvP7mZpz2+Mhp+WdWhPQz4CMRbaimlLinRoMfckZZBoT+wHw?=
 =?iso-8859-1?Q?IKdMfdVV+KP9dgTwdVLSfALRMIg8rZVMhQ/ezY8ozoYvDG2gXjUZnWUAku?=
 =?iso-8859-1?Q?7wBDKKwOoe1aaHEo6dxJK82Dz9mstfZD/SJCSC0rO1D92dKyD2xWRQETBX?=
 =?iso-8859-1?Q?kRaMV3Qlt331zBvC7SpsHOaBRqdFlMgDi5iHzVzmwS3Uu8lZfYnDVYBdKY?=
 =?iso-8859-1?Q?XRt7Snhl1t?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517586ea-7a20-4415-87f2-08d91c8093db
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:01.0315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHR4m9vOZ59hyHADSH+dEKZBtwvZhe8cMzaENPlw8Yhj0CWFSeIHc9yM83ulWJvd8L/0Ry6e3S+LIcmGaalQxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: Ntod10CNwRVOOe0KXaB_e7Q063K46Ch8
X-Proofpoint-GUID: Ntod10CNwRVOOe0KXaB_e7Q063K46Ch8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/kernel/sys_m68k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index f55bdcb8e4f1..bd0274c7592e 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -402,8 +402,8 @@ sys_cacheflush (unsigned long addr, int scope, int cach=
e, unsigned long len)
 		 * to this process.
 		 */
 		mmap_read_lock(current->mm);
-		vma =3D find_vma(current->mm, addr);
-		if (!vma || addr < vma->vm_start || addr + len > vma->vm_end)
+		vma =3D vma_lookup(current->mm, addr);
+		if (!vma || addr + len > vma->vm_end)
 			goto out_unlock;
 	}
=20
--=20
2.30.2
