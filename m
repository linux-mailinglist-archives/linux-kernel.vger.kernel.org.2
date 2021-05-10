Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4993794D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhEJRCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:02:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44998 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhEJRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGseh2166732;
        Mon, 10 May 2021 16:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Zqxb2cFxTIuhrAq2EyG8bEJh8QYx00UhYFb/iehlgaM=;
 b=VXg61sSfeUp4vwMMorIczlG0RqM8892Vt7RuEnaOnw96Zp8yWCW7YYmu74cCHJmuzGKD
 V2bggMLQl/tsHu0XD7ZgB4JIlBd/vp9W38la91/uQmsP/x1atOcY9BEzbak4IFuphwkK
 vfrYTQ8dB+52kim3S+4v2/qBNNMWnHR7U58FQW8OJ8QCL8NSwVfZf9BK58Z1lU63dIUX
 +0tgWXlgWyN+srSWDivU1k/Zy1kq6XPbObgjDXAhALLCJGzuZJT1WirhVacUvo8aJ7zt
 nD6ThyDbTvKX5xaQ1LY5mqa7NPYgQLo1Kxpp4aZDzLfIER0CNDPEg8+v2fTgWP41c7j+ Mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38dk9nbx1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtfFi036499;
        Mon, 10 May 2021 16:59:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 38dfrvs50x-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrN85OgrX0McIMmnh/ZL2sIuZqyzqDCpsfEuOG469Co2Y72PMTcfqeobAcNf8sbOnig98OmkT1T8zenf2hzsc/XijaLQGnakQLtZ9y5JFj+edropwP+mr3NLvOfc4DES91V3OdeO2lT1vpTCYlovHBa6HIX0SBuIX8oC4U5VNmxrieYJLnScbh+pskuvme9t4Oil3HaYtY+4Cg3FLiGE6Xr+aV0jSARXhDUrN9+PrecCzJSfWvE2VTHPVNd6fuqjed+QH1nS6n0xpey96fYYeu824YuN/4v4+Ctw4bhpZsJHAVKYxIDVhZbhkF4tR6SlC1d20/8NDEX0QTcpHMCLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqxb2cFxTIuhrAq2EyG8bEJh8QYx00UhYFb/iehlgaM=;
 b=eFvCF2t0Hbgj1lWIUkmSWbbGhBlyxqCReCueyaMr/zqPoScUyvtdmpOlsL3FI4p4t85GSEfdYXzJwQOBxPRvmDcdMJduPLsp2Es/IcPqOwBwrCDVko68i6hH/jkNR4YpuKuSJgpCBGtN7Ot33A71PVWgHkRK7Dzax8XsF11Ismr6DcOWXVLH1SbA1kxDRL1JqjbRdratxyx1mB7ROZCswDn+DgzF43pn1LShDYsuU8lWona2u2UJRUKDWkgpIZIYqjKLfaOdoiAotsmyLGHxea9HHf/7KHnY7AzicYNeFb0KUaolPgC05mxiMCgLhm4YqCHZvdt4JPZK2a4hnsm0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqxb2cFxTIuhrAq2EyG8bEJh8QYx00UhYFb/iehlgaM=;
 b=lv6v65lkd2b13De9NXYjMxjEFuZGPozD3UfzV3jPZjm7+BHINgm8X9h6EPiD0b5LYkWiI3YP2MfGLwcB+vdIOEM0B4uKayQjthP9b+ggRUgaMQYQL7E+smeASqPG3qhpd0zW1oQa94MBeQkZGQSuaVSO7xCr2vk+ln0F30ME0qA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:55 +0000
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
Subject: [PATCH 13/22] drm/amdgpu: Use vma_lookup() in
 amdgpu_ttm_tt_get_user_pages()
Thread-Topic: [PATCH 13/22] drm/amdgpu: Use vma_lookup() in
 amdgpu_ttm_tt_get_user_pages()
Thread-Index: AQHXRb3CHRTl3bWZtE2E22oEkj7W6A==
Date:   Mon, 10 May 2021 16:58:54 +0000
Message-ID: <20210510165839.2692974-14-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: ef767689-4547-4eb4-b98d-08d913d4e53e
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB47696FAD35F6380FEFEFD134FD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V+hx08OLPPsf+XDLObZM27t7LLJUTC7XASwt4Mq7PSwsC4PRa7r8f2OkhfDbVvdS/gY1z0ThcBTm6Z6Oko8jmVJTYF53YD0AHf8v/m5PXSDCz8rV+Oe0xZJYtbrNNe4TpA9Q/yZT3+Dsd4DzkMASQFD4/y/U5IVi+bRyBAPWCoG582bxbwMWcvmQE/2iTPcZ2qb9fQgDebaOEVTjAxQmuSyLafUVhLXO3zDMhCnyUuP5gF9aOlgWchJdokbzEevl+NF1VO5lU6OSZEe8179wmwLW411A8Hliz4LQXScbhmLAcG7QzTj2fKZfSRYqmNXk49ghJCstpMFMYWWK1iCs2A6VCGhLOoTNm43kabAR2tzogbpTJmI4oMI/Vp72kMBTtdEbU2AbTU3AvGTk3E2+9e9Fa3WJVZ9JNl0uPqZpBp84FiBevS5JJCrP3gXDIRKijp9/UEjXIFlKNsKRiH7GHG5A6mSJgA75sSb1yuZPLX+lAVZyxFqJ/n8XY/aH/aFHwnjYVRo5ATN1U2n1EqRSP5aVHwhekGoTTw919xkxmTISqqci1V0L9amBx5y5yk36do0nwN3iFqIYpcKTn5sbMk5+SLTP7S7N1KTfjYDXZxQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(4744005)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Fgr/xhJJY3VeiPVyo4aQi0Wi6M2dMFoteWIniLZjyqqP6RIoJS9XEgTXMd?=
 =?iso-8859-1?Q?DFwmLr2MfjZou/hjmaDrC7Gfyo6fQ1AIUiT1VhXR/ZzOLiq2TUkSlu6tFV?=
 =?iso-8859-1?Q?vaesLaS+N7m1LMX+cc/r2moGpBskoC9+ikNL3Td37a443ah9pawhHgkkNb?=
 =?iso-8859-1?Q?6hgVqkfZERJx7XuGclYIYkstlnpwrnsb9UPUhkS4vGMFrmu/Hr8GnV2fxj?=
 =?iso-8859-1?Q?QsDpOR0lyXnBKt2wMaOO7np6xG1r19WLBD+bSSFPGi4/VwVm4YdjpjvTss?=
 =?iso-8859-1?Q?tQlbUnL7SuSC5j1Oiis2qErFjD0vmRrUfhImc5S5u8nqfv8VGvnW0gdqTh?=
 =?iso-8859-1?Q?pkc6jO6Wla49z2dOnlnOn9GbMWArc8b2YAmlBFqH+u9ZnUhOIJseAy7YIZ?=
 =?iso-8859-1?Q?ftwYGwY+35giS7437HrNJEAok8zt9EOdl15iudF+7deY0UwJscRWOtSsuq?=
 =?iso-8859-1?Q?VBUHPV36uUt2WN7orL9DvtKpvIcML9QENaJ4+Yq+74SVnwl1O2T/hsxvkj?=
 =?iso-8859-1?Q?RtH3Mx2gEhwduUhCj/Ze//ZsKwQgoU+0zYM6AdghyqDEuSlaBVNh/ZRagN?=
 =?iso-8859-1?Q?jBaq0IaJVzbr5k7qFEUJoA+i3Hi67WTiBo+YiXPf28DjDU2UBFsM2KLrBB?=
 =?iso-8859-1?Q?drPwtpmoAjfaADfvOqiO8uekeazaMqOlQqWccGMFlz3f1jRlS2JGKJbOtj?=
 =?iso-8859-1?Q?YErlHkcccfNZuAByPeSbTw7/Adl5wDRJYGk0vUDb+vWjgLm7gju6dBzcuD?=
 =?iso-8859-1?Q?XUn/wYLSEbeXkbi1qLCRDi38ByBC40jbmPun/KwXlUPC7RSjEQjJsFBvbt?=
 =?iso-8859-1?Q?FCOhFF6z6MJn62yyPfmRWX9bh0Ep0d7m1PV/0hjDkMKeoAlUIHa0Xfs7Ga?=
 =?iso-8859-1?Q?ZkmP/CJnDjjeY14v/CCMAU4JcmZXqKIWEu2r4ydmj3f8d015tgG1ZUvRCg?=
 =?iso-8859-1?Q?j3DJlWehVFlV4eqIM+IaMIuxP6n4YD9CkKCjLLyTRt8lQyDoLkN73etR1d?=
 =?iso-8859-1?Q?GzTAagFJ3Xecv03a719Ti0VaQZ0g/MymWosZ9bE0t5nAIIy7ONYxrZ9r+Z?=
 =?iso-8859-1?Q?ACBSGt58PnoQ2ETy9l8eUL9j+c2sM9pzfVF7YtXJeRI0s/ZjOflCPij9R0?=
 =?iso-8859-1?Q?jZVNoZhN6LFc3IYqzOwetamhyyM3KVqUn+cXe2KIwCXTAAItEVgOg/5jAi?=
 =?iso-8859-1?Q?KGtn7RcK8WufLI3eiH2vHuXv5Je6CelVBDUtojuLVi1N82tf49oMgkmfnc?=
 =?iso-8859-1?Q?vdHroKxtkMaGdItBfbKr3jt15ht/QYbGx7E+5+SYwvqGVK8YNT8gmm/PKY?=
 =?iso-8859-1?Q?JhJMUYVzITSF3ghAUzLP1lkyY+P6o22MnzZzyqyYjjyW81cuLZgnhY7FtI?=
 =?iso-8859-1?Q?SRjQEiUErc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef767689-4547-4eb4-b98d-08d913d4e53e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:54.8693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TUI/yRsow7XUPneHWi4aX+Gy6fTdf/ZIUF/wdfcJwKQddJWugbXsJeNwJpYRAC/wsc+ffZJ59i5sogrnxBCTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100114
X-Proofpoint-ORIG-GUID: ai7x0Sg_4PF1QZU-LPhom2h14jms7HLu
X-Proofpoint-GUID: ai7x0Sg_4PF1QZU-LPhom2h14jms7HLu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 3251f6b67e23..00b7fa8b953b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -694,9 +694,9 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, =
struct page **pages)
 		return -ESRCH;
=20
 	mmap_read_lock(mm);
-	vma =3D find_vma(mm, start);
+	vma =3D vma_lookup(mm, start);
 	mmap_read_unlock(mm);
-	if (unlikely(!vma || start < vma->vm_start)) {
+	if (unlikely(!vma)) {
 		r =3D -EFAULT;
 		goto out_putmm;
 	}
--=20
2.30.2
