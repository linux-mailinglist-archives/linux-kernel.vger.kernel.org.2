Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE6836E48F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 07:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbhD2Fke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 01:40:34 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:38415
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230103AbhD2Fkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 01:40:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBS/3TtmTtHyBSWClE7uBhp/C3is3QDxzzs6posd6ekuUP7K2+q9xXFxQGzHsNqkg1SQs6grJvM9XM0uBD6boE496weQBB8Ga0WCF4z4IwZsj+NsU8y4OsTz0juFScfIHT4jTcfQ44yhik5TjMPdlaumLU6wB34vrEaymKjzFq/5125OcMUtYg3vEhEKKrkJ5CaTx5cytAPMgzEF9ZCGrNYg+/uo3nh18ffVkVCWaaLRA8SXH/XVHubRLfGxfgxE/vHhc9G7ogzoAzXmck2v4w/gobxH9mV5RdF+jbuixUXZXtUbJ5cgI+8KqS3cQebMhG99aosS0KD5c5R/7VLAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCWeCp94EXHRPfeGuKDV/wJJq+Q7hliYg1Z0QILf4AE=;
 b=Fi3OBCM5TTxAQGUs+0gBVoI17gD9wLT+R1J86aL9aB1ZT4G0kpO1GWAf4KXa7scV+m/GnMLnRCLKtAE/UJmXFCUHDmtUOcs4EEF+lzeoL9sZ+vZ+2koHHUKgFybel4DBElVu+hlfG5QH03zmTHgA8enPEEnxk/qeMh6cYv/UXcpIp7hpGRciahpri4CBIzSFDTQnYRcLkxn7IdlqZ4taudSSp1ZwQReinKLvrvLqj/Kx4k35203Z1XNcmSySZ8jYghKJgYgpXQzfdV+ta8R7Lo/NJrZ4/8w8M6GV5j0nZKRnbALbeUC0hCcBgEe/ghbcCpoxq2XU8D0uzMcmYjk4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCWeCp94EXHRPfeGuKDV/wJJq+Q7hliYg1Z0QILf4AE=;
 b=k7FRuiV8vWV9j4p+eeBcuB19foMg6YDrQ7L70A9pWbERetqx+PyOvu3OGJQHamiqRqmkZUiPnBa9wyeZ0QxONX0jzoY61J+jkF++O8UWb3gEttXtPn/0x8Ot6MiABuR8aqHe4+hejxftsWPH/G3ssZ0ALblWS+E1B7uPScCSiD8=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB2320.namprd02.prod.outlook.com (2603:10b6:300:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 05:39:44 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8%11]) with mapi id 15.20.4087.026; Thu, 29 Apr 2021
 05:39:44 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     Michal Simek <michals@xilinx.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Dragan Cvetic <draganc@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        git <git@xilinx.com>
Subject: RE: [PATCH 4/5] misc: doc: Add binding doc for the zynqmp afi config
 driver
Thread-Topic: [PATCH 4/5] misc: doc: Add binding doc for the zynqmp afi config
 driver
Thread-Index: AQHXNb4UkbGD1gitw0iAJ3//RjtIaqq9c6EAgA2Qi4A=
Date:   Thu, 29 Apr 2021 05:39:43 +0000
Message-ID: <MWHPR02MB2623209FE0193119B7054FF2C25F9@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-5-nava.manne@xilinx.com>
 <20210420141504.GA3250182@robh.at.kernel.org>
In-Reply-To: <20210420141504.GA3250182@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2fc124b-fbb4-48bf-9c71-08d90ad13182
x-ms-traffictypediagnostic: MWHPR02MB2320:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2320FFDD00C102F781956ECFC25F9@MWHPR02MB2320.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G7Pi5itIFcp6reMgDhZILO4ZP4r+sKrgAsD9MJNssECfitwYYMU32MCSAu+4hFYzIlG5QDQkW0+n+nV0h6lKlcMJz8AxfeAeqjnvealmZ0MeoQZiI2GFPRbbs+Ch7jl41+3VyW0wf+G1617qkyWbLCr5ODaGB87OqZKsU97mmnBqy3oJTeYZpRrcFkAA3rqd4KEDnMbQXVxHN4y8J9NPH+3q1Qm9cvWw+I43g93k+oXgeDB8aiJbVEWOypn/sL0H3FvGg26vDO4oCiCunr1EA8fRWNBGukJaamOh4fEeO1IS4QYKHzGtT/1ifsn8XcJMVVs7ADiwzRHww1M3N7vm9yM7akLXldxIspbp2HoK/1cqYct6/8RuPzsPL/TUDWdJeA8eDiJ064aJS1S7zJXWEUxy0Px860XnTD+aDCCuefOL0j/dpEOaY83vfgJEIeYlfLyXU2qtgoUUaOPtl6D8b29ryHM1Nc5MXhZZJ2Xuq1E9/coLPujsPOsvmiFi5qOoa2DYY8zCC75PFLMyeHkq6wNdHCisM7xkwaiMlUnzgcg7rJlcFabVchHAFsrwlf0mmvvpKhIBUWSQHXkJUWcfRTEByHgBu4I/Wp7g2INXBunPR0o4R3W64pPDTzGMvjcvUCWHgtMC5R7iKnCjKnGlTobXc/fynkKJ3Yolsws5KJbd4QVmJvP7hoLmM8eTB4L9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(6916009)(966005)(5660300002)(8676002)(2906002)(33656002)(7696005)(66946007)(66476007)(26005)(86362001)(53546011)(38100700002)(316002)(71200400001)(122000001)(83380400001)(478600001)(4326008)(6506007)(9686003)(52536014)(8936002)(64756008)(66556008)(76116006)(107886003)(55016002)(186003)(54906003)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?T2XAA4eNsfbZMpki3Q58cQythfYXFn8/6pXEoj6ATFXWoKZ4efKVuVD3lcfi?=
 =?us-ascii?Q?pisyMTENd/oze8FiM3er85FHlckkCoJ1Zk4RcmgDLzPJF4GD4d3QGLPTjt+r?=
 =?us-ascii?Q?QjSjRnqvrWr5FDnAnIxMu9Vs+C3Erga5cN+MvQi2m1/uZsNtFUvnyLE699rm?=
 =?us-ascii?Q?mU4FFeGXNVUUghAH7Bgh2kyasR8wX/U1zvbMybKzM3sSMDI3XZ7BRDwCWg+Z?=
 =?us-ascii?Q?Iq85m0073u85rXt+29RUm+TCpo8yyq0MOm+Zr1n9G/XzFf59yYEL+DUQMR17?=
 =?us-ascii?Q?YjpcfQX0dd347WUgV+ZuMOnACSVNPJWKZpdg+23sLU0e2KKlWfk41G7RCjIl?=
 =?us-ascii?Q?CFpvsqFNO68+nY+lxi/g7Ldkwjkcpz2aM1S/mZJdS1l1984tZoNwiojk4uN+?=
 =?us-ascii?Q?Uf4TYfJ+Yqtr4PT7wm0qS7Dq9s8MbW/4t7d3eiWK7lJunzge7uIUfCPf9zhk?=
 =?us-ascii?Q?YPdajKVec7pgLCAHtvkXSvj8DXwOwjRUA5rd7OvqgDyYFmYmOOCiS0hZCmYT?=
 =?us-ascii?Q?QrLQNTmmVBO7ZSz3rogWjdZy14fxdLHSCjY67j/BfpT2u3j4L/UbYfIC0LBa?=
 =?us-ascii?Q?j+hfKwniUuim8xXWQEnZqM8Rc8klr8XH58OzbuVqAPwSi115RQrEvOfBUysL?=
 =?us-ascii?Q?Ak3Oj5I8QW3DUfL3rxyLRpO0QniWn5ZW+lR1RyUswDx+5PhELFoHSdeKlGa1?=
 =?us-ascii?Q?18gMndMzBAaqk+1eN1DbwEC/GYbISnOPX3TqySB8uyJ8tWwmdQKr7azWF9qv?=
 =?us-ascii?Q?LHnNXmOy6UE+s1QXEzSxyvsoBDp8wOck3QPRJL1sT8L7ZQFEBMxcrYXXHCBw?=
 =?us-ascii?Q?mxZfKnb1j+aMryCMfKLmy7Wi4G9elP4rFIEGBEIUJGD+KT+7f9jqjq1IoNQO?=
 =?us-ascii?Q?Fpf44WnNC9e4HuErKGfy8UuvvkEUptn7fQ/EMr5yAAADNt4o3QdfcSVicGFe?=
 =?us-ascii?Q?DfGXM4fwvtbbpbCBs2x9CSvZrYZOzvu3giko6yDI+EAs2vx2q+dZVvJzLehP?=
 =?us-ascii?Q?fgZEpNhhfdyAYcdN2S1VDc1iHuiScprYDen2ZSp/jDFHrebwi67g9kwU9sPt?=
 =?us-ascii?Q?G5Tl6J/1ODKupNHDokVxnvUmSZY0Juxbimjo6hjOnq46SqKOWT5s08cUGtOr?=
 =?us-ascii?Q?4iQ6FscVtis9pwpdrR9gNS5pGxioyobMN5nYersSTDWZUGXEm08HGcT0pp0Y?=
 =?us-ascii?Q?fr0yzXgKh6NJviurYkswvlj/zSl5ZJR57HKn5S4rttPA9YJYfeHbuAKif7ct?=
 =?us-ascii?Q?xsNof86+BWiEgMs8sPthjRL8fZvg/ctja7NAFHFlmiHdeY613UYVA3jZj0y3?=
 =?us-ascii?Q?C490sE86Yg/5jSyUhCRtU23v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fc124b-fbb4-48bf-9c71-08d90ad13182
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 05:39:43.8654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TGV2mqg0WIx8J5eMmQijCilzXVsLxYBpgb7uI0EGr+YK19a7pzWQ5iRgA6y9A7fuq9+Bdob/IRPbhh1aOafPpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2320
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

	Thanks for the review.
Please find my response inline.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, April 20, 2021 7:45 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; Derek Kiernan
> <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.com>;
> arnd@arndb.de; gregkh@linuxfoundation.org; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Tejas Patel
> <tejasp@xlnx.xilinx.com>; Amit Sunil Dhamne <amitsuni@xilinx.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; chinnikishore369@gmail.com; git <git@xilinx.com>
> Subject: Re: [PATCH 4/5] misc: doc: Add binding doc for the zynqmp afi co=
nfig
> driver
>=20
> On Tue, Apr 20, 2021 at 01:41:52PM +0530, Nava kishore Manne wrote:
> > This patch adds the binding document for the zynqmp afi config driver.
>=20
> Bindings are for h/w blocks, not drivers.
>=20

This Binding are for h/w blocks (PS-PL bus width configurations)
For more info please refer the below links.
https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultras=
cale-trm.pdf (Page No: 54)
https://www.xilinx.com/support/documentation/ip_documentation/zynq_ultra_ps=
_e/v3_2/pg201-zynq-ultrascale-plus-processing-system.pdf (Page No: 42).

Please let me know if you need more info..

> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  .../bindings/misc/xlnx,zynqmp-afi-fpga.yaml   | 136 ++++++++++++++++++
> >  1 file changed, 136 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml
> > b/Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml
> > new file mode 100644
> > index 000000000000..3ae22096b22a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-
> fpga.yaml
> > @@ -0,0 +1,136 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/misc/xlnx,zynqmp-afi-fpga.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx ZynqMP AFI interface Manager.
> > +
> > +maintainers:
> > +  - Nava kishore Manne <nava.manne@xilinx.com>
> > +
> > +description: |
> > +  The Zynq UltraScale+ MPSoC Processing System core provides access
> > +from PL
> > +  masters to PS internal peripherals, and memory through AXI FIFO
> > +interface(AFI)
> > +  interfaces.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - xlnx,zynqmp-afi-fpga
> > +
> > +  config-afi:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: |
> > +      Pairs of  <regid value >
> > +      The possible values of regid and values are
> > +      regid - Regids of the register to be written possible values
>=20
> If we wanted sequences of register accesses in DT, we'd have a generic
> mechanism to do so.
>=20

I will try to find a better way, will get back you on this


Regards,
Navakishore.
