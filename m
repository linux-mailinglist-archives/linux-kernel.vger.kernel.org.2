Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E117C38CCAC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbhEURvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:51:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48592 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbhEURtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHTWpO143201;
        Fri, 21 May 2021 17:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yAHmawXHHZhyg4eaH7gannff4WLph4NaPxHi7T85bjI=;
 b=CDkjI/u/XaUTDrlsltb09jph+eJOO1PxDHbB7glq7YEFNBFw/I+9exOaW9SvNVOlv9pr
 jx5hKcc5Np2pHsaVbiWvzwgAmXL0Apa8S865u8LmAw/JeORboHNHUhn62uA9B6RbKSya
 0aUUFPbcybjxQq1Q7jZe5LhWkE9wdOmrHbHQk3yY2EOXZCHodXY4pZE8suSpP30ee5Oh
 Y6KmkpXMrQ/LuywbM+b2UW8wBWTqj5x37RNGCweHWRLJnKr7SjmXtJSYvY3f6PEvgLHo
 xFO2+RUdZkjD3LCfnlAfGQpm5OOkWg0a6YDMeSNkxOjmMESH4wFi+zNx96IK8jW0D3rL EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38j68mrau3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHjg55188662;
        Fri, 21 May 2021 17:48:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by userp3020.oracle.com with ESMTP id 38n4930d5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsbQOFq87F1MZ6+3eQlXXX1to+uQ6htycAz96JncqiM0+3Kma+UY5ZQMgdF08pM4qZXlLQMtDynrOQNomVU7sQ6jj4rBCLmcXOf1XcSyib/w4NBHwLMa6iSwvblH4eF4jqG2jIdS2v22tMQTp67nSDoqYWdv92SaiAGyp0QLI/ItVhBlhpja1/6E5wnvk6YqQcHuHBGAvcdY87ykRs83R69jOxncme2sw3PwJkMJaFmRn3KgmmViH3LzD7T5OZRm8W9T1iY7ZJwJgL+lFl4b8oj2jtjeXbxJkZjt43oc00hOLB+k3+fIw+XScge4pojTSZALmZb3gwD1DWl5oZdikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAHmawXHHZhyg4eaH7gannff4WLph4NaPxHi7T85bjI=;
 b=lv7OOPmg/VA3OjKo9au3X4tG+xynogOAtBWMWtTECOuHWzlUL/vhig49m+Q4dQBHTFuRuoNxcSViMfqJh7EeMWu4MImGeXD4/POvqNeVZUxasmXa8rIhJjgsU+oHpkn2tTztP3v00QRgKnGS9FXQ/u69qsQ29eHl5l2rDkpu4mhxYoehWGpCm1FRglpaWrn0+K4tiBrHvaxpIICXCPMM/GZA8S68yjyc2hjIBSNvZvxWlsmU3pgzzTVsQtejXsVJPaJsy3buLZuZS0FB3RNiiWIB7tY9mMPqdLa+mHLccykrRiN6sYAWiNnRev2OaiK+ARx4vRC/eLllvn/Eo60wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAHmawXHHZhyg4eaH7gannff4WLph4NaPxHi7T85bjI=;
 b=V5IJSSK9JIW+IU48tzYMUpoLB5rPLOUw8cRZv4fcfDhLewoud5tpN5OKMxmn0+zWH/7cIdp1AiX41zWjgBmu+b43RhK28kyTO3q1/s8mNRCHW4GspuXLmvHLnMzCE0yXhCL2+k0lyzU6LCwH54Plgk+6qlqez2Xn+JrXKONI2Zc=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1646.namprd10.prod.outlook.com (2603:10b6:301:7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 17:48:09 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 22/22] mm/mempolicy: Use vma_lookup() in
 __access_remote_vm()
Thread-Topic: [PATCH v2 22/22] mm/mempolicy: Use vma_lookup() in
 __access_remote_vm()
Thread-Index: AQHXTml1U/H7DqcLG0KdTzmBiADS9w==
Date:   Fri, 21 May 2021 17:48:08 +0000
Message-ID: <20210521174745.2219620-23-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: d55f9754-814f-4ebf-de4e-08d91c809882
x-ms-traffictypediagnostic: MWHPR10MB1646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1646D89535C5397465CFE288FD299@MWHPR10MB1646.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jdLQ/kqpjDy2ObNB2+vGDLy2Di+igRqlgoagiLsH3yyKV3Vx/tGpfkc8d/S+Cf+1nWXtB8G/hJTylYjwL29fnV9ba4PFq0vS41K0ZchI2KPEFTJN42R8pu8QOYelEKUtC0PSJFgjEUKaxhApaLJs2uJezUcukyfMSWbJPgjyC7S8dKxCoRasbLpShOmnmdVLrvv/T8yj3Ik7cAECiKc4Ch7TkCcVoM/hnxohMXZW+HTkzFaHMgiUfZIP5CP4tRVsMUGrHulgD4us88pBRbuPh9EZthhmRi4WBIE84wJzPW0mhQfn6F5GW1n5Hz+AzzH8XMJodK+stiZ5wXnDXHMm64oB6voYbR+1Esebyyxm3Ag87LC/NF0XVxIH+WM3KktkNka/jZ9+TYP0PSxPr4JpXWJ2lm2cAKWrJNwjW7hG5i2TDArN83KEGYAfpm2bc2ImSyhquWkA8knnslAzH4yBH+UiyCwVf34wSKKRW9ONxkWiG019nyPVV9gC0FdE8iFkuxkC0M0G127TjdGu5F2vYd7XcmAjhHvreSJKmsH5u19ZtmS5aW/EecMrC/LIYiiopxFg0tjkrkDHcDJVKQrcAKCCPKxKRBSUgjCu2ghKhq0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39860400002)(71200400001)(186003)(4744005)(1076003)(36756003)(6512007)(86362001)(26005)(6506007)(122000001)(38100700002)(478600001)(83380400001)(2906002)(4326008)(2616005)(64756008)(91956017)(54906003)(316002)(44832011)(110136005)(8936002)(107886003)(6486002)(76116006)(66556008)(66946007)(66446008)(66476007)(5660300002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?e02tfTwxvGI6rXITpDDrWbvt2NEvQgzxM0GEcd8PcZHg5WXBvdVX7hXdYn?=
 =?iso-8859-1?Q?EjJdpSDLg7ormooalIzxr/77JQlaj/L2y9/AKC1U1dSOSbicGhA9PFf7nO?=
 =?iso-8859-1?Q?0AZ5hqUunzXzKeLQFfQrtsAasZo0XyfykTN4LuDSuLtMBbALSUPBH6kByQ?=
 =?iso-8859-1?Q?YD/Nc9uUnmsUyovy5EEFFYVvrFYnCmrHimE9FO0dfx7Fe/tSyo6JnkaiC2?=
 =?iso-8859-1?Q?JeshAwNyg2iNWyy7PuGhyWx0GHbn52oHQ0T/um1SbDIle4KZoMap463Mae?=
 =?iso-8859-1?Q?KaMvs7yHGTjKd+9ZFuQkXO/9sVZbX8gnaSu5jbuCp3zdXDA9UBpGkcVQZj?=
 =?iso-8859-1?Q?PkkPLZBkb7FdG2uuxNPEOQ1XNXoA858ivtnoykZuxlQ656Zt3zEJ34DsCy?=
 =?iso-8859-1?Q?uA2Rb8MDA+1QdzzX+RpDjO31DqqqyfFBzT/mDu2CfMxHVQxklRj20oNUvd?=
 =?iso-8859-1?Q?q13EMvPkxcRNH9KSouo2JX56ZRjrqdjrYlJ0Uz8yWdK544SOvlrdsL0hNR?=
 =?iso-8859-1?Q?imYHNngX8+VTazL8480a5pJzRyngYXTwnnqQlp8UIOxUjWctlCDOyJqaHO?=
 =?iso-8859-1?Q?geEQbqh2PbwgoLHrqu0YJT8eH1uJvw0YqwjsobtUy+46GrWLLWyjvBx5iM?=
 =?iso-8859-1?Q?IWjyFi4tP7TPvbmiBbfYevreJbqCbIcb6qyA0wghiurZbx0inyabY/4xdI?=
 =?iso-8859-1?Q?QP9O41USUKdXiSf3y9XvQ6WgXzBsqNLTLcxpWPOet61rBQQF3/7DNInfDa?=
 =?iso-8859-1?Q?jfmQRirsYxOLDtDEJBjLczEvYszjRS2s7ViLRcpr4H3oy7069kycMVSveg?=
 =?iso-8859-1?Q?s7ezQw9xPKP1cCHfbUV/+gncJzj6nH+huQx/5gtIgPJNBsiEBz610xjuLD?=
 =?iso-8859-1?Q?bHjNVq0rn7NRwyKTeDt9BTHLWYK2vAXQy6qZA0WeDy43rEUr4Hu98c8uV8?=
 =?iso-8859-1?Q?+clfXc5X3WTiChX92vak4DUdkOHnMl5gxVAXlZmfQfRq42rW5ijv5B20g5?=
 =?iso-8859-1?Q?YtJyUfKxyOpVmU/pD+rrIrGLPsKzohlYcm2jnbsWCNkwTxssFZ05p3w5ft?=
 =?iso-8859-1?Q?AETmlL+sK18Ulujec4n/yIqilQBLFOecBlEZCwdhHYsfkJIvc2vzvgsBHt?=
 =?iso-8859-1?Q?zxTKgvsJ/7wX5qtmwyDMIN7i0penhWPEmScvbfU6vUIh2zR+55KF/EAwzp?=
 =?iso-8859-1?Q?RdOL3yJWob8MKwNL+uTR80p8SF5ZfVx3jPWy8j9JEFuLEBjbjEazzjzXer?=
 =?iso-8859-1?Q?gF+kWMaBGgSiwl7RRr0up3Xt0CrJVRXSNEtrFHDqW/S0ZCI8CyEItZlQK9?=
 =?iso-8859-1?Q?aNM4CBwrIkx5IsHtyKQAypctaVYgl3WP+AEPgy/ofskOEHm2CalGrvAqAo?=
 =?iso-8859-1?Q?q3lQZ1yqkX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55f9754-814f-4ebf-de4e-08d91c809882
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:08.7591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+iGS2AlCWizoVe/GLY567Ft+IazO0qR5ywKmKAJRfjGbCUVe1QOYeQIzPp/qD4fENcvDRPPQkCSZ3ElaDANDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1646
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: Dh7-wWtAP8pIm9uIuv2YAxLeBX0qem1L
X-Proofpoint-GUID: Dh7-wWtAP8pIm9uIuv2YAxLeBX0qem1L
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() finds the vma of a specific address with a cleaner
interface and is more readable.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d79fa299b70c..325771bef5e2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -975,7 +975,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *n=
mask,
 		 * want to return MPOL_DEFAULT in this case.
 		 */
 		mmap_read_lock(mm);
-		vma =3D find_vma_intersection(mm, addr, addr+1);
+		vma =3D vma_lookup(mm, addr);
 		if (!vma) {
 			mmap_read_unlock(mm);
 			return -EFAULT;
--=20
2.30.2
