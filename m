Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29142045F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 00:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhJCWl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 18:41:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:37419 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhJCWl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 18:41:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="222691797"
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="222691797"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2021 15:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,344,1624345200"; 
   d="scan'208";a="621224478"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 03 Oct 2021 15:39:38 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 3 Oct 2021 15:39:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 3 Oct 2021 15:39:38 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 3 Oct 2021 15:39:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhBR8ocjXPs6tqsKn0rWvYYJ4X/687lk2I+x30Ml6K2cSHcC4Gk/6qcCzKcAy9GHhTlecJbA3zbx9oYtU3i47MEM972LZbqXVdUgPPXKLJhg7ppTewFmewo9/rRnsk3LwWkRBYTY62UMxakIGOkvnRIccbtcD0dXOTQoj9E61FsAt/UZvB9vN73P+pRyzrjiBfWT84CLxwOXy0HULWgDr8KN7fjuQZTFqZCm5+xnHAHxSW3S/48RBibEnPRXqUxGnhqw0biQ6JFtKUemHjzhx68mrqrAbkxsj6d9IBLJbVQKmw0BKmOdzvUy+NHC+F4Sdpgxu8sI3U1ElH/kVeW72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eE/m1Ep3iNBUzX6TqlkqUN51sroipss/AoJKsA17yD0=;
 b=K5QgRhWhrBreYkV4q06nlTTFlYoiSKrMuAjdB7tJQ3Fp622zOrXwkODFz1sVLBlnwygkHdURcbaocrZgbyAngn4Eziq6WSIyE8d0CQ8kPoVf4pF7eDqlUoWMZAqQG+nPmxK1JlE4utITs6SYOr9S5SJ9/nWWdF2xo7uupMlupe3a2MRT22BmrU9hBgOKeBmYpXXzCF5YFMPkqKh1Cx9FB5VwQvkEYO2zcVIrmLYHvR/S6/LBBwkImZ2uPgfUQPZhT0wxABq8SIATcoJSbg09DOUXDbVkua0M58cCN0mFsBdPP4rkOuifFhE0oBQ5tuNs2u56/TDpPWb2awXSjWgO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eE/m1Ep3iNBUzX6TqlkqUN51sroipss/AoJKsA17yD0=;
 b=zaM5cyJU9wNQiu0CWAV2jqj8VWaVA7YWJvLKZkHLPMQfI9ern/dVig7qQeKDSoLjrfilturxxzTOV9FXKCSY7q/9Mr+l1o1fWA+ZK5+V8tJNJs8y4NqB1Kpcb/Y6FD5DCbwnPLTnC9Nfw+tI70AyF2cJOZNaT7RSXMCOeE8Jsr4=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Sun, 3 Oct
 2021 22:39:34 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.022; Sun, 3 Oct 2021
 22:39:34 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 13/28] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Topic: [PATCH v10 13/28] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Index: AQHXmcpyp/UMng9jvEuWIVdsREnfcKu+dzeAgABYsgCAA0uRgA==
Date:   Sun, 3 Oct 2021 22:39:34 +0000
Message-ID: <66A19E8A-11BF-4532-878F-A8D0935FDBC7@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-14-chang.seok.bae@intel.com> <871r546b52.ffs@tglx>
 <87ee944hvj.ffs@tglx>
In-Reply-To: <87ee944hvj.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bf9d0c7-fcf9-4497-c583-08d986beac6c
x-ms-traffictypediagnostic: PH0PR11MB4853:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB485332F5CF04D448F97456E4D8AD9@PH0PR11MB4853.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nCcCk7+NIVt/YNRxFzpBCR3misVv8rGfnPaoQCn5wULK+Xf68hQURx1eJDQ5jIY7xVql0GcTH8cr102as0xXubyOx7MsArYuz95yk8eX7QiF9wlb7GR2SasKQlhTj1NsGTUDy8yUov3dQCBBEYk9y9yrCGM4IxRgqKTFHDlIw/h57dpBK2dl9StniRI4jFzml44ZndSft6XOYbDveV9YqeoeCFjNKJCLm6cRYZkdr3+rL/9AUu7x1YFkYC1js3uYiUFsaRj6U2YsO9il9UjhkNOHeG6M5geEBjltNvpAiAG3RgZPK+8eNrvAGS/X6RAYypFSbH0hkCEDf++afviRFtK4NJ7vKfvXS2hjwC4gV2LNC0Mn6/kXRyEI8uFAAA5X3RYYt8SqPKwkRl5jGKBXaYudBFg+y6Za6XtSV/h4jsesQ11uVNsPwwp6Z/gc+JlTfkG5seYI0Yl4WJ4o3qrIVCoHkfN0Y0TDfz6gbqhXcNZtu9La1BqyTS0ZEj0ZnMQ7XNDI/ZQBUu53TWTTE+eYkYxqVkUxtGFjknWDukV8C5H9r/ijgWjHLpaml6cGACuYfLVewKxEb1Jr9pFPNQgxTZBC4oEnFneyviE0Rd6Xr9Nhnq09IXhL8rpLMUXqwUzRMwmg2i7xSPDReGOGhvQPZ5P9jYOBU+AyWGFDbpwaxQrhz+pW7V6aGJdlBhIu+nEy7jg6e1yVGvdzzgEeY6DY8oqVv929HxdN1mduviNOk4LvlIloo+Rrklx4AUHtOE71M5tmoQKju76jMizTVvj62BmJvBYDpW3zf1eO2o4/A5MdFHL68uMjG969Z69AGYDPjC0XoTIf1QeyuaRSpmtnFoMWczg5v09jImsTZHZt8HaryaBSswDcX2zfCjQYhNED
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(2616005)(33656002)(2906002)(6916009)(8676002)(6506007)(53546011)(86362001)(186003)(966005)(26005)(36756003)(83380400001)(38070700005)(66476007)(76116006)(38100700002)(6486002)(4326008)(6512007)(122000001)(71200400001)(5660300002)(66446008)(64756008)(66946007)(66556008)(508600001)(316002)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CV6Ifw60BQwhmcU+2a3DF5LJ/G9mqVnpLoCBBXCmLqTYwBzT9zbOmFyOqJ6O?=
 =?us-ascii?Q?/nzg/CFNCrOd4tBuw+/+ZI6FDo+LsKdaq0T6SbU3RQw5KhzRX5H53q1GO1Gp?=
 =?us-ascii?Q?FW/YSG8SVuHI1zXYIZa7e9ZOgpyZ/fph7yCKl78VkaMdsTBme3dbfAkjFh1I?=
 =?us-ascii?Q?q3EZsf08GE0/eGBNJRAdYO1R3Pnl9Lf5VQRC4VqCn5uruLMSKn7a2MQ+QFgo?=
 =?us-ascii?Q?R8+0+LE2+ztxKAnF0OUZXa5IMD7DrIqhHh8K7P1ncyEmXn/MLanJ83/toK59?=
 =?us-ascii?Q?iyEvUKwQvJG44LLTS49PgKfaUGcT/ItW+PbQnkxm+TH5qGd1L0/QTak9QOsM?=
 =?us-ascii?Q?Gi++D5PHAStcrKzbfQZC7lAqk8Vpg7W9vf//eq255c8Fx+i7b91rDnTa4SOg?=
 =?us-ascii?Q?WxpjsS9UVxJij9XdWuZgCFq84EBP/gDPkywYB7E4rkUfdy9wbeUo6A6Sfw98?=
 =?us-ascii?Q?s10MrHTBbLD+8GUGqD2LxJVGD9VP0lGMW9bPfMBobIikrY6IrgH9lZiveQnn?=
 =?us-ascii?Q?YdaneZUE2CcJUQDMGhz0iLfdYz8TrtJ4pJV3/2/jkonE63zFb0NDSwvNCWhV?=
 =?us-ascii?Q?co2uQYtMLltybz9h12qa8I7sdjNMpaIqRD53w+/OP//XQgRl04k18Cfxl7n8?=
 =?us-ascii?Q?ihD7S5on/WmGtEeoL04EMYDrK52lOWeQeNCZ0suN2o7IshsmlblV1FJTDBKH?=
 =?us-ascii?Q?Jp1h31G9PPMc8fEIy+zN7VTubsIjZW01KtbJdMdK254aXNrx39ljcGhsih1N?=
 =?us-ascii?Q?dYFRC5whIYxOJNB6fkdKuI8OMhN7epfISTfncRbBmwrpJms5zhGl/dt4faGj?=
 =?us-ascii?Q?FhMPs7eZxH9Fi8BMbKVE6nEIYzkhbc5rsY+zmnY9DQp95qpzX1OoDyEdcbJ7?=
 =?us-ascii?Q?Cp8PY/QiOzHqzuIGGahjC3SR/fVhIZwETf33BpXfSSsSygAeKWpKTweZm9GP?=
 =?us-ascii?Q?BktSXujgScDBsaQkyrTe2hU0Re/GqhgUw19V2UDZg3wMr1DwJn0piKYi86HH?=
 =?us-ascii?Q?USNMeTdzaKkBOB6p8LhN/mwLOsWfE5+tuhGoRvmeND4hDk+uIghUpPw6W+cV?=
 =?us-ascii?Q?laRgZKY1BC6+pJvEtkW0H9lqEeDLL1s81uJrIX2WDBVfzsTZe7gmaByi3dOU?=
 =?us-ascii?Q?9kssfEGTlC43vrWJ6503yACtV0ecjPBo3miB5eQM0FVnwDDlPzyDwZ5pwbNC?=
 =?us-ascii?Q?ZLqxOTvpSnc8koRSUaStAgUFe3/GThRtPSgZSw3YdFNyIg/w2VSDuQ34QlR3?=
 =?us-ascii?Q?DjrnXNh/rtF0g+FUPp77TRH/3UczsrsaNqJdGiEH/TNlkB7hkKczIL83W9Dm?=
 =?us-ascii?Q?rof1ErYOephp7XaTmOdnmvF4?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F595A03B8E04D34897E367CDAD8BC53F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf9d0c7-fcf9-4497-c583-08d986beac6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2021 22:39:34.3029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mFTqym6MwH/acMTW3P0OxTqy3XhgPKVUnYleXGJs7LnK+VsO0AVI4YGttzvHdBw68eBgegun8Ob0uf7OnQm7GImxj/HbamTYe7W6LNYPGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 1, 2021, at 13:20, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, Oct 01 2021 at 17:02, Thomas Gleixner wrote:
>> On Wed, Aug 25 2021 at 08:53, Chang S. Bae wrote:
>>> +/**
>>> + * xfd_switch - Switches the MSR IA32_XFD context if needed.
>>> + * @prev:	The previous task's struct fpu pointer
>>> + * @next:	The next task's struct fpu pointer
>>> + */
>>> +static inline void xfd_switch(struct fpu *prev, struct fpu *next)
>>> +{
>>> +	u64 prev_xfd_mask, next_xfd_mask;
>>> +
>>> +	if (!cpu_feature_enabled(X86_FEATURE_XFD) || !xfeatures_mask_user_dyn=
amic)
>>> +		return;
>>=20
>> This is context switch, so this wants to be a static key which is turned
>> on during init when the CPU supports XFD and user dynamic features are
>> available.

I see. When there is a static key, use it only since this is context switch=
.

>>> +
>>> +	prev_xfd_mask =3D prev->state_mask & xfeatures_mask_user_dynamic;
>>> +	next_xfd_mask =3D next->state_mask & xfeatures_mask_user_dynamic;
>>> +
>>> +	if (unlikely(prev_xfd_mask !=3D next_xfd_mask))
>>> +		wrmsrl_safe(MSR_IA32_XFD, xfeatures_mask_user_dynamic ^ next_xfd_mas=
k);
>>> +}
>>> +
>>> /*
>>>  * Delay loading of the complete FPU state until the return to userland=
.
>>>  * PKRU is handled separately.
>>>  */
>>> -static inline void switch_fpu_finish(struct fpu *new_fpu)
>>> +static inline void switch_fpu_finish(struct fpu *old_fpu, struct fpu *=
new_fpu)
>>> {
>>> -	if (cpu_feature_enabled(X86_FEATURE_FPU))
>>> +	if (cpu_feature_enabled(X86_FEATURE_FPU)) {
>>> 		set_thread_flag(TIF_NEED_FPU_LOAD);
>>> +		xfd_switch(old_fpu, new_fpu);
>>=20
>> Why has this to be done on context switch? Zero explanation provided.
>>=20
>> Why can't this be done in exit_to_user() where the FPU state restore is
>> handled?

Looking at the changelog of the patch to delay XSTATE [1] load:

    This gives the kernel the potential to skip loading FPU state for tasks
    that stay in kernel mode, or for tasks that end up with repeated
    invocations of kernel_fpu_begin() & kernel_fpu_end().

But I think XFD state is different from XSTATE. There is no use case for
XFD-enabled features in kernel mode. So, XFD state was considered to be
switched under switch_to() just like other user states. E.g. user FSBASE is
switched here as kernel does not use it. But user GSBASE is loaded at
returning to userspace. Potentially, it is also beneficial as XFD-armed sta=
tes
will hold INIT-state [3]:

    If XSAVE, XSAVEC, XSAVEOPT, or XSAVES is saving the state component i, =
the
    instruction does not generate #NM when XCR0[i] =3D IA32_XFD[i] =3D 1; i=
nstead,
    it saves bit i of XSTATE_BV field of the XSAVE header as 0 (indicating
    that the state component is in its initialized state).

I wish I could make sure the above point before following this:

> DEFINE_PER_CPU(xfd_state);
>=20
> update_xfd(fpu)
> {
> 	if (__this_cpu_read(xfd_state) !=3D fpu->xfd_state) {
> 		wrmsrl(XFD, fpu->xfd_state);
> 		__this_cpu_write(xfd_state, fpu->xfd_state);
> 	}
> }
>=20
> fpregs_restore_userregs()
> {
> 	if (!fpregs_state_valid(fpu, cpu)) {
>        	if (static_branch_unlikely(xfd_switching_enabled))
>                	update_xfd(fpu);
> 	...
> 	}
> }
>=20
> Hmm?

Yes, I thought some similar things in this [2].

Thanks,
Chang

[1] https://lore.kernel.org/all/20190403164156.19645-24-bigeasy@linutronix.=
de/
[2] https://lore.kernel.org/lkml/20210825155413.19673-28-chang.seok.bae@int=
el.com/
[3] 3.2.6 Extended Feature Disable (XFD), Intel Architecture Instruction Se=
t Extension Programming Reference May 2021, https://software.intel.com/cont=
ent/dam/develop/external/us/en/documents-tps/architecture-instruction-set-e=
xtensions-programming-reference.pdf=
