Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4513C7216
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbhGMOZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 10:25:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10362 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236857AbhGMOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 10:25:02 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16DEHAf1006828;
        Tue, 13 Jul 2021 14:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Crv9GLm+cbHf1llhm0IAw7ok5elJUrBa2cLYuPxPQus=;
 b=Q0WDXIjvpDamJ7Ezr3cu6N3MYM88gFPitCb9lTpvLnrrZoUkEzAj+9xBf/SKwSniZHq8
 BXE8StFjgEkfSJBWFhn8en9jSV7eTqUovZQ2e1Hmx9YZpbGjIXihMKx6/X1D1kLO+T3B
 ZZ/DwboRZH1coBO1W4w27Iaru1VPDM5VIzMi6bqZBkaip2ekJtZLw4RfkgOsUfbd81Rg
 KSp5cbWaoishHZ5Zc8l4jEHPMeQXhfprBoTDyXlsfW6eKjUU4uyBUR8W2K0ltqULLVVm
 0n+Gfz9FMH+P0MsQrMtLichKUaCle54+BNt7fKwN1EYGKj4AzOnZSHMgcVKnYqtvNza5 kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rqkb2ftu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 14:22:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16DEEhVh050594;
        Tue, 13 Jul 2021 14:22:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 39q3cbeyx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 14:22:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMUuNFkP7HshS+iLGQQ0YKAeEAZn4lwfCfQIucZUlMvwcIAxaWIZZ7tGY6/XNsSMpsEIQnk2gwf+n4x1G2uwxRgLR5mELJOmzaH7SK8orNzgPRIJfDTuDy7jqa1JZqMZ1gcPixQXPUaEdyoiKGt1B1yY4o20U8/dYHJHhfXCfrz7/6nbDnOTMp8PterXHv6Ufhv1UrYeuKpSv5JnKW1UzZwCMIC1j0f6c545BEVGTqUudZfWbYWkUkCBQdOMJJQTr2Q0G09sXsdRqH+6+u/lHB81MHB5loefy+AzgWuKAnP2+E7UXIul1NxKY6k1giiSiqvDrPjzcYVXU3byVF/lUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crv9GLm+cbHf1llhm0IAw7ok5elJUrBa2cLYuPxPQus=;
 b=XCXBswwvMO7NRDli+mo5YCFTxWnVIjeP0oDqF5Vi6yG9Lx0ObKWDLB73q15XMf/E5rPglrARm5wbCLffl/mrsI2ADLlC2tnq2tqMsa6YUB1gp3lzlL/HqlpJSO1x056MlDqZ0KYB7yeoKZhYwCuty9wHEafnkPPHxq4xs4cBqpnNvLVKjDdd+v7kBdGeTt2G8PnhHr3va0itL7STlYa3bXoyR/mS4dHC8Tagy5opiMq1sXVstsjTQVSlEui9W5w/xssrQJK0Oq7W4oapoEGB9Op03qHO3OU9E+oQS7e5+Wauov9ittYPlw36yATiZIPhTkx6fD6tndzyXsPzLnFE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crv9GLm+cbHf1llhm0IAw7ok5elJUrBa2cLYuPxPQus=;
 b=MRCUqnPnpua136T0UQOTjYKt623HLF8ltNNyvA9PyBo1/UXrZ7uejWQ9D3JRpJxBKEj+r/cdR2XoO4+deA34wQZWD0tXpxggIr5e2S8/Ahp4r13C5iaM6mqEdCFVBUWINuLd6WKxU74CxGoOwltQa7mROQS3NglsR46LntAi9OM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 14:21:58 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 14:21:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Zhang Qiang <Qiang.Zhang@windriver.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] mm/page_alloc: correct return value when failing at
 preparing
Thread-Topic: [PATCH 2/4] mm/page_alloc: correct return value when failing at
 preparing
Thread-Index: AQHXd+7xOOwL13NwHEq2099ClUljlKtA9QGA
Date:   Tue, 13 Jul 2021 14:21:58 +0000
Message-ID: <E7C50307-24D8-4D75-B65E-0D7CA7C08048@oracle.com>
References: <20210713135625.7615-1-mgorman@techsingularity.net>
 <20210713135625.7615-3-mgorman@techsingularity.net>
In-Reply-To: <20210713135625.7615-3-mgorman@techsingularity.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: techsingularity.net; dkim=none (message not signed)
 header.d=none;techsingularity.net; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86e796b5-6f2b-4aca-1b68-08d946099304
x-ms-traffictypediagnostic: BY5PR10MB4259:
x-microsoft-antispam-prvs: <BY5PR10MB4259B329D6BF858EC985755E93149@BY5PR10MB4259.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elLzDKo55UgjCsYU6a9TFAn2OwpPaewlo6kXCiCfR6iGt8oUJ9IxW9LmNFw/ckLU4ulMzKstGktD2g1j47Wz3NBkrabRIXHxZgnVkQci34vaU3fjjtokrJGdncjFIfGH7aDmkXvni1Qln2P+p3qKaXLe+3To8kS4fMzZDM1VXu1NFV1vo+R2rOB7pCgdWTGtAqnO1UHLDwS/2ClUYYAvGUJfjjMPXGy2h9j6dKWGiGyAPk5uMW6ynDNR4NDm2Y+nz1Lm5MWfmFdn7k0f1/zHvChaStDbVE8uF58eBdlncrep3TAK/z+5OGADbI63/tbabJCA4pD0V9WSKvox+nRs1wFDqNlly5WVxT7XjRxreMI6KzEdbKVc5AWHGQNaamBtlZNq7S0yi961WgxPGXYbXHaFh/z+XWxc69rLQoqiTIvUEecfEPo8jh8EjIdwl+E+gZTZU7zfiAv9lOgzF9eVx4PxDkzcWiI9wJIzLbCqcvLyEEYYfbA1rVA8td25vz9zmvjaepLXiOhH3mxzqHpCC8pXYEujVvQis/DoijtD8zrczI2XiEl3xXHUmih0XbbbFNRHINmGHmTp+SMJ/tsow8XRIvXmkSPgJWG73s9dVvqLQew0G7iPMv9jqh2HakLNir2n23IK9UOHv61qkmp2DbnB7m6I6xWeMlbDOkkDQYL7EmbpAYTCDmlQWUDRmycGD3CcdDoznF0U2Ng3Xqh5AuVTYi2IOJD+WygWFmZOPx9aZZ7Qevc9zPVMsVWX25UvOkl6Yt+jtL47z/tfoHfSFbI/rrOcw8NUhi1lBmCBgok=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(346002)(136003)(36756003)(186003)(316002)(83380400001)(53546011)(6486002)(66446008)(66556008)(54906003)(86362001)(8936002)(91956017)(76116006)(6506007)(66946007)(4326008)(26005)(5660300002)(6512007)(2906002)(966005)(2616005)(8676002)(71200400001)(122000001)(6916009)(33656002)(66476007)(38100700002)(478600001)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vQNzZbhQU/2KmyStpDFsrjwEMEEzwheOC0WnD7Ba87VKN4fkSeNF0KM+013T?=
 =?us-ascii?Q?vKKDAs3FApGR/zCHaXPcw86dme1PX0tYvCHJoyi2bBDz8ZE7t5m1El9zQeFB?=
 =?us-ascii?Q?f3vvlySuAfgb3VTCdXkrd5PY4t+uupNqqoUgL0Q5i3aHo8X4wnYOYX/G/wvU?=
 =?us-ascii?Q?aDNQXIcRa6jizS21rjfEZ0BY3tvBLK2vutH0utNZzmR3QCl36+ZXVAdY9dOG?=
 =?us-ascii?Q?l7Sgciyny0g1D8mNmGgm4JIB+9wUPvkfGkRdj2L4fo2juapGsMGpa+WI6tOz?=
 =?us-ascii?Q?VTKwgkwcXYaV9bEY/UdDUyM8ICmxoG+b+xLxA0AXOUmiHjc6adDidf+2brlL?=
 =?us-ascii?Q?8PSqTRXUmUBxHQ1bLFlxdlRVnHe8asVDz2KT8UavgOKVbuEB6/s72FWyN9UE?=
 =?us-ascii?Q?eTeMe9FI0qYgaoXnML10JujAVWS+9HR2TDFzp4eh+INQ4MTu+sdUuD+SwQJ4?=
 =?us-ascii?Q?y7YJm6MafxGYlGaU+vzZqjteRN1kaYxZ+UhhNijP59GSj5aY3OxDnnRHk/av?=
 =?us-ascii?Q?MwDmRh6q9NpxqAs3aTPUPq/K3xb+aF2RFXNhgU2RxH8Pn50EIy6leUBJwE6/?=
 =?us-ascii?Q?iezy76Umzu4sRj7K3q5rmLKPLPzED92fol2TvFQV2QROdGLjo9yvw+Pq1GYh?=
 =?us-ascii?Q?nxqXpFh/pYASqkUUkTL5W0gnUTTOwBKWca+mhG5QGOONdZvNVPfll4pu6QXR?=
 =?us-ascii?Q?Yej/OX2l8tXZjXJnT0rNGbyZKHSUwD5umzUdqLQHdmZ2i/wbzK3zxZBfS8hb?=
 =?us-ascii?Q?0HoVv60dj3sCIxa9qgO6yh7pUWDMZfR+/quxY6mdTL4fEqgp1q2qIhxEgd/z?=
 =?us-ascii?Q?Tgu856U+kcexFdjY8UULiAaujG539juTVn2y060CH7Zh4Xwoq8OCdL/h8ybl?=
 =?us-ascii?Q?uCrjMdP/YsGL9ZLBA9EsBmHU1Hjzh3eSvza8xbaJuGFst7kdXggRgD04BcLR?=
 =?us-ascii?Q?l64Guk2dT/CcjnWetiVIm/dWbUhVS66HX055sfleTu7j5qJeuJztH+ZaHdL3?=
 =?us-ascii?Q?FL2z6AfVTfNdNQJ6DNOOvdNjYdipavRX9t14xJ21gdKryB7sgXKWOqNhbQu2?=
 =?us-ascii?Q?/w7N/vij4fYGFZShagwKocwvhuxnGJsrkRgwcIhNGKxvj1wzwTqCnCW+ddQq?=
 =?us-ascii?Q?vnrWmIpEx+GnTwI9LgwlpD4MAJPcwReH9Ax02yGixdOySOwcbAnUVKFlpT8g?=
 =?us-ascii?Q?ybDJWgzfEPKybLktnr/i7X3CPpavVlf/H8GhVUn46uEWTLNUUkIgrhqsaz8Y?=
 =?us-ascii?Q?WUvOA7blnEWqomUIgVOZ5iw96DSM9Hwgo5BTQiJGBEzkmLhCyvEKq2gOzeo7?=
 =?us-ascii?Q?0IaY35+ExdMoTOtXlZcY9knN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F434093B0E30D94C97F6F43BAAF4A65E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e796b5-6f2b-4aca-1b68-08d946099304
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 14:21:58.2933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HlCbNiSBlzBVZ8/6ZgRFLUDXaZKpDnsEMYzUj3bRukEUbrzw+dd0wBsnITJQs5XwJgEz9sUMPtxxwtWTCnXaEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10043 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=943 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107130092
X-Proofpoint-ORIG-GUID: MTaGNB5zhBmbhG36pjrJtYkTZMRZJNy3
X-Proofpoint-GUID: MTaGNB5zhBmbhG36pjrJtYkTZMRZJNy3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 13, 2021, at 9:56 AM, Mel Gorman <mgorman@techsingularity.net> wro=
te:
>=20
> From: Yanfei Xu <yanfei.xu@windriver.com>
>=20
> If the array passed in is already partially populated, we should
> return "nr_populated" even failing at preparing arguments stage.
>=20
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Link: https://lore.kernel.org/r/20210709102855.55058-1-yanfei.xu@windrive=
r.com
> ---
> mm/page_alloc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6ef86f338151..803414ce9264 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5255,7 +5255,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int pre=
ferred_nid,
> 	gfp &=3D gfp_allowed_mask;
> 	alloc_gfp =3D gfp;
> 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gf=
p, &alloc_flags))
> -		return 0;
> +		return nr_populated;

Can you restore the hunk in patch 3/4 that changes this "return nr_populate=
d;"
to "goto out;" ?


> 	gfp =3D alloc_gfp;
>=20
> 	/* Find an allowed local zone that meets the low watermark. */
> --=20
> 2.26.2
>=20

--
Chuck Lever



