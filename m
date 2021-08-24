Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAA13F5841
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 08:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhHXGc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 02:32:27 -0400
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:15969
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230350AbhHXGcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 02:32:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXKioPuw1xREN3Ia2n33sS6WcPPySlBBYvshCWrCysSOy/GwYpmtt8v4TWzxfE7PgB3zuFKiWBQLSHaQpwu9bwPjWDVLWSww4kn1+qIc+TrQV6qS9zL0x3j676LdP/bmXJfL0f1j/cLjfxyoFQtX+5LJ47DpEhH/C4qiksO3CSITymsGjfp7z7B6fWQO544Zn5PjSbuKM/tphCSjkwjHseQJSEbbxRc+gokn4WCJE2QDEnD50Df2nlmKAiY9pzvo8/crpuIBfY21qKfimWTBA56qHNt3GdBk7qnYulzbTwO7BAhuX66S4hrBAg+dYBHLlN/w17AawYX7F+7S6e7yCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smzM/x/xLslzWUXssO+Vlu0G7j3Ox4O5cxwGeWt+6Qc=;
 b=S6NIMwF4IgMPrkQyLzu51GYp0AGU6rgbR5L4jOMDqswTVLXvYi+OqB3jtpeR516IIy1REYJJEzWUTN8VBQPtFt2VLT34hNH4cTEnu6iejTfbn04FBfUeYHte+yDNWOHbUytIxUS9u4fnEuUtk8CGpVAtmUj+EDe4Y+qriQasB8r/WAOgYoB37GCcZzpXO9DvwEsexuCQ6AYNh3Ct7AkDhjUajxaifS1iyP67wnP5gEz5ziohBs05KKUmC5kvRJwKMFGOKxtuH2eDL2FtCKw1b7zYGG6pRcgjbmjQof3V+XXz3PEJBR6oZVflbf4qqbK7TJR6iM+YE9FDryeJRYZTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smzM/x/xLslzWUXssO+Vlu0G7j3Ox4O5cxwGeWt+6Qc=;
 b=VnsCyiAxyzsFw0bMqAdcNFRKK11+dl+DJdQ6Xham8yqKtNgiuZrrw/x3Q05Eeyu9ufFll1HSIhD6p2N/Q94mvrZ8GlYEvzqtGFbu/QRdj/1lLv4X84WjcQkS2GRiDerYVwuTFuFoW69ZKqaB5Uu5mSJzWUvttbJemOlZcb+ZlYA=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0401MB2502.eurprd04.prod.outlook.com (2603:10a6:4:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 06:31:32 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d%8]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 06:31:32 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data" property
Thread-Topic: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data"
 property
Thread-Index: AQHXjbpIBwDJH2bCBk6a1JjgGNijp6tuGImAgAoQXgCAAMcfEIAJV06A
Date:   Tue, 24 Aug 2021 06:31:31 +0000
Message-ID: <DB8PR04MB67951BE5D484C69BD57ABDA4E6C59@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
 <20210810073510.18218-2-qiangqing.zhang@nxp.com>
 <6e3f6881-929d-1663-58f1-39bf35069175@linaro.org>
 <YRwUyLsvoSpFI9X8@robh.at.kernel.org>
 <DB8PR04MB67951E2312CFD69808B4502BE6FF9@DB8PR04MB6795.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB67951E2312CFD69808B4502BE6FF9@DB8PR04MB6795.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdffa3f1-7014-42a1-e4db-08d966c8d016
x-ms-traffictypediagnostic: DB6PR0401MB2502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB2502A3684AA1B3FC95BA38DFE6C59@DB6PR0401MB2502.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FeTcEqChLsNeUVGt1QUZUw2JIHS8ooDLleVxiPwP6awf9XmcYKky/r/lpUMObAf4y7mr0CILAkMLLYxTuie1a8Ppl2Or9ARFSk6uEvLLok64z6CtJ7V08uZogI2/e7ZQKFaYMOCgqBKNtUqRv6AtVDrF/esKAjgg8/w8Vr4dIKbcTTUkcGPpfY1gTQaeSLUk6FwNCbRhGTiBIzvq5+2PVyjLyTq1+QAa1HfNHSv7Fza4ybpV8lHj0srYFf0P6SEfqHz9MB6p2brPhIBuxTOE1RThQ0L/ak6uXvdtJspdqvwZZv+ju4M1Qk+0e/wgOklIdYAFaU2l7wNdUG6tBL5ZfmxaSQgERannIK+98Dlddc6C6rCAC//bHZrCk5pwSpBTPrSwuts23WFgLXen6T7pl7SgRdy5CetsKhSxTu2LnhEoEj+2psXFbCJekP2/BX+Pv1AOFOPPM6HlXEgeyAlwcf4rGkckWQ/ncLl0jlrCG6oL1HOMvm8Vzr5ykGnEp7TJCCY2sewXgioy+khBaXyt6amqP25qqtPXTwXYyMvoE5436QNa1x4mWYxOfxA6gkIjSe/SxiYf8OYnnx5jK3cWNv3SmwXffL8jq7mEvlTxDE4ewD1TzSzafHcSISzS4FZGtn2nVWnrxH1Q94DrOM5YM7dStkrEBWZeeQ2WbdknhHP1Kabk3IF3FZnEpS3DjXp1pQZ4/2GEtcb9xlq3NtW8Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(4326008)(33656002)(54906003)(55016002)(2906002)(71200400001)(110136005)(8936002)(83380400001)(9686003)(478600001)(38070700005)(6506007)(66476007)(66446008)(38100700002)(76116006)(5660300002)(66946007)(186003)(52536014)(122000001)(26005)(7696005)(316002)(8676002)(66556008)(64756008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dKrYgGmZ/ItT+lPdHueARGZUf/cu9p14NePr9fUTnVmOMbIGwZq1XqIhDGFI?=
 =?us-ascii?Q?4TYUI1JzP+XiqviwBqh9gx5fdHZ9pwWCom5xC4VwPzlMIFUCEC+1rjFMD2iL?=
 =?us-ascii?Q?wt4C0kgpL4pGS4IGpRsczcVs8hnaZ/ahe6IOK/cNN8kwdKH9ilNMkZlOxEtv?=
 =?us-ascii?Q?RHCCX21oEKd4drqxwX/3CJXwtq5BsBF7xXB4h4zkgKXzj1SK4a39/G8vVVz2?=
 =?us-ascii?Q?KAbbA6CwyaUwtE95A0N+UrWzyJVs3TcMSOqh8SJIWxLQ/lLLA3ED75dEob7z?=
 =?us-ascii?Q?k+RGtMPAKvPTvlfFBye6KX36ylZBUMJSm0Y34SgZbqu9SZEt5vzJTVN2plXm?=
 =?us-ascii?Q?FwZTBUMv5G9DBSvVNNA9sziah8pqDrL2IOKVH7L+cQF8hy0kFwGCJ8fDPi/W?=
 =?us-ascii?Q?iz09sjS6drl501jjEeUByz5HrPtOfLa6al3kJPXt6Vp9HqtGXd05cgnKus/t?=
 =?us-ascii?Q?+YTzRDYQae/pGx/lhs0SoK358YBrbzGnIMqhok9U3khaf5jPtSz9CxM31GX4?=
 =?us-ascii?Q?XIno455GN+fsk9Tq3ntf8qtTyX4jVlTO1R5x2Z40ogOP4RExX1x3G6pfcdgg?=
 =?us-ascii?Q?edFdSUKCcn7rlprRG24zoDkYZUktaOulSGO/euFlma5nIH9OhNQaY8kFDG2z?=
 =?us-ascii?Q?GZzp7xism6gZ86HvOGMUyP+g6pShdTwnwMwuQKBSSfztmRzvha1YsadLHB5J?=
 =?us-ascii?Q?Al1zhbDPeusu+OGxzsn37Gcs4NnF5qLwnaABYIIFNgidKU4QV4ePTwtlxSOB?=
 =?us-ascii?Q?GbbW01fzQf3W2cxVFVG39S5Xin9K2M2auznT7Fsy9orUYEglXNOFt5sXBan1?=
 =?us-ascii?Q?8RCdU9lbHYR5NPi843Z12uA1hIk+e2HDMCsiM5OHNiQQlWRuj/PNXzYOhe1b?=
 =?us-ascii?Q?/OMit4bB6wK1TUd7B/bwI0G8pU16Eg1qmdrO22Hw4h79P3g0ST2QXpbEQKDd?=
 =?us-ascii?Q?RyrT0peCHd/fzJRGdssVZnlatRMZmm0Xc68DwyifZh5k+Tu7EN2DQTpomu8o?=
 =?us-ascii?Q?Kjg8rtmkVRAKC7zGx9BOTyW2DKNOSjmmS794y8t8P+AqPCWlzBG6kyWr/bDb?=
 =?us-ascii?Q?TghGcAuQ4N258ELZzQT/OAmLB5aPnTVdWzj7bS1KPxaDDRYJaNa3fB3lVI0V?=
 =?us-ascii?Q?EHK02kzF7Dg11Q6RdU3hzsXm8DLQXuqMVMCeHAUNtdEjwNOaocdkkjG4O2+Q?=
 =?us-ascii?Q?oT4uFbTGXXdW4iJ/Y9tMPiGHXH+0/DgB3s3zQxRjfK/VJA8mq4WTBpujybIV?=
 =?us-ascii?Q?7PBSoP7DOvG7gKhTbV9Mjqf8URNpvoESr1FoZ85yrDp2cvPpQAnrDIt4F9c2?=
 =?us-ascii?Q?S7ZHGQM+8kerC2dtKLSOKz++?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdffa3f1-7014-42a1-e4db-08d966c8d016
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 06:31:31.8606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGFq4YYTLWWJgMdD2YzTpa7MsPsvmg486gWTwBW3jBAtoGGsTif7LsjZ3/OOpvqsH0GIKppC0GkMuaFYe9jhBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2502
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Srinivas,

> > > > --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> > > > +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> > > > @@ -61,6 +61,11 @@ patternProperties:
> > > >                 description:
> > > >                   Size in bit within the address range specified by
> reg.
> > > > +      reverse-data:
> > > > +        $ref: /schemas/types.yaml#/definitions/flag
> > > > +        description:
> > > > +          Reverse the data that read from the storage device.
> > > > +
> > >
> > > This new property is only going to solve one of the reverse order
> > > issue here.
> > > If I remember correctly we have mac-address stored in various formats=
 ex:
> > > from old thread I can see
> > >
> > > Type 1: Octets in ASCII without delimiters. (Swapped/non-Swapped)
> > > Type
> > > 2: Octets in ASCII with delimiters like (":", ",", ".", "-"... so
> > > on)
> > > (Swapped/non-Swapped)
> > > Type 3: Is the one which stores mac address in Type1/2 but this has
> > > to be incremented to be used on other instances of eth.
> > > Type 4: Octets as bytes/u8, swapped/non-swapped
> > >
> > > I think its right time to consider adding compatibles to nvmem-cells
> > > to be able to specify encoding information and handle post processing=
.
> >
> > Yes. Trying to handle this with never ending new properties will end
> > up with a mess. At some point, you just need code to parse the data.
>=20
> Thanks, Rob.
>=20
> Hi Srinivas,
>=20
> Do you plan to implement it?
>=20
> Or need me follow up? If yes, please input your insights to point me how =
to
> work for it.

Any comments?

Best Regards,
Joakim Zhang
