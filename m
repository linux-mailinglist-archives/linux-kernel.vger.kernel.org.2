Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74A53DCE03
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 00:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhHAWvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 18:51:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:1030 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhHAWvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 18:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627858255; x=1659394255;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G0GALS+hG1vQJ0707vVFbcBcJjOCVCD0gzsxh9lPln4=;
  b=baiv/Jx8a4d0Qp0SAWEgOwjd4a3UKwEwL1DEuXqvbyZLCzr9PUFfVEk1
   lVHzZMdmapJt8fq3U4dY+1eCFkn27IcIiKwEOP2+g5EkE5yrcb3merreG
   wD6Yam18Lbh0Hd0nRw6BByHE4RmFlbPz6LrK0I3iED0u5Pcukgnbqb2wy
   abpeudOyA8xdVi8kT0RKiZ990H1NzCPK0rl07Joepxm9ORF0B/MTIziAi
   n1p1BUogDYuN6XgpHMLELppB7BMQt2unNjycmLE00Ll+YI+glCzFV6AAS
   3fJg/H2iWGtv8UO1PEN46uXHtDsqr8OJCSP7P6oE7ZcsPPgRCks3XOQXI
   g==;
X-IronPort-AV: E=Sophos;i="5.84,287,1620662400"; 
   d="scan'208";a="175239334"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2021 06:50:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOIr1FpL9LVUtje+zJtVtaypATioK90fpB038nhzsgG5gN5JAfH0G+d2YmRWWPkg/+zSKBm5bLhuWKys6pMOWM+UzUvDh8YE29uotCiqqzu2Mhyb9FUv0VNtUHBuOvxQ/eMmOuf32viBByyqbJMBwA40UESPyTsoCa4pdlYgXzZxlat/FRDWpV5MJyjLC9UWJuG0Qcz9Q7DDu7a6eyyP8vh/umOzZdeT81YlvIXH8rOwWxS/x+5EqhRqAAuLBDp7lp70orXd64pm/hS82MYWuwVfvWFMVp3d2QD+s23hzJ1gopolDhH6bP9h24R5UpWR6GnIhsG2dJ3sccLndzyQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2mu4RtN3lAiyULl9XU+75zCyJtUwm1fZ44X6vOe9Xw=;
 b=ABoxu2B/pHPArILvlpw6JIIed8AcTtwyKYQLrHN9mgxB88B7KkIjZvwj09liB4qp7FpXyXKQfgVDPg6amHB5X0wsfr9GtElGk+kIAb1/0Ex0/viahuXYOuyrHUTEICxd/+NW9vkLIcXdRKjLuGb2v0AfvP1udOAi5q33jTCo5SuhKLJUjsAe8EB/8Q1M8dpO8nS4u+H4TnWmsrPvGKw3Qhd9XnXnd3rh9GY9YxeRBbFpBUIsutfpE/oCqXklHYEG3B4Nd8nAD7GU1ir1/ZPN8IAeX6o7IjlxswMgNcY91agyAuIrTZEXYxDFZDcD1wfFKqVca7HK40e1XHvpduKzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2mu4RtN3lAiyULl9XU+75zCyJtUwm1fZ44X6vOe9Xw=;
 b=VFZQLHlOLGrgxdkycPdO+1jJc9JMKwCikuOIrLvx5jV5Aw2p+5M+1frzfSBctMBt9l59swWKYKrLWKXwQHdKrVrn9fg3Gs0LbG+kHj6+gT+DtYdltsB2soE5PM8amRmiUySOit1PK/a8Vu0tgp2knSYatThRvgq+aDcu5vunIbc=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4011.namprd04.prod.outlook.com (2603:10b6:5:b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Sun, 1 Aug
 2021 22:50:52 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028%9]) with mapi id 15.20.4373.026; Sun, 1 Aug 2021
 22:50:51 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sean Anderson <seanga2@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [kbuild] drivers/pinctrl/pinctrl-k210.c:970 k210_fpioa_probe()
 warn: 'pdata->clk' not released on lines: 962,968.
Thread-Topic: [kbuild] drivers/pinctrl/pinctrl-k210.c:970 k210_fpioa_probe()
 warn: 'pdata->clk' not released on lines: 962,968.
Thread-Index: AQHXhUlGkK2/Qd3QB0KZXcw0MomUpw==
Date:   Sun, 1 Aug 2021 22:50:51 +0000
Message-ID: <DM6PR04MB708187FE0B622791011BEEB7E7EE9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <202107302010.QfgLffbI-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e63e1c7-c43d-47dd-60b9-08d9553ed02a
x-ms-traffictypediagnostic: DM6PR04MB4011:
x-microsoft-antispam-prvs: <DM6PR04MB40116774BF337F27C9E81D8DE7EE9@DM6PR04MB4011.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uFv/cIZxfZiFxBDIxh20D4QxTaLkF5Mb5B3SphlfobZQsG21m6ia5a4QixTmcUTFYYHlZu75oRF6EHlp2hQO45zJot/zwbxUB0suNwTnCNT56SA5kz2v966+sLOUsbEjenaman9+db7YUGlNwuDCWiEc3a+a7LIknsTXN/lZ1PdOTRJEKx2YTL/wfe1rvWBFEsvdAtq9ayq1xJCnGms6GftBZDO+OAd5r3+YwDhQRh6+itRql15JhHkSCOwSOxkIyVb/zI5iRFVAxldVmBG6232HZZ4dqJTABB6DWWTBsr1kB7v/GFz0lYjUD/XBpr6zH80f/rgyGRaTeX3EPFJDWGh0fyAnTLmyEyUKGmEbSbKaC5qVYrUto2G0/H1RKY3AKxyQ7otKotqxaInfPGVV1uUXjDhkz3tncXYN4I3FanR3A7Stf3VE53tozIKCM/ahQKuliGzUzqaRaKWhuJdnEutCySDV/zOr/bj1qIBRVMmLVtNr39Ut74TQzG+kaAqeu4BPyhaqxY0OWYtxxCRLnd1vGuDqwpS4vShErFzsI3APnVucacbirkSchHZe6G/FM2YsSRAfBodPJkx690q8J1A5ASIYGH+w6Y3AOvIERP+CIl9uV3M4O/b2bH0uWrbTsZKdqn6cVbmFT3jvqcWS9gb95yJyL19y5RXMycYNXk/DhrA6MmlESk3rrLqiK3LbiWIjQUhsi6z9IffL49NTbGR8DK2eMJKOM3H84y1qtBn9cCXg9w0H2pY85ul8PhcwVKxCqBYZVMSfzpqZ3iD3RcIVSZ4XUT+yTVMKVJh2SS8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(33656002)(53546011)(122000001)(2906002)(38100700002)(55016002)(6506007)(316002)(186003)(8936002)(54906003)(110136005)(9686003)(38070700005)(66446008)(66556008)(66476007)(86362001)(966005)(478600001)(66946007)(76116006)(64756008)(91956017)(71200400001)(5660300002)(83380400001)(4326008)(52536014)(7696005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lRt+yB7xujn3gVr6dl7npJbrnFmjl5U8ulYUZS6yxtaz9r3uMQu6EkCpYhE0?=
 =?us-ascii?Q?zxv/+tUFYriJ0KnJH7AhkzH6uq+S+31znkPPeFoNBN9rugtYFPDsidpMcMe1?=
 =?us-ascii?Q?sIhcFEG1zqz1A7ExMNAzA4WvWrS2GisEARZgaetmE+jEfzkddgrRGkwofI5o?=
 =?us-ascii?Q?Vk7sHfnhbd35NM/7jilBstCk7LNWBtAInX+xrJxOSFnUJoJz08KsoQY6Vb2m?=
 =?us-ascii?Q?22yhRtj7L/Wy+pm3adWeMDLhNiabTlAK17f/U/nUafyGeJU0JDXQZNiI61nv?=
 =?us-ascii?Q?7LEpvzmt1ZRG43Wrsb3Swzgmx8fHjV5DKWzyN2cukSTlSbIRddVfgIX315F4?=
 =?us-ascii?Q?uFe/6VeqFnWqq32Ym0Jf3Kf5m/5/m05nvPTIyfX3w2UWO9sT6k8Uw84AJhyL?=
 =?us-ascii?Q?+UpET8x2XzABjmVdkJDoTZm+AAqoOGe91vip7Ep1ZCYrc6ZzH2RsPDfE/NKx?=
 =?us-ascii?Q?nuGGp2sCgY993GDjuV/Q3jVyGvMrCgsVp9Uiu0qAxAqDzMs/1iR60QwEblS0?=
 =?us-ascii?Q?D85H3mgGbFfxhiMeljBBZ0GI4AB6dCpWMmTs3f3HwMcZfpraNqf1RJpfPelV?=
 =?us-ascii?Q?d/A5mvFGGk7TRmT6yF3sd5mCFU8jo57/fYa89fT/0ZYSmeM/y5KooqS+hrZM?=
 =?us-ascii?Q?c0d4MtAGvVYb9m1wH77D/YiP+izsu7kJjRIWsVQucCnnokumk7uVeKEE7yXp?=
 =?us-ascii?Q?wBN3Fps0pbwAwyozXexCCpD0jzJU1tQYu92mSlBMpnZD3Ir/S90i7dOai/q7?=
 =?us-ascii?Q?gxFpn3+G59RLx2FF2wdMjoYuQmbM6arXJ2ug/22RkjHDiAieqB5vnf7oUupM?=
 =?us-ascii?Q?pzvJUDk4qAUnHcYQBIvownreTmoY4uFQupKLVVOvZC7Uv6rYCNYmsQY0tBX/?=
 =?us-ascii?Q?e48vujRqQOc9asfOGPqjR27flheZqTI1yFhS+6Zcf8ZGTIHQJbrRoPKzpWyq?=
 =?us-ascii?Q?8lsJSCSxzIDDrS71KFdGibpklr6iV5KqABNB1ifkoXgIYSHMmYF2BYuJ6v4V?=
 =?us-ascii?Q?Qmx0glvpGNdtosEoveQNHq/fTb9+ZzhHQOwd26eMnrQH0CRdy5QBqVm8BKNV?=
 =?us-ascii?Q?k2IkeSCSs1z9iFBeK74DIJjumUnFpkc2UnUDg/byXDUPAdcI4dPbK2RDRdPP?=
 =?us-ascii?Q?JJs9eVjkUte8TKJJp0SDd9GJdfXpxSjQBMiTGwcTADCXgBYg2VuPlTI2vzWU?=
 =?us-ascii?Q?F0z0B8QjI+nmduD3lzqz3+xhqIAGUXDqA+L3tGysNOcMrIoj8TrAIiHtQW/N?=
 =?us-ascii?Q?BAe7jJLXAkBSdlnz9pqDNFmKwFmG5Dw1mvfJ6ASyr3GA4ncD64zFYjdCjwvv?=
 =?us-ascii?Q?MuDLnq/kLhbtUctklTPVTMUx/ikKhzjiikekkFOXEKX6Hz0No/phimSLOoZt?=
 =?us-ascii?Q?Fnx/o/9+o2s7rUXwY+8x67guYAS3287lmFSfFPcsxM3xpal8wQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e63e1c7-c43d-47dd-60b9-08d9553ed02a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2021 22:50:51.7113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwZSGxRW5ljfG5aUpxYXE8xNNu2vytkpQZ3BkSZREsm3JpJoej2KnyyzFLiSk7nqxKYoN5iCz9z2egr9CmBa3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4011
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/07/30 22:46, Dan Carpenter wrote:=0A=
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t  master=0A=
> head:   764a5bc89b12b82c18ce7ca5d7c1b10dd748a440=0A=
> commit: d4c34d09ab03e1e631fe195ddf35365a1273be9c pinctrl: Add RISC-V Cana=
an Kendryte K210 FPIOA driver=0A=
> config: riscv-randconfig-m031-20210730 (attached as .config)=0A=
> compiler: riscv64-linux-gcc (GCC) 10.3.0=0A=
> =0A=
> If you fix the issue, kindly add following tag as appropriate=0A=
> Reported-by: kernel test robot <lkp@intel.com>=0A=
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>=0A=
> =0A=
> smatch warnings:=0A=
> drivers/pinctrl/pinctrl-k210.c:970 k210_fpioa_probe() warn: 'pdata->clk' =
not released on lines: 962,968.=0A=
> =0A=
> vim +970 drivers/pinctrl/pinctrl-k210.c=0A=
> =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  925  static int k210_fpioa_prob=
e(struct platform_device *pdev)=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  926  {=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  927  	struct device *dev =3D &p=
dev->dev;=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  928  	struct device_node *np =
=3D dev->of_node;=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  929  	struct k210_fpioa_data *p=
data;=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  930  	int ret;=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  931  =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  932  	dev_info(dev, "K210 FPIOA=
 pin controller\n");=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  933  =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  934  	pdata =3D devm_kzalloc(de=
v, sizeof(*pdata), GFP_KERNEL);=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  935  	if (!pdata)=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  936  		return -ENOMEM;=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  937  =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  938  	pdata->dev =3D dev;=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  939  	platform_set_drvdata(pdev=
, pdata);=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  940  =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  941  	pdata->fpioa =3D devm_pla=
tform_ioremap_resource(pdev, 0);=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  942  	if (IS_ERR(pdata->fpioa))=
=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  943  		return PTR_ERR(pdata->fp=
ioa);=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  944  =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  945  	pdata->clk =3D devm_clk_g=
et(dev, "ref");=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  946  	if (IS_ERR(pdata->clk))=
=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  947  		return PTR_ERR(pdata->cl=
k);=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  948  =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  949  	ret =3D clk_prepare_enabl=
e(pdata->clk);=0A=
>                                                       ^^^^^^^^^^^^^^^^^^=
=0A=
> =0A=
> =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  950  	if (ret)=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  951  		return ret;=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  952  =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  953  	pdata->pclk =3D devm_clk_=
get_optional(dev, "pclk");=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  954  	if (!IS_ERR(pdata->pclk))=
=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  955  		clk_prepare_enable(pdata=
->pclk);=0A=
>                                                         ^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^=0A=
> No error handling=0A=
> =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  956  =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  957  	pdata->sysctl_map =3D=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  958  		syscon_regmap_lookup_by_=
phandle_args(np,=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  959  						"canaan,k210-sysctl-=
power",=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  960  						1, &pdata->power_off=
set);=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  961  	if (IS_ERR(pdata->sysctl_=
map))=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  962  		return PTR_ERR(pdata->sy=
sctl_map);=0A=
> =0A=
> Do we need to clk_unprepare_disable() before returning?=0A=
> =0A=
> =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  963  =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  964  	k210_fpioa_init_ties(pdat=
a);=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  965  =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  966  	pdata->pctl =3D pinctrl_r=
egister(&k210_pinctrl_desc, dev, (void *)pdata);=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  967  	if (IS_ERR(pdata->pctl))=
=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  968  		return PTR_ERR(pdata->pc=
tl);=0A=
> =0A=
> Here too.=0A=
=0A=
I can add the clk_unprepare_disable() call to avoid the warning, but that i=
s=0A=
rather pointless as the system will not boot at all if there is an error he=
re.=0A=
Thoughts ?=0A=
=0A=
> =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  969  =0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12 @970  	return 0;=0A=
> d4c34d09ab03e1 Damien Le Moal 2021-01-12  971  }=0A=
> =0A=
> ---=0A=
> 0-DAY CI Kernel Test Service, Intel Corporation=0A=
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org =0A=
> =0A=
> _______________________________________________=0A=
> kbuild mailing list -- kbuild@lists.01.org=0A=
> To unsubscribe send an email to kbuild-leave@lists.01.org=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
