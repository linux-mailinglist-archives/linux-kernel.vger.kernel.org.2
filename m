Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5DB452E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhKPKFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233748AbhKPKFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637056958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aiZm/l8h1t+i6C/1lnIe2TWJtuPljKczLdv4k7NCKi8=;
        b=MEi/ClAf/dI8nTeq24sHS3CEPw5A7OeBq0U/gwzl1eIP/BN0HeC1C5t3uXA5KX5sxuLsGX
        0KfWbwiwxlo/q5JFp+MzFWjGWYogHrOgkGgsy3h/omPtBc6elSDRqmhcdUk3EgENrnQRi2
        MSZmIR22TqDZEoyqY7DW4+lZb6Yo9mg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-MAWfLnpqPJCcteTNxuR8aw-1; Tue, 16 Nov 2021 05:02:32 -0500
X-MC-Unique: MAWfLnpqPJCcteTNxuR8aw-1
Received: by mail-ed1-f69.google.com with SMTP id b15-20020aa7c6cf000000b003e7cf0f73daso4365205eds.22
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aiZm/l8h1t+i6C/1lnIe2TWJtuPljKczLdv4k7NCKi8=;
        b=QVeB0PpLqzgbAV29/cYTTTNyuBI4+pLrhUfiWzyspueR1KsAiYagQZ6gvYRwlEhSyu
         ayO4MFMk5I9ntACH1krO9LRn1v8wg8Esw4UyZ5MfAVq7ufNXfGsZPYJe91vZIkr3vbvB
         hMvfvmW4hr6VEbA5fXQehp3mPx4P9XKNZTkhBnfu6O5X2SGYbEZkDk55584Er1tJaxWW
         ZesvDAoQROs6x4UOGPak8tu/Fp5Ep5lFQjsdgEiF2LXzXuzH4sHUioW7FvF6/r/Q/waf
         dHtLYiz9sAKGgfE87fgUUcZDIKNo6bxx9ClZ2hrq3FueNbHiQqdJpa1vUY3ucYPFxGsZ
         TWJw==
X-Gm-Message-State: AOAM531thKZQmwm82/5DLumaAtfCXOHbnIAct8Xsr9/AVHffBLClBuWO
        HCeXQkkZV8FDlFoN+vr5HO3mdVD2dTtbZ/crmYZu6wPWzWFbphDnBMChWUiVdunjVj6BIbnnWqQ
        MyrLf8mvs1/JMkAyZz1yMa29L
X-Received: by 2002:a17:907:97d4:: with SMTP id js20mr8391801ejc.416.1637056951165;
        Tue, 16 Nov 2021 02:02:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykAzOBUSb2LJ/7bdebJJCjkz2v8g3ph4oaTOtIeGHv5vCbF1lDBEi5ZOVkbHgvK5dyfr40JQ==
X-Received: by 2002:a17:907:97d4:: with SMTP id js20mr8391771ejc.416.1637056951022;
        Tue, 16 Nov 2021 02:02:31 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g21sm7954974ejt.87.2021.11.16.02.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:02:29 -0800 (PST)
Message-ID: <cdcea26c-b780-92fc-0e42-be52d9a5a5c5@redhat.com>
Date:   Tue, 16 Nov 2021 11:02:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] Fix WWAN device disabled issue after S3 deep
Content-Language: en-US
To:     Slark Xiao <slark_xiao@163.com>
Cc:     hmh@hmh.eng.br, mgross@linux.intel.com, markpearson@lenovo.com,
        njoshi1@lenovo.com, ibm-acpi-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20211108060648.8212-1-slark_xiao@163.com>
 <b3523a57-a21e-80ca-561d-23f6ee89913d@redhat.com>
 <7821731c.1990.17d02723fb6.Coremail.slark_xiao@163.com>
 <350a209b.242b.17d2779c109.Coremail.slark_xiao@163.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <350a209b.242b.17d2779c109.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/16/21 07:40, Slark Xiao wrote:
> 
> 
> 
> At 2021-11-09 10:06:21, "Slark Xiao" <slark_xiao@163.com> wrote:
>>
>>
>> At 2021-11-08 22:32:56, "Hans de Goede" <hdegoede@redhat.com> wrote:
>>> Hi,
>>>
>>> On 11/8/21 07:06, Slark Xiao wrote:
>>>> When WWAN device wake from S3 deep, under thinkpad platform,
>>>> WWAN would be disabled. This disable status could be checked
>>>> by command 'nmcli r wwan' or 'rfkill list'.
>>>>
>>>> Issue analysis as below:
>>>>   When host resume from S3 deep, thinkpad_acpi driver would
>>>> call hotkey_resume() function. Finnaly, it will use
>>>> wan_get_status to check the current status of WWAN device.
>>>> During this resume progress, wan_get_status would always
>>>> return off even WWAN boot up completely.
>>>>   In patch V2, Hans said 'sw_state should be unchanged
>>>> after a suspend/resume. It's better to drop the
>>>> tpacpi_rfk_update_swstate call all together from the
>>>> resume path'.
>>>>   And it's confimed by Lenovo that GWAN is no longer
>>>>  available from WHL generation because the design does not
>>>>  match with current pin control.
>>>>
>>>> Signed-off-by: Slark Xiao <slark_xiao@163.com>
>>>
>>> Thanks, patch looks good to me:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> I will merge this once 5.16-rc1 is out.
>>>
>>> Regards,
>>>
> Hi Hans,
>   5.16-rc1 is already out. Could you help merge this patch into baseline now?

5.16-rc1 has only been out for 1 day, some patience please!

But yes I plan to send a fixes pull-req to Linus later today
including this fix.

Regards,

Hans




>>>> ---
>>>>  drivers/platform/x86/thinkpad_acpi.c | 12 ------------
>>>>  1 file changed, 12 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>>>> index 50ff04c84650..f1cbd27282e1 100644
>>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>>> @@ -1178,15 +1178,6 @@ static int tpacpi_rfk_update_swstate(const struct tpacpi_rfk *tp_rfk)
>>>>  	return status;
>>>>  }
>>>>  
>>>> -/* Query FW and update rfkill sw state for all rfkill switches */
>>>> -static void tpacpi_rfk_update_swstate_all(void)
>>>> -{
>>>> -	unsigned int i;
>>>> -
>>>> -	for (i = 0; i < TPACPI_RFK_SW_MAX; i++)
>>>> -		tpacpi_rfk_update_swstate(tpacpi_rfkill_switches[i]);
>>>> -}
>>>> -
>>>>  /*
>>>>   * Sync the HW-blocking state of all rfkill switches,
>>>>   * do notice it causes the rfkill core to schedule uevents
>>>> @@ -3129,9 +3120,6 @@ static void tpacpi_send_radiosw_update(void)
>>>>  	if (wlsw == TPACPI_RFK_RADIO_OFF)
>>>>  		tpacpi_rfk_update_hwblock_state(true);
>>>>  
>>>> -	/* Sync sw blocking state */
>>>> -	tpacpi_rfk_update_swstate_all();
>>>> -
>>>>  	/* Sync hw blocking state last if it is hw-unblocked */
>>>>  	if (wlsw == TPACPI_RFK_RADIO_ON)
>>>>  		tpacpi_rfk_update_hwblock_state(false);
>>>>

