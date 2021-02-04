Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682E130ED58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhBDH2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:28:43 -0500
Received: from mail-eopbgr1400081.outbound.protection.outlook.com ([40.107.140.81]:36352
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234509AbhBDH2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:28:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhVerna67aQNu2cYN1kwaBr0Lsg5Ufnhml1BP43AgzemAtLgdmdgZd7cnGFQd2CbpsZi6TNQgVFtol13oeacyJmGK9mU3x7JxQdfFX57D+bD9/RzRmb3fs2prB412W9cHLDDliCjlhmr+n/YOE4cMn8bGTCHGoKDPM0qoszYB5+EJ7ZW275PL+lfPHMqkFc0lyfthvQrjRKkE2NiWO1TRLe7mLF4fBCfNSnH2V6LkMNQMLqpgk0BXCm7MzP5/qXLUXvTm9XYbN8KrqAVc5bSRUiIsOwa/G65o6VvbeGAs/nhK6gFcbI0NMk6BSBameGCAbjoVCV9l8RcWa1jDpbcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LecriwBT6qVbIG6TCnIvu4moI89380w82UiWCLljcuc=;
 b=fpKu571EJndH6Mm6oVMSuxNYNHxlHpWQi5gb1MhU8HXKLHT9fM2834Kw3cNQGLtTPqq/aNT1hsfarPeYU2zHmY16tpcrur4xmZKe2hwERCT0rWUCYRH/393/4PPyioqV1t6E9901rmXyHND0SMSuee3WO6G8p/FhDJGLPRNKHU1Vv7GNpSUh6QzfZGgngpJBVhOPesYQ2Atz0LXFQvV3VLHnheORebC/VyGiIpetxlIte/aSBrUAdKegH6UBoI3Wct5UdVev4g6Wc09MoBUQYmW6we1sVfPS+aZ8iMLSSqC6FLVGU0jCtMyrlQwmRb7jIV2y/K19mLffekrF+iOGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LecriwBT6qVbIG6TCnIvu4moI89380w82UiWCLljcuc=;
 b=PsHWFaHM+abM/Uq3qoZgP3xt5Es8dP9SGryJxcD0ydDSqaGhvMbDvKmV1vSwukrOatEju5plAFOGRXuIa2mkEySm2Yd1EzifuZPqf0af2NYLgw++6+iB6CMw+/NfVZDxoJgUmaDMBn6JpUBkDrlXeGXx1LeAx+b6A9l9GXQyByI=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYBPR01MB5344.jpnprd01.prod.outlook.com (2603:1096:404:802f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Thu, 4 Feb
 2021 07:25:58 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1d15:6a82:ea9b:5101]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1d15:6a82:ea9b:5101%6]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 07:25:58 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Aili Yao <yaoaili@kingsoft.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "YANGFENG1@kingsoft.com" <YANGFENG1@kingsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Thread-Topic: [PATCH v2] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Thread-Index: AQHW+HLnmNDQRaoKqkifESD/mJ9TwKpHnQ2A
Date:   Thu, 4 Feb 2021 07:25:55 +0000
Message-ID: <20210204072555.GA22850@hori.linux.bs1.fc.nec.co.jp>
References: <20210201161749.0e8dc212.yaoaili@kingsoft.com>
In-Reply-To: <20210201161749.0e8dc212.yaoaili@kingsoft.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kingsoft.com; dkim=none (message not signed)
 header.d=none;kingsoft.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7408a35a-b6ee-4551-af41-08d8c8de1dbf
x-ms-traffictypediagnostic: TYBPR01MB5344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB53446AFD6A69989FCABE74BAE7B39@TYBPR01MB5344.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TDTPgPleo77NmYzAkyb1+sOrORr9a7Zy1Vdd6WdGTpqEVB4jhBrApoLrz/bv6CReQGVksLIGz8MHZxXXdnn/cKqZ1zvtUi3VVhK43wxN4wU7az3cOswQ24w3JELjIOevumIXkgD/qLtrihJ462GR+oLGBzUK94ZRj3EncvvrG4uNEnzinmmajc5zKrZXIyEfNQqDFqX9JtA/1AksGvCibamvgz5iPu0j9kmW0LB5mfF9FPOP5BiqKsoc1YyhdI5PCo8B1njjBC9gadS1gxS7TOZ5W4oH69GRyDyGBXNo344EfquwBOtO5Y870OwxwktGEiDcar7LbdsbGGO8Mwf0jiBvyXJBhRsXeBZstn39RWjop9sE8RZKGKciicrgohXNFgWCxPWUORP1HkDxVBqQFShAMX4nsFklH57HMq6j8OtvVFFHElr9ZqpfmnG99E3A57jaD6KgwXHQyBlHGXZH/pViLyZY1gjOOwhXO7qfsp2/S5TnbAL3sdqQhBi/EK8Xt6w1ZUgy8U2/uNO8xc1VNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(478600001)(6916009)(4326008)(85182001)(76116006)(54906003)(316002)(66556008)(83380400001)(66446008)(64756008)(66476007)(186003)(66946007)(8936002)(7416002)(26005)(55236004)(8676002)(71200400001)(86362001)(33656002)(6506007)(5660300002)(9686003)(6512007)(6666004)(1076003)(2906002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?SCtlNXRIUXdOb01POW4zTGZJQmM4Y203V0FGNU9lSWpyWFE5S08rYW5M?=
 =?iso-2022-jp?B?OS9US0VPUEs3ZHRBelhhcjhhd2Y3a1ZiOUcyWFFOTklYWXp0TDFadmNp?=
 =?iso-2022-jp?B?NFBzWG1GMHE3WXBvREdlN0svdUhPRFZtbG4xTEZJV0c1NUVadFhwTzJx?=
 =?iso-2022-jp?B?WGhnZ1dlWitneWFkV0tEWWt2WVNweDNGek9oRjQvenNrbDZTSktweWRS?=
 =?iso-2022-jp?B?Y3E2Y205TkFnMTk1NlJwQTBWa05uL2d3NUgySnhlOXhwcVZDbDN4Q2lm?=
 =?iso-2022-jp?B?ZFh2Tm9Hai9FZlUwaWZFNTlUTitEV3ViV1MzcmdLK2xEUC9CL2tnYXow?=
 =?iso-2022-jp?B?K2VCVi8xek1lZGEvOTJGQkhWYk1kYmJ0SW54SEo5Y0dOSXc1TlRoZjM1?=
 =?iso-2022-jp?B?ZjBZbnl6L2RlRHMxZ2JISWtmUzNCRTdadUtvSXQ3emJyRE11WXU3RHZl?=
 =?iso-2022-jp?B?R0haTko5YzJIOUJwem1SdmV0NFZpUTlSODBsY0FqbkdoSUpuWkVDQm9D?=
 =?iso-2022-jp?B?TEVKdWpoZ3hPK2JJTEhIWG94SU8zZkJuUU1jNFAycmxDWkJjYmgrY1Fo?=
 =?iso-2022-jp?B?a3czWjRZVGEvRExna2tteWZUZGQxczEvWnR0OGRjNEZ5WjR0OVZEVk10?=
 =?iso-2022-jp?B?blJ1Wi9ucHJuZ29La2VuSU93UDZKcVQ1bmV2ZTRYeXNHTmRvZHMzTmdL?=
 =?iso-2022-jp?B?MWRWaURsbUZhcmV5SnBBc2duSy80SUpoSnNYWWRvMVFJU0ZvZm4vMGNX?=
 =?iso-2022-jp?B?WXdEVE9LelV5aFgwYnd3eVR4UlFGcUdMWDJmLzJmRm54aEJodVIyQ2E1?=
 =?iso-2022-jp?B?bkxHNmg4aGFjS00vd2FzWERpYm10azZMd0FlekVvRFVibk16QmhmOG15?=
 =?iso-2022-jp?B?Yi9OM1lwZlhtQnVoTlVVMlk4Y2F2WDQ4UE0rVUNBTVpqdG9mQlVXUGJn?=
 =?iso-2022-jp?B?NEdmUTBXTEJwckNPc0dJTzVlbUJHM3FzU1BVRnRaYWFiMzg1T0JQMGdL?=
 =?iso-2022-jp?B?OVdNRWR4ZEJYWkVBbVlqOHJWd3V6N0w0eVJwME1vTnlya0NMWEhrSlZP?=
 =?iso-2022-jp?B?WVpxUGlTeVVjTFFLbFdjc1hsNnlTQzQ0QlhaanZ1VmJoL0d2Qk01SkNu?=
 =?iso-2022-jp?B?cFppWXRCOVpWTmhnUE1EYlVXa0J6a0k1c0dHZ3lCb3NTWlFLZTJxQVkx?=
 =?iso-2022-jp?B?SWM5dm14MEhUS0tiU2huVHpTTWczdHcydkpvZUc3R0NiOEtodjR1MGtX?=
 =?iso-2022-jp?B?ZTBQMk5raTdwekRpakdwUm5IR0dxWkw0eDFUYTNTcjIzcWdSaVVQVFE4?=
 =?iso-2022-jp?B?bzlHalpaTkJJK29WTWNFRUNDR0U1ajZkdmQrc3duSXpaRG4zWUMvQ0Er?=
 =?iso-2022-jp?B?WmJZNzhwbTRBb1BaK1RrUEZPVkVmWHR4MjE3NlBtckFsY1JaSU9IWnR2?=
 =?iso-2022-jp?B?VmVHQmdabkRsZ3JEL2xjaHBNWHlINUFQWWhQNFowTnd4MXRVcTd0U3l4?=
 =?iso-2022-jp?B?b0VTa2gvVjE5azZVNFAyVmxWa1Awcjg1UW5heHBVRGFWTFB5RjVQWko4?=
 =?iso-2022-jp?B?SnJaaWE5TkV4c0xtSFNDL3pBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <5290B686DEA80A40B885E2B307137BFE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7408a35a-b6ee-4551-af41-08d8c8de1dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 07:25:57.8702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qZlC2HaA1iYnwJUU+j64eJbTuvN56/hejJeCxkkk/sD0e5A110eKBoPGV4sqfCdwM3NvqyfwTN+EWoAGXuLfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5344
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aili,

On Mon, Feb 01, 2021 at 04:17:49PM +0800, Aili Yao wrote:
> When one page is already hwpoisoned by AO action, process may not be
> killed, the process mapping this page may make a syscall include this
> page and result to trigger a VM_FAULT_HWPOISON fault, if it's in kernel
> mode it may be fixed by fixup_exception. Current code will just return
> error code to user process.
>=20
> This is not sufficient, we should send a SIGBUS to the process and log
> the info to console, as we can't trust the process will handle the error
> correctly.
>=20
> Suggested-by: Feng Yang <yangfeng1@kingsoft.com>
> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> ---
...

> @@ -662,12 +662,32 @@ no_context(struct pt_regs *regs, unsigned long erro=
r_code,
>  		 * In this case we need to make sure we're not recursively
>  		 * faulting through the emulate_vsyscall() logic.
>  		 */
> +
> +		if (IS_ENABLED(CONFIG_MEMORY_FAILURE) &&
> +		    fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
> +			unsigned int lsb =3D 0;
> +
> +			pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at=
 %lx\n",
> +				current->comm, current->pid, address);
> +
> +			sanitize_error_code(address, &error_code);
> +			set_signal_archinfo(address, error_code);
> +
> +			if (fault & VM_FAULT_HWPOISON_LARGE)
> +				lsb =3D hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
> +			if (fault & VM_FAULT_HWPOISON)
> +				lsb =3D PAGE_SHIFT;
> +
> +			force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);

This part contains some duplicated code with do_sigbus(), so some refactori=
ng (like
adding a common function) would be more helpful.

Thanks,
Naoya Horiguchi=
