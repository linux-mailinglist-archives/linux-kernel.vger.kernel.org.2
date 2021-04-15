Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB56535FEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 02:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhDOAci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 20:32:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63216 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhDOAcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 20:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618446734; x=1649982734;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=L3rXogAfbcsyVi8VoZBkt1bovhVDF4OOEtaRp8JxTwo=;
  b=L0y8NabOQ5r302twBIloF//sGy3jrAnsFA0ESAkunmF/Xs2kRAABX/RC
   i42QVQ+Jf8yU4EtdvmcGWqRBYCosOWkDImXYJCi1amuu5JK8ZfpGxkekY
   WKvO/RkvV1SBZarJGfJejxvwAK08RP1qWA8Nfa0RqFSlVu65em8EcFb92
   sF4/uHKdrwgvaljHB6BgWOXoMt5lNiJ71SFvIxukoQw8xNsQPF8oPfHyW
   p9RB7NFp9DBrzJmoII0xfFn7phtjBDUSyVWNMvXGAXUqVNT6jKV1fQd+x
   UE/xpn0VnHzSa5+yR0AmY8RWMVkv8hUZnjD7dDnakFELW5RnAXMMzeH4U
   Q==;
IronPort-SDR: edi8IA9va79ty0gJPdKuskU+JNKnP11Q9l6gWHbZ4wb5BJezMn5aSNgrHIcOs6Iz8srmyD8qmI
 zJZIxZUHqu6a39B2B3+hgSS+E1mj2W0a5LzPK7fLPvu9pod6mPNj19a1d8UmeH+p9Mi6nuyxi3
 Y9zVvTLlmn3vDqrkOT8I4nMA4ApxmNtLhcsBZ71O7aTh1cA4s5jWLUZVhcSnBNgKGAER63NR+E
 YIxGHq+KkTorQ03TX+Z6/tzdsW4xrYUxGhadIXbPCxhp5Uy3Mz5/wlfDRMC16FzAHBti7s642X
 D6I=
X-IronPort-AV: E=Sophos;i="5.82,223,1613404800"; 
   d="scan'208";a="164808262"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2021 08:32:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jvqwx3SOOlq0HclEsUAswEPgCSORXaOFsfz3g35zIH9xsOZm1jkWHMH/upzxkTVYzEAv+aPib6IfvaE3oCXm2Q+z74n8rHzF5SCVLhEq0qd3GqwfDr7FnIlEzewwe9RbHOlNUyKGa22DNJEcBGlItukixn1gt4S4rpnM4yxpdZ/uXsZ8eFCdQEzB1hIh5yutZZJmrS1X8G6i3M3AIFM63Zk6Fe/YbCDChhmaYZm6YVrpMu3tN+97yGWhJ9Scu9EPOo4yooXEDzG4wVsNZ1ad3DvktU3Y42x/E1lZcO1TYyv3SrmiODiXI9lInBg3DCvhkNrfcQjmJ4Y1MS2z2jqhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+wt4IRDhyagW0QnxAzRQ5XNJM8iny59WvQPQ3pja/I=;
 b=R+qkEF9oGbUzxS1OgEhT3cEiRv3Cw6aNpVxrECAzC6YeM4swbTO+m85+qoMnmrRQsyi+OmAJ1wc5q3nTWn3ylZKLmVhf4xbfPObWFua+q/+BgCyOObQdjSoAAfQwMCkOVwr1LcyPvKiuwacvoeSPsJhdCJG4Uf7iOaGS+qYg2yzdhw78j4bJGHuTE2ldlj6tdh3KMwaFFMLRLOvteKu/8/Yx2C3ET05LaxxHmbVxAwRC9OJl7SdsqVV/2GcALcujl6QQaBvRSXLaIJtfuKhBaCBso2v7jftKrRS3FsHp3X7GxbP4TUYJBsHm9rgbts8BmmHLWlCsCFo+fx5g6ywSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+wt4IRDhyagW0QnxAzRQ5XNJM8iny59WvQPQ3pja/I=;
 b=fiE1sjF9I7cI6ZKnl/zeQrAGtfdZyeGGfylmDc2R4cro9c5KUFl06PtH22CLD25mNql+n7cavyAalW8Gqjnfl+t7ljBFbIjSJsAV8fKu3hpwqBD2LLk6FoQuz+d1YUzdNJav7zKVVEFaFUyQbozNEiL0KgQMqQHCdZIrKaDpBRI=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4980.namprd04.prod.outlook.com (2603:10b6:208:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Thu, 15 Apr
 2021 00:32:10 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 00:32:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Max Filippov <jcmvbkbc@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Anup Patel <Anup.Patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/2] Fix binfmt_flat loader for RISC-V
Thread-Topic: [PATCH v2 0/2] Fix binfmt_flat loader for RISC-V
Thread-Index: AQHXK8WacfnVzM4zUUS2ex+k23Zi9Q==
Date:   Thu, 15 Apr 2021 00:32:10 +0000
Message-ID: <BL0PR04MB65148D80C819A7E3B8365242E74D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210407154924.1557489-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:a831:e732:e39f:8a81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d69cca2-acc2-4abe-b132-08d8ffa5e866
x-ms-traffictypediagnostic: BL0PR04MB4980:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB49800A4CB814F0ED2754A7E3E74D9@BL0PR04MB4980.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FCX6sAeUOOjwKB2OZNMhcawo5CFxRpwA7El6ACGDwuZqMfMNYo7/9kO/1wvRdP8TSlvjlLjGcytnvry0KGpawUgtJzLs28ZEF7eYmRRUM/Qitl68LwiS4oc2WFX8oQ+8JcFo5GdkPkjJ/aPVBr8lAK1pkVkPMuw7dqc+LaobZ4OBPwNf7Y7ebZGKlalMJLHqjPyVxlc5JI7i6GwK9HgzgTgeNxA1cGSxZuR9EIG8l9nNkube66MMh4JgptBOfehfqhtAs5XZxDg5dlo3X2O6BaHH9tfOp2ZN4y9XoJV7aJSo+XHp+l87YkqKogGiAXpZRAw3e/zLfyJZGry3AqNZM9FRUkioRd5ZSqtqvMsdriigyHqrW/M8btzFQY0GKtpudMyvu+8sZu4gKcCgymYz0FgZkucL9zn/opKtNeiLdps2363a4GbALf+ZwFYjv6Mh/URuZN5K9s2CXPv16ZzJcTt2GcRYLckfNdnXmqtHu+S/CgNrmOfgBk+Q1wi2TDxJGY+BzFiuj09PiGpd8syHzyGyKySLK9LDSz23GQ9cywTNXYSZ3KjoFL8ylwOrQ/WSsO37dZPLJ4qCDa7XcI38wh6kFR0+LnfAA1w3yr7s0sI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(186003)(66556008)(8936002)(55016002)(2906002)(54906003)(478600001)(66446008)(66476007)(38100700002)(66946007)(83380400001)(4326008)(64756008)(8676002)(122000001)(9686003)(71200400001)(33656002)(91956017)(110136005)(5660300002)(86362001)(76116006)(316002)(52536014)(53546011)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Hi4BvWWyITowZIDGAEaYseBBkQLqNrYzojCiWIYbrda6eMARZoBZHO/Gx80V?=
 =?us-ascii?Q?hrd9ZXx01RncjlOukiZOhpHzw5pdbe4L+tYjCz1sCZypqPMA9wn93yyCRxDx?=
 =?us-ascii?Q?03Pw8zlrEWCT4Y4fBLG4NUVU3fv7fVlewgLZgwUBeWgh+pnSgSjlxGB5TUdy?=
 =?us-ascii?Q?+3IR2VYITIl4Nm8aQppOGiCM5tCABZGfzhtihF8zuHoZGcPrfK8I6ZI1uA9g?=
 =?us-ascii?Q?xqcbJsstXPS1aLxz/hNASuwZu2teNPgb1GpWLrgfaGMshaVNMBpCygLKDMST?=
 =?us-ascii?Q?/a4fHcPkADVi8G/EtmpZNNqeVQ/QbSRWja0QWZYmW8q2XVArhXXX1ji68wTF?=
 =?us-ascii?Q?rRwn9b8haoyUIYF08J7Z9IqJDstLLzTgTcnV0w6OTKKBqygNxOpXVTRHYhU9?=
 =?us-ascii?Q?gIxd9GwBDn+5c1J96ObJNF2UhubsoLszuEPMZVy1tqRaIynvIRLh2dIxu4ZD?=
 =?us-ascii?Q?h2OvsId31Fmo5x/PnjPzYkTX30moYoWLUxIz3pup3a2p/kusQmyRFTxAokoj?=
 =?us-ascii?Q?yBJd0EDtfsXGcvgW9TMIhmSTXDX6HbkpZKePxTKytnwA9eK+uyPK4EgvB245?=
 =?us-ascii?Q?vtlPob4DrMDizlKXn/RrcE/rfbYlmlbtpD4qwxXtwkpE3+4OkrPEcmCxFSvb?=
 =?us-ascii?Q?VmCFyxxbGGTUrWKGpE5zXqsSeNKsJk+8YEJgDGWKRXhG6SseLWKb2tmD2LgJ?=
 =?us-ascii?Q?20YPIhiWj7mc/3hByS0fUX4du5/7n6DwrJfHszcXv3/SX9GalutQSWncBPnL?=
 =?us-ascii?Q?CL+s55zF/xf6m5KrhMpw0CFlKPMtpCH5GHP7K15yryL3hbHv+3+wAHU5/agC?=
 =?us-ascii?Q?SrkmDTzbuagXfue5ythAvpYl2FpNTi2YL877q5IM9ecNl4spbVJDyD9SEB+/?=
 =?us-ascii?Q?3GuNY/cCm6qnu0gN9qK9fXOlKa0SPrqraE4hDdZVMrzTFYcebwP840boU9CU?=
 =?us-ascii?Q?VBSsgdaociKQVDh2jFSqck+/CAZyjmt3Ho6cNuyets89CV0oc4YYJ0DyENjp?=
 =?us-ascii?Q?b5rTj9lniObD3RAyhcbf3SfcJ+coVyypINtoz7O62Z4BYRmTT0OkLBF84HNh?=
 =?us-ascii?Q?0bHfAHeit/3S0hO7rNnjkU/LADcUWdR6zTfUPwl0wqhYSDvcoHckIy+9ZBz2?=
 =?us-ascii?Q?cermkI91S85GbcEceRcjtzwto11cu4ABS5VdKmznaASo0dVyNbUGoE2pMhEI?=
 =?us-ascii?Q?Fzu47+YAIU8OL+9Vgv3F8u3FuHT9t9nPcMqp2dQ4yweAgcP6+fEXSIXjD4PL?=
 =?us-ascii?Q?MhLCJBV2NZDFUrt9BlgqjyEm8NKFKhDkNn81+H0PoVXdqGWZzyRjSgCMJif5?=
 =?us-ascii?Q?Fo6OnlpcmmGZNKh1GTyChs/w6uUboldbJGdCGEyJoCF48gtBDvxk91mjnYI4?=
 =?us-ascii?Q?mAgTbIagaEHbS62iUfWy6wxPnn9NTuexKn0rHeqFt6X3EK/69A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d69cca2-acc2-4abe-b132-08d8ffa5e866
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 00:32:10.5212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2sY3z5C9JMvVaZc+YULG+bdhsOCiHbjEmO1CnygsWaPry5hiDr7fjlbhRqUZZZH3g5F/GkDPsXAUxO+WYeJLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4980
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/08 0:49, Damien Le Moal wrote:=0A=
> RISC-V NOMMU flat binaries cannot tolerate a gap between the text and=0A=
> data section as the toolchain fully resolves at compile time the PC=0A=
> relative global pointer (__global_pointer$ value loaded in gp register).=
=0A=
> Without a relocation entry provided, the flat bin loader cannot fix the=
=0A=
> value if a gap is introduced and executables fail to run.=0A=
> =0A=
> This series fixes this problem by allowing an architecture to request=0A=
> the flat loader to suppress the gap between the text and data sections.=
=0A=
> The first patch fixes binfmt_flat flat_load_file() using the new=0A=
> configuration option CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP. The second=0A=
> patch enables this option for RISCV NOMMU builds.=0A=
> =0A=
> These patches do not change the binfmt_flat loader behavior for other=0A=
> architectures.=0A=
> =0A=
> Changes from v1:=0A=
> * Replace FLAT_TEXT_DATA_NO_GAP macro with=0A=
>   CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP config option (patch 1).=0A=
> * Remove the addition of riscv/include/asm/flat.h and set=0A=
>   CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP for RISCV and !MMU=0A=
> =0A=
> Damien Le Moal (2):=0A=
>   binfmt_flat: allow not offsetting data start=0A=
>   riscv: Disable text-data gap in flat binaries=0A=
> =0A=
>  arch/riscv/Kconfig |  1 +=0A=
>  fs/Kconfig.binfmt  |  3 +++=0A=
>  fs/binfmt_flat.c   | 21 +++++++++++++++------=0A=
>  3 files changed, 19 insertions(+), 6 deletions(-)=0A=
> =0A=
=0A=
Ping ?=0A=
=0A=
Any comment on these patches ?=0A=
=0A=
Without them, RISC-V NOMMU user space does not run... I would really like t=
o get=0A=
these in this cycle if possible.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
