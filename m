Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44D834332F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 16:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhCUPdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 11:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhCUPdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 11:33:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8A3C061574;
        Sun, 21 Mar 2021 08:33:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so7261869pjb.0;
        Sun, 21 Mar 2021 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r0U+DE5qJnTQ3kRfYyrwXQg8XIU2gEf2QfD79ym1R0w=;
        b=jmsLkoprnq3UaqjBElrMeEuK8b4+TsJRFDQRTuxjudHG8ZID8h/sUFgSLHhsUE+dgT
         aDJy6OGfmHm8O8vrryASEbyTR230Eu/ceEgEF8wBvf4KA9MdDulPIa4RqQX+6jmnkdbf
         wn+b4uP7sgBa+ai4nY9mSb5qlLNoNrKiNcjDD6pphq8lhmjaCDVQFAFfLHS06GDpctu/
         bzqDjObi+vSqI2Plsp5B0zsd4JyKxuHP+BCeHI/LNw0PEwHBvMBUGGodcZrLqxEy+f1d
         YbZhth/fpLtxiXm0p1YDU2YDd+NKoAGOoqdfRDxvqBP7D8+CRw0jECqWe0M7eHzEc49y
         cLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r0U+DE5qJnTQ3kRfYyrwXQg8XIU2gEf2QfD79ym1R0w=;
        b=jSGAXPr+AUDSQTAWv4TGpn/v+RUAlo1g2TOq76EFWwg3/KgEjM058s/0XHQgoIxWqL
         7cHjqc5WZx9BoEtYiQFI7UBV3QSqaHWOWEvGnC55M/c3dWPpsKHpm1RurSvj91KTr0EF
         n+Ug+ZLCUt4yAzUFjSm8fahpTuthanLJsCuApATOMZ3Jedy6uq++df960YXQiyOk8uaO
         MtK6Gi9G31K6il8jZFwCe7HkA5XPvlbq1e/M80wh4781gsynLvl6wRWB/cb7cXoNDmIl
         y8QKIDuBHU9VSAwBavtWKdmqPrso5OfuqpGKgVwRvHOhTYUSXZQggpunFt25BHAeXlA9
         LqVw==
X-Gm-Message-State: AOAM5337K556KYlALhirJEC98MdbReThIRbdbEj5K7xYjM49u5Cxlg3q
        JZMFQK6+BGidynpsP6TwjBfLyQ1xaUWwGZs4
X-Google-Smtp-Source: ABdhPJy2FjTJgTxZ6mjw3gj3pZU3EwRWc+4AKQqVeap+HoBd1ehxo6/2TdsRbKI/UOdAuBL8dlNxzQ==
X-Received: by 2002:a17:902:7407:b029:e4:9645:fdf6 with SMTP id g7-20020a1709027407b02900e49645fdf6mr23266820pll.19.1616340780571;
        Sun, 21 Mar 2021 08:33:00 -0700 (PDT)
Received: from [0.0.0.0] ([38.84.76.15])
        by smtp.gmail.com with ESMTPSA id d14sm11184315pji.22.2021.03.21.08.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 08:33:00 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Yuan, Perry" <Perry.Yuan@dell.com>,
        "pobrn@protonmail.com" <pobrn@protonmail.com>,
        "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210301093753.16300-1-Perry_Yuan@Dell.com>
 <551e30d2-0211-f3cb-fbb8-ee5b2f22a851@linux.intel.com>
 <SJ0PR19MB4528E7C88C955D2EE96CE3B484939@SJ0PR19MB4528.namprd19.prod.outlook.com>
 <ab14a0b2-3f3a-3796-8baf-76e635d82340@linux.intel.com>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <58d2e2f2-e552-6ecf-b1c3-bf38ad5d2e35@gmail.com>
Date:   Sun, 21 Mar 2021 23:32:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ab14a0b2-3f3a-3796-8baf-76e635d82340@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre:
Thanks for your review!
On 2021/3/8 23:59, Pierre-Louis Bossart wrote:
> 
> 
> 
>>>>    module_param(force_rfkill, bool, 0444);
>>>>    MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted
>>>> models");
>>>>
>>>> +
>>>
>>> spurious line change
>> I just want to make them separate with more space .
>> If it cause concern, I will remote the line in V5.
> 
> it's fine to improve spaces/alignment, just do it in a separate patch.
> 
>>
>>>
>>>>    static const struct dmi_system_id dell_device_table[] __initconst 
>>>> = {
>>>>        {
>>>>            .ident = "Dell laptop",
>>>> @@ -2205,11 +2209,17 @@ static int __init dell_init(void)
>>>>        dell_laptop_register_notifier(&dell_laptop_notifier);
>>>>
>>>>        if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
>>>> -        dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
>>>> -        micmute_led_cdev.brightness =
>>> ledtrig_audio_get(LED_AUDIO_MICMUTE);
>>>> -        ret = led_classdev_register(&platform_device->dev,
>>> &micmute_led_cdev);
>>>> -        if (ret < 0)
>>>> -            goto fail_led;
>>>> +
>>>     dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
>>>
>>> not sure why you changed the alignment?
>> The previous alignment is a little not correct.
>> So I adjust it
>> If it cause concern, will restore it to original shape.
> 
> same here, use a different patch.
> 
As you suggested,I should add the alignment change in another patch.
But if i keep the old alignment, the code will be very odd.
Seems like that I have to change the below code to new alignment in this 
patch.

if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
     dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) { <<--- changed back
	if (!privacy_valid)
	    	has_privacy = true;
	else
	    	has_privacy = false;
	if (!has_privacy) {
		micmute_led_cdev.brightness <<----------- new alignment
		...
	}
...
}


