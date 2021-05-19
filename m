Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF40389366
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbhESQO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355117AbhESQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621440812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ym7f63hOuYGl6Fks8S3xfcXYeM6JuCHnQnE/LmDsC+w=;
        b=WF/zS4XDCykFDCyiooGHEfEh2GnRgFrPFYT06ywkiuUKnJ8CkgoPSv88PmsXIm51PEy5/2
        RR91wlRoiwruK2jgBE2Y9e0UwF3yR2bMDt0b/c7jvzMbB286R1+pxrhKZoFONQU1lPMtkZ
        uNZ7evy+XbUVlcFCObOYE3LtxD1wXBU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-ST-utz4ZOS6y0DsLy0i5ig-1; Wed, 19 May 2021 12:13:27 -0400
X-MC-Unique: ST-utz4ZOS6y0DsLy0i5ig-1
Received: by mail-ej1-f70.google.com with SMTP id gt39-20020a1709072da7b02903a8f7736a08so3914627ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ym7f63hOuYGl6Fks8S3xfcXYeM6JuCHnQnE/LmDsC+w=;
        b=JvvTfzhCSf+tlT8D7Ral7Q6Zzik7Ux/BSljr0pPH/MSyEiAALFBglUU6fXZMavKuFv
         D6IxMIEBUZBsp47NJ553LAlsmr6NiYGNA+PxGXyW4MoQpRM8BGwy0QPdWZT++yXEC8r4
         H79ifi9bwiruVD9JnFmtUeiy+QszcS2yaB9OXo+2ZFoCMlPqNvU/JbMhSzteGHwQmZ3M
         C4fYKe2Jb9CXePW1ULo02aNjsVHgg/Id+a9CbvivkkqgypsbsLDNKqbL3YYmzLMFXxoI
         BHHrbPlHtJJDzbzwM4jtlM35E0Ht3r1oInGq9eWEqhm+1LXSDJKmKc9pk770WCCN+5+m
         CzZw==
X-Gm-Message-State: AOAM532bQBp0ninVttueUj61JaDPnBEFweO3KKAFgpt+NjKEFKRCB0+s
        ozXtguU9BcOpgEwkuyx3jAwkOCVQi58gGhYsV+7Wl7lg+VB/sPOXGhT++9vv/ReprbtcLxdW+kj
        Q4g+viKN7PiNKwNVaD1YSfebVVPQj9gHx/8zWw3nTVp+EGccVRAnU1wNUiIZ9cDFJ/gb8TBganX
        nQ
X-Received: by 2002:a05:6402:2298:: with SMTP id cw24mr15527121edb.156.1621440806303;
        Wed, 19 May 2021 09:13:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnTN24eRl34SNmfx7WHavN7lqQcZzDt7hRHYCP7UdJMNzIybsDyWB05IdjzXMOktdqUwQ20w==
X-Received: by 2002:a05:6402:2298:: with SMTP id cw24mr15527099edb.156.1621440806116;
        Wed, 19 May 2021 09:13:26 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gz8sm72730ejb.38.2021.05.19.09.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 09:13:25 -0700 (PDT)
Subject: Re: [PATCH] HID: input: Add support for Programmable Buttons
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        linux-kernel@vger.kernel.org
References: <61dcf8c7-2dcb-4173-fbbd-9adf3412edb7@redhat.com>
 <20210519160349.609690-1-linux@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2dc197eb-a222-8af6-f0ab-f722e4f492ca@redhat.com>
Date:   Wed, 19 May 2021 18:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519160349.609690-1-linux@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/19/21 6:03 PM, Thomas Weißschuh wrote:
> From: Thomas Weißschuh <thomas@t-8ch.de>
> 
> Map them to KEY_MACRO# event codes.
> 
> These buttons are defined by HID as follows:
> "The user defines the function of these buttons to control software
> applications or GUI objects."
> 
> This matches the semantics of the KEY_MACRO# input event codes that
> Linux supports.
> 
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
>  drivers/hid/hid-debug.c | 11 +++++++++++
>  drivers/hid/hid-input.c |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index 59f8d716d78f..0e76d9b4530a 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -122,6 +122,7 @@ static const struct hid_usage_entry hid_usage_table[] = {
>    {  9, 0, "Button" },
>    { 10, 0, "Ordinal" },
>    { 12, 0, "Consumer" },
> +      {0, 0x003, "ProgrammableButtons"},
>        {0, 0x238, "HorizontalWheel"},
>    { 13, 0, "Digitizers" },
>      {0, 0x01, "Digitizer"},
> @@ -939,6 +940,16 @@ static const char *keys[KEY_MAX + 1] = {
>  	[KEY_KBDINPUTASSIST_NEXTGROUP] = "KbdInputAssistNextGroup",
>  	[KEY_KBDINPUTASSIST_ACCEPT] = "KbdInputAssistAccept",
>  	[KEY_KBDINPUTASSIST_CANCEL] = "KbdInputAssistCancel",
> +	[KEY_MACRO1] = "Macro1", [KEY_MACRO2] = "Macro2", [KEY_MACRO3] = "Macro3",
> +	[KEY_MACRO4] = "Macro4", [KEY_MACRO5] = "Macro5", [KEY_MACRO6] = "Macro6",
> +	[KEY_MACRO7] = "Macro7", [KEY_MACRO8] = "Macro8", [KEY_MACRO9] = "Macro9",
> +	[KEY_MACRO10] = "Macro10", [KEY_MACRO11] = "Macro11", [KEY_MACRO12] = "Macro12",
> +	[KEY_MACRO13] = "Macro13", [KEY_MACRO14] = "Macro14", [KEY_MACRO15] = "Macro15",
> +	[KEY_MACRO16] = "Macro16", [KEY_MACRO17] = "Macro17", [KEY_MACRO18] = "Macro18",
> +	[KEY_MACRO19] = "Macro19", [KEY_MACRO20] = "Macro20", [KEY_MACRO21] = "Macro21",
> +	[KEY_MACRO22] = "Macro22", [KEY_MACRO23] = "Macro23", [KEY_MACRO24] = "Macro24",
> +	[KEY_MACRO25] = "Macro25", [KEY_MACRO26] = "Macro26", [KEY_MACRO27] = "Macro27",
> +	[KEY_MACRO28] = "Macro28", [KEY_MACRO29] = "Macro29", [KEY_MACRO30] = "Macro30",
>  };
>  
>  static const char *relatives[REL_MAX + 1] = {
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 18f5e28d475c..7d4dee58d869 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -632,6 +632,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  				else
>  					code += BTN_TRIGGER_HAPPY - 0x10;
>  				break;
> +		case HID_CP_CONSUMER_CONTROL: code += KEY_MACRO1; break;

Shouldn't there be a check here to ensure that we don't map things above KEY_MACRO30 ?
if we do that then we start hitting other codes like KEY_MACRO_RECORD_START and eventually
BTN_TRIGGER_HAPPY and after the BTN_TRIGGER_HAPPY range we go over KEY_MAX which I think
is not supported ?

Regards,

Hans



>  		default:
>  			switch (field->physical) {
>  			case HID_GD_MOUSE:
> 
> base-commit: efd8929b9eec1cde120abb36d76dd00ff6711023
> 

