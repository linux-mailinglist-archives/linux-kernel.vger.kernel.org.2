Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E673B775B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhF2Rqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:46:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:17851 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232308AbhF2Rq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:46:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208239557"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="208239557"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 10:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="558018225"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2021 10:44:00 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 29 Jun 2021 10:43:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 29 Jun 2021 10:43:59 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 29 Jun 2021 10:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjyKzX3kEtX6RL1Ye8OKsgmRH0D89ZQmvp/dU2z6JgUNWzQ51OLvNKd03pC5DBiyO4Gtr2lteBzek/HJ77ISqpyJP829J47ip4QLnAIx0fSUIvw7AZH5ZRbcMi4Vv1FplDRqHnwLE2e3hwRuAmHOEknAXUgscIfc2VTq8tzsfUhs3N2RLOqa4LsJfyWiGEL4er85yMBMophjqnhbdMjv7koPaqsUPyrCavwrignyNzmDFqDOYYRpwH9H/2pRz5z2IoBLnI/SJSLpzkUQNBYxd0R5aIyt4NF6v80VBY3XN6Mcuxnns3TuimsllZEHAK23U7qJAhXH3hHEfVlk+YE2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHfycwYNQvLObLUud3Hr0YZZmnwIApr/BqKfAYWLZ/I=;
 b=BC9FcWJZl76ZbSMzHUdJ5pqhxM/Yt011BxHLEDSPYYFMm3JjGFRGCxibwOqt0ND08g8wwGEtMEHbqC5GoMq60RlminMxi9t2m8DoouHNqhCWzn37yA2p//Dc+hHvq2PhLHHZbovek737VzcbDtQj0F02katU0fF1JBmQnz1Rh7E00fpnX5cXI3YMdxRQrDdJYY7l3lgQshzqi3HThJ8cwhy6tZX0upq4MUxmeiulVtlP+KfGRtYBQZC1bhxkPaJplUtuiqV45H8O1JK8Rz4K777JHcQVxuzmAq0xDb57aZxklaAmnVK0uFWRqfTxt30OuKWFiTH7RdAjgVz+bjR0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHfycwYNQvLObLUud3Hr0YZZmnwIApr/BqKfAYWLZ/I=;
 b=fHTCQGad3y1hEzIs+4xe4pM8A8dZgalYZOd3FDfR6JBub7zc8tEZ+4mFQXkXvK5WwWYqEbU8B9W3lVk9LBdZ6E1txO3C/2gocVvAB2Vw+UvBDUGtIwv/xweAI+VYCKHxUSTOo3pVDzjq364GY7KjXzZTVudSA/ax2DF5/SJqTvY=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 17:43:02 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 17:43:02 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>
CC:     "Lutomirski, Andy" <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, "X86 ML" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
Thread-Topic: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
Thread-Index: AQHXUAs71FpA6GLTCUWvxGMv7m3G8KsW+QQAgAAdOYCAAAnJgIAAA/+AgBRYTYA=
Date:   Tue, 29 Jun 2021 17:43:02 +0000
Message-ID: <3AB6DECB-2A53-4EC2-84A6-0CACE44CFC1C@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-15-chang.seok.bae@intel.com>
 <af093744-6f68-ff51-f40b-4db234b363d8@intel.com>
 <872cb0a2-3659-2e6c-52a8-33f1a2f0a2cd@kernel.org>
 <36D0486A-D955-4C32-941A-A2A4985A450C@intel.com>
 <48e86785-838d-f5d4-c93c-3232b8ffd915@intel.com>
In-Reply-To: <48e86785-838d-f5d4-c93c-3232b8ffd915@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa3d4ed9-54e2-48f2-e097-08d93b2557e6
x-ms-traffictypediagnostic: PH0PR11MB5192:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5192C048B00C1CED427A4DBAD8029@PH0PR11MB5192.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: psShSTE/NhFs4qHP34YqkARdrxNMu/wK+LoQxv8bFCirvaX23+2UVduS+YQQVL9+eP2MB9T/HrSm2BrThbJH/K/DqBqRVHKd2KS4lNiAyXWHVP+xIR5IH0HMmJBc/NGphY5f7McyMslXXkCqoKeX2VcJvBhWdwfUOFiosf0DDAWxaEqFlNUqno51HGHc6TIINF4DVrCYT0by7c3zawlFu0SBH4KOHieAB7Hhmyjba11NlCUpmHJcDV1Zqj82FKixq/HpKre4IxU4CR2QZissoDrEO17aOlimMK2pGptJhOf56NjNVa5gQ3S9Hyqyp67ibVS5hEIgsT7AC7wFRDxRXuonaWPDBv6jnivcDxLWPqwwGsIwu4dIUhtkk3ogWM6efcrslD+dA/365peEA/dryiaDs5dXP+rGAjQorpPPZ/Q7d+LLM2Hv9vtNdC6garMn0/wre3d45aDmWvwFO+Tm6vwmS20+ZSSvK6KPPNMyZT/IeJMRozg6hhDrl79DauIHuJjp9ALlAke8rxrDH4GE69iPdELgIujBoPq6ieI0SNn6dxihmq/ClhZJv1Xn8W0jZCfwzqRu9+K1PDTSES9mqUO9CuoEUE4uVyMK8m7MeF/Lx6qAw5jAEmMpWs1oJ1A0r2yfTItbhLmk+P6D0M+MP28iITCi/NGNzT6H9/+Qw0s0moTartNSScxqCguBadOuv47nDDNjVGP4KV0n575BQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(39860400002)(136003)(5660300002)(33656002)(8676002)(76116006)(66446008)(4744005)(6512007)(66556008)(83380400001)(64756008)(66946007)(71200400001)(6636002)(66476007)(8936002)(186003)(26005)(38100700002)(37006003)(316002)(86362001)(2616005)(36756003)(122000001)(6506007)(6862004)(6486002)(478600001)(54906003)(53546011)(2906002)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OHpTDO7an0X8tKI+PpzJnfeMMBHz4YjQ4QzBH1AjtnWAqFA8uqILdI/qnKIH?=
 =?us-ascii?Q?KHFJJmI33Sr4VkZlw2aMYyDMLLBWyCqbmRWTxJjw8WcPZX3JCsVifK4mJ8kT?=
 =?us-ascii?Q?r5kE5ijz8EGtm7F/fLizq4m+NPS1mO+PK3N8Kt9mmYlGJyy1faiK/DVXO6/C?=
 =?us-ascii?Q?PXmJ/bqahVw5nLIGoUcNJC1/8NrernMJdryfIJ2Mj0Cxe9pwGolpvZ0d568k?=
 =?us-ascii?Q?tkLvYXhrbLGtqLjX5bz5sRH9z+AnkbQRxF3aIi18JyGTg4SsNZYoFNPgnH+3?=
 =?us-ascii?Q?pjjjNrAMrzagI2ZkcHyK1WORqb/HwqNTg2pSN0l5X4xLvDVUAXgzqE+1a+3Z?=
 =?us-ascii?Q?Oz+xXMYpf41dTqn4D6Fzz0ap5BBMSdPHhYU97zOeojYOBuDVm7JV/pW5q1dD?=
 =?us-ascii?Q?p6BuJi2hkabDWOz2BeRQz/gnmyWTg/SiQcLeZluGNKor5OeaOl/gZNIr8Was?=
 =?us-ascii?Q?2vnhql86+VZHhOLwiLKqF3fUrbmrOytlOWwvyE7H1WUC5/7Zj9lqq+c9AO0T?=
 =?us-ascii?Q?6g5Ie/IpXW+6+C31uQG9TU8ImOsi8p2FnXEKzzuakbeOxHKXWLB/SmXE/5qM?=
 =?us-ascii?Q?CUfACmlmmqC/1amBJZ54VhTbEFAAqbCw/iJfXSqjjHw4LGNZ8fjTspd4HY3p?=
 =?us-ascii?Q?8De6mmxATvL+IHTrr3A3AzwKLAEHwdU39mGYZjAIriOQ270amPp9GWLMI/Gc?=
 =?us-ascii?Q?GPvHSDwEHWyFQJFPUoIVQexoPWY6y+fKJr5/GmABucqlIe7KVuiwvUdhnANH?=
 =?us-ascii?Q?LtyeXt2KGhUQR5xoPCG3XuyPh/oHmFb3K8PRYvAve0Tcw5F75X2xWQnMaLqf?=
 =?us-ascii?Q?Q/QzYeKyJsqJfNBSuNoZx460AZVnAr1SHNL35U/oH/Y2zBqZDzEQxyIjl25c?=
 =?us-ascii?Q?zlcRUTu6oPvBIvYy5nf6NQpwxjEymrG7GVc4JyUBTtkmN0Xxfsw1QqtyKm3m?=
 =?us-ascii?Q?YOwUJ1/fqvDvmxNUkD74vIUeAD7yZAmvEOwbj9qSY/VoEMPAfsrNHDYWjZoP?=
 =?us-ascii?Q?m8+sp0jUjPL/ZK14jW15Xs9fDXU3803j7tdmIbmuG9G8/HTdIrbQLkV0hv8X?=
 =?us-ascii?Q?XTEJWobsxkqUYZ+Yll1mdYacLUlTxgNEvjhPVBmb9HsOb8bKxBacHGWJVnBF?=
 =?us-ascii?Q?96F0qqVFgx+jecvOD+yg+ristFXe7Hn8EAgLpwGtbfDBPd0CREPpk4nxq5w8?=
 =?us-ascii?Q?gAULgfItGMXKSd4J6JSb0c7eE+K5enK/GtrdmZ0Cv+ZyVPl0lL3ketJXHXck?=
 =?us-ascii?Q?WRGggbpOXvLJrX3tROA6JLTsh/mYv/ulD262FU58mMa6wwzkQlAqmohLUJYs?=
 =?us-ascii?Q?x+CIP4UuG1X4SivRxiF+VOyZFZbed52vmxMOn6UGak432Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EC7020730A7E94A8CA4EF58EB518ACB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3d4ed9-54e2-48f2-e097-08d93b2557e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 17:43:02.3137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjjKNMRZPTmQkTZjkt8j6fCnmoua6FXicEdhdfLkreDe3yN0gAl1yxfxtbIsODc9bB2ypKFzrVLAY1YySD4juTXVk0XDObxk6aq0w5bEtWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5192
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16, 2021, at 12:01, Dave Hansen <dave.hansen@intel.com> wrote:
> On 6/16/21 11:47 AM, Bae, Chang Seok wrote:
>> Reading XINUSE via XGETBV is cheap but not free. I don't know spending a
>> hundred cycles for this WARN is big deal but this is one of the most
>> performance-critical paths.
> Is XGETBV(1) really a hundred cycles?  That seems absurdly high for a
> non-serializing register read.

My apologies -- I neglect not to check the log immediately. XGETBV(1) took
about 26 cycles on my test.

Thanks,
Chang
