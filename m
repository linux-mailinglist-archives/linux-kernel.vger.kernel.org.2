Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815553C69A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 07:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhGMFLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 01:11:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:19245 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhGMFLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 01:11:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="189781783"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="189781783"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 22:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="649141494"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jul 2021 22:08:55 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 12 Jul 2021 22:08:55 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 12 Jul 2021 22:08:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 12 Jul 2021 22:08:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 12 Jul 2021 22:08:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXtJlPjNOwytOT625r+LjQELkO6grMkDCKSGkbf7q3HgvymTaFJ+ZiHsLtiIU2KJ93aCg7ROMb5jXT5nZQtTY3FdDO0c/el8bXCy1Cu5su2YBVhiqR3xqbQrmiJGUmw+oaGaaYNFA2Nx19DbQPh1wqd2L0XHuECTVWfEFEVZqlH3l2BMFqc97bYcFZjaVsHUNGsUDBRcFPMZ3yjXOYEjY9C6TtVdKzJfJVS2QJBuJNKmRM8JdqoGML6zwZk/GfzfwFO/dHRRB5pCl5kHYDDWLeNwdqxwejQ719YL4406dbeVfa2Ks7hZuR+wx6+9+Ee/BB9FTR5fb833+i1TTT1Ueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGiSPI/P8V1ExO4qr5IjwH68kyxkoGlXid0t5NoNR9c=;
 b=khulrbZKAXAnhcs7hBNdSQnSowAacV7iHQIB0PIfxY3G7706ZhImF1BNbw0ZdnzjeJzNwDDbqOcbUDnAuvRV6Z0GGxQZjwDMh4yI/I1wWbRgoWLM0UxLVNyAJ3RMdIg6aVUzSoXIUD2jXjmUfvNNXVxWROOWLpc9/aO2YK3PACasdbQTVLrioMGKkZC6IvPwlVa0oWSLbS+M2f7Ia4GuxqgaEfiuGnwEqLdF7fldyZAUom8U+BYqS3GBZ9cSZdEXiSygepB1Hz+rgtrSVxTdAiFlTFSbwhPMjLkvZ0YBJxHvudccN+PxxgjouesxeU+Icqibn7jMW5OE82dUwcprXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGiSPI/P8V1ExO4qr5IjwH68kyxkoGlXid0t5NoNR9c=;
 b=YKdo62GuIIZjQCzjnfQeGtZcljz/EQRl116bM8tvacap5rCADm/AKJ4VsyEiOSuqBzGfRcUO9zEfKc5KLvq5gwYUnja6Ah3xh3BcVGYTjQduvMrl6oBoOJoivJwPi9gA6yWl2h90/TZrhbl7q9yrDphCoVghv/hSKBTZ801knBk=
Received: from BYAPR11MB3128.namprd11.prod.outlook.com (2603:10b6:a03:86::27)
 by BYAPR11MB3494.namprd11.prod.outlook.com (2603:10b6:a03:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 05:08:52 +0000
Received: from BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::f86b:ec66:5f4c:b1e4]) by BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::f86b:ec66:5f4c:b1e4%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 05:08:52 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v4 0/2] Add the driver for Intel Keem Bay SoC timer block
Thread-Topic: [PATCH v4 0/2] Add the driver for Intel Keem Bay SoC timer block
Thread-Index: AQHXa+TYX4Bi7dy+BEiiludNzO07FKtAcfQA
Date:   Tue, 13 Jul 2021 05:08:52 +0000
Message-ID: <BYAPR11MB3128ACA500E6DA8405D2526FF1149@BYAPR11MB3128.namprd11.prod.outlook.com>
References: <20210628061410.8009-1-shruthi.sanil@intel.com>
In-Reply-To: <20210628061410.8009-1-shruthi.sanil@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6acea17b-9ea9-4fef-dec9-08d945bc4eab
x-ms-traffictypediagnostic: BYAPR11MB3494:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB34947AEAEBAD69B0A260CA94F1149@BYAPR11MB3494.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 84ILmNXtQdbDOKjQOVLNFhzWdjFVx/OuaPlDpOadb3OHPzPI5mKNKHYRg9BqcGkkQcLraIoGOm/6uyMuo8qYXFphKD+xq+9N4RUCqMvt/tt8vh4JTuJAWMLaTFpCe22cNZvEqr/EQqZh+51nfCAM9aeSZ9zu4+9NXX+lKuXdCbiXJwHFweKwj6+dKMX29ePjUxTKzkRPuRhpk6qGhkWoRrD7yW5mjdGElOybOvKraFCloi0UokgoGqCBdFINnenrqHRPUsLId3o+SlSve67zF5xuHwBX/tISS5PhZVlg2Ar9G+kWFY1exW7FFc+Odk8p+idM0tsOzchcJ4+2Th5Ujh2meKlwBix2YDUTwjlQRLaDBlJ8crRQtN/E4kqEWrQBQdZNVhH+dVNtBwY7Dgm6qv9EY25ufw7cOU+htwfkJB2mbilDfIr8v1y1ShWlVs0IoO/JeJcgkJU1+J03PUetcMwnoY4Au5L28pUNWhHNyJKWNRR2IS4ktq40+O4UyMIu+k9+IrHqbhM65at/Rbhjda238cc7d0hQKWEYYbXpI5HsapCcybjEYMsWl6vzyuxpgzT9cizESjXaQzUFsy15QcEsz1HPZHCA4iQI6FQ8DAouBfXzvkxenrk73wOZZgcTyv1f5DDWlr6h2ze9iy/8dQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3128.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(2906002)(33656002)(8676002)(55016002)(9686003)(71200400001)(54906003)(316002)(110136005)(7696005)(8936002)(4326008)(66476007)(5660300002)(66556008)(52536014)(186003)(86362001)(76116006)(66446008)(38100700002)(64756008)(26005)(6506007)(83380400001)(53546011)(66946007)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aTA1Puf+c+oqgqf8TOlBP1jLjmxHCNPL3pFrYY5M1y6eodK5lUiDHlYpzsX6?=
 =?us-ascii?Q?M+nbNK1F4CB4gdpucUJtcf8w4EKio8CmWAJgRRn8gBRX3MrxeqDvagGrN8Hv?=
 =?us-ascii?Q?FiWY5fKpx+Ow+XdaZQ20zM5fYOHDmhY4dSs3a1SMcHlYibkM9c+YYHsdFgY9?=
 =?us-ascii?Q?ToTcnj73yTYBOLMIjYQazy8hYf0qgJY3gzCSsOeEdAUWVGTNQ2RhJTw00xMq?=
 =?us-ascii?Q?paNtuZbCX4wuH0pN5YqtkogvNxLn9Xkrf1T2DgMbcb9MZMZ8Qw7Sd6PUyUFK?=
 =?us-ascii?Q?UInmw5BqKP9yWjQEjYI7Cs7c+yM9iOwfG/narQQyoJoDHMu7kNdG1o1V2tBb?=
 =?us-ascii?Q?JpRDtagYF63kcFsrSsEOliP+rCd0+Ha/VVE26cpUQNRbKHWo7L4/CDQZAAWj?=
 =?us-ascii?Q?MeusGV5G9HinG2Vmm1hI/0LMoxFvXPuyqdJHRSfXWUFdhezETI6HVivFPiia?=
 =?us-ascii?Q?gDYRadTM3CFrzPa137jNHEjXzLUguR0LlskzMMGwsGrG0vKrd8stzq2mrE76?=
 =?us-ascii?Q?jA9nZNJO3bibEWbDZq9pp/YvtbJtOHmEaQh7d27WqX+pWgEN6MGpgce008x7?=
 =?us-ascii?Q?IAcM6huvNzfBq5oylI9x7UAZwk1TjHiYDpfYI12uCfz2cKvnXYrrv019aGxH?=
 =?us-ascii?Q?jppcK98kNweif/cAyB86cl1A/LV8oN0mDgxndxeBlzNZ9Jx9HlTub/bzWMzH?=
 =?us-ascii?Q?yP9b/LLYICqjQnNfL+Uzq9cz10i2K4i//E7ZgDw6vD6WDHY2AqwV25EnBclb?=
 =?us-ascii?Q?UxJVyX/osLswE/Y7mCFn16sxnHOnonbtyPIY4jV88uDz3GX0YAIy9nWPb5cT?=
 =?us-ascii?Q?Y9WflOl2z9YD3qZ1XFMNHBa0WqRAlyqA5DqfKse2GYVeHV54rlF2jBtTaORS?=
 =?us-ascii?Q?P0ApEtYXFMSJ3wmekNFTidpB19q8fxQx28vqG3ww6Y1AzJUnri8Xoduds4lp?=
 =?us-ascii?Q?dAQlLx5baD2sQ8WWY3IL6ShmH8nsJXF97UbUF47uBofD2MOOR1UsolctUH0r?=
 =?us-ascii?Q?riXxJDTXLsrbrNJBrOtMZpLw5mHzZNVB9xOM/9AVEYNnvXL6fYJFs3vVxA8Y?=
 =?us-ascii?Q?WlFBfVjuP2bEh4gKbd01TvszWP2gIEv9NftIiYZkldVE7xMJO8Zp1/5JrZYW?=
 =?us-ascii?Q?CvN2Ph8PI3LZSovz1gDfESYT5ApABYKsTW0dIFBpdMHuY0vRB+efJL7FtICP?=
 =?us-ascii?Q?A/3aDHwVFujn79KrWooExv74HwdLTl7e/Kno8dBOZAULdVoDJbw/yRxsD1UY?=
 =?us-ascii?Q?V/7rrEByahgQHg/CCzwXlxOvBfEQsZCwQPwYv/dFfOD3tqWrVYlTCGZpoFEs?=
 =?us-ascii?Q?WyMGs6zm7+B6EPTOHwVpMOL/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3128.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acea17b-9ea9-4fef-dec9-08d945bc4eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 05:08:52.4431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7y8xCJ3YT55xezYeJjRv4KC1Rerpn/V+LDerdyoJO3d1Lh/vASSIDKlPK9E4s77A6JwT0tBi4ygETWTUI3wH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3494
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Reminder!

Regards,
Shruthi

> -----Original Message-----
> From: Sanil, Shruthi <shruthi.sanil@intel.com>
> Sent: Monday, June 28, 2021 11:44 AM
> To: daniel.lezcano@linaro.org; tglx@linutronix.de; robh+dt@kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Cc: andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
> mgross@linux.intel.com; Thokala, Srikanth <srikanth.thokala@intel.com>;
> Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>;
> Sanil, Shruthi <shruthi.sanil@intel.com>
> Subject: [PATCH v4 0/2] Add the driver for Intel Keem Bay SoC timer block
>=20
> From: Shruthi Sanil <shruthi.sanil@intel.com>
>=20
> The timer block supports 1 64-bit free running counter and 8 32-bit gener=
al
> purpose timers.
>=20
> Patch 1 holds the device tree binding documentation.
> Patch 2 holds the device driver.
>=20
> This driver is tested on the Keem Bay evaluation module board.
>=20
> Changes since v3:
> - Update in KConfig file to support COMPILE_TEST for Keem Bay timer.
> - Update in device tree bindings to remove status field.
> - Update in device tree bindings to remove 64-bit address space for
>   the child nodes by using non-empty ranges.
>=20
> Changes since v2:
> - Add multi timer support.
> - Update in the device tree binding to support multi timers.
> - Code optimization.
>=20
> Changes since v1:
> - Add support for KEEMBAY_TIMER to get selected through
> Kconfig.platforms.
> - Add CLOCK_EVT_FEAT_DYNIRQ as part of clockevent feature.
> - Avoid overlapping reg regions across 2 device nodes.
> - Simplify 2 device nodes as 1 because both are from same IP block.
> - Adapt the driver code according to the new simplified devicetree.
>=20
> Shruthi Sanil (2):
>   dt-bindings: timer: Add bindings for Intel Keem Bay SoC Timer
>   clocksource: Add Intel Keem Bay timer support
>=20
>  .../bindings/timer/intel,keembay-timer.yaml   | 170 ++++++++++++
>  MAINTAINERS                                   |   5 +
>  drivers/clocksource/Kconfig                   |  11 +
>  drivers/clocksource/Makefile                  |   1 +
>  drivers/clocksource/timer-keembay.c           | 255 ++++++++++++++++++
>  5 files changed, 442 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
>  create mode 100644 drivers/clocksource/timer-keembay.c
>=20
>=20
> base-commit: 62fb9874f5da54fdb243003b386128037319b219
> --
> 2.17.1

