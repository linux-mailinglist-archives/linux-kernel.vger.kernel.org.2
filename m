Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E93430E3AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhBCT6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhBCT60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:58:26 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B76BC061573;
        Wed,  3 Feb 2021 11:57:46 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id m7so1129459oiw.12;
        Wed, 03 Feb 2021 11:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T4SSlPqi/d0aRr5sSX2BwpZ1qnFmtPFAXm66EDENBWs=;
        b=lIfl6EOTuMbmnq7Me/l/OT0fdxOXE1psNiisy+POrxtSIg/Y13k6WDLUyOxMwWO0wN
         6mtHrNeaL2afQtNpwvaEVKFwsFTwZsmU35hi0D1Rh6ip1UUqcHjqkHRYvDv+18UfMJLo
         9Cr3S2oLUmDfbOh8G83+tzxI+WJrjvD1tON8h23y6OieKC77a1a27MLM+bHePOCMcUbm
         qXOcfcpKW43EORBOL2G8XUGXakdI9f4rdLOXKaryqCV8/qerkZDESSEr0j71kI7c2Z0N
         ogjNneCgDb6bwJlrLvwp6Y9zZr5XfvWW2XbLRFg5hUsBuQ9R1sa03QJNK2mEIIbZbowq
         maoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T4SSlPqi/d0aRr5sSX2BwpZ1qnFmtPFAXm66EDENBWs=;
        b=ldBE0ItXu7QnIblvFCC4umPOh0XzSDbzmTRypgqSZcq+FXJ9kweZj8HHVdtZoELiMQ
         D1OygwJGgiQ4L9D/g3vGYzAETI/PM2bOR2aVRjEOUk5fer1u4c3Ia48iiYr8mKPltk9d
         fPve/lsphFWu2k08yI0qqrT2WOUjOZahJy2uN2nsWxxKubQd5QT/AQOaGXtv/2bCqIYh
         INQ/sUTbbSPS4Zm9EI6kjg3TzeyLGXYIMGElC7IgdT1G6KaVJQRKFX+tW4mlRGuzBvYK
         U1lrfIb06px0H9IYhNE3fFUd47ywNMXE83aatAadaxo5YXJvDCpuiMmJyVuA9qXGKAvL
         mXcA==
X-Gm-Message-State: AOAM5332vpNldF0nwmztrAahgA7B/PFBsCKWxSbZ3KHbfHLad+PEW6sr
        ouNESm9B2zrFuHH02uOms1afRFpPvnI=
X-Google-Smtp-Source: ABdhPJxxybGoMClNvsMY4KfIkETAoKRnHZbK39inds51Er5MkBq1ZhXtkbrtwtkPap4eAbjOKf+lKQ==
X-Received: by 2002:aca:3bd6:: with SMTP id i205mr3053696oia.82.1612382265638;
        Wed, 03 Feb 2021 11:57:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m10sm653594oim.42.2021.02.03.11.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 11:57:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/2] hwmon: lm75: Add NXP LM75A to of_match list
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210130103823.28914-1-matwey@sai.msu.ru>
 <82abc622-a625-b1bc-39b4-f9e1849036ee@roeck-us.net>
 <CAJs94EbBAK1LAZt4pfbzbUCxJtRo8kTAxdaN=y_gRbuvX0rz8Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <2588ea5c-630e-6509-689d-4c8fea358e9b@roeck-us.net>
Date:   Wed, 3 Feb 2021 11:57:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJs94EbBAK1LAZt4pfbzbUCxJtRo8kTAxdaN=y_gRbuvX0rz8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 9:13 AM, Matwey V. Kornilov wrote:
> 
> 
> сб, 30 янв. 2021 г. в 18:41, Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>:
>>
>> On 1/30/21 2:38 AM, Matwey V. Kornilov wrote:
>> > NXP LM75A is compatible with original LM75A while it has improved
>> > 11-bit precision.
>> >
>> > https://www.nxp.com/docs/en/data-sheet/LM75A.pdf
>> >
>> > Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru <mailto:matwey@sai.msu.ru>>
>> > ---
>> >  drivers/hwmon/lm75.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
>> > index 3aa7f9454f57..37dc903ebf54 100644
>> > --- a/drivers/hwmon/lm75.c
>> > +++ b/drivers/hwmon/lm75.c
>> > @@ -699,6 +699,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>> >               .compatible = "national,lm75b",
>> >               .data = (void *)lm75b
>> >       },
>> > +     {
>> > +             .compatible = "nxp,lm75a",
>> > +             .data = (void *)lm75b
>>
>> This should get a different identifier (such as lm75a_nxp or whatever)
>> because otherwise the results would be different on non-devicetree
>> systems which would only match "lm75a".
>>
> 
> Sorry, I don't understand it. Non-devicetree systems won't use this table at all.
>  
... and instantiate the driver with "lm75a", ie differently than on a devicetree
system. Some purist could then complain that they have to instantiate the driver
as lm75b even though it is a lm75a to get the higher resolution.

Besides, I just noticed that the resolution for the limit registers for nxp's
version of LM75A is different than the resolution of the temperature register.
That means that you'll need a separate entry for this chip anyway,
one that specifies a .default_resolution of 11 and .resolution_limits of 9.

Making things worse, that also applies to NXP's version of LM75B. And
the resolution of TI's version of LM75B/C is 9 bit for both temperature
and limit registers, which does make me wonder where the 11 bit in the
driver comes from ... oh, yes, that was commit 799fc602143024 ("hwmon:
(lm75) Add support for the NXP LM75B"). The devicetree table was added later,
and with that the entry was wrongly attributed to National and not to NXP.

So in reality we'd really need a number of additional entries to
match sensor and limit resolutions correctly.

National/TI: Resolution is always 9 bit for LM95 and LM95A/B/C.
NXP: Resolution is 11 bit for temperature, 9 bit for limits for LM75A/B.
Oh, as it turns out the limit register resolution for NXP's PCT2075 is
also 9 bit. Sigh.

Guenter

>>
>> > +     },
>> >       {
>> >               .compatible = "maxim,max6625",
>> >               .data = (void *)max6625
>> >
>>
>> Both "nxp,lm75a" and "nxp,lm75b" need to be added to
>> Documentation/devicetree/bindings/hwmon/lm75.yaml (in a separate
>> patch with copy to dt maintainers for review).
>>
>> Guenter
> 
> 
> 
> --
> With best regards,
> Matwey V. Kornilov

