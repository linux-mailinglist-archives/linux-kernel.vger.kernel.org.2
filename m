Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EDA44127C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 04:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKADuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 23:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhKADun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 23:50:43 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2170BC061714;
        Sun, 31 Oct 2021 20:48:11 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so23551637ote.8;
        Sun, 31 Oct 2021 20:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dSMSdJzsSo0hXmRoiI8+pJHJkW+iwLpzQ5iUUQzYzcg=;
        b=kpzDjCz6aWw7ruDUm2P0xUDUZbzCv4ujV8tBQ+kNfJTj3xXfc/2h20isqd0yR8bGk+
         slKMEx+ZDRejcG3g2osOcq9QgY+Cf4oUG2u4WTX8/N7rFbtR2jjo+mqUXPjYR9bpth7r
         10lfxDKY4v/CDDeZyOBcSaeyXzdITuA194RW6Seg+SRdtmLX1jNEW74xKGGHTOT1IpJA
         yodA5PhxvU20m5yRMFt5hjJ24//dfRnU9i6uM13VDuBoNrB4b+CR5zwpZ/+bALv8cQsj
         TNTO1ktl4eXVu8JMKiZHn2/If11d2hgSV5zmfqyiv+ConLAVSvsEezLPUBsAepjmeLQd
         SAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dSMSdJzsSo0hXmRoiI8+pJHJkW+iwLpzQ5iUUQzYzcg=;
        b=BiT9pb4YP+3md7EMYm6UrivEw9br6/adDzQU4lF2DsL+rWMEre2VZF0GT+Bfv3kS9W
         kXJym3H9RvmMPSmIBUmfFbojCBtkVZ7eH77zps6GwKh0/LFivsXaxXlE0pkJQ1zrsgk+
         GucwUm0xaIcmuFppcmDAgsQenguqrNieg0n6E20uXjWLhDUETQ/XI1lEiJ+vC5PMOog9
         walFIoCjyQBUFzXQWhRVDzmrFKJLIGOMzYrKefeO+FW82Rw+bRmKEkp9pRPW3G/H7goq
         CJLd8IQicuruyfbOJC7mKEkYvyHwkJLlFuUe5+3/MHdAxxJLV7TLAUfk4nsbi1nqJflm
         G3lg==
X-Gm-Message-State: AOAM531z2DfmfaOUym4JsNt0MtvSD7Aej5EeoN8E/qiKGUxQkFDD4wGE
        NO4aC71RzGNnxl0CnXuiUxAVbiXZ9jU=
X-Google-Smtp-Source: ABdhPJy8ZqxMRV8FgxBwfMiNcet12Kj3O0DoVaiMt7WfaidrfQsSt8y9GB41WVsWHj1MLcVOMMhwZg==
X-Received: by 2002:a05:6830:43aa:: with SMTP id s42mr1510744otv.13.1635738490389;
        Sun, 31 Oct 2021 20:48:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r23sm1384074ooh.44.2021.10.31.20.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 20:48:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 3/3] hwmon: Driver for Texas Instruments INA238
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20211028081030.719265-0-nathan@nathanrossi.com>
 <20211028081030.719265-3-nathan@nathanrossi.com>
 <7b6764bf-4978-60ec-b1e6-8d59077c3023@roeck-us.net>
 <CA+aJhH1aGJXwYSCU8RC275G5=qGLyZRK94g9ic24wxKuRGCwEA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <43c17bba-d4bd-1f9d-5034-1f5a9279d751@roeck-us.net>
Date:   Sun, 31 Oct 2021 20:48:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CA+aJhH1aGJXwYSCU8RC275G5=qGLyZRK94g9ic24wxKuRGCwEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/21 7:20 PM, Nathan Rossi wrote:
[ ... ]
>>> +
>>> +     if (attr != hwmon_in_max && attr != hwmon_in_min)
>>> +             return -EOPNOTSUPP;
>>> +
>>> +     /* convert decimal to register value */
>>> +     switch (channel) {
>>> +     case 0:
>>> +             /* signed value, clamp to max range +/-163 mV */
>>> +             regval = clamp_val(val, -163, 163);
>>> +             regval = (regval * 1000L * (4 - (int)data->gain + 1)) /
>>
>> nit: The typecast "(int)" is not needed here.
> 
> Due to the unsigned type of gain, it causes promotion of regval (and
> the rest of the numerator) to unsigned long which causes issues with
> negative numbers on the divide. It makes more sense for gain to be an
> int to begin with, I will change it to int to avoid the need for type
> casting.
> 

Are you sure ? I initially thought that as well and wrote a little test
program with that expression, but it didn't do the promotion to unsigned.

Thanks,
Guenter
