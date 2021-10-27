Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A6043BFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbhJ0CeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:34:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47113 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhJ0CeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635301902; x=1666837902;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TI6RsFk/Eh5+GrnKMWsKScPVlYqftLZvqZ9w1JIPuc8=;
  b=TD+83/1ZTx7HlFFY4a56XFkPqmArIjKFkrrxbYz9aCQecdE6UnLM47Cl
   gGs09KKl2W4uyrpXZeZU32ijRm+mxHa2BTFWT6seVjMiAm4MBzPGhIyW3
   4hzgfHWKVQef0TIS9o7GE77UzrVE9eOpzWBxpcBl3OfYV1ErD/037cUA2
   FtjQp+Ok8tdUdsyWH6ShMWFRQ4f429c180Peuf/k6LzJypRnGiM2NK7oI
   Q33HwAuvSiFEeVCfXVJW3YsPmW2BdzYmoNOD/phXVUJqEkf6BaqmjRAfw
   5WtXThVivwoktsLotURm+YFlLNSZIb03OknEMKseuVl+2QN345y69FeX1
   w==;
X-IronPort-AV: E=Sophos;i="5.87,184,1631548800"; 
   d="scan'208";a="183925382"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2021 10:31:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLCzqoXW1H4n8v5feyQz+HTV559P0VpyQx8JQzgM+zDPEomA7y1zq5YvI2oG7d2YPTmYh4uD0yT4pEpOgTn3LlSXQjWIQAoo1ZcMnVH/ieCdux1ykl0fxgMHKmX4oQqKLS55neuoxFusvQTGJzCd/+7c39KWA1ZseO2c6sq/c3bvKSN7Pw7UD+Szv0iv9mV/XTQY/ZsodumfIKE4OLYwTDp8BgtLfVJ0iI10O1fXA5H6xZ0lWKn5tsGKrI6JQswVYIweKFJUV8Rs8UxGZrFr42SaRRYO1F315wKkEHWT7QevAylSKU5F+jrk6TtSfgx4fv2pDimpjsS0Bm/+1hEFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQTy8WW1kNBr6Xha5qKmxpzJafbsJuxf+Nb+dSfSYwQ=;
 b=Oa5sFHzP/s+v90U5Er226HPB9uKoXGpH6K0qi8AEUH8mNuLS5aH97Ltb2bUNmEvkXv6Dr/nIa5rTWUXKvVB9TXygAkvsjTdD+5pcxaxDWcM4M6xyImRxyKepHxctHxRtsLBzYmPmrqyWY0o4jWztxSvAX2vmPj81MhlSdhxG+/UJqhLCiJ5zF1OSLascrTJzrSW0tIB44XF7sl1wIpZYdhDf7RcCU8qSIvGr7aMb3XAbMi7z+xLMLspymBJtYyvyy+0v3BZ8TSHccmc/QwQ8WBe0WeLTK1WIKueWuqRLyr6O8xRi9fk3BymYvoI6x9DDgmB3Z/zOw6ySngwR1EQgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQTy8WW1kNBr6Xha5qKmxpzJafbsJuxf+Nb+dSfSYwQ=;
 b=a2LLDz3lS80ZNHGezDkEDbqSJtxbUrbaldsxTy0uuUWvisrPKfrdtkIVdUC5yvUfF1ROhPTF+EfpBpWsdfgMsP+0nylvDtLWHxMFpsc5PlTXVS05J4OQH5umxQfLjyRwgbJupnp26aJNTaUt0VG1KKFkUV/zfvgp1h+jDn1XHhg=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0813.namprd04.prod.outlook.com (2603:10b6:3:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Wed, 27 Oct
 2021 02:31:40 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::5034:7af4:3e2a:b1af]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::5034:7af4:3e2a:b1af%8]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 02:31:40 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        "heinrich.schuchardt@canonical.com" 
        <heinrich.schuchardt@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagar.kadam@sifive.com" <sagar.kadam@sifive.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] riscv: defconfig: enable DRM_NOUVEAU
Thread-Topic: [PATCH 1/1] riscv: defconfig: enable DRM_NOUVEAU
Thread-Index: AQHXv4kNtwgxdmgy0k6ZFdVRkGjXuw==
Date:   Wed, 27 Oct 2021 02:31:40 +0000
Message-ID: <DM6PR04MB7081C64D27D133CEDE728393E7859@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <mhng-5dc2aa26-9f1c-4764-9877-6d99569210b4@palmerdabbelt-glaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f796243e-2fbf-4e84-8c9e-08d998f1e884
x-ms-traffictypediagnostic: DM5PR04MB0813:
x-microsoft-antispam-prvs: <DM5PR04MB0813FCCAF471526ED6708754E7859@DM5PR04MB0813.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QOCl95rKo64TEmhuiFy0NQPMwfORME5K05KXbncTXCZs0hBlBqW5DAIvLoOd4ClNhju2QdtQsD5yM/McEackSIRvbeT3mI2+2VfU8Qjpc/FC8oZwdiKULj55BC37kzDtYHXXqHyfFEI3TIlJQpZjrsQnhKhXXZYCe2pz7ZoMoZnb0E0qUOFcGtfc0D2K14msIoSWBWDL0HhkT9RnTV9eGonlRnXH4vAxJiPI/CC5R+VHDcSIAd2qhyI6wJmglcJP1hOTWZS4rAQwg33CiGOp+X/84fjTR3zy3Q3fbj6gN9hrmdkWuRWEBZAMBCOF4zksCAMFVmAELeSTToE+UBAqgWwdpAdcYrdQhCGV9nwASOWmj5vBFjS2ouive9N5VD5kVSWexioLJmpjFfW6D+UFkqw1+h88CIzYC1k6FzkY1YcYOUWLpCKHQa8VBSTejaXTID3M7MRI2RFp6mJHVLNDC7FwEKbggkXYTBm79vgaioDdrwQgPvA/XlwsaUHco+cT5YzEpupWSrJrXkSlks9y6fOphVIr0jaLo6vqbZGmHFjisgo2tmGUnjNaiWp34swNSys/XfIdzTNJqA9l74P8l2ct/aqxe2QmojB6KvsDQ+qRWfNcneeygwKsLF48XoVXglWHV/pPxjl6STtv/wXww0CR6S1/wzd+E3kzNwOjtkZb4Hw+OSsorbGmNnnDOlEDq8EBfyF1YOIBbTvMVhK0sXTlJp4QEjCHeZeFd6ySv+F7YSC2wBOhc3puzAms1jT39bMfPa7SHrjjrqIuBhwMzE5j39318PWwyRYlQVss9yA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(33656002)(86362001)(52536014)(38070700005)(7696005)(55016002)(966005)(6506007)(53546011)(26005)(186003)(71200400001)(8936002)(91956017)(66476007)(9686003)(66946007)(76116006)(64756008)(66446008)(66556008)(2906002)(83380400001)(316002)(508600001)(82960400001)(38100700002)(122000001)(110136005)(54906003)(5660300002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FJo1A3Ozz7XlKMG74kcqtyg0TSmJJihINvufJMra8iTgKLaAZRhU9HFFL3sA?=
 =?us-ascii?Q?h7vwvTJAkPydFbqAfedfe++bol57u0Wwk5o22ZW7QmHLkg1zWfDrfXj8fDbh?=
 =?us-ascii?Q?hcbWoUdj0n8F5vMVUTvtWGjB1It+Q3hgWyrET8489JWAhg2nCigbq6dotOxv?=
 =?us-ascii?Q?nNxjrsHgWn1R4utIIA+71cY0GY4VTCCVSuZRBKrsSEbZfCIMaKZm0RHB+7ko?=
 =?us-ascii?Q?sLY8pztcXPkjI57T2ibp330o20iZRI8IXUUKmK89Cr1CyCixEbV20jaIXwqE?=
 =?us-ascii?Q?Cowd03gWMQm7fNoIPj/2d4mILyUfEDW4EgmPEDk/cXDEl9zsB73ZqvSIjaDY?=
 =?us-ascii?Q?9Iv3JKvrgiP4yRTwOnLiFUC05D1iN9iJIViS1nKb5fdpqXErM8OYeUSRfZJe?=
 =?us-ascii?Q?0Y8Re+jyORKgTNMOgNZMOs/mCfR1ktQKQ4pwkC23dv5roSJi6qitaN7r2prn?=
 =?us-ascii?Q?lRN1YaablePlSqtP937gDKdAFVNIKKaeihs/aa3LJhL0AX0kDuHWvosPYqYp?=
 =?us-ascii?Q?Tm9SYmtSnY1IwK5UxfaLItrtb5Z0Cwvn516OBasjxNSJVjGDoKpd2d/vwVk8?=
 =?us-ascii?Q?kCFpcNmswKACIslgaTiTDYVfSDnNmc7mV0MqXUJjxa3taK5bCB84Ie1ywz2p?=
 =?us-ascii?Q?7K63/Msm0oqbMPQfi2uT5gSZHDq4tuNdnBLeOJ/aOO908rDg6yrCxMPj6TKm?=
 =?us-ascii?Q?a4grfi9SC4oCGQ6gNtq/6qJTvmwnGSTSJH6fsQaSbwQFJe71AJBEPtecgJW+?=
 =?us-ascii?Q?Qo5pn13dtiUZgz6I6yZBP/ACkWwFdzRyZzus9mXgtUcpouHfVFgJE8p1Mh3/?=
 =?us-ascii?Q?VCNqdlWu4t7u7rl3olXFHbssWMv/slGkjViTRCrywdPDCHRB4ZtmZv6z+Xn8?=
 =?us-ascii?Q?WthkLTW4mz0MHiQlOQUAdFu9PIZi1zCcgsW/x7/aN4VkmLPUWfUB/cs12Rtl?=
 =?us-ascii?Q?wh+aVIagWP6BReCoKRTd96+RWnHgQe6PxM5dLs3S8YPFXVPS8ikO1Kjcqyuo?=
 =?us-ascii?Q?TSX2rg8DjFaDJ8pGximEsPeKPvWtziYFh/Tkyzuxss8ua1x5bjshpOSqq5Et?=
 =?us-ascii?Q?eOx4I58e+dm8hZY87QulASv9dmWTuvoeYfAFsHhuCwaWiIUMPzBzH+NH+lWO?=
 =?us-ascii?Q?E5EnCMznuFKZIpCU/0FL0dX6tzIwglt4ZNnbI+JG9PIeGYX12nrD1cl9n638?=
 =?us-ascii?Q?O0U2Pi8YC1wiiIuqRR0lF0hT10yxH2gSPX6klh9+N0BZXo5AH2te2scx0pUq?=
 =?us-ascii?Q?P2DT8OjqE9lMoWUGyEzJHu8iGNPakMx2SCrS0h6xxsi2YGzNnVNleW8akP7g?=
 =?us-ascii?Q?GbTSFBUroL4NoXquUzd7lU+jn2uba5GsANa0WuMCncUW71qhumtACCLqOxwk?=
 =?us-ascii?Q?UmRNjthzAtPicNm+Mn8OliF3V5LXSMuMvDi7LpzX2+VbvgF3Ry/re9F0+dvY?=
 =?us-ascii?Q?T00uxM8easwp2l1Fd7hFtCZ+Lbuqi10UG0Pe7QGkbdgxgiyN3o31oNW0sTWB?=
 =?us-ascii?Q?GSH+xhptRejWfCg4fQ5GXFDE3fqZKRJU5OI2WP1ARQRkBoepX/yTOGz5USV4?=
 =?us-ascii?Q?xAszZSaaTZ+RX+UIJ7C+66pXLy7uQkvaKkOmww9kCq/O5xay0NyrmNTWfRj2?=
 =?us-ascii?Q?wUDOUxyVV3LfuYcL3bTHxpU5SXIiSCHaykd51UVVDf+k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f796243e-2fbf-4e84-8c9e-08d998f1e884
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 02:31:40.3703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRTBsE3pUFcYdsMLyI8vIP+xBELZ+HXWJPtX/NdWEAEFmiDks/HCFSHGOJnfDbFSkCfUiIjzPs8jnVvhEgc2tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0813
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/27 8:58, Palmer Dabbelt wrote:=0A=
> On Tue, 12 Oct 2021 09:46:58 PDT (-0700), heinrich.schuchardt@canonical.c=
om wrote:=0A=
>> Both RADEON and NOUVEAU graphics cards are supported on RISC-V. Enabling=
=0A=
>> the one and not the other does not make sense.=0A=
>>=0A=
>> As typically at most one of RADEON, NOUVEAU, or VIRTIO GPU support will =
be=0A=
>> needed DRM drivers should be compiled as modules.=0A=
> =0A=
> Do you have an nVidia card that works on real hardware?  Last I checked =
=0A=
> was a while ago, but they weren't working at the time (IIRC it was =0A=
> something to do with PCIe addressing, but it was a hardware limitation =
=0A=
> so I don't remember exactly how it all fits together).=0A=
> =0A=
> If they work then I'm happy to flip them on.=0A=
=0A=
Why enable this at all ? If they do not work, then disabling theses cards m=
ake=0A=
sense. But if they do work, isn't leaving the config to be the default defi=
ned=0A=
by the driver the preferred approach ? Otherwise, we will eventually end-up=
 with=0A=
a defconfig that has everything enabled...=0A=
=0A=
> =0A=
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>=
=0A=
>> ---=0A=
>>  arch/riscv/configs/defconfig | 7 ++++---=0A=
>>  1 file changed, 4 insertions(+), 3 deletions(-)=0A=
>>=0A=
>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig=
=0A=
>> index 4ebc80315f01..c252fd5706d2 100644=0A=
>> --- a/arch/riscv/configs/defconfig=0A=
>> +++ b/arch/riscv/configs/defconfig=0A=
>> @@ -72,9 +72,10 @@ CONFIG_GPIOLIB=3Dy=0A=
>>  CONFIG_GPIO_SIFIVE=3Dy=0A=
>>  # CONFIG_PTP_1588_CLOCK is not set=0A=
>>  CONFIG_POWER_RESET=3Dy=0A=
>> -CONFIG_DRM=3Dy=0A=
>> -CONFIG_DRM_RADEON=3Dy=0A=
>> -CONFIG_DRM_VIRTIO_GPU=3Dy=0A=
>> +CONFIG_DRM=3Dm=0A=
>> +CONFIG_DRM_RADEON=3Dm=0A=
>> +CONFIG_DRM_NOUVEAU=3Dm=0A=
>> +CONFIG_DRM_VIRTIO_GPU=3Dm=0A=
>>  CONFIG_FRAMEBUFFER_CONSOLE=3Dy=0A=
>>  CONFIG_USB=3Dy=0A=
>>  CONFIG_USB_XHCI_HCD=3Dy=0A=
> =0A=
> _______________________________________________=0A=
> linux-riscv mailing list=0A=
> linux-riscv@lists.infradead.org=0A=
> http://lists.infradead.org/mailman/listinfo/linux-riscv=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
