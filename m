Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDC631D07E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 19:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBPSyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 13:54:05 -0500
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com ([40.107.236.55]:13408
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229780AbhBPSyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:54:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQ6wVuzHSVF3KQtIUe4Cg7OmjLur5imqa7CVd+AXQPlKVrQ6iNhllHPcifKxjkjq8jc1xOSYsPTvLhl/HSGPOX4q7OPXkjRU3gCUlNoFdewiV3/GV5KlzBGUgSa75e6AzPciS1AZ3f4CrNnzzUgJUuOCqlLaho+l1G3EqidpBA1rYdXzaD9RQUt7kOqorar1L6gy+ZsHJRYEU49uuuRpFxBWo9OB5sGtI5tFPe4sbTDxGALvRmHLKSDCvd75HAdT6Cng6gH0sYkYS8w1nX8YBcR1yjQHqNBun4lOinOgBqpukkfp2LAa2vrsimuj+l0zIyl7QoO0R8JUCJVPMBMMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72J6eD0BYMFMjGhRR5I9MF0IR8qTv5i00JsgZYecNgQ=;
 b=dDMya8AHRHf3SWi11oLcFjGTffSLlftOUMwSDuSkXvCsvlxMJGgpkrRegAxbgs4gaORXWM9Y43r3VdScoCD7nAXtlbidIQfKDzOE1w12VhzmQL76jdd37UIRSkHJR3EtMEkv1sKxDhAJpOPDDf+8LQQPwVyzPHp4y50QvbrE8gJEjaj4lS08R1/jFAl0i0/U8aaG7/R+XsQV5E0YbBkIBb57S+7QemzEiQB3WZKbKCP7wJ82ZJJslWTppjW6urRqe76LaWAQ47VmUjyd38ewcam9OWkSOOwS9nn15vTxoou5sRRZITWhMuIaDcwR0eRETqUKh8fspmNlLGR9JLjvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72J6eD0BYMFMjGhRR5I9MF0IR8qTv5i00JsgZYecNgQ=;
 b=oF9p7FLiv8zccIr9ViCJXejlg6d42GL8VeBIk+JsUvgkyrI6FIQit4wyHOV4sBx2tKSA808BQlSzAa7cK2ODdkriPQ38g/6vBRFOuRx6rwmiAwbl+Te+4O367Y5ErkipWwV8c+St1Ykxsbj0YHgVP6tVrzP6hVU2iBN8vCI4UME=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BY3PR05MB8083.namprd05.prod.outlook.com (2603:10b6:a03:36e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Tue, 16 Feb
 2021 18:53:09 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31%3]) with mapi id 15.20.3846.039; Tue, 16 Feb 2021
 18:53:09 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Thread-Topic: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Thread-Index: AQHXBIFqKsC+lRA3wUC6VAD48B2JFqpbIOyA
Date:   Tue, 16 Feb 2021 18:53:09 +0000
Message-ID: <457D8FBC-8F64-48E9-B9E2-1A316DB0C2B6@vmware.com>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-2-namit@vmware.com>
 <YCvztEk6sqiCxXZV@hirez.programming.kicks-ass.net>
In-Reply-To: <YCvztEk6sqiCxXZV@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94bb6361-0d0f-46b0-24cd-08d8d2ac1ab5
x-ms-traffictypediagnostic: BY3PR05MB8083:
x-microsoft-antispam-prvs: <BY3PR05MB80830AD21ECC612B1C335AFCD0879@BY3PR05MB8083.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hbn31Ax0n8HmyDt6VayPJYdVHdJNLXSbhFpt9oJxXg3kXzXB806n5MAzqxSZOERXBWO9N3blYGkamZK8BN/YvoGRAFKby0GP8GkxHBdSPABkAH1Fa2c9sonniX2M1qIO5c0LlR+jS2a8CirMgyv14VcqwaZm5W/MgLwOzqL+HduR88NSx2PFEFIH3DxSBjfTLuAkHIDj0LAKSBh1a6SpA5ID8DqKic/lU+Vg92/YxAgWNowfSC3aUq5qGZ9oIxvgnr0PioxNauMg+wKEAWGfmznEoIlf4p8v8KT7eWawhiiHMCOASCPXtZ5sYdvYmyyAfDU4FgRBSuURUt/DV6kyvOla/st7D4zaJJRWFs7S3uWmfgDK67WDSkIrj0Snh7knB+p1xXLNXxl9v83GF24HvQyb+kPigT9VUzj7PhBgFr6lBGEF8lxD67OTENfhqTZTOEeUsJ0iDlTeihoxnkrzxOadcmavbJTN6Wh+O3XVZJsK0yGtN5WrBSaK8Nx0MJFK+buYQy1Uu2PaSUS0OKNPhSWzKeIST9Yt5XWoVMQuRrFH7YfcrIFjiMi/Oo6f7tFXi3+ND4Gq9mL6ilfrea5st4hM/jO3TFuArR6u5ndksD7Z6CPurb59yqbCcN8nq6TLO+FhDPP8ofeJ9Cxb0WN8Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(5660300002)(33656002)(4326008)(6512007)(6486002)(53546011)(478600001)(45080400002)(66946007)(966005)(8936002)(2906002)(54906003)(86362001)(316002)(66446008)(186003)(66476007)(66556008)(76116006)(26005)(71200400001)(36756003)(2616005)(6916009)(8676002)(64756008)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pD8wKRFC8s1H0g7vQ/NRfTcd3rSkCFEEO/N0+OIhQEG2RHfOtPVyB0wms+6R?=
 =?us-ascii?Q?m8F0rFe6TV4dygUpe4LYF9PC5XYpYjqm7ohjZbiDQR7vn0dBFE0r5ztT+iZe?=
 =?us-ascii?Q?MHJeB5puZrAS/gbwIGv9AtQY/hVR/M9OBLPTT+UoprT4NXMpomdg2lHn9K2/?=
 =?us-ascii?Q?JVsMuIlwrfZL1gVPXFT57IM0nKpq+el3hCD/6kajct7lYGGueyYWUjAuT66z?=
 =?us-ascii?Q?U79rmDiNRNqWTTjLzNQTY9W5ZNSKttt162YKPDDmaS1ZMy0+I1mXdNiFbI/3?=
 =?us-ascii?Q?hnGJYQOV5mlCyUk8awsr4HCOGXOGYAcIBBBF5I2MyAjzV+OPSsVsjZf4jyOT?=
 =?us-ascii?Q?6xY3VWJIXzw9ArEw1SJgPgMwLDmZnClnjMsc3gWyCmTvin5j2hIJ3H/gL2Lg?=
 =?us-ascii?Q?A2dm1X3B3jJtLIk+6EVl4ki4nkJGBnYkNjf1WiJviYws2rw/dcKiHb71yYmA?=
 =?us-ascii?Q?7gg/gByg1AVezUbmQ1EZc8XPsgEdacmUmDz9UslJyDxTFxfIFK3Bol4B/IW5?=
 =?us-ascii?Q?6TqANd+3/Sre1q5Di6ChJ1wykrkXdOy4zRgPSHJwh928F2Whzi+1tQJ+svUm?=
 =?us-ascii?Q?B/rBnJ03KoyIwrzv2vTWgpy9GrpHuipqOnefmUqJE8AjXft2s9JaK6inBbhh?=
 =?us-ascii?Q?i6RCLWasSIdSuXOrDgVdwkSbep718T8mahoSr19m7Er7SoYhu4C54fxJMj80?=
 =?us-ascii?Q?9zIfPXXRerDy/fLP0GbscekFz8Pd5S7viLtYhMtZdhhSSp5gxAiAOWn3voo/?=
 =?us-ascii?Q?uqW5kN3W2jFNn/33ri+9fbDH3saMnB6HmXu5YbKGC3wvg8vj06vaKc6vvKKT?=
 =?us-ascii?Q?sELWpGCguQdMOrRxZZ7pZd9I4jqwfQngRN4EdV4vzVtOuKKo95zott53T2S3?=
 =?us-ascii?Q?LgETiAyypbtgB+cFU00WySCxSV6JeH4yDQAOQYOpgXrPnkOIG1IH9Lao922M?=
 =?us-ascii?Q?yhrcQ3l9EWQaE7vnRWPID05xqyMbfYIeQ6LCGpTkSSsQF9tcwG0EqJ1Vb7C8?=
 =?us-ascii?Q?5wX/SylzrpNv9V5RqeGqFX0mmOl5zf6S6d4hoPL96FPduTuPbs/BomtWgaLK?=
 =?us-ascii?Q?klGeQKQTGGjxor4LT5exONRPN8/E9rYxkvryOtantsoIh4YuNgyCJ6dDhtj6?=
 =?us-ascii?Q?+H7zHmd5wujuvFMrcik+I08EbwNc9/vqJrBs5n/DbiQVXFQpPIBwp9w7yKFh?=
 =?us-ascii?Q?gyPOa7JH/gJmXjxB/2QYwO9P2f1hS/fw/xDeR6Znr24LsBy3iqLje9lLejcP?=
 =?us-ascii?Q?1zvKq11cRhm51H7KAxisrSCtGLP3mfDKPHCRfNpnLM9DFCeqvn+Ux01uA2Ka?=
 =?us-ascii?Q?3DYd5jmVZsEt1GN2GGiRfT8P?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AFF5442886F90849AA365A2E617C23C9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bb6361-0d0f-46b0-24cd-08d8d2ac1ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 18:53:09.5939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/wsIKrVNX+vb0Cu3SZqbjpkFmHKj935p10TR/qso1e113ZOXXryFYv5s4hNBPuh5scnYLsXYPrhe8Xf93J11A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 16, 2021, at 8:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Feb 09, 2021 at 02:16:46PM -0800, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Currently, on_each_cpu() and similar functions do not exploit the
>> potential of concurrency: the function is first executed remotely and
>> only then it is executed locally. Functions such as TLB flush can take
>> considerable time, so this provides an opportunity for performance
>> optimization.
>>=20
>> To do so, modify smp_call_function_many_cond(), to allows the callers to
>> provide a function that should be executed (remotely/locally), and run
>> them concurrently. Keep other smp_call_function_many() semantic as it is
>> today for backward compatibility: the called function is not executed in
>> this case locally.
>>=20
>> smp_call_function_many_cond() does not use the optimized version for a
>> single remote target that smp_call_function_single() implements. For
>> synchronous function call, smp_call_function_single() keeps a
>> call_single_data (which is used for synchronization) on the stack.
>> Interestingly, it seems that not using this optimization provides
>> greater performance improvements (greater speedup with a single remote
>> target than with multiple ones). Presumably, holding data structures
>> that are intended for synchronization on the stack can introduce
>> overheads due to TLB misses and false-sharing when the stack is used for
>> other purposes.
>>=20
>> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>=20
> Kernel-CI is giving me a regression that's most likely this patch:
>=20
>  https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fkern=
elci.org%2Ftest%2Fcase%2Fid%2F602bdd621c979f83faaddcc6%2F&amp;data=3D04%7C0=
1%7Cnamit%40vmware.com%7C7dc93f3b74d8488de06f08d8d2988b0a%7Cb39138ca3cee4b4=
aa4d6cd83d9dd62f0%7C0%7C0%7C637490899907612612%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3DPFs0ydMLh6xVfAQzAxSNd108YjxKMopNwxqsm82lEog%3D&amp;reserved=3D0
>=20
> I'm not sure I can explain it yet. It did get me looking at
> on_each_cpu() and it appears that wants to be converted too, something
> like the below perhaps.

Looks like a good cleanup, but I cannot say I understand the problem and ho=
w
it would solve it. Err...=
