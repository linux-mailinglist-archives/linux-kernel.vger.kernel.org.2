Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E8C34D6C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhC2SPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:15:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:41826 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231576AbhC2SOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:14:51 -0400
IronPort-SDR: ftz2/Qu5TR2KAg283CYHg3JsP8d8+CtLBopZZ0iNM9HoLH/3cIYiADcCCSE2tLLCqQb5Y/w3gA
 YE0J2ZZoAfdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191071737"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="191071737"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 11:14:50 -0700
IronPort-SDR: T7ATyXWAxRPnY4qNGqeC4MFdc2IqrvsjcuyzEPDmiPDg5SVw03FImDPwl1QuEDzbfhFeudpaVJ
 hxDKuzaknNaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="516126916"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2021 11:14:50 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 29 Mar 2021 11:14:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 11:14:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 29 Mar 2021 11:14:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mf2OOm2i6SWzSgQYIkIseJIPj64mLwyaBCZX++6qoLdKrMIA5yL7ojnm85aL0QBwxhg+aj79v9IJ6lEEuydpiv12QlalqBGgQmPdwJ+8b/KxPO3uNBr5Kqv0yx2yEJicacxVYnBJob/bD5mffBaH9dCTbtyHqlnESOVu4TC1QqirPKGTEdrPKZn2aJxT+YlLUEF8l/C0Ez2JXOPq10k86uC4DvftvOL6H4/76GDOafny+oXADYPCYg26u44JyhjKogG+8pwRbYV5+WwmTKggUlRHxR7oZ84jmAHr8C0dcwgbRfItJdigm/cbP1vKkRZW0J/MmtA/y+X59TvEPlnwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlK8yAohbg1fYFZVu783QoUffqyxuNIkNR/dQ5oW16A=;
 b=N9yykGFDumybKFlu3BGiOgUmtF4co5+txsv+dZhQBauMSoWkUXcYc6QwWOZmMb3KkfLB8HlL04NGoDP7Y94wV2h/Fbu5lQGgJ7e9uHWfZEC8wdI60j2jEE7qCgj8qt5ZviH44wVpmcBXc2D4kL/dSIFI3RJg5eXoSKnnSebRjt28jFRwqW7UlwxjM87EZbwuv6wOTmOOyvj0z+UdJ/Sp/GyISQBiK8sA0JiZI09gSsFpvq0z+f6g/FRYvt89+0TmttqKmOjuKhVQWWuGVrrcZRmy45Vu/5oVh4IQiZqRWiZqXresrZiTgv8qbH2RmrlScl4mHkngs9zXmxAJt7185Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlK8yAohbg1fYFZVu783QoUffqyxuNIkNR/dQ5oW16A=;
 b=iEFHJ6CBF3543Zmkahz6xss9PUyJxGqF0M+ka2x1kD5dFFyY/SNp0nsYYq7EQPWGFuPjK85PDz1K5VQzKmSgNezn5xvb7obY/C4n1GkH5im21OigmjEA9692a3mIazMdEsBo6J779gg1JpiG1H6aww1G4HvR0pocRQrZVrHjmF0=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 18:14:48 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 18:14:48 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Jann Horn <jannh@google.com>
CC:     Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
Thread-Topic: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
Thread-Index: AQHXCIQDYHRUMzQ+BU6HvOsZgq/N2KqWqq4AgATTFgA=
Date:   Mon, 29 Mar 2021 18:14:48 +0000
Message-ID: <138A0E3D-4794-43C7-861A-4011534A09A8@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com>
 <CAG48ez3hLjwirUoaanDHJ_2h73YruVxfJL88AFVoym7sy02a5w@mail.gmail.com>
In-Reply-To: <CAG48ez3hLjwirUoaanDHJ_2h73YruVxfJL88AFVoym7sy02a5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a2c0f68-271b-4c3d-6a88-08d8f2de89ce
x-ms-traffictypediagnostic: PH0PR11MB5079:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB507969CF28E42FC334301B06D87E9@PH0PR11MB5079.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EaTGYrMB2uHPqYaTJsRC6FCzI7JXZWzACUAbqOLfxWhatpgv/L0Qqaf7bZ/j1n0xSu7iFk/D3oMw75ue44UYe295GlpEbcU2O3Trudeyj5GKTybx64d00if9ESBMMVJjRsDMKPmsP4o3Ucv2/BYgQieRUAroZsyH0ReOdkYBg2qQDgAQRekFwBUufnSTSSVeyp5agY/EWKXrvoHm2XIDxh3P2P7fAXstgAXQLE0Nj/RvOM7xV4YA4G8X9A/Ep2EuXqBNlCagBM9qjJ1n3tuJvo/ZuU9OTPKrrB4mt1J4qE155Zrh4ckolymE3OM2xYQLeTf2S8cwJJa/IUYI6+VTz+skgLl9cEtsMmL/97YBDsDb2wyQSy/fJqiHWK2BfTqFTl9rMBNvJNDM8gKjUeoN5/ofyPwBwsQ05u6gzE7ZhfqsvsDb7ccp2IymcNMOzIUkSfxICdRMqDIf+jaA5+twRApgpdsA9q+uoY4VIpsHbOxeqwWxIAesR/ZBPlTC63+zw1hNfw2WJlSt2AFOb0VH2/DQbZVf1Goqf1SmZoC0UfRMks4GBxpzN3S4rSvpIOG5ISh2R5EXSXY32WzJbzwb/Tml6yTBDoN8XXuiPd1ia7uqMuqXZi7uTaw5YGlw5IWKkW+3ljmr+mhpkSMHJpLsUeDyFuavHrSR7aGBof1keQXTmvmB311VVNXXNUkgCzqmltry9SfaKq4G9xguboYtYGGWsAK8YyBP/6yYqr8C1m/S9oKGbx5ymZSrn8tEaPCdf3MatVPn5pnarAcTgPRreQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(396003)(366004)(376002)(66476007)(6916009)(66446008)(64756008)(66946007)(8936002)(76116006)(2906002)(5660300002)(83380400001)(66556008)(53546011)(54906003)(4326008)(478600001)(6512007)(6506007)(38100700001)(71200400001)(966005)(26005)(8676002)(2616005)(86362001)(33656002)(6486002)(36756003)(316002)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?V8qh07N+4PcCC3TOK4he4Gz/mnvwAXWhvfL4sopGki6zdI+R+GYdfVBepWNh?=
 =?us-ascii?Q?g4ZOlG79UHj7QA2ZHLUvnp9iJNHV970KH0Jwg0fkCPLpVD3pSiNWWSW2dR3D?=
 =?us-ascii?Q?y1123hA4yYdjqyuXXkEvIGDm1fi1sKjji8zsxGoeobtQgXXqHrAKnknfb3Ia?=
 =?us-ascii?Q?tH4Wb4ssFMYIoRuiLpKefv0npakFwVJltDMEm2NEr0VNIHvlWcR7FUjvg8a4?=
 =?us-ascii?Q?rusGot6gR4L3W7ce6dvCOY4KXrIGtJWAUIOK23mIg0nW/JuhWcdu87DAbYj6?=
 =?us-ascii?Q?cc184dC3b75FRhXSs7vIDKxtgYSjGk//FA2jlEZC5/01iZ9eSw/8vjDsswdW?=
 =?us-ascii?Q?QrHeMWNpvRfE2JJe+sC07Fv1fswuzXuMjs1R9ciEGED5i/yJZFsQ55Jtk0zu?=
 =?us-ascii?Q?SOHeNloJl7uhkyfU6kFy9Ws9z10XvtttWNKJ0S7FtK1ukvER9JzpKIOO12D6?=
 =?us-ascii?Q?yUWGKuu9f5lHCr30zR6MkAMYSW2Y1u0v4U+MPtGYoxG/2P+DU2RoqTP1e2Po?=
 =?us-ascii?Q?cYp6+xvEdFBEdZAaXvumhgPYpFk5DPcuAp5NHZdzGoPXXSFGkUDlfbB0Dz4I?=
 =?us-ascii?Q?vBZb9o53xT3Ou9IGq+VOZ44v0rl744g5cjtFN/TZUf2GT7WGxDHQZA6kZ1oo?=
 =?us-ascii?Q?7vbkyCTFsd9c5Mutc0PLQbeWmfTjWjv0NWt+0zR0ZnbintwpdobrnuG4X9Wd?=
 =?us-ascii?Q?sckT0fDRdbZqyyj+khzcLv6EUY0SX3Of7WRFbrFLnvvkzViPoN7OXB4e+yo8?=
 =?us-ascii?Q?fgy/S3JdaXM9lASjAjuZ/5VX4nGqqpT+SdDsupc2iGLxRouVbszX3XFVpH5M?=
 =?us-ascii?Q?gW6N5YUgIHHi53IfZOMS3BMRfQtGYeXQtmR66CByDZM9R3A3o3kcuRwxvcbs?=
 =?us-ascii?Q?aaigJZKBxWdzVelUJqvCEZ3WheBy4jAAsNTtj3NqFZTLbfq665sesyNjphr6?=
 =?us-ascii?Q?Ftj3Wh61Ny5hB0/emvsI6JrjPNo2/rUgErABmfAfymrpAhGaEhsk81RWHquD?=
 =?us-ascii?Q?Z/kDAxQdjmuhxYcy9oA/tr05pMLevX6uprTc/XQnJnZIuC9zjfNstZR+voI4?=
 =?us-ascii?Q?a4NkDeB3RfdeEtwuIoUdLJ0ANi7heqLpkcWX/qmzma1uf49eR0TrXweqwGfG?=
 =?us-ascii?Q?fb2s1LhdFPvuqch+ZQdHwuopgX3HpK9KcUPjE66pN/AxSldkvU++Isx7aexr?=
 =?us-ascii?Q?bvziki36T0HiUESWcfodNMK1Uw9OaMsHCFqp+XyEJpRAutzKjQ4KWPDKMDir?=
 =?us-ascii?Q?T2EI9qpxVMhd2mcILofMLG2pj8YNc5ggokEKBKPDuUiGvQDYhLHu7Pn6wS16?=
 =?us-ascii?Q?JJUkFrjZCgCbhw2gPlxcc5S5?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9534083BFD53A74A96B1FC19D61B170F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2c0f68-271b-4c3d-6a88-08d8f2de89ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 18:14:48.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tuSLFs/JqIwGDQlMYN+mbTnbhNX0FyxC2mIKP8ta96UpItP+BEe0mDIS+ImiX0KN5FYz/sAVZJnAoa5sb7NG/AJRu1LVOmgVvLp6o4OC6/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2021, at 09:34, Jann Horn <jannh@google.com> wrote:
> On Sun, Feb 21, 2021 at 7:56 PM Chang S. Bae <chang.seok.bae@intel.com> w=
rote:
>>=20
>> +       if (handle_xfirstuse_event(&current->thread.fpu))
>> +               return;
>=20
> What happens if handle_xfirstuse_event() fails because vmalloc()
> failed in alloc_xstate_buffer()? I think that should probably kill the
> task with something like force_sig() - but as far as I can tell, at
> the moment, it will instead end up at die(), which should only be used
> for kernel bugs.

This question was raised on v1 before [1].

In the end, people suggested to handle the failure, e.g., with tracepoints =
or
stats. So, proposed this on the allocation site:

+	state_ptr =3D vmalloc(newsz);
+	if (!state_ptr) {
+		trace_x86_fpu_xstate_alloc_failed(fpu);
+		return -ENOMEM;
+	}

Also, I tried to justify this to Boris [2]:

  >> Maybe it is possible to backtrack this allocation failure out of #NM
  >> handling. But the tracepoint can provide a clear context, although lim=
ited
  >> to those using it.

  > Yes, add it when it is really needed. Not slapping it proactively and
  > hoping for any potential usage.

Let me know if you have a better way.

Thanks,
Chang

[1] https://lore.kernel.org/lkml/c4669d5f-11b8-3879-562c-78a791b86229@intel=
.com/
[2] https://lore.kernel.org/lkml/20210204131002.GA17068@zn.tnic/

