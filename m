Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A89408E51
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbhIMNc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241403AbhIMNYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631539373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j8W6dBntVL6AusfnmBYHXmMjjTqmgA/g/vBD/v4Pscw=;
        b=IjH+BtNYjOMiAb5ErEJE6td7Rqr59O36HHCoGc44cIYCUd6hauJm9uK9wiB8bWWnvtBvky
        mnzdP9R11plhuJ5FMgXxjZjy2PZgT98OKlNnhdqxbG7z2eU6hmr/ghZLex9dcy9CwzImtA
        h6mnSiCvkPawmo1SvidVd+X7lcyNEhg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Sztd-4_gNQipg6vFoXSSEw-1; Mon, 13 Sep 2021 09:22:52 -0400
X-MC-Unique: Sztd-4_gNQipg6vFoXSSEw-1
Received: by mail-ej1-f69.google.com with SMTP id v19-20020a170906b013b02905b2f1bbf8f3so3661811ejy.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j8W6dBntVL6AusfnmBYHXmMjjTqmgA/g/vBD/v4Pscw=;
        b=z0Hd4D3/SMnIhoNsA20qg2nXQKa+njmquXV8sr2dAq2Kj5MAajDvuGntq5toqcN98G
         +1aRuosSgZ+4WGINXAR5MIXQ5Lbuh41XYDAF0ehdZ5O0b1lI1ixGQgeMomJ0QKmWOi7J
         94Nfq4IN7JIVVgdOz/qt1NMFmxXIW/TsCegKTDYi7WNZgrpmBDPzGfKfxMnVVjXtU/+C
         aR+oqIF1wuUy3PUdaUcOUyKEdko+3pycO+MLE0lmtB2M5SHXDXktqUTCfHdhaUkVND+X
         jqAL69YH/uzH4++Hex4vDf+g7gNckMrFVdrgtyr72yWnwrojB8vBhQ9VkCaUlDM1mHJV
         uFXQ==
X-Gm-Message-State: AOAM531pVveDecpF8hC9YzcCL1x/l516l1gVR6+hT6TBEEi2iDOMLsUM
        5v1F+WTr/JXMpMIrLW7WKF0cvlChQYO/OPXnVmSrVtW8YbrKQ8X5JLEQ9A2Dw8OP2TVnPvqu8tl
        SAMrEf6FyrOYshfgk1wp95dOUF1G/zhGXIt4zHAp6x0sOMVl+rBCfoX3WLJNOUYXaIe54vaGOTR
        4b
X-Received: by 2002:aa7:c80d:: with SMTP id a13mr13099430edt.71.1631539371417;
        Mon, 13 Sep 2021 06:22:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhLciDvypfxN7D5s0/jX2WJ6IleCql6EIx/3HGSI2S++wGwP/YnUtH59m2ARKHE07k8LGszw==
X-Received: by 2002:aa7:c80d:: with SMTP id a13mr13099402edt.71.1631539371098;
        Mon, 13 Sep 2021 06:22:51 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id t19sm3474426ejb.115.2021.09.13.06.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 06:22:50 -0700 (PDT)
Subject: Re: [PATCH] Process tablet mode events on Dell Inspiron 2n1
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Troy Rollo <linux2021@troy.rollo.name>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210909033502.1994749-1-linux2021@troy.rollo.name>
 <776ba42d-1d87-81e9-ed36-3ef860869d93@redhat.com>
 <20210913124448.jnkpbya2eyq2mcqb@pali>
 <063cf992-0f78-1d6e-cb4b-2545b4b740d5@redhat.com>
 <20210913125908.lshshpu5bkdliacg@pali>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <eac854ac-a919-0230-a421-9255ca7f8ff6@redhat.com>
Date:   Mon, 13 Sep 2021 15:22:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210913125908.lshshpu5bkdliacg@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/13/21 2:59 PM, Pali Rohár wrote:
> On Monday 13 September 2021 14:48:46 Hans de Goede wrote:
>> Hi,
>>
>> On 9/13/21 2:44 PM, Pali Rohár wrote:
>>> On Monday 13 September 2021 14:40:28 Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> Overall this patch looks good, I have 2 remarks:
>>>>
>>>> 1. Your commit message needs some work, the first line (Subject) should
>>>> briefly describe the change with a subsystem prefix, so something like this:
>>>>
>>>> platform/x86: dell-wmi: Add SW_TABLET_MODE support for Dell Inspiron 2in1
>>>>
>>>> And then an empty line followed by a "body" with a bit more detailed description.
>>>>
>>>> And last but not least you need to add a Signed-off-by line like this:
>>>>
>>>> Singed-off-by: Troy Rollo <linux2021@troy.rollo.name>
>>>>
>>>> Which indicates that you authored the patch and are submitting it under
>>>> the standard kernel license, see:
>>>> https://elinux.org/Developer_Certificate_Of_Origin
>>>>
>>>> 2. Also have 1 remark about the code, see below.
>>>>
>>>>
>>>> On 9/9/21 5:35 AM, Troy Rollo wrote:
>>>>> ---
>>>>>  drivers/platform/x86/dell/dell-wmi-base.c | 36 ++++++++++++++++-------
>>>>>  1 file changed, 26 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
>>>>> index 089c125e18f7..474ca05055ab 100644
>>>>> --- a/drivers/platform/x86/dell/dell-wmi-base.c
>>>>> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
>>>>> @@ -309,6 +309,9 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
>>>>>   * Keymap for WMI events of type 0x0011
>>>>>   */
>>>>>  static const struct key_entry dell_wmi_keymap_type_0011[] = {
>>>>> +	/* Reflex keyboard switch on 2n1 devices */
>>>>> +	{ KE_VSW,    0xe070, { .sw  = { SW_TABLET_MODE } } },
>>>>> +
>>>>
>>>> By adding this here, any device loading the dell-wmi driver will now advertise
>>>> that it supports SW_TABLET_MODE reporting, even when it does not. This will
>>>> cause e.g. GNOME40 to disable accelerometer based rotation since when
>>>> SW_TABLET_MODE=0 is being reported then GNOME40 assumes it is running on a
>>>> 2in1 in laptop mode and thus disable auto-rotation (and also the on-screen-kbd).
>>>>
>>>> So advertising a non functional (always reporting 0) SW_TABLET_MODE switch
>>>> is harmful and this change will do this.
>>>
>>> Good catch. This code needs some rework as based on above gnome
>>> behavior, this change breaks support for all existing older Dell
>>> laptops.
>>>
>>> It it problem only with SW_TABLET_MODE? Or with any KE_VSW?
>>
>> It is a problem for any KE_SW / KE_VSW since unlike keys/buttons which
>> are always unpressed by default and don't cause userspace to do anything
>> until a press is reported, switches have a meaning in both their
>> 0 and 1 state, so merely reporting the presence of a switch can cause
>> userspace to change behavior.
>>
>> Note I'm not aware of any SW other then SW_TABLET_MODE actually causing
>> issues, but in theory this is an issue with any SW because of the reason
>> which I just gave.
> 
> Well, this argument makes sense for any switch.
> 
> But all other defined keys in this driver are "standard" keys which may
> or may not be present on de-facto standard keyboard: capslock,
> brightness keys, volume keys, wifi key, eject key, ...
> Probably generic AT keyboard driver may also report more standard keys
> than it has.
> 
> So I'm not sure if it makes sense to rewrite wmi driver to dynamically
> allocate presence of also every key based on first press.
> 
> If some userspace software depends on capabilities of "standard" keys
> and reacts differently then I guess it is broken...
> 
> But for switches this dynamic behavior as you described is needed.

Right, I fully agree.

Regards,

Hans


>>>> Since you already have special handling for the tablet-mode WMI events,
>>>> it would be better to use a separate input-device which just reports
>>>> SW_TABLET_MODE and which gets dynamically created upon receiving the
>>>> first 0x0011 0xe070 event. See the
>>>> drivers/platform/x86/intel/vbtn.c
>>>> drivers/platform/x86/intel/hid.c
>>>>
>>>> Drivers for an example of 2 drivers already doing this.
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
>>>>
>>>>
>>>>>  	/* Battery unplugged */
>>>>>  	{ KE_IGNORE, 0xfff0, { KEY_RESERVED } },
>>>>>  
>>>>> @@ -344,17 +347,19 @@ static const struct key_entry dell_wmi_keymap_type_0012[] = {
>>>>>  	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
>>>>>  };
>>>>>  
>>>>> -static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
>>>>> +static int dell_wmi_process_key(struct wmi_device *wdev, int type, int code, u16 *buffer, int remaining)
>>>>>  {
>>>>>  	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
>>>>>  	const struct key_entry *key;
>>>>> +	int used = 0;
>>>>> +	int value = 1;
>>>>>  
>>>>>  	key = sparse_keymap_entry_from_scancode(priv->input_dev,
>>>>>  						(type << 16) | code);
>>>>>  	if (!key) {
>>>>>  		pr_info("Unknown key with type 0x%04x and code 0x%04x pressed\n",
>>>>>  			type, code);
>>>>> -		return;
>>>>> +		return 0;
>>>>>  	}
>>>>>  
>>>>>  	pr_debug("Key with type 0x%04x and code 0x%04x pressed\n", type, code);
>>>>> @@ -363,16 +368,22 @@ static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
>>>>>  	if ((key->keycode == KEY_BRIGHTNESSUP ||
>>>>>  	     key->keycode == KEY_BRIGHTNESSDOWN) &&
>>>>>  	    acpi_video_handles_brightness_key_presses())
>>>>> -		return;
>>>>> +		return 0;
>>>>>  
>>>>>  	if (type == 0x0000 && code == 0xe025 && !wmi_requires_smbios_request)
>>>>> -		return;
>>>>> +		return 0;
>>>>>  
>>>>> -	if (key->keycode == KEY_KBDILLUMTOGGLE)
>>>>> +	if (key->keycode == KEY_KBDILLUMTOGGLE) {
>>>>>  		dell_laptop_call_notifier(
>>>>>  			DELL_LAPTOP_KBD_BACKLIGHT_BRIGHTNESS_CHANGED, NULL);
>>>>> +	} else if (type == 0x0011 && code == 0xe070 && remaining > 0) {
>>>>> +		value = !buffer[0];
>>>>> +		used = 1;
>>>>> +	}
>>>>> +
>>>>> +	sparse_keymap_report_entry(priv->input_dev, key, value, true);
>>>>>  
>>>>> -	sparse_keymap_report_entry(priv->input_dev, key, 1, true);
>>>>> +	return used;
>>>>>  }
>>>>>  
>>>>>  static void dell_wmi_notify(struct wmi_device *wdev,
>>>>> @@ -430,21 +441,26 @@ static void dell_wmi_notify(struct wmi_device *wdev,
>>>>>  		case 0x0000: /* One key pressed or event occurred */
>>>>>  			if (len > 2)
>>>>>  				dell_wmi_process_key(wdev, buffer_entry[1],
>>>>> -						     buffer_entry[2]);
>>>>> +						     buffer_entry[2],
>>>>> +						     buffer_entry + 3,
>>>>> +						     len - 3);
>>>>>  			/* Extended data is currently ignored */
>>>>>  			break;
>>>>>  		case 0x0010: /* Sequence of keys pressed */
>>>>>  		case 0x0011: /* Sequence of events occurred */
>>>>>  			for (i = 2; i < len; ++i)
>>>>> -				dell_wmi_process_key(wdev, buffer_entry[1],
>>>>> -						     buffer_entry[i]);
>>>>> +				i += dell_wmi_process_key(wdev, buffer_entry[1],
>>>>> +							  buffer_entry[i],
>>>>> +							  buffer_entry + i,
>>>>> +							  len - i - 1);
>>>>>  			break;
>>>>>  		case 0x0012:
>>>>>  			if ((len > 4) && dell_privacy_process_event(buffer_entry[1], buffer_entry[3],
>>>>>  								    buffer_entry[4]))
>>>>>  				/* dell_privacy_process_event has handled the event */;
>>>>>  			else if (len > 2)
>>>>> -				dell_wmi_process_key(wdev, buffer_entry[1], buffer_entry[2]);
>>>>> +				dell_wmi_process_key(wdev, buffer_entry[1], buffer_entry[2],
>>>>> +						     buffer_entry + 3, len - 3);
>>>>>  			break;
>>>>>  		default: /* Unknown event */
>>>>>  			pr_info("Unknown WMI event type 0x%x\n",
>>>>>
>>>>
>>>
>>
> 

