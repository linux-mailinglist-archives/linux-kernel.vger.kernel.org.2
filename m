Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B2537B41A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 04:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhELCO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 22:14:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:15071 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhELCO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 22:14:56 -0400
IronPort-SDR: qiNsI/iw1vcDlxWsftb3xg6XdxYsTVjRx7qeTrLiqZ6ZG24iCy93Lrbv8EgxhKshWEQ/qlN0If
 gesVef54yhLQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="285097285"
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="285097285"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 19:13:48 -0700
IronPort-SDR: M2CHU/kJz1e+rcDGJQedHdv4eIhBcBowaTsp5Z/u8pQQOtGBk7SVC9zJWWgtKbjv1t3A2/z9vV
 gT73SB0iD52A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="434876136"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 11 May 2021 19:13:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 19:13:46 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 19:13:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 11 May 2021 19:13:46 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 11 May 2021 19:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs6tRLIp4hoLwUeFWebGKCf9v/5H1MQU5mb1Rp4wHkRGKoec5BN5Jcl2Gis6ojjhWTNDGVlGGE0Olj5WPOnIB2ojPcXMrUoj3AfDfI8ajjBWgli1w9iZIQ0IBe6Sl6f/FJOcBAebWc/9sL5yRJ2TrByPavyzPcPphvZeXKHp+vvukEkS3+ovv4CzUhaplJ0FvzJr56hbQmWQKnlviEU4Tkdq7dypQCCrrF0lcRQPJMK8w2Dv2d/EvSlzOeIgHlOW/tvtFWcpSUVujB6aykpA8rjgNKe1UGn03wwjImJjKYtQogB1V7yKYJp00OxL3kQJAm/bpAR22D7oGz9PEjq6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJoNNbxEjWU9XIceoXWykmwxTgiPJX1fxJbZfftUTWg=;
 b=V573i7k6vHKUzwFJZB73FIgekWqI0O8QHMCjD0b1L/5aj5oyxYgTOtBwzsTfiottoO6fMgEhf7xKyrs610Yg8wO/qVxSUwZbumkfo2CtcQlzApMZQXbUKbgem7YGpavbLVGbRHDY2bzMXQL21KO2IoEejpZx/Uu1YOrrw5rHIxHoEW8Wy3hgJmckVzqN/guRa0rKuqeGNhwV28ZCrQkh+fcWD6kSfSRh6rS81wQhTS5hNIsxgMB2aCbLsvzRHTmYnbHqtwZ5oj9DM48IyBRoILbzVg9XNM+1xdvs3lWf3lKxVXS7fI/nMxoQtlI6WeaH5xOabPnWOzbDGlXuDHdLnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJoNNbxEjWU9XIceoXWykmwxTgiPJX1fxJbZfftUTWg=;
 b=mDg3ZEvjy+KQN2H0cVPyxgjvxdwqT4z/7LqWMDYEU72YExgAFigqjChoC0OibdBmoYs7ScvydXIXGaBtL5E2g4FnnWUcAbXg2C8d2RlepeCpSmGeGoKe2d1tOvcpjJqzC8k9SulzA1GBAibE29OBFhU4bdvliBCy/EfsReR8Ti0=
Received: from BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26)
 by SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 02:13:39 +0000
Received: from BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::e878:3625:5685:c19d]) by BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::e878:3625:5685:c19d%7]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 02:13:39 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: remove Ley Foon for NIOS2
Thread-Topic: [PATCH] MAINTAINERS: remove Ley Foon for NIOS2
Thread-Index: AQHXRtQa/w/iimglH0KaOS0TZjGL6arfGwvw
Date:   Wed, 12 May 2021 02:13:38 +0000
Message-ID: <BY5PR11MB3893D130095C99659852E8CBCC529@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <20210512021055.2195467-1-dinguyen@kernel.org>
In-Reply-To: <20210512021055.2195467-1-dinguyen@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.132.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c84128a2-00cf-4665-8bb6-08d914eb8e7d
x-ms-traffictypediagnostic: SJ0PR11MB4830:
x-microsoft-antispam-prvs: <SJ0PR11MB48303469F509B3A425E880EFCC529@SJ0PR11MB4830.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:529;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wk6TdZcuRJQK/KwRpAn0O8qrcEweZJMcJz8t4AaOfeYXxMPtnUJTLZWUFEG9HSohFdMcnRHgmFESwbM1gbSBKWlS3vyyD5q9DuHmqIPsFtWFlxcMTNXUqbc9Y2WPqjCSc2dciCxaNqaYuTap58pRjtJmtYpsNjS+Pm6rDNc8YOYwDhcqFJBfkT7U4U3LjTBaiGyfFr9R5aqwJmINCfmARGOX9JDN+wXwSXI9UnHViT/uEtXGr3tzPf/6yWVmQ/YXabiWPw5PJ341G4d/BV7jXOvamq6mid/fDMiEhdwn0mDIrONGNrGfg9erFscApOPlzvxWhE7n2hFrciDkt8QeWLRXGdDWTczblfFe7aAP92FlZGq4oqvK7FI9vBcOFWqQwfynjiEnWY8+1nqPOo8KURTSEZUMMuuIKM0S4hiNK4tAc7A4C76+B2b04n3g/aghACIROOBC2zbgFifNnf0SNUG9ARxY3RZg0LaOXG/q4+AprZ9NVxP+vuu2RjfBayeSeNQGkzEqdLJLwqiK1lf2fc65Xr6Z5X5It68JrdGx3fIcfQwpVKPnEL+E1BgjS9t0mM89NBG0zK0/sRl90DBQlBnqshIo1hLiwh4bwjlaS0U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(366004)(396003)(346002)(5660300002)(478600001)(8676002)(83380400001)(122000001)(66446008)(38100700002)(66556008)(64756008)(186003)(66946007)(4744005)(86362001)(53546011)(76116006)(66476007)(8936002)(7696005)(26005)(6506007)(71200400001)(33656002)(55016002)(52536014)(2906002)(110136005)(9686003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LiMH/VluQRlOD054oSB/L8LUO1D1xhwNNXXDprMPYrq72/0MaRxbHSjmoUPs?=
 =?us-ascii?Q?aB9wAIe8EQ29/N58Gcb1/fPjKAehweUTBY87vJav2+yddkfB+xjTwKz6K9Qd?=
 =?us-ascii?Q?ON9Yt/P+iFaLqGTEA9CpXOA+yl543M8ANAldYzQ6ySL2gz1w4BZANGs/ZMyx?=
 =?us-ascii?Q?r8Yqtq98mibwF/LtUy9/97WvAGCpXzMCeLj96mdV0CCIcloopfaBOxLFzHcB?=
 =?us-ascii?Q?JOVL2uZeChFQ9F4NB4DbKMLh9GR7m4a50EptQqAKFtuDQalY0v0l/HrExQKL?=
 =?us-ascii?Q?P91ypfvvJqgvvtHpMt8KsTR9C2hoOpvI94L8CzUQng7F/kdkgkbAvI5lmxmn?=
 =?us-ascii?Q?/poYDVT3SUyxxP/k3RGQQTTUJ4Jx/RYk4B6svxGLof6bL8XWdJOS6HUprE3R?=
 =?us-ascii?Q?qTM6zpVjoVqcUBTAYrCG7Mu29Zbu3b0nGOp3tmZHYsth2ZNndGGd4OUwNTWP?=
 =?us-ascii?Q?0AJsBskMG9cv1u1VJRGj7R8uzdkqKrp/+mhw9Po3gyFbC4YqR44luZho5Eoa?=
 =?us-ascii?Q?3uKFcTuyAI6LHho8dzqNgJp5+H56sM03Jo/wa5kXEqugiCR0kmfVaaI0pGsi?=
 =?us-ascii?Q?PImd8hEP4yYbLgCZZeOolPpbLk4EjElg8DmZGHPSrORx/Lb6sN2bVsw9jr7E?=
 =?us-ascii?Q?rBltb0W73I2agJGD3c0pbaepzoBVsfcgOWr18uSS8IrVlhPG6N0QH6zaO/4t?=
 =?us-ascii?Q?cppC+wR8a4PWnrMVp7cYNAtUzv8c9YpO6eDRnrQGAz3Wcjlcfb5vhItVsUMj?=
 =?us-ascii?Q?S0qwIZkbG8OlA6d6DxyGKLmZUxGeuVLXu2u90cIjavbuKZqUgP595FHuDHK3?=
 =?us-ascii?Q?tTpo84k016jWgvwjf/CWmxnoDyBJqd7tpV5p1ll4mcnpJXlA5mr3NYh85Cb8?=
 =?us-ascii?Q?3m47HTlQPfC1KFLVFAVOY3EteXvrqxJKYavL6cm/vTWdHfNNpkIwUQK29bmS?=
 =?us-ascii?Q?Nuwzco/ZIaLiJ80g8Tk86snYzfpOze/tyn8wCT27/lp67IYArZhUfFq0Fd5z?=
 =?us-ascii?Q?5/v7WNZmd3/1v0FO2C3f+uzlAJLz9L2X5x76MoJp9VO+rA5IwPKuTErknBCv?=
 =?us-ascii?Q?UAKw9C2qX/WjLfYb2DgmSWxDrIdv8rgnygL5azOb3FH9TWy2yJFy3j+AtX9Y?=
 =?us-ascii?Q?CkD6twtyd/AkEhM/Pm9Vn8StylklOI+C9wvqlPmirt7itKHRSTyDr+dwOxf+?=
 =?us-ascii?Q?8PYh2vKq/sfPUEE/OguNBTKqpc1ZuB+OC/xAVLTMpeALnPELUSZr83d5WvYz?=
 =?us-ascii?Q?Y8eIYXwpRYgQtf07HpjGbaKOd0iJP0UW/7jMNYswWMNSM3xIIzpVeS/SRK6p?=
 =?us-ascii?Q?JmAQW1Bgd/7Os9Kmp/JipX1M?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84128a2-00cf-4665-8bb6-08d914eb8e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 02:13:38.8899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNe1LA6nn/uxpGJX6eSqCsh0n1R4Nn17InA5WM+wTiKydD7zS8BVTEvptvJMHbFCPCE9XXKnloZ2J6pIExp7Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4830
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dinh Nguyen <dinguyen@kernel.org>
> Sent: Wednesday, May 12, 2021 10:11 AM
> To: linux-kernel@vger.kernel.org
> Cc: dinguyen@kernel.org; Tan, Ley Foon <ley.foon.tan@intel.com>
> Subject: [PATCH] MAINTAINERS: remove Ley Foon for NIOS2
>=20
> Ley Foon is transferring her NIOS2 maintainership to me because she is
> moving on to do different work.
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd7aff0c120f..83aef3e767c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12960,9 +12960,9 @@ F:	Documentation/scsi/NinjaSCSI.rst
>  F:	drivers/scsi/nsp32*
>=20
>  NIOS2 ARCHITECTURE
> -M:	Ley Foon Tan <ley.foon.tan@intel.com>
> +M:	Dinh Nguyen <dinguyen@kernel.org>
>  S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
>  F:	arch/nios2/
>=20
>  NITRO ENCLAVES (NE)
> --
> 2.25.1

ACKed-by: Ley Foon Tan <ley.foon.tan@intel.com>
