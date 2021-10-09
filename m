Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021C3427B80
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 17:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhJIPwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 11:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhJIPwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:52:12 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE02C061570;
        Sat,  9 Oct 2021 08:50:16 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so15403858otb.10;
        Sat, 09 Oct 2021 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JMVUxn512Tfe+t4BKLTuIbM7ZEEL6xwwLQvWXKN58Uc=;
        b=mHvc2Ht4xyUaO4+T5NLjfL5+6NFv1GAkzatd59MKWqa70sLiGuTYBkYVKjzgooE4lV
         9fYQoX8OxaTHchBXobOwYvwIbEkT/m362aUFcLs/frmB0GGz+Bc+uIZSO9deOOO5nF8n
         FYFOvhQnjHC2QhzmzVZGVF2Z9yEK857AONfSDwoXJNsydXv8Wrl3D8sSeABlwggAtJ56
         MgNEpZNvpv/IubCm2Y+WafOB7fhlTv6FJrH7Ooc2PO9YT9F6tC3k8PRTlVHHcaiYHalR
         VrA/du3xhGJSHCL++g0wuOMqlBBolk6Tc17SAApHoGyY7QiwQfQE3xN+inZXzD4ChL1q
         ZX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JMVUxn512Tfe+t4BKLTuIbM7ZEEL6xwwLQvWXKN58Uc=;
        b=aOZylGYQ6ysQ5TXcce1ktoZanv4gho3wlBc/N4dtcdCKU1KAru3q929CxQoJ3yAFMc
         Phxr2gMpzsG7igbwXAYtBL5LRlw/SpmE5fn1pagbAbXdAjhHeNnDpZKk5i+iuaoGcrCv
         KwpNnbf5Hwmkh9GKwyxx23jyyUcWp5MZJVtzatEYEsmwPWv3ziU3UcoVF0YF+43Ja3jR
         SE/nS5NlWr4VdxpDBN4PiVCsw2VnXwllMHjAXMOKGGhsuS8jsABAcu+S6NIVZb5M1ljy
         a/kbcqa4VMIQGbh1ezewaa853RMXkhD5BwhhaIAojhU++Lyp1DwA3GAbbZHDfueutDv6
         H0vQ==
X-Gm-Message-State: AOAM530NtU2y1D1yThX1SdVwxcqT17q4oCd8ZT0+WZHozA1/xyC6YwQq
        CqAg3AI6Ibl2Dck6q20FqOBTT9EeOZE=
X-Google-Smtp-Source: ABdhPJxMirTwuQLEVUw64sE7/Ga4CN/r1MlwBVxZfFk75niQyaoL5AghA+KVXjP3MLgaXJLIbLTg/A==
X-Received: by 2002:a9d:17c5:: with SMTP id j63mr14044004otj.191.1633794615090;
        Sat, 09 Oct 2021 08:50:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t6sm503959ooa.27.2021.10.09.08.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 08:50:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Oskar Senft <osk@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211009025858.3326725-1-osk@google.com>
 <20211009025858.3326725-2-osk@google.com>
 <0674a2d0-f0a2-d6bc-33e3-483614602bae@roeck-us.net>
 <CABoTLcTL42a23=P501UoqNWr76A3fmEoxwjymz1-g0MNMyYPRA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 2/2] hwmon: (nct7802) Make temperature sensors
 configurable.
Message-ID: <fb878fce-8fa1-36b0-fa30-013d571563ee@roeck-us.net>
Date:   Sat, 9 Oct 2021 08:50:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABoTLcTL42a23=P501UoqNWr76A3fmEoxwjymz1-g0MNMyYPRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/21 7:50 AM, Oskar Senft wrote:
> Hi Guenter
> 
> Thanks for the review!
> 
>>> +     return sprintf(buf, "%u\n",
>>> +                     ((mode >> MODE_BIT_OFFSET_RTD(sattr->index)) &
>>> +                             MODE_RTD_MASK) + 2);
>>
>> Please split into two patches to simplify review. The changes from
>> constant to define are logically separate and should thus be in a
>> separate patch.
> Ok, will do.
> 
>>> +     if (index >= 30 && index < 38 &&                        /* local */
>>> +         (reg & MODE_LTD_EN) != MODE_LTD_EN)
>>
>> This is just a single bit, so "!(reg & MODE_LTD_EN)" is sufficient.
> Ack.
> 
>>> +static bool nct7802_get_input_config(struct device *dev,
>>> +     struct device_node *input, u8 *mode_mask, u8 *mode_val)
>>
>> Please align continuation lines with "(".
> Oh, even if that would result in a lot of extra lines? Or just start
> the first argument on a new line?
> 

I sincerely doubt that will happen with the 100-column limit,
but yes unless it really doesn't work.

>> The function should return an error code.
> Ok, I'll look into that.
> 
>>> +     if (reg >= 1 && reg <= 3 && !of_device_is_available(input)) {
>>
>> reg will always be >=1 and <=3 here.
> Good catch!
> 
>>> +             *mode_val &= ~(MODE_RTD_MASK
>>> +                     << MODE_BIT_OFFSET_RTD(reg-1));
>>
>> space around '-'
> Oh yeah, I'm sorry. Is there a code formatter I should have run? I did
> run "checkpatch.pl", hoping that it would catch those.
> 
For some reason checkpatch doesn't always catch this.

>>> +             *mode_mask |= MODE_RTD_MASK
>>> +                     << MODE_BIT_OFFSET_RTD(reg-1);
>>
>> Unnecessary continuation lines. There are several more of those;
>> I won't comment on it further. Please only use continuation lines if
>> the resulting line length is otherwise > 100 columns.
> Argh, yeah. After refactoring that function, I thought I caught all of
> them, but obviously I didn't. According to [1] we should stay within
> 80 columns (and use tabs that are 8 spaces wide). I assume that still
> applies? The rest of this code follows that rule.
> 

 From checkpatch, commit bdc48fa11e46 ("checkpatch/coding-style:
deprecate 80-column warning"):

     Yes, staying withing 80 columns is certainly still _preferred_.  But
     it's not the hard limit that the checkpatch warnings imply, and other
     concerns can most certainly dominate.

I prefer readability over the 80 column limit.

>>> +     if (dev->of_node) {
>>> +             for_each_child_of_node(dev->of_node, input) {
>>> +                     if (nct7802_get_input_config(dev, input, &mode_mask,
>>> +                                     &mode_val))
>>> +                             found_input_config = true;
>>
>> This is mixing errors with "dt configuration does not exist".
>> nct7802_get_input_config() should return an actual error if the
>> DT configuration is bad, and return that error to the calling code
>> if that is the case.
> Ok, I'll change that. I wasn't sure whether we'd rather configure "as
> much as we can" or fail completely without configuring anything. Shall
> we allow all of the configuration to be validated before erroring out?

No, bail out on the first error.

> That would make it easier to get the DT right in one pass, but makes
> the code more complicated.
> 
>>> +     if (!found_input_config) {
>>> +             /* Enable local temperature sensor by default */
>>> +             mode_val |= MODE_LTD_EN;
>>> +             mode_mask |= MODE_LTD_EN;
>>> +     }
>>
>> This can be set by default since nct7802_get_input_config()
>> removes it if the channel is disabled, meaning found_input_config
>> is really unnecessary.
> Ok. Should we actually phase out the "LTD enabled by default"
> completely? Or is that for a future change?
> 

Why ? That would change code behavior and would be unexpected.
Just initialize mode_val and mode_mask variables with MODE_LTD_EN.

Thanks,
Guenter
