Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7D3377F76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhEJJhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230153AbhEJJhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620639391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AU7zo6bVwVnfpZ7DIh+EUuZt1DVFtjdBfG+Vc5NzEe8=;
        b=ePHv55GweDYOqXkwhMYTngRQJqArDUxL3fvOmSX+k97wnXZRDdHcLjNXQgTj7dXiJztGOF
        Q+BdB4B1VvA3XBKsHVBzXCYvWImTAcdBtUILw/OaZYF5ygIxfl5FWufeg1/KjJsrSc2/DA
        7FY3shN0iGMtQdOTcB7AFsEbgCO7tA4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-T6gwsfbwP5yGJKdC3imvkA-1; Mon, 10 May 2021 05:36:30 -0400
X-MC-Unique: T6gwsfbwP5yGJKdC3imvkA-1
Received: by mail-ej1-f69.google.com with SMTP id cs18-20020a170906dc92b02903a8adf202d6so3460255ejc.23
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AU7zo6bVwVnfpZ7DIh+EUuZt1DVFtjdBfG+Vc5NzEe8=;
        b=cb/MAjkUFYteGaT+61o35/MQDSTov2foECjdOU7mJrqzI9kwgDlOmbOF1uswKrQMmU
         vweMH2HkflNKgTXBOdyVauN/Prtm/bniaAJHPYy20FTLnGBMueEEPjlth61kY5SGKHy9
         tB48qk2KzClmzBhdVMTOlhBg4KPMvkGotE+ZXZXd1k3bjhfo62QvhOwMy3CWHwYcHECi
         cCZFx4WJkZYTbh/UfpB82+8amcmod7e54veddNaeqQamivyFLXQ/30exT8TOxPG2Am74
         wiN7eul2uwg5B31badSGlwnz4/ipTyl/MKEDMO+/z0wdfb9aNXRuUc0vAi4PQ+1Vj4E6
         24ZQ==
X-Gm-Message-State: AOAM531OCktTvAuWYjIcoLoxd2LSimPlYx0xAaIW1Tp/N2oQI9K/CAaY
        T/dhSZ9XvKuk5bt+V46139A73St50FH40rxC9GnEttPPYpCjADIXRfDP7QuAkakF1wf03Vw9xbi
        oY3mW3f8akzqfCW3DQO6pKO6s
X-Received: by 2002:a05:6402:c1:: with SMTP id i1mr28223852edu.315.1620639388798;
        Mon, 10 May 2021 02:36:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGSngiLU/JDzfHN43Q9eIis2EowqfnjicjLpPjdPz+mL4ukA2XWwg1Nngs6x+TOv5GDqYLoQ==
X-Received: by 2002:a05:6402:c1:: with SMTP id i1mr28223831edu.315.1620639388579;
        Mon, 10 May 2021 02:36:28 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id o8sm8666791ejm.18.2021.05.10.02.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 02:36:28 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: Make populate_foo_data
 functions more robust
To:     Prasanth KSR <kosigiprasanth@gmail.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Prasanth KSR <prasanth.ksr@dell.com>,
        Divya Bharathi <divya.bharathi@dell.com>
References: <20210427042233.5495-1-prasanth.ksr@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d465a06c-8ff2-2f5f-7183-732adfa276ac@redhat.com>
Date:   Mon, 10 May 2021 11:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427042233.5495-1-prasanth.ksr@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/27/21 6:22 AM, Prasanth KSR wrote:
> 1. Check acpi type before assignment of each property value
> 
> 2. Add boundary check for properties count
> 
> Co-developed-by: Divya Bharathi <divya.bharathi@dell.com>
> Signed-off-by: Divya Bharathi <divya.bharathi@dell.com>
> Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>

Thanks this mostly looks good, 2 small remarks inline below.

Once those are fixed this is ready for merging.

> ---
>  .../dell/dell-wmi-sysman/dell-wmi-sysman.h    |  5 ++-
>  .../dell/dell-wmi-sysman/enum-attributes.c    | 36 ++++++++++++++++---
>  .../x86/dell/dell-wmi-sysman/int-attributes.c | 16 +++++++++
>  .../dell/dell-wmi-sysman/passobj-attributes.c |  6 ++++
>  .../dell/dell-wmi-sysman/string-attributes.c  | 16 ++++++++-
>  .../x86/dell/dell-wmi-sysman/sysman.c         | 17 ++++++---
>  6 files changed, 84 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
> index b80f2a62ea3f..3ad33a094588 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
> @@ -152,12 +152,15 @@ static ssize_t curr_val##_store(struct kobject *kobj,				\
>  	return ret ? ret : count;						\
>  }
>  
> +#define check_property_type(attr, prop, valuetype)				\
> +	(attr##_obj[prop].type != valuetype)
> +
>  union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid_string);
>  int get_instance_count(const char *guid_string);
>  void strlcpy_attr(char *dest, char *src);
>  
>  int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
> -			struct kobject *attr_name_kobj);
> +			struct kobject *attr_name_kobj, u32 enum_property_count);
>  int alloc_enum_data(void);
>  void exit_enum_attributes(void);
>  
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
> index 091e48c217ed..70f4ace56ec3 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
> @@ -132,39 +132,65 @@ int alloc_enum_data(void)
>   * @enumeration_obj: ACPI object with enumeration data
>   * @instance_id: The instance to enumerate
>   * @attr_name_kobj: The parent kernel object
> + * @enum_property_count: Total properties count under enumeration type
>   */
>  int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
> -			struct kobject *attr_name_kobj)
> +			struct kobject *attr_name_kobj, u32 enum_property_count)
>  {
>  	int i, next_obj, value_modifier_count, possible_values_count;
>  
>  	wmi_priv.enumeration_data[instance_id].attr_name_kobj = attr_name_kobj;
> +	if (check_property_type(enumeration, ATTR_NAME, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.enumeration_data[instance_id].attribute_name,
>  		enumeration_obj[ATTR_NAME].string.pointer);
> +	if (check_property_type(enumeration, DISPL_NAME_LANG_CODE, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.enumeration_data[instance_id].display_name_language_code,
>  		enumeration_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	if (check_property_type(enumeration, DISPLAY_NAME, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.enumeration_data[instance_id].display_name,
>  		enumeration_obj[DISPLAY_NAME].string.pointer);
> +	if (check_property_type(enumeration, DEFAULT_VAL, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.enumeration_data[instance_id].default_value,
>  		enumeration_obj[DEFAULT_VAL].string.pointer);
> +	if (check_property_type(enumeration, MODIFIER, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.enumeration_data[instance_id].dell_modifier,
>  		enumeration_obj[MODIFIER].string.pointer);
>  
>  	next_obj = MODIFIER + 1;
>  
> -	value_modifier_count = (uintptr_t)enumeration_obj[next_obj].string.pointer;
> +	if (next_obj >= enum_property_count)
> +		return -EINVAL;
> +
> +	if (check_property_type(enumeration, next_obj, ACPI_TYPE_INTEGER))
> +		return -EINVAL;
> +	value_modifier_count = (uintptr_t)enumeration_obj[next_obj++].string.pointer;
>  
>  	for (i = 0; i < value_modifier_count; i++) {
> +		if (next_obj >= enum_property_count)
> +			return -EINVAL;
> +		if (check_property_type(enumeration, next_obj, ACPI_TYPE_STRING))
> +			return -EINVAL;
>  		strcat(wmi_priv.enumeration_data[instance_id].dell_value_modifier,
> -			enumeration_obj[++next_obj].string.pointer);
> +			enumeration_obj[next_obj++].string.pointer);
>  		strcat(wmi_priv.enumeration_data[instance_id].dell_value_modifier, ";");
>  	}
>  
> -	possible_values_count = (uintptr_t) enumeration_obj[++next_obj].string.pointer;

You are missing a:

	if (next_obj >= enum_property_count)
		return -EINVAL;

Check here.


> +	if (check_property_type(enumeration, next_obj, ACPI_TYPE_INTEGER))
> +		return -EINVAL;
> +	possible_values_count = (uintptr_t) enumeration_obj[next_obj++].string.pointer;
>  
>  	for (i = 0; i < possible_values_count; i++) {
> +		if (next_obj >= enum_property_count)
> +			return -EINVAL;
> +		if (check_property_type(enumeration, next_obj, ACPI_TYPE_STRING))
> +			return -EINVAL;
>  		strcat(wmi_priv.enumeration_data[instance_id].possible_values,
> -			enumeration_obj[++next_obj].string.pointer);
> +			enumeration_obj[next_obj++].string.pointer);
>  		strcat(wmi_priv.enumeration_data[instance_id].possible_values, ";");
>  	}
>  
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
> index 8a49ba6e44f9..951e75b538fa 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
> @@ -141,20 +141,36 @@ int populate_int_data(union acpi_object *integer_obj, int instance_id,
>  			struct kobject *attr_name_kobj)
>  {
>  	wmi_priv.integer_data[instance_id].attr_name_kobj = attr_name_kobj;
> +	if (check_property_type(integer, ATTR_NAME, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.integer_data[instance_id].attribute_name,
>  		integer_obj[ATTR_NAME].string.pointer);
> +	if (check_property_type(integer, DISPL_NAME_LANG_CODE, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.integer_data[instance_id].display_name_language_code,
>  		integer_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	if (check_property_type(integer, DISPLAY_NAME, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.integer_data[instance_id].display_name,
>  		integer_obj[DISPLAY_NAME].string.pointer);
> +	if (check_property_type(integer, DEFAULT_VAL, ACPI_TYPE_INTEGER))
> +		return -EINVAL;
>  	wmi_priv.integer_data[instance_id].default_value =
>  		(uintptr_t)integer_obj[DEFAULT_VAL].string.pointer;
> +	if (check_property_type(integer, MODIFIER, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.integer_data[instance_id].dell_modifier,
>  		integer_obj[MODIFIER].string.pointer);
> +	if (check_property_type(integer, MIN_VALUE, ACPI_TYPE_INTEGER))
> +		return -EINVAL;
>  	wmi_priv.integer_data[instance_id].min_value =
>  		(uintptr_t)integer_obj[MIN_VALUE].string.pointer;
> +	if (check_property_type(integer, MAX_VALUE, ACPI_TYPE_INTEGER))
> +		return -EINVAL;
>  	wmi_priv.integer_data[instance_id].max_value =
>  		(uintptr_t)integer_obj[MAX_VALUE].string.pointer;
> +	if (check_property_type(integer, SCALAR_INCR, ACPI_TYPE_INTEGER))
> +		return -EINVAL;
>  	wmi_priv.integer_data[instance_id].scalar_increment =
>  		(uintptr_t)integer_obj[SCALAR_INCR].string.pointer;
>  
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
> index 834b3e82ad9f..230e6ee96636 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
> @@ -159,10 +159,16 @@ int alloc_po_data(void)
>  int populate_po_data(union acpi_object *po_obj, int instance_id, struct kobject *attr_name_kobj)
>  {
>  	wmi_priv.po_data[instance_id].attr_name_kobj = attr_name_kobj;
> +	if (check_property_type(po, ATTR_NAME, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.po_data[instance_id].attribute_name,
>  		     po_obj[ATTR_NAME].string.pointer);
> +	if (check_property_type(po, MIN_PASS_LEN, ACPI_TYPE_INTEGER))
> +		return -EINVAL;
>  	wmi_priv.po_data[instance_id].min_password_length =
>  		(uintptr_t)po_obj[MIN_PASS_LEN].string.pointer;
> +	if (check_property_type(po, MAX_PASS_LEN, ACPI_TYPE_INTEGER))
> +		return -EINVAL;
>  	wmi_priv.po_data[instance_id].max_password_length =
>  		(uintptr_t) po_obj[MAX_PASS_LEN].string.pointer;
>  
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
> index 552537852459..c392f0ecf8b5 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
> @@ -118,24 +118,38 @@ int alloc_str_data(void)
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
> +	if (check_property_type(str, ATTR_NAME, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.str_data[instance_id].attribute_name,
>  		     str_obj[ATTR_NAME].string.pointer);
> +	if (check_property_type(str, DISPL_NAME_LANG_CODE, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.str_data[instance_id].display_name_language_code,
>  		     str_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	if (check_property_type(str, DISPLAY_NAME, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.str_data[instance_id].display_name,
>  		     str_obj[DISPLAY_NAME].string.pointer);
> +	if (check_property_type(str, DEFAULT_VAL, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.str_data[instance_id].default_value,
>  		     str_obj[DEFAULT_VAL].string.pointer);
> +	if (check_property_type(str, MODIFIER, ACPI_TYPE_STRING))
> +		return -EINVAL;
>  	strlcpy_attr(wmi_priv.str_data[instance_id].dell_modifier,
>  		     str_obj[MODIFIER].string.pointer);
> +	if (check_property_type(str, MIN_LEN, ACPI_TYPE_INTEGER))
> +		return -EINVAL;
>  	wmi_priv.str_data[instance_id].min_length = (uintptr_t)str_obj[MIN_LEN].string.pointer;
> +	if (check_property_type(str, MAX_LEN, ACPI_TYPE_INTEGER))
> +		return -EINVAL;
>  	wmi_priv.str_data[instance_id].max_length = (uintptr_t) str_obj[MAX_LEN].string.pointer;
>  
>  	return sysfs_create_group(attr_name_kobj, &str_attr_group);
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> index c8d276d78e92..5276e8c5aad5 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -412,10 +412,16 @@ static int init_bios_attributes(int attr_type, const char *guid)
>  		return retval;
>  
>  	switch (attr_type) {
> -	case ENUM:	min_elements = 8;	break;
> -	case INT:	min_elements = 9;	break;
> -	case STR:	min_elements = 8;	break;
> -	case PO:	min_elements = 4;	break;
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
>  	default:
>  		pr_err("Error: Unknown attr_type: %d\n", attr_type);
>  		return -EINVAL;

Please drop these unrelated changes. If you want to change this please submit a
separate patch for it, but I would prefer to keep this as is.

> @@ -481,7 +487,8 @@ static int init_bios_attributes(int attr_type, const char *guid)
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

