Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E118389744
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhESUDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232529AbhESUDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621454517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhvgxIwKXugvxbNq7OeadgSTzvUaMEzWThB+Rg7b80k=;
        b=ZZhg4zQKRWOGUU0U6GSf98p6srWjVyAw6XYnYhulfqt2NWQAmR81MhXm3XwvSFSdw5sDYb
        JOv1QFzA8DueThnjAgHvJ51eQcyESQJtu720d1c4H/cOYvgFCUKbSWoOHtmw8tZlt4VB3D
        cKR9qzm+3LdWCWG0jVgBeEPgU2hCdVg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-ZfmaMgHvOYKHbYxjSQhStw-1; Wed, 19 May 2021 16:01:55 -0400
X-MC-Unique: ZfmaMgHvOYKHbYxjSQhStw-1
Received: by mail-ej1-f71.google.com with SMTP id la2-20020a170906ad82b02903d4bcc8de3bso4150778ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xhvgxIwKXugvxbNq7OeadgSTzvUaMEzWThB+Rg7b80k=;
        b=PoYUkh3q0K17W1G5iIZbUdi2u/WUEsoo1tqsKydccUAOcvO3eA7qkctuoTuW+CZXQ4
         XmhNvbnFisPBUtTD1CVE79ONZQJnAe0T9q5mE4PNw4Yst8eqVMH+/2Mb1lsOzzFr6fqf
         0SqOYaz2WFNulNdi0CZ1oW165qB2vkJjsgxAyi4Ze9mTpjYHpjXomWpNxfHdInknVgS5
         7QcqdSt0Urdi+6QlWc4mkDE8gX1sxE6Zbirml0bcndrRJo7rUhaeNC43U7G0US+6NqHh
         0VsYRvwioviABLThh6jjp6z+A0bTdY+B85/s8HOHldzj7H6qeOiUiWZUxFhX4x1CFISA
         UG+w==
X-Gm-Message-State: AOAM5310Blzzle7OvcYiFSd23pqgKhFy/UUUXVlw1dx6LARfoYXuauit
        CrOp6hsySeoSqaC4P/fRUt8t6rCTUirk7Hxdj6oEc35a/3K52CWUCsK7Ae+/CAJIJCZ+zJ+XGnv
        syKzd7AML13dJX8XXPurOe7ANyAF+XDQ02qk46Pn0AGmSFbU6xODxOafwF5PtyEXl/VHvjrdg0N
        dY
X-Received: by 2002:a17:906:9257:: with SMTP id c23mr879393ejx.392.1621454514262;
        Wed, 19 May 2021 13:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybAg2DWZBkUUzS/X6mkLHq8i7CowtdJNYzUX/LoGoHmT0H/o0OQw/yu/bVPLeRCeLuH4uFBw==
X-Received: by 2002:a17:906:9257:: with SMTP id c23mr879369ejx.392.1621454514011;
        Wed, 19 May 2021 13:01:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id 9sm397858ejv.73.2021.05.19.13.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 13:01:53 -0700 (PDT)
Subject: Re: [PATCH v2] HID: input: Add support for Programmable Buttons
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org
References: <2dc197eb-a222-8af6-f0ab-f722e4f492ca@redhat.com>
 <20210519174345.614467-1-linux@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f4cf1adb-5662-28d2-0063-0bd2856ef0f4@redhat.com>
Date:   Wed, 19 May 2021 22:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519174345.614467-1-linux@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/19/21 7:43 PM, Thomas Weißschuh wrote:
> Map them to KEY_MACRO# event codes.
> 
> These buttons are defined by HID as follows:
> "The user defines the function of these buttons to control software applications or GUI objects."
> 
> This matches the semantics of the KEY_MACRO# input event codes that Linux supports.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> 
> v1 -> v2: Only handle the 30 keys known

I'm no expert in this part of HID, so I'm not 100% sure this is correct,
with that said this looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
>  drivers/hid/hid-debug.c | 11 +++++++++++
>  drivers/hid/hid-input.c |  6 ++++++
>  2 files changed, 17 insertions(+)
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
> index 18f5e28d475c..32962772cb42 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -632,6 +632,12 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  				else
>  					code += BTN_TRIGGER_HAPPY - 0x10;
>  				break;
> +		case HID_CP_CONSUMER_CONTROL:
> +				if (code <= 29)
> +					code += KEY_MACRO1;
> +				else
> +					code += BTN_TRIGGER_HAPPY - 30;
> +				break;
>  		default:
>  			switch (field->physical) {
>  			case HID_GD_MOUSE:
> 
> base-commit: efd8929b9eec1cde120abb36d76dd00ff6711023
> 

