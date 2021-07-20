Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B034C3D0212
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 21:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhGTSfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 14:35:00 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:61434
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232404AbhGTSer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:34:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+tqszrDf89zo5YCRzAeSun/OdVNaPxe63hGrRReaTyLrG8RbOoTZ9m3/lBoGJ2tEB4abM+oG/Z2QJfzkvfi6TRko9dGUE2dmvhWL4w7iarirXK4DkKq82XV52puKlb0FySvsS2HhY4SFZjzvw5y4J5an5XfLqxlgm6BWxBswFIIEvEkDykrJf6/mJlqTjTFISjAtjrmUNVvu1QNn7rSR0uBAesdiCY4PDARn6UBreeMWYljHF8jxAFLjxkuSxwXq0QTolgzvq9heA7KqN5c8+LX//lmQ8GIGXKBOl0ytmDb2BqDRpcDHF/Wxk0KdQP1iUxUw68jxOd1EwUohOku7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVwcU8MWWtKVuMKI6Uv9BkqLu0m5pNCW9PX3aDny54I=;
 b=XHwW4cbC+Q0abD3WEip1l6+9Blnj7mXfvzYjDVh23eIqI+1dUyUYVAfYlYPm/cYfZlWhKS8++hYEg4R9UFhzHr7ubU/4O7y219felDdT1m1HlXsqc7n7T69fUmG0V4XDP0RJICvDV+ojb8wSOBYVR2cDj9LhfBnpdwEipzj4NfZpAbNTYzKnwwYGLMIXpD9s1acLQ41u5rwp/G4J7Pmj5WghzT9jQ22flQxdqFcU+qdaBS9qfPqbc86GllXARuc3wgp9hTZrWTZknSMqHSPGWXUrhn6p60A48VKs+Y7MYFK9FGcfp5FCqdqGHvq6/WC+FusLmDVlWutjw08L9nWXkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVwcU8MWWtKVuMKI6Uv9BkqLu0m5pNCW9PX3aDny54I=;
 b=1Jh38XsXD9GDQes/HzE7OVlJjg01DxI4opoEePxrSdGOfci8OiYSqKFum7jTsroo3an/K86S1gzZiKJ2CZ3gdhgTiLYBp5R+RaP2weS8q4Gpddh33+GNNK6Xfj7lMjlewkfmJ5xOMIbGpT6B6/64uAZ3UXhof150CqIZ9uvuCPg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1808.namprd12.prod.outlook.com (2603:10b6:300:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Tue, 20 Jul
 2021 19:15:19 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::add0:6be1:b4de:8bf7]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::add0:6be1:b4de:8bf7%8]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 19:15:19 +0000
Subject: Re: [PATCH] x86/resctrl: Fix default monitoring groups reporting
To:     Reinette Chatre <reinette.chatre@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, pawel.szulik@intel.com,
        "Luck, Tony" <tony.luck@intel.com>
References: <162499005859.4842.12410192091197461691.stgit@bmoger-ubuntu>
 <27e33283-a18f-bc4a-eedd-1d30907c9efa@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <b5370944-4770-b957-8b42-fcfdea91e079@amd.com>
Date:   Tue, 20 Jul 2021 14:15:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <27e33283-a18f-bc4a-eedd-1d30907c9efa@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0238.namprd04.prod.outlook.com
 (2603:10b6:806:127::33) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.0] (165.204.77.1) by SN7PR04CA0238.namprd04.prod.outlook.com (2603:10b6:806:127::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 19:15:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b812946-52d5-4606-31e2-08d94bb2b6bf
X-MS-TrafficTypeDiagnostic: MWHPR12MB1808:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18080ED654DDA15FDD9E87DA95E29@MWHPR12MB1808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CabZz2fkQRpsyeBg5NuQAPL2qwzABzGHcRH8xxmFA6Us/gV7lb7n6M7PtkZJcWzhCYHaR6RvWOy3Uey56X31tRmj4DMqcNLnUeh6Bx6VoHcuOJ9eln3y3KsASNI0lgj0QcLRvFBqy9/e4r/3OxE8FONJgx/aQWbKyBa8Fd2MpfC2LZY5QApevzlYbGKPsx7Phfsts2p1JhDjO10yOnI8IPUEuM6rgqaKN8hQSs5d299Knyf6m0Ati9e4WNIrw7yeIPPNVGUNW6hNbUxWxPZZ/5AkxQ2mbO8+Aq+fm/jT9/4/+69CEUYdicb04QuCdfyv7v02gzQEakW3LPnJoYRbPgCJe8V23/gYq0QYM9ilTXkMv5j5qRwSvrClSm6xibrc/sOABRzcZYx0NQlVW0CHW4uak7YqoFYsuCb7EWO0MWYfQrvNeuzQv3GPur1JtpjoZ5q6Uj5GwY4YJW2pxF82Zctgfd8ed2SBYzkAW5vXtSlF8u3RGejk8VhLrQWKHTKkXhcUCC8FefJwG1mkgdJOCmR/PDSAyDMTe+MwqokKUdzDqC2VjeeDTjdGXTvSqhLU6DZB0KPrPOXz8UvlO9tak+i2H/qM0tlz1kRcGgZmSPZoq//Q36ktZ9qACMPr681Ee/3ETWAeRfddOmkXR1kAhoHQVc0uNoK4draSi6Dwc070IZntohC00t1YC6LIt7NQbgAeaDXnDxZelsxscq0xEJgN71Kf2rVCMB+MPKnqMSbGnRjQo9iot3U9ox83z7L8ltOwr2WxQzV2i37GuBkmQr9NQjEF5i7aa5VNq7eNz79V0fzZjBmU6hvXX/2qgTKifP5BIkf3ZKb/Ihr+/4bFbHPxtx5kCZXj41kGFV6uWLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(44832011)(2906002)(7416002)(4326008)(478600001)(966005)(186003)(52116002)(53546011)(2616005)(956004)(26005)(31686004)(36756003)(83380400001)(8676002)(8936002)(316002)(45080400002)(16576012)(5660300002)(66476007)(66946007)(66556008)(6486002)(86362001)(31696002)(38350700002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFRFVzFUcmJWTEQyRmF0RFlxWnVLNVp3V2kvSjI2NUVoeFplY0VBamd3SU5O?=
 =?utf-8?B?a3lJMVBSczZJR1Jkb1V0d2drOFlSdFNGL3BsTGNmY0ExMHVuOGxLcHFGZGI2?=
 =?utf-8?B?SUNFc1ZmT0s4cmsySElRbmxnbWNkWVVQZzd2aThoOEZlZ3YxVTRtUTlWSk1i?=
 =?utf-8?B?cnRWZi9GUHl3Wk1KWWhob1lVUWtFeUFFbWpJMmJNQkdsTnFscCsxU1JGOEsr?=
 =?utf-8?B?RzVUVGZnZmFoV05WZ3RNbVM5UHJ1NG1kZDcxN3p0MzVqbytObkhKYUVZK0FM?=
 =?utf-8?B?Z1c1ZnFmMFdtdHhoTk5kSkRYQU5DaGRuNkpIeTk4azRmLzRLeWwvSHhRUHRL?=
 =?utf-8?B?cEVFNDNGYlI1dmVSUjNpUFNBQlhkQ1JubDdHbzZsZUx2UWw5aEtXUVlNVmpC?=
 =?utf-8?B?U0pTbzJFc3U1NlBzTzIrMnkvLzlEVURCRi9YeTRRKzJJamlrbS9YL3RDM1ZW?=
 =?utf-8?B?VWc3MUhWNThacjlGeW1zU0xEdGtLT0tJMlp1TlNZN3JPcHFIUW5lNVIzUlhE?=
 =?utf-8?B?dnNVTXBPN3lvRVFzWmxKTDhLVW9YMkozcDgwN05lYUR1Z2JBam9hUXV4ZEZR?=
 =?utf-8?B?eE9WSmNxaUNHcjBvSG5CTVNsZ1pIQlA0ODVrZEloYVhqdDlNakJjbTdORlJZ?=
 =?utf-8?B?TUlwdUVaTk4rOWtZb20wV0grTTFpcXJ6bWM2Rk9yMFRYQVdjTWFVM1hvc0cy?=
 =?utf-8?B?bTFtbFdoQWFaOEdBUXFkVUg2N2dpcW5PZ2lKdDhTUnRNSGUzZ0VGaTVSNUZy?=
 =?utf-8?B?MWN6YWNrOFU5TktuRk9BQjlFczdvQmJqSmZtMlF4OHVyYVVYcGtxZlJRT2w1?=
 =?utf-8?B?RGEvVU4zSTZUWVM5RzZOcWVnbUZTM1U2TE5XcWd2VE83aFc2MWJucE9yTUFE?=
 =?utf-8?B?elY3cmU1NllkenRtNDdJVjR1ZzB3UkxCd1NndG9jakhhUXRjaGZIWTl6T1Rk?=
 =?utf-8?B?ODkrbmYyckNRMTJ0M0ZSU0I0SFQvaWY0SzZmTU1ycDZCMVBWTS9NdDVwRFlU?=
 =?utf-8?B?M1MwZDNaU09Sc1QyaWIyQ1pCUVJjL2FqSnJqZ3RYRnZKZ0NMUkwwcDdHcUp4?=
 =?utf-8?B?ekk0MlQvSEJiTUwzSm9XcFRVV09abmYrQTFLSEVXaERkM2dRelJ5dzg4Mkl4?=
 =?utf-8?B?cExXY3R2Tk0zM3BGZHdyV1duS3pFdkhoeTlJREtLQk52TjBiK2czVjdWejRL?=
 =?utf-8?B?TnpjMVprdUhjZ2k0bzY5MzZRTUxDaSs5Rm91L3RLdlhub3lIRmlNZnA4b2Vv?=
 =?utf-8?B?d0xyN2d6WHBTRlpPb2J1V08vUTI3YUR3UGZ0K29Gek1ESENJb2prazZsK1lW?=
 =?utf-8?B?bTJ1VlRMY0ZmVlp5dVBaZmZhSzFlME9wMzdleUx0RDQvQ0Rub0RWNDlsVW9i?=
 =?utf-8?B?YUV5eVhzaHlaT3Mzb3U2K0w2TXgzYXkrMjQ2Nnh5R2Z2d2Y4NGlNQ01ReHZ3?=
 =?utf-8?B?RmF0eGJwZS9PZ283NTNOZHBUMUN1c3NYNVhYdHp1cWlTSG5yZEljVjBUbzlk?=
 =?utf-8?B?cHJJM0RYWG9ibmpxcHRweC80Qk5QeXZFR0JISmptL3ZGZmV3QzNPZlRJaURk?=
 =?utf-8?B?SXZNMldOeHJjbkllTUVEVFJUeFArQmtuTEdTbDZhQ3oybjArbms2TWFoSGQ5?=
 =?utf-8?B?NlFXRGVJYlFQYUwxZEVhVHIyME4rTm1QckRCOUpGMVRubndxVmk3bEhWTTZz?=
 =?utf-8?B?UXFwVXFERy9GV1BHNmNkOWdMTWJiYk9vT1JiY1I0VjdIejYyMkp5SGJvVHc2?=
 =?utf-8?Q?e8w2bqQWG2tkYrxbnbnI50veAQLjAodeOroVZkS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b812946-52d5-4606-31e2-08d94bb2b6bf
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 19:15:19.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iG6EhgHwWvNNqQJ2ohkQjNdpgdY4FXrblrc7wUWfhWfrgaVeBW7/rxXNhXw7zynz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1808
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/21 3:43 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/29/2021 11:07 AM, Babu Moger wrote:
>> From: Babu Moger <Babu.Moger@amd.com>
>>
>> Creating a new sub monitoring group in the root /sys/fs/resctrl leads to
>> getting the "Unavailable" value for mbm_total_bytes and mbm_local_bytes on
>> the entire filesystem.
>>
>> Steps to reproduce.
>> 1. #mount -t resctrl resctrl /sys/fs/resctrl/
>>
>> 2. #cd /sys/fs/resctrl/
>>
>> 3. #cat mon_data/mon_L3_00/mbm_total_bytes 23189832
>>
>> 4. #mkdir mon_groups/test1 (create sub monitor group)
>>
>> 5. #cat mon_data/mon_L3_00/mbm_total_bytes Unavailable
>>
>> When a new monitoring group is created, a new RMID is assigned to the new
>> group. But the RMID is not active yet. When the events are read on the new
>> RMID, it is expected to report the status as "Unavailable".
>>
>> When the user reads the events on the default monitoring group with
>> multiple subgroups, the events on all sub groups are consolidated together.
>> Currently, if any of the RMID reads report as "Unavailable", then
>> everything will be reported as "Unavailable".
>>
>> Fix the issue by discarding the "Unavailable" reads and reporting all the
>> successful RMID reads. This is not a problem on Intel systesm as Intel
> 
> systesm -> systems

Sure.
> 
>> reports 0 on Inactive RMIDs.
>>
>> Reported-by: Paweł Szulik <pawel.szulik@intel.com>
>> Signed-off-by: Babu Moger <Babu.Moger@amd.com>
>> Link:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D213311&amp;data=04%7C01%7Cbabu.moger%40amd.com%7C6931f61de9f34fc2175708d94af5eae3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637623242329908534%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=eyJwUSKewq8msA6iv6%2FVrbr9QBLUxZKhyJneRREBfm0%3D&amp;reserved=0
>>
> 
> Is a "Fixes" available? If this is specific to AMD then could this be the
> change that enabled AMD systems?

Yes, I will add "Fixes" in my next revision. Hope I will find the proper
commit. I would consider this as a generic fix.


> 
>> ---
>>   arch/x86/kernel/cpu/resctrl/monitor.c |   27 +++++++++++++--------------
>>   1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index dbeaa8409313..9573a30c0587 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -285,15 +285,14 @@ static u64 mbm_overflow_count(u64 prev_msr, u64
>> cur_msr, unsigned int width)
>>       return chunks >>= shift;
>>   }
>>   -static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>> +static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>>   {
>>       struct mbm_state *m;
>>       u64 chunks, tval;
>>         tval = __rmid_read(rmid, rr->evtid);
>>       if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
>> -        rr->val = tval;
>> -        return -EINVAL;
>> +        return tval;
>>       }
>>       switch (rr->evtid) {
>>       case QOS_L3_OCCUP_EVENT_ID:
>> @@ -305,12 +304,6 @@ static int __mon_event_count(u32 rmid, struct
>> rmid_read *rr)
>>       case QOS_L3_MBM_LOCAL_EVENT_ID:
>>           m = &rr->d->mbm_local[rmid];
>>           break;
>> -    default:
>> -        /*
>> -         * Code would never reach here because
>> -         * an invalid event id would fail the __rmid_read.
>> -         */
>> -        return -EINVAL;
>>       }
>>         if (rr->first) {
>> @@ -361,23 +354,29 @@ void mon_event_count(void *info)
>>       struct rdtgroup *rdtgrp, *entry;
>>       struct rmid_read *rr = info;
>>       struct list_head *head;
>> +    u64 ret_val;
>>         rdtgrp = rr->rgrp;
>>   -    if (__mon_event_count(rdtgrp->mon.rmid, rr))
>> -        return;
>> +    ret_val = __mon_event_count(rdtgrp->mon.rmid, rr);
>>         /*
>> -     * For Ctrl groups read data from child monitor groups.
>> +     * For Ctrl groups read data from child monitor groups and
>> +     * add them together. Count events which are read successfully.
>> +     * Discard the rmid_read's reporting errors.
>>        */
>>       head = &rdtgrp->mon.crdtgrp_list;
>>         if (rdtgrp->type == RDTCTRL_GROUP) {
>>           list_for_each_entry(entry, head, mon.crdtgrp_list) {
>> -            if (__mon_event_count(entry->mon.rmid, rr))
>> -                return;
>> +            if (__mon_event_count(entry->mon.rmid, rr) == 0)
>> +                ret_val = 0;
>>           }
>>       }
>> +
>> +    /* Report error if none of rmid_reads are successful */
>> +    if (ret_val)
>> +        rr->val = ret_val;
>>   }
>>     /*
>>
> 
> With the commit message comments addressed:
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Thank You.

> 
> Thank you very much
> 
> Reinette
