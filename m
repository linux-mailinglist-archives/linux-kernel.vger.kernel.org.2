Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD1D446006
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhKEHKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:10:50 -0400
Received: from mail-eopbgr1400111.outbound.protection.outlook.com ([40.107.140.111]:43584
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232490AbhKEHKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:10:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/XZQ4anszKh26HiOxKLfl67+QJmTkV+lenCGA3HOboNNSG20ZNcxbXGK0FaR++46w3fqGCtgFZdIMx6wzr09bT7kRyi/Vy7soTPpn5tAma/fjLXVZ9pZFtQjWdffN/BDMDAv2xtqjc/luNRQHJeYSVs8kwT8VZrG8jh8/iIvTavUOV/V6zVJX4fdJJTfL3RaC4ZPuZoL2TnBaqPpHGYBCiJjtPOWia2rBO9XDsbNh12YMR1pyjogWuKj4j6c9EShxEDxctqBMJAMx8t0E0c9HvvQbD1s6U5Mh7HXjK5vMdDXDFZwuid7RJ8/M64Vt9d62SU9zm2r7QPr19SMW6Hew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds3Xe4xE/9muukLrWL3cm7Ypxz6nMaeZ1wdgdUk9INA=;
 b=Gze+2lOcijRlIfqv71iKxRsH3pnhRHht4LGikV6V01GVlyXxv6lTzFvTI5zV+ACsWQw67My+igOAAb/oAawRHG+EHzvp3zjflck3bKXIAL2iMvqh9BxhXu6OP87Fj6JStxVvs0qdF6gmVv7UWIkhpyYifnh0Amny8HXS8cBOlFaA3mB/+NQcXJZ7PbiX0Qk6o7VdS+g/MyxY2HTVJFRH88/NSq5knaLYP8qeua2tdno01J8It78uKkxg5PIRoSXXXR4a7TlGdEJeOwPMX0PHtdGZmFELfILzEcj6UgNobnyh6ZzDWhRMFTZQaNsJoXvuMqEWWB9nD+t6Salb0mi5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds3Xe4xE/9muukLrWL3cm7Ypxz6nMaeZ1wdgdUk9INA=;
 b=L3U47eBhWrC4mhxVkmJAG2y9DsOv3sMWZRrJd0B6sPN7HTclCx00+7hGQKsztNlgJoTq6zwF7MVkNV+jcqTOsODohWx2Nla1/3hPxg/PoBFCCciYYeN9lJXs60avsNwdFpbQKI4PNWNCdtsZjSiP4UfjwyyR1yqkuWInlY42mUI=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYAP286MB0442.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8037::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Fri, 5 Nov 2021 07:07:43 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%6]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 07:07:42 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "stefanr@s5r6.in-berlin.de" <stefanr@s5r6.in-berlin.de>,
        "linux1394-devel@lists.sourceforge.net" 
        <linux1394-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: firewire: suspected uaf issue
Thread-Topic: firewire: suspected uaf issue
Thread-Index: AdfSE2Y8PWxJkaikSrSvFCtkAX2o8w==
Date:   Fri, 5 Nov 2021 07:07:42 +0000
Message-ID: <TYCP286MB1188FABA20A0F8F3C6498E538A8E9@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: s5r6.in-berlin.de; dkim=none (message not signed)
 header.d=none;s5r6.in-berlin.de; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6a438bb-6918-4ca4-e99f-08d9a02af624
x-ms-traffictypediagnostic: TYAP286MB0442:
x-microsoft-antispam-prvs: <TYAP286MB0442559DFCD0728F22659C218A8E9@TYAP286MB0442.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gYvZt/lKcJbYQUhFxhONir4zLIQMIg6lkDSPmcibnDmfRY6pVrVDs7Rn0LgsalTOfcw2cR2OlCMzECc9PHXw89wr5yROJe3kGOFO55RGf2FK32otfHHN0+DwiLLhbaaQShpmnFcSibLTiJWNPy+ptEXVO/F6wwQCYP3uXlaQbvXK6s5gDy4tGNwGvPRHglX7sRTlNopP9XlNaC8M5iUnFLueHPfi5sdSABzK6Btqx2TtQ8/eXnvvaZMK+SFFpNYKdvlSzl5lRojKP2zEU4XLEJ7W3+U458924FVY/IZBWikaStOU8JXxC/vhjsfPvL8wua7TX4paGHq9EjyFTRywHrmnqiy+o1oV0Aibl9NCuSTIRGCoaVuyoNcvHD7eFqh/mNC0kT3MDDl0Zm4vnIwgfEpjOzPX9d+/DZZoTL9dTVazJWC+1y56TFKLqAtmAWrkC3s2tjOfdBsyT6ZXWGiitjLZn7IW5lwve/G5sDYKWPWY50fMKyqRLx/H1cNvACifQ0qDmf5XrufEzw3Kfq7rq7JV8/YpedtEYdibDvdtHZQycxAXruYX0UCYG9uRB21Fk9nG2naHExk2e5ClQephuDsdrqXxIE9cszABmvfvnQofs8wxkbg4brcfTDrAypVJr4QgHYTMYfIrqQzUcIJKqG5mVnE4SohUR/lluYmrcg9k7q3N8Qh0Hxl+5hetCJC5JHPXD1Aq0oDrywI0+g0duENUssGDwme2qWzehVF7xezwBCS452tYwZ5hbcMgmYZVJuNuzBNzjpUgztYq0mabrIjKcy+MahP46Xj1OW/xeuY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(5660300002)(66946007)(76116006)(66446008)(64756008)(38100700002)(52536014)(86362001)(55016002)(9686003)(122000001)(38070700005)(83380400001)(110136005)(71200400001)(33656002)(7696005)(316002)(8936002)(966005)(2906002)(786003)(8676002)(4744005)(26005)(508600001)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lJmvY8iest0+jViEmSh8/jAKsTyM9Bwd4m98e4bo3A3yDVJrGztt7cdizyuo?=
 =?us-ascii?Q?4s8sfsHGw/dj49XVZV3L1NDhdW4DtSWQDVQjl7LbD3YzXc3e8hbx5mK2+ASt?=
 =?us-ascii?Q?fE5cDjJh64wffkGDg4bkgGiRaZ8t5dm9nUGxRHenROzEMvFrkevTAh7lNurb?=
 =?us-ascii?Q?WTKdZHKOaloEmNe6Zo0TA18knaPPipME47ZllQSxwsncsJcHp2J2uPyBmcPP?=
 =?us-ascii?Q?WaCSTFF3NHPkc42p6T3eeoufPfHuqoXcTltWsVhtOWqBS5v0UrgwuEcdwcLT?=
 =?us-ascii?Q?J7RNhJwuz/NNpQfzXmdfbtpt+NdepIwn532EVwgy+W/z+LTZA7DBpu/YgWlE?=
 =?us-ascii?Q?9JnZAndkgfjH3EefhQCXdVA0CfPBaLk/ahJFxsW1cIItyQeNipcMB/X1BGRu?=
 =?us-ascii?Q?gpi/7r/0pSVy4cipv1sPpPTIVgJUHYQHuECYjFDx9Q40d3/8ljr+S1E5SkKm?=
 =?us-ascii?Q?k30mnBU8gzCt9IMcprFxP2EWx9DZwayRNq397vKNoGO1mE3EYcYobUVxtlCt?=
 =?us-ascii?Q?Sw6DDPfvLseUFS46Rs/RTF9zzErx+FlyuiVefMbaFA6Cz//dTbj5Ql3/3qVH?=
 =?us-ascii?Q?TBnZKy0g2VBNPE/BaxNkw1sZrJBU5uneI2rMiFB8pgazQkduzJGmeWwmriM9?=
 =?us-ascii?Q?5LElcJrFdWwbYamE33VNP9KYqmGvTuj7MyB4NPgaG9qb9gmJYQ4MI+81Q5xB?=
 =?us-ascii?Q?hStL7HkJ4Y1QIkif4Amb9wVXp+N7ZJUDoeuTDKuhHz9LDZabvlyZh90UXA28?=
 =?us-ascii?Q?Yf0gsEFB7eGCp5BN04ZgTrG0Jbx9Llhc2z9hLsHpHKK6j8Pe5Z2su4UqwiZZ?=
 =?us-ascii?Q?EfI+otwSaLUGGngxgao0CYHPA/YXR9+FIYtO2Xciw30y74R7MeGupYtuVn0a?=
 =?us-ascii?Q?PkKHcseqZ5CZ00lzfmJD8MJJXcWD5ohMnHzAgE64FPRVq49P/FAWUWiG9GGR?=
 =?us-ascii?Q?I2pndy1gq+3mCzH8hzNZCwgExDn8MeU4JWXdYFNiZZRt7hTurBGZ3sBQcP1+?=
 =?us-ascii?Q?S2eMi8Dh8PStqOI3wUMH09/emm8y3Ip9+/pwcB1LPgqHmhZLLPM7LnTJf5/p?=
 =?us-ascii?Q?mjX+ZFzwjYM1j29zwe+QNUayY5P6dTqNwkmlfY79ZCLY0Ug0HSF0TaKi1WiZ?=
 =?us-ascii?Q?YeEWy9vruRQqV4s1OFwzyQXPNbT8z35MQYoNCrKoDSTnHrV4eEjJJFm7pf+O?=
 =?us-ascii?Q?N8XCTf8l3iqBmAsdJMaGwDm2vFJZfChVpzej+ptX6CII47p/7nDnL4SU2gu3?=
 =?us-ascii?Q?s3d6a0Exm77nTHPqfJSbSEBdQSZ+yJJb+A6y/gEiVAqSeITK8tCG8+2GH4DV?=
 =?us-ascii?Q?7Vklbhb6Sc6p4RCV9Sm4WHuEaiqLnZNKC0jG7zrAClRwPDPcCoPCbGhWxamR?=
 =?us-ascii?Q?mIgd1KmMaaWr5e59LkJHP5B5mE3dgnCBGM5dgM6FM+fV8y8FFCB7jOA9HSjd?=
 =?us-ascii?Q?e63avG175H2YbuewT0jgWXoY4gZaOggranv9di8BdSUeA+Jgy6PaYQ4jAtfM?=
 =?us-ascii?Q?smOjHSZnbxOvaRGhcfjziQcy5+YcmcqScuXln/VEH1PHiCxB/jNyyupmu9sB?=
 =?us-ascii?Q?IEqMkNPRQEiR9yU5FVjKAmbdm/+HbmcQ91JvnNn0wDcSGk4ejlIkLb/HO/p4?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a438bb-6918-4ca4-e99f-08d9a02af624
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 07:07:42.6269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: berQf5fi0ceZ0A2IInALf7X7jmIG2Kxp623Ratz/2rIpIi4B07e0E0XZ4LTLHsOdGjiYe7zHTAiELzroo6JgtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAP286MB0442
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We notice that after client_put(client); at #line 1316, client is dereferen=
ced l(e.g., #line 1318), and we don't see any client_get(client) like state=
ment before clientt_put(client). Could it be a uaf issue?

https://github.com/torvalds/linux/blob/master/drivers/firewire/core-cdev.c#=
L1316

Best regards.
Chengfeng
