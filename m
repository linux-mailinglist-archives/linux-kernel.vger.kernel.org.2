Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5BA3A5B79
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 04:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhFNCKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 22:10:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26276 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhFNCKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 22:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623636527; x=1655172527;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1DC672z388gX3/vg1zWZk58xsepqfDzPkINGLY43z10=;
  b=hJmJD47Edlq5QkWLmB25XQ8f6B6h6AGwUMA9xFqHbNtWcKAyTq6ZN6oA
   /OwItecE+r98qOuJkRJvgTtthoHp2ZrJw5U9aX6awxw5r0y5oVRkGrYi9
   AaLwwwsrFoVOP6kU/GbPGLSNCcNXPDlNmY6uua9fXQX2phyQAWB7zl3mA
   fZClPjNXzfxHd0b8rUmV1dRZPKJejCv+ON7/tfiHAtj4w22fB8ZRIkfU2
   7uhzoCYAiINNT18YhLonDQqNFScWN7ub/WPqWwvNlZwSKEsIK6dgeGlnG
   M4A89r45NkziCRxAi8hY3xJJM6tMv4gXCzup5uXTH+N4V7rWKb6ZGW26r
   Q==;
IronPort-SDR: WGpSnYOjepL9uiEmWNhPdFX4vkWZf7yBtalXjU+WZVkRyAqRY2CPtGTtRUtNdQz2c0suIG30wu
 JfUwm/e6FehF54PyWB5c4vV9lQX1AaIppBJgckt6VPdRbA2n/wknSXY9TXdnYshxiAw0x1TGzo
 C4ShOXc7GH1vxqHvTgIRV0IE486Mp6UgVEerThHfWti1H9HjNfe79RZD5KQw/cpcdtDKMniUj0
 qFFsfRajEFDCON0F8O4eEZnkbWqMClW9A3l2rTjbqIxqAB1roS42Gp7hEmmnQVlXRNFoGRtVNU
 /RY=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; 
   d="scan'208";a="171046679"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 10:08:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLeHAMYPiHZfgA+WSxyk9YKxhmDp/ecD0Yp3AqCrslAYGAUwnJy4LCGksGeb2x5NiV/6gqyX2UTuFYRsIG1KP9xsIn+DaBe2FgI2MKSw3Bh8G2/LRcWXfRDduoCiPubVBpBCF83xBnlLmsN8Gk+EnMH5+7DICO3OBtnc7u1sKZ3I2ipoCZuTDPEveZHMYNTb4IwZcHu46Q8e8o38iw98nF7bnIMWDUU+YcYC/+YW7TSLKxRkuLJw3ANs/FtW5GzKRGzey4mJC4qJ8sLnVg1hNt/IiPQuNJMDDv3YZac8S9xuxLWddonLPcguFQ+jlqzeoFQgKktynDxjsU6HmzwyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZszKIn9xyu/emiAikRqG/4P4B8VEcZ8MwgpJjkO/pM=;
 b=DUGqFtqtOw5saTQSO4pYk0nBm71UT/im1ZQEyvFOf7gxBK7/qp0s1KxNjbqEW4KYxgkGf6yTOS+3vzMmBOovZkogZ7/ZSaDHENNaMaE9mHusbTMjF5ws7c0+hQ1s05I7cx5CV46puGH8Tezd/hrqwLgL3/t8TTQ7Iy0cOFvkJ4csv0abyHao64rs3eKFwuoeqPZMpioATaYq1lKC53JdAxrhMT/PutO5P/HSszTrNcn08F0cbwC5BNdeU6kZvPfwL0JY+fmSDwZPs/G7qbAc6Xg9yJe8EJPjRe7zu2b8HvBoGlruxUBIDiZ9k7coki6Dlz3PP2JDeRUjX4YK8L+XGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZszKIn9xyu/emiAikRqG/4P4B8VEcZ8MwgpJjkO/pM=;
 b=HEvQVjzdCKZEVtU5oJ72NDMTTRatUMStAjvAx5tGi8SvVT9meDaQiIc0uwnP3129z8wyCfnu4CxFDw/ISkTSz4E/A3f2bLlBA40tDlUEnFTg4CoanxcJWu3mCHdZT3fDJ8vsYYKdCsn1NounbrzxpMPu/1UfHWnsx3trDGjgAxQ=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6393.namprd04.prod.outlook.com (2603:10b6:5:1eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 14 Jun
 2021 02:08:43 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd%7]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 02:08:43 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Palmer Dabbelt <palmerdabbelt@google.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: drivers/clk/clk-k210.c:717:6: warning: variable 'reg' set but not
 used
Thread-Topic: drivers/clk/clk-k210.c:717:6: warning: variable 'reg' set but
 not used
Thread-Index: AQHXWFvRoJxiJ4iKDEyXDkfjZQlCcg==
Date:   Mon, 14 Jun 2021 02:08:43 +0000
Message-ID: <DM6PR04MB70818E6C2EEE9BD8F0AD92E2E7319@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <mhng-7814f596-6d02-4031-b90d-7db1cfed8970@palmerdabbelt-glaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:588e:1cca:586f:ab48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07e86bb0-1190-47b9-9f0b-08d92ed955f2
x-ms-traffictypediagnostic: DM6PR04MB6393:
x-microsoft-antispam-prvs: <DM6PR04MB6393CBD0A69792043E1FE1D6E7319@DM6PR04MB6393.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EbOJwexjrRHo+AUdm7eFtbRqveK+IrJV3nM5v9WT03u/sqdyteQgIwCBQ/sFoBmlh5q+hpGnOxJhM3Rcw6lc1L8H+GVRvrp3TLAEAQSXUOR3XKO0kDctslxP0+F+qQRbo3Sr58+HDMsu0IjAKk/fH+xP7RO5vStAGmuMYlC/qF1wFNGoNZfaPwEcgwmCekrGfMTDj+APuUVjZQth7gDRh+bZEZE4nLYy5nWnHRq3oozS5FCEjkfzXR7aD2onO94nTdVIaJ6kLh85XP5MJb+y+YR9qu+kBxg+vlwx6Ap8UciCy+51ZmvkMcDxgSLZTF5fGy96WPhDeiYjP+Ln2B220hDvU/2vhtL7sPKq6xGtF76A/DWO01dZACovzEjiR4CD7V0wXXpqoH+36Z271MjmOTKdyyNTVEfNFidl+MUVTPfbKuEzxX53EaLrIr/XGuC/toO1v7R5p49cRDf9BqxoGtWWygqi/4dMEcUO7fRjNUwkhcw802YDJvl96o2vpxsYmxsymWr2AtJOfDUhoiPGhEA03hcQDqCOGy7exiSsTTFZ2j9VNnahglzxyZ0kg0WDS0QtU1tDceQFQ8imiATutog3evES78Evx1ELx/GVYkTFec+rxhZmEYLuHG9s2d9KoVx4TtBSbwQ2cNm2mnUFNcv6V0aEfWExHyezyVvUJJr8doKsSgeiyl4y6a7MIgWR3F0DxHAG+uebhem0AHG+9QvDtyPxRqZjTHL7ovjWj6bPhxAxWEnfg26LZHeM1NUhAqlyP9UgA33zbeckGGdOng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(6506007)(53546011)(478600001)(54906003)(83380400001)(5660300002)(8676002)(186003)(4326008)(66446008)(64756008)(38100700002)(2906002)(7696005)(6916009)(122000001)(8936002)(966005)(316002)(66556008)(66946007)(55016002)(76116006)(9686003)(91956017)(86362001)(71200400001)(33656002)(52536014)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O+PNBAXgt7bgmCOCt8NR2FcT+HXnsAd7yyYIXZwi67/QNq1mjNBuuc0+EI0V?=
 =?us-ascii?Q?UsQeOh7HgzAjl2G0BaXFkHO78+DiX0z3TN6+RZw57mLU79Gv84gLAlDGSrVU?=
 =?us-ascii?Q?1Mf+e8kWNjqqYLGBoISILUOiunIt7RtmHwM+7m9K+p4emG54f+XMSAsIu53C?=
 =?us-ascii?Q?YJuHSQ5GlwWqPXJ9stkJQpnwpGR6i+AcUqjXFiFS9f+alYTv5Rb5QOoMMHCt?=
 =?us-ascii?Q?BC5TXZ1uFXVsrRO1ZBB5Lfnws4ogN/0h6R15ufZSYshKD4gMWXMr3wPGDbWV?=
 =?us-ascii?Q?tahwWYGQvFYO7jlDDZpDgyyZVtKo5KeQsDfNExP2mOtu5NxtbMccEkKlllwZ?=
 =?us-ascii?Q?us7mPH87EmUt1WYedV/9G+fB7GiZBjGWYPcwY2gqjaRPpCtJKIqZAEo3tnJK?=
 =?us-ascii?Q?ETkUU2gT1bx00R5knUbf2GeAzZwBu5PIThsdkA1YDiIAWRN1DecaQ5idnC5D?=
 =?us-ascii?Q?A1l3poEiA8OdBXQ8FLUV4NwQYP3TcxHG4g9cl2tHTLOal5m+pOjApZaQUeHG?=
 =?us-ascii?Q?x9Tiye4ZYSuYGfZjlVZGATm10n5Qqz6rHoQ7qyzo3r6ZBh2hiDQsODQZGvBM?=
 =?us-ascii?Q?dfUu7eRZjRcaos4r+BloIXqj5VlKnWPauJG4+n5zHliu7h1Vu5O7/+Xiqi4X?=
 =?us-ascii?Q?xXBtud5RZ9KNQ4fPYOOKmGR9ABwgx0iVOEGTs7qcYqGJdRp97GsonswjUQ/e?=
 =?us-ascii?Q?sp0fn4E2CNyoRCB6CSjO3mdNtHpe63nSxA9Caph+geomZgL0WtFjoOJwo4Ff?=
 =?us-ascii?Q?kPqGV6JeD3Eo3sU+wHK1o5ZM4+8ZNiS8/w1pnck21MRP9J2eZh++d9mM6qFz?=
 =?us-ascii?Q?monDTyU/sX1khCoiF4ssUWBpYDdV2fJQR62lfo1PW5DXqIH/+MbPgT2LmAhv?=
 =?us-ascii?Q?6NGJQ4KacEpCR0QuNnXHMrj29+Lb8Bkxc2Na5kLQ4pe9CIXfkDHndptHqmqK?=
 =?us-ascii?Q?zmsfLw2oEf+zACS9oHPKmQQk8CUI6dRAbrZ1gHqBSgXXlYPA/UoSTAqSZbjY?=
 =?us-ascii?Q?f2zgnRhcqpLuvFOMQ3kYbL1eHIhK2EMt4gli4OOgVn8N3x/hcJxMO387liis?=
 =?us-ascii?Q?6SAHbtQMxIrg5ZUTwaAqkJdl0F4KXwvpN5lFeqVzePF2rNMfrAP2c0HDIEX6?=
 =?us-ascii?Q?5cf530Rt8jJoVnxdFNZjxCxAW+62jrJIvU/n22Gs9mSvuElOvRd3cFbveT6O?=
 =?us-ascii?Q?VJYox5bIxWV0Ivui/oc88y4cx/T7g5+UlLtVcvMhyP5jl+sq16PTbVcpvum1?=
 =?us-ascii?Q?VpsxdNaX+0QCwzuZbSky5OBM4PtQf1rprSeprB0Jqb9d2XxarGdqtuhEGtxN?=
 =?us-ascii?Q?Nh+mEmZJyeUvMHR+naoE8JQ6DESWUxO0MaQnv4eWiqBI7YNDusuY5FezyMr4?=
 =?us-ascii?Q?omjBod5YDBED1Ifk1fM7qGamwGpxWWQCtbZ95z9MFMVt42zBFg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e86bb0-1190-47b9-9f0b-08d92ed955f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 02:08:43.3006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9isewrb1ApQiCUGnfYrCifsK9gv7/1IrU54vzHDpX03HWVHcu7QEx2WSbw53nnwLENkOnEdcZvEDhWSlqeM7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6393
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/06/12 12:55, Palmer Dabbelt wrote:=0A=
> On Thu, 03 Jun 2021 03:03:14 PDT (-0700), Damien Le Moal wrote:=0A=
>>> On 2021/06/03 18:35, kernel test robot wrote:=0A=
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master=0A=
>>> head:   324c92e5e0ee0e993bdb106fac407846ed677f6b=0A=
>>> commit: c6ca7616f7d5c2ce166280107ba74db1d528fcb7 clk: Add RISC-V Canaan=
 Kendryte K210 clock driver=0A=
>>> date:   3 months ago=0A=
>>> config: riscv-randconfig-r033-20210603 (attached as .config)=0A=
>>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project d8=
e0ae9a76a62bdc6117630d59bf9967ac9bb4ea)=0A=
>>> reproduce (this is a W=3D1 build):=0A=
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross=0A=
>>>         chmod +x ~/bin/make.cross=0A=
>>>         # install riscv cross compiling tool for clang build=0A=
>>>         # apt-get install binutils-riscv64-linux-gnu=0A=
>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3Dc6ca7616f7d5c2ce166280107ba74db1d528fcb7=0A=
>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kerne=
l/git/torvalds/linux.git=0A=
>>>         git fetch --no-tags linus master=0A=
>>>         git checkout c6ca7616f7d5c2ce166280107ba74db1d528fcb7=0A=
>>>         # save the attached .config to linux build tree=0A=
>>>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
ARCH=3Driscv =0A=
>>>=0A=
>>> If you fix the issue, kindly add following tag as appropriate=0A=
>>> Reported-by: kernel test robot <lkp@intel.com>=0A=
>>>=0A=
>>> All warnings (new ones prefixed by >>):=0A=
>>>=0A=
>>>    In file included from drivers/clk/clk-k210.c:8:=0A=
>>>    In file included from include/linux/io.h:13:=0A=
>>>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>>>    include/asm-generic/io.h:556:9: warning: performing pointer arithmet=
ic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>>>            return inb(addr);=0A=
>>>                   ^~~~~~~~~=0A=
>>>    arch/riscv/include/asm/io.h:55:76: note: expanded from macro 'inb'=
=0A=
>>>    #define inb(c)          ({ u8  __v; __io_pbr(); __v =3D readb_cpu((v=
oid*)(PCI_IOBASE + (c))); __io_par(__v); __v; })=0A=
>>>                                                                        =
    ~~~~~~~~~~ ^=0A=
>>>    arch/riscv/include/asm/mmio.h:87:48: note: expanded from macro 'read=
b_cpu'=0A=
>>>    #define readb_cpu(c)            ({ u8  __r =3D __raw_readb(c); __r; =
})=0A=
>>>                                                             ^=0A=
>>>    In file included from drivers/clk/clk-k210.c:8:=0A=
>>>    In file included from include/linux/io.h:13:=0A=
>>>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>>>    include/asm-generic/io.h:564:9: warning: performing pointer arithmet=
ic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>>>            return inw(addr);=0A=
>>>                   ^~~~~~~~~=0A=
>>>    arch/riscv/include/asm/io.h:56:76: note: expanded from macro 'inw'=
=0A=
>>>    #define inw(c)          ({ u16 __v; __io_pbr(); __v =3D readw_cpu((v=
oid*)(PCI_IOBASE + (c))); __io_par(__v); __v; })=0A=
>>>                                                                        =
    ~~~~~~~~~~ ^=0A=
>>>    arch/riscv/include/asm/mmio.h:88:76: note: expanded from macro 'read=
w_cpu'=0A=
>>>    #define readw_cpu(c)            ({ u16 __r =3D le16_to_cpu((__force =
__le16)__raw_readw(c)); __r; })=0A=
>>>                                                                        =
                 ^=0A=
>>>    include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded f=
rom macro '__le16_to_cpu'=0A=
>>>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))=0A=
>>>                                                      ^=0A=
>>>    In file included from drivers/clk/clk-k210.c:8:=0A=
>>>    In file included from include/linux/io.h:13:=0A=
>>>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>>>    include/asm-generic/io.h:572:9: warning: performing pointer arithmet=
ic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>>>            return inl(addr);=0A=
>>>                   ^~~~~~~~~=0A=
>>>    arch/riscv/include/asm/io.h:57:76: note: expanded from macro 'inl'=
=0A=
>>>    #define inl(c)          ({ u32 __v; __io_pbr(); __v =3D readl_cpu((v=
oid*)(PCI_IOBASE + (c))); __io_par(__v); __v; })=0A=
>>>                                                                        =
    ~~~~~~~~~~ ^=0A=
>>>    arch/riscv/include/asm/mmio.h:89:76: note: expanded from macro 'read=
l_cpu'=0A=
>>>    #define readl_cpu(c)            ({ u32 __r =3D le32_to_cpu((__force =
__le32)__raw_readl(c)); __r; })=0A=
>>>                                                                        =
                 ^=0A=
>>>    include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded f=
rom macro '__le32_to_cpu'=0A=
>>>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))=0A=
>>>                                                      ^=0A=
>>>    In file included from drivers/clk/clk-k210.c:8:=0A=
>>>    In file included from include/linux/io.h:13:=0A=
>>>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>>>    include/asm-generic/io.h:580:2: warning: performing pointer arithmet=
ic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>>>            outb(value, addr);=0A=
>>>            ^~~~~~~~~~~~~~~~~=0A=
>>>    arch/riscv/include/asm/io.h:59:68: note: expanded from macro 'outb'=
=0A=
>>>    #define outb(v,c)       ({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IO=
BASE + (c))); __io_paw(); })=0A=
>>>                                                                  ~~~~~~=
~~~~ ^=0A=
>>>    arch/riscv/include/asm/mmio.h:91:52: note: expanded from macro 'writ=
eb_cpu'=0A=
>>>    #define writeb_cpu(v, c)        ((void)__raw_writeb((v), (c)))=0A=
>>>                                                              ^=0A=
>>>    In file included from drivers/clk/clk-k210.c:8:=0A=
>>>    In file included from include/linux/io.h:13:=0A=
>>>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>>>    include/asm-generic/io.h:588:2: warning: performing pointer arithmet=
ic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>>>            outw(value, addr);=0A=
>>>            ^~~~~~~~~~~~~~~~~=0A=
>>>    arch/riscv/include/asm/io.h:60:68: note: expanded from macro 'outw'=
=0A=
>>>    #define outw(v,c)       ({ __io_pbw(); writew_cpu((v),(void*)(PCI_IO=
BASE + (c))); __io_paw(); })=0A=
>>>                                                                  ~~~~~~=
~~~~ ^=0A=
>>>    arch/riscv/include/asm/mmio.h:92:76: note: expanded from macro 'writ=
ew_cpu'=0A=
>>>    #define writew_cpu(v, c)        ((void)__raw_writew((__force u16)cpu=
_to_le16(v), (c)))=0A=
>>>                                                                        =
              ^=0A=
>>>    In file included from drivers/clk/clk-k210.c:8:=0A=
>>>    In file included from include/linux/io.h:13:=0A=
>>>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>>>    include/asm-generic/io.h:596:2: warning: performing pointer arithmet=
ic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=0A=
>>>            outl(value, addr);=0A=
>>>            ^~~~~~~~~~~~~~~~~=0A=
>>>    arch/riscv/include/asm/io.h:61:68: note: expanded from macro 'outl'=
=0A=
>>>    #define outl(v,c)       ({ __io_pbw(); writel_cpu((v),(void*)(PCI_IO=
BASE + (c))); __io_paw(); })=0A=
>>>                                                                  ~~~~~~=
~~~~ ^=0A=
>>>    arch/riscv/include/asm/mmio.h:93:76: note: expanded from macro 'writ=
el_cpu'=0A=
>>>    #define writel_cpu(v, c)        ((void)__raw_writel((__force u32)cpu=
_to_le32(v), (c)))=0A=
>>>                                                                        =
              ^=0A=
>>>    In file included from drivers/clk/clk-k210.c:8:=0A=
>>>    In file included from include/linux/io.h:13:=0A=
>>>    In file included from arch/riscv/include/asm/io.h:149:=0A=
>>>    include/asm-generic/io.h:1005:55: warning: performing pointer arithm=
etic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]=
=0A=
>>>            return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;=
=0A=
>>>                                                      ~~~~~~~~~~ ^=0A=
>>>>> drivers/clk/clk-k210.c:717:6: warning: variable 'reg' set but not use=
d [-Wunused-but-set-variable]=0A=
>>>            u32 reg;=0A=
>>>                ^=0A=
>>>    8 warnings generated.=0A=
>>>=0A=
>>>=0A=
>>> vim +/reg +717 drivers/clk/clk-k210.c=0A=
>>>=0A=
>>>    710	=0A=
>>>    711	static int k210_clk_set_parent(struct clk_hw *hw, u8 index)=0A=
>>>    712	{=0A=
>>>    713		struct k210_clk *kclk =3D to_k210_clk(hw);=0A=
>>>    714		struct k210_sysclk *ksc =3D kclk->ksc;=0A=
>>>    715		struct k210_clk_cfg *cfg =3D &k210_clk_cfgs[kclk->id];=0A=
>>>    716		unsigned long flags;=0A=
>>>  > 717		u32 reg;=0A=
>>=0A=
>> Palmer,=0A=
>>=0A=
>> I do not think this driver is the real cause of this error. Did somethin=
g change=0A=
>> recently with risc-v mmio readl()/writel() ?=0A=
> =0A=
> I have no idea what's going on here.  When I try to re-build that config =
=0A=
> I don't get any warnings or errors.  That said...=0A=
> =0A=
>>>    718	=0A=
>>>    719		spin_lock_irqsave(&ksc->clk_lock, flags);=0A=
>>>    720		reg =3D readl(ksc->regs + cfg->mux_reg);=0A=
>>>    721		if (index)=0A=
>>>    722			reg |=3D BIT(cfg->mux_bit);=0A=
>>>    723		else=0A=
>>>    724			reg &=3D ~BIT(cfg->mux_bit);=0A=
>>>    725		spin_unlock_irqrestore(&ksc->clk_lock, flags);=0A=
> =0A=
> Isn't reg unused here?  That's one of the warnings.=0A=
=0A=
Yep. I just sent a patch to fix that. The writel() call to update the mux=
=0A=
register was missing (did not notice since the code basically use all defau=
lt=0A=
parents and never change parents).=0A=
=0A=
> The void* casting has been there for a while and looks like a real bug, =
=0A=
=0A=
Which (void *) cast are you talking about ? The one for the asm generic=0A=
definition of PCI_IOBASE ? That one is used in the case of NOMMU build sinc=
e it=0A=
is not defined by arch/riscv for NOMMU builds.=0A=
=0A=
> but asm-generic adopted our {in,out}{bwlq} implementation so I'm just =0A=
> going to toss ours.  I'm not quite sure why the generic ones aren't =0A=
> doing arithmetic on void*, but I'm not getting warnings.=0A=
=0A=
I tried to compile the attached config with clang 12 and the compilation ev=
en=0A=
failed (on a frame buffer driver)... Have not tried W=3D1 build as Jisheng=
=0A=
mentioned. Anyway, if (void *) arithmetic is a problem with clang, I wonder=
 how=0A=
anything can compile at all with it. That is used in a lot of places...=0A=
=0A=
> =0A=
>>>    726	=0A=
>>>    727		return 0;=0A=
>>>    728	}=0A=
>>>    729	=0A=
>>>=0A=
>>> ---=0A=
>>> 0-DAY CI Kernel Test Service, Intel Corporation=0A=
>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org=0A=
>>>=0A=
>>=0A=
>>=0A=
>> -- =0A=
>> Damien Le Moal=0A=
>> Western Digital Research=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
