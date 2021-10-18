Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A056430EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJREaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:30:10 -0400
Received: from mail-co1nam11on2131.outbound.protection.outlook.com ([40.107.220.131]:1569
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229456AbhJREaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:30:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMgF/pS3YRXDI9pYVWaqqPsrHzJ7DfYLw3qejYWjCGayi97IKaDxMV/CpW5Qpv3Xe6a5E0shyKdA4GKgD7HGqfTckeOobDKjJi9+oGiKFiTRVjl34ZPxtg/0PEvdMrmJyOfhmiwEfw5PRN7XQCr26I+nrsK9Sa+6zjA4ZdnxKJscP8TGOTbWEDCbQUeK2HXrZmMADQKmgT0VWgiryojkpGRtsJCBRZxsrwoaBZ3+0yuqr8wC2o7AFifij8428SWqGWUgCAA0nCWFsm9N0ZK/6z1ePo3ftcpe5v8Bs7w23zhNdRdWY7nCqebbrVopmJhBqvc2XfiSNLAOjlWkoFCHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VqebglkE+SW4rS+zGzFm6bpTGCa953iOHHGMfcSVMI=;
 b=lP7XTeOd11bHH5v8w6Iy4/C88j9ueiq5XS13melZ5HyV2BzsUxaO2lEq7yI8WQWroBoCTzglBiMQrX0zHQ8Z5TC2L9C9nBQVny0dewJCGBfizlcib4aF04KFh1KMfhG2rYcIbIn7LmpxnRN0rkObyRFDZWheZl5xqTqLfP2e9chMnnctUjyQyisx0vs3Jr6CwPEhSqI2Y6G5KTwAN/U3NWJCfccsbs2R/Z3XXBHexp4y8Cz03RP8i9L/QMkYKwfK5e4/0foIkU50fiXkbeN8J2FpkQDq02u7y1EsTu9JOHlwBgYI11Sz3UUDOcDXc1X5QjnB0M7KdN56rTn1DEAGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VqebglkE+SW4rS+zGzFm6bpTGCa953iOHHGMfcSVMI=;
 b=Kt23ASlYUarR0Uu4OLzgkqzqbw3z7mY6zLJlTl2qQde00J7PUNAejLwvhA/e4mtMmbPAnwZoN8IyKPj2Ex5f//YKBkw9QRpwu2a2Ra6iierQsEM0C8HqV5/1uHQD49B58oMogBtrB/4tbEi8g+PFYUAWdwfcAXNEqYq0k7c39qQ=
Received: from BYAPR11MB3671.namprd11.prod.outlook.com (2603:10b6:a03:b3::15)
 by BYAPR11MB3479.namprd11.prod.outlook.com (2603:10b6:a03:1e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Mon, 18 Oct
 2021 04:27:56 +0000
Received: from BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94]) by BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 04:27:56 +0000
From:   George Song <George.Song@maximintegrated.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "george.song@analog.com" <george.song@analog.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        Steve Lee <SteveS.Lee@maximintegrated.com>
Subject: RE: [EXTERNAL] Re: [v2 1/2] ASoC: dt-bindings: max98520: changed
 signed-off-by email address
Thread-Topic: [EXTERNAL] Re: [v2 1/2] ASoC: dt-bindings: max98520: changed
 signed-off-by email address
Thread-Index: AQHXwZYcEWw/JKy2t06rh06QWZ6yEKvURoGAgAPnXVA=
Date:   Mon, 18 Oct 2021 04:27:56 +0000
Message-ID: <BYAPR11MB36713FD5504CA0200F00250DF4BC9@BYAPR11MB3671.namprd11.prod.outlook.com>
References: <20211015072709.3167-1-george.song@maximintegrated.com>
 <YWmxd/tnHRXUEAxy@sirena.org.uk>
In-Reply-To: <YWmxd/tnHRXUEAxy@sirena.org.uk>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=maximintegrated.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c3e2761-cf2c-4380-5419-08d991efa8dd
x-ms-traffictypediagnostic: BYAPR11MB3479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3479F1E7D77AE5D5EE2DC746F4BC9@BYAPR11MB3479.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tUNYXxj0ngPZZMRv/iQy041qOYSFYFPwuqemPYLQERTib+SWzr/c+Qkm4CnLbTkprVBrxc9hjPGk8FC9h0MRYT1bbiFCNOclZ29YdMWXiBWNwwMkd0K7bRL7WRWhg2SCsuqmpeDmYElq0Ggd1iITKlqENXz9hPn6bm504FhQaTr0k0RSV2zC9GCnszj/Zpo9UJ8J8YQQUVnVUlF2iunjlrK4RSBB8BG+bk94yo6/6PUb8wh3pu9umY38xY+bygAeKrGQ/e4XeALzhOB6QqP1NRQmH1J6Iedj/+GmLc28/RF7H7QHhiCUYbHilegJy3zfrJo0xzFWVk1GSPASfJNdOX3FajZU0sDZdBpyhc7rYu2rXMQHxj7y1Be+bMu8PS+BJ4wqIeXrnhI5iZvMuWZudMIgVkE0/kO00Ahg1Km+R0IlKV/A8joToRdB5iaHhcP6tNBMkfX6+zcWGC/yA9lB3jnWLefMGaOtX1IUNI3HwPJBvBZdgBdGgSm4+vC7w1eMUXptvEydEg9+IDCwSVd/uzAWE9FLCrziYoU19f7MSwrx8d1vKGMBW0pWvjteNBQ8YONa+Qsu/zyvDdn4krxar0EqyKUpuWXFIijrOGihrxkMnR/AxPXQxTWWBxwU7Xj5iKF+LMsa9s/NN+9Mm44rdF5q0sjHiY2QxWhfSYNQS4pNWBpC0+OONGr4QRb2yawGKYFBNCOf4UOSzVmXi7mReA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(508600001)(7696005)(86362001)(54906003)(66446008)(38070700005)(83380400001)(316002)(5660300002)(9686003)(186003)(66556008)(38100700002)(64756008)(66946007)(6506007)(71200400001)(33656002)(52536014)(4326008)(55016002)(76116006)(26005)(8676002)(8936002)(107886003)(2906002)(66476007)(4744005)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jGf8zOF49XGhvVp7z3/8M67d36WEOxW6WAbrFiuErtlov94dwZtamIQMoRPq?=
 =?us-ascii?Q?68BJz4yizH0jzhbuRoMLz8itzqLMIylKpOsLkLhl/z1ksIzijfOa1C/WZyK3?=
 =?us-ascii?Q?OakwwxXSx8hKV7NPl+gN1VfGvRmG8qMj5oPs78pxJSgjPwBEK1VknaMKdFon?=
 =?us-ascii?Q?ovMJVJezP8B+dadL9n96OWz5wa3cifXNDovecSs7mawjKl7TI748BGogF1pP?=
 =?us-ascii?Q?viGGfev394b20ajjBpuOJEV2hjj8kyf6eKb5xqqHlddA1w2Gp3AgYfrVd+Fr?=
 =?us-ascii?Q?o0Puutp9N07d08Ccurz3SIZb1NPQig84bzC5oc1vYnB0OJgZZJ1HYbB7M/M2?=
 =?us-ascii?Q?GKr8/2H2WYAVfNxV6c5YJjGrp5kF5YKEyOJpArr8/WsF9w6TeIqERsJPHUfb?=
 =?us-ascii?Q?S3UWC1Az1TZecObBgh021D5ErKDzb7zkNIn4vlZacD6vVGBdd8rMMgeJZZBw?=
 =?us-ascii?Q?34m8kJSglMXHvYdgrHdiWuadScjUEa42V+0A0zynfHT4nHXeZL5+Z9XxJ2pA?=
 =?us-ascii?Q?r5MUF6SnAjrCPT0XlEClQmY/caJVfT1ikE/OQU/xmoe071jNVQCdKEyvrkkD?=
 =?us-ascii?Q?WY9VQ+bUYTQuKSwy5xdWKKYp2iPD56sYM8wHt9KgtnG19bVozGLHXgQTwqJi?=
 =?us-ascii?Q?1nzJ4hnFCq54QZkE+7Mb402NRRSk38R5HMveECjGYPK4nfkLxjvz+YMW9mSz?=
 =?us-ascii?Q?/AKO4JnMUEsUbDmH6rG2zQD0ypFFad8a4Lnu6BUcfisOGymobcjXmu42ssOF?=
 =?us-ascii?Q?CV2Rou8X6oH1h+0kIMz+Uu3XFGKk8av5ORqn1/bmTz477nvuqNzTXaweSPuN?=
 =?us-ascii?Q?LuQu5bFtuZNHy7yo1Eb/KPJT+hOQB8xUpOntbIUSrYzxUeRh6zVv/mRjuKTf?=
 =?us-ascii?Q?V5X+7DIH27An8Ot9LAKxqrCXcZnc4IkCXKgTVW0L1PGvb0vgmQvDKhX+Lq8Z?=
 =?us-ascii?Q?z91UHby0SJcSj8v961Q6R19ucgNtxRZjgPallMRD9DqeKlgUtAI+6zc/OJol?=
 =?us-ascii?Q?Tp3h1ebJLXi0vmLzn1jWdZl9Hi3qVc4VOUW4jfmRwzdORvoxOHA6idzNm/eX?=
 =?us-ascii?Q?B0c1hI6eouhTUUEJNik6KmqEctyfFkpi94/T4oNvBAy8W9Q9fj0AucH8F0da?=
 =?us-ascii?Q?a4Y22lLqYMtSw26340GnR6weDQZ1AqIuW9rPDsh2DJUjhxMmztEYuuD7FeA4?=
 =?us-ascii?Q?reqX+LL6EKljGTcpAqfnAIkeJZjQ0Nj8TmzpO4s6H17ONQQNFc2LCvZmJt3I?=
 =?us-ascii?Q?gP0DVWsY1PrqKiZzjBByNeD+aKFCjyzOP0zsTQ3djfy7hf4wj7IapFhwTPNW?=
 =?us-ascii?Q?LiYbCfOK9Yi5GYiOLT7u8k/y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3e2761-cf2c-4380-5419-08d991efa8dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 04:27:56.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QCrw7mn9VElPEJC7YtgOYUiANwkosiWMBzt1YVU8pEc1Vzo8BUf+4RiBjPxp3sgEH8Fzo3Zs0tj3og9YqYxCaS0L2n1wkUkzcP7W1GMnjUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3479
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Oct 15, 2021 at 04:27:08PM +0900, George Song wrote:
> > changed signed-off-by email address to maximintegrated group.
> >
> > Signed-off-by: George Song <george.song@maximintegrated.com>
> > ---
> >  Documentation/devicetree/bindings/sound/maxim,max98520.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> This file isn't upstream - it looks like you've sent an incremental patch
> against a previous posting instead of revising your patch?  Once a patch
> is accepted upstream you should send incremental changes but until then
> you should repost the whole thing.
OK I see. I`ll re send patch including whole things.
