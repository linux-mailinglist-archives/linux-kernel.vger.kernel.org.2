Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60495437393
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhJVIWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:22:39 -0400
Received: from mail-bn8nam08on2077.outbound.protection.outlook.com ([40.107.100.77]:27991
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231846AbhJVIWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:22:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDqN26cV+V9jnNDT3IjCOhDRzhSPFDri4EFlJco+hQU0ECJ8m3o9WzPKNsqvGlLvHRacykW9/TI2WY8pW90zMaTVP9KI8oZqG49293eCdu+SkyXhSh8slTdDE4Fam4+Hpl+j1P1RrPS9rBSIppw316dbjWQL2OvxCCxnIguYe42BMxuUjQreE3lxfaXZpK/i3/JxVY0NuibC/c/rz+3epeuRzfzso3+TNpXn71sfNlU8Nmh04yZ+0vwj8iN40x2cUo1MJFKq9NRPXpQlnLnn5k0qbtMDj2/k+WpG5AiRn72TGxFt1kPK1CBPM7r3tW71aBO6IIj5WVwS0YYdSb+NZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb615wigIGZ7TMpTd0alDcLMhRWcmJdManxNcaON6F0=;
 b=TT1838KOGWwo9s/pmyENYQPFljHSSKF1Lp7vHfL/T+nj3N/otmfAqQ6uFRmwM9Dw0Q897NTB8P621DjJrbs9rsu937cBskl9/4OP4rGH+dZ18KNdQp8rpyZeOmPbLKRLeFvKZQULncKfT4CSkmOHD8j5F6xc9p+fcmGqLsSOWiE/dosgS1FWWycoVUKi4BekunGNOCdpCgUAz7UGGPPIf21v73+NksnvAufwpAba8bO5tNyQZqX3pJE8keq0Z+UXXv3qHUY+S8egT9R60c618H24w4yXmW0jaAjr3a+DiO8CHUdJ11i8spWrBrZx5mP4DonpTJC+Cz0WvOsV2gnFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb615wigIGZ7TMpTd0alDcLMhRWcmJdManxNcaON6F0=;
 b=rtTumo9L+Hjgx8WhFHTzwZeL+JzGCBeg1BaZqZ41blsDyu/HMZu/iPXE4UU9fTwRz70wSyGDg73iMS8yYCkOv4Est7Y8M1DZI2ewyN3S/3IANHPybAqcXw5ncCIIdIDf4+lOU8kW2GPhMq2gn4ek6Ia0E3bfAAguYUkTnyv3UME=
Received: from SA1PR02MB8592.namprd02.prod.outlook.com (2603:10b6:806:1ff::18)
 by SN6PR02MB5421.namprd02.prod.outlook.com (2603:10b6:805:e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 22 Oct
 2021 08:20:18 +0000
Received: from SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23]) by SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23%8]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 08:20:18 +0000
From:   Abhyuday Godhasara <agodhasa@xilinx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc:char-misc-testing 49/54]
 include/linux/firmware/xlnx-zynqmp.h:634:71: error: expected ';' after top
 level declarator
Thread-Topic: [char-misc:char-misc-testing 49/54]
 include/linux/firmware/xlnx-zynqmp.h:634:71: error: expected ';' after top
 level declarator
Thread-Index: AQHXxsU/Vlbz1f97Rke203LeX6yMqqveovwAgAAKL6A=
Date:   Fri, 22 Oct 2021 08:20:18 +0000
Message-ID: <SA1PR02MB859220A53FF48190EDD60A8CA1809@SA1PR02MB8592.namprd02.prod.outlook.com>
References: <202110220531.JFx7N8X4-lkp@intel.com> <YXJrOiVJmsn5hkGg@kroah.com>
In-Reply-To: <YXJrOiVJmsn5hkGg@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7acf5419-75d5-472c-37b4-08d99534c863
x-ms-traffictypediagnostic: SN6PR02MB5421:
x-microsoft-antispam-prvs: <SN6PR02MB542105D6A7C6DA2453A5F99CA1809@SN6PR02MB5421.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DMMY2iFsLjJnLJdBGV07cl8xP5t+avKSEL0DFg+CTHZ1WRnY32eRC1ue753Bz8ETcre7mCZkFS7LeZO254Fm3WsATk7Eq2Dy1+cxMXdV9Ly3uLpnhDmnq2VsUjxjOUmZZjBWmvaOPhd24nEk+1Hu5Y0nev+qM+NMb8bPa9nNTcqwkn0hkUX+oGbI/fo+qTXLJ2xjlOrfBRGz4E+ZI3eAQQsd+Tj/h/ZMwGKQD5R3lAjyubQAeHVLxdIbNR74BfPxAj2p9hFZ2Z+4akURJ1rcgvDhI6ylPHoJg32Tohuyc0P6N50NuvnDk9QNwrLD6jLilo/lFjg+6xF4a9c3DFxIuSTXQ0oJauoMTvhXuS4UbKWBrek/gtZW2+VbjitqFQ+sOJANILEkoRHIx0XetqdfEl/S0/wcpw6/0ztGv0TIvJToXC1/572Tlzq8YvmVAOzPEFvQye/n0HXzHsL6KB7oa0w1GS99Dl0XUPxyNC3dDZ+qpTnjnWkKN36KzoyQikbWchrNlRd5Dfpm/qxmcQvTYKAaoKZKz397PEjnHaNVvTqiOD7tsP0FGUHrEgsc9sJfvD9CybSv7pjwuP5UaoyWgtjGnXjXhWUmr4zgBLkBcKQ1w3YUBGYJnpNx9JA5nn90mruzS6FWjaxEA8HLzpjmBV/nzE36n/RjMN8DCDQDgw8qhsf0ohvo0ynFVkT568qXw90EZ/Y4faKEV+CbIGuLjAtiS9ni0tDB35lRTy+Y8acLAcD6vt6thBW+Ge9lc83uuv9zQ8mDAW9kwfi0YZLZpYjFEKVghAoq1APRj2Fq0s+dVXr81BqTIOz15XVYKn4q7k5l7XtISLpZksDrvLcEJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8592.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(110136005)(5660300002)(8676002)(52536014)(316002)(8936002)(2906002)(76116006)(66446008)(66946007)(4001150100001)(83380400001)(38070700005)(64756008)(6506007)(508600001)(53546011)(66556008)(186003)(7696005)(38100700002)(86362001)(66476007)(966005)(26005)(9686003)(71200400001)(55016002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dqHkP3+pI3i/XsbKoCDOj3SKmYVS74gYT4eUT13EXDw3m/OUBDq09zNbmSHU?=
 =?us-ascii?Q?efCMd25OXB4dJke84Mk5MOmTyWaTQSNQ6pjp1FSz/XVla1Q04/M/F7kr7AoS?=
 =?us-ascii?Q?LaR+TCDdIIPD5tMHbwlmWn2f9x3PYeReVxaKrQHcZ6tM53OJENeBAkKvtuVk?=
 =?us-ascii?Q?bdIewit8CE1XAXxeJgFVSsJnHKJn2QD7As2zBptBtUkrZBTZprMfCVjTfuE9?=
 =?us-ascii?Q?mNY3iNCEKl4n9OV0bwBNPw5RzFyR1F9Y3zSPc6uvlt1hDdh8dH0zhWrUpdpP?=
 =?us-ascii?Q?N+y3/mUz1AOAwj1qCaqhTU7QrwnfqP0l1z9bKN79WPgMTCGWFMv9L55ondO0?=
 =?us-ascii?Q?DmBfFSfA0+XGC1zC/MkAybJkJVNT4yao+ypHpDpvNF+vOKU42s82m8cfGm54?=
 =?us-ascii?Q?ezhVZs5e5Cpolbwplu+ZqhUofz3qTOY21VCBmJ6QKAEIeJjRKpIe9QX2LRPL?=
 =?us-ascii?Q?XRGq74KwoZ6Q7ZnwBO9fPJnoTPGrKvciiM70vwn1xxRYPrsarbrK3j/Rzjdb?=
 =?us-ascii?Q?rHkuKK1bRDRjOk5PafgQdFWWgqDftwsZD7uu/iEv6PFP1pDo5d6/EvJiruEs?=
 =?us-ascii?Q?RBxOn9rKxusOoKlmWMSoWX8Z56Fu+kiUmcT3LJK/M0VC5Ad/POJHTBS3GEur?=
 =?us-ascii?Q?0dQxBb6od4hEDNu2YsjUYQKQitEtNNGNRE9Ru6wkLnbfTysR7chl0xZ4lYyA?=
 =?us-ascii?Q?n31anyPEU8hcrh2uqd2A/8uECl1SuNZ3snZ5ur+TPzxlswnqjY+5hWsqSKBB?=
 =?us-ascii?Q?8ymyVxJ+aqtV1neEoWEg1GAdvsy5RinSXRLTAiTbCaxNmBnWwnjBF52M9Q/0?=
 =?us-ascii?Q?HwXjzK8K7ABJve1CRdL6uiYfvxPnMWphy/2Fv+oRBF/6kb4t7xiiU4yAwbUv?=
 =?us-ascii?Q?8Cj8b66uAkaS4qIbu+mS/YhlSv9kVolaSNvTVbM1EdQ9YrARG2KY49wycpYi?=
 =?us-ascii?Q?HOop0A2tQ3pFEK6zEg7O7iDdEAB/x4gZ3q2FHDKu1P0QAXvr0kLas2CDhKGt?=
 =?us-ascii?Q?SsTL1KC14YWMDwRyE6AqbeJhZBXGCmdLYL3qgQgCb53YJHfjUxBmz/EexUXi?=
 =?us-ascii?Q?8HSAjUyCpim/oO/GhDfy/4C9CSHsoUf9lmVqqF3WbhLlDA4txXithLE6x64L?=
 =?us-ascii?Q?Nl42wwNXltNRBmWvXBcAoM0h4odxs+9OJ602nk1pgk1JaDPtLftSzJPGaFu9?=
 =?us-ascii?Q?1I+lpxHNf/bYBr48KsjxsllIbEgw1ZVAoaLdOOYSHmDamT+xqGtKfVPuuwCe?=
 =?us-ascii?Q?dKBxE7JQdeM8M4rMxBUBsEMytYELN9dpX35uoep7JR9q5K980/Z5NYow3cUV?=
 =?us-ascii?Q?h9qbSfl0IX/K2+/LzaJWnXNA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8592.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acf5419-75d5-472c-37b4-08d99534c863
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 08:20:18.1324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agodhasa@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5421
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday, October 22, 2021 1:12 PM
> To: kernel test robot <lkp@intel.com>; Abhyuday Godhasara
> <agodhasa@xilinx.com>; llvm@lists.linux.dev; kbuild-all@lists.01.org; lin=
ux-
> kernel@vger.kernel.org; Tejas Patel <TEJASP@xilinx.com>
> Subject: Re: [char-misc:char-misc-testing 49/54] include/linux/firmware/x=
lnx-
> zynqmp.h:634:71: error: expected ';' after top level declarator
>=20
> On Fri, Oct 22, 2021 at 05:42:37AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-mis=
c.git
> char-misc-testing
> > head:   0a6af10747d4dc25e9c85c7daf156459f28e0e55
> > commit: 1a8eae64b30f126c0786f3807982d49ca3be8f7c [49/54] firmware:
> > xilinx: add register notifier in zynqmp firmware
> > config: hexagon-randconfig-r045-20211021 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project
> > 3cea2505fd8d99a9ba0cb625aecfe28a47c4e3f8)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> misc.git/commit/?id=3D1a8eae64b30f126c0786f3807982d49ca3be8f7c
> >         git remote add char-misc
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> >         git fetch --no-tags char-misc char-misc-testing
> >         git checkout 1a8eae64b30f126c0786f3807982d49ca3be8f7c
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross
> W=3D1
> > O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash drivers/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from drivers/spi/spi-zynqmp-gqspi.c:13:
> > >> include/linux/firmware/xlnx-zynqmp.h:634:71: error: expected ';'
> > >> after top level declarator
> >    static inline int zynqmp_pm_load_pdi(const u32 src, const u64 addres=
s)
> >                                                                        =
  ^
> >                                                                        =
  ;
> >    1 error generated.
[Abhyuday] Place where this error generated are not part of my patch series=
 or changes. Please let me know if there is an any action require from my s=
ide.

Thanks,
Abhyuday

> >
> >
> > vim +634 include/linux/firmware/xlnx-zynqmp.h
> >
> > 2b9fc773c31bb7 Nava kishore Manne 2021-06-26  633
> > 2b9fc773c31bb7 Nava kishore Manne 2021-06-26 @634  static inline int
> > zynqmp_pm_load_pdi(const u32 src, const u64 address)
> > 1a8eae64b30f12 Abhyuday Godhasara 2021-10-21  635  static inline int
> zynqmp_pm_register_notifier(const u32 node, const u32 event,
> > 1a8eae64b30f12 Abhyuday Godhasara 2021-10-21  636
> 			      const u32 wake, const u32 enable)
> > 2b9fc773c31bb7 Nava kishore Manne 2021-06-26  637  {
> > 2b9fc773c31bb7 Nava kishore Manne 2021-06-26  638  	return -
> ENODEV;
> > 2b9fc773c31bb7 Nava kishore Manne 2021-06-26  639  }
> > 76582671eb5d00 Rajan Vaja         2018-09-12  640  #endif
> > 76582671eb5d00 Rajan Vaja         2018-09-12  641
> >
> > :::::: The code at line 634 was first introduced by commit
> > :::::: 2b9fc773c31bb7cb7529757382013a8158bf7e9c drivers: firmware: Add
> > PDI load API support
> >
> > :::::: TO: Nava kishore Manne <nava.manne@xilinx.com>
> > :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
>=20
> I will go drop all of these patches from my tree now.  Please fix up and =
resend
> the whole series.
>=20
> thanks,
>=20
> greg k-h
