Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D61B3D52E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 07:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhGZFAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:00:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:39493 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhGZFAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:00:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="234015922"
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="234015922"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2021 22:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="455667720"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2021 22:41:19 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 25 Jul 2021 22:41:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sun, 25 Jul 2021 22:41:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sun, 25 Jul 2021 22:41:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffTYt/tkTS0m3sPF4fJA4D0CJ7rKKscpW4PJaEMjRcPNaf4wvc3qMiCp24KuitnNnpOSjHYB7eNevCQ9d/mR9YezdKOODeByUWzMDGmve9yk0ttByZoH/+YSG7pmZMrAFmKPCiuEjk+twxrTUEFCZF+CGR+YTMfvPELc46ZQ0s5MDhfmnOehLFOyquTkW20VDVNzDpBA+1jdjVDcTb52R5tDJHa/kKMGB/Ao4i4fJDMw7ld4JzMPPk31fiXzIZABFSgUQTaVPJsjKPFLEE5hQmbYQLSDX2mIMwlhE/Fg18coT31mELwBB1iJukwHwEUzOs44RHyI/4Gsex0JY3MbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ullfl484Kb/iG/pyMzlG14eWL9IfOoK+/+xZun6CNck=;
 b=byQa6Ykx5HvF5gQPjdB8q1EYcV1PMbIRXlSGuFXvbmu1c/0T/FqhB2qJ+rjoLPfJI2KECEGnz/fjM4ZsGslFqUrR6gHNAIabbCRJUj/Q9ZLeuv+mGxMyjObOeyn6P+MZthjrTUT0f+4lJXzCK4YPpbgIpT7byaq47n2xezAia/IillCxPSPwuY07iufr/Gz5QkrF+3QUTi1uVg3z1evKcvNzdGMLUsnW+9LXjZ8pUHB1XUrSd9FpezKG6vTRosndX0CwJh4ENWIM4Ni3HkUfAvyEL+AxCFOOV4IXrZDQntP+BVWVF4JMc4oe4HKucoI4w2CkhQv8NGtaBnHxl0cPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ullfl484Kb/iG/pyMzlG14eWL9IfOoK+/+xZun6CNck=;
 b=MtQl6DyIFg4Gc0PANxungh3rIJHQAvm42XOSRI/t9ZNP2GbrgI3v40tK3OSY4iyFj111LUrnWYnqZfxW7i13U7eYRFo1NZGj/1YaVkOrgmu8vKGpX5BRKNgBkHqaqZ8nh9L5Smmhc2p6pBDdAb/7JwGP4bvkQbP5dVcOHMi8oLo=
Received: from PH0PR11MB5174.namprd11.prod.outlook.com (2603:10b6:510:3b::12)
 by PH0PR11MB5062.namprd11.prod.outlook.com (2603:10b6:510:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 05:41:17 +0000
Received: from PH0PR11MB5174.namprd11.prod.outlook.com
 ([fe80::4c03:2c62:bca9:f467]) by PH0PR11MB5174.namprd11.prod.outlook.com
 ([fe80::4c03:2c62:bca9:f467%9]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 05:41:17 +0000
From:   "Rajendran, Jaishankar" <jaishankar.rajendran@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "joelaf@google.com" <joelaf@google.com>,
        "Mallikarjun Chegaraddi, Raju" 
        <raju.mallikarjun.chegaraddi@intel.com>,
        "Rajendran, Jaishankar" <jaishankar.rajendran@intel.com>
Subject: Core Scheduling - Concurrent VMs
Thread-Topic: Core Scheduling - Concurrent VMs
Thread-Index: AdeB33R2eDlXqczGR4+1VLBjFF8POQAAHaIQ
Date:   Mon, 26 Jul 2021 05:41:17 +0000
Message-ID: <PH0PR11MB51748333769D9002912FF63C84E89@PH0PR11MB5174.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec0017a6-3238-4ece-4684-08d94ff7fd64
x-ms-traffictypediagnostic: PH0PR11MB5062:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5062CDAD58E8BC0879DAAA0284E89@PH0PR11MB5062.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zQONOsKNJ7+BMsoYy+oTCZ5BPWoeN71vaPwprA/SJJ4HSrRuWm45eUs65MyI5Pc8CvzDDe9SKffiiVviXTUcZ3/XrSi0apbtnmaDF6hDrw0Sye9dEl5muTaIuA4unny2QOlBPVYkrdiWZM0rnEscDV71OYxzse/38Otl/SDfx/jwq4896NahiDTSFfoVWNr5lLYNfJOBlDHXwQu5ieiChGgRM2zrMk1e2trZXkBeGDWgtEAU1PIpf0FFPuOgPapqQupiSx3x/1umvaT/pQtW0g1arjs1Z9cPUZQXTJAMLye4CY8w2uQTZK4fkalxcZl3Mn3uIFTO5y0E5eINNnkmECKXIKPXutsyIVaG0GSDekrJbu2LqycDsqC1pTSpUQLRTX+rWEz48LJeyyH+KU5vw2ymXh15/l4jRQgOt1u2W5KFU8+oWQCiszLJqMq3Nw3EumaXliRkP6MGe/vJ7I5o6hBM9GHm2iS4NbMyM6mGHddCFkCmjc9TiYUeqp1NdEolsjwBz/DOAw7vmM1f8rPqZA/A5R8Br/NLZcgVYEo4uufCWdkLvKx430/5rn9p5c96Xsc+QJLr+lDYHGtsF+OLJltNmvtXRc5CKxmh7QAIT+9QIW0JmnvkcND1xzKJ8AiEvZLtvfHx6kBE5eabSyEIESOrbw/exSJBTgOI/XvyCUrnCVpWmP2cFlpzafTGJ8N2mEzetrV3x23g4s7BJtUydEGqppSg1T/uQwgRMclS7Zh5r16IF4D/80CszW1gyLjeKhKTttbseoApin5nHofg0DNkvD4fRt4IdL/A0OkIovs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(55016002)(9686003)(316002)(83380400001)(122000001)(8676002)(966005)(55236004)(66946007)(38100700002)(7696005)(6916009)(5660300002)(2906002)(66556008)(64756008)(52536014)(33656002)(66476007)(66446008)(26005)(6506007)(76116006)(186003)(86362001)(54906003)(8936002)(107886003)(71200400001)(478600001)(4326008)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mIcJDC8Kf0ErjIf+02ix+bJNxbbt5le31SQyKoot3gGdilSo3rXS3tVJ5z?=
 =?iso-8859-1?Q?8cE0bzDr5d10bzoHDLvjdkguWAgm5tSDYBfez0YVCpiryA1TzcgYjSB7wy?=
 =?iso-8859-1?Q?vFjAf0yncpB2z7NCAoY6cK/cnCybGQBLGaVU0Q9EwTseF8IrGpJbBOSu9P?=
 =?iso-8859-1?Q?NJa2PgOGynapZob9oKmgrb55iZMWsUmQjeleJdRFbpf0fgOaYjS0VQxq9X?=
 =?iso-8859-1?Q?667ZE9kc8dmqJzhAHeJa72MK528sF3ChB1qmnADC1NrtNGtgSvM8vsACwc?=
 =?iso-8859-1?Q?OgIoDprEH4/lfUzDUyIa0fAQxICo3NPQOt79RK/FFp5TrWwu1X7RojfT33?=
 =?iso-8859-1?Q?W1wnvEB8GhK2JZxVGai+VP0u8ywFJRqkS5F95HEJCyDXL6zSKHOJTjEaCN?=
 =?iso-8859-1?Q?It7BorDUyazkFPw4ck8nokmjdh6oRJmI9qlDLONxv6qiRSqkAq0Zmsr/6H?=
 =?iso-8859-1?Q?3RiofrKAQUCOfVcuwMhbBhMzYaeoN8gJUFSRvICbaIxWEfTq0tDSDOMLII?=
 =?iso-8859-1?Q?Poy0Bvo9Ngs7Hu8Lq/y2IBD6AqhuOgtqbm+TE4Mq+t754aasLlDI33mRJt?=
 =?iso-8859-1?Q?YZ17wFtNt+pQaMTnL9vF1ZKZ8hAr0o+L2XjqJhmgyJMooVjx0p3Dfrcgx4?=
 =?iso-8859-1?Q?/uOL3NDHfRplmMr/R/NBp/3EMW2f2AeL9GY0/+fPEeBYYDVmVP+53gnXnk?=
 =?iso-8859-1?Q?lz3G08ozRIz7e4dQnyx4Oakf+MqTOQHV4je7yNH8NmyMRJ4GfduW5H/4b8?=
 =?iso-8859-1?Q?RY4kpaQMYmYxF3eJYbWFZ12euARY3dgtSxvQmYyAYvwvzlDBlDshTODjG1?=
 =?iso-8859-1?Q?SUUjZENKyuFsBkLTuAVG8AYLLRJYUr02tpauwAtT9eL9nT5uj3k/KD9wR5?=
 =?iso-8859-1?Q?zQ3HGsLdGw+vw+rrhEyHuZL449CZTQUqovepT2Lqa6gWRnNaU9lQm97Zja?=
 =?iso-8859-1?Q?lEx3MsLawjNE/gzat3gwULtbJ5MVvmPLBYMiOWvFiVfkCMekkqZngeC5K8?=
 =?iso-8859-1?Q?oMk71UgrjqbzB96KyzOTofA1TjfcZv2aW90/kbiAQYygj1gw0R53s+wFGM?=
 =?iso-8859-1?Q?t2cYP7JgnUNgptyup2QEWzE2Wj+tCX1S8tEDqIxglO6ensdmz9ZewKgkW3?=
 =?iso-8859-1?Q?M3SL69+tWTqGrG0LWj/opUkyS72iQK8yzIXf43+g+SZJOdh1jDrCwuaMS3?=
 =?iso-8859-1?Q?M3K0kMvrNMIcYGEySGBcnTBhUbWzUmZ+cDGTZsGj52h4ShQrPslSlTJur8?=
 =?iso-8859-1?Q?uwzbyq1y1+Ae0u3dvzta2y6+TM/Ot1Wp0uouPg5FqXFp2YzPPMFupHbNAr?=
 =?iso-8859-1?Q?YmPwYSPSIORBMXamXIMI4hZs8YvJsslPCQVLMAaGQLPTXSNTuYZcWRSuWQ?=
 =?iso-8859-1?Q?oJF75b7zw4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0017a6-3238-4ece-4684-08d94ff7fd64
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 05:41:17.4736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UD58xY25B1mfo1pqyo3VeKEDbbLEIIY7JV8e6l7pqgqXZGsXno0OfNRuF4gI+ZQpkPITA/adteLChhzA8uw4LpUbehKh/McKP4bT/dfyOuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5062
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to the below experiments performed using Core Scheduling for Concurre=
nt VMs and we found the benchmark scores executed in different VMs are=20
degrading after enablement of Core Scheduling. Both the host and guest are =
enabled with Core Scheduler

Environment:
++++++++++
Platform - CML-NUC - i5-10600 @ 3.3 Ghz
Core Assignment for Host OS : No .of Cores=A0=A0=A0=A0 : 4=A0=A0 No .of Thr=
eads : 4 ( i.e. 8 Logical Cores)
Host OS - Ubuntu 20.1 with Chromium Kernel 5.4
Guest OS - Android OS running as VM using qemu/kvm with Chromium Kernel 5.4
VM's are assigned with 4 cores and 4 Threads (i.e. 8 Logical Cores)

Kernel Config:
+++++++++++
Host and Guest OS Kernel is enabled with CONFIG_SCHED_CORE=3Dy

CGROUP Mapping:
++++++++++++++++
We did follow the CGroup approach for Core Scheduling based on the below do=
cument
https://lkml.org/lkml/2021/1/22/1469=20
=A0and configured the CGroup. But not able to find cpu.core_tag file in CGr=
oups?

VM1 (Android OS running using qemu/KVM) is executed and its default cgroup =
is changed to caas1
VM2 (Android OS running using qemu/KVM) is executed and its default cgroup =
is changed to caas2
The changes are validated using htop command.

WorkLoad:
+++++++++
GeekBench 5.3.1 - Multi core Test executed on both the VMs
=A0
Observations:
++++++++++++
As per core CORE_SCHEDULER documentation, (vCPU) Threads of VM1 & VM2 (belo=
nging to two different cgroups ) should not be scheduled on the same core a=
t a given time.
But we observe that vCPU Threads of different VMs are scheduled in the same=
 core ( Used HTOP and ps commands)

Benchmark Scores:
+++++++++++++++
With the above changes we are seeing degradation in the Multi-Threaded scor=
es=20

Without Core Scheduling:
++++++++++++++++++++
GeekBench - MultiCore Test- Concurrent Run (Two VMs) - Performance Gap is 2=
%
With Core Scheduling=20
+++++++++++++++++
GeekBench- MultiCoreTes - Concurrent Run (Two VMs) - Performance Gap is 18%

Pl advice?=20

Thanks,
Jaishankar Rajendran / Raju=20

