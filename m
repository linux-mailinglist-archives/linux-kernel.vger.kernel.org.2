Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121CF34EABB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhC3OnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:43:05 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:33069
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231627AbhC3Omu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:42:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPoWPv+geufSjS7AW8Dfgac2q3DsVHdiPiWhtcHp8pBkoHyAXLidAymQaSI9jWUk7kjwrQIwrS5ZaP188fC26H87JppAcoqxsjf4ewl2u4Mc6+sJ55TIqB43ZnyZyqTiRbqisy/6EhnNJ3pqOgbLqAavS9xOO5tgYRe7aUSNdnKTJJ+UpUwOO8jT36NkoFTtrO0H644DesDRrcXlQ51nUXZRZFIDpufLgkvwwTgot9+Ri4PGzqmZh3YFHmQ5vL+bEIoV322X5Ht/uXRSzKQ38CDHLT275ckdMZ4P+zIbU6wL8Yk8DjtKDRpTP3vJ0KqdfDs8FymSOP0m9u2BnMbvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZU8t0PBp+/2MV2JZdzUZQeRKlmso90C23pVYnPSQjU=;
 b=RO9en7ZiXrNrlojejZusJBrLKnCgdbhqD1Zld/RFTCsELYrLeWJGTkWbtP/eyTU4zRhyhlXrnhTBn69ZZAUX2r/uIj9EpfJ0VPSG23taYEi0V96UFH6GjW1XE6tJQ1Idm4lPLXn+JZjPGC6a4J8O6qOVHLKSx9ysYtR1zwCgIfHGLlUuQL2UB+nAwfqfxh3s/xKvR7nG2yCG2pqED9TOj4FvIlRe0RoPSCJnKB2/tZhecHZNiSCzSXph9at5QnaimHgZyZeNaXy3LO2e1GsDY7XlzFiE2xwt03StdxzDplrIZYTO0oFV7Wm9oVuRxutbpesF34OirXAsppg02zho0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZU8t0PBp+/2MV2JZdzUZQeRKlmso90C23pVYnPSQjU=;
 b=T61mc9WWh//J9fkjkMLuKkKDZM++UgTg2qQIZs6JeIwwN/SsaOG+TXns/E3CKsBBe0ZfS2XvqnASHXALkSYUTqNplBRE63/IiLV9MT/5/dnkYpLmg7K739bC6k1PD4g367zanoWadMS699p4wK6+G8V3kl9F02ZCfbYw+1S3oEs=
Received: from DB7PR04MB5322.eurprd04.prod.outlook.com (2603:10a6:10:1f::15)
 by DB8PR04MB5849.eurprd04.prod.outlook.com (2603:10a6:10:af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 14:42:48 +0000
Received: from DB7PR04MB5322.eurprd04.prod.outlook.com
 ([fe80::7c4b:7e9d:a414:d34]) by DB7PR04MB5322.eurprd04.prod.outlook.com
 ([fe80::7c4b:7e9d:a414:d34%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 14:42:48 +0000
From:   Sahil Malhotra <sahil.malhotra@nxp.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sahil Malhotra (OSS)" <sahil.malhotra@oss.nxp.com>
CC:     "kernelci-results@groups.io" <kernelci-results@groups.io>,
        Michael Walle <michael@walle.cc>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: Re: next/master bisection: baseline.login on
 kontron-kbox-a-230-ls
Thread-Topic: Re: next/master bisection: baseline.login on
 kontron-kbox-a-230-ls
Thread-Index: Adclcf8c6SY/VG0HQLO42N6rBLVfeQ==
Date:   Tue, 30 Mar 2021 14:42:48 +0000
Message-ID: <DB7PR04MB5322273BD92BE06417F0A46D827D9@DB7PR04MB5322.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.64.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6742228b-3ba3-4255-9fda-08d8f38a16a5
x-ms-traffictypediagnostic: DB8PR04MB5849:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5849348E8CEB848EBD1519C1827D9@DB8PR04MB5849.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VhF+OUWOYanAtGsssdTFkhrep6E4upSk+f6Zl7kiOcJ0nOqVotET6tj5pMLcciiYjL85PCXvGYFrT7U5HDuBnVRs3V5xeGc4L+l8rFeqwqeaKukvwti26WWEmmAJw16IMYdsyon5135BzXGoN2L+KBDTqwv42dARV3bIR8cflfLPZar/8bZj6KGIhVQ/9wHOsHwbOR9D8jMsJIC1i1shbWnRccFyiFxg4HtBoOiTMVMH5Jh7kk1rbQzcdiE4ZVUeMLcJBErxBqqecOh9r2dToF3CBWUY+J3XAgTwzDfKBzYrg7AKFD+ZllBwmTHRcOTYVxnxewkq0PC9fUFxswu6yngLrDG9X0EZU+tPUeTopOch9z5roL+T2D5fi6WcuOLJW4LS92Ntv0YtnDq0dh5No0YZjzLf+RDPvd9lJyHgYPHLzL7xi4lLWRAKmh8cRwSVkVayq4SIto7qFqr3loJQtsbZx389ZrRCcPi3YGgmgnbkv8rtIs0XeefSDKNpNKJtFyuMx0Dceem+68gOYAKI5zgA+ZtUlSisb5WCHRgS3pOT7eIGNH1wuMrwq/tUIk9UFTNyaCr2yfWOxqWZJ4oTCjj5XzmAYZIpGAjzhp29qdpouOZYkJdvJk/NOf/UnTgBm+3NCaLG5xA0PMs23zKNEgs1wy5VqryYsekZ7XMUqdVUF7VLEld5J2CSRPmhriP37F6TcxtkS3cFso+Ax1UDV8hDtuaIiwEjCMl8m4e2rEIpv2vZXOH1Yu6KReGZT/A1/eQA1dsr8BRxGH537HSPEMC2PixGG6LGlZK7xBJ3o2w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5322.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(66946007)(6506007)(86362001)(7696005)(44832011)(4326008)(54906003)(66556008)(38100700001)(83380400001)(5660300002)(478600001)(53546011)(316002)(110136005)(66446008)(66476007)(8676002)(76116006)(64756008)(26005)(966005)(55016002)(52536014)(186003)(71200400001)(2906002)(8936002)(33656002)(9686003)(10126625002)(45673001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QfO6Q1C40apIyxTwDd5Y37y+2wcdGrFJuLcsHakEZbjzS9iiZp5GA2bjSpmD?=
 =?us-ascii?Q?b3MPhZ/6gIgenpLSpOdbLRQvWw9j2xwk5NXyMBEwEqqmpWUHyoym6vFUB2kZ?=
 =?us-ascii?Q?pVuuVDqmXqzw66pR7ru37BteXLBVGQz1YLSBYMOpApeFnNddlr4MIIbDwqEJ?=
 =?us-ascii?Q?h0LeOduhUYoHNx07ilVo4anoL8xp5URPlzjVnPlxN5FOJms1/++6S13yG6Ox?=
 =?us-ascii?Q?v30DWpvgwsaNZMZUFxLMJ5v7VYwyPBlBuO2NIFzc2CHAIfJp8kgy5GSmyjQ2?=
 =?us-ascii?Q?b+QBsPBYKWY45jtjLUvmYu5tsZBzdbwCVrjzaUbJ+Z9jQvIlSuIjwtMQzfm0?=
 =?us-ascii?Q?CnM2SRlhEkdPiiIu5/xg5p+GtJbOXUmhJCnRH/iRhO44FspzQZl7dPngAX5B?=
 =?us-ascii?Q?f61diYoZhhjxghsUW60RFBUAti4EnFhysqRwNYpwOp3AQC+hxYA/jUckk4Pt?=
 =?us-ascii?Q?MrOjAeYwxO6ZXAakCRSGDb1s98bCJdBywPnSCGyxL0lc4Ft1aWCT60+6uDAE?=
 =?us-ascii?Q?LRJNmj1ov+MONPqMDhJLwhOF+ZmH2xMLYweD1PtsVP0mdBcrqaqgKNJ1prhA?=
 =?us-ascii?Q?CEAsV+gycFWEtmR/Wuk9CQA5lO7h6ZewH6R2QZOC+e30ATnuzW91rx+ikjKN?=
 =?us-ascii?Q?YphuCjKPms8Aq0UFiTKxDOadHkLxOUE6xQAbvuMM6oGB6hLIp6hC4nRKA4K2?=
 =?us-ascii?Q?MBLF4+JwvqnyoWEYYJtULRwMA5oySJZQj2JivCX2J4TPdkvWos4mp8ajtT/r?=
 =?us-ascii?Q?YtRNud5C5NOc4sbsqtZYA0RlLVGbksUHZYA8tDY57jvV+cEFch9d4ybrMrRB?=
 =?us-ascii?Q?52B0sNzSfG9vlWKhVzXZPQx8j4LNDTEI48aJkTtKGr/uEITbSdQ4teoQpE3Z?=
 =?us-ascii?Q?iUZIdMKBbTuKPdnrikxXWB3rYmADEpGgp5xf3+/QH+rCyUceG/+rVVCUVtr6?=
 =?us-ascii?Q?f9sWPf8qFuFR5VcbiOHUxLIDcQADmkIlhSKxPLg17I91nxQK6zdh3fv7ACDg?=
 =?us-ascii?Q?1oh0+XYKisjIXJKyd6yYGArKjc57zXSkMjEvpboYfOig69YexQ+RI7OWJyRO?=
 =?us-ascii?Q?wrERUZK168UonBc66lIiMtKJjUlsvIi5NJLEPMPkw5rWvVHBh7XFAGnkM9TE?=
 =?us-ascii?Q?25itGIXuaG/uwHav/jSs5CNDorqBh4dESqqozZnZLfdpo8hqG8qBrrxaHKKW?=
 =?us-ascii?Q?cwGGkgDvwT/g5aWgNBpYDaVKdpjCAB+lTKCtiXGzd9inl+V9RfTrZJogpLh/?=
 =?us-ascii?Q?X/SsMpww7Sf9EGjxqkv/Ix3P23h7hXRdDR76TKM6mdsJ6m3WG71ivBf+n36+?=
 =?us-ascii?Q?NedUAmwgZ+JXmS5d0GWe0DgW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5322.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6742228b-3ba3-4255-9fda-08d8f38a16a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 14:42:48.3035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5VxOsdNXT1vKTbudPZZBCgD9qnUC4ctscFM/8zkf/f/JIeT9W/MjyOfQ+7tAxtSeUUNw44BWKBb2q2ZMCR9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

I tried the same on LS1028A-RDB board with 5.11 kernel and my submitted pat=
ch applied.
Board booted up successfully:  https://pastebin.com/15D91K5k

I used OP-TEE from OP-TEE github repo: https://github.com/OP-TEE/optee_os w=
ith commit https://github.com/OP-TEE/optee_os/commit/d1447353d3f80ae49053b5=
4f525a0a4cf5e4cde7
Which OP-TEE version you used for CI ?

Regards,
Sahil Malhotra

-----Original Message-----
From: Guillaume Tucker <guillaume.tucker@collabora.com>=20
Sent: Wednesday, March 17, 2021 12:03 AM
To: Shawn Guo <shawnguo@kernel.org>; Sahil Malhotra <sahil.malhotra@nxp.com=
>
Cc: kernelci-results@groups.io; Michael Walle <michael@walle.cc>; linux-ker=
nel@vger.kernel.org; Leo Li <leoyang.li@nxp.com>; Rob Herring <robh+dt@kern=
el.org>; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
Subject: [EXT] Re: next/master bisection: baseline.login on kontron-kbox-a-=
230-ls

Caution: EXT Email

Hi Sahil,

Please see the bisection report below about a boot failure on kontron-kbox-=
a-230-ls on linux-next.

Reports aren't automatically sent to the public while we're trialing new bi=
section features on kernelci.org but this one looks valid.

The kernel is hitting this issue:

[    5.326403] kernel BUG at arch/arm64/kernel/traps.c:406!

Full log:
https://storage.kernelci.org/next/master/next-20210316/arm64/defconfig/gcc-=
8/lab-kontron/baseline-kontron-kbox-a-230-ls.html

The issue can be reproduced with a plain arm64 defconfig, and doesn't seem =
to be impacting other platforms on kernelci.org.
More details can be found here:
https://kernelci.org/test/case/id/605057a041fc669ff0addccc/

Please let us know if you need any help debugging the issue on this platfor=
m or to try a fix.

Best wishes,
Guillaume


