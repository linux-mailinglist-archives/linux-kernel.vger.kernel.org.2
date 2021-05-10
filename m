Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA363794C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhEJRBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:01:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41376 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhEJRAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtC05079446;
        Mon, 10 May 2021 16:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vel1grKY+mnBmydePfSCMnUDMBvWz8VUhggA2cBEpMs=;
 b=nRYv19/drEZQVDrlweSzbwhvgqytT0dZFtXmIxBV57rg36IQVXXWxsHQOvTyG5aqrSFn
 Do24lJMI1QgLM6KGbZuHA5dKXuCeVr019Rkjnjj8lagrj/kFuLT35zy97wI44O3de9hT
 7B0DB59rNNi8D3nHRut99K2486PnwZ56LeTWQQDF5S2DQ2PgUn5bjJx6DKqRSdcu6j6N
 Zjqqw8DWnRDDNlZxtneAnkPiEk2eCz/UJJrvVKN9k1BSyEtVq40bAXj6yEsQxVnXdlpP
 1vY2MrwX05FjC2z3/mcXPa4SDQ+h1RJqobSWlrm8HpUDdL2s6I4OgA70+kP91Vu+oJ1P Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 38djkmbxgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGucHD109288;
        Mon, 10 May 2021 16:58:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 38djf74j6a-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=el6M2e6mJ5+gw07yvfmzf3Qo1MBGu0jiahU/eMY60WMn0kVEVH5uGFP++wyg8qmo7asGfq2ONXtWWGXo9pllQ6clMwuDovKN6Qb+iLdVBw0sLEjN/eUFYm3KwMJd4wd83w8z8/egVkIeaCoWUHJ8TYuOEvsN9AXP9oYYFsbEbKgHD7DzXxFMIum0OL6HKVM/Khud8xYTN/5wn5dIuBAG8Ry5esd9Q+qvfwCZPYdmDGaESiUcFFp6DaOUF81Wdt5xAART9hvc3ETZ/9FvHSl51s4zjMNL4qyI3ldO2mR7DC9GokHJJCXI8kIOLbsWDld6A3LhFlzxiCEXEUZAYPuw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vel1grKY+mnBmydePfSCMnUDMBvWz8VUhggA2cBEpMs=;
 b=Vm19/2O1FXTOD7O8HgFHSv+4OvJElNmkUoYLw+VajCNZLCCccvq928DuZIOd/2mWlvpr90lwyfIs414rGDoOTundidJAZz+Mslk/h1MBnTOUmixygFdtwdlB1EZWtTaP8TBMWZGApRxPQZaDicNnZ30mtB1QrKoqUzES3JHIRD5meLiO6A9Kk1G7SwF9KJKP2SQ+Wcm6lum7JiDF+LnEDBwGxIbBEwdO8Wl8ylG8xW6yF/bFZpSsxyBmGsL0Wr/5DcPyDgCdZtlPAWuhzICJfvKamvEc2dK3wjvieA9ezaUoRpSTH19TLlep9qwxhy7/e0n1kciI6DcYadvbbOcVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vel1grKY+mnBmydePfSCMnUDMBvWz8VUhggA2cBEpMs=;
 b=fI1axQd/3K6VzmhsOeWPJsVpVEEM7VQNre+wyFVvT71x9QPcb1hO5W/d40URLR+9heVzAEzX/VE6LaUeBdSVdzHp2FqZ91vHM2sEexOtDbWy05Zx/nBF3Udj8/7/j6R25mTbUQI85OLWG2EWXy9bzYraSi5OdUdfqhWqmd+JRJ0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:50 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:50 +0000
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
Subject: [PATCH 04/22] arch/arm64/kvm: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Topic: [PATCH 04/22] arch/arm64/kvm: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Index: AQHXRb3AFIxOAOZjwE686fVGtsN5qQ==
Date:   Mon, 10 May 2021 16:58:50 +0000
Message-ID: <20210510165839.2692974-5-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: c1429fdc-f1b6-492a-4b3e-08d913d4e2ac
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB47690486EDE1BAE05A1E995CFD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SKk1FImZh4MD6q9CMDw7Y+uJ/TkmBTdpZi4irB0YbnCyehwpYqSNl7/Q6myZ0Sna2iXhC0suUYYs2kYHzyjvg8lYKd0m2ifOrK1Y2iUtYFjq/6mU7QsUaw4rRPoJRADGSe6o5IsaKi3EOBUK6ZomR+sALg/cf06qbsC6MnN0K/EJTXyt13PAkrM9kOAlx9VaJFX658ereNCnc7PMa6TMvftOe/gmDV38BuCeGVzD27188mvt0Uk+VUvyk2xB6UodbKz+0WOa1bAUyW33aauU6Ta/T5JQKWJ2HpHsAmBZM+/qkJ8uuyEUWuAH5pCLYoM5bbOi0qYPJSXcBSgrjbwC7H7meE+FFymgymy0/4XbuG1w49WMWRwZZzsMx0Z4SN1Wl4+48PiASUOrKjOH7UYpZBci5aG7Wm4ySoYudUyxNurXHyfPfUaEhQa05y2D0khb69lPLdw1mr8oZbKdjNc5w8hzm1hVScOaBn7iYguxjYHUHCN7cGL6ZBS/MzeZktdMZcH3QeXvbKGLwHKRHo0f/2hh5/mz4LyncoAmhKDuWtWJp5FlJvKy3SSfWnw7GuZxRKPQY5L2C43TbP5/Z/Tz+JUBEt6NgHFeI3DD4TCHJ5s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(4744005)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?8z+Wv+1W4/C4n4WF5Y8fBUCIevUyf5pABL85X83Fe+x03RNtryVlo1IlJo?=
 =?iso-8859-1?Q?DhvnzfLyM320XExd4B+T1im4O9ZmSaGA99HD0w/9iM6Buo0FW+l6Za2fxP?=
 =?iso-8859-1?Q?673jz8BTTWEEJ1Qelsy/93pTGfcxTYWW3dYIvECfjH9vnkyw5sxgB3jkne?=
 =?iso-8859-1?Q?Q3v0UnPnysEFfl2E+COMGgVzWGqf2LoFq2aczY+m1Gy/0wKYkqvwOo+jhA?=
 =?iso-8859-1?Q?rWBJjXK3bgAyuDiy1dA/xF5xFuDVdmQUYoCI+rMMqkOdbs9IGlEXAL27AO?=
 =?iso-8859-1?Q?dnbL0yPGkFlWYTwCU/i6kbIgQR4vJYIFV2ql3zIt+PDvRUqdG7hgj1G6K6?=
 =?iso-8859-1?Q?kVNDCHa3kyv/HcdM/9p6h2FBjM+OVEw5NRth5LJZs1IpfX5RK0n5k6Po7l?=
 =?iso-8859-1?Q?U0KoVh7pBBYWz2YUR3Q4/xeZFFALhW/UnmEIsQH5XKiLFhfxZ0HGmYnZAl?=
 =?iso-8859-1?Q?qx+t1PXBwmUjpa2tWKOOh4fJ32r4gpzTGUSYMfmoe8dAU8ZNXNg6hM+ukQ?=
 =?iso-8859-1?Q?I4EjTAndRdhGl2Ym1AEqa/6ctUUIRmrkl3FbcLa7Q+eiyBxTpHyErNdeCG?=
 =?iso-8859-1?Q?vQNyElWOaDTPdrrdYLSWzeJfxaXdrh3k5CWgYJQQkiLA1d+hgWtiyq2Ww2?=
 =?iso-8859-1?Q?HWTUoK9ZAxQNFVn/3plixxLozxT4WWWuTQiWQuXoMrmm8UIx5E9exMVqSB?=
 =?iso-8859-1?Q?QFSdhZ86KF4+Wt+7ll6ssuPXnT75TTbMe7EsJcKKSoK6AWvI8nS2Xb1I3d?=
 =?iso-8859-1?Q?Kx66xMTeOI7MkfHHKJcj9xh+cOrqgtHum7SbNpV/UTTMqnU6K8BxzsxXSh?=
 =?iso-8859-1?Q?7X0+4KcUQfHEWvouuzF9FAluy86Z6ZQlWfshkeKHvntO+cuKzLENGcnjL8?=
 =?iso-8859-1?Q?Y7sWVUknsN7I7brBsNQXLOf3eIrAxWB1XlI69MxEHzkRR3ynFnLSgQbeKW?=
 =?iso-8859-1?Q?e1P/T0P02MPjxQhLDPWLHf7tkC5htvFZwglcbO5ob+5NEfskDteUl2cALk?=
 =?iso-8859-1?Q?Sfw+IzPKXYFolf94XO2+shPryYI4Gpwlph5o04MwCmyzQR78Zz7RoyXph8?=
 =?iso-8859-1?Q?1CRhGY6/3F8QWj/PGJIJfvAwFu1eBlrh8GLGSrzkQk8tlCIMvO8s/N8MeU?=
 =?iso-8859-1?Q?sUvXUBQqu5UoQDWuWvmrgudcAMGHXCykQ2UxGwmS+8GrKqFbgNWC6rsBEm?=
 =?iso-8859-1?Q?5ltgX8wrakd1eaYBOECO0pz+uz3mRgnYs5fUAJfg9ZSTE76MtPFy/xW9Yp?=
 =?iso-8859-1?Q?8sO5+YUN75HVdPSGkKSMGy4j5ieOmSbjghiMnO5yo8GORfSQIegz168TB+?=
 =?iso-8859-1?Q?9Cc9spxUd8CiyM5aWFvttu0QH00/cKinWfbd48dFhOFtSpP5Da1cMK4rMW?=
 =?iso-8859-1?Q?Yxpmj24iBM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1429fdc-f1b6-492a-4b3e-08d913d4e2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:50.4913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vf0Ylo9dDoHbCY8wfSq8QyTYVmVAHQNpjKVICW70InW6UBljYabNtixlXyw7kwTqUL+vox2Tv03TJcgxv1Dw0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
X-Proofpoint-GUID: -s-4LZ7IaJT-CYHX9ly2eUnfk4eVre-z
X-Proofpoint-ORIG-GUID: -s-4LZ7IaJT-CYHX9ly2eUnfk4eVre-z
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() finds the vma of a specific address with a cleaner
interface and is more readable.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/arm64/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c5d1f3c87dbd..8b112b594e09 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -855,7 +855,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_a=
ddr_t fault_ipa,
=20
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
 	mmap_read_lock(current->mm);
-	vma =3D find_vma_intersection(current->mm, hva, hva + 1);
+	vma =3D vma_lookup(current->mm, hva);
 	if (unlikely(!vma)) {
 		kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
 		mmap_read_unlock(current->mm);
--=20
2.30.2
