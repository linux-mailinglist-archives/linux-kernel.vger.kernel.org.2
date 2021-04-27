Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE436C774
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhD0ODu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:03:50 -0400
Received: from mail-eopbgr80120.outbound.protection.outlook.com ([40.107.8.120]:61838
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236074AbhD0ODs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:03:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eswLqW8g/qCHppEWTwTCKDxpEDvdyE/Xmudx6u2fTqC7P33r2d7b6+6FNnAEAe2PnKGuuerJaO12QhYV3SWAYftX7SmiRf75JwmDEHTBstFDeRJT2avSS3ADgEsx/OQ9EYlpX0gvDGgp4+sG73uyQFlYsYv5DNTusHHjVZt4K32y2S+LzBzuMs3xLNqeGP7kyApv6YCWTkxgumJQNXc6nJIqn4dcjKbIvpwj7mUmUvkzn7+T3ZXQhqX321Pkav8ApyRXr+SYJBJf3L1isqg7TvN81zVlaGNGIWNOiMJzOmGc47tKu9LwDMDE/gIxEtfXSq9b4AQEI0bzvzLc3d0hLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYG3UX1DYEQNFhX2Fz+WcH1vF+nFhuQPjpWEEWqQokM=;
 b=hs0rjlJ4caYIapnhK2GBWlPsbe5Z6bCByI3UCsUe4XlRsFNyEVpQY90Z2hHr68/u7lPoLhUkGSkXqh0rSdzINGF6eVgMJqV8w+YP2QNyo7ufXmaFhpwO2xcQw0aCb0A9pa6toIWdfQWx40Wn+iuQHIY6CdXo4ze6EGD+5Ff8BL90+/8HrtmI5syPDygbjNCnoEHBCT+aP7xAIySVUGTp0qF5guj2jYsF3FGz3WjRvKd8/ez4ojKO+eUQIz6X7t7d4W38ieTM68nGjvntgtIb9mw3hHo47oK26RYdVPK1mee9RTec3JeFblip47g8tqYnus7Hp+qrj8wL3lS5d9/gRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYG3UX1DYEQNFhX2Fz+WcH1vF+nFhuQPjpWEEWqQokM=;
 b=IfFhOoFPhEMMISL6VFpcoEaBt3wdgSOwYbZ8iVIAlD4Vxgu9vmwbXJD9FNG3wN/ttJ2u6/seuF3nuZdZR5flBcWw3A+Ns8Uozz9avucGtIUne33T5G0D68ma+T21Pcq1NzF17YQ6z6Gvts1Fpqcg3vmBThfq/7DGg5wcwOOqc8w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB3PR0202MB3420.eurprd02.prod.outlook.com (2603:10a6:8:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Tue, 27 Apr
 2021 14:03:03 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4065.026; Tue, 27 Apr 2021
 14:03:03 +0000
Subject: Re: [PATCH 167/190] Revert "gdrom: fix a memory leak bug"
To:     Greg KH <gregkh@linuxfoundation.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org
References: <20210421130105.1226686-168-gregkh@linuxfoundation.org>
 <23ffd3c5-0095-6a95-8c30-2b6f67377ce7@axentia.se>
 <14bdfbee-b8b9-d8ac-de34-b6d852d1485b@kernel.dk> <YIgLIscB1I8MxkWP@kroah.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <5a55e8d4-e9b6-1854-51bc-afacd3ca097c@axentia.se>
Date:   Tue, 27 Apr 2021 16:03:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <YIgLIscB1I8MxkWP@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: AM6P195CA0038.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::15) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM6P195CA0038.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Tue, 27 Apr 2021 14:03:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8272020-5702-499c-54f2-08d909852c56
X-MS-TrafficTypeDiagnostic: DB3PR0202MB3420:
X-Microsoft-Antispam-PRVS: <DB3PR0202MB3420C130C26BD06B50E448A1BC419@DB3PR0202MB3420.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NsQAFBYm5f3B/ezApG4VCJF1AlDxOJuep2V08ewbzAyW6fO1WvdjGjJfh46D+E8IrreQjxABbF0u7zjpgQrgkSPM4smRv/nIhf3/QJCpnePQwy0ei5qmKNj0tlemywrxCz1nJB8LYPuqbMF6akdeaFuHV5Y29Evehy1Pt2GYOTiEUxVpBTR60Nw0tODgIRnK1e3nYhzUEJFXUuVva47abjMjDXcptkaN0sl7ZyJUPoKJ5YbReuh+VyfDKc2C1FteoF5PSwahv/GqitI7M2Lo66BEeRA3KAEC3SH3xvx2vhKXERGBfsCcO0AHU1Wf9P51ufFqEF+opPw2NLoEnRUJxOTdJ+dvEJI4DnIMNUuR+sTKxQt8hRHe2TqIOkKqO//3EdRXZtGVBpQjuMvA9OoLiXK2FBoAdUajFCd1uq8vbLB9bOLJyFd3QN9t2ntmAH1FB+hfIM8cXBpAXMcDyjqdoqlP2sG3uNOeGDWFzlhWnYSYIRULNvcjDpCwrIcXbLZxypEuFgipToB0JhFe9l0bVUMe9lsxB8vQbK0pkiOywmqufe/TRLGHPkC1OdFuX3/KDGRexZnrEbGDYXEuxSYeSJpzDydHkjY+SdUwRE+FPAVEr1aiTuJeI7rJSyCGkiBUuVkITKz3tz2p30TMqGsrfYdwxS65nnCN4hd/lJrQ8AbFHDleoq+gYFyU7ElpAsl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39830400003)(396003)(110136005)(36916002)(6486002)(8936002)(16576012)(5660300002)(36756003)(2616005)(31696002)(478600001)(2906002)(38100700002)(66476007)(956004)(53546011)(4326008)(316002)(26005)(186003)(16526019)(66556008)(86362001)(8676002)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?amRmcDBtVnYyQ043elpUb016REc0ZUhzckZxcllxUWxzd0tZNkZZNjhuTENh?=
 =?utf-8?B?VXBWR21LdWhuSHBGVk5QRzVVdHUySnprSFVINW56ZnhrYVVxNEJvZkM5TXMy?=
 =?utf-8?B?dDVpcTh3YkxURCtLeGJPUUdDUmFpVEwwYjdKQnFobGdGZFUvYnFHbkxJMUl2?=
 =?utf-8?B?QlpkTTdWR0g4NGNJQllJZ21UYnVtQm1oayt0V1paMkk0TDdsWExtNE5Ma0lv?=
 =?utf-8?B?RG00Wi81VURIYkR3VjkwVFhPWEFWVHFMNXpFb1duTkdsRlJvbllYWGdjSVpE?=
 =?utf-8?B?NUNCRGlaMG9WQStYK2Nya1hUQzhoYk9UT3NEMUxUc0orSXVudzJTSHBFbnUw?=
 =?utf-8?B?V0NlU2UyUHRCMGlpK2lMb1kxWUpkUmxBMVdSYjV1VVE3OXFmdUhla2krcGRL?=
 =?utf-8?B?NkREazdONUdZUVFwN0hWVkk1Rk1yb2d2d3RVN0RpTWNkTjVtNGYrS1M0SW9h?=
 =?utf-8?B?V1FrSjFYd0s3SEhnS2FZMFluaGRxeUltbkdoNEprajFzbmlqWjVjaktWMWtC?=
 =?utf-8?B?a1FmQ1drMy8xSE5uOUZIdFMzeVhQRms2aVhQZC9STWlweTZrdXYzQUxsN2U0?=
 =?utf-8?B?UENIMTkyOExZV2ZhMjJRczkrNWloRExabVpzclQyNXA3T1g1aEtNbm1yd2xm?=
 =?utf-8?B?NlpGd3k2QWF2MlViNDA2UGtJcENab2FNb1BSWVpJcGRXMEZRMmJZZDBEQzRr?=
 =?utf-8?B?N09ENnErN2NGNDNPWCtrNnlWWUJyczVRZW9nL0FZcHk4SWhwWWxWM1hVMGwy?=
 =?utf-8?B?ZHRHVUxqdnYrMGNsb1JVN3VTNk5TQU5sRE94Rm1VSzYzcDQvZW9WakFSdXg2?=
 =?utf-8?B?L1pBUDBUKzgxNzEySERwaG9ZU0x6Ti9sOUQzcCtLVWxJYzBQc0hwK2Vzalcy?=
 =?utf-8?B?c2tHY2dLQ1YyQzdsS3NSRk9XaGRWS3BZY0JVTmIxVVluNGNJbVlyaThnSDlr?=
 =?utf-8?B?c0gvS0FMSm10U2tIKzdFSlFRUlJ5Tk9jRU1ua2Fjb3pzSUFTaWh6bXB6NUdJ?=
 =?utf-8?B?VkJPSnFkVng1S2J6Tm5jMWg3YjE3NFNOM085dFN3V1VwL3E1empoN0k2MXQw?=
 =?utf-8?B?eEJ2ZE5sMWRRbzBTZGpDYzdVOFI2K0VVbTAwT3VRdlNnaWJKanZkcldSajk0?=
 =?utf-8?B?ZER1ZDdJQXp3OXlFYUhPWFlyaDlYV1o2WXJ3RitqcG5yczY3bkhIeEpqUCtC?=
 =?utf-8?B?OG9LdGJkNHFrWUU2cm51TEFhcU5yVlo4S0ZzcnJQTXk4L1M3R1FaN0NNRDVk?=
 =?utf-8?B?UHA3SWhQVFc5cWpLaWh3RHNTK2NlRGtrcWpPM1JTK3liT0lSR2h0bG1UdXRw?=
 =?utf-8?B?a2trb0pTOXduL2ErRytSTUw4RlR4cjJCd2dka2NOTy9POG1GSjMxcEd2U1lQ?=
 =?utf-8?B?SytxWHdTaklnQnRUYXRNWlVRcWR3bW5zVDlNTlgvWktUUFdmanlMa1VnSSt1?=
 =?utf-8?B?MnVKWkk2Y2NTa3ROdEd5U0tveUxqd3hQb0phYnVjSWZPbE83d2orS0JZbmF1?=
 =?utf-8?B?ODY0aXpZYWVwbWswdk5HUkRLYVZFL29VV2lzY2x2S3orOTVzZmtMQ1dZMjZp?=
 =?utf-8?B?ems3clp1TDBhYVNjWFptdVI3ZGtRV3B1MVdyam1pUHV1MTlma3I4WnRVeHAy?=
 =?utf-8?B?V20vZmIvQVlPZlJ4ZGJnM2c1cHlmT2JRVlNnaTlDb0VJczQyMGEwQkY5dzBx?=
 =?utf-8?B?cm9yM0swRU43dFA4R3dleE1GSFp2aEhvZ1FKbDhiSVpHTk12MjBhRUEvck5t?=
 =?utf-8?Q?gs6tLan89q8efdAPFEfDL/meatz3zL8Y9SO5Qtu?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b8272020-5702-499c-54f2-08d909852c56
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 14:03:03.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naiokqAr9d8oT+ucMK9TldzMkbhmIpn7+M7A4WBRGqPQ/k4Eu7LOo6228xAKe7Je
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3420
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-27 15:01, Greg KH wrote:
> On Fri, Apr 23, 2021 at 08:20:30AM -0600, Jens Axboe wrote:
>> On 4/22/21 3:29 PM, Peter Rosin wrote:
>>>> This reverts commit 093c48213ee37c3c3ff1cf5ac1aa2a9d8bc66017.
>>>
>>> The reverted patch looks fishy.
>>>
>>> gc.cd_info is kzalloc:ed on probe. In case probe fails after this allocation, the
>>> memory is kfree:d but the variable is NOT zeroed out.
>>>
>>> AFAICT, the above leads to a double-free on exit by the added line.
>>>
>>> I believe gd.cd_info should be kfree:d on remove instead.
>>>
>>> However, might not gc.toc also be kfree:d twice for similar reasons?
>>>
>>> I could easily be mistaken.
>>
>> >From taking a quick look the other day, that's my conclusion too. I
>> don't think the patch is correct, but I don't think the surrounding code
>> is correct right now either.
> 
> Thanks for the review from both of you, I'll keep this commit in the
> tree.
Err, which commit is "this" and what tree are you keeping it in? I
think you mean that you are keeping the revert in your tree with
reverts, and not that you mean that we should keep the original
commit in Linus' tree.

In any case, I'd think that the original memory leak is somewhat
better than the introduced double-free and therefore the revert
should be done.

Cheers,
Peter
