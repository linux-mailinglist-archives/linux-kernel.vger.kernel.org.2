Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CFB36DBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbhD1PjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45628 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240170AbhD1PhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:05 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFM3Ii013796;
        Wed, 28 Apr 2021 15:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0DmyhXmCE283nM1pfQs15ZvXAX+JSQTwyR+/voPMw6Q=;
 b=gIWavMbVKfPyQJ62d9j3uuGYYwkCvQOZ/CaRA/XQt7t37F4m9YnQvc/kpXhRqg/L0HZt
 oWj23p8+hg2JWedpbQo9NeBQNJj0iSY3Hk5/wENUPYG9wc/MADGUiKk1vj8bzPjn/5Ga
 8i2IST2OVy5+KNqn6LwpFXxTCju4Hw4Hv6C/UD7AenqI5iu1fsRkk9QWTRv2/R+n4Z/6
 FnI07G+atmehagu1YELVFRjkgh2jE75QEHFGrs+V1nNzL8MjE3thORowRY610kOTZ6BV
 J2waKYqekQe4KAFMYV6H+TshFW4arQTSzRkopHhoBpewrDeB78thrSo/p0ZKWvZFepGF eQ== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:01 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFRrsW124479;
        Wed, 28 Apr 2021 15:36:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3030.oracle.com with ESMTP id 3848eyqwaq-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISNK+xt3ETxbeAvdbDw6kqXyP46buoF9dLhKQklE6vrSNw6gJQp9Fha/CxGXba6Wm+wBVaO91U4OJ0GOi9NjZgNlolOVCgxzbbVa1wYBHQI1becuZdqIhj/l42WoGkG6Px4ejdLCGsDILfp0HjNuBkpt+xNpC7eUfuYw4f1gVOfyNQTPs42dDhgDLP5SqGh+BCbF8TptNHpnua2oHASpyNEaENQDdC1XV9buc641AvRWU7KefhD876c4Qe+Vn/f0ejqWEFNKaXTIBaZag/eCBwSpJLsIPCXeI2wmeDUP1SOZksXcEQIpCk+yRGznLi1jvjdZt2BeocjadttkCHk+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DmyhXmCE283nM1pfQs15ZvXAX+JSQTwyR+/voPMw6Q=;
 b=gnxV9Q1JWgmYeCT3vzLzZ0Z4j7B9rMPCD+Djs6XvOgEvcgYnnh4r/kim8rh1m3sVt1WLC0nFq5jmtZgDII52xvDxJrKE0pfn01RtH2XSwo1zcVp+2L4x1nv7wESoX4XhDYK/UrQWZDfEpGVFG1858Xu19XNL/0fhjnGrCQW0doL7t6lgYwqeTOUk0VyMvVyGdm3uooizpFSneQa+F6s5HPb4oKisWBBfwey9whbSQuUePvy/vAeWRYwWftz4vaCv4WfCpG3lWrXOhbgMoyXwlSa8LUqvKe9hQvbqyknrPgK61QsEeFUF59J3EcwkCMWV4+frNROse3web2xIsJogLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DmyhXmCE283nM1pfQs15ZvXAX+JSQTwyR+/voPMw6Q=;
 b=EhKC3Z1uPh+wVlLnEI/geHYTquLJ75bdmp+ZRJTz3YxLxLxSAiDTleN2z6YG8sjr5wDhWn8a565wRcGRdUUbGTp3LTVcnpxqdE4HHcg1EU9GOd/WnJQGAUcNukPt6TkpG7omu9Epssp5agp7huJ/ZVB9wF03dngFDxabbJtPRnI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:35:57 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:57 +0000
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
Subject: [PATCH 25/94] radix tree test suite: Add __must_be_array() support
Thread-Topic: [PATCH 25/94] radix tree test suite: Add __must_be_array()
 support
Thread-Index: AQHXPEQuR5BwXJ8UCUyoj55OrTv0yw==
Date:   Wed, 28 Apr 2021 15:35:57 +0000
Message-ID: <20210428153542.2814175-26-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: acaceaa4-005c-4252-c360-08d90a5b5145
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB476931E584374C391A08728CFD409@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w0Ky8CvZYSEvHk8i9Zr5k4rU7rYMmXEyad1DCmIjHD9tK1Zu5cfZlaCn0XpOYSYdswkrnFPqAZdu2DypPV8it4PYpxtej1GZUgz5ibNtJw2D7R5gYEJ++mpBkTq3f7Qp8N11WkUUG6Eyd6IGukiXvZJSEYhmhpbP+ba7BVtF7UdpfT8Z7IPF6olfDgjudjUugHTCmTYT8buu0gPFs/DBBIFGZIyjmq4RI1wRRnEptCZ8CImcysvGiH7dcxk1xv15SHOXT4VJghSkOeDZJmvjAngwF5ODfXSEsjL6FauhTMrNCX/4fZphM4VQhM9q5B6EOJQfkpsm9O+Gv4FWJicQzp3ccrD2NkZkAl3Vrzljn7DTmUrIMpRiGx/nNLldn8nnudFpv71hcUpKR9AeKeBMuR/5Sf5NzW5Zeyifz3ttyro5tBoFV6yYD89LLlNq6CkNd1Xt2+BCtv5M2o7ZkrFPogIG35j8nkocnSGYB9V24T3xBEqBH/VYExOGvfxBb3KRjOeYf3oIQtoZDvV0yWtkabmUjean5eeOQMK/w437lHlFqx7ea5jzbyb8miLnFCiB/WVEo9RpsgUH7S1HrNsYl1QRVab8CE7w2B+QTB/gWGE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(86362001)(4744005)(2906002)(110136005)(66946007)(38100700002)(66446008)(66476007)(54906003)(8936002)(2616005)(8676002)(66556008)(76116006)(478600001)(36756003)(4326008)(44832011)(316002)(1076003)(107886003)(186003)(6512007)(7416002)(64756008)(91956017)(26005)(5660300002)(71200400001)(6486002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?yrlc2Kn4lt21maZHoe9dxSOPtyOqJsQncBIuv1FnRiAwcwqchZ/Tmj5FHl?=
 =?iso-8859-1?Q?nLsHvOT/FCVWjp3w0CTCNj/KueK4EqNEYe/u2lGs+HH4BEztXFtIrSUniO?=
 =?iso-8859-1?Q?qHNKcSH6WhIEon51WO1ckAWKVDgCh+YXwwCOVCZT3SuNVjrnTHPmc/uYon?=
 =?iso-8859-1?Q?s4msJX+DJg7VY1GvEvwyP1offTojak6gmWuEyG+M4s0ald60EJE+dCX3lX?=
 =?iso-8859-1?Q?gN64qbgFn2VBlfL30WjAAYt3s+yezJ5cJIgOpk5Nqu7N5aUoFwWl+k03nG?=
 =?iso-8859-1?Q?1qdi2eEu7J4W3Sb8FkGXNoQr1VMK/YVn6qQR5fDxQRo5N+82inhwOPoLYt?=
 =?iso-8859-1?Q?vgJRA/NwWO2+5IWFg+1nFdfgCh5SMtAHwZgNwkX34fOEloN31sPj9j7bYU?=
 =?iso-8859-1?Q?q2avHFL5IcCOR82vv7CCFjEIwTmjlHY4YoNGZnXdIa2mEalT7bb+RH+bSA?=
 =?iso-8859-1?Q?ywKI6HJ+8b9VfZ9HJUawylaEsRuwZP63ngKvk/qWTpsmI+sreP3m+PdWHL?=
 =?iso-8859-1?Q?ykowkDv1xHMPD3IiFUjPgMHVKGP1K6caiTiUWXfqBB90UANlissyLrT7IP?=
 =?iso-8859-1?Q?095qVxMY2dQozs7r8AAqYF92kTnXFTwjb6zqS/SfaCYLQrk1tetnwmoma5?=
 =?iso-8859-1?Q?1E+D02uEb9mXwU0lKAMbu8REQNuAUv+IqhuUYKu89hGiNKkJKN4dV9Etbk?=
 =?iso-8859-1?Q?+ILhHuSy5zJhqyhkNpBNVUqsejDnlhLpur/7srlPmG7C+yDcZP8veV3h/1?=
 =?iso-8859-1?Q?jJmwjXfKK3e05yC9DIuxhgTHWqqLT7ymtf/cmZO0xUJOG8bNSaZ2qaYziv?=
 =?iso-8859-1?Q?wHrx1IzP+0XfVx5WiLOXh5Z/xHbE6L1NJK+8D2HotZaWUcC33RXvrmAJtu?=
 =?iso-8859-1?Q?GYwZLRC0aEeMFgORP/iHvV5XihU7IfRrj/AOSGsq0w1MJL4t+gvjg3vfUe?=
 =?iso-8859-1?Q?Zvee64RKrgknaAHI+hhOwLNSPKvXQO+KahmJlz56UuI1xNHeUz94UVKRfy?=
 =?iso-8859-1?Q?X1u+1G+6gv/ryez06vpur8MsUUGGZhltAD06kjFMY7e0eqqEmQE+VM9+EE?=
 =?iso-8859-1?Q?oOHDHzR5EtC/rvRj/DyuL77jN0LrYpoKqA/FIKfKcyiTF/2FlsKaZmBYdK?=
 =?iso-8859-1?Q?oxNvvSUUJtHVnuXNc1c15j3sJnO2EO/yja0Z9gBTx+vOOWkWJpxUtTgpR5?=
 =?iso-8859-1?Q?gxcOUFuLq6ksvNqBlODfms+PO6ismP0NjnB2Fq4sANVJz9IljuzEJhzvuM?=
 =?iso-8859-1?Q?rKisDOlVf07BUOTgeL/p2iCM1R1eKKXjzeMMB2JNdeFyvkfbKQY6kr6a5B?=
 =?iso-8859-1?Q?u8iXwUdMkzpC4PJ1PkDHmBStPNJyB+Q/utZLy4xkXdkOIu1MVVU1PqEvDC?=
 =?iso-8859-1?Q?rAFZ/HHAN1CwNxeG2+Fu4oQU0f0ps5Sw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acaceaa4-005c-4252-c360-08d90a5b5145
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:57.0544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LA6diXtw+Ck5oq8ydiQgOTscDqY5jvKIvOb6kGv84JgwbSeGCE/TOX+wYVmGts3+/eJygObJEyrr87zLRAowqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: F_13XuxYlJuTsYO049uMBMCjK-7X7_7x
X-Proofpoint-GUID: F_13XuxYlJuTsYO049uMBMCjK-7X7_7x
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux/kernel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 99979aeaa379..e44603a181da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -31,4 +31,6 @@
 # define fallthrough                    do {} while (0)  /* fallthrough */
 #endif /* __has_attribute */
=20
+#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+
 #endif /* _KERNEL_H */
--=20
2.30.2
