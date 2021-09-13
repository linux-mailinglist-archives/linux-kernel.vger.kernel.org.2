Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35377408B53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhIMMuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232959AbhIMMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631537330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+YPq9DDWXh7H6lgKwZD0yJILIrB9KSPkJ+jCnMfKqo=;
        b=Jg+jvl+g+hIhEvSTSMC//KsyJS3abCLEh20UG1r7y8ApX9daqr4yC0rWmfbInJn6P3VIYi
        pOlZozSBz05yG721sYr9rVuQJivqOuo3WQKOQWlf69ASFg1UchdfIRTKVR71YlU2G3C+Y/
        FQHX5vAndfkLFtU56goDsj+dRNIJYZI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-TOBjEXgPOyqmxifnKxjksg-1; Mon, 13 Sep 2021 08:48:49 -0400
X-MC-Unique: TOBjEXgPOyqmxifnKxjksg-1
Received: by mail-ej1-f71.google.com with SMTP id k23-20020a170906055700b005e8a5cb6925so3635309eja.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 05:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/+YPq9DDWXh7H6lgKwZD0yJILIrB9KSPkJ+jCnMfKqo=;
        b=xkfbRay/vJYTodXDkAwNdCY3VRJb8z7QrBlYb+AhE1aJI0o/oSfK3XAM4LsiO+teGr
         4ITC9wPoxcpK5IJR01Xgq0Uf3jHMREN7JRLtN5Afd4anjnvKRLzYsej6AIVJOI4lrzQu
         7n+QJE6qW/ntwaUppUXbqYaf86ccm3uk7AHhfVBsMgFjmsxD2zHcmPlqhAbWpt6T7zh1
         mrvazwLIJSCRmCXp51nKb5brMHzGiFMOiduPpo4bCP9LwfJU+PZvX1QCTZiPbOR4kdVk
         Pqj0rzJKigKBRr6TLQ+5pRlysiUSaN91/sOBvi+4CJwkj5kvoMkKmFlLDEurh7k+rmDY
         Ji5w==
X-Gm-Message-State: AOAM533htx2hg0ld7mtufXycYu/lCEvHh5ysqu+xECn9JAsZJAq7k1RA
        NZIuS2QWiOF3tRuS1/aPvdsHX4GRL5Mmd83Bt3seVGPD/GMSJ9oVVC/Ye7cv82lvoTpsXZzMuLh
        du9o2JrXy46LMYMkT1dWGU4rQ//7sWN/poHBnw1pzPce5rpXoDbALBMfqI7H6gA0JFf3F+nJlOo
        uI
X-Received: by 2002:a05:6402:229c:: with SMTP id cw28mr9684661edb.356.1631537327576;
        Mon, 13 Sep 2021 05:48:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhcNXLU3ZDliCJFsc3cNNGslwjvbStH/s2UTqrQi41ZJLQVO9a8+kG4ie15sqA/r0xEucQ+w==
X-Received: by 2002:a05:6402:229c:: with SMTP id cw28mr9684626edb.356.1631537327216;
        Mon, 13 Sep 2021 05:48:47 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id q19sm3913862edc.74.2021.09.13.05.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 05:48:46 -0700 (PDT)
Subject: Re: [PATCH] Process tablet mode events on Dell Inspiron 2n1
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Troy Rollo <linux2021@troy.rollo.name>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210909033502.1994749-1-linux2021@troy.rollo.name>
 <776ba42d-1d87-81e9-ed36-3ef860869d93@redhat.com>
 <20210913124448.jnkpbya2eyq2mcqb@pali>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <063cf992-0f78-1d6e-cb4b-2545b4b740d5@redhat.com>
Date:   Mon, 13 Sep 2021 14:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210913124448.jnkpbya2eyq2mcqb@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/13/21 2:44 PM, Pali Rohár wrote:
> On Monday 13 September 2021 14:40:28 Hans de Goede wrote:
>> Hi,
>>
>> Overall this patch looks good, I have 2 remarks:
>>
>> 1. Your commit message needs some work, the first line (Subject) should
>> briefly describe the change with a subsystem prefix, so something like this:
>>
>> platform/x86: dell-wmi: Add SW_TABLET_MODE support for Dell Inspiron 2in1
>>
>> And then an empty line followed by a "body" with a bit more detailed description.
>>
>> And last but not least you need to add a Signed-off-by line like this:
>>
>> Singed-off-by: Troy Rollo <linux2021@troy.rollo.name>
>>
>> Which indicates that you authored the patch and are submitting it under
>> the standard kernel license, see:
>> https://elinux.org/Developer_Certificate_Of_Origin
>>
>> 2. Also have 1 remark about the code, see below.
>>
>>
>> On 9/9/21 5:35 AM, Troy Rollo wrote:
>>> ---
>>>  drivers/platform/x86/dell/dell-wmi-base.c | 36 ++++++++++++++++-------
>>>  1 file changed, 26 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
>>> index 089c125e18f7..474ca05055ab 100644
>>> --- a/drivers/platform/x86/dell/dell-wmi-base.c
>>> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
>>> @@ -309,6 +309,9 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
>>>   * Keymap for WMI events of type 0x0011
>>>   */
>>>  static const struct key_entry dell_wmi_keymap_type_0011[] = {
>>> +	/* Reflex keyboard switch on 2n1 devices */
>>> +	{ KE_VSW,    0xe070, { .sw  = { SW_TABLET_MODE } } },
>>> +
>>
>> By adding this here, any device loading the dell-wmi driver will now advertise
>> that it supports SW_TABLET_MODE reporting, even when it does not. This will
>> cause e.g. GNOME40 to disable accelerometer based rotation since when
>> SW_TABLET_MODE=0 is being reported then GNOME40 assumes it is running on a
>> 2in1 in laptop mode and thus disable auto-rotation (and also the on-screen-kbd).
>>
>> So advertising a non functional (always reporting 0) SW_TABLET_MODE switch
>> is harmful and this change will do this.
> 
> Good catch. This code needs some rework as based on above gnome
> behavior, this change breaks support for all existing older Dell
> laptops.
> 
> It it problem only with SW_TABLET_MODE? Or with any KE_VSW?

It is a problem for any KE_SW / KE_VSW since unlike keys/buttons which
are always unpressed by default and don't cause userspace to do anything
until a press is reported, switches have a meaning in both their
0 and 1 state, so merely reporting the presence of a switch can cause
userspace to change behavior.

Note I'm not aware of any SW other then SW_TABLET_MODE actually causing
issues, but in theory this is an issue with any SW because of the reason
which I just gave.

Regards,

Hans


> 
>> Since you already have special handling for the tablet-mode WMI events,
>> it would be better to use a separate input-device which just reports
>> SW_TABLET_MODE and which gets dynamically created upon receiving the
>> first 0x0011 0xe070 event. See the
>> drivers/platform/x86/intel/vbtn.c
>> drivers/platform/x86/intel/hid.c
>>
>> Drivers for an example of 2 drivers already doing this.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>>  	/* Battery unplugged */
>>>  	{ KE_IGNORE, 0xfff0, { KEY_RESERVED } },
>>>  
>>> @@ -344,17 +347,19 @@ static const struct key_entry dell_wmi_keymap_type_0012[] = {
>>>  	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
>>>  };
>>>  
>>> -static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
>>> +static int dell_wmi_process_key(struct wmi_device *wdev, int type, int code, u16 *buffer, int remaining)
>>>  {
>>>  	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
>>>  	const struct key_entry *key;
>>> +	int used = 0;
>>> +	int value = 1;
>>>  
>>>  	key = sparse_keymap_entry_from_scancode(priv->input_dev,
>>>  						(type << 16) | code);
>>>  	if (!key) {
>>>  		pr_info("Unknown key with type 0x%04x and code 0x%04x pressed\n",
>>>  			type, code);
>>> -		return;
>>> +		return 0;
>>>  	}
>>>  
>>>  	pr_debug("Key with type 0x%04x and code 0x%04x pressed\n", type, code);
>>> @@ -363,16 +368,22 @@ static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
>>>  	if ((key->keycode == KEY_BRIGHTNESSUP ||
>>>  	     key->keycode == KEY_BRIGHTNESSDOWN) &&
>>>  	    acpi_video_handles_brightness_key_presses())
>>> -		return;
>>> +		return 0;
>>>  
>>>  	if (type == 0x0000 && code == 0xe025 && !wmi_requires_smbios_request)
>>> -		return;
>>> +		return 0;
>>>  
>>> -	if (key->keycode == KEY_KBDILLUMTOGGLE)
>>> +	if (key->keycode == KEY_KBDILLUMTOGGLE) {
>>>  		dell_laptop_call_notifier(
>>>  			DELL_LAPTOP_KBD_BACKLIGHT_BRIGHTNESS_CHANGED, NULL);
>>> +	} else if (type == 0x0011 && code == 0xe070 && remaining > 0) {
>>> +		value = !buffer[0];
>>> +		used = 1;
>>> +	}
>>> +
>>> +	sparse_keymap_report_entry(priv->input_dev, key, value, true);
>>>  
>>> -	sparse_keymap_report_entry(priv->input_dev, key, 1, true);
>>> +	return used;
>>>  }
>>>  
>>>  static void dell_wmi_notify(struct wmi_device *wdev,
>>> @@ -430,21 +441,26 @@ static void dell_wmi_notify(struct wmi_device *wdev,
>>>  		case 0x0000: /* One key pressed or event occurred */
>>>  			if (len > 2)
>>>  				dell_wmi_process_key(wdev, buffer_entry[1],
>>> -						     buffer_entry[2]);
>>> +						     buffer_entry[2],
>>> +						     buffer_entry + 3,
>>> +						     len - 3);
>>>  			/* Extended data is currently ignored */
>>>  			break;
>>>  		case 0x0010: /* Sequence of keys pressed */
>>>  		case 0x0011: /* Sequence of events occurred */
>>>  			for (i = 2; i < len; ++i)
>>> -				dell_wmi_process_key(wdev, buffer_entry[1],
>>> -						     buffer_entry[i]);
>>> +				i += dell_wmi_process_key(wdev, buffer_entry[1],
>>> +							  buffer_entry[i],
>>> +							  buffer_entry + i,
>>> +							  len - i - 1);
>>>  			break;
>>>  		case 0x0012:
>>>  			if ((len > 4) && dell_privacy_process_event(buffer_entry[1], buffer_entry[3],
>>>  								    buffer_entry[4]))
>>>  				/* dell_privacy_process_event has handled the event */;
>>>  			else if (len > 2)
>>> -				dell_wmi_process_key(wdev, buffer_entry[1], buffer_entry[2]);
>>> +				dell_wmi_process_key(wdev, buffer_entry[1], buffer_entry[2],
>>> +						     buffer_entry + 3, len - 3);
>>>  			break;
>>>  		default: /* Unknown event */
>>>  			pr_info("Unknown WMI event type 0x%x\n",
>>>
>>
> 

