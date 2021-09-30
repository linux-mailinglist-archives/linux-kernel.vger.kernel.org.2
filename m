Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4849E41D631
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349341AbhI3JYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:24:23 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:3826 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349293AbhI3JYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:24:21 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18U1KYWx001409;
        Thu, 30 Sep 2021 02:22:27 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bd3g39mwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 02:22:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/BD2SW0/MLrTMWwLJcVSNhW5HsKOLp81S+ISYeIfrvVq8PnavD+wDuAT2pYb6el4d423bM41vQKH0wL2DAG+JmBYnsWKrf0uja0OeDChpDJHfvmU6CXlx1weEkLwU8bsnIAQq4yRa12G++MzCKAQbAPYdfQW5/8tzfDMdxLMAkI1vm98OHUJmsNlOTUBkGNYSRQb5NPax8YRv5P9P5iml7huzun2bzF/wb2mG9YpTggijxIz5rcWxcwjR2CuRx6WKuQ917Ng+xjoITnPPB3BEpS6fL79d8X6VtiYEO6w6EWGnn6G8rGRxr8x1UCU7RBPJjRnLB8gW020NGFRM8Ctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vPw70TIEL6iPHeUpHGyycW1GR2nESnKd194efwGZoDc=;
 b=YwUZ3MEsleISRFwwGIKChQM/WhY0ZbI4+3G6lPxZP2pPowkcsFstOeWsW3gQl1IlP/B+lN1kPTvE8hR1/o3qL+0qNzOvq/7J4iTtJk42LhSiJ+f6rzrQ8vrWzUqQvbDgWoXOkoXbBJsd25IP2u2S/+8tztD2SksjdeWcJ0JGZGb5J2nn9ixg5kvohjqpboc/NlDqdT3VwzBlLjKN2iTJvtYBaPMEbH6dHnHFXY/jxleN2QGlJvZkB28LgZCs6wn8mpuzFodzN00UvOvDOS5w4b0feeHoRxBIZZqQRSj9pzeoTWjZfGkXeadfrsBiRmxCWnbLjYrTBkTVkBoPJMnU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPw70TIEL6iPHeUpHGyycW1GR2nESnKd194efwGZoDc=;
 b=TeLA3Kr11zSsO+E5xd/XpKZ8wEiB3DR2aTldblEhZwDQiYpdLg60irT1QgJcgny3rxOHW3O9cVejKx++bd5NDNuP58D0ZNRx23P4JRVDEpW+WZE3UmyW+NXhV6l2QeL7B9IdTwjIXBSPD1fVrOdSqcZAmrDUlKW9cdEmtuTFvcw=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1286.namprd18.prod.outlook.com
 (2603:10b6:903:10f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 09:22:25 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::d8ee:a8f4:b25a:7b48]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::d8ee:a8f4:b25a:7b48%7]) with mapi id 15.20.4544.023; Thu, 30 Sep 2021
 09:22:25 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 0/2] drivers: perf: Add Marvell CN10K LLC-TAD pmu
 driver
Thread-Topic: [PATCH v5 0/2] drivers: perf: Add Marvell CN10K LLC-TAD pmu
 driver
Thread-Index: AQHXpKmvLbIyd1MMTUy5i5BlP65Pnau8ahDw
Date:   Thu, 30 Sep 2021 09:22:25 +0000
Message-ID: <CY4PR1801MB207038FD04A714BF15DA88A3DEAA9@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20210908120425.10084-1-bbudiredla@marvell.com>
In-Reply-To: <20210908120425.10084-1-bbudiredla@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42857ac0-46cf-4525-0667-08d983f3d0f3
x-ms-traffictypediagnostic: CY4PR18MB1286:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB1286C5A7D423BAE950773131DEAA9@CY4PR18MB1286.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +zt//Va+QDM50VS+jF1RA5hvzcw0aXM4RajzZ6AQyo1kFQh6d6ZCwV8w17ucReHc1J/UBRoKiGUuHZonwRW+BFdrAymVKmvSMESFbisAkJqLZlLefnvsUvuPH/bwSB1yP8TvR2ulfH+j6IMju4HUcX6voqQt0GsdWK1e79ItzlPfBGyNc1iBuM8s1Pf26OzhF/wVGWPZvxiG8jP43WzXSILBb0BoIbpsRuYxBJCT8RYHpMhxQR70PvpYS4QXWUtgo4t4RdY+gBMhk/wFpMdEgAI8wYp77Py0vMqAHgrxjPse0D1zOCRUQtO79Gg+wmm/mmcUlXUwAco1deLnrw6zwS3+qNiSjon3hoQCHZuZNilIIyZncSsm2pvTcETBhu5jTCpK4oyVlW2MasJzlQiaxW2hzuJvsqXIjVNjcASaRJI7lSFcOc5AlfYaS7Z2RqjhBfZg2YsaaOcTcVvmZOBBtQgZb9FBUwZEOm/+hSTVUF2DTuaFrD15LZ6AB3AcaRPwWVEpFnEpO5OCQuz7YIXiOlFenoGvTxQiWjBtwBJKzAd7pwvYjMcXtcWS93hSIkyUQoi8ocKo5Y+dAymlfbGxSHCKB+gglbcWnTdnn7RT+dwTCJlaU+KZkUKOKgxMDfHJzotC2GCxTZcJX7PhShfpiOsibPcdpxptVxOc1MApIBkYxzxcZ3GXA5du6EG3Oy0IBH6ztIKSkCi/Smc7JvZPpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66446008)(64756008)(71200400001)(26005)(9686003)(86362001)(76116006)(66946007)(186003)(66476007)(4326008)(33656002)(66556008)(55016002)(6506007)(7696005)(52536014)(6636002)(8676002)(5660300002)(8936002)(122000001)(83380400001)(38070700005)(54906003)(38100700002)(110136005)(316002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tIr8slrZRwjRQ4Z/qJ1xbkoN/0d0aklzCyMT4vzR46gmTMABN3zORi6Ejr16?=
 =?us-ascii?Q?sltZhW891YdgQMjO0794I+cQVEwvIIVE4d1OG7OFBLi0tSTR9+dSnByC00g2?=
 =?us-ascii?Q?4UYWV3OyYVWCQ+Ek/iO3l1UqavoDwsaC7KN4rojbcIDOXmU9e1Gja3VjWLrA?=
 =?us-ascii?Q?pVZygYWGbWwbycVlUxYnGwF6tMK7lbZ1lwhfyOvLjRFQTHOPXfVnj8h7YMpt?=
 =?us-ascii?Q?BOAV9OEs/xgk05BJRkgzQY43IXNNxnEUkDK6AWTt3NnSmqTVo2jUBhPX34lC?=
 =?us-ascii?Q?NQPTD+v1Mn72oeCxvI4jKhoNLm7UNU6HrKTqUfOccfhIfB4U8ux1bPx/ja5U?=
 =?us-ascii?Q?IFh+cUpzGu/GTocBZOCF1oSlqc0KVEn95kUv/jlTEEEUNuDfY822bbp66Bai?=
 =?us-ascii?Q?cP78hsZ4pZH+W4FxAefBV2BAkdbY5KjBWhI6fOoWSIuIzaNFQVGHm9KBXEe1?=
 =?us-ascii?Q?daujNMQi4/p6XYr8epvYw0DzUqLsQ/PROWxs6bbq9JPHdI+Eethyqr3wQyXB?=
 =?us-ascii?Q?fn9g9Vyu1g9eEGgIwi19Q4ApLmxIg7H2ZC+yV5UAfsi9NfawwbrmAzqpK/QW?=
 =?us-ascii?Q?YwziV2rp9DakDT1tWwNYuryYKXyOX5zhOKPXWsxPtkiNjh5JEnZAsTvjCQen?=
 =?us-ascii?Q?+tPn+BSZBoDRfyNvA/TBQ/o/gsjQ83Sp/TqrEuiGJjZ4eTn4GoML3GC0EDE2?=
 =?us-ascii?Q?7pkCSl5DEcOaKpoR1V0qHxDS5x2Ev+FYNsS26/Ox9AwZwfRP6dOVhSQ4+xz5?=
 =?us-ascii?Q?hHPHxKxJTaAJbIE0zjLrW5eFuSXiWkgU+8XyMQ1wx/4zIXeMZ685JsJEK4Z+?=
 =?us-ascii?Q?hBAgbgoz3Xs6rEweEjSvOsLrqexQA3YogrFXhVRBzvT+bzqtAH2zxXdBm8/P?=
 =?us-ascii?Q?fJO2+ijHgYHi5ERZg862HXpKTQlTYTleZUZtKKAo0Ggh8r27r2BNgvcmtJ5G?=
 =?us-ascii?Q?QYatkoxKlpFEA/OIwBTf8qGsUn2qDbC5fzOnS5hz/NeZL9kGvOqhjF/LO9hk?=
 =?us-ascii?Q?CcIkYN7Twt/znAca/3KEqkajS+OqZRC4vYNw+lc0MY+q1VnPQMfPJa0sdZej?=
 =?us-ascii?Q?l6811fmmmSsjnvjpo9NOIERtQHVPqXHw11xTaJsHFJhJlmoxLdvZIMz9PJx7?=
 =?us-ascii?Q?RLPIj6W7rsKurhRFGryfCIriaSKks/Jfpb+3lR9E2++IRkVJIYpY3MucnWqv?=
 =?us-ascii?Q?v3Tqi/Cg4aEuOOAlgbDFxTI8IJ5evs6Th7dlDx00HjvfX6KVGqYHRoVfhK0p?=
 =?us-ascii?Q?/mpQPq+w7yOxyzvoxm7RZknpKd+TgZ4hwmHq992+5WWH3brfEodjk+z/ns0Y?=
 =?us-ascii?Q?tfAxgmny2FQZxCdTe9aOT69X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42857ac0-46cf-4525-0667-08d983f3d0f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 09:22:25.4605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4mduYnajbi2m9easMzj4HtnaQ5fy9LHi/PTXBbNFjO2qOBqHYLiva6HBw4P0lRpIMoeAZ7YDyA90ckwSjSRVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1286
X-Proofpoint-GUID: r5hy0cyw84y0bCWkNyhHtLdeEIHNzQ6O
X-Proofpoint-ORIG-GUID: r5hy0cyw84y0bCWkNyhHtLdeEIHNzQ6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_02,2021-09-29_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Rob has Acked DT bindings. Do you have any further review comments?

Thanks,
Bhaskara=20

>-----Original Message-----
>From: Bhaskara Budiredla <bbudiredla@marvell.com>
>Sent: Wednesday, September 8, 2021 5:34 PM
>To: will@kernel.org; mark.rutland@arm.com; robh+dt@kernel.org; Sunil
>Kovvuri Goutham <sgoutham@marvell.com>
>Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; linu=
x-
>kernel@vger.kernel.org; Bhaskara Budiredla <bbudiredla@marvell.com>
>Subject: [PATCH v5 0/2] drivers: perf: Add Marvell CN10K LLC-TAD pmu drive=
r
>
>This series introduces performance monitor driver to Last-level-cache tag-
>and-data (LLC-TAD) PMU which is an intergral part of Marvell CN10K SoCs.
>The configuration and functionality of the TAD PMU is covered in patch 1.
>The device tree bindings are dealt in patch 2.
>
>v5:
> - add prefix, type, description for vendor specific properties
>   in DT bindings (Rob Herring)
>
>v4:
> - rebased on kernel v5.14-rc7
> - eliminate yamllint errors (Rob Herring)
>
>v3:
> - rebased on kernel v5.14-rc5
> - disable sampling events via PERF_PMU_CAP_NO_INTERRUPT (Will Deacon)
> - convert tad pmu bindings to schema (Will Deacon)
> - replace tighter semantics with *_relaxed() accesses (Will Deacon)
> - use PMU_EVENT_ATTR_ID generic macro (Will Deacon)
> - allow cleanup of allocations through devm_kcalloc() (Will Deacon)
>
>v2:
> - rebased on kernel v5.13-rc3
>
>Bhaskara Budiredla (2):
>  drivers: perf: Add LLC-TAD perf counter support
>  dt-bindings: perf: Add YAML schemas for Marvell CN10K LLC-TAD pmu
>    bindings
>
> .../bindings/perf/marvell-cn10k-tad.yaml      |  63 +++
> drivers/perf/Kconfig                          |   7 +
> drivers/perf/Makefile                         |   1 +
> drivers/perf/marvell_cn10k_tad_pmu.c          | 430 ++++++++++++++++++
> 4 files changed, 501 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/perf/marvell-
>cn10k-tad.yaml
> create mode 100644 drivers/perf/marvell_cn10k_tad_pmu.c
>
>--
>2.17.1

