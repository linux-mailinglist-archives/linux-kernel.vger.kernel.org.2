Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5814133DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhIUNPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231658AbhIUNPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632230017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZhTULl+jFShkFTCmhPlPfzQ5OhoQqWmWp15VqWniPs=;
        b=hy62nZdGnel+ztRNCxexcK4/6UvZ+SQDi3YaaEc90UMzj5fH2/o58NhVeUuEkGbN929oEu
        zE05TTy2A8haPQ0Ujcs80qma62tDtF+J4cySUXONmlji+RDw1s9syA4S6Opljaoj5cfNVX
        r+rNLkYND8fue/jxLa474ktHiPUsYWk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-1R_fSGimOHit1s5XzqfiMQ-1; Tue, 21 Sep 2021 09:13:33 -0400
X-MC-Unique: 1R_fSGimOHit1s5XzqfiMQ-1
Received: by mail-ed1-f69.google.com with SMTP id s12-20020a05640217cc00b003cde58450f1so19089155edy.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 06:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BZhTULl+jFShkFTCmhPlPfzQ5OhoQqWmWp15VqWniPs=;
        b=5HPYtTIjkdmiXrYX7wdEUxljEuF1wuIbJAfIJFo/yNhPyEnFTZVw0KkcircDE9r9c2
         zRwAOZtUzR8X+N3pWJVirCAucZu2DAevbjMaL7neIgs2ZG96DFLwZSw/Okouuq3f0nAA
         mSJxPjxl4mntgOUfwMvfNvyukqOCyrwyMLg9pC4ZKJI/zaBHEOTH+qrvl0blcwwu8+ks
         A8Di1zm0WL2Dbo18bgvA7ys/5qC68lbl7aWKQaazQWTVvSBoybRvlww3L8jzddhkRqxB
         BwEXAMhQHr3ubwbKKJZcmKK87e5NA2m2KfFs3c8/sHgs9m44yPrZM1ZM2ENHlJoQ3dkW
         JRlQ==
X-Gm-Message-State: AOAM5311qImdM7JsZ15pv23GJ/Gy7zCfDUXckADrKg1trQUNwf9WfR3H
        S2JYxr3GfK6qgpd5NVaGtUTyqXNpl+RUz1NrH7grWNc78BlwXs4VXZRLNBdk01t2KPLNAIuwxH+
        rTptdmWhD6Iwq+l9kQjIXC4tp
X-Received: by 2002:a17:907:2632:: with SMTP id aq18mr35312887ejc.211.1632230012385;
        Tue, 21 Sep 2021 06:13:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz+CrkijFkmL0Zor4gUkBKBO84kpf5b57XecvMG87gQcgzHqmTrOs+vbOCvW/Xcdnn/SKyDw==
X-Received: by 2002:a17:907:2632:: with SMTP id aq18mr35312862ejc.211.1632230012053;
        Tue, 21 Sep 2021 06:13:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id la17sm7282350ejb.80.2021.09.21.06.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 06:13:31 -0700 (PDT)
Subject: Re: [PATCH] platform/x86/intel: hid: Add DMI switches allow list
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     alex.hung@canonical.com, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Gurtzick <magic@wizardtales.com>
References: <20210920160312.9787-1-jose.exposito89@gmail.com>
 <NgI8poho2fFBrbj2ivUSWphaZbwgMIxHVovWWqI2UWdJA8FNhlDtkFk-Y7cp4mYxiiOtkFQHoCQj-kkGh71lQfsvzJ1sg0IgixkJqdEdcnM=@protonmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ca5834c0-3456-bda8-36d8-becd8e1a2590@redhat.com>
Date:   Tue, 21 Sep 2021 15:13:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <NgI8poho2fFBrbj2ivUSWphaZbwgMIxHVovWWqI2UWdJA8FNhlDtkFk-Y7cp4mYxiiOtkFQHoCQj-kkGh71lQfsvzJ1sg0IgixkJqdEdcnM=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/20/21 8:43 PM, Barnabás Pőcze wrote:
> Hi
> 
> 
> 2021. szeptember 20., hétfő 18:03 keltezéssel, José Expósito írta:
>> Some devices, even non convertible ones, can send incorrect
>> SW_TABLET_MODE reports.
>>
>> Add an allow list and accept such reports only from devices in it.
>>
>> Bug reported for Dell XPS 17 9710 on:
>> https://gitlab.freedesktop.org/libinput/libinput/-/issues/662
>>
>> Reported-by: Tobias Gurtzick <magic@wizardtales.com>
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Tested-by: Tobias Gurtzick <magic@wizardtales.com>
>> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
>> ---
>>  drivers/platform/x86/intel/hid.c | 33 +++++++++++++++++++++++++++-----
>>  1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
>> index a33a5826e81a..24d26336e39a 100644
>> --- a/drivers/platform/x86/intel/hid.c
>> +++ b/drivers/platform/x86/intel/hid.c
>> @@ -118,6 +118,24 @@ static const struct dmi_system_id dmi_vgbs_allow_list[] = {
>>  	{ }
>>  };
>>
>> +/*
>> + * Some devices, even non convertible ones, can send incorrect SW_TABLET_MODE
>> + * reports. Accept such reports only from devices in this list.
>> + */
>> +static const struct dmi_system_id dmi_switches_auto_add_allow_list[] = {
>> +	{
>> +		.matches = {
>> +			DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "31" /* Convertible */),
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "32" /* Detachable */),
>> +		},
>> +	},
>> +	{} /* Array terminator */
>> +};
>> +
>>  struct intel_hid_priv {
>>  	struct input_dev *input_dev;
>>  	struct input_dev *array;
>> @@ -455,11 +473,16 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>>  	 *
>>  	 * See dual_accel_detect.h for more info on the dual_accel check.
>>  	 */
>> -	if (!priv->switches && !priv->dual_accel && (event == 0xcc || event == 0xcd)) {
>> -		dev_info(&device->dev, "switch event received, enable switches supports\n");
>> -		err = intel_hid_switches_setup(device);
>> -		if (err)
>> -			pr_err("Failed to setup Intel HID switches\n");
>> +	if (event == 0xcc || event == 0xcd) {
>> +		if (!dmi_check_system(dmi_switches_auto_add_allow_list))
>> +			return;
> 
> I think you should not check it every time. Maybe add a `bool` member
> to `struct intel_hid_priv`. Or maybe better: rename `dual_accel` to something like
> `autodetect_switch` and initialize it with `!dual_accel_detect() && dmi_check_system(...)`.

These events don't happen all that often. But this still is a good suggestion.

Since this is a regression fix of sorts I've gone ahead and made the suggested
changes myself (keeping José as author) and I've applied this to my tree,
see the version in the review-hans branch to see what the merged version
looks like.

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I will also add this to the pdx86 fixes branch and include it in my
next pdx86-fixes for 5.15 pull-req to Linus.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> 
> 
>> +
>> +		if (!priv->switches && !priv->dual_accel) {
>> +			dev_info(&device->dev, "switch event received, enable switches supports\n");
>> +			err = intel_hid_switches_setup(device);
>> +			if (err)
>> +				pr_err("Failed to setup Intel HID switches\n");
>> +		}
>>  	}
>>
>>  	if (priv->wakeup_mode) {
>> --
>> 2.25.1
>>
>>
> 
> 
> Regards,
> Barnabás Pőcze
> 

