Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C563339E6A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 15:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhCMOFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 09:05:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:7328 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhCMOEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 09:04:49 -0500
IronPort-SDR: QiFb+eZkPVLp9HiQcLE6q+fliP8EzFv5SBIngMjFj/dp91EvRLWIjr8dOUjC3vv9ko9mpqsRnU
 NLLmrNgds5fg==
X-IronPort-AV: E=McAfee;i="6000,8403,9922"; a="168209732"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="168209732"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2021 06:04:49 -0800
IronPort-SDR: 5kR2W/8iyecIGx+nsighlVWgusEMwe8oD7+pZioyEnUHLdb8YgWP7nFwqMGPQag0jgj9Y7Z6hp
 cbAiW2EeOrMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="372958419"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2021 06:04:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 13 Mar 2021 06:04:48 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 13 Mar 2021 06:04:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sat, 13 Mar 2021 06:04:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sat, 13 Mar 2021 06:04:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af1Hzl7kgodfLijG7IojfHtGvnMQPeYL7KerjtJm9ICB26z5aJ3Juhorh6MP0Y2f15jM41FzUPNtkMLF62WmuQZ8AYUcBPxXTY6xpwR9tzus1eiHwx0Pe2+nnv5D1JuvpIH8DzPb4xWntXM4Jw/lfzbzjq5Hk79AyhBycaaQCbYYuQXSYcF5m5sog+bTqBZq5LtjrzQcKsliKvXra12YXsc5g8kqo4/dreX7kizeSdFNALqJ+bR1HnlFscTjXxqIUeDQ6Y/2oKExKDV9G5Dng/htUKMeXf71tvvZzSA8EqYIWQ4rq23LjWrZEVj5ki+jJM11euVRD9c7QlUHA+4sBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eM7XrIhk5Pp3/vKUDxLu63JVq9gm97Zp4OSoD1LulQ=;
 b=K4vzqg7CYWxZFN3w5dnsCSDjUAc+28sByfSv9YVuLS2c/NwwTTI1/4qCUqOIUlzEkJbWi7n5AVxS2vTe+xIdu/jV0aFzPLz6Ilj0W5IGeDO4ry/5ABIdviOh3O0NxTIgu/jgQjTjf39v0MovcIy9berqBYWQUxgPxaUXZJ2XyAg/H04XUq/tlz7vuytUCkG0iK3P2B7KU3EtSFGxurj+lmX5zisLRG7AaKabaEQYu6ZvXY+JKacOMNvJYzeHVY9Gco1d4lErGbY629GFgKV6PcbJ7gxBj6I0uueBpc0CSrhPHuGFr0ibWKlZGjkEenNW0M6awqQ3ZoJtsazD3B375A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eM7XrIhk5Pp3/vKUDxLu63JVq9gm97Zp4OSoD1LulQ=;
 b=ZC4NwAAxucqxP8V8i9z+08haomgh62LtYniEJ26ozrJQxEZJXbJK925/azoGJpOjF10BVqiCJ5+REmBGvfNnVG7oHfBpo6oo84k5KkjjSBXdBc4+NmN02q+x2GX69gQFw0jUfqBB9nqnz5gQdpWSqn3OGw/3XLtQisgdohabZS0=
Received: from DM6PR11MB3642.namprd11.prod.outlook.com (2603:10b6:5:138::26)
 by DM4PR11MB5342.namprd11.prod.outlook.com (2603:10b6:5:391::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 14:04:45 +0000
Received: from DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f135:7a69:c586:6a22]) by DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f135:7a69:c586:6a22%2]) with mapi id 15.20.3933.032; Sat, 13 Mar 2021
 14:04:45 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: Intel: sof_rt5682: Add rt1015p speaker amp support
Thread-Topic: [PATCH] ASoC: Intel: sof_rt5682: Add rt1015p speaker amp support
Thread-Index: AQHXGBDpE9LBiGnjT0W/ItSyKgNeQ6qB8f0g
Date:   Sat, 13 Mar 2021 14:04:44 +0000
Message-ID: <DM6PR11MB3642882772D17011B821F99F976E9@DM6PR11MB3642.namprd11.prod.outlook.com>
References: <20210313134038.5577-1-brent.lu@intel.com>
In-Reply-To: <20210313134038.5577-1-brent.lu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: alsa-project.org; dkim=none (message not signed)
 header.d=none;alsa-project.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [36.230.3.243]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78057cdb-6206-4923-d3c1-08d8e628f4c9
x-ms-traffictypediagnostic: DM4PR11MB5342:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR11MB5342126693ADFCDAABD7E088976E9@DM4PR11MB5342.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pt/bc3Mj17aB+w2WfjFqhz3sanAFAoOIkPJ5UtFCRAyL47/no8hrTPklEGUx7qaAznH3tlSF7R2gtfsh6RAI/AB1WFMchyFb4ttTZr1OnapEezZrdqu26pELzVv8Isii0azlWu1olB78pbRQj66saOQslbIiNpb83X7c10MdJNc4zdPPWyzZiJPFUYq9030rN76Mup5FthyouZ/y6eaxRrYX0lqsluFfsvD8S2OiAS0Mbpz0l0zqLC9ePc/U8rnpsvXCIp9opHcbnAb8MdZyXYf19Be9bTvefY5F2LNzMaosh267Q3XHLNsS8QK3DTsWGcKoFiIHn4361E925tJfgq2mL+/ms0AlhfqTv2xSAsXzo8ngD8VC4MmvKV00H7AInXJaKyLBjL0sQFMbHig7xt2EgMpRSU9o6sBQM37iizodKFvzMDys54rKLlY7BN2C0wPZNuYS/TC5D2NbJftMW/3CDqCWQ+Yd8OtJjayIYTwNJoAbG8ayvEPb9VKzcG2VED/y/ZD8or3CFW9iNRmIJ9BlAcH3nPb58rOZHG8bEcLxhHf+A9ekBmgiNmjFpo5P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3642.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(376002)(136003)(39860400002)(26005)(4326008)(186003)(7416002)(54906003)(6916009)(33656002)(8676002)(316002)(8936002)(2906002)(76116006)(83380400001)(66476007)(4744005)(9686003)(66946007)(52536014)(66556008)(66446008)(71200400001)(5660300002)(7696005)(478600001)(55016002)(64756008)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Pb4cgswAAKakszO4i1uEU1ZdorTGywD1DlnhWRn0tK5rXoffMIHYzL/+MSPi?=
 =?us-ascii?Q?n9VDMhk9lvobvV7lX9liYXLJxYcLnNQSAyxCj4A3LEW9shpizAI8O6U0PPzZ?=
 =?us-ascii?Q?BcFwY0//Qlb21OopqwrpEHWVtn+QlRHnzT6wRz0+oVQqMXo+kO0cV5GoLK4n?=
 =?us-ascii?Q?Y+Ny209v3vUp3Dmql4sZZ/3gsIL4TitbVYbY4gRdC2e33Oz7d5Eq8k0BIeUq?=
 =?us-ascii?Q?PRLzDnwXaxFMIl9iUt3jprcCPsz6/9ZXbpxmsTPqykk3f/0bV8Tit1ThmO3M?=
 =?us-ascii?Q?gK2qaSy/qbpkU2EeK2gXBt1fzrdSCAXiOWNhdM7BOm/mTJXk0wZDFVonodta?=
 =?us-ascii?Q?pA5l8beOVNslz3pwCHQRhMLsq2m39BK8xAoeaKjyKIsFZrq+UEsQ6fuqxQVd?=
 =?us-ascii?Q?W8he/x4yizibYf1P0JGknsMr84LQ00W7E38FiSUWiL9h/VLtb5LnFe/3I9Ao?=
 =?us-ascii?Q?+Gm3rKyqwWWy6GC/NNloaJzarbECAGMt380V1xFntQwwJgsH7FJkIS9Nq1Of?=
 =?us-ascii?Q?7+sf6xbzZMNTytdgztNlW4RbuuApqgdzfptBaJbeTzNEtQRRuvVeZCOtKjnv?=
 =?us-ascii?Q?SrNquQMxeYF1d1YOflguW6ZgQAuBqKSp6+YE8AvtjLeaLCxdA6F5qxNL80AX?=
 =?us-ascii?Q?Dzy+IeqDXQ91jnYImYBre4f1ivkGESFfhUVlFGX2cTu8JeWuWQo7t7C/qbnQ?=
 =?us-ascii?Q?Y5zPJwgb4Tmvos3aqvssGrux6MOTNL7TazqJ6ec/xON9JaKOVbXG8TbbQjX/?=
 =?us-ascii?Q?LbO63TGPQDod53OIFcnWGq1/17nvYpWUnX3LDR+BeQWdnImyW1N5jtYj3mWm?=
 =?us-ascii?Q?KkNkXFmWdWoXIOjo0AKjP1iRsMbw4LO5VDwh1B7Rp/+3cSvkYmh1qlz2cYg5?=
 =?us-ascii?Q?w/vbkPAbfQqJcMbDfqNam0+4ydXI15tCZEniFzk7mNsjOwvxHxkEP4KTOJFB?=
 =?us-ascii?Q?7k29uXPruVR1nMlQo9CVz/QmCgTcA1UTvUZTK2usTMbOfbvUYIWb1N8QlReS?=
 =?us-ascii?Q?+BkkIzm5s4f7RsQmuo/vNCyLrhUd+kKKJ5fKxC13hNjlnroJ7FJtL344l4Pj?=
 =?us-ascii?Q?KS/l/7nE1nA9BNKGPzMLb9v95SCi+tYE6lLsNYMqOBsEkOlj2aztdOJTZjP6?=
 =?us-ascii?Q?N5bnInstmV/cDLobY2RACYL6dSOBcpGCK1oPALsJb0EqpNieUp60JzXT83pR?=
 =?us-ascii?Q?3xOFNCCbWWeAB+Ar4TwM8I7ECZH4tTL+51zVj1Uwgj3fGNy5e2Kc7NVlhHLc?=
 =?us-ascii?Q?ORR7+VRbzzJZkf96iHjimGGdRL/nyv9t/kwLsR9j34s0TdV/oG0Ft/4mwRQf?=
 =?us-ascii?Q?bL8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3642.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78057cdb-6206-4923-d3c1-08d8e628f4c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2021 14:04:45.0164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akDfPtwW8XJFc1+l+7u4poUPqqDCbRWdnPj4y5/dk1ShnoGTkvQfv18VzWjeQFmOPrMJzgI9bs+2LyB/C9124A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5342
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> This patch adds jsl_rt5682_rt1015p which supports the
> RT5682 headset codec and RT1015P speaker amplifier combination on
> JasperLake platform.
>=20
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>  sound/soc/codecs/rt1015p.c                    | 10 ++
>  sound/soc/intel/boards/Kconfig                |  1 +
>  sound/soc/intel/boards/sof_realtek_common.c   | 94
> +++++++++++++++++++
>  sound/soc/intel/boards/sof_realtek_common.h   |  8 ++
>  sound/soc/intel/boards/sof_rt5682.c           | 31 +++++-
>  .../intel/common/soc-acpi-intel-jsl-match.c   | 13 +++
>  6 files changed, 155 insertions(+), 2 deletions(-)
>=20

Sorry it contains unnecessary patch for codec driver. I'll remove it and
upload a version 2.

I'm also wondering if it's a good idea to use acpi_dev_present() function
in driver probe to determine the number of amp device instance. Without
using it, we will need to use quirk for those devices using one EN pin for
two amps.


Regards,
Brent
