Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9B3367FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 13:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhDVLhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 07:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230510AbhDVLhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619091399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JRidx53tdisViy/tIzax2btwdqucS9yJICX+S+Kekuo=;
        b=JYBchHRuJWYCa9FIcLDcdDqs8Ey2+YriZW1CgvZ3AV7aVZbJR698fGcoZjhxmPIp9xYsl3
        lfAECaYl7n72aw5CwoW5hi9FIZl37TPh716CepVXH5Np8BNv/rQA0jxtEHVEIIsNVRyhvJ
        JHVobf+agELr+iMQjgcQPgqiJVQ67f0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-MrJdXhLXPqiKwC6Hq-G4PA-1; Thu, 22 Apr 2021 07:36:19 -0400
X-MC-Unique: MrJdXhLXPqiKwC6Hq-G4PA-1
Received: by mail-ej1-f71.google.com with SMTP id r17-20020a1709069591b029037cf6a4a56dso7132581ejx.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 04:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JRidx53tdisViy/tIzax2btwdqucS9yJICX+S+Kekuo=;
        b=im7WQ1mHXhVy8hO4V1Qak5/XXdyCjAIvEQVYQm0p5pvucNbhqxJH4A87YXwl0PQBeu
         qlFUyWpRQPdLfoaLa5fV5PPuB/cKS5FI/8strYiAZRLPw+cLL2Fb++LXuTRvsI1d+2u/
         Y3V66lZIffcOIJY3jUpZKqWIbKi6EyZG8GqQnqzmGQPYhgjdRsX6x4VQ08qOXFusyUrl
         BFhQ0MJ3iEKuzgOv26E34/AbrDDiEczIOu0xaF0lZ6SG0+N5Z362jtCotZrSat53tDBB
         9MPjiFM5kZNf3tyeO6vVeSXmIjEqZ4oGXac68dW0Q6C8iEL66KVAGn66IEPg/N/Pml5g
         J3Vw==
X-Gm-Message-State: AOAM533jTMIb9SmRChKgWEl8mDjeFtQ3VODnL/FTRj8w37/car9Ad6DE
        NqlJAp1Fxe0Apsq9T2v3RQjNLbV0tXr63hGySElNZSWdoSGEFuhwbmOTnfhDm8k3NG+g5wbCsUl
        cNOcj5hQVqXR+g0wxhFL88PQ2
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr3304691eds.291.1619091378279;
        Thu, 22 Apr 2021 04:36:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx74bGYYrAvJKTAqF4xc6gs2RpEKiFqWqz3esKiHfaer+HGj2F8awoPcF98yilfHGcj3k7mDQ==
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr3304661eds.291.1619091378002;
        Thu, 22 Apr 2021 04:36:18 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d15sm1694198ejj.42.2021.04.22.04.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 04:36:17 -0700 (PDT)
Subject: Re: [PATCH] Making populate_foo_data functions more robust
To:     Prasanth KSR <kosigiprasanth@gmail.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Prasanth KSR <prasanth.ksr@dell.com>,
        Divya Bharathi <divya.bharathi@dell.com>
References: <20210422111645.24726-1-prasanth.ksr@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3c86a4d5-5ef4-5145-eb74-6cbacc859892@redhat.com>
Date:   Thu, 22 Apr 2021 13:36:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210422111645.24726-1-prasanth.ksr@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you.

Patch subject should be prefixed with: "platform/x86: dell-wmi-sysman: ",
IOW it should be:

"platform/x86: dell-wmi-sysman: Make populate_foo_data functions more robust"


On 4/22/21 1:16 PM, Prasanth KSR wrote:
> From: "Prasanth KSR" <prasanth.ksr@dell.com>
> 
>  1. Check acpi type before assignment of each property value
>  2. Add boundary check for properties count
> 
> Co-developed-by: Divya Bharathi <divya.bharathi@dell.com>
> Signed-off-by: Divya Bharathi <divya.bharathi@dell.com>
> Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>
> ---
>  .../dell/dell-wmi-sysman/dell-wmi-sysman.h    |  9 ++++-
>  .../dell/dell-wmi-sysman/enum-attributes.c    | 26 ++++++++++---
>  .../x86/dell/dell-wmi-sysman/int-attributes.c |  8 ++++
>  .../dell/dell-wmi-sysman/passobj-attributes.c |  3 ++
>  .../dell/dell-wmi-sysman/string-attributes.c  |  9 ++++-
>  .../x86/dell/dell-wmi-sysman/sysman.c         | 39 +++++++++++++++++--
>  6 files changed, 83 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
> index b80f2a62ea3f..5fd5fcd1976a 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
> @@ -152,12 +152,19 @@ static ssize_t curr_val##_store(struct kobject *kobj,				\
>  	return ret ? ret : count;						\
>  }
>  
> +#define check_property_type(attr, prop, valuetype)				\
> +do {										\
> +	if (attr##_obj[prop].type != valuetype) {				\
> +		return -EINVAL;							\
> +	}									\
> +} while (0)
> +

This is hiding a return inside a function-call which is actually a macro.

So now someone reading the code will not know that this hides a possible
return which may be an issue with releasing resources (e.g. a mutex) inside
the hidden return path.

Please drop this macro and just write out the check + return in the places where
you need it.

>  union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid_string);
>  int get_instance_count(const char *guid_string);
>  void strlcpy_attr(char *dest, char *src);
>  
>  int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
> -			struct kobject *attr_name_kobj);
> +			struct kobject *attr_name_kobj, __u32 enum_property_count);

__u32 is reserved for userspace headers please just use plain u32.

>  int alloc_enum_data(void);
>  void exit_enum_attributes(void);
>  
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
> index 091e48c217ed..a5b0e2689e5f 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
> @@ -134,37 +134,53 @@ int alloc_enum_data(void)
>   * @attr_name_kobj: The parent kernel object
>   */
>  int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
> -			struct kobject *attr_name_kobj)
> +			struct kobject *attr_name_kobj, __u32 enum_property_count)
>  {
>  	int i, next_obj, value_modifier_count, possible_values_count;
>  
>  	wmi_priv.enumeration_data[instance_id].attr_name_kobj = attr_name_kobj;
> +	check_property_type(enumeration, ATTR_NAME, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.enumeration_data[instance_id].attribute_name,
>  		enumeration_obj[ATTR_NAME].string.pointer);
> +	check_property_type(enumeration, DISPL_NAME_LANG_CODE, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.enumeration_data[instance_id].display_name_language_code,
>  		enumeration_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	check_property_type(enumeration, DISPLAY_NAME, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.enumeration_data[instance_id].display_name,
>  		enumeration_obj[DISPLAY_NAME].string.pointer);
> +	check_property_type(enumeration, DEFAULT_VAL, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.enumeration_data[instance_id].default_value,
>  		enumeration_obj[DEFAULT_VAL].string.pointer);
> +	check_property_type(enumeration, MODIFIER, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.enumeration_data[instance_id].dell_modifier,
>  		enumeration_obj[MODIFIER].string.pointer);
>  
>  	next_obj = MODIFIER + 1;
>  
> -	value_modifier_count = (uintptr_t)enumeration_obj[next_obj].string.pointer;
> +	if (next_obj >= enum_property_count)
> +		return -EINVAL;
> +
> +	check_property_type(enumeration, next_obj, ACPI_TYPE_INTEGER);
> +	value_modifier_count = (uintptr_t)enumeration_obj[next_obj++].string.pointer;
>  
>  	for (i = 0; i < value_modifier_count; i++) {
> +		if (next_obj >= enum_property_count)
> +			return -EINVAL;
> +		check_property_type(enumeration, next_obj, ACPI_TYPE_STRING);
>  		strcat(wmi_priv.enumeration_data[instance_id].dell_value_modifier,
> -			enumeration_obj[++next_obj].string.pointer);
> +			enumeration_obj[next_obj++].string.pointer);
>  		strcat(wmi_priv.enumeration_data[instance_id].dell_value_modifier, ";");
>  	}
>  
> -	possible_values_count = (uintptr_t) enumeration_obj[++next_obj].string.pointer;
> +	check_property_type(enumeration, next_obj, ACPI_TYPE_INTEGER);
> +	possible_values_count = (uintptr_t) enumeration_obj[next_obj++].string.pointer;
>  
>  	for (i = 0; i < possible_values_count; i++) {
> +		if (next_obj >= enum_property_count)
> +			return -EINVAL;
> +		check_property_type(enumeration, next_obj, ACPI_TYPE_STRING);
>  		strcat(wmi_priv.enumeration_data[instance_id].possible_values,
> -			enumeration_obj[++next_obj].string.pointer);
> +			enumeration_obj[next_obj++].string.pointer);
>  		strcat(wmi_priv.enumeration_data[instance_id].possible_values, ";");
>  	}
>  
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
> index 8a49ba6e44f9..12d6b99da43d 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
> @@ -141,20 +141,28 @@ int populate_int_data(union acpi_object *integer_obj, int instance_id,
>  			struct kobject *attr_name_kobj)
>  {
>  	wmi_priv.integer_data[instance_id].attr_name_kobj = attr_name_kobj;
> +	check_property_type(integer, ATTR_NAME, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.integer_data[instance_id].attribute_name,
>  		integer_obj[ATTR_NAME].string.pointer);
> +	check_property_type(integer, DISPL_NAME_LANG_CODE, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.integer_data[instance_id].display_name_language_code,
>  		integer_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	check_property_type(integer, DISPLAY_NAME, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.integer_data[instance_id].display_name,
>  		integer_obj[DISPLAY_NAME].string.pointer);
> +	check_property_type(integer, DEFAULT_VAL, ACPI_TYPE_INTEGER);
>  	wmi_priv.integer_data[instance_id].default_value =
>  		(uintptr_t)integer_obj[DEFAULT_VAL].string.pointer;
> +	check_property_type(integer, MODIFIER, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.integer_data[instance_id].dell_modifier,
>  		integer_obj[MODIFIER].string.pointer);
> +	check_property_type(integer, MIN_VALUE, ACPI_TYPE_INTEGER);
>  	wmi_priv.integer_data[instance_id].min_value =
>  		(uintptr_t)integer_obj[MIN_VALUE].string.pointer;
> +	check_property_type(integer, MAX_VALUE, ACPI_TYPE_INTEGER);
>  	wmi_priv.integer_data[instance_id].max_value =
>  		(uintptr_t)integer_obj[MAX_VALUE].string.pointer;
> +	check_property_type(integer, SCALAR_INCR, ACPI_TYPE_INTEGER);
>  	wmi_priv.integer_data[instance_id].scalar_increment =
>  		(uintptr_t)integer_obj[SCALAR_INCR].string.pointer;
>  
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
> index 834b3e82ad9f..866cf732cee2 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
> @@ -159,10 +159,13 @@ int alloc_po_data(void)
>  int populate_po_data(union acpi_object *po_obj, int instance_id, struct kobject *attr_name_kobj)
>  {
>  	wmi_priv.po_data[instance_id].attr_name_kobj = attr_name_kobj;
> +	check_property_type(po, ATTR_NAME, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.po_data[instance_id].attribute_name,
>  		     po_obj[ATTR_NAME].string.pointer);
> +	check_property_type(po, MIN_PASS_LEN, ACPI_TYPE_INTEGER);
>  	wmi_priv.po_data[instance_id].min_password_length =
>  		(uintptr_t)po_obj[MIN_PASS_LEN].string.pointer;
> +	check_property_type(po, MAX_PASS_LEN, ACPI_TYPE_INTEGER);
>  	wmi_priv.po_data[instance_id].max_password_length =
>  		(uintptr_t) po_obj[MAX_PASS_LEN].string.pointer;
>  
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
> index 552537852459..557b9d4511af 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
> @@ -118,24 +118,31 @@ int alloc_str_data(void)
>  
>  /**
>   * populate_str_data() - Populate all properties of an instance under string attribute
> - * @str_obj: ACPI object with integer data
> + * @str_obj: ACPI object with string data
>   * @instance_id: The instance to enumerate
>   * @attr_name_kobj: The parent kernel object
>   */
>  int populate_str_data(union acpi_object *str_obj, int instance_id, struct kobject *attr_name_kobj)
>  {
>  	wmi_priv.str_data[instance_id].attr_name_kobj = attr_name_kobj;
> +	check_property_type(str, ATTR_NAME, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.str_data[instance_id].attribute_name,
>  		     str_obj[ATTR_NAME].string.pointer);
> +	check_property_type(str, DISPL_NAME_LANG_CODE, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.str_data[instance_id].display_name_language_code,
>  		     str_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	check_property_type(str, DISPLAY_NAME, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.str_data[instance_id].display_name,
>  		     str_obj[DISPLAY_NAME].string.pointer);
> +	check_property_type(str, DEFAULT_VAL, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.str_data[instance_id].default_value,
>  		     str_obj[DEFAULT_VAL].string.pointer);
> +	check_property_type(str, MODIFIER, ACPI_TYPE_STRING);
>  	strlcpy_attr(wmi_priv.str_data[instance_id].dell_modifier,
>  		     str_obj[MODIFIER].string.pointer);
> +	check_property_type(str, MIN_LEN, ACPI_TYPE_INTEGER);
>  	wmi_priv.str_data[instance_id].min_length = (uintptr_t)str_obj[MIN_LEN].string.pointer;
> +	check_property_type(str, MAX_LEN, ACPI_TYPE_INTEGER);
>  	wmi_priv.str_data[instance_id].max_length = (uintptr_t) str_obj[MAX_LEN].string.pointer;
>  
>  	return sysfs_create_group(attr_name_kobj, &str_attr_group);

Except for the issue of using a macro which hides the return the above changes
look good, thank you.

> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> index 7410ccae650c..fc45cdb5a5e8 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -399,6 +399,7 @@ static int init_bios_attributes(int attr_type, const char *guid)
>  	union acpi_object *obj = NULL;
>  	union acpi_object *elements;
>  	struct kset *tmp_set;
> +	int min_elements;
>  
>  	/* instance_id needs to be reset for each type GUID
>  	 * also, instance IDs are unique within GUID but not across
> @@ -409,14 +410,43 @@ static int init_bios_attributes(int attr_type, const char *guid)
>  	retval = alloc_attributes_data(attr_type);
>  	if (retval)
>  		return retval;
> +
> +	switch (attr_type) {
> +	case ENUM:
> +	case STR:
> +		min_elements = 8;
> +		break;
> +	case INT:
> +		min_elements = 9;
> +		break;
> +	case PO:
> +		min_elements = 4;
> +		break;
> +	default:
> +		pr_err("Error: Unknown attr_type: %d\n", attr_type);
> +		return -EINVAL;
> +	}
> +
>  	/* need to use specific instance_id and guid combination to get right data */
>  	obj = get_wmiobj_pointer(instance_id, guid);
> -	if (!obj || obj->type != ACPI_TYPE_PACKAGE)
> +	if (!obj)
>  		return -ENODEV;
> -	elements = obj->package.elements;
>  
>  	mutex_lock(&wmi_priv.mutex);
> -	while (elements) {
> +	while (obj) {
> +		if (obj->type != ACPI_TYPE_PACKAGE) {
> +			pr_err("Error: Expected ACPI-package type, got: %d\n", obj->type);
> +			retval = -EIO;
> +			goto err_attr_init;
> +		}
> +
> +		if (obj->package.count < min_elements) {
> +			pr_err("Error: ACPI-package does not have enough elements: %d < %d\n",
> +			       obj->package.count, min_elements);
> +			goto nextobj;
> +		}
> +
> +		elements = obj->package.elements;
>  		/* sanity checking */
>  		if (elements[ATTR_NAME].type != ACPI_TYPE_STRING) {
>  			pr_debug("incorrect element type\n");

The above changes to drivers/platform/x86/dell/dell-wmi-sysman/sysman.c are already
present in for-next:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next

Please rebase on top of platform-drivers-x86.git/for-next.


> @@ -456,7 +486,8 @@ static int init_bios_attributes(int attr_type, const char *guid)
>  		/* enumerate all of this attribute */
>  		switch (attr_type) {
>  		case ENUM:
> -			retval = populate_enum_data(elements, instance_id, attr_name_kobj);
> +			retval = populate_enum_data(elements, instance_id, attr_name_kobj,
> +					obj->package.count);
>  			break;
>  		case INT:
>  			retval = populate_int_data(elements, instance_id, attr_name_kobj);
> 


Regards,

Hans

