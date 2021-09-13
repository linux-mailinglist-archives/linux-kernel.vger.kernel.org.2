Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873A1408F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbhIMNoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243177AbhIMNiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631540228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjFYHg65tqjKEZiKvQMDCUW4YwiT0ZdGTDTVBXYGaW0=;
        b=RIqz+o0PFv1O6y979mlOiyKy7t1IwLHlCAK9WtIxxXzzU7B1xnPetU5NbqCsSq1HMy1wIi
        nTfI+AAFJCodwNHr/pPZvo0ALI9QVOAqWjxf9tE5YthhupetOCxzh0nYb9PN55mQBep+vh
        6pvDgehuZlnGgw9G9MBkZBEPNaFmRVw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-1xPIGvN1OHSBBt4-Fw1moA-1; Mon, 13 Sep 2021 09:37:07 -0400
X-MC-Unique: 1xPIGvN1OHSBBt4-Fw1moA-1
Received: by mail-ed1-f70.google.com with SMTP id bf22-20020a0564021a5600b003c86b59e291so4930269edb.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bjFYHg65tqjKEZiKvQMDCUW4YwiT0ZdGTDTVBXYGaW0=;
        b=z3BGrnu4EBLpuMofrDqDWDTLSE2L97PWXaVRAALYfhiStbZqJ+JaaNHlx8n/2vbXtg
         McQUioxu/+eCtUOSGR9Xtq55KL5/qrlJj0UqyVnXK4JHLNMSH9SbOVQqL5MOlLQs2ZUX
         CUSWE76IZEixRGra6NEMCrY+BV7No/VPyUMZPdHBC9lg+OlmyQyUGOZagAnuVCnaT4Mi
         pAeYN0+2mo1fNsnawtq/gZNYbK6+Do54kh7tWmMXbRdKOt5hrR1dA6hy0GtTmPToXuad
         qxcvxHudTS9wt6pBrP97Z1AYwRP7dTG+Phy3szhwDumgJCVOm7AWKxIC5koq/bbhWOhC
         3X6g==
X-Gm-Message-State: AOAM532umHp7zAs0Gp20BApVCpYjmijw0uloDKsU7W84XBoQcbtCupPR
        5GkeFP9bAUKo2kdX00nmKIO8ZwYaCoZihnokK307Kre8p6rZTJRs9GF/zF0Z+O3kO9jhQcJLKxg
        Ix9+60i589rvClC3P9ShGUeYeRRBLNDv+9lZj3DN72Yf1EZ6PIusaCPUy2JwvgbKkiITn3/4yj5
        Gj
X-Received: by 2002:a17:906:2345:: with SMTP id m5mr806426eja.557.1631540225649;
        Mon, 13 Sep 2021 06:37:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz69ArpVr5fjX6Qv/alZZF0AteWRQzT/mCPlyPxjrPJNBDptBfIFDgcECjVPZ1ZMhYgePGXoA==
X-Received: by 2002:a17:906:2345:: with SMTP id m5mr806401eja.557.1631540225390;
        Mon, 13 Sep 2021 06:37:05 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id x13sm3469083ejv.64.2021.09.13.06.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 06:37:04 -0700 (PDT)
Subject: Re: [PATCH] acer-wmi: use __packed instead of __attribute__((packed))
To:     Jules Irenge <jbi.octave@gmail.com>, jlee@suse.com
Cc:     mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210912011741.30495-1-jbi.octave@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <caff24a5-f6ef-edb6-2b0b-0411fadb2e8f@redhat.com>
Date:   Mon, 13 Sep 2021 15:37:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210912011741.30495-1-jbi.octave@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/12/21 3:17 AM, Jules Irenge wrote:
> checkpatch.pl tool warns about using __attribute__((packed))
> "WARNING: __packed is preferred over __attribute__((packed))"
> To fix this __attribute__((packed)) is replaced by __packed
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/acer-wmi.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 694b45ed06a2..9c6943e401a6 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -138,7 +138,7 @@ struct event_return_value {
>  	u16 reserved1;
>  	u8 kbd_dock_state;
>  	u8 reserved2;
> -} __attribute__((packed));
> +} __packed;
>  
>  /*
>   * GUID3 Get Device Status device flags
> @@ -172,33 +172,33 @@ struct func_input_params {
>  	u8 app_status;          /* Acer Device Status. LM, ePM, RF Button... */
>  	u8 app_mask;		/* Bit mask to app_status */
>  	u8 reserved;
> -} __attribute__((packed));
> +} __packed;
>  
>  struct func_return_value {
>  	u8 error_code;          /* Error Code */
>  	u8 ec_return_value;     /* EC Return Value */
>  	u16 reserved;
> -} __attribute__((packed));
> +} __packed;
>  
>  struct wmid3_gds_set_input_param {     /* Set Device Status input parameter */
>  	u8 function_num;        /* Function Number */
>  	u8 hotkey_number;       /* Hotkey Number */
>  	u16 devices;            /* Set Device */
>  	u8 volume_value;        /* Volume Value */
> -} __attribute__((packed));
> +} __packed;
>  
>  struct wmid3_gds_get_input_param {     /* Get Device Status input parameter */
>  	u8 function_num;	/* Function Number */
>  	u8 hotkey_number;	/* Hotkey Number */
>  	u16 devices;		/* Get Device */
> -} __attribute__((packed));
> +} __packed;
>  
>  struct wmid3_gds_return_value {	/* Get Device Status return value*/
>  	u8 error_code;		/* Error Code */
>  	u8 ec_return_value;	/* EC Return Value */
>  	u16 devices;		/* Current Device Status */
>  	u32 reserved;
> -} __attribute__((packed));
> +} __packed;
>  
>  struct hotkey_function_type_aa {
>  	u8 type;
> @@ -210,7 +210,7 @@ struct hotkey_function_type_aa {
>  	u16 display_func_bitmap;
>  	u16 others_func_bitmap;
>  	u8 commun_fn_key_number;
> -} __attribute__((packed));
> +} __packed;
>  
>  /*
>   * Interface capability flags
> 

