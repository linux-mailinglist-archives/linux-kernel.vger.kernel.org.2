Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D99352028
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhDATwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:52:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59060 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbhDATwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:52:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131JY47u057297;
        Thu, 1 Apr 2021 19:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=u2CBiOhBGly3kAwQNXmCmHyNix/LtTyhVCxqW+hoE5o=;
 b=iD/72yvMYHt5Cj4Eety16AmJPD3m8qdHZaNr4AX+QtbJ2IGoc9WqVh4/59XFIFPl59SE
 Dwr83DPOGvBTJuUFbeIuWeediGjDvr7f4tt4NA/a24nmyUnjdfxQxc0/07np4AGMRXWu
 akeFU2zrPI6H3K5UZQqg+W3XNq1YEZRMOrHjFuDtEZSHPr2EsmtkMWUoouCR+p9gCe7w
 YRAmQSKPjv0OuVQur93gwLyiFWUWK+mZY667y6tdFy0ZGSPGJtlHRJtJqWB3uMCzYzjb
 Vrz2JeZ8025nPFipn/Sx2vUPJLGCgCllF5Ds7HY7aszr1uOC1nejIOnDPDovnvfKY6x7 bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37n2akk225-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 19:51:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131JZDY8094794;
        Thu, 1 Apr 2021 19:51:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3020.oracle.com with ESMTP id 37n2abpt1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 19:51:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC5fb7RV+J0IXAbEGo3dKwSfbZ9I/7maCNySCtP0+rwKr+4Vzs64xUNceZNGfOAMEwxjB7PumqbVHNyGjNdFRTeYYSLq4RBCWkSwA/nNGnSPseJDaSyKgEflEKaQUr1w3VVedhgvGCM0+ZlYY2Rqqd+A/pXjoayQ1HnbNNBVFoPfoyu60jieaSCgUnSRTw7pMNv/v4rUHNh1Me1tt2TMKfxHGxcK9mYEmgC9SqGt4TKANn1huVUivqcRHpvSPSqcqxobpbk7YmEvmsIIra/fbilfejeJGjVR8pDeZKmkoOBTbbaQY/xIJcdXUR+aGkU8GT5SWobMFtLW+q/PAD17/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2CBiOhBGly3kAwQNXmCmHyNix/LtTyhVCxqW+hoE5o=;
 b=dT9RIZh9FIIvY7V17kvtzXunDItnXno/aNUZmhSIeoFAj4wnXe7mRSC+KE0bPGuK8saW/5eFOgRjLoPG2TVJDuWl3KpDKrIT79y/C9Hlv6odBmP6sofkW/GbFJ/ChbZjhGs9Uj+gUysmZr7Y6glLRvQXFjAX7qjjMK1LQMK4h3QgHHk7/DwZpgoa4xWrJ4UGJDGqmJeoqDpdLMKTlyyFonUbCbd3kVBGcpoVb7sKloQ2EEpj5zR+H5QaHPf+6lVjlshs+CKMkBd8Fy2T4jlDUNCiO23K1XWT8gYTc470wZ63h+fi3dZacHonXToIARO52KNiVIb3JHcweYU6+zp6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2CBiOhBGly3kAwQNXmCmHyNix/LtTyhVCxqW+hoE5o=;
 b=z6TiXC9vjLxq6jt7Mk3M1xD8u1LwcDEWR9Y1uo8d8rI9q6DmQ4Cso9c1XETHNaKqtL3kRhJBta2nRbcluWo+zMCtwIu//AxsrczfPyzfCa3h+LedZS6vAspSEfVYxRhIkYmYbrYzGPPip+LRGT+N3NA0nYfcn/JNURbAqsdhn/I=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR1001MB2143.namprd10.prod.outlook.com (2603:10b6:301:36::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Thu, 1 Apr
 2021 19:51:49 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::1ce7:260b:b004:c82c]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::1ce7:260b:b004:c82c%11]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 19:51:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH] alpha/kernel/traps: Use find_vma_intersection() in traps for
 setting si_code
Thread-Topic: [PATCH] alpha/kernel/traps: Use find_vma_intersection() in traps
 for setting si_code
Thread-Index: AQHXJzBzAo0LIIQ3IkiycclLKpCw2g==
Date:   Thu, 1 Apr 2021 19:51:48 +0000
Message-ID: <20210401195138.2895285-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.0
authentication-results: twiddle.net; dkim=none (message not signed)
 header.d=none;twiddle.net; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c8ef5dd-0796-4a56-7a02-08d8f547968a
x-ms-traffictypediagnostic: MWHPR1001MB2143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1001MB2143775A2FF368A6E8EE6F61FD7B9@MWHPR1001MB2143.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OJuAyOdcMSgJyK54QAb/znj/FT/UZBHK0tSPuxjIQFglWLKsPBe7m+K7SXPioxsYEQTRulRLUzrbQ48o3tnE7LQGv8MLegYvpGgMpQsvUmKHfAdGHadGe/hurc/lBBBWYOiEE4a4PgFuLgyy7A4hoa/7+WRCxuuZ88eNS9IlAAtCzc5hcPKDdHB2TlnVjboQinn3BQis3S1QQPXMvXGEpKd8NJ7vKJrY6JchN05oLoxJnBHfNe1KGMDxg/GUn/1JU1nYHwhYiq0sUCeG32dFF1T+Vy+oyM602aB2Ugf805MEwpzcGZYMXwkqV60McD9+GlIxNx/a1wj8NIXaE0//lQYfjBPV6lQZ30rRfRC3h4BbsXvD/tnKS7tUQ5Oy1GpuaetLPJ/CuGRufTSrRinJIu3AYXaGDNmHuqO/RQT/Sngv35xFlY0rphSA2mP0Tln6HyZBgBF9h3n/FUbn4lku9ofr92g9DueeLevV5ug4HNZ0KkLYjSIFi69J6nPseO4KpIByAoTl8qrsRO5eHjsYgX1QeY/ZoPdWQeNxSVG3LRq7vJlZI7UCH7kIcu9oEy74ric8AcO10ozvfDKzFlocRuSVxX7lXhlT8HRWlzUSPsnf92qn/7T9OezhnK77PGrcXHYE+PIqPQF0rSl7xYzFOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(376002)(39860400002)(6486002)(44832011)(71200400001)(2616005)(8676002)(64756008)(66446008)(66556008)(4326008)(86362001)(1076003)(91956017)(66476007)(6506007)(478600001)(6512007)(316002)(2906002)(36756003)(26005)(5660300002)(186003)(76116006)(38100700001)(4744005)(83380400001)(8936002)(110136005)(54906003)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?wMFurlvESmQAJEO4qDwwFDyUqZZdhQxBrOMD3eGFePW7qLx7KY9/QTzDHw?=
 =?iso-8859-1?Q?5a7BhY1EGMZ+3e4pU7w/AItGMpJYvojaI2jEBqe1RsjH2PVWkpQEJ5O8DD?=
 =?iso-8859-1?Q?ON8M7+XhZKbhLGHktVq1T/ILCGTVLux5EeAC6EZ1qNmcl9Mca7Qa4tgbvJ?=
 =?iso-8859-1?Q?kEcKqCNk5nWCdn+XMzYUHi681qY8miUnP8lty6Q5M3a98XEWzzOgdPEMfB?=
 =?iso-8859-1?Q?bzfA2Q9UhI2MWErXoMzXpJUgw67tMowP49mTbiNpnUCXsIPp6T1bZTKX4o?=
 =?iso-8859-1?Q?+lQdorrSugVKcezEpd8gunHf4/n9EPJGgWK+JlUk87awl48JuUvYU3ydCv?=
 =?iso-8859-1?Q?63R8YMs2d0QKrF10y7btKROUrgtJH40UJlRvo54M+X9L+imB83BlEZrbNY?=
 =?iso-8859-1?Q?aupLFDYsXJBhM7OwjGHeLxUu45yl33IjJMHxWjBFSZWvB2qfHvdyRycykv?=
 =?iso-8859-1?Q?rjg2jAXY47FS0hi4eTepC8kfTas6OdEbrBnFVMgLf6D5cjp1n1DeWjIc67?=
 =?iso-8859-1?Q?wsca+JNl+4HXZ8ujsoM4feDKUyq8izD30D01rrqhrF6w9TTmSIzud3FyJN?=
 =?iso-8859-1?Q?s5NiubEYXqSzd9D6ZkYH2qsj9GCufb9k7FNEs0Hi5BqspwXobJPpoEXMWn?=
 =?iso-8859-1?Q?lFUAGDrHSmyJ7qQEdRNnCu4o+67X/pDVfnfFxAjTG1vM+n7xp6EDTHFSk0?=
 =?iso-8859-1?Q?w8VTF7NKiTqRBVzdBDJRt2WQyTq5y9Cz2RC/OYniREujbq85onHFZ6P7bE?=
 =?iso-8859-1?Q?g2aJajF+RIOOL+NZp8ZFBddhXGcd/BQO3TFlKDj7+h09OoEQRi8IImfnEK?=
 =?iso-8859-1?Q?dvYqWv/NTbfJMChLYWtQz1JoatsVl4gqot0edu/zz0vLNdgIO9BnSm/J9m?=
 =?iso-8859-1?Q?L1zqcmvTHu20QMK69MFmDubhJgyLq/l0V9XCh1CdijQJRuok50XF/RgffF?=
 =?iso-8859-1?Q?seB98c7VePWiwdq5G1h2dtXs7CdwbG61Vj57uiCPAcgYsuFN0OYkB4y12m?=
 =?iso-8859-1?Q?hna6CuODp9Otba8J/FlT4HfkJMnLnq489r0xkGgPQ1+fLXQgSYxmMt/LdT?=
 =?iso-8859-1?Q?N6Aahs6ZwEwDUZKTXuJ2EaFArV4SXYUX/bOku8rnMY9kXiCY7d4wpEWI7p?=
 =?iso-8859-1?Q?DZ93UDCA5lobXOfUQ8eKTzWLKTTgkG5o9FrCLBV+q+EjGcQ5qu+Tni8v/W?=
 =?iso-8859-1?Q?X/3dZpa3VBbsPwxr45dMYFjkZTiqQOZTBr5ebE3JQK+eEpJxD6prVFYMBx?=
 =?iso-8859-1?Q?K0VMM2zqxXOKU3n4aJB/RHwigrsHsbBIii1qNRFS5ZYA4PkBILyN7/0iWe?=
 =?iso-8859-1?Q?jI2OMh84GHDqUohjMFlC+KihSV97n+rF8wHABGaHBcrX8GiQarWfSTUeBf?=
 =?iso-8859-1?Q?pYLKAqxaOh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8ef5dd-0796-4a56-7a02-08d8f547968a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 19:51:48.8566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/bq9fHtGtmni/5wy2TmbLAg8/ValxcK6naS7XDJnQhAcgU2Pi0lRPc1RfP7kbBjr6lMvNfawikFl6LS9QcR4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2143
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010126
X-Proofpoint-ORIG-GUID: oaUcnAHFJn_W9aWbMK-q1vNYc7m7hZOu
X-Proofpoint-GUID: oaUcnAHFJn_W9aWbMK-q1vNYc7m7hZOu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_vma() will continue to search upwards until the end of the virtual
memory space.  This means the si_code would almost never be set to
SEGV_MAPERR even when the address falls outside of any VMA.

Using find_vma_intersection() allows for what is intended by only
returning a VMA if it falls within the range provided, in this case a
window of 1.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/alpha/kernel/traps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 921d4b6e4d95..7f51386c06d0 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -957,8 +957,10 @@ do_entUnaUser(void __user * va, unsigned long opcode,
 		si_code =3D SEGV_ACCERR;
 	else {
 		struct mm_struct *mm =3D current->mm;
+		unsigned long addr =3D (unsigned long)va;
+
 		mmap_read_lock(mm);
-		if (find_vma(mm, (unsigned long)va))
+		if (find_vma_intersection(mm, addr, addr + 1))
 			si_code =3D SEGV_ACCERR;
 		else
 			si_code =3D SEGV_MAPERR;
--=20
2.30.0
