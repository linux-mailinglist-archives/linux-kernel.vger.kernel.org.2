Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48456396508
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhEaQUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:20:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19726 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233028AbhEaOkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:40:52 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14VEbXgp014890;
        Mon, 31 May 2021 14:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Wy9ArUsczV3pwK2KZGGyBmN44rJP+oxWDN9BSsDhWUc=;
 b=LY7N5s3rvCUE0VuYdkSWfaBqtO+iTb7qXz5uzSlR945CZX5Cy3nryfKxqAUcZ+pvGvmi
 F6syFmp2aeyQewmz8FrwSpjiOH3ghXajWArY/hNMCBz26WbZ3ZPvHy+HiADvkMpVgE0A
 IufXL8YaSRJMnWUGjS+W1PMzRne6IyyIRY0WF8biJw4eMrutk/GmrEfR2a8cuFMdkC+s
 g0qXPjoaarGe3lCpyPBWouSlIbbi97wNhLaf8sMPHrDuT9tvf9QpNLWraYMJk0sb1EbR
 49KQpbsZrL653DPV4x8HpKSP+BMKCfTSIx9W25giO6RRT1oMaiKsGoXXqPob9lYcTxtF 2w== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38vmrgr7xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 14:39:05 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14VEd4xc134396;
        Mon, 31 May 2021 14:39:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 38uycqefk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 14:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dm8g8oeecTdNqSe4adoO1ya2L56ESqM7Tc0oxi0zJCdtEvJyHPcBOwmONKDpk4Ggbkhj+Uz5DWtN3OYSA4PVGAgypk0bBvGpVGMv0Yy/ahoBzAd93qhGByf4yztyevFN+dOcyTcvcgA8wfo0a1gefN4aRcE1H7YKrXekNw8ScL0BIWLQO2sKQd2cR2r0OPJSxaotjSayFFguuYtiUY4U4qvQIrXKWAI5LMRzoC3hpE6nF/19UC2zzojqnu0KLLpoxJHlB4Jew1YtEs7QB6vRFqVdFO2Ohwcb8rUfUDCmO1G1f/QRB+P2pWA+/z0g2axOzqb2+6tgTZXJuhRTgbapOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wy9ArUsczV3pwK2KZGGyBmN44rJP+oxWDN9BSsDhWUc=;
 b=kkXoGptbt+MhvHLV6WdsTS9UOpgnHjbKhkouvIunAGuSCUx7SNg7FSIkXYBvbJ5KOGSkpc6RzD6QWoYrfMli77GJX8U4INIbooImHSSgMMtOVeRqA5X3MuN5IvVye1kg808bocDPrzlxTswuJf2A6xtR8943exLk+EBrmfMfvcXE9iHIZFYp9kFqih50imDeXSYVRMN62AQXGYm6Zuf0fpS0WarT22+q91T1Ujs54s3hF09J3jUhM/yv0Geu0uooqaYm86Daxc1RZWi63uGwduMPOzKYu50usabdsbJRfrZKWcm0XUWzDFXr7/3VaOwX6wKlBxBoK8akoimQwBXlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wy9ArUsczV3pwK2KZGGyBmN44rJP+oxWDN9BSsDhWUc=;
 b=Nzlv9ko41ZfqcNuQaTQlTMDeDEQp5ZraVIjHGbwdT4WefvPPuDF7NdhtCCJg7Yk7+ImIVWXm/MnyoxcVlaRtuQo2Qlbk+D9wSGdKtiiOrT03xZWaDGJoTHdo8nx4Im5l6x0Tas9l5YwPh6bEjKOFxHvzolCu6iVk8wCzG17NqNg=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4529.namprd10.prod.outlook.com (2603:10b6:303:96::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 14:39:02 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 14:39:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Dong Aisheng <aisheng.dong@nxp.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH V2 3/6] mm/sparse: move mem_sections allocation out of
 memory_present()
Thread-Topic: [PATCH V2 3/6] mm/sparse: move mem_sections allocation out of
 memory_present()
Thread-Index: AQHXVf4xy73mQIlGwE2q08XomPgdeqr9qV0A
Date:   Mon, 31 May 2021 14:39:02 +0000
Message-ID: <20210531143852.h226vpjrgpyo2eqw@revolver>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-4-aisheng.dong@nxp.com>
In-Reply-To: <20210531091908.1738465-4-aisheng.dong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 624bcea5-6d23-42a5-52e9-08d92441d582
x-ms-traffictypediagnostic: CO1PR10MB4529:
x-microsoft-antispam-prvs: <CO1PR10MB4529562A1B71196CB856CDAEFD3F9@CO1PR10MB4529.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfiM7N903F+PiDO43luKwAGNn+n792TT2+NttYpQbjDsO+2ZDNNlOeDWLokhMA7NDdickXPnQ10IdYl5N1Oordf7VKcjrpffeLFRvoLpOJE6eTLZ/dciPHJTboOF8HYcLpOmANvb4t8xHFFKRIp/SFpNnWGOT9sm3Xgejac4STw7jyuR/6pI/YN0MdZz2kE+yyoBjTtn/KybaJ0QVrYNYb2CvLRP74LwjXym2s3gVIR6jeLFmJRwKZZ7F844uNE4fAeKCaMB2q9+eJGx/wFD1gvFjcsUD8xWJ88vpa4WrIPc8Afefn28lTiEhpXDLG7hkhGQO3dZfNDyc94yYxgXC3Ywt6v9g7lvNiyjqp8QMy6tasqaNOpy4njFpTA/BrQQliLn4cjxo+gtWCQqeHmppqBlpiEzz1OrvyEfG7RRTL9guHoWUZkiGyB3hKl3I2ar3c+ZRsm+87e6TP2M9Pi1edrtrNEYL82igcspkiJXL3CTx8CWoBZins3rE5m/1m83t+45LhrVcptGzdohVxmvbIuaaNcBI2b/ROcpuiDtdhIs54CR2vohspTfjkaJ1eKaAw0tCTEhvN7hgerlalG0M5/JG/b9vOKyXC/KWQ23E7o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(346002)(39860400002)(366004)(136003)(396003)(5660300002)(4326008)(71200400001)(1076003)(86362001)(26005)(6506007)(478600001)(6916009)(6486002)(38100700002)(44832011)(6512007)(2906002)(186003)(33716001)(8676002)(8936002)(54906003)(9686003)(91956017)(76116006)(66946007)(66476007)(66556008)(66446008)(83380400001)(64756008)(316002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hmTZ9NMFPeqYnojrxd3bUJqjz0eHQjG0Ofy56/Xqvn/3+dJhjWmNVOaFCafJ?=
 =?us-ascii?Q?IlOBmIk2f2m3cIyJoZKrWCuLbPBifXcT1IXYqchtE5DCl1Gip0qbMJBMAXYD?=
 =?us-ascii?Q?2nPyH3DKROyhdAS8alWJENQXzs6lnC3WLmwxYFX/3pUet0BoWMv9sRHUFRj7?=
 =?us-ascii?Q?AdTHPaYjMp8QwWQs5cvWPcW4j01EpDkeGJFvvFfq3JQ10GU9A3uklVzCOuRg?=
 =?us-ascii?Q?LOyJLfKYXzEd+H8+j3osUkA+qRAPzOXBqw9MOiR+njHh77x/oF2SD0NF1gOY?=
 =?us-ascii?Q?Vy/zUiY7zMrupy9sk4bthDEy/PZyyqocZAjXrS6WduTJ+fOhu6wwBUmQO6jV?=
 =?us-ascii?Q?G5Pu8UDEMQHuDqGr+Xh24/EIbJy/dxNgKEkR2NE9VmqltX0ogNqgkl+0yW6E?=
 =?us-ascii?Q?Tuu7kOcqw/TNf3jWG8w5jmzd70j7VvO1Ck7b+9VUyNbV4JWzHQBraZ1/Hibe?=
 =?us-ascii?Q?OXOMEOjpgCBh3sbWQEnVe6UHWawZhXovoB+pWVjUmxlyIUOanRFw85qP23U6?=
 =?us-ascii?Q?En2UcVydNwngAdy7fCAxy3cTgMCAOkbApbQgjeVq4MTKvFlogZ1r13CLrSaW?=
 =?us-ascii?Q?AiYDreqN99oJvhRG3WBj6/CFW9aLEhp9IPLEl4uPHF9TIPReps4Nfg2OtMuS?=
 =?us-ascii?Q?93zMrOjsy5BZJIQ6c6hFGyTZYlv5aJTpoZakzUfnu+5SdhcZEyVxyYowHKD7?=
 =?us-ascii?Q?pK0NbRZ/mvDpi7+SaOiybrgUJEhLeFtPKD31HjEKueXQ2DECmAs09r0hFxqo?=
 =?us-ascii?Q?9uVni3Qus4+gML99TQZgsMt0ky9MGlSVtne/aTAeJ8OtfhzwBu6qPNRZ0e6k?=
 =?us-ascii?Q?hq6NM2rCfJtD//L+IKWeeMFGgGxxPDYDuxcH/Mah1FtGGqRwKtOGOEZbzF4l?=
 =?us-ascii?Q?w+mZXqxygv4atlIX/dmeiIiqwP8P0Yrnlo37pVFXredJHwTONHPsijwdkbPQ?=
 =?us-ascii?Q?BoOfyobLoXYvrrotVKtlSU/jVAfu7IQlY8LlT6v88hB7TWHUSqI3WnTN8HFk?=
 =?us-ascii?Q?iTfeAFNXnn6/OoAarzxet/Sdg6HK5ZTgFiy244uwRqsB8eWD/a+L0m92Kx2r?=
 =?us-ascii?Q?DPQap8XeTFr7b6EGIsaVZeMucOTrvWRDxYdnEjiy3nz7gSi15sVJGjoKKJdB?=
 =?us-ascii?Q?8TFJnxUfsQ2rZabl8lMpmKEZ8EKy14P6w5d/9TnUdGgDKmq3K/MK9ct6Q40h?=
 =?us-ascii?Q?y2DaIq4phaVOfTxRh7CDx1oIUCnhLLC4uvSYL+QbfdsQ7DmdrwJhiqK7Qwen?=
 =?us-ascii?Q?FBhTjHe5XjLFtOpGqM6Xb+qzziiZPAzb/bcUCc4i+5zXknv4LHMPDvwrSZiW?=
 =?us-ascii?Q?b6Y7yY1atuo7U/KNLqyoKQBI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <494497392C46B0449C0A1D4850CA6D18@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624bcea5-6d23-42a5-52e9-08d92441d582
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 14:39:02.2378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7r6yRDMVoeZUrCCrM/viD1jVw9+tRuVczeiEX930B25ihbt6+IcWjlRanfmO76jGheH0p1PTqKt4R7BOoWFNxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4529
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10001 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105310106
X-Proofpoint-GUID: HaWhxSf_DV_yAWo5F_NhcRl-ZaQ7oJXV
X-Proofpoint-ORIG-GUID: HaWhxSf_DV_yAWo5F_NhcRl-ZaQ7oJXV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dong Aisheng <aisheng.dong@nxp.com> [210531 05:20]:
> The only path to call memory_present() is from memblocks_present().
> The struct mem_section **mem_section only needs to be initialized once,
> so no need put the initialization/allocation code in memory_present()
> which will be called multiple times for each section.
>=20
> After moving, the 'unlikely' condition statement becomes to be
> meaningless as it's only initialized one time, so dropped as well.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v1->v2:
>  * split into a helper function and called directly from sparse_init
> ---
>  mm/sparse.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
>=20
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 408b737e168e..d02ee6bb7cbc 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -60,6 +60,18 @@ static inline void set_section_nid(unsigned long secti=
on_nr, int nid)
>  #endif
> =20
>  #ifdef CONFIG_SPARSEMEM_EXTREME
> +static void __init sparse_alloc_section_roots(void)
> +{
> +	unsigned long size, align;
> +
> +	size =3D sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> +	align =3D 1 << (INTERNODE_CACHE_SHIFT);
> +	mem_section =3D memblock_alloc(size, align);
> +	if (!mem_section)
> +		panic("%s: Failed to allocate %lu bytes align=3D0x%lx\n",
> +		      __func__, size, align);
> +}
> +
>  static noinline struct mem_section __ref *sparse_index_alloc(int nid)
>  {
>  	struct mem_section *section =3D NULL;
> @@ -107,6 +119,8 @@ static inline int sparse_index_init(unsigned long sec=
tion_nr, int nid)
>  {
>  	return 0;
>  }
> +
> +static inline void sparse_alloc_section_roots(void) {}
>  #endif
> =20
>  #ifdef CONFIG_SPARSEMEM_EXTREME
> @@ -254,19 +268,6 @@ static void __init memory_present(int nid, unsigned =
long start, unsigned long en
>  {
>  	unsigned long pfn;
> =20
> -#ifdef CONFIG_SPARSEMEM_EXTREME
> -	if (unlikely(!mem_section)) {
> -		unsigned long size, align;
> -
> -		size =3D sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> -		align =3D 1 << (INTERNODE_CACHE_SHIFT);
> -		mem_section =3D memblock_alloc(size, align);
> -		if (!mem_section)
> -			panic("%s: Failed to allocate %lu bytes align=3D0x%lx\n",
> -			      __func__, size, align);
> -	}
> -#endif
> -
>  	start &=3D PAGE_SECTION_MASK;
>  	mminit_validate_memmodel_limits(&start, &end);
>  	for (pfn =3D start; pfn < end; pfn +=3D PAGES_PER_SECTION) {
> @@ -582,6 +583,8 @@ void __init sparse_init(void)
>  	unsigned long pnum_end, pnum_begin, map_count =3D 1;
>  	int nid_begin;
> =20
> +	sparse_alloc_section_roots();

nit: The newline below is unnecessary

> +
>  	memblocks_present();
> =20
>  	pnum_begin =3D first_present_section_nr();
> --=20
> 2.25.1
>=20
> =
