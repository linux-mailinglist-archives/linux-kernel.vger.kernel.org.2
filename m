Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0705938CC9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbhEURuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:50:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42890 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbhEURte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHTNlY111598;
        Fri, 21 May 2021 17:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=z2tfkgM0PQ/paQJLRkxRCpo5oWhKGBcwdbpTTqHOxEI=;
 b=zIKGHrESm2bOFaVIAW+945UjMfbzdW8iYGt9nRkVxPcR0/hGtP7bJuwT7v9gFFTET+AT
 NDh2u+a0N0i4laUHotiWgTg7+hyBEukcX7EAgkkyH2ltxfQq9WMWL+TMfMYRclGMPbGu
 YMw5lkJGaQSnivJehPuLZ+GneZVCQrhm4TRpeavfYQbmZz3UhiKwNMMK4nVsFQZi49I0
 jWnahvr1cu7RUgPCOuK3PdT5OSgpGsJDOoJzKiCuTkcdWbEgyScsu1pE8IXNH0BE4tdL
 otVmmKLoslCBlO+21dGai74DeoXfpkNt/+Tthm4gZUNLs25L0wl4+sxCCl8PyZ2nQH4V Pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38j5qrgcjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rU189475;
        Fri, 21 May 2021 17:48:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byYeQOYkA1UhEaJ4mJ73HtO9Eq8w0uUTCP0XeQH/IeFjWjz9ek3SvVjUaop5pc90OXm82rOzAlRCviB3SQ8bXe8krlmA5JXSBC1iIMYJwvfv6syfR48AOsMwPxRB8O3ShIyMAgMSlS4XTuhgeCVSkA2qhUPb5uJT5Je8fty8T7HJorIhRQfaHSSu/KS8ZBEEiJM7Tg3m7ABX8EyOsxSRCWV5mExkYyOY2sEA1xbosUFs+mZ0IK80SstGhSprOO4Li+c49Ew0Jr+CzosM4vG84FL8NendilhVCwBkrnkpUzGFNJGcJPIczEoMAo4TsY0K+KAnXskdzMbM2pItzaTZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2tfkgM0PQ/paQJLRkxRCpo5oWhKGBcwdbpTTqHOxEI=;
 b=SYG579h7XpvgHN0FAed95Nvb1GMVAKWP7oAiYEMPwt58O6mrjiDe6VDAZQDyhtkgGxkP5QjNUGUw15v6vTMDiWI/KxTy515xam3FHComs7EB98+U1TveWQd/bN/mqrHg0R2rkGyV/PYl5sQj4FpJSQLDLPWuhmlA2nrSioQz6f+JHLrAdwp6HD/x9jmu/r7J6WJ9l2gbGRpqKn1wwxZBnDyW7MoIYyckOi3X7fbCSj6vGWjqog5lpEgmOw+0BSALn3rFc3QJfRZohsuP7SWAWwdNQPoNtqlrRCD2dl6rw29wthOM8+je2/Dsopieax/oPXflYfSC8Y5qdlJNhAYf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2tfkgM0PQ/paQJLRkxRCpo5oWhKGBcwdbpTTqHOxEI=;
 b=moN0Ovnm/L3s+HixWEdkLyXN1xIlYMRe/GvLJNEBI4bnlo9Xw/3URU8ffQllCn2nZkvEmzfSxlzTtgIa6ZOdIrrj+vWmA8RgPj52SaMqT5P+nOZxgdVCbjokzVWcDnYUEIajWZ94LCiZpHq8eSXn8BNg+T2WlozuUmxMwrjj9TM=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:00 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:47:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 06/22] arch/powerpc/kvm/book3s: Use vma_lookup() in
 kvmppc_hv_setup_htab_rma()
Thread-Topic: [PATCH v2 06/22] arch/powerpc/kvm/book3s: Use vma_lookup() in
 kvmppc_hv_setup_htab_rma()
Thread-Index: AQHXTmlwKcyzyEjyV0mq5w5T0BOckQ==
Date:   Fri, 21 May 2021 17:47:59 +0000
Message-ID: <20210521174745.2219620-7-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 4b7c7d4e-877d-4ac3-8e92-08d91c809327
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4467C0F3D115B9F12DF3169AFD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CbymDUtRRie18LbzymMWKdcWHABhohNPAKdiXXPbcFk78tInOH0pB9wbhS3rizB2rLlNsA07iB04BJpdcWgQm1FFUndwgP1lXIQkUrXaNOt2lP5gfdud+egkZn2mmo7tgiwJXbgOXmUK5qK6PVmmlu7qnMV8rM4IwkkzmbX2ZYF4xUl7TlY++xLEB+6ydlEQYyav3BRrSUSBux3K/9e6RLsAIYk1Rr0mPmwkdKmgF4cWYsbNDA9sZAogLfuv5tYNrYOhaPtzkjK2AfAUH8MykcxG383GHOM02JjYLSJLUJXJJpnSz54QYjMymuYX4RzyiZXT7y2N35TCSvZlOBEmyzPDciOOuQeelyGQik4lMr3UNmu0z12x4SxHubFiRZulMlbazWa13gHcyKgxG5+AvXBmUPqalNA6CE+NV3yJ5NFxkCU0z6MbM/pyqWiCTHL+SBPcXNS8oLidPLDnKOKHFNS1XTc7umBZhpZ/G88H6k27p2b81J+olg3Mhi3pN9FAlPn7TlGLwjWFuV24qYKXYEVl0yOhcPBs8AemP2bxB66jWcRJlC7L1ebsy12CS6GuFwbchX37wV66vtlshqO3vbm20WoKR18KXyI3d0aU0Yo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?wLeaML0/x307eSyzMZ4jJBaE5aBuK5Y0Pa9vBTpO8z8xQVEok/4kbuBqKa?=
 =?iso-8859-1?Q?5gWRWUsS9+zCw/mogQkpTMO0DIXDS74v0zV6vNb23AV/dOAbMMkB8QL8Fs?=
 =?iso-8859-1?Q?K18v7tHIaHvp4WYwXGiZe5Ld1dsCZDW1FoBoyO3Kfz3T/y6wKEmfMq2I8Q?=
 =?iso-8859-1?Q?TgY6JbFvYe9o9e+5fCj5zVHYx5WyU40LqjHtcn4pg9ANpzXbFKKrAxrhv0?=
 =?iso-8859-1?Q?W5y3JPntoTDxw5cyERWnJi4n7LiPB9ZwD3ad2k7ZwNr7lfsZmkX/OXXe1U?=
 =?iso-8859-1?Q?ofLneDgt4Zh7ovi9jL9B5edfBjjTA/0ubPYnXwvQm2n2D+0s5B+ESVfApH?=
 =?iso-8859-1?Q?mGLjyRDTeM0souuYB3xow09RgFMqYTZ86wySKNpqmdJmzfD6TlsZpnYFEV?=
 =?iso-8859-1?Q?CmZ34kClX478ixdKfQ51+az6Jx7Zi7rt7nWFQA2PWoddex2WXWS+Pkce7C?=
 =?iso-8859-1?Q?BqJntCNMw9TRaP0exgdFvGKrRagDW701EsC8WtfZNEyLLDYm7ZQR1CFCqI?=
 =?iso-8859-1?Q?9uIXhV8rLZT+4h30s9EpNdjmziRCNYX5+SOSMVyWbnk3lKG5Lws+xiSTjm?=
 =?iso-8859-1?Q?5bSBKTk6aipO0xENNwZwhpxZByaqwkAzr2HDKzSiUGX3t5dxe33H/1Hsc1?=
 =?iso-8859-1?Q?69A2XH/g/HeWQIEPPBA7axtQyL17QrB3hKZne4bQv83ul2Hu8WImtb18Lb?=
 =?iso-8859-1?Q?FhmifX54c9oPW5pOFXiBNqWF7PMUVcJ03NLcARLCzIubFYFXF2Mlw0b+3e?=
 =?iso-8859-1?Q?YZgvdB3QxlDWmOO2Zy/4SWeSzF/oyyWcT/LCw0LNcvHrpyHNxx2nQyP9X0?=
 =?iso-8859-1?Q?nQ4NESrFKyBbG51nQ6nQdqTG2ezf0Qoolp/KRQZDvbvC7q8dlztoUAozHv?=
 =?iso-8859-1?Q?cGZG2bBKYfJ5HoSsUD72wgV1+BG+/F5HyVAkb1vL+TOeK0VXEjBia2gl2E?=
 =?iso-8859-1?Q?J7zg7uLbCo5Mx/uXkRtp6BTUFELfyI2raf9Rx5MxhVAItPrtmEqWCb5HHf?=
 =?iso-8859-1?Q?ahbB1xErsuRbLQuJlLN9uBYeowQYz2rX76+LLiRtfd4qEC05IR67bSUOLV?=
 =?iso-8859-1?Q?nVL+xUZAyXz/Bx7xjVu2d9y8DvRyvOh1cVOu3uqnIbyXy20lewuoN9rCTw?=
 =?iso-8859-1?Q?SO6fScGX8uc/1uyHBM7j1Y5KvwmylA5dOZUlUk9OgfJfA9SbXkI4Ipuy2P?=
 =?iso-8859-1?Q?CCxuW1a2XY6Yxmm1zlK7mJLcY1QLhi6TFB3LvK3dtqHYvtn3JFi8abPfJe?=
 =?iso-8859-1?Q?KO6hth4mQXV24kE5HKi/edTXz4mP5g2qvPYnJT5zfDbgnmTMTUM3yjylA0?=
 =?iso-8859-1?Q?p8ZdSMiucaFiNuuSP+5pph1wSswdPso3ptPYbefI3V09TU9FXVHfl2BN+z?=
 =?iso-8859-1?Q?vlbvcmSsRb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7c7d4e-877d-4ac3-8e92-08d91c809327
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:47:59.8951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FD49anutFEgYPOgZXoRrfcLPmu3fI6FFhx8g8MPKeAUnUnfslohrXOXtVhrPNoDDyeySIAIvmLtQOsdRnkIZWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-GUID: LcEwBTX-z_EjQpE8FwmDpeo8WLSucVJu
X-Proofpoint-ORIG-GUID: LcEwBTX-z_EjQpE8FwmDpeo8WLSucVJu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vma_lookup() removes the requirement to check if the address is
within the returned vma.  The code is easier to understand and more
compact.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/powerpc/kvm/book3s_hv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 28a80d240b76..a3a4b2179350 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4759,8 +4759,8 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *=
vcpu)
 	/* Look up the VMA for the start of this memory slot */
 	hva =3D memslot->userspace_addr;
 	mmap_read_lock(kvm->mm);
-	vma =3D find_vma(kvm->mm, hva);
-	if (!vma || vma->vm_start > hva || (vma->vm_flags & VM_IO))
+	vma =3D vma_lookup(kvm->mm, hva);
+	if (!vma || (vma->vm_flags & VM_IO))
 		goto up_out;
=20
 	psize =3D vma_kernel_pagesize(vma);
--=20
2.30.2
