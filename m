Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C380F3A0A74
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbhFIDIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:08:13 -0400
Received: from mail-mw2nam08on2048.outbound.protection.outlook.com ([40.107.101.48]:9056
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231438AbhFIDIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:08:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM/6qNLEOzcw85l45RtegVDPQMXKquWFTiLwg+diDWDiTAG5GjmAopc6Uq6rAwdCEwJyflYV3UnI32j210lVEQ/IyfTaD9DLYfZa3uxOrMNZDwcF4r3HZ3AW/3szauVFW8CFeGEnUfT9UcKKYuUnzW1rDGdXiSqHy1AUo8Hk7xcnlkupHNtPAL/pMPQ+NPpMFqHuz4Px7m+cYs6tAs1iswTh4/kK0rrRXG7QQPIDb2mVQKunppzdUgMD2VuYU4VFpKDJFwC9OpeeW02+FoGrcFVBGk5RThqls+yDy6F0ijXK8EhkIvXtsCgnTurCIE4CVfbh1/MMRrQhzyxQpoyuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdR/GV9bndguiiMTQ1cXPjC5IcNtUbkEt4IAk9Uu8I4=;
 b=CZD08l3/hNDw8T06di1E4QfM8Nr+Av4gTo9lBwtEk9dqcmt1wYdB+EQ1wfaxUa18Se57Zc1sA815sfzecdICdgDoF7vAPRPuLU2p/vWaJI1m6o0PD9rttOXecbuO3r9n4t1YVV1DL+D+T1BP50VBP1WQSnh6iVHxw0o4mJdwxNx8dJ6+7bjJ5u2L71taC2iABgFg0voVX07qZD3PuK5W8SSZBm6DdaJiu6NvedYtSPLRHU73heWRgA+Fr3TqA0QZ2uplUlA/jOTBIhqKHXHHMiEmfK0MA6/bD3nbGvCuzzrd+RJ1A+O7qftH825F0I9Lzcx04OwffFI/4qHHgR/b+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdR/GV9bndguiiMTQ1cXPjC5IcNtUbkEt4IAk9Uu8I4=;
 b=cn3HLI9qf/BKh/3a5B/NcTd/f6TMUAPGnBgx4s99bAE2B3l1oa8W9tIUH/2oKCxTYetrpebdYzXZPc3JHH2HrQ2nB3eOA/tf+ryk8Aph21rpBlX9joimPKYie6B6eOdOqG3hxrT8VB/uuXdHWJNPzR5Q0wqPZw5GleBJTokuBJI=
Received: from CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8)
 by MWHPR1101MB2175.namprd11.prod.outlook.com (2603:10b6:301:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Wed, 9 Jun
 2021 03:06:16 +0000
Received: from CO1PR11MB4882.namprd11.prod.outlook.com
 ([fe80::e1b5:13ed:1899:7ee6]) by CO1PR11MB4882.namprd11.prod.outlook.com
 ([fe80::e1b5:13ed:1899:7ee6%6]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 03:06:16 +0000
From:   Tung Pham <Tung.Pham@silabs.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Pho Tran <photranvan0712@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Pho Tran <Pho.Tran@silabs.com>
Subject: RE: [PATCH v12] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Topic: [PATCH v12] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Index: AddLlBYVYOD0xuQ3QaOKYNc+ovdaUAAH/oyAAHVlZWAAI6jDAAOw8IsQ
Date:   Wed, 9 Jun 2021 03:06:16 +0000
Message-ID: <CO1PR11MB488295663735895484C264CF81369@CO1PR11MB4882.namprd11.prod.outlook.com>
References: <CO1PR11MB488255D1B04D3B90886A59BE812C9@CO1PR11MB4882.namprd11.prod.outlook.com>
 <YKNnBckiw4fLIuQL@hovoldconsulting.com>
 <CO1PR11MB4882BE3951A2CDFC8F060B58812A9@CO1PR11MB4882.namprd11.prod.outlook.com>
 <YKdqKDj/Qbw4k5IA@hovoldconsulting.com>
In-Reply-To: <YKdqKDj/Qbw4k5IA@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [118.70.81.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 231f1fa2-3f01-4fb4-0514-08d92af38c1c
x-ms-traffictypediagnostic: MWHPR1101MB2175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB21757716C253AD31E7690A8981369@MWHPR1101MB2175.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QDtEqun2goKgou6z2nyeeqsjLmt+Mfd8wxENuf6j+3idlh0L3v+kI/jYAjhh/DkoywP7rTQWKB9ofi4YH84wn0UFEw2OTneutLYniX4iwns9ybDYs1/8NH8h63/r40YRJP5VguaDdny1FuqEhtXapp2BzednK6F6Q/PeQ9dLmONJ0dwTHg95ZyIMYtVvHZVRaO2SaKbFJFtEsumWde+07l1QopJx3fj18jZVMoGVEKFaPas//C8kE80SZg+L38QAIsoEfrcnej86s5jR4SKfO4YoqXjb6Ap6L37X1ZTchYsDRpvv5cpkAf7qOonM0Xz9ijvlOR0jdwMhElawtAhB6ukh/JqfCH2tLemRrw1x5+DjvizHHuZ9KE0GviR7MCjFsVoXVTXvrNb0eFdlsYhZi9tLh5H/fFRk/Dlmow9CMtFjJbrr2sKvoADg1Z2ycdtq8Xup3t78651F44D8RDLnrFMDlz1vBb5u1iybdjroG2/rFxHVVs1sEhgaAWvRSKz8jFT6agANldVHU9QdfmaHGZyd85Ya1r82BoeXSr9yQiPFa2/zil52jo4iIJZXB1ahxhqecrSWWcGJXXzpn/q4rXSwo55p2JchV7jxtE0UCshgqkg+yc0K8AiYDXwRwWTubvSexMsLU9wnJIHq73kDqgzIHyvlv4wNs2DOleGtzbE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4882.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(366004)(376002)(136003)(396003)(346002)(5660300002)(66946007)(52536014)(54906003)(7696005)(186003)(122000001)(26005)(71200400001)(4326008)(64756008)(6916009)(66446008)(478600001)(76116006)(66476007)(66556008)(38100700002)(8676002)(33656002)(107886003)(4744005)(2906002)(316002)(6506007)(8936002)(55016002)(86362001)(9686003)(83380400001)(71600200004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nolCRxNRuRsCgN/MMsyUP7/nwv93FheHDJGjWtbnWNUhI0slb5cv1eWveW3O?=
 =?us-ascii?Q?ogLFD2mkHnp0SJf/RaFuiG6r1LT2ujA8XKygRGyr14y+2eeCMS8Hj1ZlhHAJ?=
 =?us-ascii?Q?P/yUUbF3H+Me5YgTJexdeZvIyzl7811xi2MZ7wfQ0HjNkMVxiKDNa9Cms51M?=
 =?us-ascii?Q?imqWWxEpHxKlcpH1MzSord2xoBbu+lj9CdRM3yHzquD8dn8PO6FXrme941ql?=
 =?us-ascii?Q?YeOq3iKOwCHGmkkS6Pvr0EhOb6Yy4xjcuI0xt9lytsKmvnqxqGKohXqkgDYe?=
 =?us-ascii?Q?vAaE7mJgZ7qSmlhRFVHwWk7aprBCQnyx5k1o6frOcyL9Gs3G8RGGOwuLlHSZ?=
 =?us-ascii?Q?ObK7geCIQGuYttoCJV7fQz8KARTwZHu+cSq1+2zHEHUjaFy8TP52mcMhkLld?=
 =?us-ascii?Q?dyA4tkn/NE3+rVGH4UzJbqmhPKX2KHN46UY+cWKc1plXKTR3azXea8rREwbI?=
 =?us-ascii?Q?KN7wIGW9ixOn+31pHAvdD8ua/W08GGt/CuNEI8iq4FqzIH8afyn1ybeRXA9S?=
 =?us-ascii?Q?EkuoELLqDU4cDjOhkodW24AkEUwgD3xbsprkl+KE2VdkL8iqMirk+YbYwWO+?=
 =?us-ascii?Q?1O7Wdoaai4PpFVUr+GXCJpKvZYhx6kFbTWAVL4HlI1EjUWAPQulwGHrsWb4W?=
 =?us-ascii?Q?jtUuS2Mg5Mi8uYmg1/zlYDt4YVsU72woicSW4meEioubTjm8K0z/fCU7hJbZ?=
 =?us-ascii?Q?eW6IowMXJKPbW14dVFne9Y+iqtjj6ojzTYjKUx69IH1Lmc4eZBBicM+K2TZm?=
 =?us-ascii?Q?JaMHmTBe3Q7ijqotFnMRWenDah3uU7a/u8o1XJpQNNClFacF6h6wuLG2rUif?=
 =?us-ascii?Q?eFktZVooPnsZsp3MJvpx4ZuRvfAoJnUha3eanDrNc5aJDiIDqDjH23xM/c2e?=
 =?us-ascii?Q?6rg1+T2Xm8e+XAbLHCzF2d1YvwvTAq1mafb/K1u2MOaGTIx5OIMXTR1FWNYh?=
 =?us-ascii?Q?UDfoheYIxaWh6CoSMnNdC+3LXAOt33xd4J0biBGp/KVWueoIfK70IVpTpTFp?=
 =?us-ascii?Q?9zJ3U/wKzI0FDMTBTSc9881oh9MVcUYgiP6a5LugSYuesOc/EDI+Xpg1y0OZ?=
 =?us-ascii?Q?aRLatOtvrJ/WBsh2DIfABdTSv0SUgZnzbijxwr1djIJ5haeP9R1HlPM1zJu/?=
 =?us-ascii?Q?e2konQIPW1afQTRTJOcaFZeii+5c9HEZleIbfmB0zKGk0UVGMxMuzJ8cYgCB?=
 =?us-ascii?Q?gKB0Cue2Sggo22HPIkrlTsB4AvFBdYyWGsWY7BrCHz3Al1e9KyZmGEi7iyjo?=
 =?us-ascii?Q?k5ED6R0BCrefyEd9CkTc2DQSWQzkYyJIco8GUDyFF09e74LRlaWi9e0l92On?=
 =?us-ascii?Q?hnk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4882.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231f1fa2-3f01-4fb4-0514-08d92af38c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 03:06:16.2715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9YSNT2qTdQJxPVxmfCW8yNNCvEEYz4M5qXBLfwbNTv4QmQc20KlOl5SGd8t/evzEZ4VV8bzElUP6d+BRIDGYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2175
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, May 18, 2021 at 03:18:06AM +0000, Tung Pham wrote:

> > Do you agree and approve with this path?.
>
> > I'm still waiting for you to confirm that you have tested the patch=20
> > with different pin configurations in eeprom.

> -> we have tested pass the GPIO of cp2108:
> Case1: all 16 GPIO are configured as GPIO function.
> Case2: all 16 GPIO are configured as alternative functions (not GPIO).
> Please see attached file for more detail.

> Excellent, thanks for confirming. I'll try to review the latest revision =
shortly.

> Johan
Thanks for your effort to reviewing our code.
What about status of this patch?.
Thanks.
