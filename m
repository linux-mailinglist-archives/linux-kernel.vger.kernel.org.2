Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32C33E9D82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhHLE3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHLE3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:29:41 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8617C061765;
        Wed, 11 Aug 2021 21:29:16 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id p22so3916998qki.10;
        Wed, 11 Aug 2021 21:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7crB6ut1oFmTFNo8HvKM85WBKFVQGpST+6t0/W+ZBVU=;
        b=mXfuFunSLUfRZ8+6697aQg2iBIcnsk+VZrFjuxyHJAjURoOiMgA+iEq4FzXMQMq9be
         32UcAwJKS2cF1PCqSad8XBxiC3gniWc3WWFyK3A3lqBCxcHybJH8kLt1XRinQOT8oUZD
         ykjK6/5qCeWp4dn8s88P1/FZijFBOALby6GvrAvCufQSTvcP3XsHMM1K4HxsxkbGH01D
         cGkq0Y1HzG3OH8cM4WorjKTVBJZWnSWDsgkeLo8RlU1UWtJoiauIwG1aB+E8mHAhzGWO
         pTcQkLYI/BOtsVNrj7zWnVMQ6UxHAtTrPVaCgkwkf52MxqaaOl4IjhyZ0Ekt7c86h354
         6ETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7crB6ut1oFmTFNo8HvKM85WBKFVQGpST+6t0/W+ZBVU=;
        b=OvVJG7ZDUvH8GEqJ1WlV8k2mf77WCbhzBm1lRg+tSQCHpX1DnVAYWvftzXEyNo5m41
         kmZ+HtxhRSb1bjniDKISWroqE1Izht0HXDHiFcCq8zM3tDg7bVTqqWFDsL938mqsToYA
         NomU+FOWM5NovWCyb0SH9K8NlqkHdASfj9KlGdwd8+mObad6zw6CR7PnBpp/vxjZ9R2I
         iR8rbRRYpCeSQudRKyZ6MTU5KcZJd80iUhejfst955X1h8vF7kQ1mQ0L+ulMFVIUUn9Z
         abVRRieehwFi3WkuoWXfajjwRZ8AEbAh6RqLdwQWoHn0QNpxhn+Q2H1L2mLNjKe6cwio
         46qg==
X-Gm-Message-State: AOAM533e1LuFd3uyZ8q11ryp5FwZ0uCTS3NJCjHqFrFy+hyD/XusspnR
        OXUwTy8DS0dk8ad5GwKB/N1aF6HuzjM=
X-Google-Smtp-Source: ABdhPJxlpZ71SpJrRywihvbJFUMksa371VcklVh19YS84G/lBvW7XavSbPlXSAx03uHltYreiPnODg==
X-Received: by 2002:a37:8387:: with SMTP id f129mr2640582qkd.79.1628742555907;
        Wed, 11 Aug 2021 21:29:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i6sm624662qtj.21.2021.08.11.21.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 21:29:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 0/2] hwmon: (pmbus/bpa-rs600) cleanup and workaround
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "jdelvare@suse.com" <jdelvare@suse.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
 <a181b3a5-41f7-fa49-e7fe-ab32dc39ff39@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1f197bab-f7b1-d3c3-6d01-531364c88ca3@roeck-us.net>
Date:   Wed, 11 Aug 2021 21:29:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a181b3a5-41f7-fa49-e7fe-ab32dc39ff39@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 8:15 PM, Chris Packham wrote:
> 
> On 11/08/21 4:17 pm, Chris Packham wrote:
>> This series builds on top of the BPD-RS600 support[1] which is in Guenter's
>> tree by hasn't made it to Linus' yet. They might actually cleanly apply without
>> it since they touch different parts of the file.
>>
>> [1] - https://lore.kernel.org/linux-hwmon/20210708220618.23576-1-chris.packham@alliedtelesis.co.nz/
>>
>> Chris Packham (2):
>>     hwmon: (pmbus/bpa-rs600) Remove duplicate defininitions
>>     hwmon: (pmbus/bpa-rs600) Add workaround for incorrect Pin max
>>
>>    drivers/hwmon/pmbus/bpa-rs600.c | 44 ++++++++++++++++++++-------------
>>    1 file changed, 27 insertions(+), 17 deletions(-)
> 
> I've also sent a PR for adding display of the rated values to lm-sensors
> 
> https://github.com/lm-sensors/lm-sensors/pull/358
> 
Excellent, thanks!

Guenter

