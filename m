Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82039859E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhFBJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:50:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:43507 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232385AbhFBJuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:50:10 -0400
IronPort-SDR: eQ3HEn+p6ZSFy1PVIGrpmxTVdVuX0X3lHs4PxR7ag/g3E9VXKtDtbkCgjrE/ze2ofpftqdoyy7
 FzDlL6eWiWWw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="203744559"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="203744559"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 02:48:27 -0700
IronPort-SDR: T9kP3vBxFolMa+dSg63YErrLDz4poagG0ixBgmUKb4GyLFYEYHYsB5WrlZUmuz7ADjxozYlrVu
 LYmtU3EEDBow==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="447337560"
Received: from tstaplex-mobl1.ger.corp.intel.com (HELO [10.213.195.193]) ([10.213.195.193])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 02:48:24 -0700
Subject: Re: [Intel-gfx] [PATCH -next] drm/i915: use DEVICE_ATTR_RO macro
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, chris@chris-wilson.co.uk,
        tvrtko.ursulin@intel.com
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20210528100403.21548-1-yuehaibing@huawei.com>
 <7e60320b-3a1b-0cdc-136d-29c139b27af7@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <80d29f19-f429-875f-d255-259a73051f51@linux.intel.com>
Date:   Wed, 2 Jun 2021 10:48:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7e60320b-3a1b-0cdc-136d-29c139b27af7@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/06/2021 10:15, Tvrtko Ursulin wrote:
> 
> On 28/05/2021 11:04, YueHaibing wrote:
>> Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
>> which makes the code a bit shorter and easier to read.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   drivers/gpu/drm/i915/i915_pmu.c   |  8 +++-----
>>   drivers/gpu/drm/i915/i915_sysfs.c | 30 +++++++++++++++---------------
>>   2 files changed, 18 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_pmu.c 
>> b/drivers/gpu/drm/i915/i915_pmu.c
>> index 41651ac255fa..fb215929b05b 100644
>> --- a/drivers/gpu/drm/i915/i915_pmu.c
>> +++ b/drivers/gpu/drm/i915/i915_pmu.c
>> @@ -834,15 +834,13 @@ static ssize_t i915_pmu_event_show(struct device 
>> *dev,
>>       return sprintf(buf, "config=0x%lx\n", eattr->val);
>>   }
>> -static ssize_t
>> -i915_pmu_get_attr_cpumask(struct device *dev,
>> -              struct device_attribute *attr,
>> -              char *buf)
>> +static ssize_t cpumask_show(struct device *dev,
>> +                struct device_attribute *attr, char *buf)
>>   {
>>       return cpumap_print_to_pagebuf(true, buf, &i915_pmu_cpumask);
>>   }
>> -static DEVICE_ATTR(cpumask, 0444, i915_pmu_get_attr_cpumask, NULL);
>> +static DEVICE_ATTR_RO(cpumask);
>>   static struct attribute *i915_cpumask_attrs[] = {
>>       &dev_attr_cpumask.attr,
>> diff --git a/drivers/gpu/drm/i915/i915_sysfs.c 
>> b/drivers/gpu/drm/i915/i915_sysfs.c
>> index 4c6b5d52b5ca..183517d1a73d 100644
>> --- a/drivers/gpu/drm/i915/i915_sysfs.c
>> +++ b/drivers/gpu/drm/i915/i915_sysfs.c
>> @@ -58,8 +58,8 @@ static u32 calc_residency(struct drm_i915_private 
>> *dev_priv,
>>       return DIV_ROUND_CLOSEST_ULL(res, 1000);
>>   }
>> -static ssize_t
>> -show_rc6_mask(struct device *kdev, struct device_attribute *attr, 
>> char *buf)
>> +static ssize_t rc6_enable_show(struct device *kdev,
>> +                   struct device_attribute *attr, char *buf)
>>   {
>>       struct drm_i915_private *dev_priv = kdev_minor_to_i915(kdev);
>>       unsigned int mask;
>> @@ -75,43 +75,43 @@ show_rc6_mask(struct device *kdev, struct 
>> device_attribute *attr, char *buf)
>>       return sysfs_emit(buf, "%x\n", mask);
>>   }
>> -static ssize_t
>> -show_rc6_ms(struct device *kdev, struct device_attribute *attr, char 
>> *buf)
>> +static ssize_t rc6_residency_ms_show(struct device *kdev,
>> +                     struct device_attribute *attr, char *buf)
>>   {
>>       struct drm_i915_private *dev_priv = kdev_minor_to_i915(kdev);
>>       u32 rc6_residency = calc_residency(dev_priv, GEN6_GT_GFX_RC6);
>>       return sysfs_emit(buf, "%u\n", rc6_residency);
>>   }
>> -static ssize_t
>> -show_rc6p_ms(struct device *kdev, struct device_attribute *attr, char 
>> *buf)
>> +static ssize_t rc6p_residency_ms_show(struct device *kdev,
>> +                      struct device_attribute *attr, char *buf)
>>   {
>>       struct drm_i915_private *dev_priv = kdev_minor_to_i915(kdev);
>>       u32 rc6p_residency = calc_residency(dev_priv, GEN6_GT_GFX_RC6p);
>>       return sysfs_emit(buf, "%u\n", rc6p_residency);
>>   }
>> -static ssize_t
>> -show_rc6pp_ms(struct device *kdev, struct device_attribute *attr, 
>> char *buf)
>> +static ssize_t rc6pp_residency_ms_show(struct device *kdev,
>> +                       struct device_attribute *attr, char *buf)
>>   {
>>       struct drm_i915_private *dev_priv = kdev_minor_to_i915(kdev);
>>       u32 rc6pp_residency = calc_residency(dev_priv, GEN6_GT_GFX_RC6pp);
>>       return sysfs_emit(buf, "%u\n", rc6pp_residency);
>>   }
>> -static ssize_t
>> -show_media_rc6_ms(struct device *kdev, struct device_attribute *attr, 
>> char *buf)
>> +static ssize_t media_rc6_residency_ms_show(struct device *kdev,
>> +                       struct device_attribute *attr, char *buf)
>>   {
>>       struct drm_i915_private *dev_priv = kdev_minor_to_i915(kdev);
>>       u32 rc6_residency = calc_residency(dev_priv, VLV_GT_MEDIA_RC6);
>>       return sysfs_emit(buf, "%u\n", rc6_residency);
>>   }
>> -static DEVICE_ATTR(rc6_enable, S_IRUGO, show_rc6_mask, NULL);
>> -static DEVICE_ATTR(rc6_residency_ms, S_IRUGO, show_rc6_ms, NULL);
>> -static DEVICE_ATTR(rc6p_residency_ms, S_IRUGO, show_rc6p_ms, NULL);
>> -static DEVICE_ATTR(rc6pp_residency_ms, S_IRUGO, show_rc6pp_ms, NULL);
>> -static DEVICE_ATTR(media_rc6_residency_ms, S_IRUGO, 
>> show_media_rc6_ms, NULL);
>> +static DEVICE_ATTR_RO(rc6_enable);
>> +static DEVICE_ATTR_RO(rc6_residency_ms);
>> +static DEVICE_ATTR_RO(rc6p_residency_ms);
>> +static DEVICE_ATTR_RO(rc6pp_residency_ms);
>> +static DEVICE_ATTR_RO(media_rc6_residency_ms);
>>   static struct attribute *rc6_attrs[] = {
>>       &dev_attr_rc6_enable.attr,
>>
> 
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Pushed thanks for the patch!

Regards,

Tvrtko
