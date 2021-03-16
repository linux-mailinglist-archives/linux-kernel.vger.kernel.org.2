Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D533D01A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhCPItv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:49:51 -0400
Received: from us-smtp-delivery-115.mimecast.com ([170.10.133.115]:38003 "EHLO
        us-smtp-delivery-115.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231538AbhCPItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1615884562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FP+VKprYVhPXuymFr4GMjIfgx8E2VmDeAhk3b1yTB6Y=;
        b=Z0TGM7u5H57J2doTLKJLnU6/78k26v92hfeAXxNgM+Mho2+horqE858ilzsJj4vjeQBlO/
        SPpxZj3Lh1/RtDJuwJhrvaH6+D2ZyIDE03BpNFyFIOTEaPBbQg8XjbNrPjQTiAol+mcrLH
        qke5OibbF8d4+F7M/eZP16KX7VpnuVc=
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-xZLl3O3rMhiDG2dE7R3VQA-1; Tue, 16 Mar 2021 04:49:20 -0400
X-MC-Unique: xZLl3O3rMhiDG2dE7R3VQA-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by MN2PR19MB3440.namprd19.prod.outlook.com (2603:10b6:208:18c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 08:49:18 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::1cd9:22:e5ef:6d10]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::1cd9:22:e5ef:6d10%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 08:49:18 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: TEST EMAIL - PLEASE IGNORE
Thread-Topic: TEST EMAIL - PLEASE IGNORE
Thread-Index: AQHXGkFALsdsNvyN3UCmcXvg+vU9TA==
Date:   Tue, 16 Mar 2021 08:49:18 +0000
Message-ID: <MN2PR19MB3693A6A082D781FD35CA68A3B16B9@MN2PR19MB3693.namprd19.prod.outlook.com>
References: <MN2PR19MB36933AFDC4531D0F7A984608B16C9@MN2PR19MB3693.namprd19.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [222.164.90.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb9e0642-d0de-4ee3-e782-08d8e85862cf
x-ms-traffictypediagnostic: MN2PR19MB3440:
x-microsoft-antispam-prvs: <MN2PR19MB3440AE602E337AEA25D93212B16B9@MN2PR19MB3440.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 3NCAjSwQzeMwZw57ORNGZWtVlZBI4DIAVkPsy1lEczlXniz1aubdPeosP2S93CaCIYg2rTP0uI3+0iYbdoUkL8jPxLAzI7+7iJeEjVWxDPXjW0pAa1AixoJ/tlCslpHmJT9to0WGx50wE1GuozzAIQI3X4rJQ0arUvBXg63jQ8U/7TMjbYi/uG23++dFDD9UOOTlkxzVWPVHDUQH3OCscWxVBA7ITCnkUYi4NoDg2YSieemlxhKayapW3VENllZHtMzRc6oQcIhEu/s3Z2Xm4Olxw8k2Pv51o+q4ME7DenDmfh7YwMrRUQOnC7t0HbVmEGX5O2jBxX/kN8CK7H3oQHIk03O72cnIdEoyExvDCdgDrOQpMuRPtoadSA4fP6jLpf90txlhUL9glWtSUGaMbb++y6IdpihgLILk+mWLwgC8c2IIN+4FY8ZTldUuI90WgwwVD6qo6w5JH/GLrWiarZ/KPoDhhAoPmVPWPLG/6F++TxI9NaX9hRS5MRSONXHiLZgTs3OFhAfOlpXlgnZv5gy5oRtzxUoSmvIAPz4WVgKR7RAVZNPpkxGbzlNw+m33VWxkXNdjjA6ucpHgoWkDdmaudSppvDu/ZXcrC+Q2UU/8UgI9Ae/K/JWUgdRQew/+POBbiG/dihbEdLVwNZMZuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39850400004)(136003)(366004)(346002)(6506007)(91956017)(52536014)(33656002)(5660300002)(478600001)(6916009)(64756008)(8676002)(7696005)(186003)(2906002)(316002)(66946007)(53546011)(55016002)(66446008)(66476007)(9686003)(71200400001)(26005)(83380400001)(66556008)(8936002)(76116006)(86362001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mLjwCOeUvw5MkPyfzXclIsQ1nH5H0FebzZMqdgEs/ANrm9tFfF59FtiG66xo?=
 =?us-ascii?Q?9UeB4LYISxw+ilRRIk0aAV7ZGBq+kHcj2GBVv66/YQvHZtxb9VBC+gzb61nW?=
 =?us-ascii?Q?AqNzR1Jxuq/F2J5I21KNjBcoy9xevr2C6p8Jqwkz6a01k/bE3V4vP0cJM1Y2?=
 =?us-ascii?Q?+lbT6iEsXXjmfQE3DlovCWhRTus4XLNfsYvX9OOeJU6O/fKWgnIsDTNXgdvF?=
 =?us-ascii?Q?9kDgZSNd/5k/g3JGFrkUura0ivSQpESFbz7wVaxoT5tfZOTJxdbhM1A7/+hs?=
 =?us-ascii?Q?AVIPSCTz6CkA5ZXPnFksrf7VzVMmzsKHUT5bzzZjVnUjQg8Eij5Dpw4A1klt?=
 =?us-ascii?Q?jQXmokPZDBZL0dapAowwSapFWOBsOGc7hbbOR3vvKfwP4ju6wO75EYwdFRZD?=
 =?us-ascii?Q?c3UltO5WBWtUCCoHVMK8ZplGD6ph1EUKB+T+CTKdE8T847OoAFcCULDgIe/l?=
 =?us-ascii?Q?MsLeq7gaAnI7saunAv82mTr2kBD+zIiKKyAny1LyF4Q8v/r06LDF7f06mkd+?=
 =?us-ascii?Q?+h4Hlr0vhOL4n1Y++n6OX+Y39LnVtQIb42iGuLBO4RuwAJAQbbG7JfaHscWe?=
 =?us-ascii?Q?ZsWlKC8uysxILOcj3Vov9o6a36X9jQurduRWWp+Gza5YWvOSaCaWH0E4AxKo?=
 =?us-ascii?Q?rZu7UVISk1DOnfVK4MsrNsWZOZxtfHTBv5/Wf9B1WOjHC1tVoPuNw40bIS7y?=
 =?us-ascii?Q?DnDDfB5lejaB/Sc75Vv+3A9ceXDyHhMY4nDArDpmvBoN5CLMMHREVlIqYTNw?=
 =?us-ascii?Q?0kiaYqEW0mJZ4NoaAaH/up6xqU/ciLLB2HWH96X0KBeKi6OVyDYUbA3Tg6sx?=
 =?us-ascii?Q?5DIMrIqWx5Q9ngP/hsQtOx0ln8t2L+zH+bdWWAU75iFNtCAcHo2aOVQblNkB?=
 =?us-ascii?Q?uEZDRq9IAak3ZqRvZPq9NksKrrxp61woaDTNuKUtdDnthB/mezbibJ3B8wZw?=
 =?us-ascii?Q?MhvlSwT/3HgUrFASI6qjjKINvcy37vDFnI3zkusARtoVJBCReqA95YSIcIIZ?=
 =?us-ascii?Q?EpLm+vtxieeZC+7CmtiZ0ZNZF0e4VwPSc+HyHToLTeaeZo8XWKsSa8nVej42?=
 =?us-ascii?Q?WbInGDNlrQLcoe/tUrZCGE44OdKyswjhmMO5vSRF4Ii/zF44onKyBFkfSlbr?=
 =?us-ascii?Q?BpFdOL+hTDcTM7PO6vdB0tOsEqr7PtUemrgpjSirhrv8os5WO68GDYOhoyDm?=
 =?us-ascii?Q?9Rr11OrpjCB7AktTjjcxiKr4q4fugHLFVqqFZpv1iu3dTDPBZGeAxHUtsBWt?=
 =?us-ascii?Q?88WSafiqW2/trbI9vP5J+iqi5WrNH8pCKLcW1XU5PmqlmSSaBXjtiE3zGSwC?=
 =?us-ascii?Q?i++o1dm+PteAgjL4Glp93ipnIOEkUzjgUB4crL9wEBkhbA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9e0642-d0de-4ee3-e782-08d8e85862cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 08:49:18.4284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXVaACTzNV3s8vBTXVmvcR4uDZqZqxp2X5H0t23AuX4XNpBxrs+c+9mgfBA55A190Opmwp/82MNXPqzRqSvJjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3440
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA115A51 smtp.mailfrom=rtanwar@maxlinear.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/3/2021 5:44 pm, Rahul Tanwar wrote:=0A> From: Arnd Bergmann<arnd@kern=
el.org>=0A> To: Pavel Machek<pavel@ucw.cz>,=0A> =09Amireddy Mallikarjuna re=
ddy=0A> =09<mallikarjunax.reddy@linux.intel.com>=0A> Cc: Arnd Bergmann<arnd=
@arndb.de>, Dan Murphy<dmurphy@ti.com>,=0A> =09linux-leds@vger.kernel.org,l=
inux-kernel@vger.kernel.org=0A> Subject:[PATCH] leds: lgm: fix gpiolib depe=
ndency  <https://lore.kernel.org/lkml/20210308153052.2353885-1-arnd@kernel.=
org/#r>=0A> Date: Mon,  8 Mar 2021 16:30:46 +0100=0A> Message-ID:<202103081=
53052.2353885-1-arnd@kernel.org>  (raw  <https://lore.kernel.org/lkml/20210=
308153052.2353885-1-arnd@kernel.org/raw>)=0A>=20=0A> From: Arnd Bergmann<ar=
nd@arndb.de>=0A>=20=0A> Without gpiolib, the driver fails to build:=0A>=20=
=0A>      drivers/leds/blink/leds-lgm-sso.c:123:19: error: field has incomp=
lete type 'struct gpio_chip'=0A>              struct gpio_chip chip;=0A>   =
                            ^=0A>      include/linux/gpio.h:107:8: note: fo=
rward declaration of 'struct gpio_chip'=0A>      struct gpio_chip;=0A>     =
        ^=0A>      drivers/leds/blink/leds-lgm-sso.c:263:3: error: implicit=
 declaration of function 'gpiod_set_value' [-Werror,-Wimplicit-function-dec=
laration]=0A>                      gpiod_set_value(led->gpiod, val);=0A>   =
                   ^=0A>      drivers/leds/blink/leds-lgm-sso.c:263:3: note=
: did you mean 'gpio_set_value'?=0A>      include/linux/gpio.h:168:20: note=
: 'gpio_set_value' declared here=0A>      static inline void gpio_set_value=
(unsigned gpio, int value)=0A>                         ^=0A>      drivers/l=
eds/blink/leds-lgm-sso.c:345:3: error: implicit declaration of function 'gp=
iod_set_value' [-Werror,-Wimplicit-function-declaration]=0A>               =
       gpiod_set_value(led->gpiod, 1);=0A>                      ^=0A>=20=0A=
> Add the dependency in Kconfig.=0A>=20=0A> Fixes: c3987cd2bca3 ("leds: lgm=
: Add LED controller driver for LGM SoC")=0A> Signed-off-by: Arnd Bergmann<=
arnd@arndb.de>=0A> ---=0A>   drivers/leds/blink/Kconfig  <https://lore.kern=
el.org/lkml/20210308153052.2353885-1-arnd@kernel.org/#Z30drivers:leds:blink=
:Kconfig>  | 1 +=0A>   1 file changed, 1 insertion(+)=0A>=20=0A> diff=20=0A=
> <https://lore.kernel.org/lkml/20210308153052.2353885-1-arnd@kernel.org/#i=
Z30drivers:leds:blink:Kconfig>=20=0A> --git a/drivers/leds/blink/Kconfig b/=
drivers/leds/blink/Kconfig index=20=0A> 265b53476a80..6dedc58c47b3 100644 -=
-- a/drivers/leds/blink/Kconfig +++=20=0A> b/drivers/leds/blink/Kconfig @@ =
-9,6 +9,7 @@ if LEDS_BLINK  =20=0A>   config LEDS_BLINK_LGM=0A>   =09trista=
te "LED support for Intel LGM SoC series"=0A> + depends on GPIOLIB   =09dep=
ends on LEDS_CLASS=0A>   =09depends on MFD_SYSCON=0A>   =09depends on OF=0A=
> --=20=0A> 2.29.2=0A>=20=0A=0A=0AAcked-by: Rahul Tanwar <rtanwar@maxlinear=
.com>=0A

