Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003D938911B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348176AbhESOhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:37:43 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:37351
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240546AbhESOhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:37:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW5hNKUS2m/iuQbHTS9r/BvCiszOyaSON/4tHZ7TMpMqI00i6enxVDOsPHS6ndqSoIqQSyB41Un5C3Hx+OvyNkIvHGM0Ri7hafhlXAv9y2MdkG1w/LHXU4hEr/TADUlPXCQkXMNxKZQNxL9RKR1y2MJ5nMOGPStCp66XxS9w6SssyYOAO0FmZjHFGMnWQCKH6bIsA5w1b/K8VgZ22eYSa01fzfUILc96FDinCVRxyGE40id215SVbVhe6KeQUSi9ZmPUtErKGzz7rQ2qXvWf5Syg+VRWdP+IzeVjXaZynIbHQomEl3s18ptHdu1diWFoXIGzeEvPIMMKBJzGH0mHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BlBMLcZ+azHCf5aKY790kHV6fQF/AJkIo0KA8qD9iI=;
 b=VrfRCkdXvPB8Z88a6HxoDfzGF+L3W0Kj6NjBCikZJgMRex0/wZmUr7vXYvg6VcQaW1KgqbAozbqP/lXL3TCUolGpBtw4tCjjbDmipTWwqVtO/kvvEiJ4WVJ4WvfTyFsSXVVblxTB0iNJY/jDvO6ZUDN5we3qqfEOmgEluN4hbw1CaCsWpVhYgNPFGsxLL8q90/g5pe3BWjf+/hY8X6s7PA3XarFBd6DkT408O256YITTdY8XToj+2a5xI0VYA6UkPvN7Lz5/YErDYL9WzU/d/zYRoHMrJJvMyFFV3eugWs3whMIWG7WLpc7v5nePNPnF+TP/37qmjqjvJA4MaNQjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BlBMLcZ+azHCf5aKY790kHV6fQF/AJkIo0KA8qD9iI=;
 b=bwvotii3yF7nnVTSnuwo66sveSLdfySagDCY13wmFv94ex1TONTtF73qifHZ2BVrkPPrZFWI7CK7H+P1EqzRJgxgFKQ5dEwMxxi+NPvBIOA2E7vnVIthtwcoPKgiRRGBnvlYJ0LZPRgFxXLsiHIuReNNisSdhO5C+nC/MhLjoy8=
Received: from AS8PR04MB8500.eurprd04.prod.outlook.com (2603:10a6:20b:343::14)
 by AS8PR04MB8913.eurprd04.prod.outlook.com (2603:10a6:20b:42c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 14:36:18 +0000
Received: from AS8PR04MB8500.eurprd04.prod.outlook.com
 ([fe80::2ca8:978f:5800:3e9a]) by AS8PR04MB8500.eurprd04.prod.outlook.com
 ([fe80::2ca8:978f:5800:3e9a%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 14:36:18 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Qi Liu <liuqi115@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH v2 7/9] drivers/perf: Remove redundant macro and functions
 in  fsl_imx8_ddr_perf.c
Thread-Topic: [PATCH v2 7/9] drivers/perf: Remove redundant macro and
 functions in  fsl_imx8_ddr_perf.c
Thread-Index: AQHXTJSoFXtggJyyUkq3+wIvz+AaZ6rq3zVw
Date:   Wed, 19 May 2021 14:36:18 +0000
Message-ID: <AS8PR04MB850088AFA9C7BBDDA8F324F0882B9@AS8PR04MB8500.eurprd04.prod.outlook.com>
References: <1621417919-6632-1-git-send-email-liuqi115@huawei.com>
 <1621417919-6632-8-git-send-email-liuqi115@huawei.com>
In-Reply-To: <1621417919-6632-8-git-send-email-liuqi115@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [72.177.87.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b62b8a3f-b382-4a12-a686-08d91ad376fe
x-ms-traffictypediagnostic: AS8PR04MB8913:
x-microsoft-antispam-prvs: <AS8PR04MB891319BCFCC20631FBDA0FCB882B9@AS8PR04MB8913.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rg4emAJvKDNq8OGS0Gmfmzs/a6enF2yu5HRtwNaUCqf3O0SOw0dYd2ZJBH+YhxYQoMw1vs3qyJGtnNhNd+dihMZ974ydyvbLbscwCOs2bu7ILY3f5KN9L6v7JJFLhburM3OTKgE27H6siligvWUnseNAOLfryMojZ5o7WWkPJPrWsCN8HI/wbMXobyJwv1vo/ejjWOsZQu29NBuvgXgsiqpbM22gLIWKV9jcTpJkjUPnnBebjzo9E8MjISxbzOejYBGYEKSNO2kVZwCUfib/dRGw0EGLzzMXu4xExNlyIYiqOl3mB+LtW/HMaI1yW6FWIVvCiprY23E0NswNQloqCHDt8jApdyLLFs2gfHP8VXvkh/48nW01tVcQR03uE8+CNfPOR/9ytewlwCBtUeYmv9w8Zb3BDNeIsV/hizPzrNJMBxKXtoYLzR/vpClT8iWtc5rkvV/0Co6CfDxsUSM7ckKYo6OwPidIf4XIsfWxAglnpo/n0UdrWmlkdnwjT7OxSBdmGPuAzxpAmCPU8vqYXFc6+0q7Y+0iRyqwKUbmFYKTT7YqG9FJJK8lKuW0wBcnX0+VGJl2Vq18GSh6GSCjjldTzxFktTPXLxXThaM7W/U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(110136005)(66446008)(8676002)(44832011)(52536014)(2906002)(316002)(54906003)(26005)(64756008)(5660300002)(8936002)(86362001)(83380400001)(53546011)(4326008)(6506007)(7696005)(186003)(9686003)(66556008)(71200400001)(76116006)(66946007)(66476007)(122000001)(33656002)(55016002)(38100700002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BGQB189QndpC+2G/3at5YRvz2XQbIikEXRXRiBMowI512Bco1kJwPrlNZdJJ?=
 =?us-ascii?Q?w3uoKDeUGc3XQaXxMqZ/RyGsIWdlp7MFF9k/raVTP2GWEwfQjvZnbUBYiwSO?=
 =?us-ascii?Q?Ojcz0Y9eXOo3Iz6pO7kBhiXCxk9uV779PTiZ/qlGrJCxRrcsyDCL9BHYl816?=
 =?us-ascii?Q?cgJ3IeEuepwjNR7bdlTvHX2nOhR2D10SEs9jwls3+8zZU680y+xU/w45GTXw?=
 =?us-ascii?Q?TxDj1Ic/vSIhVFkA/a2WePkzpNems4hpi3XgVRST66wU1HqdPrv6mNkSfDzw?=
 =?us-ascii?Q?eLB7rBUuUR1yjr/mfrA1TmCxdgMxfdbCnvewj5hXZRDYIplabJcViwVNROph?=
 =?us-ascii?Q?ZU8X92PBY+Y9QlhMW6/uULcE+VD1osCQEHHl6FmOV5fyaFkhDuNSDqOpv77Y?=
 =?us-ascii?Q?fwwGf3X/AcM7wlBIi0J9dtby21hHLic1GVEveDV9Xb3z7t+i/fXEwyGcnDj/?=
 =?us-ascii?Q?o7JDxxqM49ptPth8PBRJnVL3ycnQxJxRP7qjyPr/HH4aCmlAkpEc1kV50K3G?=
 =?us-ascii?Q?ijwXwmL5IpDGmtaXJkXa3U2PYtEL8KPctIsz4cl30W6mZdK+gJR7rmzlF66v?=
 =?us-ascii?Q?FJ4HXH6Ex1tKkzt4i30FpjqnTA4gnTRAfeQ2K0mTamW8Dw8zfVK1ri+G3LcA?=
 =?us-ascii?Q?UZ/YgLG6aY0II9HOGNtvyG4fCvfBj4WplJepkF4ALvh1AeeUVb5x+L6MBBRP?=
 =?us-ascii?Q?mwolO8gLETW5uFZWXfaK8Cwl+Ee8DSbF8Nma/zVyRP5jORJu8IlT3ctoSN8R?=
 =?us-ascii?Q?TKQocEVgCdyQV4gpXypWMt//jGk4EE+MHCGfnw73DQX7ksONkhAxxZWW7mGC?=
 =?us-ascii?Q?pw9eWe7xk+P1UzQRt1py9K3IMj5Q+O3pJzIQaoueLHs8BEJHH+kTWqo867qB?=
 =?us-ascii?Q?E/HxU+7lzdQX3cUthFdKOVmYRnQJBtbKhO3DMw8n2uvoyVLj7LgDBMcSp8VN?=
 =?us-ascii?Q?tZtPEjdeBNw6psquLvjhAIcmecYC/baujt+41K411YvFoX9tWQXmnN7aSzQo?=
 =?us-ascii?Q?Oqq3KoWIwR/0gfzoj4TNCAwlo+ri6nHEsudMeSSBhUgZRv6vKGAuHanYqMZD?=
 =?us-ascii?Q?L6i6DN2brKujL7LXPlBkI+Yp2yIXRHuB9nGisl6hqoq1kxNMXBheminUQx8o?=
 =?us-ascii?Q?wlM2bYUH+SuLwpevWJQ8OYS6aBYtyjEtZn1gq1k0GeGwFyZLW4BKfjJoukLB?=
 =?us-ascii?Q?fxv3Zqzof78PGvHYzQkwwGIUSJL9HlLnZchHq3N+XaqIpO5wsrnASfa0BVVb?=
 =?us-ascii?Q?fQzZZpx21RUzZzug2N5RiQHJKkTj7TKCCu7aWB1Z/CUKngaVP3aYgLtp2T+P?=
 =?us-ascii?Q?Y/7ZzeVtA83ziC6IRP9cSENV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62b8a3f-b382-4a12-a686-08d91ad376fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 14:36:18.6019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FVqvlIyrychezHmXaEpv6PpP9yPiI+SPFmrfzkVJj0TERjd3+rolSTEZnsxBhsGy0JEIYqHe0z6xAcVIGBbsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8913
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Qi Liu <liuqi115@huawei.com>
> Sent: Wednesday, May 19, 2021 4:52 AM
> To: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: linuxarm@huawei.com; Frank Li <frank.li@nxp.com>; Will Deacon
> <will@kernel.org>; Mark Rutland <mark.rutland@arm.com>
> Subject: [PATCH v2 7/9] drivers/perf: Remove redundant macro and
> functions in fsl_imx8_ddr_perf.c
>=20
> Remove IMX8_DDR_PMU_EVENT_ATTR and ddr_pmu_event_show(), as
> there is a general function for this.
>=20

Reviewed by Frank Li <Frank .li@nxp.com>

> Cc: Frank Li <Frank.li@nxp.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  drivers/perf/fsl_imx8_ddr_perf.c | 80 ++++++++++++++++------------------=
------
>  1 file changed, 32 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/perf/fsl_imx8_ddr_perf.c
> b/drivers/perf/fsl_imx8_ddr_perf.c
> index 2bbb931..8f2c4dd 100644
> --- a/drivers/perf/fsl_imx8_ddr_perf.c
> +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> @@ -212,55 +212,39 @@ static const struct attribute_group
> ddr_perf_cpumask_attr_group =3D {
>  	.attrs =3D ddr_perf_cpumask_attrs,
>  };
>=20
> -static ssize_t
> -ddr_pmu_event_show(struct device *dev, struct device_attribute *attr,
> -		   char *page)
> -{
> -	struct perf_pmu_events_attr *pmu_attr;
> -
> -	pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr);
> -	return sysfs_emit(page, "event=3D0x%02llx\n", pmu_attr->id);
> -}
> -
> -#define IMX8_DDR_PMU_EVENT_ATTR(_name, _id)
> 	\
> -	(&((struct perf_pmu_events_attr[]) {				\
> -		{ .attr =3D __ATTR(_name, 0444, ddr_pmu_event_show,
> NULL),\
> -		  .id =3D _id, }						\
> -	})[0].attr.attr)
> -
>  static struct attribute *ddr_perf_events_attrs[] =3D {
> -	IMX8_DDR_PMU_EVENT_ATTR(cycles, EVENT_CYCLES_ID),
> -	IMX8_DDR_PMU_EVENT_ATTR(selfresh, 0x01),
> -	IMX8_DDR_PMU_EVENT_ATTR(read-accesses, 0x04),
> -	IMX8_DDR_PMU_EVENT_ATTR(write-accesses, 0x05),
> -	IMX8_DDR_PMU_EVENT_ATTR(read-queue-depth, 0x08),
> -	IMX8_DDR_PMU_EVENT_ATTR(write-queue-depth, 0x09),
> -	IMX8_DDR_PMU_EVENT_ATTR(lp-read-credit-cnt, 0x10),
> -	IMX8_DDR_PMU_EVENT_ATTR(hp-read-credit-cnt, 0x11),
> -	IMX8_DDR_PMU_EVENT_ATTR(write-credit-cnt, 0x12),
> -	IMX8_DDR_PMU_EVENT_ATTR(read-command, 0x20),
> -	IMX8_DDR_PMU_EVENT_ATTR(write-command, 0x21),
> -	IMX8_DDR_PMU_EVENT_ATTR(read-modify-write-command, 0x22),
> -	IMX8_DDR_PMU_EVENT_ATTR(hp-read, 0x23),
> -	IMX8_DDR_PMU_EVENT_ATTR(hp-req-nocredit, 0x24),
> -	IMX8_DDR_PMU_EVENT_ATTR(hp-xact-credit, 0x25),
> -	IMX8_DDR_PMU_EVENT_ATTR(lp-req-nocredit, 0x26),
> -	IMX8_DDR_PMU_EVENT_ATTR(lp-xact-credit, 0x27),
> -	IMX8_DDR_PMU_EVENT_ATTR(wr-xact-credit, 0x29),
> -	IMX8_DDR_PMU_EVENT_ATTR(read-cycles, 0x2a),
> -	IMX8_DDR_PMU_EVENT_ATTR(write-cycles, 0x2b),
> -	IMX8_DDR_PMU_EVENT_ATTR(read-write-transition, 0x30),
> -	IMX8_DDR_PMU_EVENT_ATTR(precharge, 0x31),
> -	IMX8_DDR_PMU_EVENT_ATTR(activate, 0x32),
> -	IMX8_DDR_PMU_EVENT_ATTR(load-mode, 0x33),
> -	IMX8_DDR_PMU_EVENT_ATTR(perf-mwr, 0x34),
> -	IMX8_DDR_PMU_EVENT_ATTR(read, 0x35),
> -	IMX8_DDR_PMU_EVENT_ATTR(read-activate, 0x36),
> -	IMX8_DDR_PMU_EVENT_ATTR(refresh, 0x37),
> -	IMX8_DDR_PMU_EVENT_ATTR(write, 0x38),
> -	IMX8_DDR_PMU_EVENT_ATTR(raw-hazard, 0x39),
> -	IMX8_DDR_PMU_EVENT_ATTR(axid-read, 0x41),
> -	IMX8_DDR_PMU_EVENT_ATTR(axid-write, 0x42),
> +	PMU_EVENT_ATTR_ID(cycles, EVENT_CYCLES_ID),
> +	PMU_EVENT_ATTR_ID(selfresh, 0x01),
> +	PMU_EVENT_ATTR_ID(read-accesses, 0x04),
> +	PMU_EVENT_ATTR_ID(write-accesses, 0x05),
> +	PMU_EVENT_ATTR_ID(read-queue-depth, 0x08),
> +	PMU_EVENT_ATTR_ID(write-queue-depth, 0x09),
> +	PMU_EVENT_ATTR_ID(lp-read-credit-cnt, 0x10),
> +	PMU_EVENT_ATTR_ID(hp-read-credit-cnt, 0x11),
> +	PMU_EVENT_ATTR_ID(write-credit-cnt, 0x12),
> +	PMU_EVENT_ATTR_ID(read-command, 0x20),
> +	PMU_EVENT_ATTR_ID(write-command, 0x21),
> +	PMU_EVENT_ATTR_ID(read-modify-write-command, 0x22),
> +	PMU_EVENT_ATTR_ID(hp-read, 0x23),
> +	PMU_EVENT_ATTR_ID(hp-req-nocredit, 0x24),
> +	PMU_EVENT_ATTR_ID(hp-xact-credit, 0x25),
> +	PMU_EVENT_ATTR_ID(lp-req-nocredit, 0x26),
> +	PMU_EVENT_ATTR_ID(lp-xact-credit, 0x27),
> +	PMU_EVENT_ATTR_ID(wr-xact-credit, 0x29),
> +	PMU_EVENT_ATTR_ID(read-cycles, 0x2a),
> +	PMU_EVENT_ATTR_ID(write-cycles, 0x2b),
> +	PMU_EVENT_ATTR_ID(read-write-transition, 0x30),
> +	PMU_EVENT_ATTR_ID(precharge, 0x31),
> +	PMU_EVENT_ATTR_ID(activate, 0x32),
> +	PMU_EVENT_ATTR_ID(load-mode, 0x33),
> +	PMU_EVENT_ATTR_ID(perf-mwr, 0x34),
> +	PMU_EVENT_ATTR_ID(read, 0x35),
> +	PMU_EVENT_ATTR_ID(read-activate, 0x36),
> +	PMU_EVENT_ATTR_ID(refresh, 0x37),
> +	PMU_EVENT_ATTR_ID(write, 0x38),
> +	PMU_EVENT_ATTR_ID(raw-hazard, 0x39),
> +	PMU_EVENT_ATTR_ID(axid-read, 0x41),
> +	PMU_EVENT_ATTR_ID(axid-write, 0x42),
>  	NULL,
>  };
>=20
> --
> 2.7.4

