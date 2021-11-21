Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC825458735
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 00:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhKUXo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 18:44:28 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50043 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhKUXo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 18:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637538080; x=1669074080;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NprzZVPurxF8/WbexxvU8yM0W4O1nsGeqLOYUjHtCy4=;
  b=QVTIn4vqdeoxvuPYwbNlajv9LROdlFH5l3cZFJWe+CxUq2d2X4bC28mx
   bxIrfmuc7CQVh4pRCqdGY65q7k3fikYMmS7RvVh9hBiolcBlPUOBQ6kHC
   3nFneK7SDTKg4IS1QdBoG1/HPbWCVf0gczfWYDhg78FaHviMQzzhX12Jt
   33sHTVM4oaQdc87SRhnPdUjKBUCjUHrWdH8R/f0BDuvmL8deUrmDuNPwu
   v/qRfP2LSs8tTqv6Up4SJm4lFYbYqWOuMKgCPZP2Pky7K9d+imB1sB95x
   O2UWJH1/lumuHPsPbXXVjR0/75hMs7rI94uWCkq6zpwmbVv6F11FzrU6J
   A==;
X-IronPort-AV: E=Sophos;i="5.87,253,1631548800"; 
   d="scan'208";a="298085839"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2021 07:41:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DztaezJKwxSCUI+qUMuVayYoSCjDCVvukXsVzGcezs9klwj1R1T3nWyq1PJJ+qn2VkIbMBqQ8z6M0gglWrGeTMjBtYXqV8fz3WAub2kPmGH29b4ystTVTvhsM2tnJfbbUcRmpI6fdvFo89abos34hJu1bteT6v0TyYHUKXF7RV0LRJVKU3EJ1k4LboUQzAivPLDCTo6GX4eWGHE86NOxOytTW3n4CWNNcjMjYkl5Lb26L2ro3WA/lud8uGVKuhphhx3vSA4GDlVLv4FbTikv85r00zKi5Cdj9MTg3g5FCQ5Br+ihQhaF6P1zn55kSpX7eJeq3Z6qjQAEBWlbGLstKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRy5Bt+P25Id9LkMCMO0SCVQhoTC0Sw56JYCBONuaxc=;
 b=MXqIXU02oZ+Sr+YXDPn/Z/DD7hTMWsv5TBub9e9QngqdxYiEQuMjuPHt4HLgx1L6GuWL32eTlwAUgh6wQpm80W5gX+IiD6ceBbr5+/HvGlTYEKeKvLzOKeGF4J9fAg1cft392ZdSiRCFUto1mV6h5TM/WjGjB4zA1HhD2NneIraAdyjj1z+sXUcHcPpDfkty/+XKjW5PJ4q3qNACKVTJONA+nQaxk1MdDqf1OGpZ5ZAHZQdRhdi2HZiaI1G6YjPJD0CExCj71dZK38/RAnWmVc6zIu8282ZJsDnrzW3+qpyuBtWZRyZGLvF4asEQCsIW2VKsw08bYTYLbTsNPeYV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRy5Bt+P25Id9LkMCMO0SCVQhoTC0Sw56JYCBONuaxc=;
 b=ppZdKo1DSqIazZxfscSZoKsQ+bv+kNL86LnwhSGbSzjbB29PMA0F6PQ0GukZ1/zGkaI4mZniZ4Jnc3i23pE5aHSgMiOk8VZadmZNbew7777RDrLJVSmnz1aa1zMkNy4KX0fKggj93FzxA4e1cTE6zF3X3sPgVZd4C7JsY3T77eY=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4923.namprd04.prod.outlook.com (2603:10b6:5:fc::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Sun, 21 Nov
 2021 23:41:18 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::fdf1:de8f:9073:8487]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::fdf1:de8f:9073:8487%5]) with mapi id 15.20.4713.024; Sun, 21 Nov 2021
 23:41:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        "heinrich.schuchardt@canonical.com" 
        <heinrich.schuchardt@canonical.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        "bin.meng@windriver.com" <bin.meng@windriver.com>,
        "sagar.kadam@sifive.com" <sagar.kadam@sifive.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/12] RISC-V: defconfigs: Remove redundant K210 DT source
Thread-Topic: [PATCH 12/12] RISC-V: defconfigs: Remove redundant K210 DT
 source
Thread-Index: AQHX3WTpsbliyan1bkCwPrZcgVMvjA==
Date:   Sun, 21 Nov 2021 23:41:18 +0000
Message-ID: <DM6PR04MB70816CBD9FFA383FEE8DDC67E79E9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20211119164413.29052-1-palmer@rivosinc.com>
 <20211119164413.29052-13-palmer@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e12ae080-b983-49ca-5659-08d9ad486a75
x-ms-traffictypediagnostic: DM6PR04MB4923:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM6PR04MB49235938DDEC102F795A5113E79E9@DM6PR04MB4923.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKXifn20rh/pe+5sxWtbinttL4QAG+pirbvmSFjCcHodm+kQfip3CXB1Cv3ZKPwsB8N+iybSYKBS8G1zEkpIXSsHPGevxEDTv7OD2kLPHtP6ODsCJQLMC/UsTHZe7akUDjqu+VtcJ51NLPOvSQm8IWBOmcvDkwZ9ZgHcPGqoDTIj+gGb3ui6Fm4pDGXtRlrNEqB2tPXpyPeF1Cz1sC1Rjws8IClewgsYBt3oMkBuefEGM4nPE43WQgODAQwvFpJUMrVmDPqiOFAmPr5gRHiRYrvmRj/cp++X2g9cNzrc/hcGNib/LzL+KHmphy3tkqZ1oUuKKHb9Tb4KLsDETxM4g47d3hhBGqpzMsJV2aznnRkMW5pSXhKIeRVXQXyU+uDd5h3H0VHAShC/xBaDSU8JDk6qdYH0Tyn/rMH6E7P2GGShHaQlXINr/61ppmCYgYjS2wCpeR1soRbjz1Pt2yMywW4fkfCF9f9osAow3rF3+ffOMH5FE2YMmX+eCVli2J5/RRy3jDs/y321rhtNNL9U0pPx+QqRWieQF8znhTM6eAu2wa8A0Gt+34RccL4W87ToQ7HF4iwY+2wBQaLqg39yyrv5xOZNwXiCacAAMc3aCavWltGvwdKlBiIm9gLSTftINIc3oX90cSu9cVDbPK0oSnd+q+3KGeHiNjF7NJjzYlCij1HmNiDHbD2EaWef4Tta3R7tNrXQx6M5b/PfWqC6Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(83380400001)(8676002)(316002)(82960400001)(66446008)(66476007)(86362001)(64756008)(66556008)(9686003)(55016002)(4326008)(54906003)(110136005)(6506007)(7416002)(91956017)(53546011)(122000001)(33656002)(7696005)(38100700002)(8936002)(52536014)(186003)(2906002)(5660300002)(508600001)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qrx6hCRPutq9Cb8JK6rRPeAeexbXIQLQcRo3Lms9rUrgnWuYiKJToY+emeLI?=
 =?us-ascii?Q?jHvn47wnQVhwbgYAUssG34awx1tAIGFGa7ipsqkHfUNXI9I4wzryUe6vxzCg?=
 =?us-ascii?Q?Ij+kVXaaFAEACAl13Jk4h6lyoBUYaqU297t2xTV7cv0D/klklk3sfgahP4SP?=
 =?us-ascii?Q?5xn12meJJdAEVIF68v7/VlLPj9L/KhqZ5UsNRzfcZvBsL0dTmJDxgYYeEvWB?=
 =?us-ascii?Q?8AvrcVSl96c3wvONZCqj5e0+moVQ0q9+punsb657j9tI8KbKrloj6UgRtrTc?=
 =?us-ascii?Q?Ph9RkK9TDVHBc86dFqjcExIphlNb8loFmLre+kZrnP9MrHHyCr6LU+gs427I?=
 =?us-ascii?Q?lRQGE7pTAZPaCcV2F5deLQu2t6+IWEPNeiHG/fqkjhyqn8McGOEun+eT6+Qc?=
 =?us-ascii?Q?ND1RgP0BsyPmBgTFJnxMjoQeTzE0U19mMIlhvwBT4MjkZOWrE4YIbkUdI9se?=
 =?us-ascii?Q?ELYT0SqqbnnP+u4wMrAKarYj61Dn8oVh0RqM4aJVwx5M4JLwf9U46YdRSK+s?=
 =?us-ascii?Q?Mwru9gNYl7sHKJiFrANCBCIvGVDQ7txX6Sc7y2HYtwyxZGD3K5rSi09HILw0?=
 =?us-ascii?Q?WnLHPe2aal3jPqoPBb1hNWqLnDN8RF12+cXbrJ242LvKSXYXXmvxp0r5pVIx?=
 =?us-ascii?Q?bjafZOk3sN1CPDjVTgQqI19axBRvuzZFRaFyX05Fh+3iToJWR/6vSx/vV2mJ?=
 =?us-ascii?Q?jSW1zLkTIjUhK8Wo9s971WhLFnErssiP9M/9euNAnBelqaTbXZW0uUoEWdkB?=
 =?us-ascii?Q?8C61ZCVK0MW9p7K4iIIyKHrmMAWTg+Ml2AoZHIcU5/QG/zpA2bnNdAxwGO8w?=
 =?us-ascii?Q?VCJo2ZYUdOxzpaYuBVqjS9pf4EO2gPBvrFTOLXHmM8PKROirPlsiVHGHTLtL?=
 =?us-ascii?Q?fcPVBPNqR5wOU006g84MgqtmLMW5USSuGP1/CEt+RSqRNnb+dV5HSBSJGja5?=
 =?us-ascii?Q?A8uRoh0C4ShfTtiitJVY9/0bwakNWQuh3y0G2QlsVR4OmXaZMh4kDOPX8PIY?=
 =?us-ascii?Q?gtt7GUsXLVx66khJ1wM/4KSYjItklQlKNe421p5FiYfvL0la/6MHLZT5U27R?=
 =?us-ascii?Q?zQyWo8nqzrgL7MRiMUkE+7CLSbdqxBVgCwFry6n8i0/5MOWw3j1avRbNs7D4?=
 =?us-ascii?Q?OFJ7RZ+t1BwoIiL/JV1soi/yeb6+GQHL0pb/zg/Gpi+okO/1qHthv4YKy8S1?=
 =?us-ascii?Q?/jV8uTY4LCikNKik/o//I+j9FYKqRaV960yi2CKAI6xGra6IN4ok0dziskrR?=
 =?us-ascii?Q?05n4pWZIEPqFFcafRvuwPwSGuU6SJDdeu+JuFS9kIsj2sFL1Sv406WOaDp0e?=
 =?us-ascii?Q?Gl7KRDRql6VMQSuCgxmx+OZg95oFI6NR/dXMoDHiHtT6yaqs3bvkIYJTugdk?=
 =?us-ascii?Q?CFsYL8xj8181Lfi61TlisdJ3nLAY67flXKyHnsl3nDMoWnd2DlPHQLaSYtAf?=
 =?us-ascii?Q?1cp2GIhHq+9VnaNwTXdggm8IcBu6GiEl29vxr0Ie/FMM8Hdi6YHUzyT7xpWX?=
 =?us-ascii?Q?884slYbtVbaLSuz0894Y1tfjvKoMA2eCzlhR4IeUYpjwMQxQ1QJgGnthOrme?=
 =?us-ascii?Q?8jfiac+7Y5CzEuBTMR+8wfI/8SPshztj/Qr5Xp/JWH6h3dC1XcKECJPMRoUp?=
 =?us-ascii?Q?5wXthrIrVolQgIjOJx5g6Vhz5Sdi/2sA9G/2VEEUyjkahA/O7aKPWJ3nyDT1?=
 =?us-ascii?Q?UVLN7prUosXKX4GIN0TfZ0poe2I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12ae080-b983-49ca-5659-08d9ad486a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2021 23:41:18.4294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c108DeCsqMHlBvU8gTNk4VNsEZeryv7yb6GsY19XrzNuhCDIlEKkrj6GvMH3pRBYKwPPADp+HDpOXJBGqKPPzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4923
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/20 1:45, Palmer Dabbelt wrote:=0A=
> From: Palmer Dabbelt <palmer@rivosinc.com>=0A=
> =0A=
> The "k210_generic" DT has been the default in Kconfig since 7d96729a9e7=
=0A=
> ("riscv: Update Canaan Kendryte K210 device tree"), so drop it from the=
=0A=
> defconfigs to avoid diff with savedefconfig.=0A=
> =0A=
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>=0A=
> ---=0A=
>  arch/riscv/configs/nommu_k210_defconfig        | 1 -=0A=
>  arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 -=0A=
>  2 files changed, 2 deletions(-)=0A=
> =0A=
> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs=
/nommu_k210_defconfig=0A=
> index 89ab76349ea8..e8ceab678e8b 100644=0A=
> --- a/arch/riscv/configs/nommu_k210_defconfig=0A=
> +++ b/arch/riscv/configs/nommu_k210_defconfig=0A=
> @@ -29,7 +29,6 @@ CONFIG_EMBEDDED=3Dy=0A=
>  CONFIG_SLOB=3Dy=0A=
>  # CONFIG_MMU is not set=0A=
>  CONFIG_SOC_CANAAN=3Dy=0A=
> -CONFIG_SOC_CANAAN_K210_DTB_SOURCE=3D"k210_generic"=0A=
>  CONFIG_MAXPHYSMEM_2GB=3Dy=0A=
>  CONFIG_SMP=3Dy=0A=
>  CONFIG_NR_CPUS=3D2=0A=
> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/=
configs/nommu_k210_sdcard_defconfig=0A=
> index 84b87f8bfc8f..46aa3879f19c 100644=0A=
> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig=0A=
> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig=0A=
> @@ -21,7 +21,6 @@ CONFIG_EMBEDDED=3Dy=0A=
>  CONFIG_SLOB=3Dy=0A=
>  # CONFIG_MMU is not set=0A=
>  CONFIG_SOC_CANAAN=3Dy=0A=
> -CONFIG_SOC_CANAAN_K210_DTB_SOURCE=3D"k210_generic"=0A=
>  CONFIG_MAXPHYSMEM_2GB=3Dy=0A=
>  CONFIG_SMP=3Dy=0A=
>  CONFIG_NR_CPUS=3D2=0A=
> =0A=
=0A=
Then maybe also delete the arch/riscv/boot/dts/canaan/k210_generic.dts file=
 too=0A=
? It is redundant now that it is not being referenced...=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
