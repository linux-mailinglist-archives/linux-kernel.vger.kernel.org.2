Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2983794D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhEJRBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:01:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34186 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhEJRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGsFo1173323;
        Mon, 10 May 2021 16:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OtOL2A/ZbTYZXiXqaF3a8Xytx+OAVd/DKSy1kuCLwSM=;
 b=iJriBxxaTWFZ+38j0bKhzVxVUFLXhRavBRh94wZpJQfYApt5ILobqjEjXQ9E8hhhbMS8
 w6T6sOp5TrbTAtVa9vYZSjpYlNYeyk43f0G/RBfyuqPMTq7FHj1aND9olg3CHfFe/YNJ
 yj7Un6+3z3iG7/VRbAoztImIU3T/LpAlf816QeikSxe2w9ZnYUgFNXgu9dzLV5lZwnkU
 7mE2MbRajQgdrQ2z17W2cH9jWht/CamN8kb9VhwHoYKsUaTceDFZPLgtRrJJ6sY59tbP
 BMtSwLMmHab11nGBtcPYlghM19fw63M6WcoeVxF8vy4ReBEo2MMkzs/u6hSidONhPZgS vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38dg5bc2gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtfFh036499;
        Mon, 10 May 2021 16:59:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 38dfrvs50x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+ptwm4Ju8PwkkMIHlVouq+7ezyicRizwweHUma8+fmapAN5jdFZZ8Ot6SGZq9pLR3qnGmYb++i/gkjSHZ9+SCrsBLjUyD8WClm/wVX3VMBBhPzoklkd/EJPiZ1zRzvYjPZfKGyNbSgV4nXoTAuXKQ4oN7T4810uPPBSrULBSUuZq9H/wB4En9s9Mg/XBlJjnKycYFB191Yoyn+08/O+XFG5L7dFq/4eZZm++AY0bwKbo1SPXNuRRrP/G7YRJpFwvfKqWPsQzK0uxsxElD2wbU9tXuQyanDePZ2DaLQ4+BIfgbJZJP1KvCMO6BcwiCWN4Y0EuHtf8vWShbFQNV4aKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtOL2A/ZbTYZXiXqaF3a8Xytx+OAVd/DKSy1kuCLwSM=;
 b=nP2rxbzrBQKTs6nkH/ApvJlaZd4JRPmORwYdTCxEExd9Bboqz53oFTJSA5vywUBW2IHt3cDha+65DtmVTxwiPgx1X774/EvkullyLiRZFE/50Aav9cK2UQwAJZjsi55OYJYdaiImeVVhOUGmnGyzMnCPAKkGv6vS4ZWQsgV/XvStm21VJGDMfAo1uhhZY55LIIdt++SFXm6MdOE/MOghS3jJOmHsZCIGoo4W09sZSb7TujqhDuTYqgvP+ToWwngxdObkMuHnHbEza9avKlIGnrFo+txCwmhDfHAf9/HKdGRrLAC032kDa4dK0FCUNy8JO60LaWNH9PE5sRNNgVUhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtOL2A/ZbTYZXiXqaF3a8Xytx+OAVd/DKSy1kuCLwSM=;
 b=n089OKwdlw4zzyTO7HbaUBlKP5+r726eG6/sYWQDDTiqeS/qdhBx2mF6cv1EQupXeKV73JpZ3ysKt3fqTTzjgEvnlZLMaCUbdX2usrY/bv9vQBLCsjvtQaBQXpda/CzYjE216WXfYWd46X+J6sV98EzloIKfTKgEkea8v0/9xkI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:54 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:54 +0000
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
Subject: [PATCH 12/22] net/ipv5/tcp: Use vma_lookup() in
 tcp_zerocopy_receive()
Thread-Topic: [PATCH 12/22] net/ipv5/tcp: Use vma_lookup() in
 tcp_zerocopy_receive()
Thread-Index: AQHXRb3C8AW4MeSLNEeR8Dl/1JhMVg==
Date:   Mon, 10 May 2021 16:58:54 +0000
Message-ID: <20210510165839.2692974-13-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 980c1640-4a6a-4df4-d603-08d913d4e4fc
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB47694759775F55947B381478FD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wRx3+ebjuUWzhl+Aumwr66xBKTG8znGxiCoQbF4zm6Y7twwrgPvDKcSZ8BnkJ29tohpyYlwPvIzSVCOl+sSlRlu9cq0AMCmQtSW2rua8DDbrB+1oyejQvvfuokX9y865a/AciKvMxiE9vlBfb+/9H7IcmaHaWa9M7C6HQS0nq8/YQcq300a8eT5fsOD1Y4kr3NpsopBD0RJuIrg7csZ+75fjH9302+PLoKVbysZUmz+mBZnphBp4uSVdI1dAQ7B7f0a7wpjPhl/wKnBoM79MVmjDs9/l6BgmgaU94CR+lWXO+sDTsT3H3tBaR2Ha2YatqxbtFfAWfroffcZVTwjBDja96T6oBNWX7YJhAmAqEiBaozyZ1i87pwS60gtn49YqrNygmUbwFv0AL+MVFZlnOC3ecu8wSp7Jaw0dFl6+JUB+N/CiTwmX3A2scRBsldDBH54r7rMacZYlHOLM3CDWk0IuLqeKkGsgrzm7hN1Mp0kdRh7wx/pK9gH8p57k7eKOC8m5hhRvbNyP9Bt1a8hCeEkL6hGQST5rcy25j5rmUFJOtW/ONcFflLxvqSbLvjdz8NTJwaUIzXRMt3FE4j4eg64JQDqBsRTXHeTKr0QtmLo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(4744005)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?xUy4yqr6p4DTGKT3J3U+pvm4Ib7BXBW7ebuZA94nPmHwBZKWNc5UoFI/kR?=
 =?iso-8859-1?Q?WAS5B7Pg7VlSOD2r3qYyYIG4PhI1m/W8QMI2zX8jvhMM+tAMn2p2+V8PpL?=
 =?iso-8859-1?Q?Xya9D52B2Gp/luJ/HwwCofYkkM9v1whAEwavCfPTrNnxkWMzXEZYVUL1+y?=
 =?iso-8859-1?Q?PTxu70RHozR++tE4R08YHDmluz6V2SnXQ9237+CxckYrMOnoSgILEH1VT3?=
 =?iso-8859-1?Q?DjUsj1FzdEx4MfnfDLXxmt3HqCDC15g/DNMVAx2QwY04ut3yYDy3ieUwra?=
 =?iso-8859-1?Q?DOO48uE32HjDHEiz5BqhqbQHnFa3MM9H48aqsARajW8rNXg0tcrEvB/bGb?=
 =?iso-8859-1?Q?+fvyzpAMNwykkKfulS8BU3HUWQaORgjcWAHLJS8zO8n2XsUPGGi1wqMVSj?=
 =?iso-8859-1?Q?jO4ysZ27HCPRb08gMll2FSFRe6PWiTUVGTCpZojutgjbCpWp4YupB6w8ro?=
 =?iso-8859-1?Q?kntxJElKtqBH6umiMNZ2jlcqtCkPhSReBgbfV+jwFXefVT+bDYBB5ArUID?=
 =?iso-8859-1?Q?d9FnGx6xIImzezbNmIqdK8+VIfSL5nkKDVM3XiB3PBiEmAco4hJa6NLPR+?=
 =?iso-8859-1?Q?zd1RSialTYd2UXR66ygPQFUMaqMfk3OxUlqTKOs+XND213FhI23mg8TTr+?=
 =?iso-8859-1?Q?pN+iY9a6tAFkcfZzoK+L/53RKsDHQNHHjJ6uj/5HrKVDt8l9MXy5HZcjcC?=
 =?iso-8859-1?Q?WDucFSFGX289O6l6lSyx3mR6rJ5kvne6dl4Fc2InuQ/Ul1onPoeUNWQgE2?=
 =?iso-8859-1?Q?zITIeo7XGFYmQRtIKMF10ILHSU04jrvCGBVWrxEyL+gMkufEJVIcnwE8KX?=
 =?iso-8859-1?Q?cZtf5wltYTfUYAohOc8e+R38Jr6b40MrUwo70p+Jaha4s+6XgNyogD8tdW?=
 =?iso-8859-1?Q?K9gu/mEFGWfdcqHiTnmULfK81MFLCrWWVTf9yM1W1vQLToLKWQtLs+xTDG?=
 =?iso-8859-1?Q?VsAw5UgFNBLFGMj9IE7O+Rwvcf7QNEfVE/tNTOpXhmxwDoKr9RVfNDCFhZ?=
 =?iso-8859-1?Q?E+Equ3NyWO3i7UVfRs5rlI6MHq6Y4PUukEHESruH4NSc04kJX6tw3UHdLx?=
 =?iso-8859-1?Q?ZIy/UK14e7vIxBGDUT3gwLQEpfwLCpjPfP5qkV54piIGWg+H3Xv63TJ3BO?=
 =?iso-8859-1?Q?UyF1d6eG+UXQKrC2hBK56yOI45nQVuY11zqiBZB9KGuO34N2vxad+WIdb1?=
 =?iso-8859-1?Q?zNo3zBSktAfD/E/vPJLvuy1MqkKt4iy1FgagNSyuuUf9fLbIQu0wtMQ1cO?=
 =?iso-8859-1?Q?0NogP1n3k2qcIlGZq2KOGBgicoNnE17/xvxi+MQ90TjqNoQ7tFcBL1n88G?=
 =?iso-8859-1?Q?eK2DS79yMsKK7OyeABEIxLdpseG6hFuoMhpP6ibCZA1/WAlSD4MgdQIqzM?=
 =?iso-8859-1?Q?iyAO4w3Cb+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980c1640-4a6a-4df4-d603-08d913d4e4fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:54.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flcktzwiNvxs8BxPfALoUFvpWRYYresg8rp269nwUiRPd3B1sq7RjIjXRDEW6D4J3Y91N3sXuGZNV+S9eLV4vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100114
X-Proofpoint-GUID: glkBaJr4nOtIH-TVvKG-kyjhArUvaTwj
X-Proofpoint-ORIG-GUID: glkBaJr4nOtIH-TVvKG-kyjhArUvaTwj
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
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
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e14fd0c50c10..d4781a514012 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2094,8 +2094,8 @@ static int tcp_zerocopy_receive(struct sock *sk,
=20
 	mmap_read_lock(current->mm);
=20
-	vma =3D find_vma(current->mm, address);
-	if (!vma || vma->vm_start > address || vma->vm_ops !=3D &tcp_vm_ops) {
+	vma =3D vma_lookup(current->mm, address);
+	if (!vma || vma->vm_ops !=3D &tcp_vm_ops) {
 		mmap_read_unlock(current->mm);
 		return -EINVAL;
 	}
--=20
2.30.2
