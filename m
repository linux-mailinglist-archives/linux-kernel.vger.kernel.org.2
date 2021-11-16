Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9FC453436
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbhKPOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhKPOfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:35:11 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB41C061570;
        Tue, 16 Nov 2021 06:32:14 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id n66so42775063oia.9;
        Tue, 16 Nov 2021 06:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rS3gt/PrpWVtv6gSE0O41JGuk3vZ4MHqtZq926OB300=;
        b=UADwpeAkTgvpK7nOuk2G48YW3G/+Uf/gOpLQbb6XCf5oUBcx2+R5PzC3gL/evmYPNR
         5JGfkcPldpx3SecDK//+YMFfLVk+7R+g59Iq1YxQYRbbf47MXVljhiD901x4yQ5pP1YM
         ezrbI+jRnaHDeDU1PK0M/fRXL5ho6hnxS38cjMV2Tz45avk4O9ueFaP5p/QnJNRtJZqU
         +r8j55qjLAT2yjYXBomt2D8uoLDuP1uqUDhs/HzuylBwUx9T9oONDe9w7YsXRR+mOv1Z
         wu260OTIAEQ5Z0D6gIUwb/4sMhCgCI9PZ/Z6fVUv6pjZKgaxefk4xcQwbdvO+moWLFrv
         rPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rS3gt/PrpWVtv6gSE0O41JGuk3vZ4MHqtZq926OB300=;
        b=cW1Ha5jF/3csBfDunbFbnG7RtSTH1M6DI1cDvh6OIi/8rRVvUJrhK4cjKrr4nfoxsP
         lj+9jBZVwubc75w2tftVlOC4F4Bphah0AE2z8qGKe9M+qVpl5bktyv7Ds4oq0huLRMF5
         sHnqROFUcX/0BkGT6tSEmgf0knqPxEZ8BEL6VYK54oPcB5r0GYBTK4PjXHpzwlQzMIvs
         ivZ+CZAxYQYq9rBRPympHOjXGf1vOreP98gJm9FpT76UDEgu+5bYiwAkz3UuF3BYx/wb
         mII4ou6el5/mjjI6WI64lD9uAIN+Wv/hyibHVbge0eEyfgRc8o3zlkF8QKyo5i9jP8pz
         yyZg==
X-Gm-Message-State: AOAM5305IvYWR1L6ovfnJQ+J+lTuxnsvOtFPEeXE2oXU/qWjC6eaaGfp
        aQOtDNYswsHeLzOhHb7byJ96qw1tQAI=
X-Google-Smtp-Source: ABdhPJxuVAwopYOnPTh16WP55elWLlT/bUaZv8sU1w35lJhls+Z4ingK+OqWwORbeJm83MrWoKXdKw==
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr6588480oil.166.1637073133697;
        Tue, 16 Nov 2021 06:32:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t14sm781860oth.81.2021.11.16.06.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 06:32:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v11 0/2] Update ASUS WMI supported boards
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211115210842.11972-1-pauk.denis@gmail.com>
 <CAHp75VcPHi1XyZr=CFbUhiUXK0q-10iBx5U3d==aG8pMG27k1Q@mail.gmail.com>
 <c016d0ca-b8b1-fb06-50f3-06a7b1c4aaea@roeck-us.net>
 <YZOKLDg582dQPzVN@smile.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d2943033-e701-f719-5da6-c00dc431dff9@roeck-us.net>
Date:   Tue, 16 Nov 2021 06:32:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZOKLDg582dQPzVN@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 2:38 AM, Andy Shevchenko wrote:
> On Mon, Nov 15, 2021 at 03:15:39PM -0800, Guenter Roeck wrote:
>> On 11/15/21 2:01 PM, Andy Shevchenko wrote:
>>> On Mon, Nov 15, 2021 at 11:09 PM Denis Pauk <pauk.denis@gmail.com> wrote:
>>>>
>>>> Add support by WMI interface provided by Asus for B550/X570 boards:
>>>> * PRIME X570-PRO,
>>>> * ROG CROSSHAIR VIII HERO
>>>> * ROG CROSSHAIR VIII DARK HERO
>>>> * ROG CROSSHAIR VIII FORMULA
>>>> * ROG STRIX X570-E GAMING
>>>> * ROG STRIX B550-I GAMING
>>>> * ROG STRIX B550-E GAMING
>>>>
>>>> Add support by WMI interface provided by Asus for X370/X470/
>>>> B450/X399 boards:
>>>> * ROG CROSSHAIR VI HERO,
>>>> * PRIME X399-A,
>>>> * PRIME X470-PRO,
>>>> * ROG CROSSHAIR VI EXTREME,
>>>> * ROG CROSSHAIR VI HERO (WI-FI AC),
>>>> * ROG CROSSHAIR VII HERO,
>>>> * ROG CROSSHAIR VII HERO (WI-FI),
>>>> * ROG STRIX Z390-F GAMING
>>>> * ROG STRIX B450-E GAMING,
>>>> * ROG STRIX B450-F GAMING,
>>>> * ROG STRIX B450-I GAMING,
>>>> * ROG STRIX X399-E GAMING,
>>>> * ROG STRIX X470-F GAMING,
>>>> * ROG STRIX X470-I GAMING,
>>>> * ROG ZENITH EXTREME,
>>>> * ROG ZENITH EXTREME ALPHA.
>>>>
>>>> I have added "ROG STRIX Z390-F GAMING" to list of supported boards in
>>>> asus_wmi_sensors.
>>>
>>> Guenter, what is your plan about this patch series? It seems it
>>> missed, by unknown (?) reason, the v5.16-rc1 (I remember seeing it in
>>> some of your tree branches at some point).
>>>
>>
>> I don't see it in my record. Earlier I was simply waiting for some
>> Reviewed-by: tags, which I have never seen.
> 
> Ah, understood. Thank you for clarifications.
> 
>> Looking into the commit log,
>> I do see:
>>
>> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
>> Co-developed-by: Eugene Shalygin <eugene.shalygin@gmail.com>
>> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
>> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Did you and Eugene indeed sign this off, ie did you write it, and
>> Eugene and Denis signed it off ? If so, the tags are in the wrong order.
> 
> I'm not sure I follow. I have helped Denis with the code and according to
> Submitting Patches documentation the order should be chronological with the
> main author to be first in the list. Here the committer (submitter) is the
> same as the original author IIUC. (I can't speak for Eugene, though)
> 

I got the patch from Denis. At the very least, Denis' signature should be
last. It is first.

Guenter

>> On the other side, if the code is ultimately from Denis, with your input,
>> the tags should be either Acked-by: or Reviewed-by: for both Eugene
>> and yourself.
> 
> I'm fine with either Co-developed-by+SoB or Reviewed-by.
> 
>> Note that v11 of this patch series is missing from
>> https://patchwork.kernel.org/project/linux-hwmon/list/
>> for some reason.
> 
> Hmm... Denis, please check locally how you prepare your patches.
> 
> 

