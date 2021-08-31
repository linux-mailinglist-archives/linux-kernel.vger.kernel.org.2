Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4613FC965
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhHaOJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:09:41 -0400
Received: from mail-db8eur05on2057.outbound.protection.outlook.com ([40.107.20.57]:11232
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229926AbhHaOJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:09:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCJsxA7n3e3VCWMj89UocO/c3qH7hC6fLV7wjVHgBvv+w+Dpvpu9OhUranVQlRlFIVrA8L7YhJM1kzEWOiXYvlzbn/ayDyVmyPPQnKelUWb5SIGhnveVOf2HDqI4aiTORxPYHn7BSw5BcKbEN+B2mmGxEGv5JvQj1soPn1IQd3WHnRKMDP3zm99/7kClm6ipgfylyyuBsh1ecO7nHd9Oy7BXWJudpfJqgkDTN77jbNrWNdMuMU/e29NZ9+mBV0+rlnYYevyNUOO338f+FUUBtZx5vcGV5NCfnfVinlee2wpT7G/kOo7EaIlAKOUkrvsAJGOwrwLbdGz2vwhAeZNpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DseXwa8KuJFjiiD5r6FjT0qqk984uDLY3vaM4RuMqu0=;
 b=UkLlhdtyrhJa81P/UXgHdlb7Wcbg8/DWK8qpmIQ6v+fYP36wb5WSCejSlLLAIOBTQQETtON32+6vrNTNq2lu09j8lobw0Jx7HsyNDElheT3zc+uiWPk2fq0jlX/uUlUCcQ67QoK2z9iFWUbt5QFGjBA0P7RxMCeSV8yrM3cDsNUHLKN0TmwnBtkv7BRYiAfQ/S6PnVKyA2dUw4ZYv21yFizMyFNPyqv5hLTjoHx9A+KD48Tqa322u0/Us8huW9FpdfMl9z2fLVNP1HKtCQSn28m5B9GTDnXb/AxJy01ykNBtbXv9XOxNr5jk7xAHSHOQllyZBNPIn6ClJrsz1iI/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DseXwa8KuJFjiiD5r6FjT0qqk984uDLY3vaM4RuMqu0=;
 b=XiT1LKcEelHugulUAdWB07zn2uO3l7tF6KlxEiD/wRd45dHhklt6ZiGiK+oNzdd6H8yigRDDyNPpgp2IWoqHpR71s5FNm9+tfYKdPY26yQAEHONK0j7JPMnOLQyxnePLZXUjz66w3HmJTPtL/ymEDYYRt8NwWjLs/u00D3Xoo2c=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0401MB2688.eurprd04.prod.outlook.com (2603:10a6:800:59::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21; Tue, 31 Aug
 2021 14:08:32 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 14:08:32 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 5/7] arm64: dts: ls1028a: disable usb controller by
 default
Thread-Topic: [PATCH 5/7] arm64: dts: ls1028a: disable usb controller by
 default
Thread-Index: AQHXnm3CNOiw6M4LEEyucZKWgHopFquNpn+A
Date:   Tue, 31 Aug 2021 14:08:32 +0000
Message-ID: <20210831140831.vouhwnwpgndwfblh@skbuf>
References: <20210831134013.1625527-1-michael@walle.cc>
 <20210831134013.1625527-6-michael@walle.cc>
In-Reply-To: <20210831134013.1625527-6-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a602c498-0ee2-4ce1-8642-08d96c88d0ba
x-ms-traffictypediagnostic: VI1PR0401MB2688:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2688F1F54E6E4E1B0B1BA86DE0CC9@VI1PR0401MB2688.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lveKDXq8xkdjPUN+QYGG+Xj8rA/nkesc+MZrSUIayuRQQfzdTPP2G1gExyDtpjjnTXNW31sp7xdoP4RA0FvQEhBdALuq+dO1kFFweA1BjTnH/6un3gL9zp23VnKsfkF40KbXMc+WNlwAVVdp2/98JyZ9LwlmITlv+Ka8sGN4mterp+ifeH1T5w3of0mOUPZIxGm7OBMPjZiwtKYRId9EL4ZRaf540pqv2eb5JmguT+dTsADzaE5xMMAYxzbtm0a+DfHh97HyEOu277K3qdYwaACTvIfLiC/cWesy4kIeWxcTLIUGCNDPxqEmlHWI/+9bsGJFnguLR8cu3D7PUBvGACSpoHwGt+FhwRS7Kux9+NxBzyEXOO34NNjL15dvr62pJ7gxiQ8Nh3yq9miAixuqXrRgRxMqIQQWjFjdXxmtl1vegk0e8MvkcKlDNSwLpF0FusLedd0vJ2PJJstG6nxBZe4U4ch/M8ZJHZ7KpiVEiMZP4z7lWw95LGNk7mup/go/oYmbyW4K70gkVBls5wXCWpWw7EPa0O2U2oZ9ZCHKpN26VkS6OtlNB8keOJkMSeCayXBs18yZwf/EtFPW5eirgv3kaVUypazbGBJrQ7zLGD7SC9/5b8GUW17OjS46t0kxX+bMfK+29I0Ub87eEED1wndyVWZKfRZIFaIokLESQpN2QQis5ytGrTaG6rEcJatI7JHhBURQu2iZCpmrUhn5oA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(396003)(376002)(136003)(346002)(39860400002)(122000001)(478600001)(1076003)(38100700002)(316002)(3716004)(2906002)(83380400001)(54906003)(33716001)(6916009)(76116006)(8676002)(8936002)(4326008)(6506007)(44832011)(5660300002)(186003)(6512007)(91956017)(6486002)(86362001)(71200400001)(38070700005)(66556008)(64756008)(9686003)(26005)(66946007)(66446008)(4744005)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C0i2uHdk2C/J0okcdWjSVrXGEQVLWfXCkL6tXJKbXcTrkW0xOMntBStb7uWS?=
 =?us-ascii?Q?IOyoImw7Id4qJw8H03v2TdjU8Hf3X4t+QEnLDMM9ivc0nMfEarr180MikdYA?=
 =?us-ascii?Q?b2tOAuxNuaMtGcONh8yCclQDAOVUPgJLP+Tr4t5/pxZU/NaoxNTjxESBv+rB?=
 =?us-ascii?Q?QmeXRmkKQgHOn8PyhCJNRZNqBSaqJ4euMcGKqFZuV/jKVSqwsDvG02ZYiY/c?=
 =?us-ascii?Q?Nh9ZPisBoa/pYni5Nx8C3na7Jlfv5kPpf+ORpY87q4KHX4BqQAmIIHznhxHy?=
 =?us-ascii?Q?wENO81Rn5ZF1Q6aW0ZFzicKTmiKZQltSJGk3VfSXgrWXcr1YzHLSqsxuNt7Y?=
 =?us-ascii?Q?2K6gCHCFjbX4c34sRkQ7eB029DAaa1ytKaybDOQVbulvKAC5Qw0gu1QDM/7w?=
 =?us-ascii?Q?FkEuahBPwprLmOLbO7lPF4Az6b7lrwrKNwSMdi/2LyT1t+B0lm1f+nYGq61X?=
 =?us-ascii?Q?NwVfcb+0AH6KcfjL2OuNcfYyXcAxYCWC9tRYAFvqpL0sSwB00MTiWjG81Sb4?=
 =?us-ascii?Q?3vB1sx8hRhhAO2Xfd4qLgOzlH7Dss9CrwMpSa6+y9h76rr9WNj1d4D9mSzzT?=
 =?us-ascii?Q?DPof8Pq+56jM7P8L54qxLoPUVJ7IpUV16ivkjF9kmViyvq1g5rTooK4prSlu?=
 =?us-ascii?Q?PNzlztnwMErUkuEeAkRTmK3/x/H/szCauRRwDuYZjmmCY+liq+zk83Cy+trx?=
 =?us-ascii?Q?4FGlGiMq+5oqci9z+jQpj5jqLQuHzAMqcy508zYggSjCS8bCeKBnD6XBOHi6?=
 =?us-ascii?Q?DRjzhATqA3wfLMtOiIYgwymIDq14to0/0VQk86axa8ZtkHwTioKorscGi1An?=
 =?us-ascii?Q?Evui8TS5pbm17HClNsFPMC87trT0xZCpnMBIGZCXFC/MqoRQf+DYZTI36rLc?=
 =?us-ascii?Q?KXoyKKSeKchl6PyktF/PqflH515GFVpQDyz+635wymNStZXV6BR0IQ9KUDnN?=
 =?us-ascii?Q?4mqt27nM6I0kfBUlijalBMr1Y1fIcGqrolyS1IU9jMJx4r9I3EeIzLAoAFjT?=
 =?us-ascii?Q?D5KaJ/yXOTlJNNZEwqK+j3wGkTo9pyWIVaMM+Da4MI/lfiKSgiZ+c6QlpNb2?=
 =?us-ascii?Q?5URxBwf/FZw6794ghXZgap0jOBYx0lF1E92AFvOpSzn1yP0AwtuRaFxjlrsv?=
 =?us-ascii?Q?+BXfk1emwNx1F1IXg3ysshYtHXtAYpFK5bbKJOZyMKjiFgFqO3UJjJT4KZ60?=
 =?us-ascii?Q?eyCd+QIaJgsUcMNQC7QpQKLqso0GEUcGhC/m981QmXb3KYGBPCMke5eFcv0j?=
 =?us-ascii?Q?IVK/6NgfgRGWzG4GBgmDD7uQ3QW8yhGfAj9k1OuD/XRJVtc/IQaJSVJN/d/4?=
 =?us-ascii?Q?QCz7fTZ0iJ+r+vJ9vq6rnz4EoX2nrbmWfFQAm67hbkMWQw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5CD3031524ABA942B58BBD33DDAF7040@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a602c498-0ee2-4ce1-8642-08d96c88d0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 14:08:32.1973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9Cw1v4K6PypMjGW4ybrCjui/8hfmpg1SQExISZ19JoxXedsO7nEh9aYLe4aXruqEbMr7pA4ciSL5fbFdvS6jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 03:40:11PM +0200, Michael Walle wrote:
> One of the last devices which are enabled by default are the USB
> controllers. Although the pins are not multi-function pins, some boards
> might not use USB at all. Apply the "disabled-by-default" style also for
> the USB controllers and enable the controllers in the actual device tree
> of the boards.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>=
