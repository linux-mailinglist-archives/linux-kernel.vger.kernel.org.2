Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0197C3E8BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbhHKIdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:33:37 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:15826 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236029AbhHKIdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:33:31 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17B8M4BL030057;
        Wed, 11 Aug 2021 08:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : from :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=fYICoi4cVz0SEv+vVZ2irggYhjLAFUdZL209q7DlU88=;
 b=cW5j8VnYKbYAe1MPbL8CNVwjehRtP6xQnn5tSbPulHUw/5DjL6u4lAMBwbX4YNpYBfpk
 lRfQr2rgq6Rgnw0is0hF+p81R6chaHboDB2WsnfxFaHfQXu3f6UF/PFVH9vdHi914v6V
 SW+P3VkR87DD3pKJLSonexoOyY7eEaBEjMdmr8lgxbED1uki+C1ADEtZ98XAtC24r6eq
 xj1aBVCPZWHgg9ZdTEm7nlbG/uncptPXamdQTdZZ7PCZbxDy+n9iK3EGmrgILqHWE0qG
 iXRy/CQ4pjwRIwHsWdLkjcEgUh2r+CFJhdbhOrOco4Ec/iE2wawYh04Vfc64OW9zAgH+ pw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-0064b401.pphosted.com with ESMTP id 3ac2et88ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 08:32:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m44B0R/5H1ZqEs/voSSNlFs4eGYOtiiQ0ukzZ3OzRU300kD4A8gZa1XmCg5ICtHIPV3Mr7HcgH2WLn0rhvkqw4mwlRE0A86lc7AmTX04dzcSH99KKUZR2R2Cjp6WXxpCMyy7A9d+4GvVaDP9pWhqwzir3TBKHrWivWhEpenLv6ufLua94ixyRbTdAdxDNhpOtFBnDoIe0YopNBZGFfWyhdYYGTO3B/QKXhlftMu7OjwEAssMpVFsDYP7E5aBpe7JTUCqsLnlEbQ3aT0DGN1Zdwg3zotZJO+iMTUq/teDSXcLl2Sizyj6OVdoC88ET7s6D7/yEi6gPzkNZXJD7eJSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYICoi4cVz0SEv+vVZ2irggYhjLAFUdZL209q7DlU88=;
 b=JJDP7RTzbf3kk7LlGW1FnAVifMgT/BdKQElV54/RIpLVfiEq+YEYuP5aVhmcmUBq3GX2MABM+b3hSS712VeY4S9tLXg3OjHKr3grWfzFH3UQla/TOXciZ3f+3uDKGW7G1OChDd0iW0yUjvSkAAzD62dR5BGgbEMTQVnJzZfKogiTLrzruKEZsFn2NmCL8lbFDm/XbxYpgIC/Rx1mRqfOQj2/BIbm5Ogb6SFiPZb0yc8upg9RcpqNA7o/kLet3S+49BURd2C1szIYJnfJjweY8Btfo0U9FNWF0orASgEkAb4HqcXWZ7RuEH35Nb4mD1cwcvUTxow/itKvL0qs5ViQ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM6PR11MB3563.namprd11.prod.outlook.com (2603:10b6:5:13e::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13; Wed, 11 Aug 2021 08:32:41 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::8ccc:636b:dcea:7a5d]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::8ccc:636b:dcea:7a5d%5]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 08:32:41 +0000
Subject: Re: [PATCH] kernel/hung_task.c: Fix a typo in check_hung_task()
 comment
From:   Jun Miao <jun.miao@windriver.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        deller@gmx.de, wei.liu@kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210806114049.649909-1-jun.miao@windriver.com>
 <CAKXUXMxrE=OO3K6fafU38GDp3cvEtRYrqo-w2-hDO6OrvHe26Q@mail.gmail.com>
 <c40abc2d-2343-2eba-a5e4-4309a2577908@windriver.com>
Message-ID: <facd857b-6fb1-75c0-0b81-39176fff3e7a@windriver.com>
Date:   Wed, 11 Aug 2021 16:32:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <c40abc2d-2343-2eba-a5e4-4309a2577908@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HKAPR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:c8::13) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.214] (60.247.85.82) by HKAPR03CA0008.apcprd03.prod.outlook.com (2603:1096:203:c8::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Wed, 11 Aug 2021 08:32:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9e50e91-7f56-4d19-7db2-08d95ca2952f
X-MS-TrafficTypeDiagnostic: DM6PR11MB3563:
X-Microsoft-Antispam-PRVS: <DM6PR11MB35634A9E25A71A54AA31EB9E8EF89@DM6PR11MB3563.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFEo1r+m8Pu1C5FYVCZB5uetKQktda7RTPHAFNB+Lv8yoPPPqmzkChOMxTaITdPOY+yYiFiH4X4YlComlXnx27Aaw158TnXH5m4EFpJU9qEut1VZEP81lyJDQuwrqV2xGrW7VFWbnXurui2xF5IZswZO5eAQb3yfXk5UzYCYdFMp9dl3C2GMxg967IfMfominLwzOHlzK8zj0/yJz1dCnlPG2iTUFAka2dqfL+1tGXdBRJQ/3FSczcDGeh+jenECyFJtG49esIVhjUMc25RVQx0aZrwZcThCiIm/wt4Re0/rjI+oXhoFBIy+p9FBbZFby/AVMp/0hNVhi0feHNktTpu0G2hwlBAH/bFtV4WVhoEmukl2OU5yd38bxUPNm82L8NNG02zNGIxfR+321Zvr27PXbx4YuWwt5SYOLk/9de9YWaqccoNkJDbUMk3nsGKizRbOX4Zf+1kx6ROl77PBIZ3s9K6dYgtiRrsLd1EuQWKTeBjmv8aUcz/uhR0ziwTXEM6f5eLx0AI363shJ12NRM6vp32RTtxen+BbSuY17+pwgLuapQ0eZNX0ron89gJRel2ceArKssKMErs9AUWZGidjza3CoShWBLYoOV7xOv9g3L1Q98jq3nStG5Kr4cjfVenQbFWVgT/PHiDkIneWr0uA2Ik06b+jmYKzE8gGzspTNttR5+ivhmnWP6P8LrE0gxj/r7kq3zV9Zr7qKRmTSZzILxUqJtaQ1470hfWpzt7/zvuf7bHsrtLNNbg2cdPwoFcenuR2B0JiBdnBocmSp5NLNnGzUu2i22vQu/xb6P0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39850400004)(6666004)(6486002)(31686004)(316002)(16576012)(44832011)(6706004)(54906003)(8676002)(26005)(8936002)(186003)(38100700002)(38350700002)(53546011)(52116002)(478600001)(66946007)(66476007)(36756003)(86362001)(66556008)(5660300002)(83380400001)(956004)(2616005)(4326008)(31696002)(109986005)(2906002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui8reVcyMTdBYVFSd29hM1JyVXA0MGJ5emxwWk1mN0o2SlBud0dDbW5YZjI1?=
 =?utf-8?B?Tk13Uyt1ZWVVVkcrSlRIOFVvcjN2S3NHeks2cHUweTA2TEdkNG5iWDBxS0ha?=
 =?utf-8?B?UWxURGRKR3F1dnRvYkpIcDg0SHhHdWExM1ArclAzeVVRM1RRQU82dkpyMDI2?=
 =?utf-8?B?ZERsNWVSRGN1ckl6MHEwT29NSDZIckh0M1hVTWNtMVJTekNiTHdsdzJja0hz?=
 =?utf-8?B?MmdHTmUxSEJIbUpBRnUvR1hoakJlN2JmVUxzUThJQUl3NkpxNzBwVkJjT0VF?=
 =?utf-8?B?RzMwanArVzUzVjM1a2JZbnk5OGtXclNGK0ZONFZtVDdwbEdVSUt0VGZETDNh?=
 =?utf-8?B?enVIdDZxNEFCc3lUZlRPSnRhaW9wZHo1bHpBQXlTMGUwR2YvdGVvODQ2Mm1h?=
 =?utf-8?B?OTkxbTZ3TlZjdnlMdllNdTNrSlhjNVVUOW9zOGtVcHNBUFhEY0R1MHN0VjMz?=
 =?utf-8?B?RDdDeThsdmZmcmZ4N0c5NzJhTHlhZHVid3RMcy9NNDVWN1ZUTXRIWGtHL3hu?=
 =?utf-8?B?NDFmUzZuUS9zRm5ncURZYndZU2hGeTJiQzZaekZHdlBhaFJOS3dzQ0UwYU1N?=
 =?utf-8?B?aExZeDFlTGREK055YnpLdXJ0d0FVMU45V0JoYlNpS2tXSzZzbTIzLzh2Z1o4?=
 =?utf-8?B?bmIrbTVpZkhDbCtoSTZ5aExtdmZ2LzYreDVDYzExWGlqN2h3L1U2eVFxUkQw?=
 =?utf-8?B?M3VHbUdGYXd2TFV4U1BaYWFsdkVvT1RRWnhGRk1jQk9SNlV6TUZoNC9SaFhP?=
 =?utf-8?B?YVQrUjltK3Vtb2ZWWmdObmtTbWVtajg5ZHZ1Vi9udzNyVWx2OVExMWpaTzMr?=
 =?utf-8?B?ZHZSR05Fa2l2aVM4THJBU1VFSURxWm1RbjFMSDlhRFJpZEwrKzdWbXBvK3J1?=
 =?utf-8?B?SlAyNmxobTlKVlNCU2NVSkFSbzBaT29BWmk2eDdGemF1REhQdnVTM0t3QlhU?=
 =?utf-8?B?b3ZHWG9yS0wzNVR0d1NabTFQMmdVMWZieGx0TE9DN2JlMk8yenJBTlc5aUE2?=
 =?utf-8?B?L3pBTU5XckxmK3pmMVhlUFNZUVJ3cysrVVVhRnFFSkRabUdnRmh0YW4xOFd2?=
 =?utf-8?B?SENXQ20wSUMvU3psYm1MZDM4dVkyQndxdDVtMjA5dzJud1ZWTnIrWXZsZVo2?=
 =?utf-8?B?b0Y5SmRWNjIwT21rSHIyOWZHcXJ0SUJ3QUFiM3JjOGpXMXEwV2VnbTlUaDN5?=
 =?utf-8?B?QVdRY3A4S1h0VTErazU2SDRSVWtrNy8rWXB0NU9JVkdzc01EMDdHcG5CUkN2?=
 =?utf-8?B?SEtVeVRQVk5MQTRkVytIOGJraUNIaUZvMmdBVzBZWlU2RHdXR1pSREkxSmUx?=
 =?utf-8?B?cTBpaTRBLzRibk5ET3k3TGpTdml1N2dLN2M3K29JTytISmhTUk5ITllMMGlF?=
 =?utf-8?B?cDhmekFwVnpUcHpsMGJCbU5Wc2N1VFNKM0hWR3E3L2x2U1RKL1huNks5ZFY1?=
 =?utf-8?B?UjRUdjIyZDdudXVDYTZEdGxaQ2pnREhEMGYzYklNOXkvaFY3UVhMZTh3NjBR?=
 =?utf-8?B?WWlnb0IwUEttVEZNU3JsMW4yeng2RWNlTjJGODZBYzM3SXQxZ2ROcWh6SDZM?=
 =?utf-8?B?K1htYVgzU05SL3A1WHVubFdvb0lGYXp1eWM1RUc1VDZGekVRb2R0SDVkYmFD?=
 =?utf-8?B?M0tjVVlZenZ4UTRpN1U2UitMRnA2WVVnZG5ieE5iekJJaW9kK1Ura3BHaHFs?=
 =?utf-8?B?aW9MYzdiMW4zZGsvTlVkYmovSzAxSENRT2hzK0ZMOFFiamY0aVdXc3NFT0h3?=
 =?utf-8?Q?RP0nKU1lngst3a1WwqxbeAEl4MWWSBUvXXIXqou?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e50e91-7f56-4d19-7db2-08d95ca2952f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 08:32:40.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igdjbCpHs+9qWAHkUVN9kAcUf8FxiHxjKsAjlxjweUzdwa2qCTZ3hgR2aAcCfoNAsReOOdjcjYzUHdd8/Qy0cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3563
X-Proofpoint-GUID: 9HuMSyNanBPrbYQMMdYJGaQWe3n1nl9m
X-Proofpoint-ORIG-GUID: 9HuMSyNanBPrbYQMMdYJGaQWe3n1nl9m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-11_02,2021-08-10_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110055
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

     What about this spelling mistakes ?

Thanks
Jun


On 8/7/21 8:21 PM, Jun Miao wrote:
>
> On 8/6/21 10:27 PM, Lukas Bulwahn wrote:
>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>
>> On Fri, Aug 6, 2021 at 1:41 PM Jun Miao <jun.miao@windriver.com> wrote:
>>> It's "mustn't", not "musn't". Let's fix that.
>>>
>>> Signed-off-by: Jun Miao <jun.miao@windriver.com>
>>> ---
>>>   kernel/hung_task.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>>> index 9888e2bc8c76..ea5ba912db06 100644
>>> --- a/kernel/hung_task.c
>>> +++ b/kernel/hung_task.c
>>> @@ -99,7 +99,7 @@ static void check_hung_task(struct task_struct *t, 
>>> unsigned long timeout)
>>>          /*
>>>           * When a freshly created task is scheduled once, changes 
>>> its state to
>>>           * TASK_UNINTERRUPTIBLE without having ever been switched 
>>> out once, it
>>> -        * musn't be checked.
>>> +        * mustn't be checked.
>> I cannot even parse this comment.
>>
>> Does "When a freshly created task is scheduled once, changes its state
>> to TASK_UNINTERRUPTIBLE" mean "When a freshly created task is
>> scheduled once and it changes its state to TASK_UNINTERRUPTIBLE"?
>>
>> Does this "it must not be checked" read as "it shall not be checked"
>> (as in "because if you check it, something goes wrong") or "it is not
>> required to be checked" (as in "usually, you need to check it
>> (otherwise something goes wrong), but here in this case, you do not
>> need to check it, because it cannot go wrong in this case")?
>>
>> Fixing spelling mistakes is okay, but it is even better to check the
>> sentence you are correcting and try to comprehend it.
>
> Hi Lukas, thanks for your advice from my heart.
>
> From the context of code:
> ---
>  90         unsigned long switch_count = t->nvcsw + t->nivcsw;
>  91
>  ... ...
>  99         /*
> 100          * When a freshly created task is scheduled once, changes 
> its state to
> 101          * TASK_UNINTERRUPTIBLE without having ever been switched 
> out once, it
> 102          * mustn't be checked.
> 103          */
> 104         if (unlikely(!switch_count))
> 105                 return;
> ---
>
> It should read as "it shall not be checked" (as in "because if you 
> check it, something goes wrong")
> . When create a task and set it as "TASK_UNINTERRUPTIBLE" we don`t 
> need to check "swtich_count=0".
> If check will report a false positive.
>
> From a history commit cf2592f59c0e, there is a detail explain:
>     - the task is freshly created and scheduled
>     - it puts its state to TASK_UNINTERRUPTIBLE and is not yet 
> switched out
>     - check_hung_task() scans this task and will report a false 
> positive because
>       t->nvcsw + t->nivcsw == t->last_switch_count == 0
>
>     Add a check for such cases.
>
> Thanks
> Jun
>> Lukas
