Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086BE30968C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhA3QPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 11:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhA3QA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 11:00:56 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F338C061573;
        Sat, 30 Jan 2021 08:00:11 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 36so11768949otp.2;
        Sat, 30 Jan 2021 08:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i1Y1GTOXeVZe95V2JMXKUZfz/w0hpueKYPv2Yf7uGAs=;
        b=TJk49GIMvxm8PC4RfvcwIkVnLjUb9fdi4O9N3k202Cr26Y2EP1cNSNlEqRAj5lUaA6
         PU0MBMk2AmnH0cKXOkoyCAPqu0ktzoAhnszUP4cYM/J/sxUVreV5JpuT45qcwMDlZiWG
         NViamyuqqvUFGmaYOhkSuSrYDSRHRhmzpv3CKRFOWsD/ammnqPCKaEFTtLd5umNR5q+Z
         QUSS618OeKeAGmNWemzTgu/kq7QBx5FG6jNAukVJQzT5iSUApP3C1dQK0sTy0JupYAyr
         8o2qfw8eNprVU9DAA/bGv/NfiYNGlejbq2id2hz0s7x+hMd1DTQCd9EOGNNeqYAS5laP
         tqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=i1Y1GTOXeVZe95V2JMXKUZfz/w0hpueKYPv2Yf7uGAs=;
        b=evSacaWKYtJOp8GSObiuBvzrVgJcS96M6E6BJHa0iLoEMWpzePKROdqW5DZJ+kE6CJ
         kmn7yBd276EEyyY4hfJVOV66n1wOPtjwBR0GSYgXysDrGjZJ81XOAhakTx3PC/fpNvhx
         FCbsKedhdYRP5ViOGjc9rfKw7Qu0d+aeJHlHdDOOd4zIVkxT5E7MCf33QXh9aEp9wCS2
         EqOOsg4rt+L61Eykl3BAyL9tGUzbvFtbfJ0/4PK5pv5rv41UVr3I7lnoX8JawWBvjyxV
         or95dOihx2tVmzD9F1a4kGK3ygjEB2uy1tdAiypJG4k99pMZu9DVOvlZCBtq9Uqxgm+B
         0Zww==
X-Gm-Message-State: AOAM531cJjzujEO2lJnC193BcI1TzpcR2fD5zGiwhto3fo5tNkMNf7JO
        mPHl8f/PhjsTU0XIdTdW71pluHhHIvQ=
X-Google-Smtp-Source: ABdhPJyVqJ2/gwKsiVCbI4qg6JOkNVpDlDvQjENT/WO304Me/CpY++JqOAF4eEMta4EpLQzHiGfaHw==
X-Received: by 2002:a9d:21ca:: with SMTP id s68mr2090823otb.164.1612022410137;
        Sat, 30 Jan 2021 08:00:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w66sm3171077oif.21.2021.01.30.08.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 08:00:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: lm75: Use zero lm75_type for lm75
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210130101038.26331-1-matwey@sai.msu.ru>
 <a771f5b8-aa24-b736-4e8f-b3b46a15dcb6@roeck-us.net>
 <CAJs94EY=hDwNun_kzNQdMHmC27KEZV6urxcKm9xbHriJ_1m3UQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <dae2c13a-877e-fd54-bb6a-ed7c2c3d1e66@roeck-us.net>
Date:   Sat, 30 Jan 2021 08:00:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJs94EY=hDwNun_kzNQdMHmC27KEZV6urxcKm9xbHriJ_1m3UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/21 7:43 AM, Matwey V. Kornilov wrote:
> 
> 
> сб, 30 янв. 2021 г. в 18:31, Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>:
>>
>> On 1/30/21 2:10 AM, Matwey V. Kornilov wrote:
>> > There is a logical flaw in lm75_probe() function introduced in
>> >
>> >     e97a45f1b460 ("hwmon: (lm75) Add OF device ID table")
>> >
>> > Note, that of_device_get_match_data() returns NULL when no match
>> > found. This is the case when OF node exists but has unknown
>> > compatible line, while the module is still loaded via i2c
>> > detection.
>> >
>> > arch/powerpc/boot/dts/fsl/p2041rdb.dts:
>> >
>> >     lm75b@48 {
>> >       compatible = "nxp,lm75a";
>> >       reg = <0x48>;
>> >     };
>> >
>> > In this case, the sensor is mistakenly considered as ADT75 variant.
>> > The simplest way to handle this issue is to make the LM75 code
>> > zero.
>> >
>>
>> This doesn't really solve the problem since it would match _all_
>> non-existing entries with lm75 (instead of whatever is intended).
> 
> Just exactly how it happened before e97a45f1b460
> 
>> That doesn't matter for lm75a, but it would matter if someone
>> would enter, say, "bla,adt75".
>>
>> On a side note, "nxp,lm75a" (nor "nxp,lm75", for that matter) is not a
>> documented compatible string for this driver. If anything, we would
>> need a means to explicitly reject such undefined compatible strings.
>> One option might be to define the first entry in enum lm75_type
>> explicitly as invalid, check for it and reject it if returned.
> 
> It is fine for me. I am afraid that this will break some dts files in the tree.
> The following compatible strings missed in the driver are currently in use:
> 
> ti,lm75
> nxp,lm75
> nxp,lm75a
> 
> I suppose these boards currently rely on the i2c detection path.
> 

Correct. But relying on a bug doesn't improve the situation.
The above compatible strings need to be documented (and properly
implemented), or removed. And we really need a better means to handle
NULL returns from of_device_get_match_data(). Maybe we should use
of_match_device() instead and check for a NULL return.

Guenter
