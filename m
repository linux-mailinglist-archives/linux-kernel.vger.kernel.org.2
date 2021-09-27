Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE052419962
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhI0QnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:43:18 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:18344 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235543AbhI0QnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:43:13 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18REslvG011405;
        Mon, 27 Sep 2021 09:41:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=By2mcS59sjzaJQOQJGSQALCLMCFU48D7wzDhcJo3Jaw=;
 b=a03KxpZASskns4Pf9vmP7I+tzEe8XCGWBzDMKFBuaUMc30Flwka1YLM992I2YnAbOuTr
 n84LlcEVXg7usnxYDwHnyEqpkCuvVSXhuGS6WbGtTgeL483NV+2fu71A8onH3O/GqqQu
 /UAlPO1oDKQOB78SoUaFTcxs+3kZrEskg3wibXmGWtrLmXFN1KJY+SvOrm6v10GI7k0R
 tvgq3+jOq2yHiI9q/9V+U6Fw1tyS9JIbFoyCFNj1Wlv/pT2pYgeXWnkjkVRiLPYIcP07
 jL2s8JojfLDxOEfpIsT3d1zxKU45JplsI5U03NrZb7eNAAd6kCBgaOW/lghKsH9Eszd1 Vw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bavv60pnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 09:41:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1yd83l04NLLEk2UnlSrUsqHY/zz1gAAeVEPDu1JK/EYCcIYbDbfIYg7ROkz0xbXw8IBGlrZteFTvsYusVqGmQO5y1ctd6geXBRyhoo51/0gdYM+5E7nL8C4cGSVPQQlohWJVrfs5ttIhKgujcA9LejGNMoFdznkZoXgpla539a2hgZhGv3t5to0tUdJW7ULU5hQy1bWbrR3gAS7Trmye/+pY71FDXA1jhR3L4GlUYjZdueqrAq1Y+ViNogvXr9yGzZqXezEdSBC7IYbviWJZmQXkD4Wf9M9t0MIaQRtDJKCdyPo2viGAwYR9BLmO5rTN8kSQn4z38LaF5WiwgxAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=By2mcS59sjzaJQOQJGSQALCLMCFU48D7wzDhcJo3Jaw=;
 b=TU8ZL3RZsOP7hdG0O5c0uKXVPiSzpxs09/cY+FE3g/1JyN0orOOYmzARuSyxar3mV94eXxKFRz+RgzGU6PsYfZZ+grWJb/Hp7Fj1FdnDnxNaY0RyAyovlMVfIcrZZggR81Df/xyZo2JP3LWFNDqpvNdI6TdEp0ZTROfctjFM9DnsMgT6oDbyM5iZxtg/B08jaQzlI4c4IzsuX7ld1OmBE4krrlyVNj3AMg1OmTXr1kzEr9mEHDidBZ0AWpcFZg2rUWaHh8akq0XOSZLkjAmed52IcDvEJL9Ro1YekcCn01rCbsjJeafrZPMp1i1iMP8LUIxW84nE2y5zFSICEQlYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB4721.namprd11.prod.outlook.com (2603:10b6:5:2a3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Mon, 27 Sep 2021 16:41:23 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5%3]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 16:41:23 +0000
Subject: Re: [PATCH 2/2] locking/rwsem: Use rcu_read_lock_sched to simplify
 codes
To:     Waiman Long <llong@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210926101624.2460704-1-yanfei.xu@windriver.com>
 <20210926101624.2460704-2-yanfei.xu@windriver.com>
 <4e4c9adf-5444-e331-fefa-0d72aea8ba57@redhat.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <0c9507f6-a28c-44db-ea80-6b31847b2504@windriver.com>
Date:   Tue, 28 Sep 2021 00:41:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <4e4c9adf-5444-e331-fefa-0d72aea8ba57@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:202:2e::21) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from [128.224.162.160] (60.247.85.82) by HK2PR06CA0009.apcprd06.prod.outlook.com (2603:1096:202:2e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 16:41:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4f86827-2241-425a-30db-08d981d5a427
X-MS-TrafficTypeDiagnostic: DM6PR11MB4721:
X-Microsoft-Antispam-PRVS: <DM6PR11MB47216EF4F5EF54C49C913264E4A79@DM6PR11MB4721.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Csd2CQTGTTqRZI6qCx/CH7n9RJglPjD5jhWXg1sitW7b8baTA6yzB0kDQud9EyIzNqhACxSqtuMf7yENgDCJUl88kzFU9jUjpf5Hc3AtrTEAwMnHN7hzTZobvJj1vq7RZLG7C/GRI50AYExKTkfEJzk0rVhvLqKUHTmW1zBi4YQmzkUPTKIdzJ99LYDHHjiSTDA3bufDplgRUg7FHXTF1mSCjrHRkjlbu7rFGaT+A1fEVGBua2rxoJknw32I1F4xOhQnDtCQoFbGTTHdcHmn2kytUP4THs3IQHOm8YAI1hW6cL+8QsArDaA67ikFU7BBq+gUv2P78SYkn7kvx/JKROEuTe0x6Z9XqRsxEXSJKpt+SGyTuy5Wc0mVb9P2SXMCaSQeq+ykQs1bBiKaiuANnWKM1g0W1CHX1ku5LoISlxRwLtgn7eFaj1VVM9AAtLSD3sZbZnzjBWR1rqIC/v0m6GZ31ODR1vyjIs7b3fVj24tq/ESc14g43x0nZtQI6JikpJybqjPT1ot7hF+uZNTNlXhN7ymp+YpyKtRycv36QTNon+eYzYKQRjh+eGhtn6se+7y1a6+400ponXqLVOj8xcPpcLxP82zaOgzR2JQGfEqVTK67s5ZSX1XSjasebPhfw6D0O+hirA0mc20cvf7BgaA2oHcMrB/VeKnPMJevOULn2ZTfyRFLm2IKsZQAQjQQGF6wlGmAkcATotAvgsHlscUJUa45L/0y6SM1+PFRu1SXY3rFX5Fly2E4Aacgb+D4ZQUGKI+WN1vUTqnkYQzKMVfT1I6aPXm23V7tMeSzjNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8676002)(6706004)(8936002)(6486002)(508600001)(316002)(16576012)(38350700002)(38100700002)(31686004)(186003)(5660300002)(86362001)(66556008)(36756003)(31696002)(66946007)(52116002)(956004)(2616005)(4326008)(26005)(83380400001)(6666004)(66476007)(53546011)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGs4MnppalhqLy81Y2JjSDBieTllREtlTEsvYUJHZnlYL1RSVXdqaGQ1Znpi?=
 =?utf-8?B?TjNBMzFrSFVTN3VwcTIySEkzS081RHFIcVJaOHJwV1dPcU5LQnQzcTdPbjdS?=
 =?utf-8?B?cDZvUUc0dzIwZGFEQ0xzSU9vRmJXcDFBK2xXSlFuVm16Z1ZVdlJQSGlQSmpv?=
 =?utf-8?B?TTJFbVYyOCsrSGFaZDkzRGVqWlA3N1pTU092NkZ1N2xZUmZMT2ljcTlPcGpv?=
 =?utf-8?B?V2RFOTZZNk9sVldGTWJCQXpJdGNidnBBUmR4bWNja2lDNHM0aGZPeWVCZDRq?=
 =?utf-8?B?R2h3TUNhRUdWcURWRXcvVnlnSnVmRDRtRFM1V0NtdkQ5WlZOeklRUFp0NWRt?=
 =?utf-8?B?V3ZySGpKSWlNYzljNE5vSk5VM0lyT2tYVld3djhFd2hkcUw1bFpmNS9EQm9l?=
 =?utf-8?B?RDNuSFY4TTMrQU9yZVd2bjhjaDMvZ28xWW9QQ0p1Y2d6RTZYV3dtckxPWDNR?=
 =?utf-8?B?L2hqK0tMemN2UzFiNHNwR2I0SjNwVWtUR3YxWTBiVGhVSWNTaUdBSWh3YzBE?=
 =?utf-8?B?cFRidmZxTmRqZnM5QVlmQzZNdkR4UWJVOEg2a1gyTjhyMnJpTkU0eFdQOHZr?=
 =?utf-8?B?bGtBcDlLV0NnYTRrY3pvKzdqWEhLVjRDVXdpNUJVREtVUkFGbndmQlNvTm5t?=
 =?utf-8?B?ZEF6REJwYWRqL1pZTGRHVURxdnlsWjBWRWQrcHkvOW1Hc043Y1huMThabWNO?=
 =?utf-8?B?NE1lWnFtdTc0T212VHZOOTFvWEVoQlRyNmNzUWcrdW1OL05IYWFlSFZPbFJI?=
 =?utf-8?B?MnZ5dThDdnE1N1dndkszNzhnclBPMDE0dVJudmJQdWpLUGlVeWYwWm9VcnpJ?=
 =?utf-8?B?eDZwS2pLUVNqNUYrSXQ4aFo0MkxFOWdlaytBd2dBMk0vTFZuTEVjMUYwaGZq?=
 =?utf-8?B?S0s0eVUzQ040SzZhQ0h1dDRNRFNrNVQ3OE5OamVkREg2NHRrcXpKc1JNdTUv?=
 =?utf-8?B?dmsrYmNZMHBiRlJkVWFjclFiRWFCLzdINVZhM1BYdVJvSlZLMFFWWmhHV3pH?=
 =?utf-8?B?amFZN01XMGc0UmFhR0M4amIrMUtZYmMwcmdCQWpGNUo3dlJnNU5KVHdOYUd6?=
 =?utf-8?B?RWRGVFNVTFZUOEdRN043Z0VSUkc2MEYwcmYxNDhmU0FEcEJuRkVRNVFxcWg5?=
 =?utf-8?B?VENiZG8xNjNhZmFFaXEzM09NREtmako1eURoUkhDRktHU2VRWXJYZHJxZk1j?=
 =?utf-8?B?WnNDcHA4TGJNdDBoYjhuSW1XOGIrTit2MmFZaHE4SjdZQ1hDb1NSU08yVW9Y?=
 =?utf-8?B?cFlvQnQ0T3QyM0EraW9HS3hLU3VYclM3dW5EbFhZdnBiT1dBV2VPcldXcVJx?=
 =?utf-8?B?RnUzWHFrZzJxb1BsUWtUd25EMld2eXZVd29VVzAvdk1IdytFZnBjVXhxbFli?=
 =?utf-8?B?VWt3V3dhS0t3ZDV2VytHQ2VNaFpWWUV0eE9tZzNmN2Ewa3N0M2NKZkRIQnNr?=
 =?utf-8?B?Q3hlS0crK0tjdHlQdCtEQkwxZzdkVldVVkxkcGVlNlU4MWRPR2p3OEFZYWJF?=
 =?utf-8?B?RWNiWTU5a2tkYm9aTTcxa21uK1JPUENaL2FjUi8xNWg1TG5WY0FhZXp0SlpE?=
 =?utf-8?B?akRLeFNSUWkvVWxSTGdZQkswd1ZYTVNrQzBxRmhIT1QyMlJNWUZlWGZhVlpM?=
 =?utf-8?B?ejJLaExyUjArMDJCYmpwMERyNXc0YmczbXQ0Zyt4Q0QrdHRmR3JPbzhqSmRD?=
 =?utf-8?B?WHl4dStZdkRKMno0cGlNeHUxRUFjaTFLUWkrc3l5K3ZicldON0lQLzlBRlBE?=
 =?utf-8?Q?AdSossZMegsrv+cm+oJRjzrHl4yqAFd9BxQmh+B?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f86827-2241-425a-30db-08d981d5a427
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 16:41:23.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KO6ZsYpnv6T7MtMMMHiIbvxPrYiUuw5nfgmD5aFXwMYscQpOtNW/2eHjM9ZG9vIRcNBOtnyXbiDlYUqaxY84ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4721
X-Proofpoint-ORIG-GUID: 06TCNvpLC25atjudk0XKjFQ_ZZQENQe1
X-Proofpoint-GUID: 06TCNvpLC25atjudk0XKjFQ_ZZQENQe1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_06,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/21 3:22 AM, Waiman Long wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On 9/26/21 6:16 AM, Yanfei Xu wrote:
>> Use rcu_read_lock_sched to simplify the codes, and it also saves
>> some cycles of handling rcu nesting counter.
>>
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>> ---
>>   kernel/locking/rwsem.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 000e8d5a2884..7afadfe02286 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -616,8 +616,7 @@ static inline bool rwsem_can_spin_on_owner(struct 
>> rw_semaphore *sem)
>>               return false;
>>       }
>>
>> -     preempt_disable();
>> -     rcu_read_lock();
>> +     rcu_read_lock_sched();
>>       owner = rwsem_owner_flags(sem, &flags);
>>       /*
>>        * Don't check the read-owner as the entry may be stale.
>> @@ -625,8 +624,7 @@ static inline bool rwsem_can_spin_on_owner(struct 
>> rw_semaphore *sem)
>>       if ((flags & RWSEM_NONSPINNABLE) ||
>>           (owner && !(flags & RWSEM_READER_OWNED) && 
>> !owner_on_cpu(owner)))
>>               ret = false;
>> -     rcu_read_unlock();
>> -     preempt_enable();
>> +     rcu_read_unlock_sched();
>>
>>       lockevent_cond_inc(rwsem_opt_fail, !ret);
>>       return ret;
> 
> I don't think there is any performance gain with this change. I would
> prefer the original code that is more readable as some people may not
> know rcu_read_lock_sched() will disable preemption if they don't look
> into it.
> 

OK, thanks for comments.

Yanfei

> Cheers,
> Longman
> 
