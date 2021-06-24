Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71563B276A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 08:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhFXGew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 02:34:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:21731 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhFXGeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:34:50 -0400
IronPort-SDR: uNdTbdbKvBEr28ox5lkf26J9Vb/nmzsiz8pWlMmRWwzdZczeAKMvrU2l9O/pRbO8nnsap3PnAa
 22y2RZNxX1pg==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="268540511"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="xz'?scan'208";a="268540511"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 23:32:29 -0700
IronPort-SDR: 2KHJve1rVeqmYb1Zz3Rs0VZqPnbORorZsWMYI6ePYmKagIlX+H66fDuikYYvCEgFepg3P8YK/q
 XvwHC3165iag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="xz'?scan'208";a="454934903"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jun 2021 23:32:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 23 Jun 2021 23:32:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 23 Jun 2021 23:32:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 23 Jun 2021 23:32:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F92NuRbYM0tei6WYDJOrxOwP0i0PwtIpyaLlYHM3248eS1p51DIQ5TKjIS/TAclSeyd0Z3Qg9eOITsmthnDqFEn70VAjYrbrpz/czzGFrgsWJktYHTAnqiPcGyfn6bzBlQ13qci2ek8rI3/hDQd+PTIIcC5hFp1pvO4TNru04ond9L0val22qWd1UPpMcrpxemaC8QZZ1VpkpI72WBPJ/HvMTVjDdjVu3J8iqolSdYQU9sEmgHnWVlcDv+WpsIM3JW2j2X1HfQSFJHlH6OSdnWlfVtUshkVLtXuZAKc9rIe6gjZWelChxDWC7UEdEwmoGH3RF8unVjFRf8vIQCf69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP2AbYSDyMon/MweuRLMADCM8rebMJJfJ8Zhq0323Vs=;
 b=Nc7NNbyjQ8zr6Ql64+JmH4d8YqAqRu2sSjsF7JLYPugt3FZpd1+0765CEPWsIfsJUeVfWC8sjQmkrW86rwS6DGVhEOsZ6C0u4T32KlnVLt3UFYY8+tE9XPjezCkGUvMtB7m3Lr+yX9wDEWcRaSQThRTb1/xiVmLINQWHuDZI9hBLbay7AXAbA/m/AoGosn6G7BRnG0GGmY68g4FiCh7WpK8l9i+UIuAnCxOMAUyozapL/a1z8dTaafJ8u2wcxweKka9YeWMJaSLB9TSJZRTeaSMgpxhhOiR+Dsqd3tS1B4K9Hqx9AV3/lniiXe6KetIzS8vDxHaD6jhFO3d4NMcXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP2AbYSDyMon/MweuRLMADCM8rebMJJfJ8Zhq0323Vs=;
 b=yn67uu78hajcLJbcXDih78QV/nrQ2VOsw+pNizKX13rmQkQ1CoRRWvDG0boHtXGsXfiVlR/lOhlVdWMLt1rgg+TlV65WtJxCSqAqfb92n+lYdDi1MJsECzzBzZSZLc2zD8D9IR7u+WUzJBsOm7QxO5IsO6RllxmQiHjut3V4zXg=
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 06:32:25 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::e50f:8709:f404:8b4b]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::e50f:8709:f404:8b4b%4]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 06:32:25 +0000
From:   "Liu, Yujie" <yujie.liu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Sang, Oliver" <oliver.sang@intel.com>
Subject: RE: [LKP] Re: [jump_label, x86]  e7bf1ba97a:
 BUG:unable_to_handle_page_fault_for_address
Thread-Topic: [LKP] Re: [jump_label, x86]  e7bf1ba97a:
 BUG:unable_to_handle_page_fault_for_address
Thread-Index: AQHXaAiH7ZAQDH07J0+GlvPgeMbkGasitFqw
Date:   Thu, 24 Jun 2021 06:32:25 +0000
Message-ID: <SJ0PR11MB5598608507B7EB38983113BCFB079@SJ0PR11MB5598.namprd11.prod.outlook.com>
References: <20210623022826.GA20282@xsang-OptiPlex-9020>
 <YNLtSKUtqxqPxmGP@hirez.programming.kicks-ass.net>
In-Reply-To: <YNLtSKUtqxqPxmGP@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.143.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50237c78-1e81-4aab-3b82-08d936d9d4df
x-ms-traffictypediagnostic: SJ0PR11MB5613:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5613B06CE00248C7F5D11B7EFB079@SJ0PR11MB5613.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gSyj/NsT2Ae7vyvtR+yrx5EQ+e6uoyiQRG4jJgOGRjyKd/XTweBDeH64NQcb4ymoxRvLqHjuePVVR5tZ7YoOWqvr5qy3Jm1pmS97lNXTemFJg0MBEDL9ROYncVGCkty0jqIHiftFPk09SKzAE7/tja5yf5xbbVoZlPVTQHwkGe53PGWV4KOgSevxAkxHzDQ81DIIihA06L/SKrYkDsFXfnTo0RXPdBPwPQlIfAdgtDFu7BTCyNcS1S23uM5EzXbjAK/qO2JKGx4nwMxT1ejyDraE7sH49trM6W8FbYhBRYUdnCK0jvVj+0fWzpUaEAP9gt74y1vOpEKEewzGm7h4tM8ZFAVVry0Mk/F4remYv862BTsaxyCH3vIBo33VpS2nNXnygjLbAX2U8ss6tPtl1SCVsCfpkyt1O5FHsDmxeRZkeTOBVlP+ZU7i2O6fGdOn4AR/9QFEBTz56DcUoXeF+cVldBcOtmrpl0ck9SSGj54JAf63p5TUdQ7aK3ugCXqY9NP262qMpnFLj1aggZgVW0m+BlZ4bL/Q0dSNhi5aooO6NmV/YJX8bFYTJaCu9z1+0VaaCkpZL+4ZPshg1SUPPwoVPjYWJP37dx0ZwU4g0Wd80yLcD/rdRy+3FN/1WwYE4taytbPd3t+c/iyx+h+pBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(346002)(396003)(136003)(55016002)(7696005)(6506007)(107886003)(54906003)(38100700002)(6916009)(122000001)(33656002)(4326008)(83380400001)(86362001)(5660300002)(66946007)(26005)(2906002)(316002)(186003)(8676002)(9686003)(8936002)(64756008)(66446008)(76116006)(66556008)(66476007)(66616009)(99936003)(478600001)(45080400002)(71200400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L9CL1/zcKzq/AK8LRD+8FkiRv9BXuRvRFfpgBE668SZ9N2RGpQGkGX3q3Ssy?=
 =?us-ascii?Q?5rI9LLG1yP/+MzaE6jMgna44iRQXywQkOCRc4qn/kibgJEptQPDZQOoH0h+l?=
 =?us-ascii?Q?1zNthABpW4QMdZFhLYyHMI1K+D0q9RK4Wu49x3FEitXYEpoYUuLo3ZcIYmS6?=
 =?us-ascii?Q?MZO3I0sZ9GcO+QyxE8Loje+DNLtJP0DebYGSc78A0WomK5LOx/c0kPz8PLl9?=
 =?us-ascii?Q?opzprhxrdzpge7mard9ARl6ErRJYvj9SYcpTXwsqBchn+ZPLYRWLjbiMhOC8?=
 =?us-ascii?Q?Bqm75lReFNhSCWBZDl7UnPJ8DRiMDxX80GKJnsWIHoIwKOhtX5QJm+v+M6vz?=
 =?us-ascii?Q?MM4QOvbsxdF+9TLpRS08m9C6BjtZpJPoA3Qgir9J0cB3/QdtMsAEaKlkz0Ct?=
 =?us-ascii?Q?tOBwMXDtKW450w6CCPMq+SO6bX2Cb4GzfLP+fds3jLVCZNBz7e+k1MSi9OzZ?=
 =?us-ascii?Q?UjBRkXfQv+uwz4UY+zTQGWYJbFgybOtYfwtzkS7Je/0ujCPKBqTXWaf+tdRM?=
 =?us-ascii?Q?RyPtHVh9sZ1nTyGzo8TOPPhYN2LtpJgtbrthEA53zc93/frhcTNVPJ0zEeDT?=
 =?us-ascii?Q?f6c6RzaDnWiWW0dGKmzi9LmZxggalisfQvcbyrwf6Gu8p2PaZoEgZXwP8dvd?=
 =?us-ascii?Q?XiSrSsWhPJlhw/R1DOMV0jnzgqNYmYLYP/mM0fg84GpOsoNMUYTLiy83ZLYF?=
 =?us-ascii?Q?hKRgpw7HuWYhNHEGs/UqiVtIZXwzJy8VPM2Xydyxmi4vYH3QQoDDiBq5u+fP?=
 =?us-ascii?Q?SbuG85LmnuobquL/TcWFBW0NPOLzM5F5Iz6IAuSG7sIzbxwX7bSVqsR/XcZc?=
 =?us-ascii?Q?vLUhgcIraVHoQ3D5YbF3iZlbHgyq9QY+4yrdoxVdaRQN1yaYTo55ZqnRNB7F?=
 =?us-ascii?Q?BymxFstyDQoWrL4dEco5FbBgSI+Bxq04Ml/+RAPFM2Rif3/cg2QRwntta2vI?=
 =?us-ascii?Q?8g9mdtAA+Kngaz/5p1TsMICdfS5QpnIi/7BQYLx06D0pTqaRqas4K1krIkYe?=
 =?us-ascii?Q?+iuYk+wk5PZcqxD45rRDQHKexKCc5NTapFBPdg2bOMTP5YMvu691iM4Md//R?=
 =?us-ascii?Q?IlEqzh8apR399nwtVOk3Dt4Er6/jPfJPCpnIsVzWShwNZIVzj8gO2mx3V4V7?=
 =?us-ascii?Q?NXGWm2zLb4gMA1Z9Ut5mdN2tjEng1Uu4tvmS/KHSlB3PBfOiyjF362ra16UJ?=
 =?us-ascii?Q?A+mikAh7SrD6ZIvwn2i026NaRYk8cXa2mPP5WJYnwGCFUyy97LN5lj93dc6G?=
 =?us-ascii?Q?kAlE8/I2fANrgG2CAX7xIk+jyT4d3lKI59g8wL54kFp+bzkBPbVay6RIuQW7?=
 =?us-ascii?Q?/uQgc8hxSa1/C0CxwVfDqPcC?=
Content-Type: multipart/mixed;
        boundary="_002_SJ0PR11MB5598608507B7EB38983113BCFB079SJ0PR11MB5598namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50237c78-1e81-4aab-3b82-08d936d9d4df
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 06:32:25.5633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7bQenwV0xQ8W8KvGjnb6EQsGZ2bdXAh7FuQuSONBS/12khw8uBL1t9QRJCiygDmj2TGDEHEYHoOnMjjCZjoehQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5613
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_SJ0PR11MB5598608507B7EB38983113BCFB079SJ0PR11MB5598namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> > [  222.094341] BUG: unable to handle page fault for address:
> > ffffffff83ccffe0
>=20
> I *think* the below might help, can you try?

Hi Peter Z,

We try to apply the patch on commit e7bf1ba97afdd (jump_label, x86: Emit sh=
ort JMP)
A new BUG appeared before reaching the BUG reported in previous mail.
Full dmesg in attachment.

Some brief dmesg:
[  143.438194] BUG: kernel NULL pointer dereference, address: 0000000000000=
000                              =20
[  143.445105] #PF: supervisor read access in kernel mode                  =
                                 =20
[  143.450203] #PF: error_code(0x0000) - not-present page                  =
                                 =20
[  143.455301] PGD 0 P4D 0                                                 =
                                 =20
[  143.457814] Oops: 0000 [#1] PREEMPT SMP PTI                             =
                                 =20
[  143.461964] CPU: 1 PID: 2812 Comm: ftracetest Not tainted 5.13.0-rc1-000=
10-g2e1ef7b15f89 #1              =20
[  143.470249] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12=
/05/2017                         =20
[  143.477585] RIP: 0010:jump_label_text_reserved+0x82/0x100               =
                                 =20
[  143.482940] Code: 89 ef e8 61 fd ee ff 4c 89 f7 48 89 c5 e8 56 fd ee ff =
48 39 c5 75 70 48 89 ef e8 c9 b5 e
e ff 84 c0 b8 00 00 00 00 48 0f 44 e8 <8b> 5d 00 bf 01 00 00 00 e8 31 7d e3=
 ff 65 8b 05 6a 84 c7 7e 85 c0   =20
[  143.501565] RSP: 0018:ffffc90000dcfcd8 EFLAGS: 00010202                 =
               =20
[  143.506747] RAX: 0000000000000000 RBX: ffff88880c633400 RCX: ffffffff811=
97c49          =20
[  143.513823] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000          =20
[  143.520899] RBP: 0000000000000000 R08: ffffc90000dcfc20 R09: 00000000000=
00001          =20
[  143.527975] R10: 000000000001ae21 R11: 0000000000024f61 R12: 00000000000=
00000          =20
[  143.535051] R13: ffffffff811dfe40 R14: ffffffff811dfe40 R15: 00000000000=
00000          =20
[  143.542126] FS:  00007f7558bb3740(0000) GS:ffff88881dc80000(0000) knlGS:=
0000000000000000
[  143.550149] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033           =
               =20
[  143.555849] CR2: 0000000000000000 CR3: 000000081239e002 CR4: 00000000003=
706e0          =20
[  143.562924] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000          =20
[  143.569999] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400          =20
[  143.577075] Call Trace:                                                 =
               =20
[  143.579501]  register_kprobe+0x3c9/0x600                                =
               =20
[  143.583997]  register_trace_kprobe+0x202/0x600                          =
               =20
[  143.588406]  __trace_kprobe_create+0x449/0x700                          =
               =20
[  143.592812]  ? __kmalloc+0x749/0x7c0                                    =
               =20
[  143.596372]  ? register_trace_kprobe+0x600/0x600                        =
               =20
[  143.600952]  ? probes_profile_seq_show+0xc0/0xc0                        =
               =20
[  143.605531]  trace_probe_create+0x76/0xc0                               =
               =20
[  143.609509]  create_or_delete_trace_kprobe+0x11/0x40                    =
               =20
[  143.614433]  trace_parse_run_command+0xbb/0x180                         =
               =20
[  143.618925]  vfs_write+0xcc/0x3c0                                       =
               =20
[  143.622213]  ksys_write+0x68/0x100                                      =
               =20
[  143.625588]  do_syscall_64+0x40/0x80                                    =
                                 =20
[  143.629134]  entry_SYSCALL_64_after_hwframe+0x44/0xae                   =
                                 =20
[  143.634147] RIP: 0033:0x7f7558ca0504                                    =
                                 =20
[  143.637691] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 =
00 00 00 00 48 8d 05 f9 61 0d 00 8
b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00=
 41 54 49 89 d4 55 48 89 f5 53   =20
[  143.656310] RSP: 002b:00007ffe82aebca8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001                       =20
[  143.663817] RAX: ffffffffffffffda RBX: 0000000000000023 RCX: 00007f7558c=
a0504                            =20
[  143.670894] RDX: 0000000000000023 RSI: 000055bb6897ce30 RDI: 00000000000=
00001                            =20
[  143.677972] RBP: 000055bb6897ce30 R08: 000000000000000a R09: 00007f7558d=
30e80                            =20
[  143.685050] R10: 000000000000000a R11: 0000000000000246 R12: 00007f7558d=
72760                            =20
[  143.692128] R13: 0000000000000023 R14: 00007f7558d6d760 R15: 00000000000=
00023                            =20
[  143.699207] Modules linked in: btrfs blake2b_generic xor zstd_compress r=
aid6_pq libcrc32c intel_rapl_msr i ntel_rapl_common i915 sd_mod t10_pi sg i=
pmi_devintf ipmi_msghandler x86_pkg_temp_thermal intel_powerclamp ahc i cor=
etemp crct10dif_pclmul libahci mei_wdt wmi_bmof vfio_mdev crc32_pclmul vfio=
_iommu_type1 crc32c_intel gha sh_clmulni_intel rapl intel_cstate mei_me vfi=
o mei intel_uncore libata mdev intel_pch_thermal i2c_i801 i2c_sm
bus intel_gtt wmi video acpi_pad intel_pmc_core ip_tables [last unloaded: f=
trace_direct]                    =20
[  143.744567] CR2: 0000000000000000                                       =
                                 =20
[  143.747855] ---[ end trace a8a384c1d6f5e7b7 ]---                        =
                                 =20
[  143.752434] RIP: 0010:jump_label_text_reserved+0x82/0x100       =20
[  143.757789] Code: 89 ef e8 61 fd ee ff 4c 89 f7 48 89 c5 e8 56 fd ee ff =
48 39 c5 75 70 48 89 ef e8 c9 b5 e
e ff 84 c0 b8 00 00 00 00 48 0f 44 e8 <8b> 5d 00 bf 01 00 00 00 e8 31 7d e3=
 ff 65 8b 05 6a 84 c7 7e 85 c0   =20
[  143.776410] RSP: 0018:ffffc90000dcfcd8 EFLAGS: 00010202                 =
                                 =20
[  143.781594] RAX: 0000000000000000 RBX: ffff88880c633400 RCX: ffffffff811=
97c49                            =20
[  143.788674] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000                            =20
[  143.795752] RBP: 0000000000000000 R08: ffffc90000dcfc20 R09: 00000000000=
00001                            =20
[  143.802830] R10: 000000000001ae21 R11: 0000000000024f61 R12: 00000000000=
00000                            =20
[  143.809909] R13: ffffffff811dfe40 R14: ffffffff811dfe40 R15: 00000000000=
00000                            =20
[  143.816988] FS:  00007f7558bb3740(0000) GS:ffff88881dc80000(0000) knlGS:=
0000000000000000                 =20
[  143.825012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033           =
    =20
[  143.830710] CR2: 0000000000000000 CR3: 000000081239e002 CR4: 00000000003=
706e0 [  143.837786] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000 [  143.844861] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:=
 0000000000000400
[  143.851937] Kernel panic - not syncing: Fatal exception                 =
    =20
[  143.857167] Kernel Offset: disabled                                     =
    =20
ACPI MEMORY or I/O RESET_REG.                                              =
    =20


Thanks.

> ---
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c index bdb0681bece8=
..c44381dcf25b 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -316,14 +316,16 @@ static int addr_conflict(struct jump_entry *entry, =
void *start, void *end)  }
>=20
>  static int __jump_label_text_reserved(struct jump_entry *iter_start,
> -		struct jump_entry *iter_stop, void *start, void *end)
> +		struct jump_entry *iter_stop, void *start, void *end, bool init)
>  {
>  	struct jump_entry *iter;
>=20
>  	iter =3D iter_start;
>  	while (iter < iter_stop) {
> -		if (addr_conflict(iter, start, end))
> -			return 1;
> +		if (init || !jump_entry_is_init(iter)) {
> +			if (addr_conflict(iter, start, end))
> +				return 1;
> +		}
>  		iter++;
>  	}
>=20
> @@ -548,6 +550,7 @@ static void static_key_set_mod(struct static_key *key=
,  static int __jump_label_mod_text_reserved(void *start, void
> *end)  {
>  	struct module *mod;
> +	bool init;
>  	int ret;
>=20
>  	preempt_disable();
> @@ -555,6 +558,7 @@ static int __jump_label_mod_text_reserved(void *start=
, void *end)
>  	WARN_ON_ONCE(__module_text_address((unsigned long)end) !=3D mod);
>  	if (!try_module_get(mod))
>  		mod =3D NULL;
> +	init =3D mod->state =3D=3D MODULE_STATE_COMING;
>  	preempt_enable();
>=20
>  	if (!mod)
> @@ -562,7 +566,7 @@ static int __jump_label_mod_text_reserved(void *start=
, void *end)
>=20
>  	ret =3D __jump_label_text_reserved(mod->jump_entries,
>  				mod->jump_entries + mod->num_jump_entries,
> -				start, end);
> +				start, end, init);
>=20
>  	module_put(mod);
>=20
> @@ -788,8 +792,9 @@ early_initcall(jump_label_init_module);
>   */
>  int jump_label_text_reserved(void *start, void *end)  {
> +	bool init =3D system_state < SYSTEM_RUNNING;
>  	int ret =3D __jump_label_text_reserved(__start___jump_table,
> -			__stop___jump_table, start, end);
> +			__stop___jump_table, start, end, init);
>=20
>  	if (ret)
>  		return ret;
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

--_002_SJ0PR11MB5598608507B7EB38983113BCFB079SJ0PR11MB5598namp_
Content-Type: application/octet-stream; name="dmesg.xz"
Content-Description: dmesg.xz
Content-Disposition: attachment; filename="dmesg.xz"; size=29324;
	creation-date="Thu, 24 Jun 2021 06:31:00 GMT";
	modification-date="Thu, 24 Jun 2021 06:31:00 GMT"
Content-Transfer-Encoding: base64

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
pWMAAejkAamvCSU1QNqxxGf7AgAAAAAEWVo=

--_002_SJ0PR11MB5598608507B7EB38983113BCFB079SJ0PR11MB5598namp_--
