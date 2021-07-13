Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C06F3C735A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbhGMPhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:37:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50282 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237060AbhGMPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:37:40 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16DFVcrm011930;
        Tue, 13 Jul 2021 15:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RAHduqLyzwqe+xyRdRp4dxW7LRacuFOUK2aaw4cnrUA=;
 b=yL08ZLUXKSYrlmDjqXaOgCWoVpL/sqsH9n2W2QCge5JDeCzfvi9UAgE7FEKZ7q4MiJui
 fx3kp+OYymwZZghvKbjwGr6CUl4XL7tB4+/D9MyyDjphQD9tbpPqKrKCRpsKvvtG4G0S
 4H8zpjhea+46fVwswMGJlrT8hHdaoc00hEFZCYFbNionLavb9pDTB732pQwaIBK22iW/
 oXaPhw+iGvV9qsFlCUKCwzD6j5H9b+XhrIyiFAu9zlTgmiHBiqmWjlC+3dOBb7SrTX+d
 BdbTV0zJhAfL9+Pw1Kveck6xUaUtxxEZeMiDlDzhwGvhucAjdRtMd1B8SoVsNBy+FxVh bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rqm0tpc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 15:34:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16DFUfZE157543;
        Tue, 13 Jul 2021 15:34:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by aserp3020.oracle.com with ESMTP id 39q3cbm2wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 15:34:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHo6Mj1S/5aG36w7hWdKzsi9/wbkvd15OQ022UPO6Uehu26zvXw0x7RzHdlBeQ95EZXgChZZ2n6iR4fPKC3JkUYhF1qQ95AbTZTyydIlrvg2ecaPU5E+E5R2wk0EZnnQ7LzGqZ8nilZ2sNNvcrxwmnF4/w6gTDK112ks8AiPwbaPgqumeK2281WZaMDUjxJ5o7Ve+ccdfSifUKnflf2NhxIi/G1okBpOIxWPa3TT1KdwQaMk0+iRJ/gdq0zTWqsgSh47RgQY+qbteClNc+hSXqEdrT0aO9+VPck1u1b6JoO74ieYHmTSvwq9pl+PouZi9IQzfTaMWq4EzIW40Nc2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAHduqLyzwqe+xyRdRp4dxW7LRacuFOUK2aaw4cnrUA=;
 b=cnFfWiAiH7yz1mVu3/o6F2fBelPRYe78fmLi+CF5m1IEuPR0I6KVlLSdBFS21yZDlT+YT2dYop0AXg/sgQltozxY9oM1THc6eBxLlSRr1CRGzLsHjrVfV3ODK5v4rk1UagZf8GRBA7NMGzLxUy1NfzQ0URmYS59eVOGqpJsQ/OWFJhxY6F7QUntzXMQibC0w9WTyP3ch5DMBJknUCj9BXEjRxK+t7eKhE3GwTFjy2bCVLQN9JEXzT5EEBWVLjp+6UESG5hOvJ6q5Yr0DqiaiDlu3on0r8vzSuE1RX2XqyrNj9j8mQtfVZmOJ6GAy+eiRMam7sSsBml7hAl2mx9RQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAHduqLyzwqe+xyRdRp4dxW7LRacuFOUK2aaw4cnrUA=;
 b=mvbiWzb2nGkaDwjIshG0uwXyCoSC2300WMHQgazQoaDUGUon6ms8Q6hrmWxSK96L3E7AC9BkL9DphS/Gn2+TNgZbSUC6xx6Y+18h4UcuhfcIWT9SQ5Z7/pSDs2AlDu3Y20QgpbiVheH1ks8xxHo18DJKpovX9Sucw1qmXTZvOWE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3718.namprd10.prod.outlook.com (2603:10b6:a03:126::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 15:34:40 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 15:34:38 +0000
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
Subject: Re: [PATCH 3/4] mm/page_alloc: Further fix __alloc_pages_bulk()
 return value
Thread-Topic: [PATCH 3/4] mm/page_alloc: Further fix __alloc_pages_bulk()
 return value
Thread-Index: AQHXd/q0wkVPyeiXDU6Ea6+AzorKHqtBCTeA
Date:   Tue, 13 Jul 2021 15:34:38 +0000
Message-ID: <CBDA966F-616F-4411-BCA3-F497ED79DE34@oracle.com>
References: <20210713152100.10381-1-mgorman@techsingularity.net>
 <20210713152100.10381-4-mgorman@techsingularity.net>
In-Reply-To: <20210713152100.10381-4-mgorman@techsingularity.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: techsingularity.net; dkim=none (message not signed)
 header.d=none;techsingularity.net; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74cb9f88-0216-466e-d48c-08d94613b9db
x-ms-traffictypediagnostic: BYAPR10MB3718:
x-microsoft-antispam-prvs: <BYAPR10MB37185F834EC258099D7AFC6893149@BYAPR10MB3718.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UximIVGTr24C2bPAslTizw6kP9ScBJHsaU1AYlVLMsekxOJ/6ckEFhPqodo8gHZf9yMQdwTOh41LZSjZ1AadmE2Fz/+HrE5P6r1OIXX0J5cpOgzYqfbRLc4S7/NtJxtjhfh+JdvnWX+3YimKAQ+WDGRzQ+/wH/V1kkTgnhihjWeIBiPQ+d56/lR6lUtGsG1X0RIz828jJnn6LTVN+gUkTa4km75ecU7vvUJ2O0oek8SaRp1z/I6jWzij0PBfyC3jMO5qbodFLV4CYmpGdwpS7eDrcdnU1wuE/ParUCzGo0W9aMMv4JNdZ34i1WX+/RRYwxxzo+UkqjYFLH1kSgmRzm6/77/UHFzLCDnfEmi3Uwf3zQriZo21dOwTS7RrIqC+uzRp1SznYgx14UiwJLOKqvEJflTJFvgfCjZRsSb0bBbLRD3x0vHU2io/3IUhYn06RSt3LGtxu9F+mL+mmwP/JeWVvo0eWhnrOe6qY+4/AsdufwgtoLjK5p1E2ML9K+9zeYxgFk0x1AgX7s4vYFsocmAbAeF7zYwgJHJdX2RIJ2eCsmyXyCUVdn5UczBIBO06Z70E31A4ioWtFHdEVZITAoHshCpP1ooG2e4hZIKrw0cK3Uf1hhuiOVhWKabo1wCGrGx7+y0riRgSltWgV+A9CTD+7NSq9w1JOfKACume6SAceGLrV4Ylyccy7J7akdZhds6mAWGicJlbOI1+cnJfNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(366004)(396003)(66556008)(122000001)(316002)(4326008)(66476007)(64756008)(66446008)(91956017)(36756003)(86362001)(186003)(66946007)(83380400001)(6486002)(71200400001)(76116006)(26005)(6512007)(53546011)(33656002)(2616005)(478600001)(6916009)(54906003)(5660300002)(6506007)(8676002)(38100700002)(2906002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N/CQl4jtbjCXe5MJj5QCjWuHFBXnyEOZOEU0wHNMgyf7p+49PXkcIYQWghv1?=
 =?us-ascii?Q?Kw7AASyEoQwIBoSD3gTLULNpax/Zarz2Y8AVbAzIax1EnlZjJPx4/AJtNvYN?=
 =?us-ascii?Q?rtPGVVwAmezbXWSjPfPncVf8ocGZUMVSXlAkuY1csHhLuKFC71ILdYHhNDCH?=
 =?us-ascii?Q?xHnD9WuUWWzNp2o2jYtIUP+LooNTms69EMAb6x+vVzNVdU0Q9C+/byGbiMrw?=
 =?us-ascii?Q?loekKt+YH8xbrDYqdewA97k238UA9IiEzR0wyNn0zJJRloNAU1roTqOZ7Fyg?=
 =?us-ascii?Q?JGxU2lXBWWgrhYba6IYItNsxVtIeEVVGZ7mpzMRkWBm1bfg784yOovLNylut?=
 =?us-ascii?Q?Xix1YzAOQbQEhC+oGsYvf0n8RXW2ppSuo0tsDuVo+kADZrufOg1c8QSPqwEf?=
 =?us-ascii?Q?cU/t7Q8MqFS623bSmEr/poxISzNHLc9hW+lqI/YAwFxRDOa9u/F6Sx6ONR0h?=
 =?us-ascii?Q?Qr5jpzFl7/4Cq2z+sUhZyPdcHc0kEij/k+xoFXLU8xIYNfp8XEXXCOhY5Rlu?=
 =?us-ascii?Q?e+hdoQzwMOPH9960HSFIyYX+xvbLnPp+c5pdK0awWfOi0CLVwIkilB4s+N7c?=
 =?us-ascii?Q?TFvkULxMkZDWdcXNBocFf8EbgDj12CaSHJY9GatYDjr+SXM2SDFvu2KI/ETx?=
 =?us-ascii?Q?mhyNX0UnF7HVDSl4SDNKtWZm/J4rE22H2A1Pocp33Rrv/5HvkVWe76ZT1gQS?=
 =?us-ascii?Q?ym7qFUAN8IhOtAeP47DgTTnwfn2EmWnYYqlftDBmHXsrVicY18sj2lBu4Ky8?=
 =?us-ascii?Q?BgU14ioD/MtOF6UTAJXmx+lOhUQvRMjePabjRJmkwBcOwSiqZcxrgRYUiDtu?=
 =?us-ascii?Q?E3mYAjloJdLghFzxLDoTdEQH8aOuGwlv17XFalk4362e/T+AyJXrMc9WPNbr?=
 =?us-ascii?Q?hzG/adDxSM6joqQUL/I3eKkgvfYes/sEBXpIvMJ76mV/JLvmOwuu3VVn3rQ/?=
 =?us-ascii?Q?HyqPZ6T8Go9KWyM/cU/XH8BjcoY10rJV7C8eVJoupFiuMdzlEiePVErrM6Br?=
 =?us-ascii?Q?DNIBAeVyXg1QwaTgzCfG+Zl6qp7nYAsMyqxQgJt7i2FOvCwJLhTVqhmKN+m7?=
 =?us-ascii?Q?cBt1ZnkQXLRG6sNDrC9Xspo8rHIbEt6xH7dKzZS+oUfwyexBQLeWYaXJQks3?=
 =?us-ascii?Q?HBi9h8EzMObJcQ5pZQFarL4UA+hrdufjzTox2Xt2UqDwtqmIoKmpfT3fW1ut?=
 =?us-ascii?Q?W8U78rsH/O9ib1xCohTV9PDD1Vnj6Eli5J8ulHX8VUMFe+aG4zrF+pt9q2WJ?=
 =?us-ascii?Q?GMxbDTKbyPEuI/frLUgXYmDd4dMoOuzIGjpSjTPAvHKfdSUbnfF9dD0q8pOU?=
 =?us-ascii?Q?HDhKs2TLaUawXUU+ka3wjWGC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23168954393DCD4C8DD900A4C9B0FF64@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cb9f88-0216-466e-d48c-08d94613b9db
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 15:34:38.5144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvSOBzTBR5A0PHOhSO/isW7iFv3yfcVF74LtypVDus3ZWhyvsOnB2/FDwXIhksx4WtlyFJ0fNjcgjBs3SZaWqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3718
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10044 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107130099
X-Proofpoint-GUID: fhZ9DqRFWW_MWXiQNAn3avpr0K83b0Z_
X-Proofpoint-ORIG-GUID: fhZ9DqRFWW_MWXiQNAn3avpr0K83b0Z_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 13, 2021, at 11:20 AM, Mel Gorman <mgorman@techsingularity.net> wr=
ote:
>=20
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The author of commit b3b64ebd3822 ("mm/page_alloc: do bulk array
> bounds check after checking populated elements") was possibly
> confused by the mixture of return values throughout the function.
>=20
> The API contract is clear that the function "Returns the number of
> pages on the list or array." It does not list zero as a unique
> return value with a special meaning. Therefore zero is a plausible
> return value only if @nr_pages is zero or less.
>=20
> Clean up the return logic to make it clear that the returned value
> is always the total number of pages in the array/list, not the
> number of pages that were allocated during this call.
>=20
> The only change in behavior with this patch is the value returned
> if prepare_alloc_pages() fails. To match the API contract, the
> number of pages currently in the array/list is returned in this
> case.
>=20
> The call site in __page_pool_alloc_pages_slow() also seems to be
> confused on this matter. It should be attended to by someone who
> is familiar with that code.
>=20
> [mel@techsingularity.net: Return nr_populated if 0 pages are requested]
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
> mm/page_alloc.c | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 803414ce9264..c66f1e6204c2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5221,9 +5221,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int pre=
ferred_nid,
> 	unsigned int alloc_flags =3D ALLOC_WMARK_LOW;
> 	int nr_populated =3D 0, nr_account =3D 0;
>=20
> -	if (unlikely(nr_pages <=3D 0))
> -		return 0;
> -
> 	/*
> 	 * Skip populated array elements to determine if any pages need
> 	 * to be allocated before disabling IRQs.
> @@ -5231,9 +5228,13 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int pr=
eferred_nid,
> 	while (page_array && nr_populated < nr_pages && page_array[nr_populated]=
)
> 		nr_populated++;
>=20
> +	/* No pages requested? */
> +	if (unlikely(nr_pages <=3D 0))
> +		goto out;
> +
> 	/* Already populated array? */
> 	if (unlikely(page_array && nr_pages - nr_populated =3D=3D 0))
> -		return nr_populated;
> +		goto out;
>=20
> 	/* Use the single page allocator for one page. */
> 	if (nr_pages - nr_populated =3D=3D 1)
> @@ -5255,7 +5256,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int pre=
ferred_nid,
> 	gfp &=3D gfp_allowed_mask;
> 	alloc_gfp =3D gfp;
> 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gf=
p, &alloc_flags))
> -		return nr_populated;
> +		goto out;

:thumbsup:  Thanks!


> 	gfp =3D alloc_gfp;
>=20
> 	/* Find an allowed local zone that meets the low watermark. */
> @@ -5323,6 +5324,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int pre=
ferred_nid,
> 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
> 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
>=20
> +out:
> 	return nr_populated;
>=20
> failed_irq:
> @@ -5338,7 +5340,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int pre=
ferred_nid,
> 		nr_populated++;
> 	}
>=20
> -	return nr_populated;
> +	goto out;
> }
> EXPORT_SYMBOL_GPL(__alloc_pages_bulk);
>=20
> --=20
> 2.26.2
>=20

--
Chuck Lever



