Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A16238CC9D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhEURuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:50:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42888 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238475AbhEURte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHTCTU111452;
        Fri, 21 May 2021 17:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tuvFEgC1UA7+7DBwr+7+HO2Yl9TiPWNImYF7v6iWi4s=;
 b=U4nolU7tQIWCAB5fsCKXzNFINBtnd1dX1XhzKwSlgb4zD95l2XvIiJqnJW35xlVvoIg5
 vYoFafaEzE3xQIsYxG3QDKyirdNrL/tXFdyh67xlSQu6lM1U9eBrAKCt9qmNxnVLrelB
 T65UdIpDqsYVBdx6FoY82ZMrDDfT1+46tqf1EsrZdGaQyzMcKmsF5C+Y14kENmml4aLo
 KLDo3bnV3zqsk74yXM/LnsISdGQQ6eRjTblAXx4OISkJbpndWv4qxfxyC2BhwKm+dznD
 3dEBa6tUvuNIf7jcZZVipY/QekTBPWPr+EA1Ev7c6JLmYWKF6p2dEBl+6D2TCXixBcWt LA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38j5qrgcjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rQ189475;
        Fri, 21 May 2021 17:47:59 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Axm/x294mwiNJP0ZzFm2ICNO4zvE/MVHf4h27arzyaaeEE2JH9pNotbKh9jTMergIHgFywQ4lV3CyvHRw2B0f1VLpw+bAXnOAk8PPPSalAtDhzuMOSQKLpDQua4HoATAEOvI/W7Z077qvkwOyLJRsE+Sx3G5XVLjNxUQpML0rE5YIw3dKGlPQQTifI54+7w9tecgWZWER3Cv34vqn72XOHpFc1NSf13EYQGulFE0bEbfOl9exOTVfxf3BF9+jCw604/CshFwykTDg4CWfUH4yWzJmLBaoduy9NrLnoLijRkKKSRj9ZXqCZRqhxvjy3znpshSgSS/XDqO0rG7vqIWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuvFEgC1UA7+7DBwr+7+HO2Yl9TiPWNImYF7v6iWi4s=;
 b=S9bGkOL800y4/QyBbHvQC1q7wSxD1VLZ2jVZ6M2JebWV791CLMlBXwgOtv5g13LUep9ghHp1WBsbdFpRERlkYmujk4ggU87N9U27urSdBRUnKnxEMUEHRDeWPRlFEb51S32RM53VQIfBG+wMM+GRydjGegQZi6PHl5KsLaZnYXtwEeFpbjpzRTY0V47/5X/EKctWS68B8Xlhzdf59/cSA76e7ODYDo7Tx1bmBDEDztiZuj7AZzUi6q++7I2Ehf1ub3ww6QVvZkjGHyxPliZVDWxnYLap6UibEp/R8ChCMWc5NzNmfSg7klfLlriS2rOnVAv70BP5qN4Eht5gFSJGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuvFEgC1UA7+7DBwr+7+HO2Yl9TiPWNImYF7v6iWi4s=;
 b=YTweHN5K81Og834J/iWaHhjR6pI6Lnjq/06IDYEyk5vISksSibizx1WxoaH/eWpc7OAcuGSQpUfCtRBT4liy7DIyO22NWCiBukdvD5W0Ru3Tp7bWWr3oHLMn5jzWK4pDsmvCe5b1wfhYxoMzgyIdtvLiYUCNMUeD3qa9ldu2ZRc=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:47:57 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:47:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 02/22] drm/i915/selftests: Use vma_lookup() in __igt_mmap()
Thread-Topic: [PATCH v2 02/22] drm/i915/selftests: Use vma_lookup() in
 __igt_mmap()
Thread-Index: AQHXTmlvYcbZEW/XbEesC1LxFkINoQ==
Date:   Fri, 21 May 2021 17:47:57 +0000
Message-ID: <20210521174745.2219620-3-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 728ab78b-32e2-4bae-677a-08d91c8091c5
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB446750635EE1983A278C4F4CFD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MZyVCPZWiSLvHXJsTzjYQarLmyrFj9jVoxKOtBzK3YIYC4BBCyJHXSPGNc3l2W8oSqEb+Dx4xowHKu1qi9aNgwsc5Md6oHcbDeIHYRrVYJZK8bscnHLD1afyqxU0BOBIVCCJkwewolzXdr2J32m+vVsXS4Ofkm8hGvpvCBLa0cmW/JxQ2xaPYWQvWWFId3XdLteRZzZoGlYPggtXbp+589KHjHQ5Go6tmMkh4bYL5Ex8VGSGM9H8Oj/ppX8KsOeOc57bnVtE4GkEAnsQtzhyDRMavwYM2WScFhtptlD7Rpm2TV1TKBnfzGbHFZEpJSfbjZSLXtY3MnvryLuHQXEullmhjev76MexJQRXu6g2g3lf7MgODyTAawQE+KpPZEqcQB8svKu3CezTv7thr5Mj9LOQ58V9+y2wxJmFITUwkZKwzqqsROQen2Dg5qFG/QwyHvWlqD9zc3ieD9mDnBDyvs71d0LqppUKxlxZIuXwpcypZ7S7b+vPt0/4MDiogvk8vJwGISdvKPdTkrKHLz4+7eD7QUa7KZ5YCANOnyjDLOC4Teg4SgWECAhMTD0HtlHC7swTQNO7jvhIYqzuzmyKZTSU6gLYHthFOy12GcAiGas=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?9b7BqG5TXFf4JGRKluzyMsUl4AxuNut1XtAXfYms/cIGymx0O7BEOyLC25?=
 =?iso-8859-1?Q?cMEWBtm2laMYLA1GQCc6flW+354mKkvme6vJ3wJRK5N1cMdla8lOlwGsiw?=
 =?iso-8859-1?Q?ARllP1xoPAvAtj3L6/l/ZzW3VKkfRfqRusQqTxetIV/YILp2wIBpOvrgX0?=
 =?iso-8859-1?Q?JO1UODqKk8tcP2BE1kE7TGxHhx+QYtGtc5Qp9uZEp0KGZwIYetVFzRwOTU?=
 =?iso-8859-1?Q?Sid0bigi21OMZGoQiGvnyAngUVnPpYxNnliyI0aSOAzcYPIpem8c9FaYG1?=
 =?iso-8859-1?Q?sL5LVbKKJOtDuLV6VPKTO0cENr/GgRPN0KNU5henF6RFjLcrT9MZCTHgrK?=
 =?iso-8859-1?Q?Gi8+ZjAhbGFhVyrSj6+EfIzeqlO4FOhy5M94ZWp5TRzuBBpwFjVtgSkUaB?=
 =?iso-8859-1?Q?xZ/U+5ciVWNNVQ1suFN/sUZ7dz1RK1kWMokl8SkmHGXQTScizWWO0Ps2+q?=
 =?iso-8859-1?Q?8wNWHF64zWgzPWLC8cMLitPLPvr77/94kHeFCTiS+YIeXGoc94H/LExve0?=
 =?iso-8859-1?Q?3EvHXkYGjCHDgvnSfzzcxXE6hxqaITP1A229dgkeOrCbIgMfzvcEMam+og?=
 =?iso-8859-1?Q?k9K72yoyVzkNBQeQAY8sXhfGA1a1vlQODDSLP5gIC1p1yEhPc0VyUETOiV?=
 =?iso-8859-1?Q?9s3rXFNrWP5eickdr3II+Yx2Q6xigDaC1Xw88bYt07B4gLV3r1O9KRoBHY?=
 =?iso-8859-1?Q?REuIwEbT7MAl5Tn0+PpP8T8KrdcvtO3Xf1C98SqYiA8lQ0voQ81hjaLtcx?=
 =?iso-8859-1?Q?HSWqipdgEIdoBGrrUqXA5ZF2IAOrWh3Yn3s5Y0Q+vAbZdKdvyQN0ey29Cn?=
 =?iso-8859-1?Q?7p/bvCKtaWS0gXn1vjYW9QDjj6n0NhGs0pfL8Cjw/f/JtOZV0c/ZEvgn6r?=
 =?iso-8859-1?Q?XtdORrqHjl7s/kxKDjQRAcXNTp4Gl+Y4oNCw7W0A061yky0R1bYZL+Z114?=
 =?iso-8859-1?Q?bJrGaKrUwo86O1qfpKHBOQniuj19DCaaLr9DXXdNzGkHKLOOYf7PsVn4HQ?=
 =?iso-8859-1?Q?abLNRQbg2wdUJYy699e0wrVEfnIJQkTbKrSf2TlUVXmUi0sgSsMUW2N+Q7?=
 =?iso-8859-1?Q?iUJ2HoqjFvw7fUS0G+xPKTeCZqx2zVt+8yBz5rHhLtjmHyN65tENwRh8rv?=
 =?iso-8859-1?Q?mz+qo/c/lJmefAagchHO4gGoHPFR9NoN8ouFjtPiDoB2iA93ChXlytvJAe?=
 =?iso-8859-1?Q?+LMkAkp5YiYC2o2tDrhYSqg1NbuJmFbPMz5y9Uc1BOPrbDWDlofqW1SF8u?=
 =?iso-8859-1?Q?kR5lcvS59XgkveO3aQCMHvPWEB8PmJUMAQ83kfDLYlIlcbJzlhMBdXR3SK?=
 =?iso-8859-1?Q?YzuvUu0AkkUX89aYsbXJ9GM2bhGwpwRBUJTGn3KNDXLfC3bRYZjR0rh2IH?=
 =?iso-8859-1?Q?NhNSDeCVM8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728ab78b-32e2-4bae-677a-08d91c8091c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:47:57.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkk/PHvq36LBll15OOQy8o9EfaeGxZNkxkpycpfL02KjgZcGKJvNl/i75FzmexXt75dIPC4M1IWHlxysDeH0AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-GUID: dBB5Umg8YwT_YQg8pdYVlMUWWMVTm3mp
X-Proofpoint-ORIG-GUID: dBB5Umg8YwT_YQg8pdYVlMUWWMVTm3mp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() will look up the vma at a specific address.  find_vma()
will start the search for a specific address and continue upwards.  This
fixes an issue with the selftest as the returned vma may not be the
newly created vma, but simply the vma at a higher address.

Fixes: 6fedafacae1b (drm/i915/selftests: Wrap vm_mmap() around GEM
objects
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/g=
pu/drm/i915/gem/selftests/i915_gem_mman.c
index 5cf6df49c333..35c15ef1327d 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -871,7 +871,7 @@ static int __igt_mmap(struct drm_i915_private *i915,
=20
 	pr_debug("igt_mmap(%s, %d) @ %lx\n", obj->mm.region->name, type, addr);
=20
-	area =3D find_vma(current->mm, addr);
+	area =3D vma_lookup(current->mm, addr);
 	if (!area) {
 		pr_err("%s: Did not create a vm_area_struct for the mmap\n",
 		       obj->mm.region->name);
--=20
2.30.2
