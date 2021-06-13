Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641673A59E9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 19:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhFMRwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 13:52:16 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:12572 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231915AbhFMRwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 13:52:11 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15DHnKIw025874;
        Sun, 13 Jun 2021 10:50:02 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0064b401.pphosted.com with ESMTP id 395kgv029g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Jun 2021 10:50:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgNyz5IUi+tqHt60eEbjxk1El0cZc28E5xR4nJcnfV3gvDsX8Y+tXKtTOEyOozd0dHqbVF1c+73xdpqmf0aUMw19aJ6goz5bxARNHDyRGCBgKIpZ/bOcQx9oevvwMMj9klkxAoW9+tCNC18i6qrz8wIITaiLJt8V1tT5KRLzo3J5+/hs8qn2ZujCl2B1d5q6hkBiQHvn9JEccBWL1reneI+FaSXkPY4lSH0564yTY0+RiXFTmF7YwER/tMLEOp2Ga/GjkNlpXfvGuhZI1HdNmAoOwe/891qYLaEefOOJm3t6apMBeAJAKjalpI5SJ2E4Y7Otjch2z7bPCWYp6vztDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aihIR3k0ZHOvOeWK8oizr5FW73JcF4zPtTTssjhJFOk=;
 b=SXtOsWwVaiCerZ2gim91HdZcU0paqmb/FDb0RAxI3ZaSx9RHPUtcaf8wuqaPxjaA1SHRcKHRFc1kqtrAnYldVmEa+WFkVDthcIPCTPAibkhyJgCIQrN96AlmJKI3xrCH7Fz087ZPSLhouS5z3XWlihZqLJKBQSJDj9JwpY5Uw/abvoNMojJNb1ZMLxv3iDTR6LScDUGyt70gnRVOo5QOr6sME3qidR2VXNkehIxJQ1xXAPAGwBcIQ5Siiu9Ef8NMIcsAxyeEItf4igrAiGbAhqfXret4htEGdWyQVSjiVjRN1/VT4iDqrSwY+0BLuG6PzHv9W+IsPL+OGSGuEBXI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aihIR3k0ZHOvOeWK8oizr5FW73JcF4zPtTTssjhJFOk=;
 b=PF/dVTnhmNH4V+RWNz7DjlgX51VNeo6U0CW2yNa+t9pTcVLtnq6dE8b69I1YzZtQly6nSzBOk801oiZ18G9EvFur2TJvfg1wNku/QG9SklSqqxb2pme3/ngGenRXlObZLgl7p9ZjMLUExjYafeLLRcDPYYMEGGSjWQPpofAlLjk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4226.namprd11.prod.outlook.com (2603:10b6:a03:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Sun, 13 Jun
 2021 17:49:59 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4219.025; Sun, 13 Jun 2021
 17:49:59 +0000
Subject: Re: [PATCH] mm/kmemleak: use READ_ONCE() for accessing
 jiffies_scan_wait
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210609155657.26972-1-yanfei.xu@windriver.com>
 <20210611085913.GA8132@arm.com>
 <833a5523-3e49-2554-178d-cba7cbe71b7a@windriver.com>
Message-ID: <5f9c64ec-fa41-f968-43b6-0ddd02d73b86@windriver.com>
Date:   Mon, 14 Jun 2021 01:49:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <833a5523-3e49-2554-178d-cba7cbe71b7a@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0061.apcprd04.prod.outlook.com
 (2603:1096:202:14::29) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR04CA0061.apcprd04.prod.outlook.com (2603:1096:202:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sun, 13 Jun 2021 17:49:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9949e1b8-e77e-4023-701f-08d92e93a9a1
X-MS-TrafficTypeDiagnostic: BY5PR11MB4226:
X-Microsoft-Antispam-PRVS: <BY5PR11MB42269EC0799A837AC7DC8E22E4329@BY5PR11MB4226.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZU1ywhnJiG4dbWoFqT+OVIBtLgqzHBlZBYjn976j8VexBCRFvTqECslF+nOlzAY0adyi425wjKAzzZWtcW8/aELHAUHwE12p9jCfDeKwscGyjKcGYiEu2OmANjxeAslGxFiAwcA/5yF33q8laovCCOgFiKK36dFj7FJfBLsoEI4vzdJYQNH/Uif9B9IDWSi+qYbtMs6pao+amNsEBs2z0s87iYmoQ0eW5p2wadYLO9FjqcIOIjA3O9s8OqDHO1koW7wUbSiIb+EXvaR0oAu69QQQfN7mZ62Uy+LFKKywG9IyhXLG8e7HP90L1YEH6TAcbti4w3orIb1hfK2aIR5oTDBP1Lt2RgaMHFmqxEpa/b99mTcwLmAfYuCTgfT42xfKskBCcV02/WemdZox9ZMk66qpczB2SUm8BLX7XeM7GFw4MFjvIbig8uXhnFfuT1CDq0CyMTn/3Qx7tFaI4RxUIvgAxUlKA39bsc68y61LLkm5yH/moJyJU9gqibF38YhCotlCc9+jSSZdJymhwygPzqWHV5VR5KgzZdwr7ruPW8rZ7nuJx1n2urtU0OJBT/LrGe8X8Y5N9g8QTCCQpQkX0JO666+BzV/1f9ubIMx+pxkF4Ib0LbX4JyK9sjYqmftNkKM+lzInScNLJiIf21oKS7flt6py9DE620VHan+tB3jBlr544Vea+azXQUQqiPVsqko8jgIag0yLEbzPNu6rKf4RbbA2SuDRbEJh+Hz182Q+g+h/Tw+5caPImOHrTCfWLJk0Z1ZyAk+I7695uG4UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39830400003)(396003)(376002)(136003)(956004)(53546011)(66476007)(6916009)(2616005)(2906002)(31686004)(5660300002)(66946007)(31696002)(66556008)(86362001)(6706004)(4326008)(38350700002)(38100700002)(186003)(16526019)(8936002)(8676002)(16576012)(26005)(6486002)(83380400001)(36756003)(52116002)(316002)(6666004)(478600001)(21314003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUZQd3FyaC9qZFpCNnZMMW55SkJyOGI0M1dhdkgyMFNQaHYrNkpnZzFvSTFz?=
 =?utf-8?B?R1NqWm82enlsZ1EvT0tDM3RiN1BtZFVvL2JrWFppV1dhNjQ5WHczWFR3azZI?=
 =?utf-8?B?dTVlMmZPZEU4NFQzL1pzb2IvNEd1WFNNWGZ0M3U2d1VJdzdYU2gzTGNCamtK?=
 =?utf-8?B?ZE1pWjdFVCtIS1lMN3hHRGtkd1IwUmprOVFqeTVrcGp5a09oaFNxaGFtQVJK?=
 =?utf-8?B?NFoxc0QwSWlGdHlidFkwcGtqVThQcW53TjlxeU02U0VyZnM0V0tYaXp2d25D?=
 =?utf-8?B?SmFHekc4dGh4OTVIc284VEZzdGNxeGFWc041QVN6a3FNbEphenZVUWZNQUgv?=
 =?utf-8?B?S0hoNG1nelNjdU9iaDgxbFNOVUw4L1YrWFQ4c0VUTWhTSzY1V1FFKzB4d2Ft?=
 =?utf-8?B?OEZybm90SUFQNnpPK2hyMFcvbTEzM2NwNGc5QXJQTHJyNno4MFNKRnYvT2JF?=
 =?utf-8?B?TFljU2tERkQ2aHFFaGJISzFqMjRGT01FYXl0eTVmZTdaRmRtNHVUTmgwckVp?=
 =?utf-8?B?STZ2cTZCTDVYeGtIY3VzVXVQODlvaEZ4ZnZWTThrejY2eWZBS0NQL1N2RjFq?=
 =?utf-8?B?LzhaWjhGYmRRc1RHL0hoR3dXRVlhSTJNSjBPTmtDVG1YbmFBc244RkRDTjZT?=
 =?utf-8?B?UXdQMUJibDR1b0YyOThEK1pSL2xmTlVQVlVlRzlpUVlCbHJyaDQ4d29KV04r?=
 =?utf-8?B?Z2c0MXVxR3Y1QjJ2cHdCRXJ4V0IzcUZPc1FQVklmUlhoaFFYa3ZiTDJ3QUdp?=
 =?utf-8?B?QnBGbys5UVovcktNMDA3ZFRjTHpLMndhbG9OYW5ZS09lT3d2ZStQQU1LNVVh?=
 =?utf-8?B?d2dWRkRuRVVoZVRQUFBGejA3OWV6UDM2eEpxYkwxYnJQdWU0eThua2Uvek5L?=
 =?utf-8?B?b2dMMDMwT1JYTEYxVkk3ZXc1Q2xxaWhwMndSczYxSUxUazhPaDhieFc1WHF4?=
 =?utf-8?B?cS9jLzRlRktsVTNWU1QyVHUvWDVHb2x2aXVJS3Zocmo5LzVRSGxJdk83ZGRv?=
 =?utf-8?B?YjZEWHg3NURGend3cjRsWFFlejViZDFZR1Fua0JJTVZja2xkcVptakFjOGVI?=
 =?utf-8?B?MkJ5T2FZRjBVaGhkem5lOTJqL3kxNEpIV0YrYk1BSng2T0h2YzhzdHdSbTNY?=
 =?utf-8?B?bmNVU0tUVmZOaEdnREQwUEd6aVBRYys5MWtYdjVOME03RTh0bGYwaTdzejRp?=
 =?utf-8?B?di9uaHRoTWVOelE2S0Y5a1UxdmkyQ3E1elhGU042MURJNXhRZEtuTWFNSzUr?=
 =?utf-8?B?cnFNSCsvUmdNT1RsbWc1V1NMWjlZQWhUVXBMQWxyYUdRV3Z4VEs3RnpiRmFF?=
 =?utf-8?B?WFZNY1VJWFhCT05BWGdteEUyMDNpWHBCZ2lkdE5yUXlLWWZtd2t1UWdMSDdI?=
 =?utf-8?B?Si9WcTE2RHZGRlVjUEZoTmNDZXFUVUFpTVcxTm83Q09NOFJHcUl6UWRONjlH?=
 =?utf-8?B?d0lGM1pxYkpmR01ON1ltYy8zcG42MVB0QlFVNE9NT29OUDVvS05tQVNPckZO?=
 =?utf-8?B?ZFJPT28wZjd1OHIxNjkxbXBrdUFTb25qYXN1SHBYSWJmVzVMT0V5aVFxSThp?=
 =?utf-8?B?cHRDL2xuT0wxMWVFZUxKMko0MG5TS3ArWkNrbC9tUXp2RFE3U1pCYmtVT3lk?=
 =?utf-8?B?c2o1WlB0OUozcFdIaWpDVlM0SGNRUXBOVEVqS0M2a1hwTHlaM2VVbkl1UXQ2?=
 =?utf-8?B?T3lySSs0UkVQeHJ4ZzZqQ3QySEpBRFg1Y1J6RFM0UmpBK1R2MkJ4OGFMRmt4?=
 =?utf-8?Q?HTCTzP6aJVqnCN1fVD2kZrXZTJ+gqj2eAuIrfzN?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9949e1b8-e77e-4023-701f-08d92e93a9a1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2021 17:49:59.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odJCyg1j7KC5OFLdZGMr8e6xjQ07a/rwl7W+xli9aV4Uh5lbrBLmHML7F+id+pa/5SMGcnSNVa/+K/l7Zu9anw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4226
X-Proofpoint-ORIG-GUID: O4SarzFgVhi-ttYAL9zi4I9qZ2S8V77s
X-Proofpoint-GUID: O4SarzFgVhi-ttYAL9zi4I9qZ2S8V77s
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_09:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106130128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/21 7:17 PM, Xu, Yanfei wrote:
> 
> 
> On 6/11/21 4:59 PM, Catalin Marinas wrote:
>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>
>> On Wed, Jun 09, 2021 at 11:56:57PM +0800, Yanfei Xu wrote:
>>> The stop_scan_thread() and start_scan_thread() cannot really solve
>>> the problem of concurrent accessing the global jiffies_scan_wait.
>>>
>>> kmemleak_write              kmemleak_scan_thread
>>>                                while (!kthread_should_stop())
>>>    stop_scan_thread
>>>    jiffies_scan_wait = xxx       timeout = jiffies_scan_wait
>>>    start_scan_thread
>>>
>>> We could replace these with a READ_ONCE() when reading
>>> jiffies_scan_wait. It also can prevent compiler from reordering the
>>> jiffies_scan_wait which is in while loop.
>>
>> I'm ok with READ_ONCE but your patch introduces functional changes.
>>
>>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>>> index 92a2d4885808..5ccf3969b7fe 100644
>>> --- a/mm/kmemleak.c
>>> +++ b/mm/kmemleak.c
>>> @@ -1567,7 +1567,7 @@ static int kmemleak_scan_thread(void *arg)
>>>        }
>>>
>>>        while (!kthread_should_stop()) {
>>> -             signed long timeout = jiffies_scan_wait;
>>> +             signed long timeout = READ_ONCE(jiffies_scan_wait);
>>>
>>>                mutex_lock(&scan_mutex);
>>>                kmemleak_scan();
>>> @@ -1812,11 +1812,8 @@ static ssize_t kmemleak_write(struct file 
>>> *file, const char __user *user_buf,
>>>                ret = kstrtoul(buf + 5, 0, &secs);
>>>                if (ret < 0)
>>>                        goto out;
>>> -             stop_scan_thread();
>>> -             if (secs) {
>>> +             if (secs)
>>>                        jiffies_scan_wait = msecs_to_jiffies(secs * 
>>> 1000);
>>
>> For symmetry, I'd add a WRITE_ONCE here as well.
>>
>>> -                     start_scan_thread();
>>> -             }
>>
>> The reason for stop/start_scan_thread() wasn't to protect against
>> jiffies_scan_wait access but rather to force a new delay. Let's say you
>> start by default with a 10min delay between scans (default) but you want
>> to lower it to 1min. With the above removal of stop/start, you'd still
>> have to wait for 10min until the scanning thread will notice the change.
>> Also, with secs=0, the expectations is that the thread won't be
>> restarted but this is removed by your patch.
>>
> 
> I see.
> Thanks for your explain and sorry for my bad introduction. Will send a v2.
> 

Hi Catalin and Andrew,

I sent the v2 patch which is renamed to:
[PATCH] mm/kmemleak: fix the possible wrong memory scanning period

I have tested it on qemux86, and hope you can help to review. Thanks.

--Yanfei

> Thanks,
> Yanfei
> 
>> -- 
>> Catalin
>>
