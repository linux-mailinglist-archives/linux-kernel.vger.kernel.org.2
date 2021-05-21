Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4974138CC97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbhEURtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:49:45 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41954 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbhEURtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:33 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHVPgM083850;
        Fri, 21 May 2021 17:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lV+UBAmAwVkVBXsnJs3ozxdkqTFb2HoBGn7kCP7sIlw=;
 b=AcS2DVWwNvUAHHKcBHiV0UdKVFyvnbgUy++fvi8KurTx2Q65ZraJPHOhnQJYigh48Kw6
 c3H1N3kOhVflv20WnsYmlUEOy2P5E5jnuyypYhghl0TPRaq7a4QUuJlL/4hIKKkbZYnU
 HSZMTwkaLKcfkuUazOHUVvHy4kQKc7xaebVXiqCwnNp1mRUCz5dSX/dakSAALIDoJFT4
 00AjjU3JIb3UQR3q/mJ+e78+Q3KtkFDfybYIIIDc7yXJ+2Y1bGmks09P4NSro7SCLqq3
 cXqGP3jOUyQnsv5uQwpEKzog9Gs/odDBtHYaf7xB29SOhowjVgoidpyeqpDyOaRX9Zpo zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38j3tbrf2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rV189475;
        Fri, 21 May 2021 17:48:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK2q8Utb+2MkMyMtx5+XDhL1JJ1xy6i4u2CB2o5FxnOiPqgzc4Henu5nNpjjLotWXlWutPdn1TpbJXw/hRYxX4m8K7I5m/f+zLDjnIR44h0C1r4EwT/u+QyUoy8l24rCbU1A5sEoH7VAM2ttKwDgYo6UixyJCcqFF3LK4JtHx7KhJLEJw5JfwTFEeOvc/WYGfs7Pej6cSNYmKEw61oxuejazBCx6LTHQfqRoEVXJuG0kLClu32MjaI+dUIYnX+kkFv9F0jjgQDwj+G+B7NnYotyCq47ekxUVoVGoLRH7x8oLtVniNLUnROE529E3qtQ4vs+1/2G2J2m+sc2+sHGJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV+UBAmAwVkVBXsnJs3ozxdkqTFb2HoBGn7kCP7sIlw=;
 b=EniKVa5SVCBhcozxsvZXO83cRsrwMD8LLKrIeBJikLCwdWKetPjluNQWY01db2TFiLUW2ltUIPM2bUFRd/qKOH3ebgEy2ZEWTs4/oV3zi2iIlVJw8hJok60vrf9xeEwvLGmdiTL4X0xlWzlodWbTD0RU+mbd3Zq4PU4jKq/Rk11c/O670pcstfKPMXitHYgqF56yjWgyBT9CLT3yWkDp/cxi3tGMzyi7PwLq4EJAZ81L1zeEGoiKba9IscwPmu3b1aGD+3c19CpHWY5z62wu1Pp3p2WVQIg+VFXeyntUDs0tCh26xEe5vcK0SXHudMRiU3rs4uP3YcQi8Q6XJUCZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV+UBAmAwVkVBXsnJs3ozxdkqTFb2HoBGn7kCP7sIlw=;
 b=mNKBTUCsp2V+liS4BLm4dVGlnQ0mUU6xglN40bYPXItz1rVWXGyUEvH57lVe9ERkBxeqrnfaNsLan7WCa+EfYbZettrj5YzYpWjpeC3KDhWvxRvAVHCIG9XYJXpiFACms+wZj1khF8CvVN30NjRIu9Pikh0dLCGl9eSBYECCOl8=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:00 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 07/22] arch/mips/kernel/traps: Use vma_lookup() instead of
 find_vma()
Thread-Topic: [PATCH v2 07/22] arch/mips/kernel/traps: Use vma_lookup()
 instead of find_vma()
Thread-Index: AQHXTmlwBfhKtOT190avM+iNVj7O5A==
Date:   Fri, 21 May 2021 17:48:00 +0000
Message-ID: <20210521174745.2219620-8-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 58c0f603-67b0-4a19-9825-08d91c809384
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB446799B2B7E572175C3D8AD6FD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ncSZDCbypCYHxVtQkj5ixjusjWUnVcHvR3Iug2S0WUD/ogXCRIWnuWFyUYiZXTHDZSWXG7GKGn3EnPvLH7qarN6rsOpfh/aauh7FnirNKoqkN/X6bpjknt1gOy6Gkwl6i/KRH31BZvmdcLYZZkUJv/Js+Pj4i61nFK1/UTM2Kw+qTJ1s8qgrUz+gDbj5YdMzfsc3yySWQrtYeXTSqBbUu1j+qdryKGstFkRaSzUuFZlS2+5hKewo2c2BEe1uYcMWKVvKqUzFzi6/uZhC5eIOa9a3AaGNRYB112CclH0LrLu69awTbnbh/YGRdBQMoTat0X4mpLTzH95qwVCCwVPYmei7kbF3fRUc/GZ6mmGnlmRSZtGVgP2uH66zLz7FJtf+xM/lD8lFc+UDfQREHzBjWvF372p1IwVkyNSFYKA5GJcdVtDPZ8rfrSzr4dSRHOIRzq01jWliN6K0qmBfw8ErxuTLVNr01rmRcm1OwOUpFPRvbZ1tNteRdEAJpDf0TqXEDECPT2BVXSzk594kEayArSmups/5B+EE4DRa4TeklZbah0Vpj298uvSGZYNil/onCToI8aOQU7Yj+gvAfMi5ajY67WpopSs6SZ3YdgGIQo0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?znRBoZdyqWKFEdS1ytenDO5g9DlwsMoQ1lsWhZTtH9dAGJj8ObJx3MTIGY?=
 =?iso-8859-1?Q?QqQqXZmedhB5zoIkDtXtBkSygBp7C25kh7hUYqYGIu4VSvDZ7ZuxFe7Zp8?=
 =?iso-8859-1?Q?HjEC+f46QKmlA0TYxLbq4nTpWTG+DGXbVmICkPzVE7ZJsQBSKj/GP05msI?=
 =?iso-8859-1?Q?HBz3dRU/kk+QqJFLLS4mMmFyBfULG6GoLouWZKHsQRjcB6m9lRjA06c6Mf?=
 =?iso-8859-1?Q?DLzCTNrU/IPfSA1+VfKSZbWk+x/JuPsE/9rK146WRpPa/j9TxQ94yYQghV?=
 =?iso-8859-1?Q?/Zl+gq6s60mqQFB7sVuyJvoI/TMFO46yZqIaQilORIp+S9tCJea7GnbcPv?=
 =?iso-8859-1?Q?AvlMMadNcrV5a/ARh0fo+E0k99LpRj2WQ9s3ybKqv2XYAgB4w4VPBPw3ee?=
 =?iso-8859-1?Q?pFlqjQOBgc59I4HZ/2BvsaQRGPXGleLQ1vNCQ6++SW2NUnvMe7D2Y7G2GS?=
 =?iso-8859-1?Q?+rNkQfS2BqT6ngJBI5NY/ZhETJWmedYfHSWCB38aExSHFaZbK+X6SXZtyJ?=
 =?iso-8859-1?Q?ylA4JLe3eQqZ1Z0DX+vuawRPv3+8Y555YO0bJ4KwSwyn6WA4rqIcdzU9lb?=
 =?iso-8859-1?Q?YEqmVUDACcduBekpD8vNNDrKW9B/7q0B/o2X2tHU3AvBDMggsEzx0RSxbG?=
 =?iso-8859-1?Q?HELhk1AMxio2+OjLRR7BlHrmiMMdOBkiUZrEwXmLWrrOQaktssJdjvjUwp?=
 =?iso-8859-1?Q?dzxz/snltBI0PY4vFwfPwulT1dHa8iNbdlobOLersFC4TbX/jRLjrDJr03?=
 =?iso-8859-1?Q?2n9IIY27hmHPQjDCx3x+5MT5iUWMxDc7UmJ4fp+pNVoxEus9YjDMNG9rjF?=
 =?iso-8859-1?Q?A4W0OWQy+y8UsGBMuyNXtskjto7wJH88DPwslc3AS3Xc6r7CwpruBTVF73?=
 =?iso-8859-1?Q?dSZn33Ym+ExSJ7C5M4apL6Xk87IRkuWQr99kqUFKbw3Z504GDz4HHfDrfC?=
 =?iso-8859-1?Q?mGN8GE3B/j1Jet9Tgb3exJ0Ugljr9ybxIeRjymzLT0QfEo1oNkVhUxXmiu?=
 =?iso-8859-1?Q?2Bxnc/i3MHR7jXBGOX/UrBkRmPKotxbbVhCP8V2IzrRJkIRAhgSHjPy//+?=
 =?iso-8859-1?Q?CJ8F92xRuE70o0R7pDJq8mTupCTK/I5u11j3rg7C76lByDJQctAp6JzW5j?=
 =?iso-8859-1?Q?Oof6V9OK1PbxjwKIMx6WhMuJzWSTAyk+NB7LwDp8NpQpwAwK0PtLBXW3JW?=
 =?iso-8859-1?Q?UlC4ZyNAZxE7Baxylv0fYHCRt+KnRFQ2tveEmQg/Z2qjXL9NV+oGqFm875?=
 =?iso-8859-1?Q?3BQX9Tg+mVyV95RhdNeSRu8j/1KbFRMTDCyOZyVn/Pl7VlTCVzRTHtvrau?=
 =?iso-8859-1?Q?UCRkrnhMQBMWUSEGfN/N1ROPDobVKjmQJ+H6ZMD8FTEmBeAS0dfIWL7xr5?=
 =?iso-8859-1?Q?PGd4S/ELZC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c0f603-67b0-4a19-9825-08d91c809384
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:00.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPxgyLkoNmKX8lw5597UAaOVPyX6WQjnXqNJqGkgbViQ/p/QBmqoiqQcSCAf03BQrI7zGgEzEBiyzOVz5eYCGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: 9p6PDFaWWa8HJiop8mQJOeHyXu2pQXAW
X-Proofpoint-GUID: 9p6PDFaWWa8HJiop8mQJOeHyXu2pQXAW
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210092
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
