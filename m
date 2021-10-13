Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DE642B9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbhJMH4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:56:30 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:7430 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230057AbhJMH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:56:27 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D6o7YG030147;
        Wed, 13 Oct 2021 00:54:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=LJ/UT0bStwkJnNf9OIaEvFmHi2TNQm2phnktJdrio5Y=;
 b=Gu8X2hhBXvffsbuyjWNGRjCYBLCp58CzOdyTupRcSK6erIIwAZJmd63SmL5SL+gyHtSF
 SkuhySHR5985ZeT99RsrEPHLlW+vCpnQwRRGkVFgtOYmSau9WEc8aswBaCNpStNMhuHv
 a1qJtwFCJaBnMVRXp/hLAAVE1V/SKxWYK8IPtDeBl4z4TCQsMDyNZis4JdCPQlbexnVD
 upsr9b+M0Ay/AGVNtz0W7eGpjHBRGcek54eXu+Uqlx1RvMoUYDcyHd0gWiokUbqj2qwo
 s+m4BnUnDEP7hCp0AW9lvRqKofFrSOQKw6l5cDhnhY1q0rse9pmbmILU2jT5zW66ji6D Og== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bnka70avd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 00:54:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsXvfqTkMYnZoAal9Uw4x1dBlNzHs/HvJXiBs5PgWrbCidHC3j1Bhd6UzrdFJHi/KR4EUsGuone5Ql6wnVZvX4Rozf11OwfKk6H/9o5C3ocydxTuyAFq+5Mvpa3fkhNkKjRP6/JrZ8TGEzNE2KO88PhRvHNE/AwKH5Td4+nnKOlDOhYsUZrmE/WpcVYb8bp1eLY8eCzDeR5Zp0Xsw4Rbu2Ljqy6Zw2I5RRf69xXKIFU0T4Cxc1cR4FN8+fzmN2Tb8mzDyUnS9W94UPJymWgm8NHhuT99K4EuAZUaWg8TYI8/FkNH2lZLsW+eEVMQMOfRdWsBk2uQ8kgmwVyWosbGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ/UT0bStwkJnNf9OIaEvFmHi2TNQm2phnktJdrio5Y=;
 b=j9+m/6rOhZyy/owB8jobbB7HU0gbWLKUHkskIMH+gAnrmoTZnOkwCOZmscEuBoS5XfwX2Ev4l7RUO1S1z85zxdJIYEc+PaRj4XMmsEE7nW1jtaylHxUusMS59x7YECykS0QREG7KmlpQ8S5IwfpbH8ejErSAC9rmteBv5iA4sfq2ioJyX9Nr/ns5ZlR7ELd0icyyRPLht0vZHm4SnhwHODtOkFiVTHAbSlnB9CKNMmUUi3NiSiAbOV6h592uNf85sx9F8e2CEJk0Xpjjg7lWutvC4hivdORaF9QiknqzhwkqfruRfIXIcJJT6qCkCVMvUJY+WPKYTLLent514nEHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CH0PR11MB5739.namprd11.prod.outlook.com (2603:10b6:610:100::20)
 by CH0PR11MB5219.namprd11.prod.outlook.com (2603:10b6:610:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 07:54:09 +0000
Received: from CH0PR11MB5739.namprd11.prod.outlook.com
 ([fe80::bcf2:571f:eb41:1737]) by CH0PR11MB5739.namprd11.prod.outlook.com
 ([fe80::bcf2:571f:eb41:1737%2]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 07:54:09 +0000
Subject: Re: [PATCH v2] locking/mutex: remove rcu_read_lock/unlock as we
 already disabled preemption
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
References: <20211008032518.1298372-1-yanfei.xu@windriver.com>
 <YWWKhoRzUWoMsJbk@hirez.programming.kicks-ass.net>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <1aab91a4-07fc-c7f3-d04b-93ccf05ae425@windriver.com>
Date:   Wed, 13 Oct 2021 15:54:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YWWKhoRzUWoMsJbk@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:202:16::21) To CH0PR11MB5739.namprd11.prod.outlook.com
 (2603:10b6:610:100::20)
MIME-Version: 1.0
Received: from [128.224.162.160] (60.247.85.82) by HK2PR02CA0137.apcprd02.prod.outlook.com (2603:1096:202:16::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20 via Frontend Transport; Wed, 13 Oct 2021 07:54:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 449b5031-eeee-4341-ce63-08d98e1ea353
X-MS-TrafficTypeDiagnostic: CH0PR11MB5219:
X-Microsoft-Antispam-PRVS: <CH0PR11MB5219BC86AAFF177DE32FA208E4B79@CH0PR11MB5219.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aXk3ssPUkwbBiLCq1hYqemTeVgLIw57neQdYcjryGZGkBCvbBb0BTwGHRLzNWS13Uqeh0xSQcxpFhqe1Ew0XtJ5+VQLmTJwbVdScYPJ25WhBn+ysxAV/rryLCY5D1s990w11R3b6g3VkKRpCmOMHWLMk8Uwv9C7eGDg9tJM9wqEEQE70PlJ/Ao+8lv6uWPlzqUGN/gvBViW+IEwqOCBiHceTK6xK4eKCNaM/VpULVSmaO3/SQ8S1AkV10bjnY78lI1LRXzstCA9w8qViLjbtXdVj1woYu9TN7FEUPOIZjfEOHsL3DswuLetlHPqzfLVk+fx1XKg7sal8E1ClvyB+vHgw2qTNtCHt0RfpvyUcxBZnkdcDkfEwCHKtBMtMjWP1sNIyzcvs2SB27ijlIfnCG55DrhpQ36VPsoaY9Lw+GoyUQQbxoE2fHry76leL1XrELMPAzr0sxkOFz09cZpfYHpP4bJEbh77G3c2nQ6/RdZ73hSUuI5qOtNT18VA5wvPXWj5rfZLqDNaury/YZN+xm+GyrvlYKSggfu5am7FU4MVc7f1DqJbAnrHJ1xmx4zVz9Ktpyj30j8dbZRCva1+DV78ytJxZi924HlkdcYpfJSVXmOFUlEGzUkgpIyHEDEVzaEL+3cgPv05JNVlUYZITk2pu8e2MLKmFq42zFvxiqOqDs6LMkd7NBNZP/2O0ldacYua66S7lViMUZIYNSuFQAJxnAfyXwGSIIMfOXVM4tYr2GMSCDPTtTfOToI8laiClXqqIb/ixCpnICegUlOQa+dFcasQm4K7PksNJOM9zuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(36756003)(53546011)(66476007)(38350700002)(66556008)(8936002)(2906002)(508600001)(6916009)(186003)(6486002)(83380400001)(8676002)(6706004)(6666004)(66946007)(5660300002)(52116002)(316002)(2616005)(16576012)(86362001)(38100700002)(956004)(31686004)(4326008)(31696002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDIySGcvdThqb1ljRjQ4K2tzalR2cERyQ250Wk1yZGd2bGhxY085UGViQnJv?=
 =?utf-8?B?TXVHajh0NzFUSlZrNldLWXhURUpscW5TMlVmc1JCWWlheGhBd3MyT3p1ZzBY?=
 =?utf-8?B?N2ZQR2xmNVJudngyZlg3K2tsQU1zYU1YOU53b3NOcUNqQ2VhZEdzNnpTNEJy?=
 =?utf-8?B?dHYxeUR1Y1AwY01VbXlWZ2F2WXdNSEo0bnlSc3cwN2tzekdPeFBEK293NlRo?=
 =?utf-8?B?N2N4YVJSRk1TMjhaakllYm5yOFFoUGpYY2RoUHhmOG0veC8wQm1IYmxSZmFB?=
 =?utf-8?B?ZjRGaEtWc1QzZGsvS0M3SXZZdW9LeGoxcjBkT05xajEwb1puUkhhUW8wbEpp?=
 =?utf-8?B?Qy96WGE5OXh4YWdRU1NnY2t3NHdUUXJBQXYxUkFpVjZra2NNUlhOZUNVOUgr?=
 =?utf-8?B?dUhSM21KZmp1bWxDMGlCVjRJbFVTbDNtRFczWVBlWHFWbkFhMWxyVXVrNm1F?=
 =?utf-8?B?QUUreVFYVVhpajg4Yk1KM1BQQWlVWmpqTytORHhxQWx5Q1I1YjVwSm5razNy?=
 =?utf-8?B?dEc3cHRxd3AwbGR3VTZrQ0luL0dPdXZFUCtwa2dLRS9jZC8vUTFMa2FjSUlK?=
 =?utf-8?B?b2s1QkJYUnpiVmNRTjRsQlFmMWEveDgzRFpQdG9nbG5mZFlxeit4WXFvdWJi?=
 =?utf-8?B?NEk3VUtUYVdIdTFPb2xEMWFMTkovcXBSR1NmRnNQWXFNMG5DRXZwaDJYNDNv?=
 =?utf-8?B?WnpGRXBUYjBjdXN2bkJxUEJuNms0QjBjK1BGdzZ1RURjT2ttRTVVSDFHa3Zx?=
 =?utf-8?B?Vk5kU1U5L0VrRStPaG5kWUFFK0w2K3NqUTg4VW10aU9MNjFwMm9LYzA2WVM4?=
 =?utf-8?B?N0ROMjlMSFAybU45WXMyRE80eVQ0SUVzaG0rODNLSGZYa1hXVFZCWDdsNGhZ?=
 =?utf-8?B?QWtRTERhMU43T3BtV1RtZjJJS2VPTHE1K1RnTEFRZ2xjWDJBdzJhRGdBUk5i?=
 =?utf-8?B?MXdyQWd1TytUREkvcUlUT1VSS1ROa1VNY1ZVT3FVZEVhOXZnanMvSzlUeTJX?=
 =?utf-8?B?d05zMG41RWtDZjhTRXZWSTVCT0EyOXRjV2UweCt4Q0ZncStqS1BPc05lcnFz?=
 =?utf-8?B?NG94VTkxeEpFWXRtU2dGakVrdTVKcSs0MUFwV2VqdGozWTYvVWdlU3U3OEsr?=
 =?utf-8?B?b3Nob3d0aVl1Z3lidWtpdVVJYTRPa1Q1S3lpTFFLdnRxOGZMYzRSWWphZmY3?=
 =?utf-8?B?Q2dnaTZUNnBPYk90U3hIN3JsT0FsU0QyejhGOEJHTTJ0MWNnWSt5L1hTMHZy?=
 =?utf-8?B?UlVjZXY5MnhZZnNaMTd6QlZKOWtjam5tN05WUGY5SHd3V2dOeE43SHQraWJp?=
 =?utf-8?B?dmJ4eEVhOXJKamFjdVpkNDJ1TmJPb0l3Umo3dHRLQUx5MEh3dzRadFcrZ0I1?=
 =?utf-8?B?d2lwRU9OVmVhSko3RjVmTmJnOVhtQ2NaMjIxRzVTSXBqdW50T3AzaWtlVExi?=
 =?utf-8?B?aWRsTE5VTkRPYmVJeEtoMmlkZGRDSDlRU3Q4cDEwakVreVhJSlpESUQ0SXZO?=
 =?utf-8?B?WExKQlorZEMxVVRIdlhRWE1TRDIrWGxDRUlUVzA4Mk1zamo5MTdZbCtCeWtk?=
 =?utf-8?B?STVYTERUN3I3S1oyZFhKMU8zUUNvckJyUHhoMWMvdGVsSmxORUxPM2pCbGYr?=
 =?utf-8?B?bHQzdU8yYU9GdTJrVEJJbGhQUGhCMFFSZUk2NWpQUFQ1MGhJMGl5K2FPNHlQ?=
 =?utf-8?B?a2ZoemhSMjJBMFAxUGU0K20xbFFoNG92TzNMbDIwcW9NeDFteTlyS3ArbFR4?=
 =?utf-8?Q?rIMRwqjcdsu3SgBt8dL6EHtIbwsZ9rvpQ9HV+Xd?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449b5031-eeee-4341-ce63-08d98e1ea353
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 07:54:09.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0pQmCrw7dbme5y3Q+Qc7uZ0ESpX2uuF3G+nIbstYyt67/eIWeJVeqxe9t+tPjc6GmRvXKrbH8MR0N+eCjyDxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5219
X-Proofpoint-GUID: Dgs9viuEPDgFW9CHmPKUlpq1bgaDxwnX
X-Proofpoint-ORIG-GUID: Dgs9viuEPDgFW9CHmPKUlpq1bgaDxwnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_02,2021-10-13_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 suspectscore=0 adultscore=0 mlxlogscore=983
 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/21 9:15 PM, Peter Zijlstra wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Fri, Oct 08, 2021 at 11:25:18AM +0800, Yanfei Xu wrote:
>> preempt_disable/enable() is equal to RCU read-side crital section,
>> and the mutex lock slowpath disabled the preemption for the optimistic
>> spinning code. Let's remove the rcu_read_lock/unlock for saving some
>> cycles in hot codes.
>>
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>> ---
>> v1->v2: fix the incorrect comment in code and commit message.
>>          thanks for WaiMan's suggestion.
>>
>> BTW, sorry for this late v2 due to a long vocation.
>>
>>   kernel/locking/mutex.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
>> index 2fede72b6af5..2f654cfb10d9 100644
>> --- a/kernel/locking/mutex.c
>> +++ b/kernel/locking/mutex.c
>> @@ -351,13 +351,14 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
>>   {
>>        bool ret = true;
> 
>          lockdep_assert_preemption_disabled();

Agree.

> 
>> -     rcu_read_lock();
>>        while (__mutex_owner(lock) == owner) {
>>                /*
>>                 * Ensure we emit the owner->on_cpu, dereference _after_
> 
> And did you check the other code in locking/ for similar things?
> 

I did a check, rwsem also has the similar things. Will do it for rwsem 
in v3.



Thanks,
Yanfei
