Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7976A347E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbhCXQqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:46:35 -0400
Received: from mail-vi1eur05on2126.outbound.protection.outlook.com ([40.107.21.126]:32865
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237125AbhCXQpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:45:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbZqAQkQR1CEOZtFhPS23782SvHcCql/VzoTY3L6a4Blxm1kQ2yHMJbzXsz7oGEgEV3dCQhQYZOCq+Z1uPmf+6ai1qLTR5p0eGQS1+hRJ7wNIxr+Nk5XoRPyzGSL3y6FIdUSGR7gga/PDxGIi5RrW21A+JPFas5QxObNGYCZHoHCsdLbJivCemSzxOqHaHaaKiqgRtGfsT4a8Ot23T4s9PU9h+YP00ZzLZ6mPcgrVtL2P7FFqDQpv4zz1Ugve1RpzHXcmukLWDBZjQBnY07sGN6PIdUymP1Qm5ujBXy0jFxpL2KEsV6m33Bl3VSWm/m54kGZZuVEWiVWQ/zVoPMJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5XkKKNZOhSMJTc+TbHcOInC2WH39Uc6eSIihZtsfec=;
 b=AcRxKRo626592zZDtzIX454ofaN1zX3hGbqihCN+LlqKyYCQsmThwCIevn3/IrmcTcmE6/LS8dJqINnaD54pkqxDJtMaGEZBBX7+NofMaGIf5YcyhhA/OrOExpDrv3Se43a8oGSmogx6+G5ihO/znMxczmCPP4xXmWazXBzF3jXyb5GFulzzrW9J+3whWkRWSRuxZ2ZdklmSPNCgm2w/ENYkk3ve1IdFTLdeIV10l5G//tmFCrTfNfgk0kRzGoDgfGontiAisX5i4IpFzROxpCvlELjLrKmtz8naeHR5BOGaZv4ZEan6NsDb1KTvzRy8o0Q5s0Z8SvLY/XP7qWCzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5XkKKNZOhSMJTc+TbHcOInC2WH39Uc6eSIihZtsfec=;
 b=lwPhnStXN59nuHFHTFLcNi2d1yPoNHI0iU/+CiNbBViqHtTpip3gfjEY3X2kzJJcY6KDT4jEzT/IznmCsC0/JkYVGYTIlb8k2F5yXS9HSSH3zzZjmHSdY4IufKJGyzYOdsDSc/2ea3yx/CSz2IlVEWOfpHC1VAatw0bfFW1OV2w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB3571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 16:45:54 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a%3]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 16:45:54 +0000
Subject: Re: [PATCH] static_call: fix function type mismatch
To:     Sami Tolvanen <samitolvanen@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210322170711.1855115-1-arnd@kernel.org>
 <20210322153214.25d869b1@gandalf.local.home>
 <YFkCZuOwe37d2bV+@hirez.programming.kicks-ass.net>
 <CAK8P3a2sz4emewH_HA+nsf0e5tP6qtAxhBOFucmzW4OPDJASdQ@mail.gmail.com>
 <20210322172921.56350a69@gandalf.local.home>
 <YFmdJlESrCh4iC9A@hirez.programming.kicks-ass.net>
 <0f4679d6-44a4-d045-f249-a9cffb126fd4@rasmusvillemoes.dk>
 <CABCJKuf1-GWda9_BiBO=nNP_drh3a8471G+LEqPzdVrLBhVqZQ@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <b2d77e78-751e-283c-8cff-e9c4f16e27ef@prevas.dk>
Date:   Wed, 24 Mar 2021 17:45:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CABCJKuf1-GWda9_BiBO=nNP_drh3a8471G+LEqPzdVrLBhVqZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.208.71.248]
X-ClientProxiedBy: AM0PR01CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::33) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (80.208.71.248) by AM0PR01CA0092.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Wed, 24 Mar 2021 16:45:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e58124a3-1d61-460e-8dd7-08d8eee449ff
X-MS-TrafficTypeDiagnostic: AM0PR10MB3571:
X-Microsoft-Antispam-PRVS: <AM0PR10MB35717194FF639A76838CE0FF93639@AM0PR10MB3571.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTqFwkWmjI/044JrlXWNddTHpVpFKXhdFTeXaK1s8L04y7/JUT4x1JQE4grwWYo2jbFzMHKJtiMJUMhOXYUMTh4/HYSQhul8HGd0WuT73eXqY1B9/O8Vbi4Nf7KJRd21kG/IXKkMVyVm4jscGMefIj2xOJK6vN41jLKfz29T/zB2n4E3yDfdpAccOkV2Zpy+DYCbiEgiDp3oRrcCyR1fzYd1zFbOmUndy2GWfo2jIHbknnoMzkuMjqWaGVwMTzooWLkj1S76E/Jfy/tzUrVvtba2wkJxTownx4X/+7cErCQnP5z6lcz/J7lyDgeelmSTYK/LejIkIBz4oumt/9dvvqLTK0wVmidHY5Dw71Fhxm+m0fBMQQR51hiI3SU4y3C7y5aYMCXcKLXb9Cuo3tVo+1W6iHW12+8S7jYFmHeFMADN3hiFP8Ui9nnjsWwyhMTOOI8L+rjUFbTjj9US1PNC+4ktbRXWiuSuA/qqLMeVpTRquBbrquPC1nBjaBh+tdW4gDxNH8ztm+1gqfQXbqCqsPrYECGlHk7BmVydGnn6rrG674dE/NSQe8e0zKx9+2oOj7hVg+NXXwvP75E00yDwpZ+I4V/DsnMco3hfVeHifOLo5FbjQCOfDTOxXJgrLqpIfhPUEc9lvEJZUCDqwZF+aWD23Wz8XBYtsiTif9IZPH15RHLLY1rKkaJ9YJ41X5Q6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39850400004)(366004)(396003)(346002)(136003)(186003)(54906003)(7416002)(478600001)(16526019)(316002)(38100700001)(956004)(4326008)(2616005)(110136005)(26005)(83380400001)(16576012)(53546011)(31696002)(44832011)(2906002)(8936002)(31686004)(8676002)(66556008)(5660300002)(6486002)(52116002)(66946007)(8976002)(66476007)(86362001)(36756003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bklYRk9DcUo0RExIcTd2TVY5cjlsVlNtbHhHS3l2VTVLaWlxZGtpakxwREpR?=
 =?utf-8?B?Y2NkQVE2amk1aldoQWl0Yno2NG9GQURIWER6b2NkZU9NdnA0Z3FncCtpWUVW?=
 =?utf-8?B?SC9MSER2cFRDMWlyWTY3VlR2TEhFcHFjZy92QXpNS0o0Q1QvekxOdUhDTVlq?=
 =?utf-8?B?YnVNdVBJMFJyV2dtY2RjcjcySWhKTDlTVHAvYXhNWkJzb29PQUhsRU1YSTFu?=
 =?utf-8?B?M1Y0OTN5bk9EMkljN1gzVGdqeUtHQWdhWHVlYzBHLzJ4bG1TYk9vS1RiNUdw?=
 =?utf-8?B?blUrR215Tm9pejNjYzhmVTQ0OS9BK0M4RTV5WDBJRDNXV0FVa2k0SWNaUjNi?=
 =?utf-8?B?WXBkWWMzOW9meWFQS2xrdDdhWDNBVHMwVWVaYUNzTU9VWjRXd1RON1dKVi9a?=
 =?utf-8?B?ak1OaTYyVDUvNkFTdTgxN3Fmb25rcTZ5c281aThlOTlpNklFSDU0STQ1WWkv?=
 =?utf-8?B?dERTMUVhNUxiOGpHYit0My92NEhneW4zSjF5Q1JaSWRTM2VmeVhnamFQdnRo?=
 =?utf-8?B?U25WWkRLUFpKZUw3Zmp4N0ZCN2lrNExKOEwyTGFXUzRKb0h2ZHlzZW1KUVVQ?=
 =?utf-8?B?OCtDZkFXOWtOQUh0TTZqZEI1QjlocVRHL0NwZnFHOXZRMldoZ2hUY0xmVGtC?=
 =?utf-8?B?WEd2RklmWFlIMG80OFZZTG5RaG1pQ05JcDd4cURneUpOalNWc0pEb096RjJ6?=
 =?utf-8?B?b2VvcXJ0aDUwU0ZtN2NDSFVFUGJISkJoa0kzRVkrOXBzZjd5RHFFY29HT040?=
 =?utf-8?B?NjF4bnhJK3RTTUNzSmllS2p0SmNIbUNKeWtrYTllRmlmV1czRk44NW14Z0xN?=
 =?utf-8?B?Nk5RLzRGM2ZUWHZjSTFGalE5dFNFcXpPWnNQcHdvazdBQ2R0Yk9kcWhlTklE?=
 =?utf-8?B?TkV1MjM1Rm1vWmtlU2ltSmRDY0xxUEZ1V1dOZUwrTERZSmhrdVRGaUJvc3Yv?=
 =?utf-8?B?MFdlcnMwT3g5ZUxqUEZoUkx2ZjNKakxEMTUydVdPQ1NueGppZ3J2WDQyQmYr?=
 =?utf-8?B?UldnZG9ReU9DVVd3d0ZUeElhdzdCWFVSMVRnVHBxQkJiLytrN1l1RENnVlNY?=
 =?utf-8?B?SUI2THFTclZYUFdBdlA3ajFmMWtta3B1UzN1ZlpOSnB0RDFDUmp6VUNpeGlC?=
 =?utf-8?B?MlV2aW9Yd0dHNENydkpDL1RwMEQwdXp1aGI4emdER2NHcGJmaFU0REtXbkNq?=
 =?utf-8?B?RzMxSEczZy9IczZObVFkZS83cXpSamN1OVZoUDhXRTdUckZ1S04wM3cyN0oz?=
 =?utf-8?B?Si9mWk1valFJaWJyTW5aanVLNUI0RmVpZzRPeFRtTHBkZDlwQmNrVkMxRCsz?=
 =?utf-8?B?emhhMFV3dmdVTnJURWEvV1NTeHdiMXp3SCtibE00ejU5K3A2SHdjUkJwU2VQ?=
 =?utf-8?B?YWRXNG8xM0pzaWtrTk4zMmtJTzd5OVRWSnBFVnlxeXFZREI2YUZzY3ppb0Jl?=
 =?utf-8?B?ZkEra2pBczlpa1BMV0ZWSUhFRGpWTVAwK054T3FqMWRRM01hZDRYaU15Mkc1?=
 =?utf-8?B?c1VaZCtNbkMwNG85cVR5UmtmSVRDNmdEcVkrbXo4eEhxMmtpaDRRZDhYNWNa?=
 =?utf-8?B?bEp2ODhZUGFMdjBqY1hlYTBBVlFYS2lKaUFGNUlvWWYzbVRSTXgwSkV3T3RE?=
 =?utf-8?B?bHN3S1JvODEzMFZIOSs1aTJldTJvdlZkM0ZQRzZTMDlzU0xMd3I4K2ZtcTQ0?=
 =?utf-8?B?Mk96RWRadW9uK1RxUTB0bTRCdkpPcGJDd3ZzeiszNUlxNTJLOFBWWkVGcm1N?=
 =?utf-8?Q?xNRfcLQ17VwzJ/GvVgK/kAtFHBQTeoUcL6wmrZz?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e58124a3-1d61-460e-8dd7-08d8eee449ff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 16:45:53.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNeD+mwMrXdbaTx+TNNy3czYsbzaEZxEa3S3CWnAy5coKlyL5x/daix8qn0d3/G1gf12TFDbmoWSeRVyGaHrfbjndSWzenO3qeyMzKWh5rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3571
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 17.01, Sami Tolvanen wrote:
> On Wed, Mar 24, 2021 at 5:46 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On 23/03/2021 08.47, Peter Zijlstra wrote:
>>> On Mon, Mar 22, 2021 at 05:29:21PM -0400, Steven Rostedt wrote:
>>>> On Mon, 22 Mar 2021 22:18:17 +0100
>>>> Arnd Bergmann <arnd@kernel.org> wrote:
>>>>
>>>>> I think the code works correctly on all architectures we support because
>>>>> both 'int' and 'long' are returned in a register with any unused bits cleared.
>>>>> It is however undefined behavior in C because 'int' and 'long' are not
>>>>> compatible types, and the calling conventions don't have to allow this.
>>>>
>>>> Static calls (and so do tracepoints) currently rely on these kind of
>>>> "undefined behavior" in C. This isn't the only UB that it relies on.
>>>
>>> Right, most of the kernel lives in UB. That's what we have -fwrapv
>>> -fno-strict-aliassing and lots of other bits for, to 'fix' the stupid C
>>> standard.
>>>
>>> This is one more of them, so just ignore the warning and make it go
>>> away:
>>>
>>>  -Wno-cast-function-type
>>>
>>> seems to be the magic knob.
>>>
>>
>> That can be done for now, but I think something has to be done if CFI is
>> to become a thing.
>>
>> Sami, what happens if you try to boot a
>> CONFIG_CFI_CLANG+CONFIG_PREEMPT_DYNAMIC kernel?
> 
> Seems to boot just fine. CFI instrumentation is only for
> compiler-generated indirect calls. Casting functions to different
> types is fine as long as you don't end up calling them using an
> incorrect pointer type.

Sorry, I think I misread the code. The static calls are indeed
initialized with a function with the right prototype. Try adding
"preempt=full" on the command line so that we exercise these lines

               static_call_update(cond_resched,
(typeof(&__cond_resched)) __static_call_return0);
                static_call_update(might_resched,
(typeof(&__cond_resched)) __static_call_return0);

I would expect that to blow up, since we end up calling a long (*)(void)
function using a function pointer of type int (*)(void).

Rasmus
