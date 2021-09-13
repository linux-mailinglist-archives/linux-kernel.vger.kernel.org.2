Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B187B408B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbhIMMlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236180AbhIMMlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631536831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qlsCP2qhSgSLVFrSvVDvFizs4Sbr7u4Q8tObERzqWpY=;
        b=G8mTvscBfwx4gybgOJj2HAitCMyTgwzsTmGscptEtNx9eCGGd3V7cJz3MvV6Mp3GRg42m6
        uVd5W16C0vzs4NHQcsrTzSRzSwcKeSVhpAfkfk7QfV3IGt6OCE2rJjP+uhNhzBma6mfkxe
        1Q+zY0+Q+djUC1Q87pF6nTqtmoESvK0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-iFgFdyWyPHuAp61IShOt_g-1; Mon, 13 Sep 2021 08:40:30 -0400
X-MC-Unique: iFgFdyWyPHuAp61IShOt_g-1
Received: by mail-ej1-f70.google.com with SMTP id z15-20020a170906074f00b005ef9f1d0e97so1595708ejb.19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 05:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qlsCP2qhSgSLVFrSvVDvFizs4Sbr7u4Q8tObERzqWpY=;
        b=iIfu8AxK/AZY9Lf2lm/g1x1/k1TGspGQY9exfOKi48LMNOoPM6IwdajAwM+DBMp8Ib
         9x09W/TfjM4SpY9oR++s4MU9I+NhtcOPPdmawbVsfV2YOAuVqycOX0J0B3EU/DZ8Mlty
         55DVGB1vHSlfPNoYYdBrQRGdWz23vhcUWKAztpFUhrNEQs4H03YCcw8hZy4NVa/gOmZC
         5hAipRSBiKgdiI36ZTadf4e/8xQY7n9/AAkz+DikGKf7kVzi9TiOjDT41IcPD941AGrP
         WCp9kOtewxDaZkQuTGRDOvRdZyuKtEYPyT6FOVrq4UelD5bkXgO2vuJeUL5/87loni14
         x6xw==
X-Gm-Message-State: AOAM533Coz9wFTKDra5pAWDHYC+4TSMUoUxTfteyjYLl+cAFs3LGmFLS
        ZqLLl/kMt2FaElVskxBq0b0WnY3KfINaQJV+tLImw6tn6147txWx46jXA505YafAhuAarpeGEL5
        mgU371FxF8iUFED9E581C9CLL1I0CC3NiUuhdieTAwlDePicvaGCJ8YnF7/EhphV/H/pK49myTy
        PN
X-Received: by 2002:a17:906:4c89:: with SMTP id q9mr12784112eju.118.1631536829180;
        Mon, 13 Sep 2021 05:40:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOgNkAIxBV1tgFRLPkt6mc+RZZ5SibWG4r+lHtG3fyDuFIdvSd6rBNvuruUOJuIRSxj5COBw==
X-Received: by 2002:a17:906:4c89:: with SMTP id q9mr12784089eju.118.1631536828880;
        Mon, 13 Sep 2021 05:40:28 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id y8sm1239281ejm.104.2021.09.13.05.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 05:40:28 -0700 (PDT)
Subject: Re: [PATCH] Process tablet mode events on Dell Inspiron 2n1
To:     Troy Rollo <linux2021@troy.rollo.name>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210909033502.1994749-1-linux2021@troy.rollo.name>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <776ba42d-1d87-81e9-ed36-3ef860869d93@redhat.com>
Date:   Mon, 13 Sep 2021 14:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210909033502.1994749-1-linux2021@troy.rollo.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Overall this patch looks good, I have 2 remarks:

1. Your commit message needs some work, the first line (Subject) should
briefly describe the change with a subsystem prefix, so something like this:

platform/x86: dell-wmi: Add SW_TABLET_MODE support for Dell Inspiron 2in1

And then an empty line followed by a "body" with a bit more detailed description.

And last but not least you need to add a Signed-off-by line like this:

Singed-off-by: Troy Rollo <linux2021@troy.rollo.name>

Which indicates that you authored the patch and are submitting it under
the standard kernel license, see:
https://elinux.org/Developer_Certificate_Of_Origin

2. Also have 1 remark about the code, see below.


On 9/9/21 5:35 AM, Troy Rollo wrote:
> ---
>  drivers/platform/x86/dell/dell-wmi-base.c | 36 ++++++++++++++++-------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> index 089c125e18f7..474ca05055ab 100644
> --- a/drivers/platform/x86/dell/dell-wmi-base.c
> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> @@ -309,6 +309,9 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
>   * Keymap for WMI events of type 0x0011
>   */
>  static const struct key_entry dell_wmi_keymap_type_0011[] = {
> +	/* Reflex keyboard switch on 2n1 devices */
> +	{ KE_VSW,    0xe070, { .sw  = { SW_TABLET_MODE } } },
> +

By adding this here, any device loading the dell-wmi driver will now advertise
that it supports SW_TABLET_MODE reporting, even when it does not. This will
cause e.g. GNOME40 to disable accelerometer based rotation since when
SW_TABLET_MODE=0 is being reported then GNOME40 assumes it is running on a
2in1 in laptop mode and thus disable auto-rotation (and also the on-screen-kbd).

So advertising a non functional (always reporting 0) SW_TABLET_MODE switch
is harmful and this change will do this.

Since you already have special handling for the tablet-mode WMI events,
it would be better to use a separate input-device which just reports
SW_TABLET_MODE and which gets dynamically created upon receiving the
first 0x0011 0xe070 event. See the
drivers/platform/x86/intel/vbtn.c
drivers/platform/x86/intel/hid.c

Drivers for an example of 2 drivers already doing this.

Regards,

Hans



>  	/* Battery unplugged */
>  	{ KE_IGNORE, 0xfff0, { KEY_RESERVED } },
>  
> @@ -344,17 +347,19 @@ static const struct key_entry dell_wmi_keymap_type_0012[] = {
>  	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
>  };
>  
> -static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
> +static int dell_wmi_process_key(struct wmi_device *wdev, int type, int code, u16 *buffer, int remaining)
>  {
>  	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
>  	const struct key_entry *key;
> +	int used = 0;
> +	int value = 1;
>  
>  	key = sparse_keymap_entry_from_scancode(priv->input_dev,
>  						(type << 16) | code);
>  	if (!key) {
>  		pr_info("Unknown key with type 0x%04x and code 0x%04x pressed\n",
>  			type, code);
> -		return;
> +		return 0;
>  	}
>  
>  	pr_debug("Key with type 0x%04x and code 0x%04x pressed\n", type, code);
> @@ -363,16 +368,22 @@ static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
>  	if ((key->keycode == KEY_BRIGHTNESSUP ||
>  	     key->keycode == KEY_BRIGHTNESSDOWN) &&
>  	    acpi_video_handles_brightness_key_presses())
> -		return;
> +		return 0;
>  
>  	if (type == 0x0000 && code == 0xe025 && !wmi_requires_smbios_request)
> -		return;
> +		return 0;
>  
> -	if (key->keycode == KEY_KBDILLUMTOGGLE)
> +	if (key->keycode == KEY_KBDILLUMTOGGLE) {
>  		dell_laptop_call_notifier(
>  			DELL_LAPTOP_KBD_BACKLIGHT_BRIGHTNESS_CHANGED, NULL);
> +	} else if (type == 0x0011 && code == 0xe070 && remaining > 0) {
> +		value = !buffer[0];
> +		used = 1;
> +	}
> +
> +	sparse_keymap_report_entry(priv->input_dev, key, value, true);
>  
> -	sparse_keymap_report_entry(priv->input_dev, key, 1, true);
> +	return used;
>  }
>  
>  static void dell_wmi_notify(struct wmi_device *wdev,
> @@ -430,21 +441,26 @@ static void dell_wmi_notify(struct wmi_device *wdev,
>  		case 0x0000: /* One key pressed or event occurred */
>  			if (len > 2)
>  				dell_wmi_process_key(wdev, buffer_entry[1],
> -						     buffer_entry[2]);
> +						     buffer_entry[2],
> +						     buffer_entry + 3,
> +						     len - 3);
>  			/* Extended data is currently ignored */
>  			break;
>  		case 0x0010: /* Sequence of keys pressed */
>  		case 0x0011: /* Sequence of events occurred */
>  			for (i = 2; i < len; ++i)
> -				dell_wmi_process_key(wdev, buffer_entry[1],
> -						     buffer_entry[i]);
> +				i += dell_wmi_process_key(wdev, buffer_entry[1],
> +							  buffer_entry[i],
> +							  buffer_entry + i,
> +							  len - i - 1);
>  			break;
>  		case 0x0012:
>  			if ((len > 4) && dell_privacy_process_event(buffer_entry[1], buffer_entry[3],
>  								    buffer_entry[4]))
>  				/* dell_privacy_process_event has handled the event */;
>  			else if (len > 2)
> -				dell_wmi_process_key(wdev, buffer_entry[1], buffer_entry[2]);
> +				dell_wmi_process_key(wdev, buffer_entry[1], buffer_entry[2],
> +						     buffer_entry + 3, len - 3);
>  			break;
>  		default: /* Unknown event */
>  			pr_info("Unknown WMI event type 0x%x\n",
> 

