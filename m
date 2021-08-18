Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6EE3F0C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhHRTsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:48:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:56145 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232969AbhHRTse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:48:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="277434683"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="277434683"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 12:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="488858711"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2021 12:47:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 12:47:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 18 Aug 2021 12:47:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 18 Aug 2021 12:47:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlCZ8OCR/oOzPUvemBBNQR1M293M8l7SgABKKV9RvHYYoj1h0/ChkiF/jxmzIoH2WtCWrqCfF8+I7EAocP3CoF8UkSlc1NlzwHftMg0pEgBv0xkzO/vsNwxs0s4KXP7fxVeSU6qFoRX18/AxQsI8GI7bk9WNI0M6vXW3WikUWcA3s+T9q1HnDC/IRU8+rvdiL0l+FhylBH9t0y5S6h1IynHXuJZ8q1dnn8xNV8AKRTXiC9frm05RPNsuoOIQDPcqgqsq9WaN2WlBYK0zMrzgjlyxMIHiCMR9bKpZp0NdtRp9MrMBuPDvOT/JiX7pVuGy9sS4O9PcBx06dsOnmP8uUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8vwUxatHvebG/FEP1RbcPTiBSRJvjOf3feOYOXvNUI=;
 b=NcM8+CrisaEB9WS9vCz0SjfXmG1wjVXnMigbuyCgEZjbfL6J+wCnMjnZhVRIa+2BOJVTyClu7+BC2uWKujv2s3/pQ/tsUHCu/bO702VEjcxtN80GjXBLpUwAdVMhcf7y333CkqzKApOH2JFX9HwZ7rM5VvMFJ/hSpBxZAbQujFdKFmJntKRyKUAxBeMerJ/Io34dof097YTUtxPNVDL4emK/1nNcNHag3ujb+eTlJz5yELPJZZPAM4IgHpRtJ1IIjdJapdcfreWEnAmXwzJ2ndYhdl3ew6rozXVKxV/eer9Y4V8Yhh7kJCy1YinD+kLUIHtvDkgc476etoShbRh1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8vwUxatHvebG/FEP1RbcPTiBSRJvjOf3feOYOXvNUI=;
 b=W6DgCv8O9ZfnYmRZIljTeHsxF30/dN9qAGwfp62xymO44zv2E4uNbtq1+0wOcszcbpxhc8j/EYWKZzGC68SxTmOM4W/SrPXeKDMr4vSyt6BQotFhENw6GlEiishzUrqk62trn1FXT7VXy69IGusZ5Jh64J0iJEMvuakyfcBVOvQ=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 18 Aug
 2021 19:47:49 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 19:47:49 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Topic: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Index: AQHXhVRyjpE4OXS+e0aKA8ZshCCgeqt5kHqAgAA4tAA=
Date:   Wed, 18 Aug 2021 19:47:49 +0000
Message-ID: <7012BF86-4D1E-41C9-BDB7-70E8F4952144@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
In-Reply-To: <YR00U19168BGoRB9@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0630855-9b57-49cd-8ddc-08d962810f5c
x-ms-traffictypediagnostic: PH0PR11MB5109:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5109C50F78BA5DF085A37226D8FF9@PH0PR11MB5109.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0nm6Uylfeh9YlaMOEZdwzBgeYNtG76jVHeNddgBrDscP7/SLqiJky3kAwWtWkMFG9TjfB7uWZ55/bPu5jA9vtLPktzG9OUDbBRlMfBn2sUd6ZKEfnFAFNsuOKnzhCnc1bkaeVjuYcaM/hpiG+fuKFUjVuYLiLa+CoRQjUF11FzyAAKCYijvM7KVJS4/SrSkw5H7LTVZzK59NOuGOiOoUj+nEIbfRKb92h8BvTQjRj0LvDe0t1jN7S3mzwwEUb6s9zr1x4QthZPgxfJM8tqUkUabAIzKve71cNFUt7xIyaHEsCdpUMDBuxMk/MsHdQW+/F7doOcF2k1vk95v0ZeLpNTelWcMVfsRVZvmHGiBgYYs1az5VngwpZMr9viAlE/IB4bJs175e/TZVJ/7HNN1Wvx/UFYrUdZ3BBqrljNVx+0KmwV/rpFzJBCXIH5t8eKFLmFzo420OpTwbxYniMr/HhdA3Yr7eU8+7GmzmMSTP4QDc0Wq2pN6F2+1oF8disqyodOxcG+ZcyGd8Q92nB6GC9Tdu2C00EQNz2RZgmLkOTe2DSRMFKC8dXp6NZRKckoKLYG8P0iqHo2tS31Y7oSmKrZ7KcHxUnSX8pBQLgucbVSqbvvbDoyuRE05v2jD7NzLp8xwf4+vD+yS7EqTOIwjsE8q2hxpLr/MZWz8c7+6pikT56s9eldvkhibKDoQS5BcVGWEGAB6vaLHMjB2t7lQ63pPeaHecIns48vk+LEWSLslfI/cNKUMwc5Fts+/Vu5K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(8676002)(8936002)(6916009)(316002)(6512007)(2906002)(83380400001)(2616005)(33656002)(86362001)(38100700002)(122000001)(54906003)(6506007)(71200400001)(5660300002)(53546011)(4326008)(66946007)(6486002)(478600001)(36756003)(76116006)(186003)(64756008)(66446008)(66476007)(66556008)(38070700005)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gnUBn1eVHA3E2h85sS3ONxD36t7feNrVLe1aLqyxiGu3UK2VTe8QqnX0v7Dz?=
 =?us-ascii?Q?7jWYGnbwoxnDuOnH3SnW++kKjJeTK/erQbP6Knr6iWjgiq8KanrCLTsumiaZ?=
 =?us-ascii?Q?lv5HvP/nj4ff1OZoUyE5w+oC2kG1NrgkJqj5bDOLfNz5qr6eOCbNTfSChjOW?=
 =?us-ascii?Q?JlOMUuaq16ohELayDpHrf5wSQeIMIUL9QLT5gL0dQ3DJcjHa/HJhet+9Ju8e?=
 =?us-ascii?Q?I2SnyAo1H/pwtcs321x/PO6jppO6BkJ0j5cigmgVyOETeOID8R/985NarmA0?=
 =?us-ascii?Q?MV6+Ja58UdCRXLlWktWZ37fos3KOmSSSZcvwL42zYTkifg5O9jIkntBjN/6t?=
 =?us-ascii?Q?7fd5pRB8KlO/fTFKQjg9BbDuldUvTXO+akyORuuJqkKqyDGDAcOlgHTlxL/C?=
 =?us-ascii?Q?2ZY1L4nz4dUbrC9cBxKNBTxSeSoAhG1hXsNu4NHzFQ9kfM2KWGX984EDxoOg?=
 =?us-ascii?Q?Z6yLymYL7Z7zlYL1fKU4ncx0N298glSqiCZhCN1V3ACM9kHfaLQjXUuBh2Qo?=
 =?us-ascii?Q?LxqmHl25zzDJ/EqefSH36HZvxc5hLVKf0ztMfOoEfm/CgWh7dDt9o6XEZeKu?=
 =?us-ascii?Q?wYUh8lZzrYAzVQRXljrvOUkNcicnfg6It6LLE3tEV7JtSdK5069o0tPVVwzT?=
 =?us-ascii?Q?G2/2kpwJ7LSl8cwg9sNGAazDaib2rH3hyJYukJ9bVPbl+zN4hLfXdSWF0B6J?=
 =?us-ascii?Q?zFZGKVvvkt3NNeUQVWT/WDIX2yP2IgB2avfUcIHtJ8Pkdb/oJR1AjiJa2csR?=
 =?us-ascii?Q?BiqfImWFX6ZAJXFTwjEGXCAJ1GBzzmC1kKtLEfzWJBlYr0eptIRh1cUqmhAZ?=
 =?us-ascii?Q?P5Yxbf6agsEa2dMBo+rEhB5bkppZHuzMLe+8d51xO9neLOWg8IPSwIubxJ9D?=
 =?us-ascii?Q?dUgbOgv3m9wU7mobTtueeuU/mMCdH6N9Cz6PW9bmS+6Nah3aE1kq66ZusW+G?=
 =?us-ascii?Q?qXwvAWLpvBcodB/LRKbGstPmCYHBT7Bmd8QC37d5yK9KjSZ3amKCeXLMfBvE?=
 =?us-ascii?Q?m2Y8ok5XRm8PZAF4HBFirTwJ0X9z4Uime0obeEWfJj6YRr8xk+clwW8nIYdc?=
 =?us-ascii?Q?23R4owGWdSN3GdJSTKfN6iKkdVVae9fzzTccGlNga66br1HDfIwwOaUMJC1c?=
 =?us-ascii?Q?AJ7yxhuTGT7aaXCpQ4MysnWXF32F5jFFxU0VlalwulpNnz1xRK5U7m2OlQd0?=
 =?us-ascii?Q?IjYHRqBaXEkqV9GaRe4Oeco6GY4mh8naS/VcC1E9mNwLi3gT2t//wwa95Mi5?=
 =?us-ascii?Q?US/vwM+IKKbU2CaVU2qBVgu1WxMLoOlVMfUUdVFyFh98PqYOgnDRTgK7aINs?=
 =?us-ascii?Q?NnC2JsRTfbXBat+Lm+2mY/eU?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E22C133022165043B962ECB2624EF851@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0630855-9b57-49cd-8ddc-08d962810f5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 19:47:49.6298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRaA62YK9CAI2oIBthVKNedkSjiJMiEZ6uN3bwjvtCYcSomlWerNuX9LIouaEU5eLnUQ5UY4p50E99G9TAfgDlI8is30xOrJThiPh0I9mzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Cut out the API comments and other obvious ones here. ]

On Aug 18, 2021, at 09:24, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Jul 30, 2021 at 07:59:43AM -0700, Chang S. Bae wrote:
>=20
>> +/**
>> + * xfd_switch - Switches the MSR IA32_XFD context if needed.
>> + * @prev:	The previous task's struct fpu pointer
>> + * @next:	The next task's struct fpu pointer
>> + */
>> +static inline void xfd_switch(struct fpu *prev, struct fpu *next)
>> +{
>> +	u64 prev_xfd_mask, next_xfd_mask;
>> +
>> +	if (!static_cpu_has(X86_FEATURE_XFD) || !xfd_capable())
>=20
> cpu_feature_enabled(). Use that everywhere in your patchset. But you
> know already...

Yes, I did on my local.

>> +		return;
>> +
>> +	prev_xfd_mask =3D prev->state_mask & xfd_capable();
>> +	next_xfd_mask =3D next->state_mask & xfd_capable();
>=20
> This is just plain misleading:
>=20
> You're *AND*ing a mask with xfd_capable?!?
>=20
> Just use xfeatures_mask_user_dynamic directly instead, as already
> mentioned.

Okay.

>> +	if (unlikely(prev_xfd_mask !=3D next_xfd_mask))
>> +		xfd_write(xfd_capable() ^ next_xfd_mask);
>> +}
>=20
> Here too.
>=20
> Also, I must be missing something. Let's play with some imaginary masks:
>=20
> prev->state_mask =3D 110b
> next->state_mask =3D 111b
> dyn		 =3D 101b
>=20
> ("dyn" is short for xfeatures_mask_user_dynamic)
>=20
> prev_xfd_mask =3D 100b
> next_xfd_mask =3D 101b
>=20
> if (unlikely(100b !=3D 101b))
> 	xfd_write(101b ^ 101b) =3D=3D xfd_write(0)
>=20
> so next has bits 2 and 0 set but the xfd write zaps them so next won't
> get any more #NMs for those states.
>=20
> Why?

Because the next has already fully expanded the buffer -- its state_mask
equals to feature_mask_user_dynamic.

No more XFD event is needed for the task.

>>=20
>> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
>> index a58800973aed..dd66d528afd8 100644
>> --- a/arch/x86/kernel/traps.c
>> +++ b/arch/x86/kernel/traps.c
>> @@ -1112,6 +1112,45 @@ DEFINE_IDTENTRY(exc_device_not_available)
>> {
>> 	unsigned long cr0 =3D read_cr0();
>>=20
>> +	if (boot_cpu_has(X86_FEATURE_XFD)) {
>=20
> This whole thing wants to be in a separate function. Even the
> indentation level is begging for it.

Ah, it was once in a separate function until V4. Since trimmed down quite a
bit in V5, it has grown from there.

Let me fix this.

>> +		u64 xfd_err;
>> +
>> +		rdmsrl_safe(MSR_IA32_XFD_ERR, &xfd_err);
>> +		wrmsrl_safe(MSR_IA32_XFD_ERR, 0);
>> +
>> +		if (xfd_err) {
>> +			u64 xfd_event =3D xfd_err & xfd_capable();
>> +
>> +			if (WARN_ON(!xfd_event)) {
>> +				/*
>> +				 * Unexpected event is raised. But update XFD state to
>> +				 * unblock the task.
>> +				 */
>> +				xfd_write(xfd_read() & ~xfd_err);
>=20
> So AFAIU, xfd_err points to some other feature which caused this
> exception.
>=20
> So if that feature bit is set in XFD, you're clearing it here. Why?
>=20
> So that it doesn't raise that #NM for it anymore?
>=20
> This looks weird.

If this ever happens, something might be wrong with the hardware.

If the bit is not reset, it will get stuck with repeatedly unhandled #NMs,
which I think is even more terrible.

>> +			} else {
>> +				struct fpu *fpu =3D &current->thread.fpu;
>> +				int err =3D -1;
>> +
>> +				/*
>> +				 * Make sure not in interrupt context as handling a
>> +				 * trap from userspace.
>> +				 */
>> +				if (!WARN_ON(in_interrupt())) {
>=20
> I'm guessing that's supposed to stop people from using AMX and other
> dynamic states in the kernel?

But the kernel can handle this without XFD?

Thanks,
Chang


