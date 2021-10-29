Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFEB43F6B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 07:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhJ2Fhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 01:37:38 -0400
Received: from mail-eopbgr1320102.outbound.protection.outlook.com ([40.107.132.102]:31712
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231764AbhJ2Fhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 01:37:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erjBMb1NJD/2XuJVkBsDuJgjI986r2RUo8cbIFKdYRIz/2H0L0o/VlHpDiyBrpsip6qJjD/hcjeVozrkXW4O7INoEy98XVCeBV6mCVULLydiC4JZQI7BeDKYpzjhAqh48vZOpHwwUANHu08bS0cOmHdZUlhvkX0Vf9B//0OUXehj4piMrVx1MDgmXq/kF668tTbBqWXO/ZJjfv+6LwhGof3yEGKq03jnqbT3QpeN2BYQR7cOw7hh0CgXNwWiXUFlclrnb8cS+HT1tEkQ0kVM4m4DrQOMF11CthhnwCLqMZW4K4pT8bsSY6RU6nWarmhkefTtG42utlleEZ33eWg9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zyff4Rgey7rVvDnnDHma9UQaG45n8iu9Osd+3MnDEN4=;
 b=EUj3wlF57yREqVxiBC/y/A08Y1SGwR9Y/WF73w1Jd08o3CwKMQn1BEQp09wWDUzwdg0/3pavMQcomj7rP9dZjRSoa3SgzsKXST3l7g5Hendr8VRn6bzipi0O4lttBLJ7AXEcV6d+0qfesSsZQ2ivkaJy6RSIdZVShWsUAoZl/QSWJFZ4Ss+ftRu+vyA0gX3sbvq+J4Ae8g1xDwg9fJ2L54zIa2TrEBW/kc/0VikcJBGBkSPbFNI+wDgpgy0TQpxn+JAlG9iXVUhUi5c90L3ThHiZ5KSO2iE2TY9cvCy2OkGTM2x9fC7AKhpQCBLKBDmA5PwYG4RyoJr5Aw7xaof8tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zyff4Rgey7rVvDnnDHma9UQaG45n8iu9Osd+3MnDEN4=;
 b=vXM9u7t9dtB9MMqJsVSLbFPD+RFRfUhsEJe6balQFg5FqzPGhs+YwGII62K+Be2ZWDQVeps//eoaEDluNruj8kc+OW3lUXy7hE4AMYMLWnmqQm7HAvic+G+cnXtUF2J6+63AcQ+nhHg9MO6u4XvFIZSVffUXmmgkx+ZFX1GjhMNFSq+TTyWoOhVAD4tI/MtTLIB1IIugFAu9pO8k/hn4uYPOTlubIjOMCV42DICvS/DTkbVfT/AiR2k9hOF9si3l5uh57iSERqKNWGZokwtqYHOc0r7jXtKBYH65bmIZfH/wU2wCI4r24/xMd7jqshAHZOqQLv5zJsCD18Q4s2dE4g==
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB3378.apcprd06.prod.outlook.com (2603:1096:203:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 05:35:03 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::68a9:3f18:dfe4:273f]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::68a9:3f18:dfe4:273f%7]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 05:35:03 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv3] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Topic: [PATCHv3] clk:aspeed:Fix AST2600 hpll calculate formula
Thread-Index: AQHXsbRv6xuXpttuYkWAu3oZNdj4AqvIkEiAgAA3wICAIMOBAIAAHlKw
Date:   Fri, 29 Oct 2021 05:35:03 +0000
Message-ID: <HK0PR06MB33800D3E7158692D82DA6CD9F2879@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210925022354.10297-1-ryan_chen@aspeedtech.com>
 <CACPK8Xct9rWEu40XHWjo_uY9P7dJ=U5LBM+O3KjmjNL+9yD5QQ@mail.gmail.com>
 <HK0PR06MB338025A6EC2AE11D25C34998F2B29@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <ad15c868-de54-41c2-8d3c-716c33b7aa8c@www.fastmail.com>
In-Reply-To: <ad15c868-de54-41c2-8d3c-716c33b7aa8c@www.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: aj.id.au; dkim=none (message not signed)
 header.d=none;aj.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddbaa261-50f9-45e4-f399-08d99a9ddbbe
x-ms-traffictypediagnostic: HK0PR06MB3378:
x-microsoft-antispam-prvs: <HK0PR06MB3378A082A7DE73B1BC942D6AF2879@HK0PR06MB3378.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6Zx6mMyTKY65ZQkqFolERz5loQvAJRo5vXH8DRK9w1rSDAzwbHRIX985bcraOulV14XblAkMCIvzInza/fPQ0dNqjFv0vq171T29jKAu6xXJ2XNzLAJbfBqdbjHQJRsYwq+dusjYCSX7tGu0jhygQcn0hmOtbp1g+ETDYBoEqD/W3oHOLT/b6q1sbuc5gVp1DdpqhIUM9BEp3F7gs58fnSl6FB1l1rtPX4EbKmzGb5Oz1NLYSIPQe/hCASRNBByw7zgSlLnmwO0HZXEoHLM2WVj9nngjjORymzNvjmC9PF8kOa1FdHr2gJ4bNTzlhbbsUcrYEzE0enwFgl4Vb9++eIzKa3GIY6b0TuxnM1D2Rm8dE3RfQd9hEzouGoi1P2a9yGlcOlaN/t/7mOqq7SMwrHb6xmLPHADWJZaGVnWqfF6NzkLMIouZE0Yc0nxDF1w1UxdjlYWZSZQCU/az5zvOXx8Q4PZkQ575OA3FY33D5v0ZjPaVyRc7yGx6cWKWMhE0mOXBotnr98e8+z4nSRHvzY2dQpnT1lPCKmFVSW4qhuQvKc04U14rZF4cH7GDTaACCLXFAklhLo+TvkJKp2RfvjKbymUaqYMpFQvDLLY49VCz13DyCR8am3YWZix1m9L0HSYQQxPbhVGw9XiSEf7s24azyFPB3fWtTUj04dYVwzQwZUwj6znKsN5XTek5OsowIR34LtxjQ3ziIMZxnMWyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39840400004)(136003)(366004)(396003)(376002)(53546011)(52536014)(6506007)(26005)(66556008)(122000001)(38070700005)(5660300002)(66946007)(64756008)(66476007)(66446008)(33656002)(186003)(8676002)(86362001)(83380400001)(38100700002)(8936002)(55016002)(110136005)(9686003)(71200400001)(2906002)(4326008)(316002)(508600001)(76116006)(7696005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MTpb4J+9q4imRUrrYy2UZVy3i1xu8+nuBX7fr8T+gX2+CdCINOkCG70+udE6?=
 =?us-ascii?Q?mHd/Pm4P15CsjZ7B7D8v5suLyksVxEOzJ6AzJW68YHwsSX6VSfJk/p71GDn+?=
 =?us-ascii?Q?q3JprbWu6TcJV9EUWn5R0LG7UnQDwVLO3AdW6N0wKuWkCTkuGjbTE6ZlL4Of?=
 =?us-ascii?Q?W8KqDrCcf7w54hox+aXJp69R8gkBfjhy7W38Fg9Pc0I8WhHT3nivAC6Te6Jl?=
 =?us-ascii?Q?h25mxlT3EoJjt24uZaaGzgfBlbIJTvzy+xXkbm+BFVx6uXLs/f2bFOIoJsMG?=
 =?us-ascii?Q?m+GVCo/6tswvZLKU5fyuAhEmQNnGh98Q2PzQ2hnsdGpZ1sm2Pn+0PNlGKCTs?=
 =?us-ascii?Q?iGj73upQRd0zawuFJdb3ChOygTEo8b0D7pyZoz8TW2LdG8wAfHNtruJSCwkv?=
 =?us-ascii?Q?CdZdcq0SgXsR7JDe4z+umNWzU30wOZeNN/i/FjqDSNsqIX5ZtazFGTaCpPs2?=
 =?us-ascii?Q?1qlNA2gHkq4SjKPUwmVsnveO6uqvCnjUiJ9KUdfv2ZH0ZB4Z5LIYazAamBu4?=
 =?us-ascii?Q?DKL3z7qwGKVrivIBYgpHs2OigPcbfG1wmSNxcI2wk3V2YL311lYrvckA0u5f?=
 =?us-ascii?Q?sSsFQWfn+nDLniWHJ7bhVpFvPapEKllQYdhEJGuyeNILnBq3Rue5Tzliwtij?=
 =?us-ascii?Q?2RAZY8LIL981GILtadwcIgkn2Xu2JP7vddt4zAkOERqkf6DKTIo+C9ls2vJ9?=
 =?us-ascii?Q?VqWYeRMCJR+HYW8H660urwQQDQ/s8FzgjvoSCpJZpGNzzAo+qul+3VlQA3Xw?=
 =?us-ascii?Q?hLGjM4dIMaP2UU+jpD1rT2fmdUbSYb/QzJHTXrtlGY+iz4plzYBpxCCjMAjO?=
 =?us-ascii?Q?EN/MRogihNcqv6QSnReZUDhzH+0viRvJGFHhed3zpNokC0nWNlYgHAITYohZ?=
 =?us-ascii?Q?yFCY0YaBWbyLz8fCcVMTx2NFn9FUuPnwcpbD2sQ546P8D9LbYslg1mGzrCfI?=
 =?us-ascii?Q?qFBqjHrgr2M3sGgU/RkbknpIG4oPvqkEf37Z50oJAgwq1BL5KI6TajzVQTOr?=
 =?us-ascii?Q?NQyntbvcjVkC/MUWTpS35ph6JgSUQ/jdCRT5atfySxZC3RX0lHSR1gNgMipI?=
 =?us-ascii?Q?tBOy9R7DnNnp6GL0j0J1eM8xNBXc3jD4/H/mptmfzclDynMdNWS5zJ6g2cwu?=
 =?us-ascii?Q?9RlsG4bmBzp6tFLTWYTc3v9JyOuM+VMM9+Qva4ZX0ZpDegrfVCPVKiPc9XSZ?=
 =?us-ascii?Q?mgoWxE1Wp5lgNLu+UQ0wo1173Rnabd0tWeEKuG2gCt6aS8p5hKsayo2fFviS?=
 =?us-ascii?Q?7V27HTA2mhyXTd1p5R1aoRKSRhCpMNAT0EnG8HmNdmRJDYSvUP9M6N6pjeGm?=
 =?us-ascii?Q?u8q4G+tAUpu969fsX5NkLubT8g5hcINnnJ8kvHoT/djmCIAl9FmlbprHRuTr?=
 =?us-ascii?Q?U62USTmtUVIiqvu4zaaVJalaXld8f+BcfI+3D1WNalOdkaoSN4a2a1QPsCDK?=
 =?us-ascii?Q?XyyApXuPQAUqOM0wbndrnPBsdHSu8jTMjh1txVgocFzU6jCZRHh4mOcX53Tj?=
 =?us-ascii?Q?ADS7JOXwkUZFH70TwxUYvHZwLoGGNVqgAHTNrOloRtJ0/figkML+5VXNcSz5?=
 =?us-ascii?Q?VMkfe6/vtP7xLTXYfSpqE5tkmh2yKLLJvylYKKbNJ59GqnKuafu/oJIU6VfA?=
 =?us-ascii?Q?wQV9bqnNHZRszceXaY2o0X0G44JiboUbwoUlvtxioU392YgMsrEOF029N7cZ?=
 =?us-ascii?Q?nkQ8Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbaa261-50f9-45e4-f399-08d99a9ddbbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 05:35:03.4504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOODQbUK29QWP+F7gZi3shIqGAc60DuJFgOZ4SvlKPMkzXcmsudjMtICa9mQjQYgTs5xm6n57TV0+VvhPC4NwW1B8Db5b41mYan8zj0H+RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3378
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Friday, October 29, 2021 11:46 AM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Joel Stanley <joel@jms.id.au>
> Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; linux-clk@vger.kernel.org; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCHv3] clk:aspeed:Fix AST2600 hpll calculate formula
>=20
>=20
>=20
> On Fri, 8 Oct 2021, at 18:02, Ryan Chen wrote:
> >> -----Original Message-----
> >> From: Joel Stanley <joel@jms.id.au>
> >> Sent: Friday, October 8, 2021 12:06 PM
> >> To: Ryan Chen <ryan_chen@aspeedtech.com>
> >> Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> >> <sboyd@kernel.org>; Andrew Jeffery <andrew@aj.id.au>;
> >> linux-clk@vger.kernel.org; Linux Kernel Mailing List
> >> <linux-kernel@vger.kernel.org>
> >> Subject: Re: [PATCHv3] clk:aspeed:Fix AST2600 hpll calculate formula
> >>
> >> On Sat, 25 Sept 2021 at 02:24, Ryan Chen <ryan_chen@aspeedtech.com>
> >> wrote:
> >> >
> >>
> >> A few notes on process:
> >>
> >> > v2 -> v3: change else than if to directly else if
> >> > v1 -> v2: add Fixes commit hash
> >>
> >> As this is normally information for reviewers to know what you've
> >> changed since the last version, we normally put this below the --- in
> >> the patch, which means it is not included in the commit message.
> >>
> >> Also we put a space between the PATCH and v3 in the subject. If you
> >> use the tools, it will generate this for you:
> >>
> >> git format-patch -v3 -1 --to=3D...
> >>
> >> >
> >> > AST2600 HPLL calculate formula [SCU200] HPLL Numerator(M): have
> >> > fixed value depend on SCU strap.
> >> > M =3D SCU500[10] ? 0x5F : SCU500[8] ? 0xBF : SCU200[12:0]
> >>
> >> I recommend adding to the commit message the text from my first review=
:
> >>
> >> From the datasheet:
> >>
> >> CPU frequency selection
> >> 000 1.2GHz
> >> 001 1.6GHz
> >> 010 1.2GHz
> >> 011 1.6GHz
> >> 100 800MHz
> >> 101 800MHz
> >> 110 800MHz
> >> 111 800MHz
> >>
> >> So when the system is running at 800MHz or 1.6GHz, the value for the
> >> numerator (m) in SCU204 is incorrect, and must be overridden.
> >
> > Yes, SCU204 will be overridden by chip design.
> > Let me clarify m is in SCU200[12:0] not SCU204. SCU204 is NB not
> > related with freq.
> >
> >>
> >> >
> >> > if SCU500[10] =3D 1, M=3D0x5F.
> >> > else if SCU500[10]=3D0 & SCU500[8]=3D1, M=3D0xBF.
> >> > others (SCU510[10]=3D0 and SCU510[8]=3D0) depend on SCU200[12:0]
> >> > (default 0x8F) register setting.
> >> >
> >> > HPLL Denumerator (N) =3D  SCU200[18:13] (default 0x2)
> >> > HPLL Divider (P)         =3D      SCU200[22:19] (default 0x0)
> >> >
> >> > Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
> >> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> >> > ---
> >> >  drivers/clk/clk-ast2600.c | 28 +++++++++++++++++++++++++++-
> >> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> >> > index 085d0a18b2b6..d30188355aaf 100644
> >> > --- a/drivers/clk/clk-ast2600.c
> >> > +++ b/drivers/clk/clk-ast2600.c
> >> > @@ -169,6 +169,32 @@ static const struct clk_div_table
> >> > ast2600_div_table[] =3D {  };
> >> >
> >> >  /* For hpll/dpll/epll/mpll */
> >> > +static struct clk_hw *ast2600_calc_hpll(const char *name, u32 val) =
{
> >> > +       unsigned int mult, div;
> >> > +       u32 hwstrap =3D readl(scu_g6_base + ASPEED_G6_STRAP1);
> >> > +
> >> > +       if (val & BIT(24)) {
> >> > +               /* Pass through mode */
> >> > +               mult =3D div =3D 1;
> >> > +       } else {
> >> > +               /* F =3D 25Mhz * [(M + 2) / (n + 1)] / (p + 1) */
> >> > +               u32 m =3D val  & 0x1fff;
> >> > +               u32 n =3D (val >> 13) & 0x3f;
> >> > +               u32 p =3D (val >> 19) & 0xf;
> >> > +
> >>
> >> Add a comment:
> >>
> >> /* If the CPU is running at 800Mhz. */
> >>
> >> > +               if (hwstrap & BIT(10))
> >> > +                       m =3D 0x5F;
> >>
> >> /* If the CPU is running at 1600Mhz. */
> >>
> >> > +               else if (hwstrap & BIT(8))
> >> > +                       m =3D 0xBF;
> >>
> >>
> >> Or you could copy what I suggested in the first patch, and write it
> >> like this, which I think is clear:
> >>
> >> ff (hwstrap & BIT(10)) {
> >>     /* CPU running at 800MHz */
> >>    m =3D 95;
> >> } else if (hwstrap & BIT(10)) {
> >>     /* CPU running at 1.6GHz */
> >>   m  =3D 191;
> >> } else {
> >>    /* CPU running at 1.2Ghz */
> >>   m =3D val  & 0x1fff;
> >> }
> >
> > How about following
> >
> > ff (hwstrap & BIT(10)) {
> >     /* CPU running at 800MHz */
> >     m =3D 0x5F;
> > } else if (hwstrap & BIT(10)) {
>=20
> This is the same condition as the `if` above. That doesn't seem right.

It would modify to following
	} else if (hwstrap & BIT(8)) {
>=20
> >     /* CPU running at 1.6GHz */
> >     m =3D 0xBF;
> > } else {
> >    /* CPU running at 1.2Ghz */
> >    m =3D val  & 0x1fff;
> > }
> >
> >>
