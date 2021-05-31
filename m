Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C562139661E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhEaQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:58:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19896 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233544AbhEaPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:08:18 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14VF1Xhb007346;
        Mon, 31 May 2021 15:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iKPaSd8mG7auZjLXxAgKurWx2A8ZukTswn8h2Cgrjuo=;
 b=N82U3cbFpp+2ydV9CZg21ISrkMHVnIQ++ECGYM5ZIHDYKga3a9AjKsI2jXRcLcmZ0YoL
 RiDHt/1BYuXyv7EaxwwDPhSOdpXmzi22G5dzvP6zMWQKHf/J6uYc+Yo9fkuiRFRaNJT6
 sR4VJjWAcQGg1X78BcxciMduHQ4832+NvcuBSV7L/8Se/2y4vQyM7G3LQt37cMBOC/TX
 wjChThiN6yzMQOG4L3vjZuKP7zPiJQ2kFgW918nBAVbnscxJ/vsfb3A+ZcKaPgqtpxT+
 B8CFYY13a2UTLPRzgs/hc3z+0sRfdcywCVM/Y1cBLabRb1h+kFJM+RfGvANMSc4d2Lhf og== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38vjar093m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 15:06:32 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14VF1EuW190444;
        Mon, 31 May 2021 15:06:31 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by aserp3020.oracle.com with ESMTP id 38ude6nbdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 15:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcLOBqfayXx04YVGtgrIPaR/SWx2ze1mDIgL0gKMOQP8FAliD3CnavuudSuj+XUeW8OnknCNkOQ5ohnRzthqLlBSWyeUAyTD7dKQi9pomfCvuQ/3YgdQ98m621QhyHktmlGr2YxCCzfCG1Ko8GMHLFJTeMK7MfyivGsPogv/WkrDyFlgXQ8va+pcZfXrZaejSZHbf2HBEcHAZtrqdin3AfaEbiILoknIf2Pjgj0fv1GafCvOUsPPN6WpeOEftu4gxUtr+sBhAXGnvEZ3LbWNPw0odAX0gS7zmphhc4dmuRQwjX6VcEHhQTQXR8G4M2I1CVf4LTHCaxaelM7yFEUWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKPaSd8mG7auZjLXxAgKurWx2A8ZukTswn8h2Cgrjuo=;
 b=eYIrv39c+nsDPFt2GpVAHzAsmTmoagg7aC/ZamOfuT7KW/+l7+enUP8h50OBdbpXeFmLasDefUrwu43KxbJE/4JoU2Kw9WfAiX3FMVrIC/FLTF1tMur+gtiaTmCmyU35uVL6+di+q2b8XMQwOcAVEWq2VHR+e+TSlFNcqGaQeXAQENyWYp4zUcfLRLuh8teGx9PHhQVUzPxRxwJpoVm9bt74QnydkoQenWTYljT8XfbzcdXC+BBMzMbHhBToO5Qfppe+NWfNGNgbNHy7a80CUy6Sx6tLPTUgTm7PlQyaShr8JdYWrFFJL48e4MpzFaK0/O+7G3t9nmrO0ZJgzRONnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKPaSd8mG7auZjLXxAgKurWx2A8ZukTswn8h2Cgrjuo=;
 b=c/Cd+kqPQlGOwEFw78lRbHhyhiXQ2Q32khCxZoXD54VZuJxPKzT8ebT6UjCffcWtF4NbuEioDvENbsRgYdhcuWr9JyYygeVK6Cgz2CowCBZXWUs9TOKWMVJhy9Oa6p+jwHc26O+ewP/G68N+7JF196a5mayMsbzwKTL8sbdqp4I=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1742.namprd10.prod.outlook.com (2603:10b6:301:a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 15:06:28 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 15:06:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Dong Aisheng <aisheng.dong@nxp.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH V2 2/6] mm/sparse: free section usage memory in case
 populate_section_memmap failed
Thread-Topic: [PATCH V2 2/6] mm/sparse: free section usage memory in case
 populate_section_memmap failed
Thread-Index: AQHXVf4vS9Xor91CmEmtzwvydauNs6r9sNwA
Date:   Mon, 31 May 2021 15:06:28 +0000
Message-ID: <20210531150542.inopmezthosooy5u@revolver>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-3-aisheng.dong@nxp.com>
In-Reply-To: <20210531091908.1738465-3-aisheng.dong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23cf1ca0-b10e-40ef-c756-08d92445aaa6
x-ms-traffictypediagnostic: MWHPR10MB1742:
x-microsoft-antispam-prvs: <MWHPR10MB17422F96B0B6D803690505B2FD3F9@MWHPR10MB1742.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TirBxAv4eTTYhystal5dI3NvJVDHWNu8vG4TTFFFIFGmkpbiAb6fbKPNmrzYvVHoKUPieCtHf0DQ9LENU/VIknfoUXQUUktDjy5MMMbL0NV28KkE75NGMVYfGcZQWE/AV8g6Az2A71RTEud/TlLM8nTv3XYh5f/7Nqmc6VUs46Paax6YDA77PTsvr7hGu5sBE1J0mhab8Yh8UuWQkS2F9yDI2tFZ2wDLLplkAls/Q1wb7CXs7Lc4iqG/5WPZUlEinSqqm/PXzummPlb2+YFYM7nBOXe8hC33yScPhpc1jwIA+lszr2R2SzDHqrNtzFv1RaUPtU5jNYVpPMKztiVc5V2oPGrugBMbAlhpCDlU6Xn2+wL5yDG5Ni0GoicldxD5lnjdczcaTsPh7sz66kNKwJAnebND6G7ZtSZuFS7fAds9v65HSa0QXXtn0PFIPU9UVgGeL78L2YZwjfXijbGrJci93vaMp+PIJ6ARwMOQdJ02gjuy4AEFGUMilR4lywbniAv2C7wZcdE+gd+8qJGX4l9WwNWqsANreMz7/343S7xOhoCsEsM64L3tI+50+SgeqSXG387v9KsoXBbjnFNmKHmVjdqLiGv8eUz0mbCI17M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(396003)(346002)(39860400002)(366004)(376002)(38100700002)(6916009)(122000001)(86362001)(6486002)(91956017)(316002)(8936002)(186003)(83380400001)(8676002)(71200400001)(54906003)(478600001)(9686003)(6512007)(5660300002)(4326008)(6506007)(33716001)(26005)(1076003)(2906002)(76116006)(66946007)(44832011)(64756008)(66476007)(66446008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?F8KQmqpjhUNq7641c9A9kkIJnafRMWkuj6C9MpJbO9y8fOKZzYfVXTXhyIlu?=
 =?us-ascii?Q?q3il2w3P2ZaxJ+rhrZIFtbn65ZIoNQ+VCNyd2iHN6jKFqzmXWi2TvLGqKAOV?=
 =?us-ascii?Q?P6ymmMTEdMAxq0MGKw54B4dLlo6TFSesvlUXUSMmyuBXItwGB5L1Zsy2u82D?=
 =?us-ascii?Q?uS3U4RrjB9nOhaQw4XvNB4P5HkbEUB9+5HQB6w3aC/+Wk22pnU4FVyr94U+J?=
 =?us-ascii?Q?NL2HmqyCR81R0Ml8xy1HWLz4x8a08Qbs4tcnf1KUtGoYyP89cZCgo3nBAnYZ?=
 =?us-ascii?Q?hyfqdBUdFev5MzvmybwU9EUf8D3psumxnnvn7lsrc/oLbsTu7mpM91KrzEGj?=
 =?us-ascii?Q?tR1rdToAlIqGgXdeRsGI9bZnpJHg1RQHf4tmr4w9qrlHryXS5BL8A88sH0Zb?=
 =?us-ascii?Q?gcwTZBRHcXp5dkHBVcFH75EUFl8oRG30c1l/XKVXcEOlhFsXrqILL8XxreS+?=
 =?us-ascii?Q?Zqc6KHVq700wlz/OI/Bb7UwReb6Ol2LvZbLUEuLhbWThyhY7hvNEFiD2RTev?=
 =?us-ascii?Q?+Mea9fKoDGNpyC1rUu2UQ9LYS+oOrBIZWOCHom7Wgc3WbeQBXwPonYkkuTZP?=
 =?us-ascii?Q?NlnWe3ZDF3AIxDqfYycMO0YFuhUkcn+bX7g8yrfpwJ7WPZfL7S7Wc81v2mzA?=
 =?us-ascii?Q?qod5TheZIW//NsBDzfGyLbySik7yuv7t/kNtPSffVTktWVQAXHaHeFN/JAue?=
 =?us-ascii?Q?BscUyzofYEVV6I9B76/nX4BNBuk2ShbJkZmH1z/Pu6vLBsjiN6stTkSyxLwy?=
 =?us-ascii?Q?m/IhUvtVu+G6xeXHsgEmy2BBkmqrrqiGgMph87WXSFSeMLewVAdIc6X6+20r?=
 =?us-ascii?Q?qr7z0skWu095PT3rm1jI3t2IP6LuRhwobgiZFKoD7F+p0Hn8YzbrA5vCk2XB?=
 =?us-ascii?Q?RLyx8hjMFH64LvnYNPd/0ACm7EGz77V9qhNv3JtWiD+f27B2ppip8NA47mSy?=
 =?us-ascii?Q?0jmbBneF2FpejCI1olOMVRAWmChP1lE8gNZX5lnmHRSGjDregOlQlOPKI01d?=
 =?us-ascii?Q?33XWmYBgaeu1T1nyB7JRJDrnXGD1XgjGAIbe21HkzKp5fmSvqOIhdS6GSd9h?=
 =?us-ascii?Q?MqgOQZIqT9o0wrkCn7JC2L0vIpeO5YyDbtKLXsPQe5c+JjxuugniMeawv/o+?=
 =?us-ascii?Q?DQldLSN6NCoe+c3qgmo6LYOeRSHQ9Mwk7jw84FQcfsP2Q5x+F+KKa+4GTE7m?=
 =?us-ascii?Q?DaVUwFwScDy/mBFGSkHAWRNOeMBGhnMk7mKrpKdTxUVcZZwXmFlJxEEaZ1ox?=
 =?us-ascii?Q?r0FA1Y7ncFRQk9wV2+0KemzRsG6IzMLhnGulu9l2svWXZ4dAaeLkvOfdmKx6?=
 =?us-ascii?Q?vjjrZzFvxQHpKbXuk/42dpys?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B38145E5F794DB43B8794868F81FC83D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cf1ca0-b10e-40ef-c756-08d92445aaa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 15:06:28.3086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkXiacOoN8IvJPyNbHun+rgB5xP1PWYa4a4Q/b3DLtlb4BDNn2GN9pkdksuXAw0jo5gWtuvkKHtfzOy9GAPdpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1742
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10001 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105310110
X-Proofpoint-ORIG-GUID: 5yfO3ycfx44eXo563MnN8KcYIUdbPZvn
X-Proofpoint-GUID: 5yfO3ycfx44eXo563MnN8KcYIUdbPZvn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dong Aisheng <aisheng.dong@nxp.com> [210531 05:20]:
> Free section usage memory in case populate_section_memmap failed.
> We use map_count to track the remain unused memory to be freed.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v1->v2:
>  * using goto + lable according to Mike's suggestion
> ---
>  mm/sparse.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 7ac481353b6b..408b737e168e 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -533,7 +533,7 @@ static void __init sparse_init_nid(int nid, unsigned =
long pnum_begin,
>  			mem_section_usage_size() * map_count);
>  	if (!usage) {
>  		pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
> -		goto failed;
> +		goto failed1;

Please use better labels for goto statements.  Perhaps usemap_failed ?


>  	}
>  	sparse_buffer_init(map_count * section_map_size(), nid);
>  	for_each_present_section_nr(pnum_begin, pnum) {
> @@ -548,17 +548,20 @@ static void __init sparse_init_nid(int nid, unsigne=
d long pnum_begin,
>  			pr_err("%s: node[%d] memory map backing failed. Some memory will not =
be available.",
>  			       __func__, nid);
>  			pnum_begin =3D pnum;
> -			sparse_buffer_fini();
> -			goto failed;
> +			goto failed2;

Again, this goto label is not descriptive.

>  		}
>  		check_usemap_section_nr(nid, usage);
>  		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
>  				SECTION_IS_EARLY);
>  		usage =3D (void *) usage + mem_section_usage_size();
> +		map_count--;
>  	}
>  	sparse_buffer_fini();
>  	return;
> -failed:
> +failed2:
> +	sparse_buffer_fini();
> +	memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
> +failed1:
>  	/* We failed to allocate, mark all the following pnums as not present *=
/
>  	for_each_present_section_nr(pnum_begin, pnum) {
>  		struct mem_section *ms;
> --=20
> 2.25.1
>=20
> =
