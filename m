Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E285D31237B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 11:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBGKdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 05:33:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhBGKdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 05:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612693941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZ2NyIxf6r/NIa95Lz0kTigmjh+yVnxtRLDiE0g2UJY=;
        b=ITUslMlXFrRC6Ry3W2l5gHw6qhqGPvNm1EXzfdNxpUNQQ2gy8wvYzzvFPQAjWvVfuqJRkv
        Op7aOUmlJ6sh2Pzwxndfg1x8B7NNvulxGGABoFBs8HpFYD2Guhovil9mE0SRXIf7ykYJQ2
        kBt4N47pMrOz/scbubvUIcQSd6udoYE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-Z-jUbtwEOPumhv1c7aB9Ag-1; Sun, 07 Feb 2021 05:32:17 -0500
X-MC-Unique: Z-jUbtwEOPumhv1c7aB9Ag-1
Received: by mail-ed1-f70.google.com with SMTP id u24so8377553eds.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 02:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EZ2NyIxf6r/NIa95Lz0kTigmjh+yVnxtRLDiE0g2UJY=;
        b=tbcVVEFic/5FpMGnh7nkshPSqeUxuk/gKE52s3ueaUSsuxwTspJwXovCyQt7UickAJ
         C2nAAXTMYRXUIZVpskznAbqDu41BQFVhtzzTPWtXyP4Ra55ojd91b9L0HgbL5jGsQTCy
         QuRZRO5L9Io6xDeqBR08Vsw7Ys+3RdhJSY+nAYlFp9jPUXYoh9TMuE0dTRHppYtw0O2u
         Pfn3mjBV2Uhvet06a64aoGAnhFokCGZCyCIDeR9ZVPPgeL9qQXiUuCzcu+MLXhZNMMpq
         1Db6BWJA+piUmYMlqywddl5368RvnnmK0hlXY9A5EaKC70LBS52JWijVIqNApMvsVaUY
         T0SA==
X-Gm-Message-State: AOAM530KxJ4tP22yrryGqFs8CUcK8us0ypvgfuB3+H2XjFZXf9rps6Lf
        Nq6ZFbTIlELTHiwQu8Z4VOWiMDp+B1FQkTx7F+r8hRgHNyVj5s3444MGr9ycaAOk+AZtqUJNpAH
        fLsWmCKYlIEfFHBERpllKW4+mHQQhcfrHHjNq/0OPlnW76GWrRvIeTBF2oGTYMoreaLuj2f0CgU
        rW
X-Received: by 2002:a17:906:3a13:: with SMTP id z19mr12457866eje.317.1612693935902;
        Sun, 07 Feb 2021 02:32:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynt5RcbjbWjEscrjnKI9AW6p2ZEi10XR+wMXyZ8/NYunIcGq2YCKh+O0sv5yYafLcghJMLQQ==
X-Received: by 2002:a17:906:3a13:: with SMTP id z19mr12457842eje.317.1612693935678;
        Sun, 07 Feb 2021 02:32:15 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id c27sm3503626eja.104.2021.02.07.02.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 02:32:15 -0800 (PST)
Subject: Re: [PATCH] Input: synaptic - reverting
 dcb00fc799dc03fd320e123e4c81b3278c763ea5 because it breaks the touchpad for
 one guy on Reddit.
From:   Hans de Goede <hdegoede@redhat.com>
To:     Colton Booth <colton@boothsoftware.ca>, dmitry.torokhov@gmail.com
Cc:     colton@boothlinux.ca, Lyude Paul <lyude@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        Dennis Kadioglu <denk@eclipso.email>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yussuf Khalil <dev@pp3345.net>, Ilya Katsnelson <me@0upti.me>,
        Gaurav Agrawal <agrawalgaurav@gnome.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210207035024.69095-1-colton@boothsoftware.ca>
 <08362ef4-c407-9cd0-20fa-354cd8e73fcb@redhat.com>
Message-ID: <354e080e-4ddb-9097-2ca9-4834982e925b@redhat.com>
Date:   Sun, 7 Feb 2021 11:32:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <08362ef4-c407-9cd0-20fa-354cd8e73fcb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/7/21 11:18 AM, Hans de Goede wrote:
> Hi,
> 
> On 2/7/21 4:50 AM, Colton Booth wrote:
>> I can't test myself since I don't have the correct hardware, BUT this change seems to work for him. I'm thinking he has an early version of the X1E which may use slightly different trackpad revision.
> 
> Who is "him"? Do you have a bug-report link or some such ?
> 
> With which kernel version is this ?  Could it be that the commit you are reverting was
> backported to a stable-series release while that stable series is missing the rmi4
> updates necessary to make things work on newer models ?
> 
> What are the symptoms / problems "him" is seeing when not reverting this?
> 
> On case it is not clear: NACK due to insufficient information why this is
> necessary / missing description and root cause analysis of the actual problem.

p.s.

My apologies if this sounds a bit grumpy, I got out of bed on the wrong side this morning.

Regards,

Hans





> 
> Regards,
> 
> Hans
> 
> 
>>
>> Signed-off-by: Colton Booth <colton@boothsoftware.ca>
>> ---
>>  drivers/input/mouse/synaptics.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
>> index ffad142801b3..2d3f03921dbc 100644
>> --- a/drivers/input/mouse/synaptics.c
>> +++ b/drivers/input/mouse/synaptics.c
>> @@ -179,9 +179,7 @@ static const char * const smbus_pnp_ids[] = {
>>  	"LEN0093", /* T480 */
>>  	"LEN0096", /* X280 */
>>  	"LEN0097", /* X280 -> ALPS trackpoint */
>> -	"LEN0099", /* X1 Extreme Gen 1 / P1 Gen 1 */
>>  	"LEN009b", /* T580 */
>> -	"LEN0402", /* X1 Extreme Gen 2 / P1 Gen 2 */
>>  	"LEN200f", /* T450s */
>>  	"LEN2044", /* L470  */
>>  	"LEN2054", /* E480 */
>>

