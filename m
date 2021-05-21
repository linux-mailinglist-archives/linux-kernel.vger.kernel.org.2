Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8F038CCA1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbhEURu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:50:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41998 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbhEURtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHUt4j083413;
        Fri, 21 May 2021 17:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dG4rB7Q6+xdaYIP9Ci0V/p7hh0+fXgGvEi+Ph7JmgPk=;
 b=KzHcd5QRuUjggvMi9mY2rKXYfriOGy6usQ3fn6ua40zuQPmsPWDtMnSahwQgRTSF2ls2
 gm4Ib2aYAQQDQMNEDH7hDWo/xNQVRv2KQ9PnbSjBXSRKHUpqUADWRin6nYiyEMiaRcct
 ta5T6/e8S6cFYT95aJenh828UqE2FL22fhb2AJek/DHNcMQFLTVz8hl9/9J84E0p29m1
 cA1bmDFVI7gOjIB5TPVp41wakQ87ES9qZF/xkpjpN5sW0EnLaOnWmGCvyhJ8VS8Z+Txb
 3fNCAdNtFqkxj3dpGGHtRIAE96XmXtFodYMX0Eefwg8dBZ1fIUxOIDkBqalwpzxZkPyO Jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38j3tbrf2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rb189475;
        Fri, 21 May 2021 17:48:06 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVFX7B5CILUNguPhxVDN1UlIzTujkZbWelJ4d6YTHEFdu4Qk4qXNSk5HZ0hhtWOk9CXcW4I6UZvezVIPDbWwvZdno7RwtO8Ilo4KapqaIeSD3fqc7Ys8MAgQrATRdX8CEeaLo0Yr8IS+3IAbfG90KE2TKG80WAInG8jdVQscGLAdzyu2v5YwYL2/wF1j/Jd2VBmegfK73q2fg631IM44Rapcu6l1oaN3qUaw4mjS4gCP0JzhH8pDDbn+/IyJA96zrzgjfxM6je5t6aj4UHM93vJf5TOvbRyeIkEC30eoBaW8Nd1Bt/w9H2BVJ16Vp7VW5FBRktOozrGqvFK4Rh+RXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG4rB7Q6+xdaYIP9Ci0V/p7hh0+fXgGvEi+Ph7JmgPk=;
 b=OMCyBJcneiMS0vImsHCARHC3CWFektM/VyPjXWCsjb9VDUWWpJLAJ6TU0PjIxCo3dMDI7JyGYx5pEf8+Pd4jY5QiBOFDXPf35a5806LPx3N3TDlJcirL4Xb1hw17LtCHm8h+AGFWK7FhBeNG3jWx4EYv9kUl/GmOqF/Gy0V08ofl8ZsBqoBifjeTNr8HN3FUUedDaJfjJ5wGmZKBEZQdcV0gl46S5oxlM9ivGo5GqhBPuSna+It8bCwWmWUnObJ35+jaeWplsF2LuOynPI/OI2h1d1xVpISxrIfZx3G39sIu1PMpWokfcIg1A9q2HQukv9YymUHWORU00zZQLHVjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG4rB7Q6+xdaYIP9Ci0V/p7hh0+fXgGvEi+Ph7JmgPk=;
 b=iLdGfEauFKCcYgmwzCZAybQchdsZLzYS9YV9k8PaRgghhupivQDpLJBLk7ceOPG66AvXTHJtIj/jTz0DsaZU7+jEZ1pBFeJzWBaW8MRxAFQ35/sVIy9ox43cKXsgVH36aFPosX3if1cJJM1MK+aYg6gn9+eYxy9j5pnLsGoB7qA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:03 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 13/22] drm/amdgpu: Use vma_lookup() in
 amdgpu_ttm_tt_get_user_pages()
Thread-Topic: [PATCH v2 13/22] drm/amdgpu: Use vma_lookup() in
 amdgpu_ttm_tt_get_user_pages()
Thread-Index: AQHXTmly/Ik424K/xUiYiqjNqb66cQ==
Date:   Fri, 21 May 2021 17:48:03 +0000
Message-ID: <20210521174745.2219620-14-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: d884d12b-b46e-41a1-26e5-08d91c809569
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB446765B1F5223F83F66A53DBFD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5tfFt8nhQIfNOa4rW5r6r1RWfpfrmFifcuTfw/Mu4DEpfuH9BTbEvVUQmOxewy+CeqkFOOAOUP8sHERvpApRbdoM8HdVAkWB07oaeSWePgWyq88ezY0SJkvFwSICLPYgJoCoDlr8zOY9Nmd9oQjk/X1oEJ5Md0o3KqMp7GVLpLjfCz5v5BBNaoa0axhunLd9moj9Q0jla456YHlO9z0A3WB8bjc+noBdoDWJfOVtzzKl7iXLE23u4GLunSbCLGKbWYJCdMQpe5f8zwLR10bAzLDCZWTZTHojbHvB5bmRWoexJvrql8t8peLfA4zEdMyfmI+nTf2bDF1UcYIRdXB0ZXBEfXoCUtobbgB3qhgRbGX+WBA79UAAJjzMpHf5SyLXXMM7fEJklSvJte/ByAMsutTvTGBbWqhabwA2gC+YBlGttCyqOsWSsu30p2HCloWHmIv3K8bOj4S0inK4P5h8u5wm61+U7k6aBVnrrkPIq2lndv3JPkPyfjtVnQBb1idkbbFfOuyIgOmnFZMCp4jjTJQX4l0j4HYgU8r0JAIJr62l0rS2tlA1EVWSpgaJ7exMzEaBUQ3/IOfPj6o3PadXDcQ2NABnMYaFE7xgFLEa5o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?uWKzQOwJJAuNoQqdkNEmPndvZBeL43FuIZFSgzxgQF+giEYSMRTt+KlrFC?=
 =?iso-8859-1?Q?gabajtClTNfUCU1IIvBzqnLJYaQ/rVtFjwgjGgPdHrcSYM+nxjUPt0dip8?=
 =?iso-8859-1?Q?BGB8WIwf8Ib6BdzPIKXCQ+4VggfWYZnBEtIq0jN6ykbcQszm7TWUNEtG/v?=
 =?iso-8859-1?Q?UM6jKqWEUQzNqodObcmo3hs6iwfiwIpxllVYIZMvrDMlPSkux9VsIsK0f5?=
 =?iso-8859-1?Q?I79X8zktwBPwRlQBbnenHvWtFGxm10nXGtwh2karowVjLDmGiD83aWp3Zs?=
 =?iso-8859-1?Q?14r9+Oq5BWBim1a6g99sd5b3koicTDeJvCy12tO0/aioxLrfvc6J2uLacC?=
 =?iso-8859-1?Q?up/tqRgh6M38H47duKYW02r8Hmi6iWVJw5oiWuljULkh1rJFBDLPb83IPm?=
 =?iso-8859-1?Q?LvpG3h0C0s1wTxh/oYZiv1vqUaaz4Zm21UrQW7rs30C9AzTkrOcw9WBIQp?=
 =?iso-8859-1?Q?/uLfdfa1J9PHWtZcm69jw3jg3TXBGBBWY5+83kqOJTQivXhkLMHCjUJs5h?=
 =?iso-8859-1?Q?c7VYuiquizwBzsCZBaXAUs1sYzjjdLcul/Szay4JiT9UQi0svJ7N+20qg9?=
 =?iso-8859-1?Q?s23mqHyw8YUS+W0xAl3PhwYLKAcFTFAT1Ts9LxqyMCfq/LGol/lmDi4DMV?=
 =?iso-8859-1?Q?XtHinR6w8tdQKvaWJ17grjppkPcKVdZOA3LR1l3VcD7ekm7pFAjmvdHmH1?=
 =?iso-8859-1?Q?V1GaRibSHoLspyGGqqS0uh6U2ANZCHeMrE1rbTJGdB2jNNknNU3r5XwK4k?=
 =?iso-8859-1?Q?cdCEic0GF8RaTYm9KvPEBTMZOz7J7spi6aogkNrFgnvBItGJ6CRTBUoxDh?=
 =?iso-8859-1?Q?BMqAdAkmEhhJ62bVMM/JhSOBklk6AB0oIwoRbwpkvwDQXez3U2ZYo09cOI?=
 =?iso-8859-1?Q?94BvzTvsfE4j9q2tNKoo5kFxMpPcCvRXgE1Fb+NMqHq1210mbIz5CyVdLg?=
 =?iso-8859-1?Q?3E7hPWBYHyL2BVFUtpm3gkZDCaxyIo1NL0GuFK6z1HX+bgVoKOYVLXO3bA?=
 =?iso-8859-1?Q?E7a5KFd2b3DhuBOGSg9cAOeXgAgc1tLCV3B8klf9P5oY+f6I3BaorQDTsU?=
 =?iso-8859-1?Q?+43yEFPXa38NN95ylr0/dEGxecejY4GvWNoYB9ZFE/OgHm0CSFcOWukdsg?=
 =?iso-8859-1?Q?QlVjKLEIY0bczF+B9jt8jc99IMnR0Sc/tPZ1JqYSfz2jryo10RKt2FTzJp?=
 =?iso-8859-1?Q?rfZ8B9/TOFmuuJojavs+g/q7iDZnrJAL/3TAMPtog7ebD9ufwhnJvLV6F+?=
 =?iso-8859-1?Q?8pTMFeQgsGWbQvGihbweytYcOsyuFWKZ4I5kE2+aibjqNPCC4Ahyx0k3EX?=
 =?iso-8859-1?Q?UPoyjZCCw1QIfr7yspNHG+vtXm42g8MxhPRYgVBbWQUr7evNZskIf24WZT?=
 =?iso-8859-1?Q?6DfVhoYp8o?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d884d12b-b46e-41a1-26e5-08d91c809569
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:03.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbQ09ZGnlqy/lRPhrvn4kelj7qwvnbn51K0yCcE8jmHPwpCEYJdF0G7kp82JwhRB1/3cC4GHa3wX77N+rIWbcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: azamGkuU_Cy9YbypUGicqWgpUwMYDc24
X-Proofpoint-GUID: azamGkuU_Cy9YbypUGicqWgpUwMYDc24
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
