Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2995D430AE5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 18:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344271AbhJQQtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 12:49:43 -0400
Received: from mail-eopbgr00106.outbound.protection.outlook.com ([40.107.0.106]:64697
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231742AbhJQQtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 12:49:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqFz7DI3KYwvoV02VUbbctR+1HDRDsBqv4oM7UMEPp1FA64usB6NYkUStEbLikrrv+ALaRK2HndbHF++6w32cxg0ZxYsCm/Ktxs2DtT2CfMIApOfoxqU5kc+3OcVuYY6y1fyRwL602Wib+j0mzczlkDMGk21lhuvOWD1glENm/N102ioY+xw5gcuXZYOQVPuOKWSNFVYg4LP/z9dUL6G8v/DKhbhKE+9UAqsKMBWUZln3vuzksCFrDjE8gfHrmbFHfGO6fKxz86SuGerkOTS1Oo3a8E4nvKkj68gszG/i457wKiMfaPU8g3emoZp7f2FBPBnfMWAS8vAKeCga4IfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFo+h3FMK46xZco9Yx8fvqfTC6S/9V1uuDI6YMaX6xY=;
 b=cn5Lve3zegv5oWRyEyeQkf1AZeKh2xyAKuyZzaheA8r0vWhS0WZnTUIZ+7fXGveO+R1MEE4YElCrENgsNxtc1par0W74ZxD6vfJLsxzXzmmZj2DUk4ZYYBch9v+HeQVqvKT3KtaK1dgCknpXH4nkfuoAk/1KUaCFcv4k2i1vwoP9EFYc6DuY6T0Nhhl5TReQthJdRxeitqQBEy3J62HxXz4qIE7dLwkjBEHoXJ/J7wdvEPf7QlMSNLEp6XUII+HLi4R7nB0FkE7JbawDkbfuAEhS1x8HT31qxBI7jseYiBDbN8ivjvPnreEe/2Lo/rCarVcKqo/5FbiMjB2tUtb7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infomedia.dk; dmarc=pass action=none header.from=infomedia.dk;
 dkim=pass header.d=infomedia.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infomedia.dk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFo+h3FMK46xZco9Yx8fvqfTC6S/9V1uuDI6YMaX6xY=;
 b=Jcj5c7d/W4QUdwH/unEuUTYTHwKTE6hzVKF9DGbH9NJp6GK201a/QBYQzyMk3u1lfg4D1XbQO3xJaaLtzbm3dU8FY6XXlTLKbpQUatnw7QY34HxOr8D6Cuzfjv9/XoWnqHji4F4AKwMEOFvOxySnPu3dbV85dWZjfdrIfeEgtBQ=
Authentication-Results: xmission.com; dkim=none (message not signed)
 header.d=none;xmission.com; dmarc=none action=none header.from=infomedia.dk;
Received: from PA4PR06MB7263.eurprd06.prod.outlook.com (2603:10a6:102:f7::10)
 by PA4PR06MB7246.eurprd06.prod.outlook.com (2603:10a6:102:d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Sun, 17 Oct
 2021 16:47:30 +0000
Received: from PA4PR06MB7263.eurprd06.prod.outlook.com
 ([fe80::428:6cd1:2d65:4314]) by PA4PR06MB7263.eurprd06.prod.outlook.com
 ([fe80::428:6cd1:2d65:4314%7]) with mapi id 15.20.4608.018; Sun, 17 Oct 2021
 16:47:30 +0000
Message-ID: <24192747-7f69-ef22-7bf1-96b2e7c2bca1@infomedia.dk>
Date:   Sun, 17 Oct 2021 18:47:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [CFT][PATCH] ucounts: Fix signal ucount refcounting
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Yu Zhao <yuzhao@google.com>, Alexey Gladkov <legion@kernel.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        containers@lists.linux-foundation.org
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
 <87ee9pa6xw.fsf@disp2133>
 <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
 <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
 <878rzw77i3.fsf@disp2133>
 <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
 <20210929173611.fo5traia77o63gpw@example.org>
 <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
 <20210930130640.wudkpmn3cmah2cjz@example.org>
 <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
 <878rz8wwb6.fsf@disp2133> <87v92cvhbf.fsf@disp2133>
 <ccbccf82-dc50-00b2-1cfd-3da5e2c81dbf@infomedia.dk>
 <87mtnavszx.fsf_-_@disp2133>
From:   Rune Kleveland <rune.kleveland@infomedia.dk>
In-Reply-To: <87mtnavszx.fsf_-_@disp2133>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0003.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:12::8) To PA4PR06MB7263.eurprd06.prod.outlook.com
 (2603:10a6:102:f7::10)
MIME-Version: 1.0
Received: from [192.168.1.102] (84.212.50.24) by OL1P279CA0003.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Sun, 17 Oct 2021 16:47:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76eed81c-4d40-47c6-630a-08d9918dcf65
X-MS-TrafficTypeDiagnostic: PA4PR06MB7246:
X-Microsoft-Antispam-PRVS: <PA4PR06MB72462B0085FCCDEAF56D2A87E5BB9@PA4PR06MB7246.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaJTkig8nCleiAjRHDZAxZv8UeDB361yiivZOrNBFDJFusy89ouT/L+9G3GeyttM7ezAB7Kk5AJqw1kw2CR0ir29YdNKYnd6/6RCBRVl6xyXDpwhDTmTp4eUutPYKyJDc2FG/K+mH47JXjrwRdDz7itkkYqK8k0Ep55m2sBrnsNPRun/D/dhr3xWzKnGdm6FmzVaiCKtR/QodIq0MtB82cxOm1T+lfpz+2AQWBE3Pnn0QzayO2EjxtK0BGp+JfbtssgonYH/ZLhFVIj/o805jvmgvr2mLg/pkZEPjSXtxRof+OG/MD3za2OWUScJaGpDgNGn1Qm2Gu9Ix9w3muIM6YkY2S8T17tk6K23QKmQmZKoYgilul3tYdhfZeFDJEhRT3JEjQjz9sWyMSD6Gm4kiyEhpQ+5sPo+sZ6GyhzyPBwHE7W63VtcbUuSG7eeGp7+rhEnBz68Iz/Bro8Lz9hURnPpvZrhRrFuWP6KVRF7+b9gqru66TIGr1GhXT0d/U2QxAZo0U+dwzmj66LtAvpT5Gi0E8FvBjikdeIe+zNUcllWzNKCAhlTiMMY20JpPbdmH63V02hcxGTVzm1j3lea9fuoTuB6Vf39fTaHfOBee7FNZRfU3ChHhiNVWjubkERJgZbZJ5JnqUX57AUC377K8UnAIayfBjN0abz7++dWPOQb2JqkAxjuT8pVkFM8aN4+yZaNzAFik2l9DYlMmzeTUY67q1wbaLLKhUMHst7edCgJ9kPKCdsCVKkUNuWsxsxIoX3kcxTc7wPfhkOHY8rQww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR06MB7263.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(136003)(376002)(346002)(366004)(956004)(16576012)(6666004)(316002)(86362001)(31686004)(2616005)(83380400001)(38100700002)(26005)(8976002)(52116002)(66946007)(31696002)(36756003)(4326008)(186003)(6486002)(2906002)(508600001)(8936002)(53546011)(5660300002)(8676002)(44832011)(66556008)(6916009)(54906003)(66476007)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUYwd0VOVEp4SzFuY3pPdXhhMHBwR25GYmdJb1RuZURiY3RvbDhwS09kMVN6?=
 =?utf-8?B?OWt3bnBQZjd3aUhjSnVvaWFFeWM5RDZ0Zk1FMkwzaUxRd0g4UFNERWRsUjJQ?=
 =?utf-8?B?VU5OM0VPZENRYmZIN1hqaTBkbjN1NmNvRTBMNjBtVFR4M1JsVldYZFY0M1Nj?=
 =?utf-8?B?L3pOOUhKcVVLRXZrN3NmTVAxRFE5ZVJCYkRMSlRNQTJQbHNveHhLN2NOT1ZX?=
 =?utf-8?B?bHFTNTJnNWxrTGFILzRBRWJoeDdJS05pZ3NWY0dScm9pY0craHRGZXhDOUlY?=
 =?utf-8?B?WVMyd3VlMU01YkdKTGhCaUVDV3VNUWZxWHQ5RzEyaEltWk4zRlZnbURwTHJq?=
 =?utf-8?B?UVdpcjhka3hYT3kwNHVHaTQ4amlyanoxK3ZDNUlYclhJNVVRSzQyK2FiS2pr?=
 =?utf-8?B?YS9kWkNhL3gxZjhJY01UNTJTMXRrVmpuZWNEU0Q4bWYrZ3VLYWpyQm5zU0Vt?=
 =?utf-8?B?UDBIVXZGcFoycGsrU2ZhS1BVcEF3aXpDR2ZXN1NJRUlzZjl5czNlMm1oZ0k2?=
 =?utf-8?B?T0t5RElBYmc3MDhwU2k3MDBFcHh3bTczTmcrQkRvYVZQVWVlNU0wa2x1b285?=
 =?utf-8?B?SERDd2pOa09MWEZkaVQwSlA4Wm5tTkVZeW5UbXBBejd6RUxhNlNSU3VYV2Vr?=
 =?utf-8?B?elZsK2RGWFhJV1FmLzUwV2lCTU90dndQaUttRjNqenZ0ejFvYXVTdFFYdzNH?=
 =?utf-8?B?a1NuQlZOQVcrUjZCT2tZdkwrNVNUZjBrUDd1d1dTa2xhSHRtbzd5anJFZHND?=
 =?utf-8?B?d1hCNFQxSlFaMW10OHp3VGZWQk9Ma204Yk96dmc0djI3OVdRaHM1bmhqeGU0?=
 =?utf-8?B?Z1hkQ2IzNS95QmRQR3FidE9tUEx6YTBmU2VWWjErZ3lnYUQwT1V2SkVhUEg0?=
 =?utf-8?B?VFJFK1EyaFZET0w4WVk4c2phT2l6UDYweU1obmlaYjR0NFZYQng5dlFGT3Rv?=
 =?utf-8?B?anlnTnllZWszaXJhU2lzWnk0YmtsUWpBWHQ2dWdpNXV1NnJCQkVoUXF3Mk9N?=
 =?utf-8?B?U0JWQnUrbUlpM2FDZlhCMG9xNFlMTjQ3aENvZkkrY3YrbDhESzVFOUFGc1FE?=
 =?utf-8?B?UjViMEExc3dlb1RYc2dzMjVFSGxjTFRNZCt1V1Nkc3FjQ0xMVmUzbzhjTC9Q?=
 =?utf-8?B?TU4vRWJVb2c0Q0N0OU1rVFp0UGFnL2NTY3JZY280UGtVQWNRNmw0V1ZGdTYw?=
 =?utf-8?B?ZWxSWE1CZzJCb3NoQXlaZ09XZ1ZWRERjaTU3MG9jK2EyRU5KbTVDTEtPY3Z2?=
 =?utf-8?B?NXBYSG9nZ1dsZllWVGhxamtyUmthcHAwblAxQnRuNGR4LzNkam1sU0tTa1By?=
 =?utf-8?B?T3V5eFV5SjRzd29LQ0puNzZ2aFRZRklrTnZWc1pPWVZpblpKczNFdGVjRGI3?=
 =?utf-8?B?djBvczF0Skw0TDZBaENUNE1KMXkvZEpiNXU0QW9YOXdwZFZVZlJFMjd3dVRu?=
 =?utf-8?B?MDBVek1DeS9ZWGhIN0x2dm55ZW5jOHJkNHpZL3lqZlVNU01XRWk1dXFHeHN1?=
 =?utf-8?B?cHNlRXdROHpSTjhybEFYd2hySGYycnBCdnhoVG0zT093andPRmdRMUo2bDNR?=
 =?utf-8?B?VzdNQTUvaCtyeHFSa21Wd0EwVE95TDRlcktSMS9yWFJCYjVCRjJaVEg3WjdJ?=
 =?utf-8?B?TDhFRnppcDIrQ3NlcUxjT1pLd3NUbFlqZTlLMXExcHB4Yk11V3ovb3dSazU3?=
 =?utf-8?B?cFZHZEIrMnZFd05ScUdtR0NubWJlMW1IaTNIWlVVcnlVK0xWYzRkdWYyVU9r?=
 =?utf-8?Q?09aV8tmxNRHMCEP5Wm9esuPR4M1YhIjHgl7nb9C?=
X-OriginatorOrg: infomedia.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 76eed81c-4d40-47c6-630a-08d9918dcf65
X-MS-Exchange-CrossTenant-AuthSource: PA4PR06MB7263.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2021 16:47:30.7452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e66074a4-dad5-454c-8f0e-f55dc95f5919
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUhtvqEgCakKgjUU9HZyMUjrqBUeOxFDLbHVMLRSuaB3/i199lOjKMwSWW4jAF7oLTNKLWT2q9NY5cAXc2jh5P9zcftQAOLEELOYWLCJ78I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7246
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After applying the below patch, the 5 most problematic servers have run 
without any issues for 23 hours. That never happened before the patch on 
5.14, so the patch seems to have fixed the issue for me.

On Monday there will be more load on the servers, which caused them to 
crash faster without the patch. I will let you know if it happens again.

Best regards,
Rune

On 16/10/2021 00:10, Eric W. Biederman wrote:
> 
> In commit fda31c50292a ("signal: avoid double atomic counter
> increments for user accounting") Linus made a clever optimization to
> how rlimits and the struct user_struct.  Unfortunately that
> optimization does not work in the obvious way when moved to nested
> rlimits.  The problem is that the last decrement of the per user
> namespace per user sigpending counter might also be the last decrement
> of the sigpending counter in the parent user namespace as well.  Which
> means that simply freeing the leaf ucount in __free_sigqueue is not
> enough.
> 
> Maintain the optimization and handle the tricky cases by introducing
> inc_rlimit_get_ucounts and dec_rlimit_put_ucounts.
> 
> By moving the entire optimization into functions that perform all of
> the work it becomes possible to ensure that every level is handled
> properly.
> 
> I wish we had a single user across all of the threads whose rlimit
> could be charged so we did not need this complexity.
