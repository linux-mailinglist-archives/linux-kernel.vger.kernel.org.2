Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875FD41BCE9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbhI2Coz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:44:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:50638 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242877AbhI2Cox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:44:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="285862650"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="285862650"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 19:43:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="562877848"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 28 Sep 2021 19:43:13 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 19:43:12 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 19:43:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 19:43:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 19:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dn4HddkGjWR/P1X1YTB5jhrCCsFDJ4NUlPtnTe90mjz+wMekTQZIp+j3dAtceQmkKNkTpDpH2xYFHnJOnuujN2rvW+aqOtfKXtAdArkM4DFIpHfWSj3ORRpEb+mSKG0FhkQKIYb99StgEaZj8fMaed3X4s1lRKprCO8hJDHpWEaTBkDGwp43qVY+Xuk3dcCpdJeQlhrQfBfnyAkAI5X6ktrQaZ8cJqdvmVcIdu4ffcXwd77Pq2ypBCVbGkQy6SRpo4S2YplugO+mRcKu/SZ3ouJtuAR+B/itxEFSOLtHX7stMVGSiUIbSUGcJZMstdfxk6R+oaET4g5pEnXCPRD07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VGHMCnfRrqORdnVwpWjEyjAqOBu7+gT9ttf6UDXqLHI=;
 b=oBA0e1OTy69+yUHr/Lkxh0COI17puQA2HfySKvumJkvljfwJjvY5sgy8sDEpZKgiJPXUxGzSGnjxTF45J76SYQMHajHHf4zHxg2HO2t6hHQ/FewG8P9e36aZBV9H/sSNjSw53M5KOiMmhV5/VGhMVGWS3t7uYreI3EQwvtvpRNiPasg0jzvESGQGkpo2Gn7v6ucLMNw8RvJiagYoN0kAhB5BiHuyQOHOuChq5Y4KC9Fel0bEgZSUSUhpO0XkE91WegEP/u7CQMmNZzqp9CLuBjKUSH0C8M/6MeXptWk7gg5+cIc6v8clty1lu7yLXFfLl5UCLfcks+aruaTEhMyJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGHMCnfRrqORdnVwpWjEyjAqOBu7+gT9ttf6UDXqLHI=;
 b=B81eBdZLvK1BN2fmgQM5vD3loLQtK1WfyhbMu0p2j/4Giev2nLaeJrNv4qjWu4b5Ficvs4DnK1i/k3QN0oU6nnK4cBVlOI8KsOa95lmPGBWOH5Cmdni3DF8XlcQ3J6MrhBP8uxWttTpFVJoYaE8GiYyykVLZE+fG6BXXl5bc4kw=
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CO1PR11MB4900.namprd11.prod.outlook.com (2603:10b6:303:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 02:43:11 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::44d8:67f3:8883:dec7]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::44d8:67f3:8883:dec7%3]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 02:43:11 +0000
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH]MAINTAINERS: Update Mun Yew Tham as Altera Mailbox Driver
 maintainer
Thread-Topic: [PATCH]MAINTAINERS: Update Mun Yew Tham as Altera Mailbox Driver
 maintainer
Thread-Index: AQHXtMcg8KpKQ1c1SE+LlnXgukwOy6u6TYYg
Date:   Wed, 29 Sep 2021 02:43:11 +0000
Message-ID: <CO1PR11MB48205E5FF4398BB53741487BF2A99@CO1PR11MB4820.namprd11.prod.outlook.com>
References: <20210929001406.23345-1-mun.yew.tham@intel.com>
In-Reply-To: <20210929001406.23345-1-mun.yew.tham@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae65b542-877a-457e-07ae-08d982f2e0dc
x-ms-traffictypediagnostic: CO1PR11MB4900:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4900F0755228D276B07A30DDF2A99@CO1PR11MB4900.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:221;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5L21Hbp2pb5gbY3Taz0htsnxYFU3kwMwZw+oFg5XLAVP/O5EMVTQ4kYGuWpi2Qh+0XvlCM5Yo5Gf4o7z/Xcgvlzu3s7rmaF9ddK1Ko9TGs/zygPm2XABj2jCGDPM29mCwqwTKQxpZGDBQH0TeHPZCLdHGRweV3tw3AiZkzrrX63Izfu8xanLl6he0Ypooejck7jc4t8xEnFQi+ujDFvSmxj82WeVqXzofQaPMEYy+B/H8VQgLGui0hiAQ0XpsNOnV2W2FWuVKFSZaZUVlM9d3mKg/SNx/wQGetcz4PdslWaZY82m7JU7cRYoTr0J4C7Nd9n1ofsvate5Iujvv7Ybm+8qEFYJj+BEUBk9JFYonk7Yl+iOUb3TGaJ3eFzZdt5wcIqEjlYcFxLfbsVdZJZTG5RZ7j8UW1bHrbklDczn+bYQEqZOZuL4GulSHVVLJcX2s/k25Mzi6GFYAoJP0f2h9H4nRtkpvmXg0xydocRVd/vohfps5ua50z+qfsaDHrtwhtVfZrWLms+kIlKYPrtRWpFIuw0lGlFUi3bfswFlZLpPDgf285VyNz8RCiTIIpK2lHsN/YrLCOW16RL74sBlXNqTeHQ1Vso1rn7ktBnJssHo/0r6FVj8dv4p+ep3s98wt8CmCDdVjA/toxFFz1YhjdGRX0tQYqwt/5Sf5drzJLKkrjE6R7d3Nw95qHTBTP+VurhKJHEgv5pJGcIDX+veJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(15650500001)(508600001)(52536014)(86362001)(4326008)(316002)(110136005)(5660300002)(4744005)(122000001)(38070700005)(38100700002)(2906002)(186003)(9686003)(55016002)(8936002)(76116006)(53546011)(66476007)(66446008)(83380400001)(66946007)(66556008)(6506007)(64756008)(8676002)(33656002)(71200400001)(7696005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0jElpBZyNg9JLa4VHD9txjNbWHaNQpz7IFTEb1Efii4VXqKNY7dtOPQNaAwY?=
 =?us-ascii?Q?JZl8CPfToLV3sLYWSRHV9e+vNGvK6tZj1sPaMSFmn9UtP7hJbD4jRM+mqyDY?=
 =?us-ascii?Q?4ex0fhh6EWHJ6GHlb9MU9OJJhaz1mHadifR1VVMYFuORafOLTm6lXb9LyM1V?=
 =?us-ascii?Q?WZZhb7qW2s12MgV5u8k0Rk8hISocx0yAnyCYVSctfSs51t7j5t07o/0dP8aq?=
 =?us-ascii?Q?7FzOcGd+TcQPYt6HESAi6aC7MwcEAF0sCjabhrUyyuXvhHjc7CuyMb2c+zKt?=
 =?us-ascii?Q?0su7LyxaUdsVDwyGl0TIxX/GXT3FqHHzJWHnnvIeWcKayX/Z8Q/xXRYaecLP?=
 =?us-ascii?Q?yhZHpEahwl+5jRsreFwzVIDlvjxX/dJ8N0tvkrBLC21U4m/fv9FVzYCOXoV5?=
 =?us-ascii?Q?IA1MQjI3dAG6CXQlOw6Phs0QqKJlBduYE+Z+rojAPryYjfA1OdSHSjXAZAlW?=
 =?us-ascii?Q?KnimFUQinxyJXFIC2WfaUit57iPU7933CvtaMykp0ARXIlNCcqmf+pQf6rk9?=
 =?us-ascii?Q?ZzcnOuhkur5NlqAjJJzdeOdmF8py/hzb7LBnvVSnwFx5eIARIaXbsmRkNdlA?=
 =?us-ascii?Q?DXyJSVwU9IL0ecFcDw+SlP2I5AvEacnHNFQRaqLvLzL79DAOy9V+TjkiYnQQ?=
 =?us-ascii?Q?HqeCg9i2UDksf21zoko3y/KIoFSpiVLrs2In4IZLTiHDCqEYnEOcBmeVeogu?=
 =?us-ascii?Q?4FA+SXwM9gwHHjJL3GRoYuGoN0UxA1k+NoDP6G/5mxsc8CCzo+IMIKuPoYMG?=
 =?us-ascii?Q?Xq9Ul7z2VLh4NFAzIsk3lpl2CtR/EhB6XHNbz17pOkpUMFwLkTfMDv6fkd9D?=
 =?us-ascii?Q?nwAM64GxvAyhefLniua40PeXPwokmoIWBjHCU9ggKZCbwFeaS8RZQ7agU9cP?=
 =?us-ascii?Q?2Y3+nQt6PjIKTJ1PKXvqWZnbGeY1qWXJ+uEZ9sxT16Gfc1F88YdTfIwXGe2A?=
 =?us-ascii?Q?odqeUwBhhDIEGa2jxNSPeZe4zwhPdNiy/NxA3giTVBNnX83cvOBeo5U2k0qY?=
 =?us-ascii?Q?ME/zZ2ei/XMigTqmx/ThZktJkWcpj6XxXpFn22gQRSZ5Gmd2alLr07PSOk+Y?=
 =?us-ascii?Q?YV3o6T/ujeQ8dtNIXUbSmvXZEWPXc/b+wAS1xLQBCwrQxG7kOxXqm0WHUzlN?=
 =?us-ascii?Q?K7vX27KRoOSXlVOP1J/fpyY52DQ/KNkX9ur6ov+2asoC1y+tLVaUVS1Boo2j?=
 =?us-ascii?Q?t1ecmnqpl9e74lGuAqGSwIRdvRZmjzaSfLfqd4w8Ubp55soqT+1P8jDf7/Cw?=
 =?us-ascii?Q?ZrIYF5jWkuQqrAAxu5QkS3UevXeyj+Bfz3kkoMOfWxHJwo20GlLuINjxf8uQ?=
 =?us-ascii?Q?EDwYy8bX/p4csen7mMvuQGwg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae65b542-877a-457e-07ae-08d982f2e0dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 02:43:11.4902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeIfTa3nlS5q3IRZ36xH3NvFSuS+nGe+nC+H/bX4YSg12QZtklAxQt1spfN2XjauZhgHsRJHbdi6jX1Pfky0rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4900
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tham, Mun Yew <mun.yew.tham@intel.com>
> Sent: Wednesday, September 29, 2021 8:14 AM
> To: Ooi, Joyce <joyce.ooi@intel.com>; Jassi Brar <jassisinghbrar@gmail.co=
m>
> Cc: linux-kernel@vger.kernel.org; Tham, Mun Yew
> <mun.yew.tham@intel.com>
> Subject: [PATCH]MAINTAINERS: Update Mun Yew Tham as Altera Mailbox
> Driver maintainer
>=20
> Update Altera Mailbox Driver maintainer's email from <joyce.ooi@intel.com=
>
> to <mun.yew.tham@intel.com>
>=20
> Signed-off-by: Mun Yew Tham <mun.yew.tham@intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f4615336fa5..71d27c38212b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -797,7 +797,7 @@ F:	Documentation/devicetree/bindings/i2c/i2c-
> altera.txt
>  F:	drivers/i2c/busses/i2c-altera.c
>=20
>  ALTERA MAILBOX DRIVER
> -M:	Joyce Ooi <joyce.ooi@intel.com>
> +M:	Mun Yew Tham <mun.yew.tham@intel.com>
>  S:	Maintained
>  F:	drivers/mailbox/mailbox-altera.c

Acked-by: Joyce Ooi <joyce.ooi@intel.com>

>=20
> --
> 2.26.2

