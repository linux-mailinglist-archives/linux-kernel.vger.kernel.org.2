Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE540C7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhIOOoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:44:19 -0400
Received: from mail-eopbgr1400135.outbound.protection.outlook.com ([40.107.140.135]:28016
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233745AbhIOOoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSI9HfqtH+IhO47ygt43tiPd5GLU8YhWvIlI6obqkzgFyeOZlwun1WoA3y/7hJtlufTaaU4J3Kwyh93xcSxuigefHzebPF3jI/jil9YYMcdjYqOO+p34KN2ySoM2wV3S4j/Bai4GulLaSfLa6GYOxGVIHiapOK6ru6SZhxAcS9ODgLRj1qNMOcKm/um7bcl12IfG2tXQVB52TbIQOu+arhP7fy7+LDrgAWHhnLF7p+ryWjYqoDRE9alKA0A5E4Um4gmrsXfxk07R/q7XlEnMONNjjzemH7J+5xvfwrOkeAAs4UJIzZwhHnpT5zNKrgbOZxW5G1Vkmi2YOfO5CRIzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NuP13HZjWGgG3gEABc2JNzsA/1rh49iH+oVXs/xcj+Q=;
 b=bomdKKUVGMXKJm3ivyESQz4IdZ0b/oqPZN+djrh/m8ByEHgCHohk7mPpeQLYPL2fiCkuWa5JdwiIe7kTj4eBtLdTGd9GrbKU+FMqb2wsR5MS9A2X8nsw1mCKo9YKK5ArfENSInaRf5yrd79NtEEIzv6zAegxLSywYEqt3Taytp3C606V25dqsg4ozpxZCG7zbrE8/E9OptuVYXGosQAoLmZ/7C1R0x+V3HRm0QWtoNlJbVCmRlCcExe36osVokGplTsHE2qQmfs3mLnHL50BKiHMNkVYM1+xpmjPyjmoeSn7DmJfzTeWo7LBS3H+zQV7aUcseN3d1IYMcUi+2NKkDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuP13HZjWGgG3gEABc2JNzsA/1rh49iH+oVXs/xcj+Q=;
 b=W6yrn/5n4kr6h05cj4E6OzcX48qk6/GzJIqVlaPZ/m1v48xfMql0dhABzHcvIm4NJHFSJSIplqP5G9psh3naTuFL0fKCzpo9OEek29ThAFygN842AI+z/aQantjNMYmq7Q/JeuRtf1Zkvdi2Rubl0iKMjBj1geBEoEu8hzcC5BA=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OS0PR01MB5907.jpnprd01.prod.outlook.com (2603:1096:604:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 14:42:56 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312%5]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 14:42:55 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH misc] misc: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH misc] misc: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXoCrWcPCOZLcVpEOu9zHAf9JJVKujT1SAgAC5dCCAAJ7XAIAAlN8g
Date:   Wed, 15 Sep 2021 14:42:55 +0000
Message-ID: <OS3PR01MB65934A451D6B347C207E222BBADB9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1630608353-7606-1-git-send-email-min.li.xe@renesas.com>
 <YUBmIWU6HwIjjeXa@kroah.com>
 <OS3PR01MB6593057EA6257006C7228542BADA9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YUGG8iPWMLx5vJ1f@kroah.com>
In-Reply-To: <YUGG8iPWMLx5vJ1f@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f0b1135-be80-49e8-b22e-08d978571af9
x-ms-traffictypediagnostic: OS0PR01MB5907:
x-microsoft-antispam-prvs: <OS0PR01MB5907588001D7FB694520C8DFBADB9@OS0PR01MB5907.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gzrpv4a/Ji4R5cUFJz90X7leI8JQr9Afl+PQHrGtiUutSrCAMYDOKZfQ3JvzvN4VCA856eWkNB8zPQYqcu5a113yDBo3hk2IMQI5jCyXLGWmYVZeCsHSegaeBLduWN4SLLQsRtt2YYllR818+drO9ER7xBkwinGOag1aSGPwhTrlOR83zFfAMRAkSGiCim25FcnxWt+NOUKmikLEhll1atmYyBfnNpwWQOvmETJo/o9wmWtUTeoc4M3mIqBGD53agB1g99esA0Lx3vy3UZYtqa/8ACZ1acSZy2JYoHK5obk8wBPIPPWByYSWi8NyAFRfw8wt775QYGRGuOOKb/6hL8YDrVdBSsNQX7xCA/fxf7LiSWvvjGjBDJrqB3buEz2u5MOc5zFL6qdqVBJiqAGWgwI5U/IduAWOTK4mY1y9JLZhecpaekeEE8L6JeU8XMMS8myFiGYtejB5055kRB/QcT/OB1Mkh05lNdLnAk+xzh5NKtwu9R2X+4dNU56f4VhQ9hdu8yNazkbDFWbRvcI5AGQeqY4VCS6hDp+i0gcaDt1fqnLR8NuekXtXRz4OPc0PrFgOEwO/DarpZG5aLrebjllwh82PSPKzlPBU5LkE8yagl9tIVdtrBMBp1w5rYIV/azkDjzfVeslioyYl8yMUlUpmFn2q4f+16q3dEwkuIG5chtcU/VcbdSp2MD+MYMvJBwJK/RX46792DKkT06UnMhxpjUPQkN8h0jB0/9iWBKbz1ZkOzQPieiFSY4yZg1MGw6hvSMayoEVdxad/aJAfHlIMAMxoeKnDF8+GDxPFFBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(8936002)(54906003)(186003)(122000001)(5660300002)(38070700005)(38100700002)(8676002)(316002)(4326008)(4744005)(86362001)(83380400001)(9686003)(33656002)(55016002)(64756008)(66556008)(71200400001)(6506007)(66946007)(66446008)(2906002)(6916009)(478600001)(52536014)(66476007)(966005)(76116006)(7696005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dSL0BuDdKlLccERkvEhyGqpf0Nv6E74QKqwKJwSIw2dwwn1H1LdSRu0RTPOa?=
 =?us-ascii?Q?yB6GJpAI/VOinONbSoZJZv48Pv68xKiEbdhjuiUxlr/4p8p3okM7GdwCpiQm?=
 =?us-ascii?Q?/nQxoxdBPka4GeOhWCT1XMaRsmBinxRDgs0/9Cr1FW+gZSMaY0GaaOB7rZEm?=
 =?us-ascii?Q?sK77A2x+EJ1BG31B0MfY7kGKuw5k0lGeg1lo4fxDoUsA448N2SStApm+i70Q?=
 =?us-ascii?Q?tq+k8H4U5Gc+QYzBGkIc551e+cnySoRf2aPCENFJP0LXfSFTbkqIkzChLJne?=
 =?us-ascii?Q?O3xzJAa4Lmga9spam0Zj33zqOlbvfFAPNukEwB+ZF2yghNJ9zZyN0RXMOlai?=
 =?us-ascii?Q?K/FEs82aYLTurByoxytc8wvCOiOn5NPOViULtI/dw9D0xr7t01Ekwqdfn77M?=
 =?us-ascii?Q?hLuMH/UJQzI5MpMCtZNDgJnJqbcWBm8nGLcBGXpb4QyKzztjw/r0WI2GqzzH?=
 =?us-ascii?Q?mwMQmnoC0RGMi93W76tk1FbmULI3T2BVHi1W49JicEyqv78HHf+JuDsPA75i?=
 =?us-ascii?Q?bSSGGDWKd80rvVE9CZ+Ml8LoBl2Le4RmmXwiLEmpJwDAWj1YjeQdB02EQ7sa?=
 =?us-ascii?Q?cectTRc6vBfU6m81X/T++9n/F7tmgQ8wV0hY7QAQt1ChbknOgNwq1pfjxBMb?=
 =?us-ascii?Q?47UM8R8sVDtTMK5b3UcXerg8SRxZu1NFukiPydDWOMKVu/DsEJbsi9qTl2ZZ?=
 =?us-ascii?Q?IVTfVxrNzwROdm1RFBCmCmqIlGu+yw4AWuwemkOzg8x4SrvLltCvCbacTxEc?=
 =?us-ascii?Q?3qCmr/V2wvk3IYN4nUyR9oEuUy32WM28wcCrdT3Cwhdu3brdiNCanYl2jU71?=
 =?us-ascii?Q?2ELn3bZUWO4VlGlHqV69K9o6OXuyLlbU7zGj/g0FijubvxYk0fKhn3qOPDAd?=
 =?us-ascii?Q?raq48b2ZmR05YY/R+Sx5QAaiooKxE0utgtXKLQV7RqHuBExZ4cL0og3H3hys?=
 =?us-ascii?Q?6JMnHpvM25h/KQbeRBwU2ejMg2r5Amyx0bmqtl5rjQtRudz6peQkrOPK4nNI?=
 =?us-ascii?Q?vBSP6arImHRtvD5/op3yaz+wYVyi/kpdyxKZk7aLSfy4QPFb78ztZjIcYwbM?=
 =?us-ascii?Q?DLsOFj1GsrWJ7e8kCpSfcjvWpx0osUf2fj6GMkBH7TVmpNLGgHNVU5tuIKge?=
 =?us-ascii?Q?TBSPdCXAh1wYWMfQdg69jCyfodQ9cQwz9ZOHoI1yOyfQerKV0HqynYYlU/PS?=
 =?us-ascii?Q?UvI/GBgSrovmetnLea6INhU1grm9MMJkP0nrR6KqSodKX9DsJP/JRUCtTDxd?=
 =?us-ascii?Q?CxzYL3PiORXkyKeGd16ZUT+Zr/khToEM/HhR4L41vsJ4K32pbQpACz5xjbWw?=
 =?us-ascii?Q?gudlEyif06bgJrGuQObzoItD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0b1135-be80-49e8-b22e-08d978571af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 14:42:55.8092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoXrKyt+kX3+tMyI9SCXsz1Lk1l4xY29X9Fwegwg2xwLWHi4rjEVLCqdu1x4c/f9lTXYxzcoW1JGBh4T6s5Rqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5907
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > +/*
> > > > + * RSMU IOCTL List
> > > > + */
> > > > +#define RSMU_MAGIC '?'
> > >
> > > Where did you get this value from?
> > >
> > > Where did you reserve it?
> >
> > No I didn't reserve it. I checked other code and they all seem to use
> > a random character
>=20
> That's not the best way to do this.
>=20
> Why do you need ioctls at all anyway?  What userspace tools will be
> accessing this driver?  Do you have a link to where they are located at?

Hi Greg

The userspace tool is called PCM4L (PTP Clock Manager for Linux) from Renes=
as

https://www.renesas.com/us/en/software-tool/ptp-clock-manager-linux

But the functions of this misc driver is not ptp related. It is meant for b=
eing called by pcm4l to
support GNSS assisted partial timing support (APTS), which doesn't have abs=
tracted/dedicated
Linux Kernel API's. That is why I went for IOCTL in the first place.

Thanks

Min
