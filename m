Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962BB421C0C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhJEBgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15910 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232429AbhJEBeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19508Mdl004481;
        Tue, 5 Oct 2021 01:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=taad8FPo9G2wWA09nDe7GP761yIwtzMi1D3jdQKhS5o=;
 b=VdiAbNXEBWkMsC/VhJqFuxo6CRn4dnqAZcn9l+j9ZVq3tDI9JMIZzZS6L/oW/xJYcxSg
 Yf4mIqZTv03cJfgq9I8xTYGZ3R+XjyMwRAaZQPoAg672SIBxbMCEbEdTn4mb34ijIQdv
 4ftfbC24KazD10KjeEQc3rL1Uu53M3k946Xl1FHcoYUw8uh70CbQQuqr4odbhxHEDY0O
 hBAponVWd1CVZpSBURbGSr9FjdRUEy0nkUkkqZkMbCiM40a71bJAZCtWmZiq+QI2cE4x
 SR8fRtdhRW02l95jLVZSzimWMFSJjdagHTfjdGtwGcW2z7h2EqGwqzND2X5SIBtEt6+8 EQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHTV178361;
        Tue, 5 Oct 2021 01:31:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3bev8w0386-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltqpbm4J16Cd3NNkTGOBFywbfY/So2I9IxVtKRvlXkvhkqjQe6MQtYKcPB6BMhelTyUNOZ78VMjFdk4srOcQKhbqv/6PJ2WjFk9mTzxkftjkC6z7JBlW+AWCa7Wddv8qG6Q4Eb3T+FzncQfRwHGyrsEuT4rk42hFnGwI60wH4i337r3i1q+gZAhPSGp+Cm+D6KLcv5uOqChTrp8baMeJLC1RYWBZj0kW8eH5Ffd/oqbRXKWf0wY/rCFtXXY95NPufXx36vlAzg0vzw1PM/AE4HEQkfzbmwPH3NjmdFoQVe8ZpPZ3jxbgQYnO9xm8Pr4/muiLzJUZviAsaZ7g50yFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taad8FPo9G2wWA09nDe7GP761yIwtzMi1D3jdQKhS5o=;
 b=AQhxOXf2Y9gK+nD7nAKn4UQ46lIRaJwufjQ4kxqJTtHsp2F7iwaqxiHO1ZZEAAD37INK8xSU+O75xX1+ho8waFdRIZm2am+6NR7I/bP8fhY3zQPS+ZqsBAoBGNOObiIXFfvaZpa3HmaFpFc6HKtSCoXtQuZS80LE8XbwAcycfUxi9P9K2IlG38uSwp80FOhoHQx+f0LaU3rFS9rBrghxWTZS06Cc66JiWCvSdLoYBaLqFu1oMJdP49cUt0lmyih5EvDE3XWDrxcXEPHOqRv6uvlgr23BEl2EkA8cwACmn+HmDXggAeO3T4wUBRoMcMEE1BPKNKrBWEijRgE5aSuFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taad8FPo9G2wWA09nDe7GP761yIwtzMi1D3jdQKhS5o=;
 b=JRm9HpuJvB9gMIMRUdcbEuSz/gPQsfCGPbfkZyvpBUfGsr1t+1pLUlRnYTfBA9806D5XOCHFZOy/TEQ9rBw1hjbpEp/Z0J6fJND1zvEqgnmf61PZEab5S3I+fBVhs+BeLQiI58fP/ITfSIDN7jQgVnsLktZ4eNcrCpJpMJh1Wlc=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:26 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 56/66] mm/mremap: Use vma_next() instead of vma linked list
Thread-Topic: [PATCH v3 56/66] mm/mremap: Use vma_next() instead of vma linked
 list
Thread-Index: AQHXuYirHzkEEnfXBEmxcW6HjmUcXg==
Date:   Tue, 5 Oct 2021 01:31:07 +0000
Message-ID: <20211005012959.1110504-57-Liam.Howlett@oracle.com>
References: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2a75ee5-7886-4215-9524-08d9879fd932
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50447F8DA099380C406C8862FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1nfMcS6+gj/cX4K72VVcvWSCvCNvxm7mcVSCwihpDkQiRV9/nLeMoJCYud2YVrXzwCE5HlOlxMue6OmBCwL+kOy34QCgW6RrhSVl2fIzyhaSh/Tbr+EbxBpPJF1f2rUQwYdPWN1jzGJy+rS944Wfsr3wscFVLNC8F4/yY+klBwk4IvHSVM95JUNQw6U6sAwHIX8kpMc7FCq0LDNUuSLrVX+I2b5jCRGPwfDJo7mBR6jq2kFI0rEjkWtd8shSzOa4R6rOagW4FSWVtU03KlVOl/HRZt0ng4d1glBA32yF9qOi7kbgRH8hilUnPVwhTvt9+1Ix/ZDDEkGvu7a0LOvi+YvudAcZ3BQlR2wzBbAXSedxF+mnIVjb7mglfYrFx0CCZQ83jmrXfMP6XiTcYsR128Yp6Y2PzszLyotnllFJhryI2vkkfr0I1ytsG6R+2T39WGbZOf8dzqPk8nHYZ9LOpAoBXZ9frFRvOeGRCzgfPKfWYzDxUS5P10C1G/i72LtumhcpIg52AJc5oMBWrWQBnCJswMK00YJT46nExV56fDzPDNQ9VNM719DurkZo/uXB5kc2+Vw9EiolvgRlY4DIJ62KzOyqx0LxNiS7rfPWOrpFw590N/SZou4dU6HRhVWiydDgbruorFvZyWMGsFNlxWg0fYhcieoSvXHBrvMb1mkj0NqpcNY2mWxk/tsIvvVmrEv3lqal/G4eSf6YpG2XJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H5gEwKoMMjniA91qkgw2l3L1UIshDwXi1RQG5FkZoDhJ0YINQO/DN+Xkzc?=
 =?iso-8859-1?Q?HdlRMjAnJUQPIhJCpGE3MjEFXRY29v6e3fwiaICDJGK6Y39O3PG3uJJxMY?=
 =?iso-8859-1?Q?T5f0rcsP40PaadWIDADsxBBzdV52mhC2pBUdrMVgaPFXjpvtBihrXrxBWh?=
 =?iso-8859-1?Q?tKnuCTZSjlD/rZXjsRFVIZqHquSfdNJOhsXXXyYIX+BTRei0gx8CwmTcGJ?=
 =?iso-8859-1?Q?taHMILyAdIIWRc5w+lwjSI5PTBVOhOdZIweDFfaOpmnmglXCiAYbnNz+Gx?=
 =?iso-8859-1?Q?E/SdN+kKgp1ldPND9a620Efvmld2jVOmWNYIVh4KyJNZFh64QP2+ah/0zl?=
 =?iso-8859-1?Q?BkwKS4cEMsw9g8GJHg0+8lWIejcJebE8nHiRseES1NiYtfX0d3xD3J2QJi?=
 =?iso-8859-1?Q?auD4g4xCmcC3LAl9EQM5OLzfJCQtO4mOGoTqfxCYBqwKvzdZAQ5USZ4kGH?=
 =?iso-8859-1?Q?B9zgMtwIq+xIKtRWQBAwiCxZJIndTUGD0dg30gEaR6mvwpS3CnPFNXF5jc?=
 =?iso-8859-1?Q?w8Sn4+TmovgKqvMhhWI/tjgXyO1U/HGldQBfM2Ryw+tsIkypJXPCnKHS5/?=
 =?iso-8859-1?Q?qRCCMVQNudUJic+t4agf91CZjPFJG7f++2q4EZLDkJnWeA6ATF8VzibBVl?=
 =?iso-8859-1?Q?F+lv12Dx1+idm7Y9WWbmVhFnJsukG69CLQZqWnrrvWSfsLphFUIjOCLhWe?=
 =?iso-8859-1?Q?2sLLhUy5JHODp1lYUL31bb7LHQ4cQcK1PMLhGTdQgTTJ432ZH6kqH2KhkZ?=
 =?iso-8859-1?Q?vvLvPJxhk4kqnLVfbnuhb14xeMf43qO5zc0kQ4hAT3pIzkSD3XnwIUulna?=
 =?iso-8859-1?Q?mLXjGogDifq+BmrO+bf4GGAlIqvIY+DKZ+gZfggB0qDvufQrAp3+Jl0koV?=
 =?iso-8859-1?Q?u3NAq6aFf1XA95HpjCo/TqDGj1JieA4E1OEaMsgjsVv54vkSCPUKg9Kh4l?=
 =?iso-8859-1?Q?355/AwCMVGwZNdP4c4ySLXZssyg+oLlqM/U3VDEbonRCmlQSjJZxnT0hb7?=
 =?iso-8859-1?Q?+Wsd/GPZFaUp5qy1lAgbP504r1bZ2rIUDfJCKakIODoAMnaeE+mbi2i3SH?=
 =?iso-8859-1?Q?mpVleWWh+4LzJsC8uw1MwNwXTeq0+aWK2Ij/J+Q6dFoj4QEP//wCCjRgiA?=
 =?iso-8859-1?Q?jdP8y+P4ie9zMja4MlYee8vZehm62mrEHoHg10yfa2fNR2NA7bB2WdTPFU?=
 =?iso-8859-1?Q?fJt6GU0VCkVZAlXUrkD+LZO6Q8KxCC6YRlIJpSq/tRonHdiENz4oF01b87?=
 =?iso-8859-1?Q?0PA+MvWov8VE3yqO30mkHHsvTqe1nfwgOd5celahbNeu2l+vm09D2VPqj9?=
 =?iso-8859-1?Q?+1foMsOSXGI6Webc6zyJKjb2tEB1XGi+V8n1wY6lGgNzidD/Iq+q/v2rrh?=
 =?iso-8859-1?Q?hROh6TTvuP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a75ee5-7886-4215-9524-08d9879fd932
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:07.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhPXCkK1eNIQo3ynPUoS1wWxOO+Fos0bilPZ0x6JYzifGvkGlAfFn2Q4rusAMB2Lwt2b3qgC6T09SgTuLBjWXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: Eb954hjrV-coh7NeiumRsqAqt7BCmztK
X-Proofpoint-ORIG-GUID: Eb954hjrV-coh7NeiumRsqAqt7BCmztK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mremap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 160ec0d05465..bcfdabab4ab9 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -701,7 +701,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			vma_next(mm, vma)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -875,9 +875,11 @@ static unsigned long mremap_to(unsigned long addr, uns=
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
