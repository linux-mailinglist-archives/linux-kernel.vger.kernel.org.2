Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E2F40C7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbhIOPBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:01:42 -0400
Received: from mail-eopbgr1410097.outbound.protection.outlook.com ([40.107.141.97]:35872
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233977AbhIOPBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:01:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKolmBTtPaRuJIipLFhNJnmbsqR4YW/OFQMRK0pCGFP2xwRIlHuYTGGRM97XgnZATksD4hPq076ad0RrUtltiGOWHnOeFOzTKdHxXV+BNXoJ4YzaNjCkJfb0W11XGfgdAFdVq7H457Z1NI058sILgl1QF6T1A2XEZzhJb2jHNTx0oaTvXxPryPsNZFRp3rZNKRrUwZB2pjfgdtMilQayYxNdEadO/VVO9A1WPbFw2yV7XuNjkwpC2oJbnxqiQqNWtINBPA/DtDsyM/MUMyp/q6mN5aR77ahC8tG0Cl5c3XbWJC28A9Nege+7QEYCzLB4kddFx+wOtCcSt24nqBUoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vFroakeF+u57f0KTnX0ymaKB2g5vUB3OHZ5M/nvTS4g=;
 b=CwozWF2Xj4iJ1Zmx9mDGhEB35A3kWwCkhqeEiP4HO2Iyqig50Dq0J+8arveu9RSSdiqh6rBFClQBQPc8TRHwi1zqM06HZsG8/3FrnHm9yKHg0fhjkJ/VO1Saj8EzdcMvnj/hWB+Hd4o8YUo43bHLh8/fR7jIBFyqzpXXBaSXHdYCJVzKp18ZfxUqt6BRMa8LWoDvtrs96P57gXMXCQGbB9otyNE34c2ouwE7IqWyrEIU6XAI2X238VcAyd9TYKnP8ky+28bIfKLLxq9NetAhseqX8kv05FUdsF7SHbF0yD/KPoYHMWCRmsVKleMoKomsr+Qi7ds+xZ9Mqs+0liByYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFroakeF+u57f0KTnX0ymaKB2g5vUB3OHZ5M/nvTS4g=;
 b=emAQsDWCK1FSU47FeSia7ef6V78YphMecuM2soFdMfHOUOkzISdXMjwigx1qTJgfgZ4rWyXEP/+FlvFMCrrBDZC4CJ4TD46Mbh7mEEBB4dYd8VAgcCyAFGT+Ge2+iAjwENeQe7vTyj5bO1JhNodW7jghMCoc3AnNst8p6NLfGN0=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSAPR01MB4467.jpnprd01.prod.outlook.com (2603:1096:604:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Wed, 15 Sep
 2021 15:00:16 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::84ad:ad49:6f8:1312%5]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 15:00:16 +0000
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
Thread-Index: AQHXoCrWcPCOZLcVpEOu9zHAf9JJVKujT1SAgAC5dCCAAJ7XAIAAlN8ggAAD/wCAAAC4AA==
Date:   Wed, 15 Sep 2021 15:00:15 +0000
Message-ID: <OS3PR01MB6593101378E924202DD7162ABADB9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1630608353-7606-1-git-send-email-min.li.xe@renesas.com>
 <YUBmIWU6HwIjjeXa@kroah.com>
 <OS3PR01MB6593057EA6257006C7228542BADA9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YUGG8iPWMLx5vJ1f@kroah.com>
 <OS3PR01MB65934A451D6B347C207E222BBADB9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YUIHLrgU3H2ECoCf@kroah.com>
In-Reply-To: <YUIHLrgU3H2ECoCf@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84829d76-3523-4789-5558-08d9785986e4
x-ms-traffictypediagnostic: OSAPR01MB4467:
x-microsoft-antispam-prvs: <OSAPR01MB4467D79E85984D9CAD97325FBADB9@OSAPR01MB4467.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cGgIQliiEARBzbyVuW1Z4LERmrg68E7SqXfPeEWL//PQm3NTlShv2vzJKH7vVXIrwOW66FWEFUYgvvbMABjY+FBhQnuIuOVpOriyaiEn5tRLITwifM0yVTTPUdwRG6R+pttkHp+4tdvIdW90lPl3G8CgYLTrK4UmD++DKgaEwdjrYv/X0fH8BNrbuys5eXsxGBmR2okylbEiTpPa285H4h7FGIT+J2HNwtR9I4UcP3RJLF6hKSlA8NfhWkUGtlXJ3IvcCzMRpAgs3PhLC81RFHbir/ubuu6j6IBsIpuZVZWXVin5pf3qADk8C30W4iKTbNOvTh2IPWkYDNp0pSqJWrnJyQ0JhI1ZtAx5/Q+WG+M1lJBJNRZeFnftaxsoyQ153IblHqb8wZgUXeR9YD7DAEhncKP8EY7T/0CHg1eEAMTuDZ+kZETRcGu+XS75C0Psxh5fs0xcsrLStc1hJYMwVEcFtbVGljFD6MUg+dKpH1t9h/xmHPWkkct2poy3FrKQIh7fsTDVUaHRdIOSanisiX1V1bCoPiv8QpPizN40P04Btemw9cKnIEHEF29rRT1Xh46cvbU7hiKlvDgDh08ncHuDsGVUfMEw9c9hJgaKwKONeKJw+k0fCM1z9q5rpixtQJUq6vhIclnTe++jwRNX0Seq2g9IEDn6sSgBD5RqGHa1h2SoAtAszJ5TSzxCOAyUhUgOYkEX7oybs6J7FXzQwnysQg0cIwixNcKHRNB6IxQDITaEb5+skuah5BmQL615gZl1wAFmJoIKqWvlQZf//SPrt44alOXvty05IlTIKg8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(6506007)(478600001)(71200400001)(5660300002)(186003)(26005)(966005)(122000001)(38100700002)(83380400001)(8676002)(4326008)(86362001)(7696005)(8936002)(33656002)(316002)(66446008)(76116006)(66946007)(66556008)(64756008)(66476007)(9686003)(55016002)(52536014)(2906002)(38070700005)(54906003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ni2BrYHJK0D8PoIoVzooUkN+ttqjedfag409aVnWzr22S4ebQi2DGifCLlDX?=
 =?us-ascii?Q?rgg4tFOUxIp3vM2coQLZwtHy5WnqsGIl4Effa6R4sEBuTDJ63cY5M4uorcGo?=
 =?us-ascii?Q?IYHQFfEnZ8TIko4LdsvRv+H8esUbEFCpoCt+ILiLHaQkGDX3XGz/z0JJ4T4z?=
 =?us-ascii?Q?Td6gw4GcD/3gB5cgxlcysv7Jgr74ueD3VgZY8C+PcL4ZEFR2WNhrp6XIONP+?=
 =?us-ascii?Q?Frnye4GDNIxPd66lY88MjRDCSDpRjPP98lbUvZ9vvb2TCThGAmWpcllHfV08?=
 =?us-ascii?Q?rhLl66LdbXonZROWDdV05UrfNdkJlAwpK2zSF1s8zfw+5wqlxaZATrZvwTQp?=
 =?us-ascii?Q?A0yivy4B7h1GASJhyD7vsW/tF35mh3uMXTn1IiKFKL2vzmsyayihvrIHOLY7?=
 =?us-ascii?Q?81D/Jpy6SnAFFUSMZCA4K1N27dsrHrJhrpr6k30HAsTuO3YQyhWo8bMieGwx?=
 =?us-ascii?Q?Dz/F3XODkrDe+uV9QC+3yUacdUxYCTQxYVRGuevoEF0kvAvZ7ub/150PnFWy?=
 =?us-ascii?Q?+0DfcNp1v9znABnqhR+PIBOd0OENuO5HryzXCr0e1m+/FxigTbGjcd/AHove?=
 =?us-ascii?Q?S/q7EyB9nPjQQy1f0yNx9MMv3tCRrKS7Fjg6RXqi8oLtYbw/vSCROd0bbL46?=
 =?us-ascii?Q?a9Xv0FEkMGwTm4AwLl/v9q0IANOIQqeiCGjqwt5rsFOZB4VPebsi9T1S1BL+?=
 =?us-ascii?Q?RRQLht9ZIcbY+K+Gvw9FXSUInNZG7q5pyg6pTelYzNVr7IkGq7IzQ5MEouJx?=
 =?us-ascii?Q?8Q1H27N3M3vtpLSVye0c97/3VoLUCNAIsCj9ZpdHnO4IcogX1780XGC5u7B6?=
 =?us-ascii?Q?e59lehxdSS4zeG4xqeMf+C8iMaVJVhIpMu+AkPZFalaI0//BSuK6jefWSyFw?=
 =?us-ascii?Q?zObnXwIzl+j/99ahBn8kyDhjPd7KwIwUR/IPdKN9w2NKwCNzCWiZCB+JnhFx?=
 =?us-ascii?Q?w/agLNVL9ttsJ6SViuB7zeEcbR5i9oTCMy/LesjLYsYIiPDl7kgzcldPU24V?=
 =?us-ascii?Q?dtdmxqPfd406UpHijDzf4x/XNWOqs9UfbONn6JerDTpdw3ED5/elfIduvRy9?=
 =?us-ascii?Q?lKdBxIwaR2srnAxkYVAFlVK1LGJm8IOoRE5wob3L3KUSccr/Yc4Kqw4IaBgM?=
 =?us-ascii?Q?gUjxFn6iyyx8T9UOznKLZ/CHRME/05o0GBQUcX3MqDkAZlVZH4Cs7jJigbfj?=
 =?us-ascii?Q?0loBmq7oZRjGhXPYBYEcDGGZm+Q34twkZ7jNkM6MITjmd+Eii9W1ac5eeACd?=
 =?us-ascii?Q?/c4F6OUeDNw42gJmlbzl0+ZAyjCW/PPPRleKROhOqCjDuwkjTIYqwOxRRmcZ?=
 =?us-ascii?Q?FUw9A+LNTIi2dNJ9uEHU1PTr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84829d76-3523-4789-5558-08d9785986e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 15:00:15.8904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nebThljaO5Xdd58CUnsJ039fsMw1wimwgFZOm0lkOVJ7fG+zDu9MmVFD1Apmi/4Oi1Eg6RTymDuvHzt13W05Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4467
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Sep 15, 2021 at 02:42:55PM +0000, Min Li wrote:
> > > > > > +/*
> > > > > > + * RSMU IOCTL List
> > > > > > + */
> > > > > > +#define RSMU_MAGIC '?'
> > > > >
> > > > > Where did you get this value from?
> > > > >
> > > > > Where did you reserve it?
> > > >
> > > > No I didn't reserve it. I checked other code and they all seem to
> > > > use a random character
> > >
> > > That's not the best way to do this.
> > >
> > > Why do you need ioctls at all anyway?  What userspace tools will be
> > > accessing this driver?  Do you have a link to where they are located =
at?
> >
> > Hi Greg
> >
> > The userspace tool is called PCM4L (PTP Clock Manager for Linux) from
> > Renesas
> >
> > https://www.renesas.com/us/en/software-tool/ptp-clock-manager-linux
> >
> > But the functions of this misc driver is not ptp related. It is meant
> > for being called by pcm4l to support GNSS assisted partial timing
> > support (APTS), which doesn't have abstracted/dedicated Linux Kernel
> API's. That is why I went for IOCTL in the first place.
>=20
> Why not work on a real set of apis for this type of thing so that all dev=
ices of
> this type will work properly?
>=20
> thanks,
>=20
> greg k-h

Hi Greg

That plan is on our roadmap. On the other hand, this is a new area that dif=
ferent company has its
own hw/sw solution and it takes time to abstract functions to kernel. Also,=
 our APTS first release
was already out. Right now we are actively developing another release that =
we will try out best to
come up with better solution. =20
