Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA9536E45E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 06:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbhD2E5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 00:57:32 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:7137
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230071AbhD2E5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 00:57:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNWeZOautCp3b39CqnnZctVTtQpl9tH+tHeYSFSXn89ELdaKjIy+QGFF+7Ot1RtJiczkl6xyFhnQOE5mUcBGq92LCp2faiGwPoA8bjsHOTPJw8RJCd7Z6jDU9zmlJWhWvVioEH4Jfc9MQ/xrDtS7UknngwRmSqtdEjT/wrtgB01ZXYak/MZX/xU96qg89c/B3F+3Fxg62JwM3V+C0SYiGPusM7VwEhQ02Mr8flXe+HQBF2jI7Z5kiF4N0Be3l1npklbmvOWADVcoqgmnuw7smS6gLTBv6ohpE3xzNofDg2FOg6sk3l8l+EqYYVhHRYqsb2ztiU2djCkhUeon35qGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9qHf2TT9xRMmkqAeiF4lzJUq0EzHvhSPzNoZl+4PuI=;
 b=iPnV+Nhe6LkczfPHKkBqRFhe/S5ZsutUK3FZGWKA2vspqFBOpEu8gCK+v0bQV981mv0cz74inYCDjd95an3vHAY+r1jet8C9loASW8qCLPSVmlM+cDkZoczkDm1SbFXlaTJH1Hok0Nj7GPlPoFRXqKpZXg1JGTsnoP0pRuwLDF6pabrUpX8ZsYcIlol71XsaDbmmA6wd3jXwZsNV9272ZcVsDl8RUkZNxkXK0gRijLZX3o1EXw/ZHGJhIBiGoNCqvKpNsnKir40QRLjBfrGe3izZ6RUg9Lf2KxD0j0jmkL5XFduwB2aw3Brv0kUP4kucZyanQwVsqSJUn+dp19i9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9qHf2TT9xRMmkqAeiF4lzJUq0EzHvhSPzNoZl+4PuI=;
 b=Z4Q2pTzigvftyEamzYXLswoyb/ZrzjyQ7XVewH4r7kPJxOG6df5Pfdknk1WV1Fu/AKd06EWpfyWirON01KYPzWK03i14FTz9N82WGnHJGrw/nGgsDaYVrnU5ZGqn+pjE7ZfrG50n6Ey+4+QKl5Ubjk/m21LPDD19Gc2e5idxyMQ=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB2784.namprd02.prod.outlook.com (2603:10b6:300:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 04:56:43 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8%11]) with mapi id 15.20.4087.026; Thu, 29 Apr 2021
 04:56:43 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Dragan Cvetic <draganc@xilinx.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>, git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 4/5] misc: doc: Add binding doc for the zynqmp afi config
 driver
Thread-Topic: [PATCH 4/5] misc: doc: Add binding doc for the zynqmp afi config
 driver
Thread-Index: AQHXNb4UkbGD1gitw0iAJ3//RjtIaqq9bw2AgA2IRRA=
Date:   Thu, 29 Apr 2021 04:56:42 +0000
Message-ID: <MWHPR02MB26235C242818EF48E9026040C25F9@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-5-nava.manne@xilinx.com>
 <1618927121.480164.3235334.nullmailer@robh.at.kernel.org>
In-Reply-To: <1618927121.480164.3235334.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3271a22b-6b4b-4d20-a9f4-08d90acb2eec
x-ms-traffictypediagnostic: MWHPR02MB2784:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2784E18F1274B24915840C05C25F9@MWHPR02MB2784.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JKuadWhGCZx+UjqfWVp4qxqNNl5yUp1e0Bzu0v5WKR56XeOdhikJrTCscErEGgYSLbXQxjwQo8AmT8SaW0IuKg/tXhBVdGdmafQ6uDy14uTv/X7mqZCn3CjnAEMI6tmIhqPbZCMZs9AWMErvimj6EJ2DyouDATiteCI4HqDYQ5z+Nh6NO6tPl7Q7DO6O9rjecpbTcejUGOrcDf+IE3gbphyzWw7xWF3cdchbwBcu/Rr+mWNJKFY1uO6P/p7v5U29euL5UTMYpMyhMLLjpLiRQJ1gQXkWGAAY7hWcYB1TOxCYl88pPgvMR7RS28E4Gk9EpkNKa1AhwgJMu/raEKmhM5qvOKKLJb+WCLQg/720EMY5Xy8R9/5NygP4e999jZogKmrYwZhP9BSFgaw/1a/awnN3ibVXi+Y0vOL+z+kJCMV45DMu0FKNNeL2cDmFmeS5rqmSUDSCshYYlWqNl0jjpTwqH58lDeiCJbn/BqGR/UFREmaFyRamC0urG6FGSZ/nEx8ctk3HdxeQ/3SnTsfTQuus9OqnSVdkbx7nmCGfneZPTA7qD0RiEsHBMESyH9B+VZUXbWRH8gJf95B7IMkTM33F+UDurhquQbvA0zh8EF1RoEsPlQBN1B6/NBjHGIQbra7W1uL91NzdIaRolG7Kr2nAhxVtmR6kxyNQhYRlww/SVkN8HoItny9nq+MrqPqx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39850400004)(396003)(136003)(5660300002)(9686003)(38100700002)(55016002)(8936002)(33656002)(316002)(83380400001)(54906003)(66946007)(7696005)(4326008)(71200400001)(52536014)(76116006)(86362001)(6916009)(66556008)(26005)(966005)(8676002)(6506007)(53546011)(186003)(122000001)(2906002)(66446008)(478600001)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JnB4gAyFT5TN6THwASX8PTiX7F2WUF1PtlpbBb4Xrgu3vhcHcdUtYyj7OY8P?=
 =?us-ascii?Q?fxE8/qP+oyQyFxouL6mHJTfMdnqheE2IIxRWMrQddaGOgoAEUfxhar6ujfMl?=
 =?us-ascii?Q?FnAmm76xZdoHS1+R1In4AHU/8tLs3Lh1mZrIldBvZEvd7+OXLahniR3rG2Z9?=
 =?us-ascii?Q?zneGhiP1R3QYo8PVlCIxRtU3uspZXFoccJVy9A8VtIwNaJkvs22om9rqur4E?=
 =?us-ascii?Q?IM60aVYFV9pId9xQ13RWTG26RLqNa0Ag8vYrKpcF5X1Wt+K6sC/8TITe9qmb?=
 =?us-ascii?Q?82q0WsSL2nCHPzeI4iFAHcEoB5Dojk5HDICpW6nR6jZO6EG8AjufluR4LMEz?=
 =?us-ascii?Q?heXCXdJEhXbpNS0DfIPzZ9p9V+qqkuTS8k9nogcqzRV7M8c0j0/zHmSmOQTl?=
 =?us-ascii?Q?DaaR1lGt1MFoKVEbCSncf6NSc780MT5QcatcBdyiJkIBkQScZP+8EgZK2y3D?=
 =?us-ascii?Q?abdtK7PVS9JpyDMVoxB4P5TkRvwX6UWR4ImOlxIl0cHm39WXV2n3tD/BVmu6?=
 =?us-ascii?Q?X4VR5VUzBLdwtYGCAUMpHCOhI9mTZAq+2dVHtWMILo3JeLavjGPUN8gtweYO?=
 =?us-ascii?Q?nYHClr8Wf0WUkZaoD7g5yeAruK1eNuTSPxdt+pGkoCZ7MgtK7hfbNkyHtTpk?=
 =?us-ascii?Q?qdcZs9WJBjbOqNhVVndSE1SugNhzFWlL0b2MIr9bqEUQLR0QogOXt1m4djTd?=
 =?us-ascii?Q?RosRvCAnB9+K9+TvIZOgZiD1LGawp17JhIDxS/VKpUA1dS1VdHxtAwr7EDHL?=
 =?us-ascii?Q?Mp6Z5z6wK9hWvhB37cJqQDkrYBY+g0rjlocpHvmMT2n7hhuvMpp3Iw98nGA6?=
 =?us-ascii?Q?G5EwSvere2wCWABCfgPGy2JWh7wg4/Hnd3JMhfDqqFYy7jE05+772ulQB+Bc?=
 =?us-ascii?Q?I/Q67BlztQnte3RippDSQ4yNnoQni4mWHodHuKTJqLHRrT2t+Jp+9NOcMwuC?=
 =?us-ascii?Q?uzy+xLYxiAH+SNPpqAdhaTolu0Wbk4foXrFR/xpV1Ksnd6WWZRwVUcqKKys0?=
 =?us-ascii?Q?qgwiXABHieqgKqIutPzVTRlfY/GsNpJ5FJQv2U8wUPJdmuR4I1gtG10DEz98?=
 =?us-ascii?Q?3EOd8znK7/ztFvRah3KJnZCNpF1Pz4zGX0A/jq84vcET0V/52FZ1EzJoQfcW?=
 =?us-ascii?Q?l6DyqrZqGmJ2+oBmMOI1aRe7UFsBSltrF4+npEhMnrd2IfG7a/jpTKUjjf3Z?=
 =?us-ascii?Q?8y6/SdUVRCzPI2lsEXl0ECczMqrdeIh0OkcOO7oosQin4IlpfL4PXXg6T+j2?=
 =?us-ascii?Q?uYax8reGJBph2hg3AJnX3IBWFj6iNHfoUSs2+kTp19u9d1oQACjH78dzi9r/?=
 =?us-ascii?Q?u5Sfetbg1KaleUEg3SRIgcEl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3271a22b-6b4b-4d20-a9f4-08d90acb2eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 04:56:42.9297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jP+rc3d3ctfyb51M04S31SnDfAtgYO3vjyQXn9KX5iPhcah+G1juX02ViThLtTgiHBXHWZW+Jk7DtY12v473Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2784
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

	Please find my response inline.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, April 20, 2021 7:29 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: robh+dt@kernel.org; Tejas Patel <tejasp@xlnx.xilinx.com>; Michal Sime=
k
> <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; linux-arm-
> kernel@lists.infradead.org; Amit Sunil Dhamne <amitsuni@xilinx.com>;
> Dragan Cvetic <draganc@xilinx.com>; Derek Kiernan <dkiernan@xilinx.com>;
> Jolly Shah <JOLLYS@xilinx.com>; git <git@xilinx.com>;
> chinnikishore369@gmail.com; arnd@arndb.de;
> gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH 4/5] misc: doc: Add binding doc for the zynqmp afi co=
nfig
> driver
>=20
> On Tue, 20 Apr 2021 13:41:52 +0530, Nava kishore Manne wrote:
> > This patch adds the binding document for the zynqmp afi config driver.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  .../bindings/misc/xlnx,zynqmp-afi-fpga.yaml   | 136 ++++++++++++++++++
> >  1 file changed, 136 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20

Thanks for the providing the update on the new features

> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-
> fpga.example.dt.yaml:0:0: /example-0/firmware/zynqmp-firmware: failed to
> match any schema with compatible: ['xlnx,zynqmp-firmware']
> Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-
> fpga.example.dt.yaml:0:0: /example-0/firmware/zynqmp-firmware/afi:
> failed to match any schema with compatible: ['xlnx,afi-fpga']
>=20
> See https://patchwork.ozlabs.org/patch/1468230
>=20
> This check can fail if there are any dependencies. The base for a patch s=
eries
> is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

Will fix in v2.


Regards,
Navakishore.
