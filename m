Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97F44502BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbhKOKtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:49:12 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29318 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbhKOKtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636973166; x=1668509166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TOIIOOYOP9uJ3CHzwHpbLAwJYYaezVMFQ64xJ+BU8As=;
  b=Qw2XNgDAcPwvk6AWLi54HSda8kpnFj8mKzVCFTTAmBHmfEabN+/NJNgl
   AKbE2CGzqncKWZ6Xfesbo3MU/KEZzCFG4d8ZFliNJVw8Lav7If4NIgyOC
   nYgm2/CI/omOkJ3+NvvliiSmPQuFOtBfsmbv6b7QajSm83R412iZco700
   rIejL3wHpZg1USfT5m5r0U6j3yDvpN3gx1Ylzhot0sMUleRoyflYLLBMR
   yiyOkxSBFiO6eb3+zb3tobyPR1xvq4o3J2eQLH8zpeqqPTepMxNEzWyo1
   43KG8DglNwtbKbJ17Haa+YMuTnMnI80Kirf4MYKhEAd6/y1a97BPCAT5P
   A==;
X-IronPort-AV: E=Sophos;i="5.87,236,1631548800"; 
   d="scan'208";a="289557254"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2021 18:46:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USUC1UDbavB0DAnbDdFdtdf9X8MEayn3+I+XBxBcv55yD17fLCdoHWMrffNSvhEtkWtE74sHA0cUGuwFH5VF1ay1tYY7BmEk1y8/Pno7HWaBzp51uAy6Gk/b8JXZjXdRrJF08h396TdUA+XRH8gKF7Tn+MYmMaTCrl7XjA3QLGoPzzcRoUaqXq7DmTt17TIrxe2tcyLo3t9oy2H0b+pb81//GEFavgSfJd7N02WuN6ne1SELywN+/TDHVyPB2OL9zPr3wZKKsGeFQI3U1N7FW8XKikNtVdFOC+vhFbRh2NIff27hQN7o5VezsGUHAdMHNPuMUnUVZqEdHPHIgjj2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL7H22xP0//4fFO4cjvEvAQcGBBFLaYF32CQTm05qEY=;
 b=gUWuN/ocZSkrviG0Fl37FWXeoZRsw3xPR2ngz93WHdLx7Ly6tNccML8jYJ2KPvkqPxqSfnLx6F6HNCpb1G7HaWoozSmp0Febwk5VL5wiMcpzsQz0ONEtllrwP/YZ5VYwMuYUaiyM+NNFvmqhhgfGcMqk01vJhvQcJ7bYwX99huuXaVmcU6wq/mOA+l9gWerACkJ7/jdbmNUgUVtPrwuDa/ac+8K7vy91JKJvPSDELBW3p5IMVXfLgZEc3pxoK8vi776nGZbRfoh+92EyICZxXGmr5CXECl/tJY3FMnsXZIVVSzbITL3ZJ6AIygp92BkZfGWNI90UZ1B8ahMMCwPAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SL7H22xP0//4fFO4cjvEvAQcGBBFLaYF32CQTm05qEY=;
 b=u8L2VpO1AB0Ml9KGVJkQ7jIvrWEnTjp0iYahLw5L9x8RnxJXvusINh5svRTBbB/KjuVVTCebeWE9Y502WLk9tJ8qWhq52ZynA/8PBqAkfcrDTkJwEcvs5y3KiMVPi0N4tUlWQqa1g5cRUSP00mf5f2YQ9JEtBjaDYvWK4isUMq8=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB4295.namprd04.prod.outlook.com (2603:10b6:a02:fe::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 10:46:02 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 10:46:02 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "jing-ting.wu@mediatek.com" <jing-ting.wu@mediatek.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] sched/core: Mitigate race
 cpus_share_cache()/update_top_cache_domain()
Thread-Topic: [PATCH] sched/core: Mitigate race
 cpus_share_cache()/update_top_cache_domain()
Thread-Index: AQHX2g37TPTJ8je3+U2WwmDdbyK6Nw==
Date:   Mon, 15 Nov 2021 10:46:02 +0000
Message-ID: <20211115104601.lwcwxoc67ftbf6uh@shindev>
References: <20211104175120.857087-1-vincent.donnefort@arm.com>
In-Reply-To: <20211104175120.857087-1-vincent.donnefort@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9cff36f-010b-46f0-378c-08d9a8251e63
x-ms-traffictypediagnostic: BYAPR04MB4295:
x-microsoft-antispam-prvs: <BYAPR04MB4295BBF849080A17D51E873AED989@BYAPR04MB4295.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lgZP7Eb0+8DDq+1nnXfMzI+8xDLTDkwJD5JigQVDkKP5k1QyJTJxAXP0UzE6AZBridgMXXEAFDcvZ9zWN083xY0f0Gctw2Q+K3R7TTBP2rGcYPXMs6Phz1jhD1Xm6R7Jl5rDdAvZvnQ13ZHZJFUFOmhWcvtqEyznSv7ys0YQ0olQs1lYJbSYw0BgAZFvMR/DKuBYEZtFYHESzR9WyWmfAU18gwt1suRrsJZjhvtDmih2mQT0XQlWI624gU0eIv7rjQxAERz5G+NEXoiu4r+ZkBer1+pma0lr8rlqGKC6u/+Ebyyi0Ra1DUlWhlYpqh9TWawxvS7AnmjSvizoI7JL8rui1eVIYTNNMFm14dO23vErHUrImebaQgu5QLgg6TgEEqxPQi/pPFLadvk1TgRHDt3GwetdRJbnOc4oCykwgcqLaVNqvnl8uLztLGUclIHfxKmmF0q72OwZm+z9dBCZ0DbrxJeg+OC3y/ai6PvqAut9t5Grhs0Yf2fNS5cSwUpeDOWGsShgx9oYZOU6u9SAO2ZZGww76AzTxOY68XLQ9ozfyNWayTGqXQtMKGkQiQr4aEWaob+Jp6rU+bo58cdWKGI/b9N1ai4X5qUNfkeH2h9UVXlqvTRIkcP62l9cT2qLK+iZOiZn6uzTP176kS/cp4A0RDUtXQ7lcLmCT1ifLUyT7AoDVT7dt4sKUZtfIvymfJ8b6AGmGTpnT1yZoD1iLtxpadnb1qZdAk8zJwN6NbJ8iz5tTXsPx2LRDwX0/Gs2PF2qNOe5eRhoQTkHZVM4ktS0l+tW0YQhZn4hV80RzIM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(82960400001)(8676002)(44832011)(6486002)(76116006)(33716001)(6916009)(66946007)(91956017)(316002)(8936002)(6512007)(122000001)(4326008)(6506007)(38100700002)(966005)(9686003)(5660300002)(71200400001)(64756008)(66476007)(66556008)(66446008)(83380400001)(15650500001)(2906002)(1076003)(54906003)(186003)(508600001)(26005)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uWc9SXIsaZVzWWTKZBBrSQrlPuZD7J8UlXQ6o+E2V2+d6yj78deyiijYqVfb?=
 =?us-ascii?Q?yNqEzxR9yftqJ0+i7PKCBaxJ1w8f1HGp+JG4B8qKX3/5V54M6BObFVXXk2Zy?=
 =?us-ascii?Q?j3FbS/hwHjfnQZnscJZjXdecRpbzUO1/NIhIjKakomVSg3PSaTScLWK1Jm/c?=
 =?us-ascii?Q?rRES5WlSHuD7Rt3M/H/0RnxAiZZlEmiK6c0oZFvczxh/YjKzv89AwwZXQHfz?=
 =?us-ascii?Q?GXC65A5KHuR0SR5jOICOnLykgllAnlO2QlXsNJlLZwaAgqZx0wYObVu9JEYZ?=
 =?us-ascii?Q?iS9Brhwsxgbx/9VFM0jB0GOK9V/Ue67ly0udNBm92kyM6kxF6PXKrcOKNbbR?=
 =?us-ascii?Q?5MHUhdGxtCERAjW0TYz9v83fXDK8tpwICxeIfcNwUlZZhaYZZZKy0RXu76zU?=
 =?us-ascii?Q?7+9KzVeAFzKI+pCJAvn27+iYrvWr0ovMTZxFJH+bwAqxP9HGbW0MTMz9vkG4?=
 =?us-ascii?Q?8WcmZGBaQQY4ncYatrZgfceubiXKZyt/66WCLYcU+aFUaScrBdjxdqfnt99x?=
 =?us-ascii?Q?uzWuSZaRHYI2L89jvPqjFZLy6WXaU6+YkqPoa2Q+kqx48V1Vi/L/1xDYWaHj?=
 =?us-ascii?Q?MxVSgzuiDHafc8WQ5CWwWMZzfcu52Ww1yPO8omjwXcz6ydkxCfUePPZuqV3w?=
 =?us-ascii?Q?l6/MaS7DFCHQu+69f2ImYpQ60etLM3inCXzpARTGq1U7EPqes+8GS1K7pwo5?=
 =?us-ascii?Q?MbyVaR4nhqdRne37Xx8QXYGViQZzgj1wFVG4mgao91jOm/OZDc92ZPVxTF3d?=
 =?us-ascii?Q?sNsQkvN5QExaP5S5ynJtizhMKozNLzqdctzu2u1uZzfhi+T+hjPc8heiDVzy?=
 =?us-ascii?Q?I5HqzY+sbqBc7ywmaf6ZgXl8qgTEfGVxUnvKm42l+QoxR8qzqV5uBkOWKW2p?=
 =?us-ascii?Q?JTmYWQVBoXDd81y/rHlc383lksmzlwjtkIU++EO5QUBD87qySXO4GF/mvmBS?=
 =?us-ascii?Q?fG/wyJpc8CyIkPZBjOxRE8LckkfYtIxrxQaqUgIMrOSp+Fd2iTu0/En1Xgng?=
 =?us-ascii?Q?EHA3kT9uGzxH+AHc1c4CbjaQN67mTuILDXyKaJEpU8hcW8kkhBS5RU0iXewd?=
 =?us-ascii?Q?RyCGILuABI+1Htim3L/ssSB8a7ffOhZPs+elQyTwfeP3U8Rl7qFLSNO0WgkH?=
 =?us-ascii?Q?cUldMxzN0FxozmruLLRSTj64LbLlps+ThYHm4lCoINORGVGAIF8ZMTfi1Br3?=
 =?us-ascii?Q?MbzKeGcSkqSfmAEHjoMNO5B2tJ3k6xoiLg3y8gzqUdn87W7IdCurVjttKCMt?=
 =?us-ascii?Q?/fJDqRyYWZtjKSRME/4hHN7Qe1ZvtHyiH6eboFlDa91jM3e+zQduqi0LmLkl?=
 =?us-ascii?Q?+TIkJ7ICBqjKOqi6QgvyXCjKJMJiO8YHf2baBS6xHeiIvvYOa1SRyWcktIVo?=
 =?us-ascii?Q?hQMIR5jCMa3fSTkB4Zs116VGsQut2jlR3O2LDmFlo2VI/OCesb/lG5MJIDSb?=
 =?us-ascii?Q?lO/15XZJvGNzhWcn21/ewJ+JCQhhey1itqF0fNrBMNtPcWyOTTLoxsr4YeRa?=
 =?us-ascii?Q?uzWmHuJZrThLoww0c6UGg3z2IComD8utEjOkRT/9Z5SnSg0F2DZ6wSXmsQWT?=
 =?us-ascii?Q?i8WbSeFp1a3Cq0kEQITVHd9QkCiWCfUJZRoSzlU2gUBP4WeFHZoEj6OcDWJM?=
 =?us-ascii?Q?v+uZ196Nn0IHhAUjl6HA6KbOoaPYrfT5tQ9mxS3nVqGSwcfgYZ3yZyQNv3Iv?=
 =?us-ascii?Q?FIIDGFwryvgWA19AyMNfXmbyAYA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1181AA8717D3654ABD48B071D5CFE5CC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cff36f-010b-46f0-378c-08d9a8251e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 10:46:02.5366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SiNKS8pCSKbG5daB+zCimguHO3BlankJkLgqeplbtNcBNlgVGcF8m/tRK8OaSpGXnc59M5HbZ8FLnCPh5/39KNPq/KvfUZA4/Jp52BD57qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4295
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 04, 2021 / 17:51, Vincent Donnefort wrote:
> Nothing protects the access to the per_cpu variable sd_llc_id. When testi=
ng
> the same CPU (i.e. this_cpu =3D=3D that_cpu), a race condition exists wit=
h
> update_top_cache_domain(). One scenario being:
>=20
>               CPU1                            CPU2
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>   per_cpu(sd_llc_id, CPUX) =3D> 0
>                                     partition_sched_domains_locked()
>       				      detach_destroy_domains()
>   cpus_share_cache(CPUX, CPUX)          update_top_cache_domain(CPUX)
>     per_cpu(sd_llc_id, CPUX) =3D> 0
>                                           per_cpu(sd_llc_id, CPUX) =3D CP=
UX
>     per_cpu(sd_llc_id, CPUX) =3D> CPUX
>     return false
>=20
> ttwu_queue_cond() wouldn't catch smp_processor_id() =3D=3D cpu and the re=
sult
> is a warning triggered from ttwu_queue_wakelist().
>=20
> Avoid a such race in cpus_share_cache() by always returning true when
> this_cpu =3D=3D that_cpu.
>=20
> Fixes: 518cd6234178 ("sched: Only queue remote wakeups when crossing cach=
e boundaries")
> Reported-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f2611b9cf503..f5ca15cdcff4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3726,6 +3726,9 @@ void wake_up_if_idle(int cpu)
> =20
>  bool cpus_share_cache(int this_cpu, int that_cpu)
>  {
> +	if (this_cpu =3D=3D that_cpu)
> +		return true;
> +
>  	return per_cpu(sd_llc_id, this_cpu) =3D=3D per_cpu(sd_llc_id, that_cpu)=
;
>  }
> =20
> --=20
> 2.25.1
>=20

Oh, this is the exactly same fix as I posted before [1]. It is a little bit=
 sad
that my post did not get reviewed. Anyway, good to see the issue fixed. Tha=
nks.

[1] https://lore.kernel.org/all/20211029005618.773579-1-shinichiro.kawasaki=
@wdc.com/

--=20
Best Regards,
Shin'ichiro Kawasaki=
