Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B433E4EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhHIWIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:08:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:10613 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232683AbhHIWIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:08:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="214819862"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="214819862"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 15:08:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="483751920"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2021 15:08:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 9 Aug 2021 15:08:22 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 9 Aug 2021 15:08:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 9 Aug 2021 15:08:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 9 Aug 2021 15:08:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM5EA5Hfsof4lidM6V/00QsIPnTz5Sl+rdI8BGIZGgGLQJwx7jf7zRlG6+OMvCb77LyC1bpdIkriKCvNHHGdfg5kn5MzcueaTO3mbQ79JWWMX51M1qjKXsK8e35SDLAILgyoO10bqarD70jm0+y1nPODyw7aZ3Gs7XlbbNCfivjPiVqcc7PHWkomReV9vJ6/lUMfgrfXDP1GXQ1/t5jFrGvH/gdpCpSWLag78wqPdvsTKiSXxgbL1VeXWcRHl/kVY4+yVXmPEfVIXBHNtMyL76Od1LNeb3Bkqj7iOJf+MnmR+J1ugMHX8MpjitprjbiYznRO770BPlG3lavPzqEV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7kPJEH4C4t71RkleKnjbksX/R+vN3Y0N+Bi1J6mNsU=;
 b=V+parHC8TX3UeBWQvoL5dRoYWEPTq6pyPIi0nMW6QZZ3/+hfGLhVu5OV+tevrtjcnaF+scSEpPi0Mpwd6B2/Gs5Clirt2E0KiXiaF0s7BYQYakW3F/SCK/QGTBKZ/pDdgZjd0FXyWPDAh4MbWX6GMybjIH6lHsk5lrmqFJ/ZGs/JNdh9jW1zqLwhj0ZhgHm3F4LHTnJwBkFx9aekpiQ3W+QPFzlkuv9AM0YncPE0fFQ1CviQbhu9SOTL3IZsquBpGE1wodSMZIb8mYZ4LdRfd6RA7nlzp1rhJAPRqT+bZUS1M1VrrvbrfID46jB3mGfKmJigbak6D1poDfE0HoWWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7kPJEH4C4t71RkleKnjbksX/R+vN3Y0N+Bi1J6mNsU=;
 b=BA4dz3Rhw9NgtrWClUTJ0QlK6spr4G8lCnJRvfjddaexDStNU2uhDBdcmOh1q61b74v4UcfpFObDuD663XjO0UGPDnYGO+aEvtBpYCemVSrEhNSIfEaLR93/s2vB8vtYhA9y7gPAkgJ4BdXB17ooZ3hbHwwV0l1ByaogDPsAcGA=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4934.namprd11.prod.outlook.com (2603:10b6:510:30::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 22:08:20 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 22:08:20 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Macieira, Thiago" <thiago.macieira@intel.com>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 14/26] x86/arch_prctl: Create
 ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Thread-Topic: [PATCH v9 14/26] x86/arch_prctl: Create
 ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
Thread-Index: AQHXhVR0BYy4P9XafESfiMTncJD6GatmuoMAgAUQ8IA=
Date:   Mon, 9 Aug 2021 22:08:19 +0000
Message-ID: <E9C8AF5E-E229-4BA2-AEC8-4289EF7428CA@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-15-chang.seok.bae@intel.com>
 <3718618.i2J648eyUT@tjmaciei-mobl5>
In-Reply-To: <3718618.i2J648eyUT@tjmaciei-mobl5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bf495fa-a606-42f4-9020-08d95b82327d
x-ms-traffictypediagnostic: PH0PR11MB4934:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB49349F227736826DD8849E35D8F69@PH0PR11MB4934.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UUS9U8o83MyjgMJyWrYATQM4zzTEYg/xRx70l9cDFetRSfQnHYvP3z7Fba/XDi9aLXlSbz/KmIAh3U9XL21Bx+q2E1uUTL/oHdqx4NTAHVwb2HegjiDz1gZyjz0RG+TufLBEUnX4ud/oc889rwyqhoNi9s2aF7fXnrxQv5JKlAEgiycI3EtHoBWyeEvxuKVAhc/rxz5D/LMv1TlKqFH0s+9x0ZhV79HsjQZzwKsDX+Tbys9fNL9G18zyRd2VDdsjf05NwT1Etdl7k96BwPqPJTKhpMlJ6/z+jcDFiRe7hDX5pli70JlRTDGTL1lijvqfgIeA0MbDTjkda2g5029dE3/VDTt/TD9hqpidyMYQItWYJwKrCSDN2kOHyQqga+v7tARPUXoF/UG4mSRw+qYj2UNDI7UD1UV4mwYj2j6EvxmZqWxzbfGB8S/NcCYwp1rW0tumbsDUJMBlUZS0/oGzP48RE86Ejosz09dsp1qhUg74kV77L4J0t3hpW5ac5a6iF4kjhN/IeHMzFWLRxOmTsiPxthRYoN94efCgupfGo/33dnNuLW4LtffBl3hr1AVudOQvN8JwI0aXFcJRVgrpJe726SL9EIs1gUFY5R68wG8zwAVdiDOYH8FySJhcIeAVwlg0qSxAHKiYYOqbOi30ynu1VC5I1qjGz/lkzhXefevGTsl0aw+fg1+vx3L0cWt8onU9EtQYNzKxviKcipydTmwycTyzU0QaMYJIsf3pyck13/CMmbOK2yMQ0Mi03j2nX16y6SCOHKV/7EIHBSnc+/8TlMc1UeqVtpwNEx2ubWe1hkCWfQ0cGuHAnuV7vuig+aJMFNleasIDwGr8EW6O02Afqt2HkZJO/rebc2LXZgc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(2616005)(478600001)(8936002)(122000001)(86362001)(38070700005)(71200400001)(316002)(966005)(33656002)(38100700002)(8676002)(6512007)(54906003)(76116006)(66946007)(2906002)(37006003)(66446008)(64756008)(66556008)(6486002)(66476007)(26005)(83380400001)(6636002)(6862004)(5660300002)(6506007)(4326008)(36756003)(53546011)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y+IpcaatHpPuwRM+OXRi+rluoiX0r7kyI0BMJ2dLyohiRjm8HhyVG9e757Wj?=
 =?us-ascii?Q?bpHEx8xk4ICxFhrYBdZy8i0HGy26r/wlE4DPNZSRdQPO3fBx7Y2XCdWhgLNn?=
 =?us-ascii?Q?fopmRqSlACv3BjyoGrg39/35SSLTkOP6/hNM+xs9DCQJ9j1t2qeG2QxbQdgl?=
 =?us-ascii?Q?RbQ+Ir9OpSkIwZuTE1Vdq3fd4DHY+8vD8KXS9iBSMRQii9mI+2RPB5dutKYL?=
 =?us-ascii?Q?csJVTPaS7+0HU0PWkhFOsT+yaGaIx4MrnqFda6Ncr7JtSAQADHr0A4RuYdtZ?=
 =?us-ascii?Q?MX/mRaVC9/ZFgYKuTslVoggApXID0B6pGf88RvI+PWzNJtr0AmYTI6OQKj/K?=
 =?us-ascii?Q?MY9Klq5t5n/g0t33DCIeTBq3N7yDINHEcco862ehgoGGk8uv7mgY3xZuc2GI?=
 =?us-ascii?Q?NEG9+IhjZhnUZ9DwsiOSa10KxAZfpwAmIG6VYM7lemjtAi+yR6BdGKeEbQo+?=
 =?us-ascii?Q?0BNKrPfeWCs2W5qj7c0S3Shl5n98HHNalIYxH13cbLST0OsnJgaxmJhaMHll?=
 =?us-ascii?Q?R+JqUp2dMHl060HQl744gj6Ys1j/593K17hvm1EXz8TNCe204smK7vxgLzx1?=
 =?us-ascii?Q?tMuAspU27nkNJGTCHu9lWoA9zfM1ggS6EJVg0dQw7f/zcpJcOfXvASG8clLl?=
 =?us-ascii?Q?Qn6fVE/YjaIRh9ZG9BN7d4+jgZC/a6COVo4gwVm8+u8dbzRdcMFdvgUz4NbF?=
 =?us-ascii?Q?8xYNhOF2B7RN1rQ6e3qB4NF5zC4pncGE7TwpZh7wkbla9+XO7sqDM/CDf/d9?=
 =?us-ascii?Q?8VCw2It4AovG9zwMdDye6jihajhxP832XxDAI5U1vkEN/hFu6HgbFwUArwVD?=
 =?us-ascii?Q?+FBuWAqjkIdMTINpXz3/uk2zqLwYh8tTF99+El3+9pNOJtH3o1g78AZ28kaj?=
 =?us-ascii?Q?skw1iFp51vCsdm2Z0lXKwJOQkB6MfEQJFO7TRCBRn9PVMboXrBqgZateofTw?=
 =?us-ascii?Q?TsDIjCmhfsCvAnZr3qHoILKNDWmuJRJT8gvOgK5xNNn2+0TGKjx32M/dzISH?=
 =?us-ascii?Q?5UKp6PfZaO1QUSGWvYBrMeS2t1FQZTtlH+qP5AHtKDnoSpnCd0JQ8T3EP4c+?=
 =?us-ascii?Q?OcULWA2uqMgB8fHjejomm8A3UGw1D8jo5wXUiYPSXVC+YgIo2lBtvgFncrsv?=
 =?us-ascii?Q?1HHAm3Qgfisp94ztivR0TgZh4h8gqZglIhZ8GmDbD7wS3fNjY+dJ6lFzmjzl?=
 =?us-ascii?Q?mG3O9Asjo8+IANyzWRaGZjxUGS14VyRliJXkIH4WzK+kq5s8MsRA0miLPUxo?=
 =?us-ascii?Q?+tP7YMwbVCEF9H4TJO7l1sf/JfxuYvXxX0dSaFiRu6Zdzvpu/qMi4nzsMKg8?=
 =?us-ascii?Q?1Q0Rlh9/nolf9XRcg/eBPUQe?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <232E6B5F1EC51D439C352896244429CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf495fa-a606-42f4-9020-08d95b82327d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 22:08:19.8550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imMiqyhhNzn3ccnFP4vrbk5WJM1sb1MPafJDh4AXJIPveGsXpAnMxI4PazM1kyZD34ysnpLsmSO/ioMJXHHNuCK/0c5mJ8qodFOQ5ZpvO/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4934
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 6, 2021, at 09:46, Macieira, Thiago <thiago.macieira@intel.com> wrot=
e:
> On Friday, 30 July 2021 07:59:45 PDT Chang S. Bae wrote:
>> +       for_each_thread(tsk, t) {
>> +               t->thread.fpu.dynamic_state_perm |=3D req_dynstate_perm;
>> +               nr_threads++;
>> +       }
>> +
>> +       if (nr_threads !=3D tsk->signal->nr_threads) {
>> +               for_each_thread(tsk, t)
>> +                       t->thread.fpu.dynamic_state_perm =3D
>> old_dynstate_perm;=20
>> +               pr_err("x86/fpu: ARCH_XSTATE_PERM failed
>> as thread number mismatched.\n");=20
>> +               return -EBUSY;
>> +       }
>> +       return 0;
>> +}

<snip>

> First the simpler one: that EBUSY. It must go and you can do that with a =
lock.=20
> Library code cannot ensure that it is running in single-threaded state an=
d=20
> that no other threads are started or exit while they make the system call=
.=20
> There's nothing the library in question can do if it got an EBUSY. Do you=
 want=20
> me to try again? What if it fails again? What's the state of the dynamica=
lly=20
> permitted states after an EBUSY? It's probably inconsistent. Moreover, th=
ere's=20
> an ABA problem there: what happens if a thread starts and another exits w=
hile=20
> this system call is running? And what happens if two threads are making t=
his=20
> system call?=20
> (also, shouldn't tsk->signal->nr_threads be an atomic read?)

I suspect the EBUSY situation is somewhat imaginative. In theory, the
situation might be possible one thread calls this syscall at some point whe=
n a
new task is being created -- after task data duplication [1] and before
enlisted [2].

As stated in the changelog, the alternative is possible:
> An alternative implementation would not save the permission bitmap in
> every task. But instead would extend the per-process signal data, and
> that would not be subject to this race.
But it involves quite a bit of code complexity and this is pretty much
backend. I think it is possible to follow up and update when the case ever
turns out to be real. At least, I'm not aware of any report against the
PR_SET_FP_MODE prctl(2) [3] which took the same way -- walk and update the
task list.

Perhaps, the hunk above can be improved to be atomic.

<snip>

> So I have to insist that the XGETBV instruction's result match exactly wh=
at is=20
> permitted to run. That means we either enable AMX unconditionally with no=
 need=20
> for system calls (with or without XFD trapping to dynamically allocate mo=
re=20
> state), or that the XCR0 register be set without the AMX bits by default,=
=20
> until the system call is issued.

XCR0 provokes VMEXIT which will impact the performance hardly. At least the
opt-in model is a consensus out of the long debate [4]. Let alone the quest=
ion
on how well advertise this new syscall though.

Thanks,
Chang

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/kernel/fork.c#n2128
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/kernel/fork.c#n2320
[3]: https://man7.org/linux/man-pages/man2/prctl.2.html
[4]: https://lore.kernel.org/lkml/CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAG=
cbG8N+gtdQ@mail.gmail.com/


