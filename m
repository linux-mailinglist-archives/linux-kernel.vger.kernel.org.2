Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65623FAC7C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 17:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhH2PS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhH2PS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:18:57 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B08CC061575;
        Sun, 29 Aug 2021 08:18:05 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id n27so17017343oij.0;
        Sun, 29 Aug 2021 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sbgY53rxu2C/Bzp1Fq3Hlx4nUgLjjGXWejXFRVYrqhw=;
        b=P2xhmBc4+k9rU4F3yTt6/j1+VZCULGBkfOOtIKLdppfm3JBlItxbfq1uo0/4lXEj8b
         6i9m8/8YEieVLDu/kxQ55blgNT+1wwFXF1EXvEmsjFGWKKnzvcnzw3uA8IeNeffzTs2E
         h8KHudv9WasZlWYbxD5atF074Alcdo0qgf3utDOQvzQbRtjaMHmlfbxkh6sHX0w6Ctsi
         6tjnpsDLHgipQP6YP2bSWfWa5U/uEryDTrAbnpSI39+opegZi1HP9qy1SlX9k63zOTqM
         VWDZxxInySBOXe5iNlJlntUvae1GIqYWe9hb0lgFJSUEjZ5WFTd+TGUs47+tIn6pLF3c
         51Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sbgY53rxu2C/Bzp1Fq3Hlx4nUgLjjGXWejXFRVYrqhw=;
        b=DbK7s0tiKGI58zmiYXhyZhwkHAduZIo4g25ohgxMPhe4ZSpuBTGhFl/J7rS0ICDN49
         nzFSpNqKeLPrsxU7XsLFK3NBa4ANe/IWAxScYq6cnIaf03PVhT3/6+o1uCZCkCFckfCg
         ETaUJGYWjv641nlSItjBdtzbMlN/VMSNeeSsNqyxNg0ur3yttxDELpNFWbhoyK985MYe
         NSjHMNJ3DrJ+q847MH0E8N5N3jqwzAyOJzVGbKrodlZn4W+3D0ALhOm/f4+hMl3sJu0j
         aZk3mFwGL3IvSJfaKsYzpf79j2sOeEsjsH6HbExXSkb5F6Qa+Xg2sz10hyB+TO0p8K2O
         GUyw==
X-Gm-Message-State: AOAM533ayhEk96ahUuOveETtm1OSJ6U2Tnlw/6xjk/WcvtUw9/624Ehu
        t2JeJVtQc22ih7hXUHOx0VGa/GwJOuM=
X-Google-Smtp-Source: ABdhPJyb2Ut2IjTAb/bfrFeYaDBMs3C+cpNS7YKc2KKgmXQobV/OxuwwKTpZ0wTKs03x3O5EHD9nEQ==
X-Received: by 2002:a54:4189:: with SMTP id 9mr20687971oiy.45.1630250284257;
        Sun, 29 Aug 2021 08:18:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c7sm2622446otm.27.2021.08.29.08.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 08:18:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Luke Jones <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, pobrn@protonmail.com,
        platform-driver-x86@vger.kernel.org
References: <20210829071402.576380-1-luke@ljones.dev>
 <cf42ddd7-29ed-ff8b-7d03-958187863b70@redhat.com>
 <RLILYQ.0GH3JY7UCTPI2@ljones.dev>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 0/1] asus-wmi: Add support for custom fan curves
Message-ID: <2af6628e-118f-6a75-8074-2f4144c7f8e7@roeck-us.net>
Date:   Sun, 29 Aug 2021 08:18:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <RLILYQ.0GH3JY7UCTPI2@ljones.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/21 3:03 AM, Luke Jones wrote:
> 
> 
> On Sun, Aug 29 2021 at 11:57:55 +0200, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi Luke,
>>
>> On 8/29/21 9:14 AM, Luke D. Jones wrote:
>>>  Add support for custom fan curves found on some ASUS ROG laptops.
>>>
>>>  - V1
>>>    + Initial patch work
>>>  - V2
>>>    + Don't fail and remove wmi driver if error from
>>>      asus_wmi_evaluate_method_buf() if error is -ENODEV
>>>  - V3
>>>    + Store the "default" fan curves
>>>    + Call throttle_thermal_policy_write() if a curve is erased to ensure
>>>      that the factory default for a profile is applied again
>>>  - V4
>>>    + Do not apply default curves by default. Testers have found that the
>>>      default curves don't quite match actual no-curve behaviours
>>>    + Add method to enable/disable curves for each profile
>>>  - V5
>>>    + Remove an unrequired function left over from previous iterations
>>>    + Ensure default curves are applied if user writes " " to a curve path
>>>    + Rename "active_fan_curve_profiles" to "enabled_fan_curve_profiles" to
>>>      better reflect the behavious of this setting
>>>    + Move throttle_thermal_policy_write_*pu_curves() and rename to
>>>      fan_curve_*pu_write()
>>>    + Merge fan_curve_check_valid() and fan_curve_write()
>>>    + Remove some leftover debug statements
>>>  - V6
>>>    + Refactor data structs to store  array or u8 instead of strings.
>>>      This affects the entire patch except the enabled_fan_curves block
>>>    + Use sysfs_match_string in enabled_fan_curve block
>>>    + Add some extra comments to describe things
>>>    + Allow some variation in how fan curve input can be formatted
>>>    + Use SENSOR_DEVICE_ATTR_2_RW() to reduce the amount of lines per
>>>      fan+profile combo drastically
>>
>> Thank you for your continued work on this. I read in the discussin of v5
>> that you discussed using the standard auto_point#_pwm, auto_point#_temp
>> pairs. I see here that you have decided to not go that route, may I ask
>> why ?
> 
> Sure, primary reason is because the RPM for the fans is in percentage so it didn't really make sense to me to use that format.
> 
> Also if the max for that is 255 then I'd need to introduce scaling to make match what the ACPI method expects (max 100). But yeah, auto_point#_pwm changes the meaning.
> 

Bad argument. That is true for other controllers as well. You could
just scale it up and down as needed.

The whole point of an ABI is that it is standardized.
If others would [be permitted to] follow your line of argument,
we would not have a useful ABI because "my chip provides/needs
data in some other format".

Guenter
