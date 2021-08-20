Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E631B3F2A25
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbhHTKfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:35:06 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:60951 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237319AbhHTKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:34:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B955D32009BB;
        Fri, 20 Aug 2021 06:34:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 20 Aug 2021 06:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=kCLCjc
        MJYrg5yULyAmnl0c+pVt2A9DrBPhejQTC0pxU=; b=B6+S/tnFAiqDgW/jh7Ew9m
        fCE86qa9jI7kMRMFkncumtZiE70DykYHT31l81vNMXJTtGkyIrgecLd+82YSlQMX
        U1UCbgRJStJ8v6XFKJrgYBpCAzsgANnLjifcHK0PEF6WaCec/kAJg3J26gIMUG/L
        lf0sEBql2h3qkLLNQIa5+L8BdI1FA1lIS/9/jKoD7Ey3650cOSeOVO39gPjvakVP
        MgrN1X+ZtqIj3B+XIvnCMym7vUj/NLiJ5j+FJnMs3fGZ4KZ4CZ3E1uIICstNIO0L
        Brbh3VscYuX+skvN9BcJ0FwihCyO/WvjDeoQh+aYI/0gTjy1og8fcMXDxD9jbiaQ
        ==
X-ME-Sender: <xms:KYUfYe8Fwfe4cFYyZeauUwd_d3EfmP9IIL8mUxN-BMBv7-JBck8_AQ>
    <xme:KYUfYetczuqkw78OdJNJyUG8HVCy-XskN76ASA094xF9PEVCOxhdFIaESpupXiqyh
    bXTMn8FxGDiRm9iFec>
X-ME-Received: <xmr:KYUfYUAKXcujt1QNzPB80elc4ToraO5okOlW_ZMJKXEFewxEQ5oSy_c3YWNq0LIs40GiWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleelgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhuffvkfgjfhfogggtsehttdertd
    ertddvnecuhfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdgu
    vghvqeenucggtffrrghtthgvrhhnpefgfeefudffhffgueehgeffffeggeevieefueethf
    eijefftedugfeuveethedtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:KYUfYWdJtmXsMovER6I2SPJRNeCTP9WD66OCRhZZkrK_x28m_4ac2A>
    <xmx:KYUfYTOPx010JVjhiInOlckYP50AQjzKMr5Qp0kX7sb2UFHgm3AN9w>
    <xmx:KYUfYQlniia0iDJC3fhDQAtNOMHmiK5KaCGLGKLR1jDfXjKIYzfSZw>
    <xmx:KoUfYZ16UATm5dWAVNJQU539NeIqrTidxXmoOqPRi1KAYhH_b_kk_Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Aug 2021 06:34:13 -0400 (EDT)
Date:   Fri, 20 Aug 2021 22:33:57 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v4 1/1] asus-wmi: Add support for custom fan curves
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org
Message-Id: <L0W4YQ.ZVWQDLFJE8NR2@ljones.dev>
In-Reply-To: <321afe1a293be3a623a9be53feea3a008e044b31.camel@hadess.net>
References: <20210820095726.14131-1-luke@ljones.dev>
        <20210820095726.14131-2-luke@ljones.dev>
        <321afe1a293be3a623a9be53feea3a008e044b31.camel@hadess.net>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Aug 20 2021 at 12:18:39 +0200, Bastien Nocera 
<hadess@hadess.net> wrote:
> On Fri, 2021-08-20 at 21:57 +1200, Luke D. Jones wrote:
>>  Add support for custom fan curves found on some ASUS ROG laptops.
>> 
>>  These laptops have the ability to set a custom curve for the CPU
>>  and GPU fans via an ACPI method call. This patch enables this,
>>  additionally enabling custom fan curves per-profile, where profile
>>  here means each of the 3 levels of "throttle_thermal_policy".
> 
> I don't quite understand how this works. Are those fan controls
> supposed to add to the platform_profile implementation that just
> landed, or are the features mutually exclusive?

Ah sorry, I wasn't sure if I should have CC'd you or not.
The fan controls are mutually exclusive in terms of platform_profile, 
but the patch *does* provide ability for users to modify only the fan 
curve for each profile.

> 
> If the curves can be controlled by end-users, what will make sure that
> the fan curve that's assigned to, say, the performance 
> platform_profile
> actually corresponds to a "performance" setting?

It's fully controlled in kernel with specific pairing.

> 
> Am I going to get bug reports from Asus users that will complain that
> power-profiles-daemon doesn't work correctly, where I will have to
> wearily ask if they're using an Asus Rog laptop?

No. Definitely not. The changes to fan curves per-profile need to be 
explicitly enabled and set. So a new user will be unaware that this 
control exists (until they look for it) and their laptop will behave 
exactly as default.

> 
> I'd certainly prefer the 2 features to be separate, and the
> platform_profile to not be available if the curves are custom, seeing
> as Asus presumably would know better than end-users what curves to
> apply for a particular workload.

As it turns out there are default curves per-profile that can be 
fetched from ACPI call.

I and pretty much every user I've spoken to so far prefer to have the 
ability to set a curve per-profile and have a platform_profile change 
also set the related curve. The default factory mode fans are rather 
weak tbh - by setting the fans slightly higher in performance profile I 
got an extra 300Mhz CPU boost.

And I've gotten a lot of users who come from Windows request this. At 
least with the ability in kernel then there won't be a need to use 
"acpi_call" module.

I look at this as a power-user setting. As mentioned above, unless a 
user already knows this ability exists then they won't be aware of it 
and their laptop will work in stock standard default modes.


Regards,
Luke.
> 
>> 
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  ---
>>   drivers/platform/x86/asus-wmi.c            | 672
>>  +++++++++++++++++++++
>>   include/linux/platform_data/x86/asus-wmi.h |   2 +
>>   2 files changed, 674 insertions(+)
>> 
>>  diff --git a/drivers/platform/x86/asus-wmi.c
>>  b/drivers/platform/x86/asus-wmi.c
>>  index cc5811844012..a515207d1645 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -108,6 +108,11 @@ module_param(fnlock_default, bool, 0444);
>> 
>>   static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL
>>  };
>> 
>>  +static int throttle_thermal_policy_write(struct asus_wmi*);
>>  +static ssize_t fan_curve_store(struct asus_wmi *asus, const char
>>  *buf,
>>  +                                                               
>> size_
>>  t count, u32 dev, char **curve,
>>  +                                                               char
>>  *default_curve, u32 throttle_policy);
>>  +
>>   static bool ashs_present(void)
>>   {
>>          int i = 0;
>>  @@ -122,6 +127,7 @@ struct bios_args {
>>          u32 arg0;
>>          u32 arg1;
>>          u32 arg2; /* At least TUF Gaming series uses 3 dword input
>>  buffer. */
>>  +       u32 arg3;
>>          u32 arg4;
>>          u32 arg5;
>>   } __packed;
>>  @@ -173,6 +179,21 @@ enum fan_type {
>>          FAN_TYPE_SPEC83,        /* starting in Spec 8.3, use
>>  CPU_FAN_CTRL */
>>   };
>> 
>>  +struct fan_curve {
>>  +       char *balanced;
>>  +       char *balanced_default;
>>  +       char *performance;
>>  +       char *performance_default;
>>  +       char *quiet;
>>  +       char *quiet_default;
>>  +};
>>  +
>>  +struct active_fan_curves {
>>  +       bool balanced;
>>  +       bool performance;
>>  +       bool quiet;
>>  +};
>>  +
>>   struct asus_wmi {
>>          int dsts_id;
>>          int spec;
>>  @@ -220,6 +241,14 @@ struct asus_wmi {
>>          bool throttle_thermal_policy_available;
>>          u8 throttle_thermal_policy_mode;
>> 
>>  +       bool cpu_fan_curve_available;
>>  +       struct fan_curve cpu_fan_curve;
>>  +
>>  +    bool gpu_fan_curve_available;
>>  +       struct fan_curve gpu_fan_curve;
>>  +
>>  +       struct active_fan_curves active_fan_curve_profiles;
>>  +
>>          struct platform_profile_handler platform_profile_handler;
>>          bool platform_profile_support;
>> 
>>  @@ -285,6 +314,85 @@ int asus_wmi_evaluate_method(u32 method_id, u32
>>  arg0, u32 arg1, u32 *retval)
>>   }
>>   EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
>> 
>>  +static int asus_wmi_evaluate_method5(u32 method_id,
>>  +               u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, 
>> u32
>>  *retval)
>>  +{
>>  +       struct bios_args args = {
>>  +               .arg0 = arg0,
>>  +               .arg1 = arg1,
>>  +               .arg2 = arg2,
>>  +               .arg3 = arg3,
>>  +               .arg4 = arg4,
>>  +       };
>>  +       struct acpi_buffer input = { (acpi_size) sizeof(args), &args
>>  };
>>  +       struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>>  +       acpi_status status;
>>  +       union acpi_object *obj;
>>  +       u32 tmp = 0;
>>  +
>>  +       status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0,
>>  method_id,
>>  +                                    &input, &output);
>>  +
>>  +       if (ACPI_FAILURE(status))
>>  +               return -EIO;
>>  +
>>  +       obj = (union acpi_object *)output.pointer;
>>  +       if (obj && obj->type == ACPI_TYPE_INTEGER)
>>  +               tmp = (u32) obj->integer.value;
>>  +
>>  +       if (retval)
>>  +               *retval = tmp;
>>  +
>>  +       kfree(obj);
>>  +
>>  +       if (tmp == ASUS_WMI_UNSUPPORTED_METHOD)
>>  +               return -ENODEV;
>>  +
>>  +       return 0;
>>  +}
>>  +
>>  +/*
>>  + * Returns as an error if the method output is not a buffer.
>>  Typically this
>>  + * means that the method called is unsupported.
>>  +*/
>>  +static int asus_wmi_evaluate_method_buf(u32 method_id,
>>  +               u32 arg0, u32 arg1, u8 *ret_buffer)
>>  +{
>>  +       struct bios_args args = {
>>  +               .arg0 = arg0,
>>  +               .arg1 = arg1,
>>  +               .arg2 = 0,
>>  +       };
>>  +       struct acpi_buffer input = { (acpi_size) sizeof(args), &args
>>  };
>>  +       struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>>  +       acpi_status status;
>>  +       union acpi_object *obj;
>>  +       u32 int_tmp = 0;
>>  +
>>  +       status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0,
>>  method_id,
>>  +                                    &input, &output);
>>  +
>>  +       if (ACPI_FAILURE(status))
>>  +               return -EIO;
>>  +
>>  +       obj = (union acpi_object *)output.pointer;
>>  +
>>  +       if (obj && obj->type == ACPI_TYPE_INTEGER) {
>>  +               int_tmp = (u32) obj->integer.value;
>>  +               if (int_tmp == ASUS_WMI_UNSUPPORTED_METHOD)
>>  +                       return -ENODEV;
>>  +               return int_tmp;
>>  +       }
>>  +
>>  +       if (obj && obj->type == ACPI_TYPE_BUFFER && obj-
>>  >buffer.length >= 16) {
>>  +               memcpy(ret_buffer, obj->buffer.pointer, obj-
>>  >buffer.length);
>>  +       }
>>  +
>>  +       kfree(obj);
>>  +
>>  +       return 0;
>>  +}
>>  +
>>   static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer
>>  args)
>>   {
>>          struct acpi_buffer input;
>>  @@ -2043,6 +2151,461 @@ static ssize_t fan_boost_mode_store(struct
>>  device *dev,
>>   // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
>>   static DEVICE_ATTR_RW(fan_boost_mode);
>> 
>>  +/* Custom fan curves per-profile
>>  **********************************************/
>>  +
>>  +static int custom_fan_check_present(struct asus_wmi *asus,
>>  +
>>     bool *available, u32 dev)
>>  +{
>>  +       struct fan_curve *curves = &asus->cpu_fan_curve;
>>  +       u8 *b = kzalloc(16 * sizeof(u8), GFP_KERNEL);
>>  +       /* 15 punctuation marks + 16 sets of numbers up to 3 char
>>  each */
>>  +       int str_len = 15 + 16 * 3;
>>  +       int err;
>>  +
>>  +       *available = false;
>>  +
>>  +       if (dev == ASUS_WMI_DEVID_GPU_FAN_CURVE)
>>  +               curves = &asus->gpu_fan_curve;
>>  +
>>  +       /* Balanced default */
>>  +       err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 0, 
>> b);
>>  +       if (err) {
>>  +               if (err == -ENODEV)
>>  +                       return 0;
>>  +               return err;
>>  +       }
>>  +
>>  +       curves->balanced = kzalloc(str_len * sizeof(char),
>>  GFP_KERNEL);
>>  +       if (!curves->balanced)
>>  +               return -ENOMEM;
>>  +
>>  +       curves->balanced_default = kzalloc(str_len * sizeof(char),
>>  GFP_KERNEL);
>>  +       if (!curves->balanced_default)
>>  +               return -ENOMEM;
>>  +
>>  +       sprintf(curves->balanced,
>>  "%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
>>  +               b[0], b[8], b[1], b[9], b[2], b[10], b[3], b[11],
>>  +               b[4], b[12], b[5], b[13], b[6], b[14], b[7], b[15]);
>>  +       sprintf(curves->balanced_default, curves->balanced);
>>  +
>>  +       /* Quiet default */
>>  +       err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 1, 
>> b);
>>  +       if (err) {
>>  +               if (err == -ENODEV)
>>  +                       return 0;
>>  +               return err;
>>  +       }
>>  +
>>  +       curves->quiet = kzalloc(str_len * sizeof(char), GFP_KERNEL);
>>  +       if (!curves->quiet)
>>  +               return -ENOMEM;
>>  +
>>  +       curves->quiet_default = kzalloc(str_len * sizeof(char),
>>  GFP_KERNEL);
>>  +       if (!curves->quiet_default)
>>  +               return -ENOMEM;
>>  +
>>  +       sprintf(curves->quiet,
>>  "%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
>>  +               b[0], b[8], b[1], b[9], b[2], b[10], b[3], b[11],
>>  +               b[4], b[12], b[5], b[13], b[6], b[14], b[7], b[15]);
>>  +       sprintf(curves->quiet_default, curves->quiet);
>>  +
>>  +       /* Performance default */
>>  +       err = asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 2, 
>> b);
>>  +       if (err) {
>>  +               if (err == -ENODEV)
>>  +                       return 0;
>>  +               return err;
>>  +       }
>>  +
>>  +       curves->performance = kzalloc(str_len * sizeof(char),
>>  GFP_KERNEL);
>>  +       if (!curves->performance)
>>  +               return -ENOMEM;
>>  +
>>  +       curves->performance_default = kzalloc(str_len * 
>> sizeof(char),
>>  GFP_KERNEL);
>>  +       if (!curves->performance_default)
>>  +               return -ENOMEM;
>>  +
>>  +       sprintf(curves->performance,
>>  +               "%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
>>  +               b[0], b[8], b[1], b[9], b[2], b[10], b[3], b[11],
>>  +               b[4], b[12], b[5], b[13], b[6], b[14], b[7], b[15]);
>>  +       sprintf(curves->performance_default, curves->performance);
>>  +
>>  +       kfree(b);
>>  +
>>  +       *available = true;
>>  +       return 0;
>>  +}
>>  +
>>  +/*
>>  + * The expected input is of the format
>>  + *     "30:1,49:2,59:3,69:4,79:31,89:49,99:56,109:58"
>>  + * where a pair is 30:1, with 30 = temperature, and 1 = percentage
>>  +*/
>>  +static int fan_curve_check_valid(const char *curve)
>>  +{
>>  +    char * buf, *set, *set_end, *pair_tmp, *pair, *pair_end;
>>  +       int err, ret;
>>  +
>>  +       char *set_delimiter = ",";
>>  +       char *pair_delimiter = ":";
>>  +    bool pair_start = true;
>>  +       u32 prev_percent = 0;
>>  +       u32 prev_temp = 0;
>>  +    u32 percent = 0;
>>  +       u32 temp = 0;
>>  +
>>  +    buf = set_end = pair_end = kstrdup(curve, GFP_KERNEL);
>>  +
>>  +       while( (set = strsep(&set_end, set_delimiter)) != NULL ) {
>>  +               pair_tmp = kstrdup(set, GFP_KERNEL);
>>  +        pair_start = true;
>>  +               while( (pair = strsep(&pair_tmp, pair_delimiter)) !=
>>  NULL ) {
>>  +                       err = kstrtouint(pair, 10, &ret);
>>  +                       if (err) {
>>  +                               kfree(pair_tmp);
>>  +                               kfree(buf);
>>  +                               return err;
>>  +                       }
>>  +
>>  +            if (pair_start) {
>>  +                temp = ret;
>>  +                pair_start = false;
>>  +            } else {
>>  +                percent = ret;
>>  +            }
>>  +               }
>>  +               kfree(pair_tmp);
>>  +
>>  +        if (temp < prev_temp || percent < prev_percent || percent >
>>  100) {
>>  +            pr_info("Fan curve invalid");
>>  +                       pr_info("A value is sequentially lower or
>>  percentage is > 100");
>>  +            kfree(buf);
>>  +            return -EINVAL;
>>  +        }
>>  +
>>  +        prev_temp = temp;
>>  +        prev_percent = percent;
>>  +       }
>>  +       kfree(buf);
>>  +
>>  +    return 0;
>>  +}
>>  +
>>  +static int fan_curve_write(struct asus_wmi *asus, u32 dev, char
>>  *curve)
>>  +{
>>  +    char * buf, *set, *pair_tmp, *pair, *set_end, *pair_end;
>>  +    int err, ret;
>>  +
>>  +       char *set_delimiter = ",";
>>  +       char *pair_delimiter = ":";
>>  +       bool half_complete = false;
>>  +       bool pair_start = true;
>>  +       u32 percent = 0;
>>  +       u32 shift = 0;
>>  +       u32 temp = 0;
>>  +    u32 arg1 = 0;
>>  +    u32 arg2 = 0;
>>  +    u32 arg3 = 0;
>>  +    u32 arg4 = 0;
>>  +
>>  +    buf = set_end = pair_end = kstrdup(curve, GFP_KERNEL);
>>  +
>>  +       while( (set = strsep(&set_end, set_delimiter)) != NULL ) {
>>  +               pair_tmp = kstrdup(set, GFP_KERNEL);
>>  +        pair_start = true;
>>  +               while( (pair = strsep(&pair_tmp, pair_delimiter)) !=
>>  NULL ) {
>>  +                       err = kstrtouint(pair, 10, &ret);
>>  +            if (err) {
>>  +                kfree(pair_tmp);
>>  +                kfree(buf);
>>  +                return err;
>>  +            }
>>  +
>>  +            if (pair_start) {
>>  +                temp = ret;
>>  +                pair_start = false;
>>  +            } else {
>>  +                percent = ret;
>>  +            }
>>  +               }
>>  +               kfree(pair_tmp);
>>  +
>>  +        if (!half_complete) {
>>  +            arg1 += temp << shift;
>>  +            arg3 += percent << shift;
>>  +        } else {
>>  +            arg2 += temp << shift;
>>  +            arg4 += percent << shift;
>>  +        }
>>  +        shift += 8;
>>  +
>>  +        if (shift == 32) {
>>  +            shift = 0;
>>  +            half_complete = true;
>>  +        }
>>  +       }
>>  +       kfree(buf);
>>  +
>>  +    return asus_wmi_evaluate_method5(ASUS_WMI_METHODID_DEVS, dev,
>>  +
>>      arg1, arg2, arg3, arg4, &ret);
>>  +}
>>  +
>>  +static ssize_t fan_curve_store(struct asus_wmi *asus, const char
>>  *buf,
>>  +                                                               
>> size_
>>  t count, u32 dev, char **curve,
>>  +                                                               char
>>  *default_curve, u32 throttle_policy)
>>  +{
>>  +    int err;
>>  +
>>  +       /* Allow a user to write "" or " " to erase a curve setting
>>  */
>>  +       if (strlen(buf) <= 1 || strcmp(buf, " \n") == 0) {
>>  +               kfree(*curve);
>>  +               *curve = kstrdup(default_curve, GFP_KERNEL);
>>  +               err = throttle_thermal_policy_write(asus);
>>  +               if (err)
>>  +                       return err;
>>  +               return count;
>>  +       }
>>  +
>>  +       err = fan_curve_check_valid(buf);
>>  +       if (err)
>>  +               return err;
>>  +
>>  +       if (*curve)
>>  +               kfree(*curve);
>>  +
>>  +       /* Always save fan curve if it is valid */
>>  +    *curve = kstrdup(buf, GFP_KERNEL);
>>  +
>>  +       /* Maybe activate fan curve if in associated mode */
>>  +    if (asus->throttle_thermal_policy_mode == throttle_policy) {
>>  +        err = fan_curve_write(asus, dev, *curve);
>>  +        if (err)
>>  +            return err;
>>  +    }
>>  +
>>  +    return count;
>>  +}
>>  +
>>  +/*
>>  + * CPU Fan Curves
>>  +*/
>>  +
>>  +static ssize_t cpu_fan_curve_balanced_show(struct device *dev,
>>  +                                  struct device_attribute *attr,
>>  char *buf)
>>  +{
>>  +       struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +       return scnprintf(buf, PAGE_SIZE, "%s\n", asus-
>>  >cpu_fan_curve.balanced);
>>  +}
>>  +
>>  +static ssize_t cpu_fan_curve_balanced_store(struct device *dev,
>>  +                                   struct device_attribute *attr,
>>  +                                   const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +    return fan_curve_store(asus, buf, count,
>>  ASUS_WMI_DEVID_CPU_FAN_CURVE,
>>  +                                                       &asus-
>>  >cpu_fan_curve.balanced,
>>  +                                                       asus-
>>  >cpu_fan_curve.balanced_default,
>>  +                            ASUS_THROTTLE_THERMAL_POLICY_DEFAULT);
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(cpu_fan_curve_balanced);
>>  +
>>  +static ssize_t cpu_fan_curve_performance_show(struct device *dev,
>>  +                                  struct device_attribute *attr,
>>  char *buf)
>>  +{
>>  +       struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +       return scnprintf(buf, PAGE_SIZE, "%s\n", asus-
>>  >cpu_fan_curve.performance);
>>  +}
>>  +
>>  +static ssize_t cpu_fan_curve_performance_store(struct device *dev,
>>  +                                   struct device_attribute *attr,
>>  +                                   const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +    return fan_curve_store(asus, buf, count,
>>  ASUS_WMI_DEVID_CPU_FAN_CURVE,
>>  +                                                       &asus-
>>  >cpu_fan_curve.performance,
>>  +                                                       asus-
>>  >cpu_fan_curve.performance_default,
>>  +                            
>> ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST);
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(cpu_fan_curve_performance);
>>  +
>>  +static ssize_t cpu_fan_curve_quiet_show(struct device *dev,
>>  +                                  struct device_attribute *attr,
>>  char *buf)
>>  +{
>>  +       struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +       return scnprintf(buf, PAGE_SIZE, "%s\n", asus-
>>  >cpu_fan_curve.quiet);
>>  +}
>>  +
>>  +static ssize_t cpu_fan_curve_quiet_store(struct device *dev,
>>  +                                   struct device_attribute *attr,
>>  +                                   const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +    return fan_curve_store(asus, buf, count,
>>  ASUS_WMI_DEVID_CPU_FAN_CURVE,
>>  +                                                       &asus-
>>  >cpu_fan_curve.quiet,
>>  +                                                       asus-
>>  >cpu_fan_curve.quiet_default,
>>  +                            ASUS_THROTTLE_THERMAL_POLICY_SILENT);
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(cpu_fan_curve_quiet);
>>  +
>>  +/*
>>  + * GPU Fan Curves
>>  +*/
>>  +
>>  +static ssize_t gpu_fan_curve_balanced_show(struct device *dev,
>>  +                                  struct device_attribute *attr,
>>  char *buf)
>>  +{
>>  +       struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +       return scnprintf(buf, PAGE_SIZE, "%s\n", asus-
>>  >gpu_fan_curve.balanced);
>>  +}
>>  +
>>  +static ssize_t gpu_fan_curve_balanced_store(struct device *dev,
>>  +                                   struct device_attribute *attr,
>>  +                                   const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +    return fan_curve_store(asus, buf, count,
>>  ASUS_WMI_DEVID_GPU_FAN_CURVE,
>>  +                                                       &asus-
>>  >gpu_fan_curve.balanced,
>>  +                                                       asus-
>>  >gpu_fan_curve.balanced_default,
>>  +                            ASUS_THROTTLE_THERMAL_POLICY_DEFAULT);
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(gpu_fan_curve_balanced);
>>  +
>>  +static ssize_t gpu_fan_curve_performance_show(struct device *dev,
>>  +                                  struct device_attribute *attr,
>>  char *buf)
>>  +{
>>  +       struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +       return scnprintf(buf, PAGE_SIZE, "%s\n", asus-
>>  >gpu_fan_curve.performance);
>>  +}
>>  +
>>  +static ssize_t gpu_fan_curve_performance_store(struct device *dev,
>>  +                                   struct device_attribute *attr,
>>  +                                   const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +    return fan_curve_store(asus, buf, count,
>>  ASUS_WMI_DEVID_GPU_FAN_CURVE,
>>  +                                                       &asus-
>>  >gpu_fan_curve.performance,
>>  +                                                       asus-
>>  >gpu_fan_curve.performance_default,
>>  +                            
>> ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST);
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(gpu_fan_curve_performance);
>>  +
>>  +static ssize_t gpu_fan_curve_quiet_show(struct device *dev,
>>  +                                  struct device_attribute *attr,
>>  char *buf)
>>  +{
>>  +       struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +       return scnprintf(buf, PAGE_SIZE, "%s\n", asus-
>>  >gpu_fan_curve.quiet);
>>  +}
>>  +
>>  +static ssize_t gpu_fan_curve_quiet_store(struct device *dev,
>>  +                                   struct device_attribute *attr,
>>  +                                   const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +    return fan_curve_store(asus, buf, count,
>>  ASUS_WMI_DEVID_GPU_FAN_CURVE,
>>  +                                                       &asus-
>>  >gpu_fan_curve.quiet,
>>  +                                                       asus-
>>  >gpu_fan_curve.quiet_default,
>>  +                            ASUS_THROTTLE_THERMAL_POLICY_SILENT);
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(gpu_fan_curve_quiet);
>>  +
>>  +/*
>>  + * Active curves per profile
>>  +*/
>>  +
>>  +static int active_fan_curve_profiles_check_present(struct asus_wmi
>>  *asus)
>>  +{
>>  +       if (!asus->cpu_fan_curve_available || !asus-
>>  >gpu_fan_curve_available)
>>  +               return -ENODEV;
>>  +
>>  +       return 0;
>>  +}
>>  +
>>  +
>>  +static int active_fan_curve_profiles_write(struct asus_wmi *asus,
>>  const char *names)
>>  +{
>>  +    char *buf, *set, *set_end;
>>  +    int err;
>>  +
>>  +    buf = set_end = kstrdup(names, GFP_KERNEL);
>>  +
>>  +       /* Reset before checking */
>>  +       asus->active_fan_curve_profiles.balanced = false;
>>  +       asus->active_fan_curve_profiles.quiet = false;
>>  +       asus->active_fan_curve_profiles.performance = false;
>>  +
>>  +       while( (set = strsep(&set_end, " ")) != NULL ) {
>>  +               if (set == NULL)
>>  +                       set = buf;
>>  +
>>  +               pr_info("SET: %s", set);
>>  +               pr_info("SET: %d", strcmp(set, "quiet"));
>>  +               pr_info("SET: %d", strcmp(set, "quiet\n"));
>>  +
>>  +               if (strcmp(set, "balanced") == 0
>>  +                               || strcmp(set, "balanced\n") == 0)
>>  +                       asus->active_fan_curve_profiles.balanced =
>>  true;
>>  +
>>  +               if (strcmp(set, "quiet") == 0
>>  +                               || strcmp(set, "quiet\n") == 0)
>>  +                       asus->active_fan_curve_profiles.quiet = 
>> true;
>>  +
>>  +               if (strcmp(set, "performance") == 0
>>  +                               || strcmp(set, "performance\n") == 
>> 0)
>>  +                       asus->active_fan_curve_profiles.performance 
>> =
>>  true;
>>  +       }
>>  +
>>  +       err = throttle_thermal_policy_write(asus);
>>  +       if (err)
>>  +               return err;
>>  +
>>  +       kfree(buf);
>>  +
>>  +       return 0;
>>  +}
>>  +
>>  +static ssize_t active_fan_curve_profiles_show(struct device *dev,
>>  +                                  struct device_attribute *attr,
>>  char *buf)
>>  +{
>>  +       struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +       int len = 0;
>>  +
>>  +       if (asus->active_fan_curve_profiles.balanced)
>>  +               len += sysfs_emit_at(buf, len, "balanced ");
>>  +
>>  +       if (asus->active_fan_curve_profiles.performance)
>>  +               len += sysfs_emit_at(buf, len, "performance ");
>>  +
>>  +       if (asus->active_fan_curve_profiles.quiet)
>>  +               len += sysfs_emit_at(buf, len, "quiet ");
>>  +
>>  +       len += sysfs_emit_at(buf, len, "\n");
>>  +
>>  +       return len;
>>  +}
>>  +
>>  +static ssize_t active_fan_curve_profiles_store(struct device *dev,
>>  +                                   struct device_attribute *attr,
>>  +                                   const char *buf, size_t count)
>>  +{
>>  +    struct asus_wmi *asus = dev_get_drvdata(dev);
>>  +       int err;
>>  +
>>  +       err = active_fan_curve_profiles_write(asus, buf);
>>  +       if (err)
>>  +               return err;
>>  +
>>  +    return count;
>>  +}
>>  +
>>  +static DEVICE_ATTR_RW(active_fan_curve_profiles);
>>  +
>>   /* Throttle thermal policy
>>  ****************************************************/
>> 
>>   static int throttle_thermal_policy_check_present(struct asus_wmi
>>  *asus)
>>  @@ -2067,6 +2630,59 @@ static int
>>  throttle_thermal_policy_check_present(struct asus_wmi *asus)
>>          return 0;
>>   }
>> 
>>  +static int throttle_thermal_policy_write_cpu_curves(struct asus_wmi
>>  *asus)
>>  +{
>>  +       char *curve = NULL;
>>  +       int err, mode;
>>  +
>>  +       mode = asus->throttle_thermal_policy_mode;
>>  +
>>  +       if (mode == ASUS_THROTTLE_THERMAL_POLICY_DEFAULT
>>  +                                       && asus-
>>  >active_fan_curve_profiles.balanced) {
>>  +               curve = asus->cpu_fan_curve.balanced;
>>  +       } else if (mode == ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST
>>  +                                       && asus-
>>  >active_fan_curve_profiles.performance) {
>>  +               curve = asus->cpu_fan_curve.performance;
>>  +       } else if (mode == ASUS_THROTTLE_THERMAL_POLICY_SILENT
>>  +                                       && asus-
>>  >active_fan_curve_profiles.quiet) {
>>  +               curve = asus->cpu_fan_curve.quiet;
>>  +       }
>>  +
>>  +       if (curve != NULL) {
>>  +               err = fan_curve_write(asus,
>>  ASUS_WMI_DEVID_CPU_FAN_CURVE, curve);
>>  +               if (err)
>>  +                       return err;
>>  +       }
>>  +       return 0;
>>  +}
>>  +
>>  +
>>  +static int throttle_thermal_policy_write_gpu_curves(struct asus_wmi
>>  *asus)
>>  +{
>>  +       char *curve = NULL;
>>  +       int err, mode;
>>  +
>>  +       mode = asus->throttle_thermal_policy_mode;
>>  +
>>  +       if (mode == ASUS_THROTTLE_THERMAL_POLICY_DEFAULT
>>  +                                       && asus-
>>  >active_fan_curve_profiles.balanced) {
>>  +               curve = asus->gpu_fan_curve.balanced;
>>  +       } else if (mode == ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST
>>  +                                       && asus-
>>  >active_fan_curve_profiles.performance) {
>>  +               curve = asus->gpu_fan_curve.performance;
>>  +       } else if (mode == ASUS_THROTTLE_THERMAL_POLICY_SILENT
>>  +                                       && asus-
>>  >active_fan_curve_profiles.quiet) {
>>  +               curve = asus->gpu_fan_curve.quiet;
>>  +       }
>>  +
>>  +       if (curve != NULL) {
>>  +               err = fan_curve_write(asus,
>>  ASUS_WMI_DEVID_GPU_FAN_CURVE, curve);
>>  +               if (err)
>>  +                       return err;
>>  +       }
>>  +       return 0;
>>  +}
>>  +
>>   static int throttle_thermal_policy_write(struct asus_wmi *asus)
>>   {
>>          int err;
>>  @@ -2092,6 +2708,26 @@ static int
>>  throttle_thermal_policy_write(struct asus_wmi *asus)
>>                  return -EIO;
>>          }
>> 
>>  +       if (asus->cpu_fan_curve_available) {
>>  +               err = 
>> throttle_thermal_policy_write_cpu_curves(asus);
>>  +               if (err) {
>>  +                       dev_warn(&asus->platform_device->dev,
>>  +                               "Failed to set custom CPU curve for
>>  thermal policy: %d\n",
>>  +                               err);
>>  +                       return err;
>>  +               }
>>  +       }
>>  +
>>  +       if (asus->gpu_fan_curve_available) {
>>  +               err = 
>> throttle_thermal_policy_write_gpu_curves(asus);
>>  +               if (err) {
>>  +                       dev_warn(&asus->platform_device->dev,
>>  +                               "Failed to set custom GPU curve for
>>  thermal policy: %d\n",
>>  +                               err);
>>  +                       return err;
>>  +               }
>>  +       }
>>  +
>>          return 0;
>>   }
>> 
>>  @@ -2711,6 +3347,13 @@ static struct attribute 
>> *platform_attributes[]
>>  = {
>>          &dev_attr_als_enable.attr,
>>          &dev_attr_fan_boost_mode.attr,
>>          &dev_attr_throttle_thermal_policy.attr,
>>  +       &dev_attr_cpu_fan_curve_balanced.attr,
>>  +       &dev_attr_cpu_fan_curve_performance.attr,
>>  +       &dev_attr_cpu_fan_curve_quiet.attr,
>>  +    &dev_attr_gpu_fan_curve_balanced.attr,
>>  +       &dev_attr_gpu_fan_curve_performance.attr,
>>  +       &dev_attr_gpu_fan_curve_quiet.attr,
>>  +       &dev_attr_active_fan_curve_profiles.attr,
>>          &dev_attr_panel_od.attr,
>>          NULL
>>   };
>>  @@ -2741,6 +3384,20 @@ static umode_t asus_sysfs_is_visible(struct
>>  kobject *kobj,
>>                  ok = asus->fan_boost_mode_available;
>>          else if (attr == &dev_attr_throttle_thermal_policy.attr)
>>                  ok = asus->throttle_thermal_policy_available;
>>  +       else if (attr == &dev_attr_cpu_fan_curve_balanced.attr)
>>  +               ok = asus->cpu_fan_curve_available;
>>  +       else if (attr == &dev_attr_cpu_fan_curve_performance.attr)
>>  +               ok = asus->cpu_fan_curve_available;
>>  +       else if (attr == &dev_attr_cpu_fan_curve_quiet.attr)
>>  +               ok = asus->cpu_fan_curve_available;
>>  +    else if (attr == &dev_attr_gpu_fan_curve_balanced.attr)
>>  +               ok = asus->gpu_fan_curve_available;
>>  +       else if (attr == &dev_attr_gpu_fan_curve_performance.attr)
>>  +               ok = asus->gpu_fan_curve_available;
>>  +       else if (attr == &dev_attr_gpu_fan_curve_quiet.attr)
>>  +               ok = asus->gpu_fan_curve_available;
>>  +       else if (attr == &dev_attr_active_fan_curve_profiles.attr)
>>  +               ok = asus->cpu_fan_curve_available || asus-
>>  >gpu_fan_curve_available;
>>          else if (attr == &dev_attr_panel_od.attr)
>>                  ok = asus->panel_overdrive_available;
>> 
>>  @@ -3016,6 +3673,20 @@ static int asus_wmi_add(struct 
>> platform_device
>>  *pdev)
>>          else
>>                  throttle_thermal_policy_set_default(asus);
>> 
>>  +       err = custom_fan_check_present(asus, &asus-
>>  >cpu_fan_curve_available,
>>  +                       ASUS_WMI_DEVID_CPU_FAN_CURVE);
>>  +       if (err)
>>  +               goto fail_throttle_fan_curve;
>>  +
>>  +    err = custom_fan_check_present(asus, &asus-
>>  >gpu_fan_curve_available,
>>  +                       ASUS_WMI_DEVID_GPU_FAN_CURVE);
>>  +       if (err)
>>  +               goto fail_throttle_fan_curve;
>>  +
>>  +       err = active_fan_curve_profiles_check_present(asus);
>>  +       if (err)
>>  +               goto fail_throttle_fan_curve;
>>  +
>>          err = platform_profile_setup(asus);
>>          if (err)
>>                  goto fail_platform_profile_setup;
>>  @@ -3109,6 +3780,7 @@ static int asus_wmi_add(struct platform_device
>>  *pdev)
>>          asus_wmi_sysfs_exit(asus->platform_device);
>>   fail_sysfs:
>>   fail_throttle_thermal_policy:
>>  +fail_throttle_fan_curve:
>>   fail_platform_profile_setup:
>>          if (asus->platform_profile_support)
>>                  platform_profile_remove();
>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h
>>  b/include/linux/platform_data/x86/asus-wmi.h
>>  index 17dc5cb6f3f2..a571b47ff362 100644
>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>  @@ -77,6 +77,8 @@
>>   #define ASUS_WMI_DEVID_THERMAL_CTRL    0x00110011
>>   #define ASUS_WMI_DEVID_FAN_CTRL                0x00110012 /*
>>  deprecated */
>>   #define ASUS_WMI_DEVID_CPU_FAN_CTRL    0x00110013
>>  +#define ASUS_WMI_DEVID_CPU_FAN_CURVE   0x00110024
>>  +#define ASUS_WMI_DEVID_GPU_FAN_CURVE   0x00110025
>> 
>>   /* Power */
>>   #define ASUS_WMI_DEVID_PROCESSOR_STATE 0x00120012
> 
> 


