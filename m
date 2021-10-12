Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6971429F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhJLIGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:06:17 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43202 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234899AbhJLIE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:04:58 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C0gWXE031571;
        Tue, 12 Oct 2021 01:02:12 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bmpv4ukf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 01:02:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgpVjKuYZWZGbe23+SsfqyMz00yerxAyt/VzKCpW/e8eAA2bk4u3Gw2NamThCpQPNb8XekOy6CunkLyVmIylq7eLxI5zFFe8rtYJmADHh4nCwbouowAQVo9Lf9HSdxlngJWG2FSRYArMi6YuJN45WuFRRFsOrImqPTTtbuR/5z9HPnJLrW6mC6dnW5oNqJmsWVEgkhfW103QjNcXWhCBFQUs/ALO/LQWwVwR9Ndv4vMneKIx2kqXN30heLGKb2EnMEb+mgstv7iGwPG8xuFYwhhyxXsxnqGOcOd6J4r9NeKYQpRBFlaNmf8npZ2cgyMaobDyW5Fujit9FSX52MfRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTlmD9Kpgv/ABeTdXnkBkpuO2V3upfqHd4nX2a/g5E0=;
 b=XvBNKrOpuoFL5ysZUMg0GCknIAxDpsisgnDd7NmUTwhfusfq0dZjdtZDO+Y04TBW5g44Ac7FkRIOwX2l8kn3yiRLl+nSqkZDbHE8AW35RAsV0pQUU1+M1yPltoWR6/AZnOy2A9SiK7se1F98xKEWAgVwh/UyyFeqzWkN+iCnfW2kkXRX5lOYbTjV7Zac8ANxZVXvlvigoSES5kqREZbnqVbutNcDFQGaKXLYptFycaKUxFhWQV4pud4NMg5jJv60clymHzmWp6RcMEDnwxM5GojKuFfuyHCYMMLlHuZ8Lh1s/ZQ82Ztp0b/MOcKUbHQ2BPnLcKHYPX5W30TqMgbdrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTlmD9Kpgv/ABeTdXnkBkpuO2V3upfqHd4nX2a/g5E0=;
 b=DUu1Ms2S9wtGL/UTz2ZSRwCrBj47uggrnQUsTRriux+yKRW0cvW+pBKBd9GNE+n37JR2XyUTYqgCB0u7MdulSjB6fRwbVVgF2iMORpqH1ZdeF8b8H4QPb+tGDIm+XI1esS3+dt2YElssG5dh6BlRncmtUGN6tXwyP9ZAY9DNMmA=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO1PR18MB4731.namprd18.prod.outlook.com (2603:10b6:303:ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 08:02:10 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::9da7:4d20:98ff:e441]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::9da7:4d20:98ff:e441%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 08:02:10 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: RE: [PATCH v4 4/4] perf/marvell: cn10k DDR perf event core ownership
Thread-Topic: [PATCH v4 4/4] perf/marvell: cn10k DDR perf event core ownership
Thread-Index: AQHXrd2Xcorcgtmsy0+X5+eU/Myu66vPIx5w
Date:   Tue, 12 Oct 2021 08:02:10 +0000
Message-ID: <CO6PR18MB44654A1AF5A02C120892F476E3B69@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20210920050823.10853-1-bbhushan2@marvell.com>
 <20210920050823.10853-5-bbhushan2@marvell.com>
In-Reply-To: <20210920050823.10853-5-bbhushan2@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2048006-3438-4ac9-9814-08d98d569823
x-ms-traffictypediagnostic: CO1PR18MB4731:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR18MB47310EE1C65A5F515BDAA7DDE3B69@CO1PR18MB4731.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R4Wvyp/pM04UeXynAwXK317FY6X1qvRLZIaJxQpS/dCYp+1poeN7fdCXKjGuZ8gQrm0SUXGMO76uD/1H+1PEN2rjOBi2CS/NzIlEL8nRMMEJVJNByh25Pv5m90OA2K6yoD/mvmSfGRsO5HwRr3aQjqMHDt9FGR1I5nEXGcpZigANVzk0P8yk8mMD2SfnvZTRyn7ziIqvvcuSCADhypZO2PVmlMuYIuJd/auVGlihx6jnbVaH5FooyIh2MErSQKm+544qXhVb9tbKtsT+Z9gefCb39N56olnbmw3Bmh6tppX4jNbtD8n0oYupHG1fZl/p2KXgFz05IrKC5SidXnq+yoEknSCT3sQGfR2H/AbOHxxoXc5M1eI9SzhrNBhC25fimm64WD6p7KMl1KrZEgA0/awQ+TTJAAzesH+VHoDZrxlUzedEtCKELdZritS9J8dHAIqn+X8VRrYOV9mITB3fduAMNVby6GhOmNTBYbiJW4TLJZVzsiHru+HGtDioh2spLxgNFjxN1U7YxYsnE/9UoC5tRlIZrpYa835+cNfm15+iZByf2tyED1/0BJtqbNEcabcoAjtuxSeYFN9jfgQeoLHusC4D8WBIEM3FL4nqGL6CDY6t54zfoQy8oC83xleQ9MVfgTHYL3aFf+gdAhIBLIswesW7qLZCEcuLk43uj+DCX9GX/CHeyUrD128AC5tsJHpnO0HP15Hq0QnV7HNbiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66446008)(64756008)(66476007)(66556008)(38070700005)(66946007)(122000001)(71200400001)(86362001)(38100700002)(9686003)(55016002)(83380400001)(5660300002)(26005)(33656002)(6506007)(8936002)(186003)(53546011)(508600001)(7696005)(52536014)(2906002)(110136005)(6636002)(316002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?urSg7xt7mT2sboFPJO9nLskhcowGKG/zCqxigLvWcvr8F108iTq65fQbAqwl?=
 =?us-ascii?Q?vDtTCgwzD9201GCHo9d2fYaWoNVBp9E9/eIdHV02iPuIYSP8baYCg/uHj968?=
 =?us-ascii?Q?AG4olE4ccqlUBi+MKOVP+u7vqLO2rwg4Q4fNGc1y0i4hVrdLX1d7LkUqXW6j?=
 =?us-ascii?Q?avGK4Nd2d3/HPFt5YOKkDuvnR58cwzCLyJ9BcAWIBvvuLzb1V0lLbZwbJkhi?=
 =?us-ascii?Q?JkLXgOrnCT/lEN4GrNvyKPuaGp+7AynjTEXd/OYi92rysTB2JKomYUUdqZzD?=
 =?us-ascii?Q?oMiqdkgmYB5EZBBcBOKXsLTcSI831nYiHwTwTfR9Cyx2zf36RMf/g1uKFq/Z?=
 =?us-ascii?Q?4iw8lHzVf2RUDALSxl4oLXyKLoNbs8vB+RVFOHT1HC+HlrTnM6RdWYEOuNIM?=
 =?us-ascii?Q?psddTTPLb008Aa1qjkaVqsBsEVP3qV6a6MFIpy1xiCJBKNeghzptW7K1yfuk?=
 =?us-ascii?Q?wDxYbqSC1h2y/nmCL/0COhSBR3rEGL4HI3vbcx/FiWfA9nfoWyK5LVz1Murl?=
 =?us-ascii?Q?lHYmcIueySB8TYC86McJIz7EF/QnGsCcwtSDvQ1pihoVvbNCH8kcK7S8lnFB?=
 =?us-ascii?Q?xymvrwQD9J0PaVPOFwlyt1qbzVnZpQhNmE1a3sN7Okm+Yj6eH376kdp6YS7x?=
 =?us-ascii?Q?B+RRjpUjAg1UeEd3jtsySaquH1YNkZBAwduF/aOYLp3PDVPkEG9ECOjgE6PD?=
 =?us-ascii?Q?lV3bGtuUeYaB0+Phyis0dHtqPO2bi1gMxkPKmXdGfdOpnhWaby65N84ZVBXi?=
 =?us-ascii?Q?x4K2iMY8lPAd/5ZcU2XpHTzpDpBlvUojExiecMwhUMms3C21PtEIDsEXhdac?=
 =?us-ascii?Q?0cd41eA4m4atW81XGRrmJjf4blXpj//rUKRSI3ocJ5VOfVZRARyW1eMqRX8f?=
 =?us-ascii?Q?YaiYg2GQD7JW0r2w++A+1eEXe/+DpzEugnO9vrfjGt4WiMZt4TPJLuCpQcPz?=
 =?us-ascii?Q?q2fCc8QUriP8yPlnuYQ/XnKhaj97kO10dfc7BqJUKydfiGy3w6Yrbr7YEFFf?=
 =?us-ascii?Q?2c0rZxCRvT91qunR4gYjW9r0L+5HSvfhcxRruueGDseS9qym/xPgIMNx0w7s?=
 =?us-ascii?Q?B2XgjVClc3R7Do2SYGg7XTadZheDUNp4qoVnSiXqffFr8giXAuaTCyDl9GrJ?=
 =?us-ascii?Q?BzoPaLj1ILChV/Oao6O99UWaO13yDfiGXYkUx9mBms9QHWpUx7UaTbXiOMsi?=
 =?us-ascii?Q?quXiqTiOskuMwPOAFZXlBSrN7CBqdPXP15+OamvpkRaCKmJacWNlbak7KNMF?=
 =?us-ascii?Q?haaxmvr09KW2ElAhTBlwHPRJhTjopnDQWsZ0Q4jWZeGARJsaNYsEnHtRuUBJ?=
 =?us-ascii?Q?GW559A7HNlKtIFEnTacZKzQo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2048006-3438-4ac9-9814-08d98d569823
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 08:02:10.6837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKXYqSiS/QClRcxSVEAoW7QXenQkj+dKMHrqgsNsrkZGooRB1El4LPfK/+fi1KA+LGUDCV/BmHpMlBHw8YC9Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4731
X-Proofpoint-ORIG-GUID: kEfAwcmnp-VIEEctrAkb-jHzcQtfPv-d
X-Proofpoint-GUID: kEfAwcmnp-VIEEctrAkb-jHzcQtfPv-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_01,2021-10-11_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Bhaskara

> -----Original Message-----
> From: Bharat Bhushan <bbhushan2@marvell.com>
> Sent: Monday, September 20, 2021 10:38 AM
> To: will@kernel.org; mark.rutland@arm.com; robh+dt@kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Bharat Bhushan <bbhushan2@marvell.com>
> Subject: [PATCH v4 4/4] perf/marvell: cn10k DDR perf event core ownership
>=20
> As DDR perf event counters are not per core, so they should be accessed o=
nly by
> one core at a time. Select new core when previously owning core is going =
offline.
>=20
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v1->v2->v3->v4:
>  - No change
>=20
>  drivers/perf/marvell_cn10k_ddr_pmu.c | 50 ++++++++++++++++++++++++++--
>  include/linux/cpuhotplug.h           |  1 +
>  2 files changed, 49 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c
> b/drivers/perf/marvell_cn10k_ddr_pmu.c
> index 21fccb9090c5..bef0cee3a46a 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
> @@ -129,6 +129,7 @@ struct cn10k_ddr_pmu {
>  	int active_events;
>  	struct perf_event *events[DDRC_PERF_NUM_COUNTERS];
>  	struct hrtimer hrtimer;
> +	struct hlist_node node;
>  };
>=20
>  #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
> @@ -610,6 +611,24 @@ static enum hrtimer_restart
> cn10k_ddr_pmu_timer_handler(struct hrtimer *hrtimer)
>  	return HRTIMER_RESTART;
>  }
>=20
> +static int cn10k_ddr_pmu_offline_cpu(unsigned int cpu, struct
> +hlist_node *node) {
> +	struct cn10k_ddr_pmu *pmu =3D hlist_entry_safe(node, struct
> cn10k_ddr_pmu,
> +						     node);
> +	unsigned int target;
> +
> +	if (cpu !=3D pmu->cpu)
> +		return 0;
> +
> +	target =3D cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >=3D nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
> +	pmu->cpu =3D target;
> +	return 0;
> +}
> +
>  static int cn10k_ddr_perf_probe(struct platform_device *pdev)  {
>  	struct cn10k_ddr_pmu *ddr_pmu;
> @@ -661,18 +680,31 @@ static int cn10k_ddr_perf_probe(struct
> platform_device *pdev)
>  	hrtimer_init(&ddr_pmu->hrtimer, CLOCK_MONOTONIC,
> HRTIMER_MODE_REL);
>  	ddr_pmu->hrtimer.function =3D cn10k_ddr_pmu_timer_handler;
>=20
> +	cpuhp_state_add_instance_nocalls(
> +
> 	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
> +				&ddr_pmu->node);
> +
>  	ret =3D perf_pmu_register(&ddr_pmu->pmu, name, -1);
>  	if (ret)
> -		return ret;
> +		goto error;
>=20
>  	pr_info("CN10K DDR PMU Driver for ddrc@%llx\n", res->start);
>  	return 0;
> +error:
> +	cpuhp_state_remove_instance_nocalls(
> +
> 	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
> +				&ddr_pmu->node);
> +	return ret;
>  }
>=20
>  static int cn10k_ddr_perf_remove(struct platform_device *pdev)  {
>  	struct cn10k_ddr_pmu *ddr_pmu =3D platform_get_drvdata(pdev);
>=20
> +	cpuhp_state_remove_instance_nocalls(
> +
> 	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
> +				&ddr_pmu->node);
> +
>  	perf_pmu_unregister(&ddr_pmu->pmu);
>  	return 0;
>  }
> @@ -695,12 +727,26 @@ static struct platform_driver cn10k_ddr_pmu_driver =
=3D {
>=20
>  static int __init cn10k_ddr_pmu_init(void)  {
> -	return platform_driver_register(&cn10k_ddr_pmu_driver);
> +	int ret;
> +
> +	ret =3D cpuhp_setup_state_multi(
> +
> 	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
> +				"perf/marvell/cn10k/ddr:online", NULL,
> +				cn10k_ddr_pmu_offline_cpu);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D platform_driver_register(&cn10k_ddr_pmu_driver);
> +	if (ret)
> +		cpuhp_remove_multi_state(
> +
> 	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE);
> +	return ret;
>  }
>=20
>  static void __exit cn10k_ddr_pmu_exit(void)  {
>  	platform_driver_unregister(&cn10k_ddr_pmu_driver);
> +
> 	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_MARVELL_CN10K_D
> DR_ONLINE);
>  }
>=20
>  module_init(cn10k_ddr_pmu_init);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h inde=
x
> 832d8a74fa59..a4b521f12b58 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -227,6 +227,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
>  	CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
>  	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
> +	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
> --
> 2.17.1

