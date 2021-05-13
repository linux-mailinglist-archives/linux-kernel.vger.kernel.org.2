Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B53537F997
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhEMOVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:21:44 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:59167
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234424AbhEMOUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:20:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdmeZd/XQsUaj3Mt5mWtZ9qscHrLgzWM2D46/Vs9Pex9LOAkSq7Vc6+uFMb5DjB+Uj/R0TI43ei5beRJKTLzgCT1F0+SOjEh9a/3Ps/YdAh7eW0T9FcZRVQ3/y1ETv/TNKwcMOu78U+CysaHmOfpTMflvLp4b9JaVsm8pYHGG6exVkSnK+n/5akFzzp911JzGPczYn/8K2215TiDUoRA2yydK31ywVXoAN7VEVuzOkOJuGOF8MLC/EYUMSWVrwX9TJem1rerBP0m/tDRSbge8zkBXAullYLZgnIUaVQJTNV73PdBDNDi75tCgB0rcOhd9ThQDAocriuI/llXvqA0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR6DUr919AJY+oJOGkDNMbnf9pSvu1+sx+MWeR6o6oA=;
 b=ZlLShWU5stHkdwkSCitrohqP9dvbfKqYX1qmPiJFv/AN7+oBpMeeQelJEorjbsX5ZTLZFGQGLVE/NPyIbtxl7DrmUn2XGkLkWVWl01ALRkdGnOVBkZUrP9BJztOt5pS01ue2pS2vHrhnGLt0RlK701z7nGLiP1ifg27C3MHJQd9L3hLmRjNj/q6nBoQN6mCwdlrurOA5blf1mZvCF65p5zfyfI8zwFQyrbJ5pNhCrkP8m7GivYPUfZpQ0E05qwzut8vB4YeT495kyjwUHAiWRLbhrwMBfx+jBV1Qsr6ApD4GGnlRxGuvNUFlIa228BwtRHJzGYEhSkBcoSzT5BwF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR6DUr919AJY+oJOGkDNMbnf9pSvu1+sx+MWeR6o6oA=;
 b=j9rQrOish0aXZHsrMb6wpo55Puf7xVZofiP3JotHb4AIYftIYnNFXL1Os/CPspcPJYMydNhnMZ0cevJLH/aTJ3g4r+9Wb0Z5r8yyRQeKUSDg57qMIzaxS7ipmXdchmjKEU9sCeu0/7Qoy42ctIjuYbU4V/R2xjAw9KtmucmrK6E=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0402MB2861.eurprd04.prod.outlook.com (2603:10a6:800:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 13 May
 2021 14:19:22 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::f0c0:cb99:d153:e39b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::f0c0:cb99:d153:e39b%7]) with mapi id 15.20.4108.031; Thu, 13 May 2021
 14:19:22 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Claudiu Manoil <claudiu.manoil@nxp.com>,
        Kornel Duleba <mindal@semihalf.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges
Thread-Topic: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges
Thread-Index: AQHXRhK6wSxUwtoqZkenOXHlDRJ4r6reBtQAgAKnz4CAAMsmgA==
Date:   Thu, 13 May 2021 14:19:22 +0000
Message-ID: <20210513141921.i7sfmekbcw2m7vxd@skbuf>
References: <20210407123438.224551-1-mindal@semihalf.com>
 <20210511030658.GG3425@dragon>
 <AM0PR04MB67542D30A9424D455DB3ADD496539@AM0PR04MB6754.eurprd04.prod.outlook.com>
 <20210513021214.GJ3425@dragon>
In-Reply-To: <20210513021214.GJ3425@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [86.127.41.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0a18c19-a8b0-4287-4aa6-08d9161a1b01
x-ms-traffictypediagnostic: VI1PR0402MB2861:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB2861C3D4A3E4B196AD0C6675E0519@VI1PR0402MB2861.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HaLImKWcBYnS0auArxtJa+W+uPbnzUNqJrSmDN2Eklqs12heGQjqR9juq1L5oQXtReRm/3bQXP/tBCZUyi0t3+huv9frPKlIzXYEwl1xV4ZlQlFrkKOPDt6n9R40MSiozrNegNvxZDzOMoh6E4WfalEafmMYAQVKdFYku9FFS0Q1WOQ5C8EMQt0xzhU10SdDlbFmgVl6h8gVWDiqiXdmJFUYlY16IxA+BYZfQrPjXE6vOscn5capcIdoLVaW2RSTQlmrHOVe9li3jBbO4qlC2FRo4AHuFYOUGF6vwNpymrf849SC59POtzwg58KTd0zGExvoC50BX1CiLKW2xiuI0CEa37RdVBJ7+8vRoYetYXC7DoQxBxDEmN+ZdNEO0YQiFgnU9CdVTFah2UXdwknyjGpAQ+tHLJgEGRgEuRLlrrds6GIE0AuBXDyRuJzkV+SxX7eVtNNJQIj6ZJJuAIV1l/sSj2kqx7cFkmveTh4lv7BFU/zZRwGvULFIANpnpOPgjuVAnh3pkYKEVxSdH54X4I2hR5K8LjC5BH6m9lQJqlXxDySOW/FgaUtwq8t1s1Li/2+EsiOjv1nPlxCrSM2K6aW3ahybrn4kaKBE7mn4Pkn+HoHgQb1+DqdxEdWNtTzBwgrQPgT3at7y4B5aNelmZ7n6ZQOSbmT2AXMwlEjeFQmBQ/VlGUCv+EKsGZhz0c+O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(39850400004)(396003)(136003)(366004)(376002)(6916009)(6486002)(478600001)(6506007)(9686003)(6512007)(186003)(54906003)(122000001)(1076003)(26005)(2906002)(966005)(4326008)(8676002)(38100700002)(7416002)(86362001)(71200400001)(83380400001)(5660300002)(66946007)(33716001)(66556008)(64756008)(66476007)(44832011)(76116006)(8936002)(66446008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MXeB/I1sZEpXGzSlmELyJ5J0iakf9leCPbdz/mAlweVwoSIaHEDLnaEjbetV?=
 =?us-ascii?Q?u8vAp2pwSGdqPH7tglNv0z8E3In/og1+9Hzol15oQkh9xLqVjmUd91t8+6wz?=
 =?us-ascii?Q?vA8+TbUuJDsXhz/UbRcKqzPn5W9EgH5CQTZgCJSCMT+JJR2rWGaBAFgb3uLS?=
 =?us-ascii?Q?hgwRPDaCRMldHOAcBiQf5cfrwlRWWr7J3EL5cXjX/VmvaWtMaa7xwyCJ+ocQ?=
 =?us-ascii?Q?8iEgH/mCDzN5zu1VcsnQ7JFKlDx6Mmrsoj40otJxdLER9KRf5bRzMtdfkQxu?=
 =?us-ascii?Q?Y2LJEiMGp1AQ0jdbKDHvcvYEq9kz6f6txgZzeEfS9AE+Ro4VVbYLBYj09fsa?=
 =?us-ascii?Q?K4cdHi+/A2XfyIonbewimrBakOK8RZD2XBZPsSkWgRp2+1JNCnJS641Ti3fB?=
 =?us-ascii?Q?aE0KacxAr42tAImydLyMaRjjdVK0z7VzDmiMWPs3G4nN8DrxbBiiSpEX9iq8?=
 =?us-ascii?Q?PHr7ws5910X8z6HX2mkT4qEE8oBjwsSG8TO0/0omlckkUsKuFj/uckc1dTM/?=
 =?us-ascii?Q?LyDg3rNhNXs5tHmEseywMPY93uNs0S+sPyB67qKjJaUrMu8TpRt60zjQLBQ4?=
 =?us-ascii?Q?9wN45+9d7lNK3W43GHGNaRJqmx7aHs3xpusVtPNRTwN0dEVsiSWuzhvgOzup?=
 =?us-ascii?Q?sDFuPXycMBs4LNTHjuiKWXajHxZL7m8jJaW8WvLqKkRhaP2s/60zM+T/28oW?=
 =?us-ascii?Q?FRFccSW292boy79hD0xuo2oQXdX6QxWWJ6D9ZtEmFhC68U7aNaP91eeduvAN?=
 =?us-ascii?Q?GdplKhVMP9CgmWJNoPgFiMFS7mOh3Eznx1XJw+P+1AdMGEXhdalpQ4kSUy+3?=
 =?us-ascii?Q?y4Lr/jF/f88+4Urn/3dJ2I6HgS+XCh9s8vRnBExx9thZtnmOfDiNaq+XsSvf?=
 =?us-ascii?Q?z+m5EI5wJe+5WEB8FbBzwzf8UjYTdUxxSQLAaMaQ28pHGhH4iGg+nZeiN4NY?=
 =?us-ascii?Q?ac+ETTcdz18+Tj/KWriWEScIIlMIGQ50jQu9PYQHIsED56YDICA3Argw2kHz?=
 =?us-ascii?Q?R4jkCKzLXDjand87rJg18l8ABfR+VZjo1+HqT4AekXHobYTzPEQ2zFYsaFBo?=
 =?us-ascii?Q?Z2GSPwbuMJSHY0XwxZoLJAiZsWQd2h3/NUXUWjXTVy5dVcXU3JIVP3FEVYDm?=
 =?us-ascii?Q?L4otjdlqsgXoog/rworF4vQ73CnSwct0czoKD+iYwNN4l6YWqjH5ODRcWJz3?=
 =?us-ascii?Q?FJ3++Db/0JEhTw6fkEFdPsOsBYk6263Lny+dhl1zUm/+KPQXNjqs4x6CXejc?=
 =?us-ascii?Q?WYaoIAklo/o5AE6R1WbPmf/cUp9TvzvH2BrAntx8Hu3m33HTBstEyOJBhVR7?=
 =?us-ascii?Q?Vj09bCa3TZtTe3cwEK0clqcS?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06E0CD60FBF9004FB6018489E1C93131@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a18c19-a8b0-4287-4aa6-08d9161a1b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 14:19:22.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyxfGwId7QvQKnlLHPv4gXawqhMs2Bv2Uj2Lh7fc3KrpKMpYp7obQStgopG+1H+4PukRTqDgsfOxlMS4Iq5TwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2861
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 10:12:15AM +0800, Shawn Guo wrote:
> On Tue, May 11, 2021 at 09:48:22AM +0000, Claudiu Manoil wrote:
> > >-----Original Message-----
> > >From: Shawn Guo <shawnguo@kernel.org>
> > >Sent: Tuesday, May 11, 2021 6:07 AM
> > [...]
> > >Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window
> > >ranges
> > >
> > >+ Claudiu
> > >
> > >On Wed, Apr 07, 2021 at 02:34:38PM +0200, Kornel Duleba wrote:
> > >> Currently all PCIE windows point to bus address 0x0, which does not =
match
> > >> the values obtained from hardware during EA.
> > >> Replace those values with CPU addresses, since in reality we
> > >> have a 1:1 mapping between the two.
> > >>
> > >> Signed-off-by: Kornel Duleba <mindal@semihalf.com>
> > >
> > >Claudiu,
> > >
> > >Do you have any comment on this?
> > >
> >
> > Well, probing is still working with this change, I've just tested it.
> >
> > PCI listing at boot time changes from:
> >
> > pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 ranges=
:
> > pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff ->=
 0x0000000000
> > pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff ->=
 0x0000000000
> >
> > to:
> >
> > pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 ranges=
:
> > pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff ->=
 0x01f8000000
> > pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff ->=
 0x01f8160000
> >
> > and looks reasonable.
> > Adding Vladimir and Alex just in case.
> >
> > Acked-by: Claudiu Manoil <claudiu.manoil@nxp.com>
>
> Thanks, Claudiu.
>
> Kornel,
>
> Do we need a Fixes tag for this patch?
>
> Shawn

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

I am not sure whether "incorrect data that is unused" deserves a Fixes:
tag or not, probably not.

Bjorn Helgaas did point out before that "The fact that all these windows
map to PCI bus address 0 looks broken", so there's that:

https://patchwork.kernel.org/project/linux-pci/cover/20201129230743.3006978=
-1-kw@linux.com/

And while it does look "broken", with the Enhanced Allocation capability
and the pci-host-ecam-generic driver, there is no address translation
taking place, so no inbound/outbound windows are configured, so the
range.pci_addr calculated in devm_of_pci_get_host_bridge_resources() is
not used for anything except for printing.

FWIW here's a more complete image of what changes with Kornel's patch
("-" is before, "+" is after) - again all is limited to the dmesg output.

 pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 ranges:
 pci-host-generic 1f0000000.pcie: Parsing ranges property...
-pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff -> 0x=
0000000000
+pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff -> 0x=
01f8000000
 pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: tm=
p_res start 0x01f8000000 end 0x01f815ffff
-pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x0000000000 =3D> offset 0x01f8000000
-pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff -> 0x=
0000000000
+pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x01f8000000 =3D> offset 0x0000000000
+pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff -> 0x=
01f8160000
 pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: tm=
p_res start 0x01f8160000 end 0x01f81cffff
-pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x0000000000 =3D> offset 0x01f8160000
-pci-host-generic 1f0000000.pcie:      MEM 0x01f81d0000..0x01f81effff -> 0x=
0000000000
+pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x01f8160000 =3D> offset 0x0000000000
+pci-host-generic 1f0000000.pcie:      MEM 0x01f81d0000..0x01f81effff -> 0x=
01f81d0000
 pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: tm=
p_res start 0x01f81d0000 end 0x01f81effff
-pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x0000000000 =3D> offset 0x01f81d0000
-pci-host-generic 1f0000000.pcie:      MEM 0x01f81f0000..0x01f820ffff -> 0x=
0000000000
+pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x01f81d0000 =3D> offset 0x0000000000
+pci-host-generic 1f0000000.pcie:      MEM 0x01f81f0000..0x01f820ffff -> 0x=
01f81f0000
 pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: tm=
p_res start 0x01f81f0000 end 0x01f820ffff
-pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x0000000000 =3D> offset 0x01f81f0000
-pci-host-generic 1f0000000.pcie:      MEM 0x01f8210000..0x01f822ffff -> 0x=
0000000000
+pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x01f81f0000 =3D> offset 0x0000000000
+pci-host-generic 1f0000000.pcie:      MEM 0x01f8210000..0x01f822ffff -> 0x=
01f8210000
 pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: tm=
p_res start 0x01f8210000 end 0x01f822ffff
-pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x0000000000 =3D> offset 0x01f8210000
-pci-host-generic 1f0000000.pcie:      MEM 0x01f8230000..0x01f824ffff -> 0x=
0000000000
+pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x01f8210000 =3D> offset 0x0000000000
+pci-host-generic 1f0000000.pcie:      MEM 0x01f8230000..0x01f824ffff -> 0x=
01f8230000
 pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: tm=
p_res start 0x01f8230000 end 0x01f824ffff
-pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x0000000000 =3D> offset 0x01f8230000
-pci-host-generic 1f0000000.pcie:      MEM 0x01fc000000..0x01fc3fffff -> 0x=
0000000000
+pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x01f8230000 =3D> offset 0x0000000000
+pci-host-generic 1f0000000.pcie:      MEM 0x01fc000000..0x01fc3fffff -> 0x=
01fc000000
 pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: tm=
p_res start 0x01fc000000 end 0x01fc3fffff
-pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x0000000000 =3D> offset 0x01fc000000
+pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: pc=
i_addr 0x01fc000000 =3D> offset 0x0000000000
 pci-host-generic 1f0000000.pcie: ECAM at [mem 0x1f0000000-0x1f00fffff] for=
 [bus 00]
 pci-host-generic 1f0000000.pcie: PCI host bridge to bus 0000:00
 pci_bus 0000:00: root bus resource [bus 00]
-pci_bus 0000:00: root bus resource [mem 0x1f8000000-0x1f815ffff] (bus addr=
ess [0x00000000-0x0015ffff])
-pci_bus 0000:00: root bus resource [mem 0x1f8160000-0x1f81cffff pref] (bus=
 address [0x00000000-0x0006ffff])
-pci_bus 0000:00: root bus resource [mem 0x1f81d0000-0x1f81effff] (bus addr=
ess [0x00000000-0x0001ffff])
-pci_bus 0000:00: root bus resource [mem 0x1f81f0000-0x1f820ffff pref] (bus=
 address [0x00000000-0x0001ffff])
-pci_bus 0000:00: root bus resource [mem 0x1f8210000-0x1f822ffff] (bus addr=
ess [0x00000000-0x0001ffff])
-pci_bus 0000:00: root bus resource [mem 0x1f8230000-0x1f824ffff pref] (bus=
 address [0x00000000-0x0001ffff])
-pci_bus 0000:00: root bus resource [mem 0x1fc000000-0x1fc3fffff] (bus addr=
ess [0x00000000-0x003fffff])
+pci_bus 0000:00: root bus resource [mem 0x1f8000000-0x1f815ffff]
+pci_bus 0000:00: root bus resource [mem 0x1f8160000-0x1f81cffff pref]
+pci_bus 0000:00: root bus resource [mem 0x1f81d0000-0x1f81effff]
+pci_bus 0000:00: root bus resource [mem 0x1f81f0000-0x1f820ffff pref]
+pci_bus 0000:00: root bus resource [mem 0x1f8210000-0x1f822ffff]
+pci_bus 0000:00: root bus resource [mem 0x1f8230000-0x1f824ffff pref]
+pci_bus 0000:00: root bus resource [mem 0x1fc000000-0x1fc3fffff]
 pci 0000:00:00.0: [1957:e100] type 00 class 0x020001
 pci 0000:00:00.0: BAR 0: [mem 0x1f8000000-0x1f803ffff 64bit] (from Enhance=
d Allocation, properties 0x0)
 pci 0000:00:00.0: BAR 2: [mem 0x1f8160000-0x1f816ffff 64bit pref] (from En=
hanced Allocation, properties 0x1)

My understanding might be wrong, but it should be possible for the PCIe
host bridge driver to initialize some of its resources by enumerating
the functions which have the EA capability, and not require the device
tree writer to add a "ranges" entry for them at all. Then this discussion
would be moot - that resource would have no way to be incorrect.

$ lspci -vvv
0000:00:00.0 Ethernet controller: Freescale Semiconductor Inc Device e100 (=
rev 01) (prog-if 01)
	Subsystem: Freescale Semiconductor Inc Device e100
(...)
	Capabilities: [9c] Enhanced Allocation (EA): NumEntries=3D4
		Entry 0: Enable+ Writable- EntrySize=3D3
			 BAR Equivalent Indicator: BAR 0
			 PrimaryProperties: memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties shoul=
d be used
			 Base: 1f8000000
			 MaxOffset: 0003ffff
		Entry 1: Enable+ Writable- EntrySize=3D3
			 BAR Equivalent Indicator: BAR 2
			 PrimaryProperties: memory space, prefetchable
			 SecondaryProperties: memory space, non-prefetchable
			 Base: 1f8160000
			 MaxOffset: 0000ffff
		Entry 2: Enable+ Writable- EntrySize=3D3
			 BAR Equivalent Indicator: VF-BAR 0
			 PrimaryProperties: VF memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties shoul=
d be used
			 Base: 1f81d0000
			 MaxOffset: 0000ffff
		Entry 3: Enable+ Writable- EntrySize=3D3
			 BAR Equivalent Indicator: VF-BAR 2
			 PrimaryProperties: VF memory space, prefetchable
			 SecondaryProperties: VF memory space, prefetchable
			 Base: 1f81f0000
			 MaxOffset: 0000ffff

This information, which is already present in the hardware, needs to be
duplicated here (now I do see that the 'ranges' property declares them
larger than they really are, too):

				  /* PF0-6 BAR0 - non-prefetchable memory */
			ranges =3D <0x82000000 0x0 0x00000000  0x1 0xf8000000  0x0 0x160000
				  /* PF0-6 BAR2 - prefetchable memory */
				  0xc2000000 0x0 0x00000000  0x1 0xf8160000  0x0 0x070000
				  /* PF0: VF0-1 BAR0 - non-prefetchable memory */
				  0x82000000 0x0 0x00000000  0x1 0xf81d0000  0x0 0x020000
				  /* PF0: VF0-1 BAR2 - prefetchable memory */
				  0xc2000000 0x0 0x00000000  0x1 0xf81f0000  0x0 0x020000=
