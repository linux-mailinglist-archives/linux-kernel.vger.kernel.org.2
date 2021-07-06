Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC5D3BDB3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhGFQUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:20:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:37909 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhGFQUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:20:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="189522771"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="189522771"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 09:17:41 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="486328230"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.249.229.136]) ([10.249.229.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 09:17:39 -0700
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix IIO cleanup mapping procedure
 for SNR/ICX
To:     "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ak@linux.intel.com, alexey.v.bayduraev@linux.intel.com
References: <20210706090723.41850-1-alexander.antonov@linux.intel.com>
 <3d634baf-8abe-480d-61ed-ade1945324ee@linux.intel.com>
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <0292c242-dc53-253d-da87-710b001aa3e7@linux.intel.com>
Date:   Tue, 6 Jul 2021 19:17:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3d634baf-8abe-480d-61ed-ade1945324ee@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/2021 5:12 PM, Liang, Kan wrote:
>
>
> On 7/6/2021 5:07 AM, alexander.antonov@linux.intel.com wrote:
>> From: Alexander Antonov <alexander.antonov@linux.intel.com>
>>
>> Cleanup mapping procedure for IIO PMU is needed to free memory which was
>> allocated for topology data and for attributes in IIO mapping
>> attribute_group.
>> Current implementation of this procedure for Snowridge and Icelake 
>> Server
>> platforms doesn't free allocated memory that can be a reason for memory
>> leak issue.
>> Fix the issue with IIO cleanup mapping procedure for these platforms
>> to release allocated memory.
>>
>> Fixes: 10337e95e04c ("perf/x86/intel/uncore: Enable I/O stacks to IIO 
>> PMON mapping on ICX")
>>
>> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
>
> The patch looks good to me.
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
>
> With this fix, there will be several similar codes repeat, e.g., 
> XXX_iio_set_mapping() and XXX_iio_cleanup_mapping(), for SKX, ICX, and 
> SNR for now.
> I guess there will be more for the future platforms. Have you 
> considered to add a macro or something to reduce the code repetition?
>
> Thanks,
> Kan

That's a good idea.
I suggest to do it together with enabling of mapping on future 
platforms. What do you think?

Thanks,
Alexander

>
>> ---
>>   arch/x86/events/intel/uncore_snbep.c | 40 +++++++++++++++++++---------
>>   1 file changed, 28 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c 
>> b/arch/x86/events/intel/uncore_snbep.c
>> index bb6eb1e5569c..54cdbb96e628 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -3836,26 +3836,32 @@ pmu_iio_set_mapping(struct intel_uncore_type 
>> *type, struct attribute_group *ag)
>>       return ret;
>>   }
>>   -static int skx_iio_set_mapping(struct intel_uncore_type *type)
>> -{
>> -    return pmu_iio_set_mapping(type, &skx_iio_mapping_group);
>> -}
>> -
>> -static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)
>> +static void
>> +pmu_iio_cleanup_mapping(struct intel_uncore_type *type, struct 
>> attribute_group *ag)
>>   {
>> -    struct attribute **attr = skx_iio_mapping_group.attrs;
>> +    struct attribute **attr = ag->attrs;
>>         if (!attr)
>>           return;
>>         for (; *attr; attr++)
>>           kfree((*attr)->name);
>> -    kfree(attr_to_ext_attr(*skx_iio_mapping_group.attrs));
>> -    kfree(skx_iio_mapping_group.attrs);
>> -    skx_iio_mapping_group.attrs = NULL;
>> +    kfree(attr_to_ext_attr(*ag->attrs));
>> +    kfree(ag->attrs);
>> +    ag->attrs = NULL;
>>       kfree(type->topology);
>>   }
>>   +static int skx_iio_set_mapping(struct intel_uncore_type *type)
>> +{
>> +    return pmu_iio_set_mapping(type, &skx_iio_mapping_group);
>> +}
>> +
>> +static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)
>> +{
>> +    pmu_iio_cleanup_mapping(type, &skx_iio_mapping_group);
>> +}
>> +
>>   static struct intel_uncore_type skx_uncore_iio = {
>>       .name            = "iio",
>>       .num_counters        = 4,
>> @@ -4499,6 +4505,11 @@ static int snr_iio_set_mapping(struct 
>> intel_uncore_type *type)
>>       return pmu_iio_set_mapping(type, &snr_iio_mapping_group);
>>   }
>>   +static void snr_iio_cleanup_mapping(struct intel_uncore_type *type)
>> +{
>> +    pmu_iio_cleanup_mapping(type, &snr_iio_mapping_group);
>> +}
>> +
>>   static struct intel_uncore_type snr_uncore_iio = {
>>       .name            = "iio",
>>       .num_counters        = 4,
>> @@ -4515,7 +4526,7 @@ static struct intel_uncore_type snr_uncore_iio = {
>>       .attr_update        = snr_iio_attr_update,
>>       .get_topology        = snr_iio_get_topology,
>>       .set_mapping        = snr_iio_set_mapping,
>> -    .cleanup_mapping    = skx_iio_cleanup_mapping,
>> +    .cleanup_mapping    = snr_iio_cleanup_mapping,
>>   };
>>     static struct intel_uncore_type snr_uncore_irp = {
>> @@ -5090,6 +5101,11 @@ static int icx_iio_set_mapping(struct 
>> intel_uncore_type *type)
>>       return pmu_iio_set_mapping(type, &icx_iio_mapping_group);
>>   }
>>   +static void icx_iio_cleanup_mapping(struct intel_uncore_type *type)
>> +{
>> +    pmu_iio_cleanup_mapping(type, &icx_iio_mapping_group);
>> +}
>> +
>>   static struct intel_uncore_type icx_uncore_iio = {
>>       .name            = "iio",
>>       .num_counters        = 4,
>> @@ -5107,7 +5123,7 @@ static struct intel_uncore_type icx_uncore_iio = {
>>       .attr_update        = icx_iio_attr_update,
>>       .get_topology        = icx_iio_get_topology,
>>       .set_mapping        = icx_iio_set_mapping,
>> -    .cleanup_mapping    = skx_iio_cleanup_mapping,
>> +    .cleanup_mapping    = icx_iio_cleanup_mapping,
>>   };
>>     static struct intel_uncore_type icx_uncore_irp = {
>>
>> base-commit: 3dbdb38e286903ec220aaf1fb29a8d94297da246
>>
