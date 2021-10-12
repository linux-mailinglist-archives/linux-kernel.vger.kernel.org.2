Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36121429F46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhJLIF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:05:59 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34396 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234809AbhJLIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:04:26 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C0XeQj028248;
        Tue, 12 Oct 2021 01:01:05 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bmpv4ukbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 01:01:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcsrXlvYn46Yg5+YDV+cX0FSRRzqk4GHZJg5skSdtoJNkH9fp5vk7n7U4Y+MK75EMGw67jo0MBTNgb/yFOwTdjYrDX1+aU0Uem7spqWfll9lclMHq2uHuFNU6Nn3xd9PQ7efE3+3ImOSIIrjR93A9BYa8SS3e5QflIN3h43YiW8acKTtQyMrZKE1LKeueA8xqOkCxHWtzckKKiVzbH/6RxagZ+GpMFnyFV+8SapxEIMlOjljYQQYfTKp3ebwIXLAKY6BCO+AWMQP3FCVYIKyX3TlVzQI+Vc/eApRXBhCwoaWZIa5gywZ31cLDICC5ncrP7tn6n6U3/BiipywpYzDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccjmDVSbOgHrN6MuoDcmDD10wsD9kY+N/CkHN3ge8eU=;
 b=W5/+U6eNcR6mCLyPPiFbhKYpFWZJMhrdY9MVYGfYfq9KakXYRwP09bLh85MJfoAf/Z5qoIIUU30XaiAlBbpKV1GWOJn7wCCIxYwcl2Mu/1UjROsGYogBFpvBCFCnsMPau1O3KndWQJ4JLkKCELb4Z9LFEbewhgXlAgQGjEEDao3e5yO3LgCQZ2ArlQRZjom10K4a/QOaumlrTv+gqeyxeiINpDnUfybznH/BCQ1fxdQloMMp75sGUTA0W9cF1nzeQo5023Puc1DTxy4B3e0dqRl5sxbqXWVDOFCpzrDnJjALDA1WbYZmb5FuTV4Rq2ZojOIN5C7B88CcLYRh/8BO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccjmDVSbOgHrN6MuoDcmDD10wsD9kY+N/CkHN3ge8eU=;
 b=Pk8XaQ92+8DVRk60uqNvJZ1UIPcURvkSBoFPo0g2j05TOBysHIGOHV71MfwjSkyT+rQoy/GiZ0K7EraSmZOgwl/tORVf6DCyE5yvbr15hLkTrVF1SCABsKN47ziipK/ekROtfiziiNQkhHDyvj97Ta7BZnV7t9GO92Dtck0NKEc=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO1PR18MB4731.namprd18.prod.outlook.com (2603:10b6:303:ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 08:01:01 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::9da7:4d20:98ff:e441]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::9da7:4d20:98ff:e441%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 08:01:01 +0000
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
Subject: RE: [PATCH v4 0/4] cn10k DDR Performance monitor support
Thread-Topic: [PATCH v4 0/4] cn10k DDR Performance monitor support
Thread-Index: AQHXrd2PjHFr6VjFMUaBh2+kP4e3PqvPIrrA
Date:   Tue, 12 Oct 2021 08:01:00 +0000
Message-ID: <CO6PR18MB4465BC28C193E2CF9954B251E3B69@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20210920050823.10853-1-bbhushan2@marvell.com>
In-Reply-To: <20210920050823.10853-1-bbhushan2@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4b59a5e-5414-4774-c488-08d98d566ea0
x-ms-traffictypediagnostic: CO1PR18MB4731:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR18MB473126BB8F74F673F44936EEE3B69@CO1PR18MB4731.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AMKWJVMhQaBO57TDKzQ8SIZsuvwYTQRZPQSUhqSPfAd83LWVHQHAHHO+OPNbxk2AuScfdmp2cQuroR1i2vKVvvjfu9ScLD24nYPiNxizDu0fg4bscrQGG7XOGFxTN+HN1Ph0CUtddaA5jEUiQtmN6NQxvNwHGT2SwvtuQOuI7QF8GNs0pmfc8Jni+vgvB5+4Wp92DmSfXvq4fbocSRoxFquGgMGX6JrgyJJ/HZtW8AG4WhLPcFYK1FqWM+GP0m41XESZ058S5As7YIharXkpecM2Djsm00gUAbU7gMvJCJCl5Mpj8GQatOEILATSmZ4zahhYu55zrNRQyQEepxO06rtAgXe3fPN/FAUbpf9f7KS+pli5a6SMMg8pHzHMozPP0hrOMV34Yp4IIOvVinTJRG5SOUW0HSqTB05wIoaruVZ//uwz2kphScgeSJDdrxcRhLUtlyKFNnnSCOhLTAl2F688cZUOg0SRAd4LkuNjlO5AwBbfsIMSPzlTHg/O95EDQH9xdiYGbO1O/JJAOYfuAa0Je7SnNyNng119yV1U0DnyfDtD9voGmVGHnt1WTQnBGZl7czCrJRt425oaTirmJD20qyk3q2qiOptXRbRtBMSEVzUgY78Ta/s4jrFNHqy9Ujh6C0PkfFMzb3ECXtDf2Z8szGePP9aG7UkRv65fg6LWSRVlhob9g+pT1RiyavTLt7QI2469Dg0uf0YZqJXlbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66446008)(64756008)(66476007)(66556008)(38070700005)(66946007)(122000001)(71200400001)(86362001)(38100700002)(9686003)(55016002)(83380400001)(5660300002)(26005)(33656002)(6506007)(8936002)(186003)(53546011)(508600001)(7696005)(52536014)(2906002)(110136005)(6636002)(316002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?05s7muAlznI1nUWwLeUiK/S4c6Zw7Qv+S1g6bYzae37nBZH3wd7l6vQlpX2U?=
 =?us-ascii?Q?zdClrqfDgMlj2W9gu2qo3J83s1XhB9HJkRoYQrlnqgJJIujY1pqERwv0ldxm?=
 =?us-ascii?Q?fO1dD3KgNx/agTpb80cdiHs7lGimgHYQc0sJZu70pqyT+RFkzbYwwIIJjZ4H?=
 =?us-ascii?Q?Q0D347ccnecrfAf8BDXoeVQ0awEY2aP06MPKhiHZaSGZAT/Sc3WJ7hqNkLPR?=
 =?us-ascii?Q?vT5b19c0Ab6WViZ8gpwNJrkrQ7FDAymoIR8Qo9TGOt6pEkEdvdxZhhDZe5bq?=
 =?us-ascii?Q?XM8lQx4Ff7tR5EEWB6YPimWjvfbC7SKqgm/SLw3mQI6HDE5k2yBl0pFTzW82?=
 =?us-ascii?Q?hTERZoKl7O9k51hBbUH1p2PVkY41Apu6NZpGMj2PdDbDovUvsMPOJ/oA7+5N?=
 =?us-ascii?Q?3eDngG+GnocHtoczAd35bFyORw81/x8/tJ80gaKIXW7lRYs97jK29LD+4aNh?=
 =?us-ascii?Q?2v5AJWUxSlxzl4PqivDNE+DULzsoCxXkrHbJHAFreCJs29Rc3+wNdfXGIfUM?=
 =?us-ascii?Q?2LMbftSYbPkrZ74kBm6lPvFdM8g/kKGv/p3fnP6/8Vas4icsGuuoVHNSpROU?=
 =?us-ascii?Q?RYN4HWWB53qNA24zqUdX2CoffsonGlV1bEtNfTCZFxrFWBkZ3Pb/7tmlgGn7?=
 =?us-ascii?Q?lEYrb3KMTRzEL0wI8GPAuCsD2CHQ04lIWjamd8xz/J5l9TTx2rMxj/+pnRxf?=
 =?us-ascii?Q?EaTDXVqYwBi/Za/KM99oadT0GG7iiMXqtkYN6Hc8aQbK6KpXw73l0ZqJSCxJ?=
 =?us-ascii?Q?9G95HRJc7R46LMXvEAf8WgAv8epE0R2TmkKpanLlMzhkLX+GlDzOeNhYpoYy?=
 =?us-ascii?Q?R/FyjWk07f9gg3hfcirB2Bd0uj4QkmBtsEGjUFMEMIxL1rzGdIq6xepe+NH+?=
 =?us-ascii?Q?3qyzbwWt1YD+71NaTBtYClHc4N672foWkjZoN2hYWEddhSXAd4Jd8YjhHkgI?=
 =?us-ascii?Q?tHFZMzHCCgWsPPj291sQCeRxJQkN6q5rKygDLM0InvtElziZOSymyysXky04?=
 =?us-ascii?Q?HoXbnBqhe7djQFh3hHlyu4f28dsWUbE84ykFSokrfPgQhVMinlGbpofVBmaV?=
 =?us-ascii?Q?ojd55N36h3ZVAg0zPlmx/PNOkk4rCRbpgL26lj10DlEmu2tz9G0b9yzkxY3w?=
 =?us-ascii?Q?tlZ75nSAERa7VMY2TzIq3Zl8A39315iTLtWKFrJrY+6uEdCFfiJpiCvRvmlA?=
 =?us-ascii?Q?H673T6bhEnyCYBWUUWiErcViQI0JgQu1yu7UpI9Q6p/L1CExhXTc1bcjJxCA?=
 =?us-ascii?Q?0OHsoCcQNTOsv79yCpVwIDv7S8S/ZgqhmBA39e23GxgKufegA5gAEL7pDFpR?=
 =?us-ascii?Q?1OLqPuBiizKUpopAJcQes6sF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b59a5e-5414-4774-c488-08d98d566ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 08:01:00.9502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7FNTNyTcf6X6mqBS4obrAgNi9qgzXpwwP/zpH7qQvlyUICkNfaYAV6LRxPV5B1I62/M90OxbfD7h7f03IlObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4731
X-Proofpoint-ORIG-GUID: 1of367NkmV-8YcfZ6jV3NR9iJZ25esVG
X-Proofpoint-GUID: 1of367NkmV-8YcfZ6jV3NR9iJZ25esVG
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
> Subject: [PATCH v4 0/4] cn10k DDR Performance monitor support
>=20
> This patch series adds DDR performance monitor support on Marvell cn10k
> series of processor.
>=20
> First patch adds device tree binding changes.
> Second patch add basic support (without overflow and event ownership). Th=
ird
> and fourth patch adds overflow and event ownership respectively.
>=20
> Seems like 4th patch can be merged in second patch, For easy review it is
> currently separate
>=20
> v3->v4:
>  - Added Rob Herring reviewed-by for dt-binding patch
>=20
> v2->v3:
>  - dt-binding, ddrcpmu@1 -> pmu@87e1c0000000
>  - Add COMPILE_TEST as a dependency
>  - Switch to sysfs_emit()
>  - Error propagation when invalif event requested
>  - Switch to devm_platform_get_and_ioremap_resource()
>  - Other review comments on v2.
>=20
> v1->v2:
>  - DT binding changed to new DT Schema
>  - writeq/readq changed to respective relaxed
>  - Using PMU_EVENT_ATTR_ID
>=20
> Bharat Bhushan (4):
>   dt-bindings: perf: marvell: cn10k ddr performance monitor
>   perf/marvell: CN10k DDR performance monitor support
>   perf/marvell: cn10k DDR perfmon event overflow handling
>   perf/marvell: cn10k DDR perf event core ownership
>=20
>  .../bindings/perf/marvell-cn10k-ddr.yaml      |  37 +
>  drivers/perf/Kconfig                          |   7 +
>  drivers/perf/Makefile                         |   1 +
>  drivers/perf/marvell_cn10k_ddr_pmu.c          | 756 ++++++++++++++++++
>  include/linux/cpuhotplug.h                    |   1 +
>  5 files changed, 802 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-
> ddr.yaml
>  create mode 100644 drivers/perf/marvell_cn10k_ddr_pmu.c
>=20
> --
> 2.17.1

