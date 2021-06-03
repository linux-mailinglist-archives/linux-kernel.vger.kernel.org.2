Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4CB399E65
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFCKFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:05:03 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23254 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622714598; x=1654250598;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LiYzP/z5U6ZzhBF41v/Tug5NJAqIj/52gBXx4B15wJE=;
  b=rTft3KG1aiN8Ev/U3ksagXubv7Zi+oosKwwqKxu6xKOzT33Cl6jI0uo8
   MkM5x5B6KwiA5bft6V1CQhrbyc7xxVBZHiozGIQ032EJSdiPlNvernwfH
   foAE9H6wFoVttd3Be1w8aOEtTtsU3Xx7VslOg51IqNNVnzAXPC/eJURmo
   qQqQ26Ir8Pi396l8YpaK+YZ4qB1WqbTTBzjiKMFHRrlzu7lDVoiS087Ln
   YBW/lCg9LVRclrINcP3nASTo0/dOsgNzRL60htyi1QBf6vg7UTJY3JlUI
   H3HPyJvrMmlH16XnlskBTEeQBtoWHz77EE3U8fxbiAicRRh2rdv1noOR5
   A==;
IronPort-SDR: ooCM1a3wU9wy0LRR46V2lbxOf2MC42Z9ahBcXySj9Z8j8b34Mqyslvlb75TpPARFjy+0f9Bw6x
 9pOeh4ogUCsyJPogtaK6ag8FXkxCqjVzlrbs2vN2j3ry2xhQrrrCCQEaLYmjp/uDxckzdnBL7o
 wGuOZp2y0vZ2M43mS2uXbJBiOaX8lE2XtN9K3YYekW3y+d5I7YRQ+MVRZddx+55Wc33UNtLAsO
 zRWpsAJKmKFT1f0hLOPgE9A+GF7Y4F6dJ1k3dxsYwmWVHblsZV/bVhYfKBq7RLz7gxQtyxjNj2
 Sc0=
X-IronPort-AV: E=Sophos;i="5.83,244,1616428800"; 
   d="scan'208";a="171091076"
Received: from mail-dm6nam08lp2049.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.49])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2021 18:03:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+Y+l3XGGUReT3uX7uXIU0B9gLev8KVbZ5a5J15jsKQBhK0QNXD7HuXbYY6Dbfl50H2wbhO+mCvO2q1f+BxPRrLwqzteEMOBiSes4y1AIz0FZNTJP3C8PmVeEdUutyFfSdBm0XEtOG3pswT4SQ3DllTF8Ckg5YpVauXBhXL4L3FtJFZhR+buMmvkmGN3TXWhBqQcJ46rPNqsOJkCItAz9eOk7euP6clnT1dhygX0nvDCL/vNXZ4vB1JLOsV3/IZLyLBuuXcUxNWs81AD9sx4b/Mag/6JHYwGFgZZa9xRk6AKIupL71mv3es+vdbe1uv4T0QCSSNEgIMyvIIEqFnxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5V6MY3rcwik0w+TqTRtwnSfqQ6SYWGlEtZZA7gI+Uk=;
 b=XnSTKpArbimkqVdJGeLgWqDjw5e8zavj0EVCZJQWklAHVu7+mNnYW0P4Iq2MArfKGLlOTmyeL7PS0bzYIXWKxM5p7GuN82zhr+7RH239QcA9zwPUPUbA+cvgfLXT2so6qtsQdRUfI+Azo2/M1/SwwKWEAHUuftDYkI0B/qtkxTUaqUhlBOp+0npb9MX2wmWrZYwqaajP2WQH6C36e1Tsd/IyKxj5JeIrd/2DtYMozPs141w/gCSQiWDADkcpcKqrdezZ8EL3FEZB6jcwLEkIMH+Wzbv0czRAjdHH6Z6q5zq0vInC6YLPLVc4aH+bEQFdRHxoD4m+rf2t4TU4WOt7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5V6MY3rcwik0w+TqTRtwnSfqQ6SYWGlEtZZA7gI+Uk=;
 b=iZChNBvwxsfiRpILsiuvbzC8W/8jFxTrwMHnwzjDxUfOZFMLRwSZYL511mBnCU9B2EdWIAb2FJAQJUpjCsFOYlrkObOrGAo/clImY0OpYI/H+X0mbj130/duoOiqGz+rw+9LdMRmqYMDJ1Xx6QZ3ETsSqZjDF60AvMaAAn/Y1PY=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5595.namprd04.prod.outlook.com (2603:10b6:5:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26; Thu, 3 Jun
 2021 10:03:15 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 10:03:15 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: drivers/clk/clk-k210.c:717:6: warning: variable 'reg' set but not
 used
Thread-Topic: drivers/clk/clk-k210.c:717:6: warning: variable 'reg' set but
 not used
Thread-Index: AQHXWFvRoJxiJ4iKDEyXDkfjZQlCcg==
Date:   Thu, 3 Jun 2021 10:03:14 +0000
Message-ID: <DM6PR04MB7081C0499CCCA8C9B9E36610E73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <202106031749.dSbBjn30-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:467:7587:9599:cace]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc7b77c3-24bf-4a96-6446-08d92676cdce
x-ms-traffictypediagnostic: DM6PR04MB5595:
x-microsoft-antispam-prvs: <DM6PR04MB5595ACE5C06C79A7D3588ABCE73C9@DM6PR04MB5595.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:20;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oNZ3cue0dmWK9DDvYFVj9VInyWzjw+wEDcM+NeHHERdpylaVFMJeZGnavXeegaUDmajAkjaJy2v+cbzF+HvZBE5NDoqp4OtfeuHEEpbVyEYlm1F8j9ujCCPdAYWUPnNLGx8RGKutaXsUHEpYVj4lR9qPDcqDu3z6nBJaB5o9iRr6LHTmrjAeEN7Idg7isxws1+ayIZ8aWmpp5nH6OxNU6cDTom5uiCgMJKoJIiZKXXLKWRAkmIXxuXhNfBvTkVwLMuHskmmOAY40AHW4GpCWi2cOp5nIXBj/DGpIKm+xsdMvBZy0tAUQ3WrZk9I15s/Zl+knTp4ex5EVGlJz+9mTCA12YQ/mq4ha7yaVvaHTjgaqTRqCK0URdBYeiQOpA7IYeGJSCDTJStvsONg6r0DdiIqOYkxFheMatm5An/PwMkGOjxkK10WzmrTp95IhacFjOtVQ1Ya7JBZoCgh2OgQ8XYbgRGXIw61PiRQJEkfCpR+BQkU5+R4zxDByhmtnY66d0RWxD6DDFTHAUor1PFua9vWRt8RdsVwA46pqEW7GVmzgkeD1Vt05zesEcBVVl5t0IDMmDwEwENbB4ccpsw9Lji72p/XM2sjrNJ/QejfXjj0YbgLucTiAS42GT0vjAHp10nSEU85s5zBczEmHi3xf+e+RbQKSHPwLOzgIapUiu00xWKjnLL5NoYHgVV3lx1zeoesLn2tgXsFW59aAUsEgH07htyn4oHilqhpwXSf3BDr6ifisuiW1wSBzlAkr3HXE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(8936002)(9686003)(4326008)(2906002)(33656002)(86362001)(478600001)(966005)(55016002)(66476007)(122000001)(91956017)(8676002)(6506007)(5660300002)(186003)(52536014)(64756008)(66946007)(316002)(53546011)(71200400001)(7696005)(76116006)(66446008)(83380400001)(66556008)(38100700002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TTBPFtUb0tSLHpL5RPuzdqNu46OmmpSVrjrOF4+1OZWBiiWfyZEIaD1+xLhr?=
 =?us-ascii?Q?6CGEMqb+fZ+vZ2qjlHAPNPYsMkOWz80jfSWjY9SSgG2yyhUYHtdxrNOqeVpD?=
 =?us-ascii?Q?RtQPOdW1lZlckKOr4AQUe6U+ev8HMIbCeaUxuJWH6pGsZbB9lFnFyxjC7xqS?=
 =?us-ascii?Q?gMD3pIvrWjSlA3GQtbQsF/EDJyQlbPjtGBXhO7zPNJEzzWKJAMDPfHkjIOSX?=
 =?us-ascii?Q?A1q1ubE7BwQHtTa+ut+WcJvHpuTmu8QI2V5n20Pica6bysSx7B0dhrzHz17Y?=
 =?us-ascii?Q?2z6t/xzpcJYnK5LRsQSmVbU/x1FM35KnFV/VQcYUG2G5JTkwzVJb+rPZXwGK?=
 =?us-ascii?Q?tA1rP9PeldJeRS0rNE3XgANL/nU2h8iA7OFe+D5rgssv6HpET6ETetO6cXXu?=
 =?us-ascii?Q?okWjCg15jfzGRC+FBgki5kaUIx1XBsGEcJe+MFmi13AaV3kzPesc7SWXOpcC?=
 =?us-ascii?Q?B3kyMFmgh01gzMJf2PtPyLYQM1eD7qV/QOiP9PMfXN1SYqBYAplf/iHZ/DXs?=
 =?us-ascii?Q?zGT/7kn2o48OOukGtEYxlf/2irtd0HGDyMPHbtVZBWtEmJMm6Dvu26MWfTiC?=
 =?us-ascii?Q?wkHDx2WYDwreircYcevftBnrnmrsKFK9Rp+Dsrx+vgOpqyCrgNK62UzIV7Bu?=
 =?us-ascii?Q?pEt7MsNKlqtkNBGfy6BWoA+5zbeGdJQH37GloJjAsXOG0Z0vzwtG1hwQw0KV?=
 =?us-ascii?Q?QY9b8D7RF4njB2lqbPT28QiQGA1mU7T+ya01YAVOxrAp2/mUwy8Rr3NQDzQe?=
 =?us-ascii?Q?2nfaNKmC1bugwnxUlOkHjCGHDWOGVMFcrML8RAbz+xgNdB68sOQhc4VWQnJi?=
 =?us-ascii?Q?vOJhUdBhwhEVopEzJ+5+pjYqb6yq+F3zKewnzmp9Aa/dA9cb3+i1hfgpdcvh?=
 =?us-ascii?Q?WNV3VwWAus7S2CKh2xgbAfKanjnLDLU7dvdPJASl47CCFCQesMg1IvuC2wa3?=
 =?us-ascii?Q?eSevTgNrAd5NGxCKm+tzdN8r4qWeWKpGBE+RILxLYjzVFX0FyQORk/iDC05/?=
 =?us-ascii?Q?dLTkE04W0yoYVAeMQ3DmnXDNWPQrPJ5vz/d+d/3Gkrc0OWuwRlCZfM+VTwqb?=
 =?us-ascii?Q?sgWiR1X+/w12yvGnQMBIWf5/JH2ShGju6fEyEx+MpU5XVt9z9MdxCoBl7YLV?=
 =?us-ascii?Q?zmhgE4Qus4oeGfNeHlcG3Zo+0SLJVgkr3u1MsqwbA/oJb7Fhs/1+BBLvAnP6?=
 =?us-ascii?Q?/8ZVXKV/YVNd6+3BfbleaiPkdFFohxVZ5Cb7gZoSxL/UYl+1W50fYebw0IF1?=
 =?us-ascii?Q?+veeiTIz2KQD0E7W6tD5Q/sTAZj7T2pSSbmW3CJWYugb8s0GV/KgLyRqAFSm?=
 =?us-ascii?Q?3Sj4gQQQhV93lGKlZet2wci+X/nGFyuwcMAsDPGdpzFL0VuvPGBHoS8Aw/gx?=
 =?us-ascii?Q?gSMVplYmXV4mMpG66yb2f5tdwhHi3jjjIPYgqIX1JCFR6CcXJg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7b77c3-24bf-4a96-6446-08d92676cdce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 10:03:14.9551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mlxLHJv4EDatrJ4VTYYMoxgAvlRBlfDEi32TD3MScnFZj0KiarcoBcaIP2QV+th5dRJcPFCSsnyyjSKfBZqwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5595
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/06/03 18:35, kernel test robot wrote:=0A=
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master=0A=
> head:   324c92e5e0ee0e993bdb106fac407846ed677f6b=0A=
> commit: c6ca7616f7d5c2ce166280107ba74db1d528fcb7 clk: Add RISC-V Canaan K=
endryte K210 clock driver=0A=
> date:   3 months ago=0A=
> config: riscv-randconfig-r033-20210603 (attached as .config)=0A=
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project d8e0=
ae9a76a62bdc6117630d59bf9967ac9bb4ea)=0A=
> reproduce (this is a W=3D1 build):=0A=
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross=0A=
>         chmod +x ~/bin/make.cross=0A=
>         # install riscv cross compiling tool for clang build=0A=
>         # apt-get install binutils-riscv64-linux-gnu=0A=
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3Dc6ca7616f7d5c2ce166280107ba74db1d528fcb7=0A=
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git=0A=
>         git fetch --no-tags linus master=0A=
>         git checkout c6ca7616f7d5c2ce166280107ba74db1d528fcb7=0A=
>         # save the attached .config to linux build tree=0A=
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross AR=
CH=3Driscv =0A=
> =0A=
> If you fix the issue, kindly add following tag as appropriate=0A=
> Reported-by: kernel test robot <lkp@intel.com>=0A=
> =0A=
> All warnings (new ones prefixed by >>):=0A=
> =0A=
>    In file included from drivers/clk/clk-k210.c:8:=0A=
>    In file included from include/linux/io.h:13:=0A=
>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>    include/asm-generic/io.h:556:9: warning: performing pointer arithmetic=
 on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>            return inb(addr);=0A=
>                   ^~~~~~~~~=0A=
>    arch/riscv/include/asm/io.h:55:76: note: expanded from macro 'inb'=0A=
>    #define inb(c)          ({ u8  __v; __io_pbr(); __v =3D readb_cpu((voi=
d*)(PCI_IOBASE + (c))); __io_par(__v); __v; })=0A=
>                                                                          =
  ~~~~~~~~~~ ^=0A=
>    arch/riscv/include/asm/mmio.h:87:48: note: expanded from macro 'readb_=
cpu'=0A=
>    #define readb_cpu(c)            ({ u8  __r =3D __raw_readb(c); __r; })=
=0A=
>                                                             ^=0A=
>    In file included from drivers/clk/clk-k210.c:8:=0A=
>    In file included from include/linux/io.h:13:=0A=
>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>    include/asm-generic/io.h:564:9: warning: performing pointer arithmetic=
 on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>            return inw(addr);=0A=
>                   ^~~~~~~~~=0A=
>    arch/riscv/include/asm/io.h:56:76: note: expanded from macro 'inw'=0A=
>    #define inw(c)          ({ u16 __v; __io_pbr(); __v =3D readw_cpu((voi=
d*)(PCI_IOBASE + (c))); __io_par(__v); __v; })=0A=
>                                                                          =
  ~~~~~~~~~~ ^=0A=
>    arch/riscv/include/asm/mmio.h:88:76: note: expanded from macro 'readw_=
cpu'=0A=
>    #define readw_cpu(c)            ({ u16 __r =3D le16_to_cpu((__force __=
le16)__raw_readw(c)); __r; })=0A=
>                                                                          =
               ^=0A=
>    include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded fro=
m macro '__le16_to_cpu'=0A=
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))=0A=
>                                                      ^=0A=
>    In file included from drivers/clk/clk-k210.c:8:=0A=
>    In file included from include/linux/io.h:13:=0A=
>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>    include/asm-generic/io.h:572:9: warning: performing pointer arithmetic=
 on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>            return inl(addr);=0A=
>                   ^~~~~~~~~=0A=
>    arch/riscv/include/asm/io.h:57:76: note: expanded from macro 'inl'=0A=
>    #define inl(c)          ({ u32 __v; __io_pbr(); __v =3D readl_cpu((voi=
d*)(PCI_IOBASE + (c))); __io_par(__v); __v; })=0A=
>                                                                          =
  ~~~~~~~~~~ ^=0A=
>    arch/riscv/include/asm/mmio.h:89:76: note: expanded from macro 'readl_=
cpu'=0A=
>    #define readl_cpu(c)            ({ u32 __r =3D le32_to_cpu((__force __=
le32)__raw_readl(c)); __r; })=0A=
>                                                                          =
               ^=0A=
>    include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded fro=
m macro '__le32_to_cpu'=0A=
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))=0A=
>                                                      ^=0A=
>    In file included from drivers/clk/clk-k210.c:8:=0A=
>    In file included from include/linux/io.h:13:=0A=
>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>    include/asm-generic/io.h:580:2: warning: performing pointer arithmetic=
 on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>            outb(value, addr);=0A=
>            ^~~~~~~~~~~~~~~~~=0A=
>    arch/riscv/include/asm/io.h:59:68: note: expanded from macro 'outb'=0A=
>    #define outb(v,c)       ({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBA=
SE + (c))); __io_paw(); })=0A=
>                                                                  ~~~~~~~~=
~~ ^=0A=
>    arch/riscv/include/asm/mmio.h:91:52: note: expanded from macro 'writeb=
_cpu'=0A=
>    #define writeb_cpu(v, c)        ((void)__raw_writeb((v), (c)))=0A=
>                                                              ^=0A=
>    In file included from drivers/clk/clk-k210.c:8:=0A=
>    In file included from include/linux/io.h:13:=0A=
>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>    include/asm-generic/io.h:588:2: warning: performing pointer arithmetic=
 on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>            outw(value, addr);=0A=
>            ^~~~~~~~~~~~~~~~~=0A=
>    arch/riscv/include/asm/io.h:60:68: note: expanded from macro 'outw'=0A=
>    #define outw(v,c)       ({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBA=
SE + (c))); __io_paw(); })=0A=
>                                                                  ~~~~~~~~=
~~ ^=0A=
>    arch/riscv/include/asm/mmio.h:92:76: note: expanded from macro 'writew=
_cpu'=0A=
>    #define writew_cpu(v, c)        ((void)__raw_writew((__force u16)cpu_t=
o_le16(v), (c)))=0A=
>                                                                          =
            ^=0A=
>    In file included from drivers/clk/clk-k210.c:8:=0A=
>    In file included from include/linux/io.h:13:=0A=
>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>    include/asm-generic/io.h:596:2: warning: performing pointer arithmetic=
 on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>            outl(value, addr);=0A=
>            ^~~~~~~~~~~~~~~~~=0A=
>    arch/riscv/include/asm/io.h:61:68: note: expanded from macro 'outl'=0A=
>    #define outl(v,c)       ({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBA=
SE + (c))); __io_paw(); })=0A=
>                                                                  ~~~~~~~~=
~~ ^=0A=
>    arch/riscv/include/asm/mmio.h:93:76: note: expanded from macro 'writel=
_cpu'=0A=
>    #define writel_cpu(v, c)        ((void)__raw_writel((__force u32)cpu_t=
o_le32(v), (c)))=0A=
>                                                                          =
            ^=0A=
>    In file included from drivers/clk/clk-k210.c:8:=0A=
>    In file included from include/linux/io.h:13:=0A=
>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>    include/asm-generic/io.h:1005:55: warning: performing pointer arithmet=
ic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>            return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;=
=0A=
>                                                      ~~~~~~~~~~ ^=0A=
>>> drivers/clk/clk-k210.c:717:6: warning: variable 'reg' set but not used =
[-Wunused-but-set-variable]=0A=
>            u32 reg;=0A=
>                ^=0A=
>    8 warnings generated.=0A=
> =0A=
> =0A=
> vim +/reg +717 drivers/clk/clk-k210.c=0A=
> =0A=
>    710	=0A=
>    711	static int k210_clk_set_parent(struct clk_hw *hw, u8 index)=0A=
>    712	{=0A=
>    713		struct k210_clk *kclk =3D to_k210_clk(hw);=0A=
>    714		struct k210_sysclk *ksc =3D kclk->ksc;=0A=
>    715		struct k210_clk_cfg *cfg =3D &k210_clk_cfgs[kclk->id];=0A=
>    716		unsigned long flags;=0A=
>  > 717		u32 reg;=0A=
=0A=
Palmer,=0A=
=0A=
I do not think this driver is the real cause of this error. Did something c=
hange=0A=
recently with risc-v mmio readl()/writel() ?=0A=
=0A=
>    718	=0A=
>    719		spin_lock_irqsave(&ksc->clk_lock, flags);=0A=
>    720		reg =3D readl(ksc->regs + cfg->mux_reg);=0A=
>    721		if (index)=0A=
>    722			reg |=3D BIT(cfg->mux_bit);=0A=
>    723		else=0A=
>    724			reg &=3D ~BIT(cfg->mux_bit);=0A=
>    725		spin_unlock_irqrestore(&ksc->clk_lock, flags);=0A=
>    726	=0A=
>    727		return 0;=0A=
>    728	}=0A=
>    729	=0A=
> =0A=
> ---=0A=
> 0-DAY CI Kernel Test Service, Intel Corporation=0A=
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
