Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4470C3B7769
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhF2Rww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:52:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:18383 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233843AbhF2Rwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:52:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208240786"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="208240786"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 10:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="492778961"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2021 10:50:22 -0700
Received: from [10.212.193.2] (kliang2-MOBL.ccr.corp.intel.com [10.212.193.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B6062580A88;
        Tue, 29 Jun 2021 10:50:20 -0700 (PDT)
Subject: Re: [PATCH V2 2/6] perf/x86/intel/uncore: Add alias PMU name
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com,
        "Antonov, Alexander" <alexander.antonov@linux.intel.com>
References: <1624911463-192936-1-git-send-email-kan.liang@linux.intel.com>
 <1624911463-192936-3-git-send-email-kan.liang@linux.intel.com>
 <YNq6ZqzHjQbV2ceN@kroah.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <37726d03-c988-5f26-b133-d48408f30e89@linux.intel.com>
Date:   Tue, 29 Jun 2021 13:50:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNq6ZqzHjQbV2ceN@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2021 2:15 AM, Greg KH wrote:
> On Mon, Jun 28, 2021 at 01:17:39PM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> A perf PMU may have two PMU names. For example, Intel Sapphire Rapids
>> server supports the discovery mechanism. Without the platform-specific
>> support, an uncore PMU is named by a type ID plus a box ID, e.g.,
>> uncore_type_0_0, because the real name of the uncore PMU cannot be
>> retrieved from the discovery table. With the platform-specific support
>> later, perf has the mapping information from a type ID to a specific
>> uncore unit. Just like the previous platforms, the uncore PMU is named
>> by the real PMU name, e.g., uncore_cha_0. The user scripts which work
>> well with the old numeric name may not work anymore.
>>
>> Add a new attribute "alias" to indicate the old numeric name. The
>> following userspace perf tool patch will handle both names. The user
>> scripts should work properly with the updated perf tool.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Cc: gregkh@linuxfoundation.org
>> ---
>>   .../testing/sysfs-bus-event_source-devices-uncore  | 13 ++++++++
>>   arch/x86/events/intel/uncore.c                     | 19 ++++++++----
>>   arch/x86/events/intel/uncore.h                     |  1 +
>>   arch/x86/events/intel/uncore_snbep.c               | 35 +++++++++++++++++++++-
>>   4 files changed, 61 insertions(+), 7 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore b/Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore
>> new file mode 100644
>> index 0000000..b56e8f0
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore
>> @@ -0,0 +1,13 @@
>> +What:		/sys/bus/event_source/devices/uncore_*/alias
>> +Date:		June 2021
>> +KernelVersion:	5.15
>> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>> +Description:	Read-only.  An attribute to describe the alias name of
>> +		the uncore PMU if an alias exists on some platforms.
>> +		The 'perf(1)' tool should treat both names the same.
>> +		They both can be used to access the uncore PMU.
>> +
>> +		Example:
>> +
>> +		$ cat /sys/devices/uncore_cha_2/alias
>> +		uncore_type_0_2
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 7087ce7..ff07472 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -846,6 +846,18 @@ static const struct attribute_group uncore_pmu_attr_group = {
>>   	.attrs = uncore_pmu_attrs,
>>   };
>>   
>> +void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu)
>> +{
>> +	struct intel_uncore_type *type = pmu->type;
>> +
>> +	if (type->num_boxes == 1)
>> +		sprintf(pmu_name, "uncore_type_%u", type->type_id);
>> +	else {
>> +		sprintf(pmu_name, "uncore_type_%u_%d",
>> +			type->type_id, type->box_ids[pmu->pmu_idx]);
>> +	}
>> +}
>> +
>>   static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
>>   {
>>   	struct intel_uncore_type *type = pmu->type;
>> @@ -855,12 +867,7 @@ static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
>>   	 * Use uncore_type_&typeid_&boxid as name.
>>   	 */
>>   	if (!type->name) {
>> -		if (type->num_boxes == 1)
>> -			sprintf(pmu->name, "uncore_type_%u", type->type_id);
>> -		else {
>> -			sprintf(pmu->name, "uncore_type_%u_%d",
>> -				type->type_id, type->box_ids[pmu->pmu_idx]);
>> -		}
>> +		uncore_get_alias_name(pmu->name, pmu);
>>   		return;
>>   	}
>>   
>> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
>> index 6d44b7e..f65fb73 100644
>> --- a/arch/x86/events/intel/uncore.h
>> +++ b/arch/x86/events/intel/uncore.h
>> @@ -560,6 +560,7 @@ struct event_constraint *
>>   uncore_get_constraint(struct intel_uncore_box *box, struct perf_event *event);
>>   void uncore_put_constraint(struct intel_uncore_box *box, struct perf_event *event);
>>   u64 uncore_shared_reg_config(struct intel_uncore_box *box, int idx);
>> +void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu);
>>   
>>   extern struct intel_uncore_type *empty_uncore[];
>>   extern struct intel_uncore_type **uncore_msr_uncores;
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index 44f2469..fc09ca4 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -5429,6 +5429,33 @@ static const struct attribute_group spr_uncore_chabox_format_group = {
>>   	.attrs = spr_uncore_cha_formats_attr,
>>   };
>>   
>> +static ssize_t alias_show(struct device *dev,
>> +			  struct device_attribute *attr,
>> +			  char *buf)
>> +{
>> +	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(dev);
>> +	char pmu_name[UNCORE_PMU_NAME_LEN];
>> +
>> +	uncore_get_alias_name(pmu_name, pmu);
>> +	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name);
> 
> Please use sysfs_emit() for new sysfs attributes.
>

Sure.

-	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name);
+	return sysfs_emit(buf, "%s\n", pmu_name);



>> +}
>> +
>> +static DEVICE_ATTR_RO(alias);
>> +
>> +static struct attribute *uncore_alias_name_attrs[] = {
>> +	&dev_attr_alias.attr,
>> +	NULL
>> +};
>> +
>> +static struct attribute_group uncore_alias_name = {
>> +	.attrs			= uncore_alias_name_attrs,
>> +};
>> +
>> +static const struct attribute_group *spr_uncore_attr_update[] = {
>> +	&uncore_alias_name,
>> +	NULL,
>> +};
> 
> ATTRIBUTE_GROUPS()?
> 
Yes, I think we can use it.
I will change it in V3.

Thanks,
Kan
