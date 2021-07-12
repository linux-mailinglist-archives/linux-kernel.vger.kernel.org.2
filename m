Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CF63C43CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 08:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhGLGHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 02:07:44 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:59518 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230215AbhGLGHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:07:42 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16C64Jdt006067;
        Mon, 12 Jul 2021 06:04:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-0064b401.pphosted.com with ESMTP id 39r5bq0951-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 06:04:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koCWDEbOT+l5BnqwiAke4POTkubnBCmLNXfbhP5alyAjOZEJQESDMNMd7Q82XRGh5JGQY6u6lJStP2v0o3TYndJj1QH+MTvyp9Dob4mB60m5kwe9khuCN0y5ZEfwn+0fjlKe9hIeJ6I/JKDTjN1sS9TRmKjLluiE+o4SEKjlqJeVve4DewI/dn+oaknKArSAt76bkHYmQDEUPV8goCMBDHzi3KC8z/DXyLxLKmWbnEI8G+YUxktEuDIcx0N5vUB4EB67YOxx198AY+Z3mq3iR0igBgVCB+TPVbRzlo+0XMcE9ej1MeacAiaJMzPEXwxfRauwVY2w2onR44oacfUvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liHXaRga54J90TtFCWWBHfDoPJQWeD9pWVksZMjoTIQ=;
 b=j8dS9GfEXXgiBhv4duWd2fZlk1NBSFQN/ATm5Xg4LAe6D9llA9TS1b1lBDoQHxqY3RAo+iV9OVPmHk4ZpiqDnSo0ScG79ePa7FLlm327bPvmV3NZfSb/va2wl0oPdAOn424I17wBForOgWai42Y/C5F1cebpkxXYXajOUT4MOp+TqJaFZJh9AnukM0KJ9mM3BUAgBqVTDcHN4H8+jWU8LIXjfKEnUviPiHP5OsKgezVdTeR7qAhVWRlk+Q7SgadEncLBottbrfBlKpN1NX/ZC5Y4EwkbWLkjheYyAQ1gI3hoy/OutsEqmmvDpMzX2StSKASQnAR3G5d7jUj4uXQ5Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liHXaRga54J90TtFCWWBHfDoPJQWeD9pWVksZMjoTIQ=;
 b=lBWRrpm2ftrFZcTM9lmGuKqnTYGa58PslAZU3PjL1VClb6ZfQLBZUtIAS2H4veW4syG8CyKULHu1i4uzIyuvIwUGTq4zhepI31iC7E95ZTMCdd8Dj4trokTicBe48DLFmEbd7XsG/m0XEQ/qrOvOWNRwXC9C5Px2Sw32vuvj61g=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) by
 DM8PR11MB5608.namprd11.prod.outlook.com (2603:10b6:8:35::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Mon, 12 Jul 2021 06:04:37 +0000
Received: from DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::e172:8ec5:1d86:844f]) by DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::e172:8ec5:1d86:844f%9]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 06:04:37 +0000
Subject: Re: [PATCH] timers: Fix get_next_timer_interrupt() with no timers
 pending
To:     Frederic Weisbecker <frederic@kernel.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
References: <20200723151641.12236-1-frederic@kernel.org>
 <dfbf752e-91db-b128-76a8-98fde4c5d480@windriver.com>
 <20210708153620.GA6716@lothringen>
 <c7a5015a-2b93-17d2-29bc-cd03e40cc09c@windriver.com>
 <20210709084303.GA17239@lothringen>
 <11e85cd8-40ac-09fe-e1fe-0eafa351072c@windriver.com>
 <f520c8b87f56fcda0158853c5127f0488918503e.camel@redhat.com>
 <4409fa71931446d9cabd849431ee0098c9b31292.camel@redhat.com>
 <20210710090535.GA28305@lothringen>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <6d84ebfa-7b5b-4b45-18ee-139af6e74707@windriver.com>
Date:   Mon, 12 Jul 2021 14:04:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210710090535.GA28305@lothringen>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To DM8PR11MB5637.namprd11.prod.outlook.com
 (2603:10b6:8:33::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR02CA0193.apcprd02.prod.outlook.com (2603:1096:201:21::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 06:04:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f4804fb-6023-4d59-3d2b-08d944faedd4
X-MS-TrafficTypeDiagnostic: DM8PR11MB5608:
X-Microsoft-Antispam-PRVS: <DM8PR11MB560815EAC1CF899425070E9D8F159@DM8PR11MB5608.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAOm4tKkEXuO/ETcqo1ihU6DyocsF2eOhHKiYIJNgVfd1QQm3JObvfH4UV1Q5BdCx7goWw1Tr+mARjDdT1kQ9RLyuRDGtRWqKc1wHesu3EPazZ/JTwfcUf7cQkxhHKWMETApR7PW/hfbCXe2/DAr2+XBQUlAv+YAfYvJri28cxPmDZ899zDj/ytW2NT6bqP5XV/MoqQ8nUThNtjL9+A2E3GRGmKS/kOdh260ylXADn6V9Su0TcaJXwXtYkOuodsfOkRkppKP/LYoC5s9QWa676Ch6nhRf0p22k+Rguwai+e3mTU2P5zA4I7nH+nTLsJ4u2mPgQl15KfJAHr1gW2A6BLzvZj8/3/pI70GaFR737LoaY0RzzU4+s7bQZOOI7Gse6cg67QisILPQz0bcjmMJdYUp9Oc06FExbQzf5yf70mLnSlVpbQdXQAIJJKQ4NSuJGcchSw1QIqYCvCjoydiRuBshdcdJMeSydQDo+91V4d8mh72JGTFvH9IZmX5Cvx8MPcxER31Gfct7uhLhTrT0eM7VJeOVlL+TLaOiVAaJpZY25eRu7m/18XxVeky2AXpB6s/r/VG5wsL8ySqIZDMN3eeRx4fVO7DGDX0VtN7pNFsEkVeW1NrI7BdDYjjMZENLPL4NeBWTHN91tnM/DwnxurRGPTe2JXukSNMqOQAscZLUeonWmV9cCKX0mvW+IQQ6XqYI9lUqkofQeVt0RM6CimqZM9ins2flnP3JjAZcRfWm2ku8lwX5d6IGCgy9qKoqFRRvpUcJGzbg9wE5YLHlfyOtGe7qpNd+rhbmUd4rRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5637.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39840400004)(376002)(366004)(396003)(36756003)(6666004)(8676002)(6706004)(16576012)(53546011)(66476007)(478600001)(5660300002)(110136005)(38350700002)(26005)(86362001)(4326008)(52116002)(316002)(8936002)(31686004)(38100700002)(66946007)(2906002)(66556008)(2616005)(956004)(6486002)(31696002)(83380400001)(186003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MExrR3FyWUt1Syt1QTJMcVJtR1hmdWw3Z0VvRVFIeGFGTDZDTUJPQmFGMnNB?=
 =?utf-8?B?VkdyWCs0MGlnK3gvMlBadXlqMWNOcGRQeFZnbmViWW90cG0zZ09rditSVkw0?=
 =?utf-8?B?aUlFS2V3NmFQY0N4U3BzcE9SczV5S1VPdlRORTY5cFAxSWowaFVRMGlTWlJV?=
 =?utf-8?B?T2JRZzUxOFhpNnNkVWEvYWh5WThYM3hSYS9SUjJLS1FtSjIvemEwdHhxcUVD?=
 =?utf-8?B?THZzYVhaSzN6NXZzOTN5OUxuR2VnaGJ1SHNEN000YzNJRk9EclZIQ2F2TDEz?=
 =?utf-8?B?Zk1pYTFpYWtuYk1hZGVkRFZRQ1gxYnZQcGNhMytVME5FNk0yT2ZvTnJ0Ully?=
 =?utf-8?B?ZGVuTUl5ZDBDZmtybDAraW1jRk9pNHI3bWNtSlZOcitOK3NxNXVmWUZaMDRw?=
 =?utf-8?B?cW9FMDFGYzdmNXdOL1hLOGlyVmRYWEVZNThwQ1pmZmZPZW9qeGtoRThKOUhU?=
 =?utf-8?B?elp6b05RTVhISktVTVlpMHRNR0wwMFg3em5BelFWMlFXeUNlZXlJWXQvUjJ1?=
 =?utf-8?B?MnByT2E3WjExbFRPNTgwYVY4TGp4dEo1NEE1ZmFldUdub3dVMHJpakhtT1g5?=
 =?utf-8?B?REFXL3pOaU03NmFnVWI3OUhtQU53bDUyT3hJN1Juc01raStsQlYxMzBLbnBj?=
 =?utf-8?B?TWY1SjJvWWt3SGpEOEFDQ1VOWVJ5bTJPVHIxaWcwbzhkcEUwdG5mQnkzdnlB?=
 =?utf-8?B?WkxSUVYvMU55TVAxUlROTkwyY25naE1wSkRGdG04RWszbDErSlJoNUVZVSsz?=
 =?utf-8?B?QXo3VjdDL0pNZlN4VzA5bmdFcnZMWU9ybHlSQTA1SlNoWXJhbnp1NEVpWnIr?=
 =?utf-8?B?bml5bG5iVjAyWmM0TzlxZUR2d1pSUDlaaWdLKzJzRXZncDI3Q3BtUThFU3VO?=
 =?utf-8?B?YWV6SExhSDBtU1dkYjkzRFgxeTJtQ1daQU41ZUVvdjlZa01tc2U5MkdCeGRR?=
 =?utf-8?B?T3kwWjEzN2NFZFdzcVlGVGRTbWI2U0xJWkh1QUV5WHNlMGtVYUoxUUxkbURn?=
 =?utf-8?B?eUt3c0ZwdWd2eVUwSUpVeGJsOEVkQnN5M201OFc2bjNmL1NiQXhuL05kTWdl?=
 =?utf-8?B?QkF1am5jUlpReDVCcmdjOXh1NHhaU29xVmlTVWVqcFVvOEpVKy9VL2NVYTNu?=
 =?utf-8?B?NTBFWTQzWFRLbWRVbGQvRGhzL3RMU2VudklJRHpqTkx1ME1PcElKaHZ0TEcz?=
 =?utf-8?B?cGlTbFhTOURWWWdXODFsSUtOZW9WYjBtRDd0NU5zWEJIMEZySnU2SXdycjhi?=
 =?utf-8?B?UUgwZytHMGFNbjM0ZkRqeVFpOXpsQm1FVHpaV2JJTWkybWc1cDlNbGx6d2tE?=
 =?utf-8?B?Wkp5NGRPQTU1RE9GWERWUWpCei96TW95UFFOclNRYm56UkdtN0RLUDlQSk5O?=
 =?utf-8?B?RDBJVTg4MUtBSHhCZEZzSm1ZbEs5Z0NVWGxKYUZZbWU0NkF5NFhYMy9zSndI?=
 =?utf-8?B?dnIrd3d5UWpIZEhmTU9YTVZtcnZrc3RXQXZDS0hFSGpWMFVRWDQ1MmhvbFBl?=
 =?utf-8?B?anZkb1NMbjBYUnlvbXNCdG16bFFLWHRMOVdTejNTNmRQNGwvdjJKRUI3a3Zz?=
 =?utf-8?B?V1EwUkI2ZHpXY3lITXhPQUt5NHd5bU9GUHF1c1BLTFdEWVdHZWhRelEwcXRW?=
 =?utf-8?B?bnZFa2RKeDZlbk1WQ3I1SFArSFk2ZEovdGFpZ2JzZy9YM283aDNrVTJhZW9z?=
 =?utf-8?B?aWRpVStSZ3MxcTBZZnRXbGhTam8yL3dhVXZqV2JON3NGeHFKdUlxclNrWE85?=
 =?utf-8?Q?D3mbIhb05zbyM2JZ8Y1PC05iOQ1zWCkU9NjQqEf?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4804fb-6023-4d59-3d2b-08d944faedd4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5637.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 06:04:37.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExjpGBgC8YWjjLNwF8v13m7UdhJ24uO3UGR6eK6GuduDKUxCZ4rRco/GDsEh/DuIKdigq21Yf1WNNpMP0Wz2mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5608
X-Proofpoint-ORIG-GUID: r1DuuLMm-uFXt9ZK61rWhoNeZM8dhWBV
X-Proofpoint-GUID: r1DuuLMm-uFXt9ZK61rWhoNeZM8dhWBV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_04:2021-07-09,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/21 5:05 PM, Frederic Weisbecker wrote:
> On Fri, Jul 09, 2021 at 04:13:25PM +0200, Nicolas Saenz Julienne wrote:
>> 31cd0e119d50 ("timers: Recalculate next timer interrupt only when
>> necessary") subtly altered get_next_timer_interrupt()'s behaviour. The
>> function no longer consistently returns KTIME_MAX with no timers
>> pending.
>>
>> In order to decide if there are any timers pending we check whether the
>> next expiry will happen NEXT_TIMER_MAX_DELTA jiffies from now.
>> Unfortunately, the next expiry time and the timer base clock are no
>> longer updated in unison. The former changes upon certain timer
>> operations (enqueue, expire, detach), whereas the latter keeps track of
>> jiffies as they move forward. Ultimately breaking the logic above.
>>
>> A simplified example:
>>
>> - Upon entering get_next_timer_interrupt() with:
>>
>> 	jiffies = 1
>> 	base->clk = 0;
>> 	base->next_expiry = NEXT_TIMER_MAX_DELTA;
>>
>>   'base->next_expiry == base->clk + NEXT_TIMER_MAX_DELTA', the function
>>   returns KTIME_MAX.
>>
>> - 'base->clk' is updated to the jiffies value.
>>
>> - The next time we enter get_next_timer_interrupt(), taking into account
>>   no timer operations happened:
>>
>> 	base->clk = 1;
>> 	base->next_expiry = NEXT_TIMER_MAX_DELTA;
>>
>>   'base->next_expiry != base->clk + NEXT_TIMER_MAX_DELTA', the function
>>   returns a valid expire time, which is incorrect.
>>
>> This ultimately might unnecessarily rearm sched's timer on nohz_full
>> setups, and add latency to the system[1].
>>
>> So, introduce 'base->timers_pending'[2], update it every time
>> 'base->next_expiry' changes, and use it in get_next_timer_interrupt().
>>
>> [1] See tick_nohz_stop_tick().
>> [2] A quick pahole check on x86_64 and arm64 shows it doesn't make
>>     'struct timer_base' any bigger.
>>
>> Fixes: 31cd0e119d50 ("timers: Recalculate next timer interrupt only when necessary")
>> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> He Zhe, does it fix your issue?

Yes, this fixes my issue. Thank you all.

Zhe

>
> Thanks.

