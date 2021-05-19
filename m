Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB2538961C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhESTET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhESTEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:04:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A6AC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:02:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q5so15118022wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AzHpE/P+E3XnVFe+pFYyhTOphLcaWN5in3hWqrOjh5s=;
        b=KzaLc/B0vgpNLw4CFVrdJuHg0f/M7rCNqks42xT/dGdS+03dXeehZkL3iOuQLYrAtA
         X8kFpMQxpehQ/otqwZzz4RrGzhmzASeR5fMY0hx8N/vQpOGJ7eaZ5u4PGcW2OIzlOTiT
         Iq/I6/R9EaGXWgjvh1JkX9glZ0e8B7uuNBg6B30DhyNT/OBd/DqYrCny2NRW2KpZ2uMx
         Eal5u69aJv3IcGmvNksCEPRh6JB5NbZym4mJKPb5VMkrG6rW1pT7He7XyD20hKqYK+Iv
         /mBQx4nk5ZZxUqIUwPlCVh6461uqlLJdDKC1x8q7JppsiQVD/Ll5mq6sw4xSz1qRhcnW
         UTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AzHpE/P+E3XnVFe+pFYyhTOphLcaWN5in3hWqrOjh5s=;
        b=TlKqrhqhYri89e5y9NZFl3jZwdqdRLotkUreONzZJhUOzGkykM+d92R2RbI92kfxeI
         GPpNZ0+Ujj5lkvGMOiwNXbCsmJhymZaG/gVZH2UI2Zl6c5NaOv3C9taXbg+7IIm580/7
         lkD1hu6j/XYqWu63n0kantSwgcA9s6jQVYB6MqB9re4VPY/Mm2sEfmg+PwHwzH/8KG+d
         6FarGu580DT9wwO+hUDDq3L40y7uEHBKuV3PWmGLqSe140d7ykOJLo1rQbK4YEK8tpBw
         MiVose6la8jAX1NQFpukqk3TuS3HFvmQvGpyZ9J6RoIDHR6jpWDnu++G8uD18R8FwPOc
         d27w==
X-Gm-Message-State: AOAM531A81a9NlNunrPT9uoWmjgYO9yZGnwNOJ9YV0okhSj2l2I+8aLX
        UYRg+YzfxF1FxgRqGnZLUkzT9Cl6FJh2xg==
X-Google-Smtp-Source: ABdhPJygzJiAWSIOqIANPD3djDlDxK2OEsFK5a6+6uf/SjYihMDKwq7JPQ2QbrUSkHAlpQTk4RKtzA==
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr426156wrm.212.1621450972315;
        Wed, 19 May 2021 12:02:52 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:e5dc:6577:6b94:e9e7? (p200300ea8f384600e5dc65776b94e9e7.dip0.t-ipconnect.de. [2003:ea:8f38:4600:e5dc:6577:6b94:e9e7])
        by smtp.googlemail.com with ESMTPSA id b8sm308503wrx.15.2021.05.19.12.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 12:02:51 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <66e9f6e5-fdee-6963-6131-228c69705350@gmail.com>
 <e20db248-ed30-cf5d-a37c-b538dceaa5b2@gmail.com> <YKVFO4bmW/hkoUnx@kroah.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] sysfs: Add helper BIN_ATTRIBUTE_GROUPS
Message-ID: <1facebe2-1368-9b52-e0a1-f7a6eafc91ea@gmail.com>
Date:   Wed, 19 May 2021 21:02:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKVFO4bmW/hkoUnx@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.05.2021 19:04, Greg Kroah-Hartman wrote:
> On Wed, May 19, 2021 at 06:33:14PM +0200, Heiner Kallweit wrote:
>> New helper BIN_ATTRIBUTE_GROUPS() does the same as ATTRIBUTE_GROUPS(),
>> just for binary attributes.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  include/linux/sysfs.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
>> index d76a1ddf8..a12556a4b 100644
>> --- a/include/linux/sysfs.h
>> +++ b/include/linux/sysfs.h
>> @@ -162,6 +162,12 @@ static const struct attribute_group _name##_group = {		\
>>  };								\
>>  __ATTRIBUTE_GROUPS(_name)
>>  
>> +#define BIN_ATTRIBUTE_GROUPS(_name)				\
>> +static const struct attribute_group _name##_group = {		\
>> +	.bin_attrs = _name##_attrs,				\
>> +};								\
>> +__ATTRIBUTE_GROUPS(_name)
> 
> Is this really needed by more than just 1 driver?
> 
Few more use case I saw:
devcd_dev_groups in drivers/base/devcoredump.c
w1_f3a_group in drivers/w1/slaves/w1_ds2413.c
w1_slave_default_groups in drivers/w1/w1.c

> How about just "open code" this for now, binary sysfs files are rare.
> 
> thanks,
> 
> greg k-h
> 
Heiner
