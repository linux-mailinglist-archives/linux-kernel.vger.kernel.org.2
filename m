Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9243527D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhJTSRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:17:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:48144 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhJTSRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:17:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="228799961"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="228799961"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 11:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="463286983"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 20 Oct 2021 11:15:39 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 11:15:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 11:15:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 20 Oct 2021 11:15:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 20 Oct 2021 11:15:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc/Zf4g50GwNwRYPnRbjsOluqy3XyQsJxW6JB7+DWfbW2qq1e3zgiBRjARKJ3sM7DIpGx/nGew0ozPB/GLxxNNnGH6Oc4awAm7XXiZXSdp9nyGyEOfzm1k0dG6nWOEXn1NJHkfvOWQVClpx94GFLLdeXOgSFqKu8baeXb91BM+mF/unFEFctGuiDgE3RWCnsaUwRLEMQ8P0dUHs4A3GzwxsQqeFrMrw1TYg7a5N2bVAtZiZfihst1bhJn+MF09EvfJPtejkjmCTPOPgfiGUd4mLwTEG7G536CcqRTrpD5z23jKVG+Ec/ZSVIifyE2SlQZEHwFcdDpKMrZg4udEgxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+rXe5PVQRh9RxRHLzPpl7senJHUcaI/g3j1bMfSrbQ=;
 b=NRB3FcPRghN8oVpX4I2dKTMsKz11lUfZPsqN3K/zq6NBTuarFHhvIEH6E0b+WnIJ3/rm+wzEMpjJz8tg9tSO4WE3pUY0E45EyKhYTNNd356XfBmrfmNgzfIfXZR1P0rg1lhTaWSoYPHyKNsFkOzfno4rQRXBMbch1RIsAgkRSa3N7mSrhlVrHfZw1c2CLYHkgKt8J7W2YAE8ERv9Z4FEguMNjDbIdqkiEYXWy1q31jsOdHEF5kofO5lUQ05HWOd9BPc621AbWxdW7pZjoHTqUMrbyujA7/Uv2zVMBara6SywmzcRzXHdVjV9uQYmTSAz7K3JK2/sW3o8hv+tYdr2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+rXe5PVQRh9RxRHLzPpl7senJHUcaI/g3j1bMfSrbQ=;
 b=NyeE2avFLVwvYFia/w4yOUUZpO4fU4/CxkaqF+R5cPZ1ebPw5/4JU9v7uDk/kAD841LJqHyjsxSmFimHXdju1in7HOGbLEwyA+V9WqiYcQ6Ai8YU8D1z4nzXZEyApnl47C7U027/sg1Ck+8qCWio7RI42OT/YMQcEf76fGAs2CY=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1236.namprd11.prod.outlook.com (2603:10b6:404:48::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 18:15:32 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 18:15:32 +0000
Subject: Re: [PATCH v2 17/23] x86/resctrl: Abstract __rmid_read()
To:     Babu Moger <babu.moger@amd.com>, James Morse <james.morse@arm.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-18-james.morse@arm.com>
 <887f8946-6d2b-27bf-a49b-f83af05cbc68@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <dfe2f33c-6103-9699-42f9-73983fa62057@intel.com>
Date:   Wed, 20 Oct 2021 11:15:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <887f8946-6d2b-27bf-a49b-f83af05cbc68@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:303:2a::11) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW3PR06CA0006.namprd06.prod.outlook.com (2603:10b6:303:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend Transport; Wed, 20 Oct 2021 18:15:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e927377-0dc0-4b15-5496-08d993f59ac2
X-MS-TrafficTypeDiagnostic: BN6PR11MB1236:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB12360753A9D2ED8334297C3BF8BE9@BN6PR11MB1236.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABIrZVNfGJVfcmHPTPGtC+5BRqtdcJbXFp+YUmTWZyn5bXYvDXkGkesHR2LeM1o4Np5spn4UJSbbCCVjvB2t3+knl4MSwjJV1E1UccX47S8Lq5NvzjE1uBdVKi9jBFT0x+1NqGCyWYjh/LsCUdoNJMY0ZkHWye5W1x0yxhkGEJNhBqYAik/Y5vHoJ4IPRVqJNU68Mo3AW/gp/mNWNjY2hTH3AGYd4iUSYuiOpCGDIkwHu9RnO5NyfdyjCa7E18gAhNIfWWHm6X1oz9LlITAV1bNMfTU1JqHELhiDRfju+jR7xAHDoJpe9/iAvxu2iIJIe0ZxSAE6TgE1UtQCRnS2CBQzxdNMpCdmyGVrJB0iH4ke7BR9OimGPlaMFUhbF7aACdyXH9XWBXSxYBcGStxuXr4l5WUDJoeTSBveWx8jFZhlXTQmY8FvrZ3MLeY6zXYiVLI6ZgfQjO9DqnkO6m5Gm1ULbyreTFtjMaNfEzhmCkPYmB9zJenLI2KerdN9JNt3hUpqPt8wcg0LSf+ZaHSEczqxHQDhmHxVLGJZtwF9k+2vKzTyEITWSQf+KfDSuaD277IvAju/01X4B+JwG0w+SMf5BjGx1+5It6PwpWZTwp+fg8Ni9wVMlGKA86K/c6cUo8kWKToff7bdZPzKKztC2tyZn5lWujwTKq7/HsCcscAc3HkZiUBCGC76s1erIx7jqHlMXLr4T8mCmS5CKTt9162cBgXftVyMpSujEuIeyo8DhxqfyCes12l7OufgiOz4/J0bbUsA/56CywFBuUcoAOhQe7ig8yYrdIYPTvMjn243aPhdZBsas4NGf7U2QPC2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(8676002)(110136005)(186003)(26005)(508600001)(966005)(8936002)(54906003)(2906002)(5660300002)(31696002)(6486002)(316002)(31686004)(16576012)(956004)(7416002)(83380400001)(53546011)(38100700002)(44832011)(66946007)(82960400001)(4326008)(36756003)(2616005)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c01hNlVrWUpLSHV6TEFGekhmd1I2VXVJQmgxcHN3Q0hFSzB4bW44THZVTHlI?=
 =?utf-8?B?eVd5b1djYnVadlJOQW82Ymx2empMeHNXMzAwOVlKR0U4aW9XZHF0ZlVLSUtD?=
 =?utf-8?B?bTRkaUxpK1JjYnh0OTFwUS9PZHNyTkNMQllQWFNoZHpwMm01ZDlWOVVBQjQx?=
 =?utf-8?B?U2RvdVI0QUdKcjlPL0hFeVFDVmdpcUJGa2hIdjJwRDhjTkJTMFJHMzdWZUcv?=
 =?utf-8?B?M0ZvUGsrZ0h1TGFuL2l5bnpqb3U1WEhBWisyL2FlOGV3aGhpblJlK1gyNjZ6?=
 =?utf-8?B?MzVIbTRaMzVYbDVVVUZRaVUwOEFiZ0VXSXVGNDdEaUVyWEtDTUdSMHk1Y3k2?=
 =?utf-8?B?bWZaWmEzM3Z5S1JHTE83dUNWWlc2bVRpWFJKdTJYYUNlTGZ4L0h6VE93clB2?=
 =?utf-8?B?WXcxNDJxM1hOeC9ITkprMHFpWS8xU1VHazl1REJsR212QWExeEZRZnEzcHo5?=
 =?utf-8?B?V3dZbFhqa2FtdVFja0dmZ2hjenBkOENyUU5FSjA3WWtkeFBwS1BkVkJmUVFh?=
 =?utf-8?B?YzZFdE1QdFZ1blBRU3dhcXZDeitFSzZadU41TkdGSVRBZ3JmS3dmTWdCbGNt?=
 =?utf-8?B?UmVaMW1EbjN0MTFVY1UyTE9QOFZrK09rOStjdEJjazh0alRzQ2hxQ0d0Ui9Y?=
 =?utf-8?B?QVZXaWpVSjFwOVpqNkIwYXRnM05FMnhkdmtSMzl3VU1la2pyZ0ZtODBsZWxm?=
 =?utf-8?B?TlkwYTRGTTBDSXJGRXFyYW5LTGp1aWJaRmZVMVpwQ0NlNmJmSjFVK2RJUmpE?=
 =?utf-8?B?SFA3dU1MUTk1TEdJNEI4V3RKUlA3ZjVSWGRsdGJWS2RTSEk4QkZCMUNscnhU?=
 =?utf-8?B?OWlOY25XU3hvQW5jTFhZMi9VcTN0eVFKNjZ4ZHh1NjhoSDgxS1FVOFM4elN1?=
 =?utf-8?B?a3dtL3dDcWl6SjVyaVp1dkhKSmJTQllwTDNnMTB3NGQ0N3cvbTBPN2cwcnl1?=
 =?utf-8?B?c2puRFFzc0FNdDdtMlpqUTVHb3dzZlJIMFBnYXlDSm12K2lYbXg3b0pjdDdM?=
 =?utf-8?B?RmNZSDVvdkNFUlN2TTc0RkJDUXpyVDdZRkxVTXdleUJQMk16NXpPd2lMcFRY?=
 =?utf-8?B?TDB5b1J5c1k0Q2dnSnU5NHdPQXdBVE43ek1kWGpyUFV0R1h0WXo1Zk9pVVBh?=
 =?utf-8?B?bHRBditNWEtSb3Z1UGMyOXdkdi9NWlN6c3Y4TkhnOTk1eG90bEpheElUNDMw?=
 =?utf-8?B?WVVIQk4rWDNYdUVMVjRJUXlZV05WcTlIbXhmKzNJM3NaWlVEUU1PZGVyVEpZ?=
 =?utf-8?B?ai81L3dGaGhlTElnQUFGbUVxMUlST0pqendNRFVKeG8raGo0YkdNUXhLUWhO?=
 =?utf-8?B?eFFoVGkwZnpUWVZTcWRPaWJva0RuZ3dnM1NPVVphWkZvSmVlQXU3OUVmSCto?=
 =?utf-8?B?ckMzeE5TQlltNWV1c3lTak5FNXZDOHFOeTNrcFVLdmJnK0dpSFltSStGNTJx?=
 =?utf-8?B?L2wranR3cUJGWEdlMWxVSmIvUGMyM2RjUEptMW1JRjB6VURENGV1bnMwR29J?=
 =?utf-8?B?T0FCakNSc0x0cGdMc2w0WmJoNUtzeUMvVUM3YlBTL2NsbmJoTFJGT0YzamNZ?=
 =?utf-8?B?TGpOUDhmckhCNDg2c3l5WjlrTDZWc2h6aGR0UVg1K2M4aU1mcFYyRWtXMi9n?=
 =?utf-8?B?ZTVSVXpDdVhXR3c5eGswY3NTMUwwU1VUZ3dzT0Y3ZCtmV0dYazNkdFRreXlC?=
 =?utf-8?B?c21QTjllNE9vdDRrd0gxVWt1dWNXb3BtQXVnYlczN2lDdmhXOFJQc1E1SmZB?=
 =?utf-8?B?Y3FzdUJyWUY4Rk54ZHhpTGFpRWhxS2VOR2FTVUZ2UWppYm9nVUlUbVp0ZnJa?=
 =?utf-8?B?RUhOZmtzelgyZWVRcDl1VmtSd2Rvamkrck50L2VVUXNYYjFPVHlpNEpkeUFC?=
 =?utf-8?B?TUxBYjRFbTJGdno4Rkc4RW5jZUR3akF5SzBtSHNTczJaeXJUOXk5Z1pucTJL?=
 =?utf-8?B?T1ZuSGpxMWt6NHEwWnd1NkNhdXo4bFU5cVdieHBJOGttODNVbXg2cWlJRGNl?=
 =?utf-8?B?Y0NYSTJGbU9OeDAwc0tVbTJEamZhbXVVT1JhdHAwKyt1cWt1ODJiOUdHUU0z?=
 =?utf-8?B?cnRpcmdXSVdoVTBNcnFackJKVlFIcGpoMUk3bnpLUzNNSWlwSlkvR2FuTlJO?=
 =?utf-8?B?bVI1bkVycENXU1VncWZZaGZlaWozWDFHdUVod05hNmRJdkt3TEFWOTN3bUw1?=
 =?utf-8?B?R0ptd2V2V0YxTVVMckNTZVBVRTYxYUZKNzBKc1QrbEFGUkpEOEtTZ2R1SzZ4?=
 =?utf-8?B?bm9aMTN5dDBkSi9aeDJEa0lxSkJnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e927377-0dc0-4b15-5496-08d993f59ac2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 18:15:32.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxSnrp8g+SvY6jhQND0nrvmgPMejeMTK1BV5bltbFBinZdGOPpP7gE4fEbczyuvK2Sjm4FpiAebT5Crfdeik9cz0127n3kRL0SBospVIUjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1236
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/19/2021 4:20 PM, Babu Moger wrote:
> Hi James,
> 
> On 10/1/21 11:02 AM, James Morse wrote:
>> __rmid_read() selects the specified eventid and returns the counter
>> value from the msr. The error handling is architecture specific, and
>> handled by the callers, rdtgroup_mondata_show() and __mon_event_count().
>>
>> Error handling should be handled by architecture specific code, as
>> a different architecture may have different requirements. MPAM's
>> counters can report that they are 'not ready', requiring a second
>> read after a short delay. This should be hidden from resctrl.
>>
>> Make __rmid_read() the architecture specific function for reading
>> a counter. Rename it resctrl_arch_rmid_read() and move the error
>> handling into it.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
>> Changes since v1:
>>   * Return EINVAL from the impossible case in __mon_event_count() instead
>>     of an x86 hardware specific value.
>> ---
>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +--
>>   arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>>   arch/x86/kernel/cpu/resctrl/monitor.c     | 42 +++++++++++++++--------
>>   include/linux/resctrl.h                   |  1 +
>>   4 files changed, 31 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 25baacd331e0..c8ca7184c6d9 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -579,9 +579,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>>   
>>   	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
>>   
>> -	if (rr.val & RMID_VAL_ERROR)
>> +	if (rr.err == -EIO)
>>   		seq_puts(m, "Error\n");
>> -	else if (rr.val & RMID_VAL_UNAVAIL)
>> +	else if (rr.err == -EINVAL)
>>   		seq_puts(m, "Unavailable\n");
>>   	else
>>   		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
> 
> This patch breaks the earlier fix
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.15-rc6&id=064855a69003c24bd6b473b367d364e418c57625
> 
> When the user reads the events on the default monitoring group with
> multiple subgroups, the events on all subgroups are consolidated
> together. In case if the last rmid read was resulted in error then whole
> group will be reported as error. The err field needs to be cleared.
> 
> Please add this patch to clear the error.
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 14bc843043da..0e4addf237ec 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -444,6 +444,8 @@ void mon_event_count(void *info)
>          /* Report error if none of rmid_reads are successful */
>          if (ret_val)
>                  rr->val = ret_val;
> +       else
> +               rr->err  = 0;
>   }
> 
>   /*
> 

Good catch, thank you.

Even so, I do not think mon_event_count()'s usage of __mon_event_count() 
was taken into account by this patch and needs a bigger rework than the 
above fixup. For example, if I understand correctly ret_val is the error 
and rr->val no longer expected to contain the error after this patch. So 
keeping that assignment to rr->val is not correct.

Reinette

