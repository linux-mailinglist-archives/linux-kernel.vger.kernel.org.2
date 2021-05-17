Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD55C386D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbhEQWwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbhEQWwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:52:10 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710F7C061573;
        Mon, 17 May 2021 15:50:53 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id a2so7492120qkh.11;
        Mon, 17 May 2021 15:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PFoa0ysP7g5oE43V+pkJyWkN91IQnyPwZMQcrYwnKCo=;
        b=ThpTAGgQC2SJ5ykjDgigg6BiA1vT47dchqNNdnix5O2+IpDaHr2VGEpViLiJoJfXJ/
         pD1L7zYT+Iqb8tq7PkqhF74kWtxYBgKiNgTbz7uUGroi9/jTmGORkjH9M76GRHuZnPSf
         Hv7gc/F/vI14QVwAOulr1g8msfv3ChYidqrJQuAKNU5iERvi33lERCJFKDeoxIgnmfxp
         LQ/Hq0DVGWwVsaSV2O/jwwvfLQ6/+Pda1rrrVkfdX7Xp8eGBtXavcwZBp3QiVAnUu7/I
         fF1ByLcyqtOIi+dVfG/vVMXSw7HpK6N47AXEPrOPetooeweT67ceSKgoHW+NuQKTHV6u
         mzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PFoa0ysP7g5oE43V+pkJyWkN91IQnyPwZMQcrYwnKCo=;
        b=K8amWL4QlyAdB+MUwfK8mR2fMTJ7l7IYVcAepdMvGHEhUDlZ0tD9//8JrApUNKBkFS
         xfhsTeAm9ld20xlnL/HlDyhZmGl3MucVSMpXg2EwEZvmoCExftbMrO25FXF9SfYbA0N6
         dzpPMhgk/tJSW+2Wdn8HbUCxExTo7Y2YW+SI6jCppGfV2mZyUF9Ce0NObd/WrYXG+IU2
         67NYZ1wdqWmGUeySdq3Wrjt0ofQwAnRx/3iMpq27wRIfXJ7hax3lga1auztCpkOLFn7l
         ehNLAkEyrWaRxcmrXKi1luYspqoXI5iuSvCGBpYvQ//YrKHMHq4L/f38XzIncjlS8B8l
         FqCA==
X-Gm-Message-State: AOAM533P6LP05bMoHZU6WIN9LhU2jAfQ1XYABby6Es/EiCbgRE5XNxFa
        NpR0mNFWINRCq8isF5ip/WhBS7L3GLk=
X-Google-Smtp-Source: ABdhPJyAhk1dCl6Dn6eXy02fzqAW0VDjdqfiCkEcL9Yngbr8mWuhcosq0QkIga6Dpx/HvhxoYKQiaQ==
X-Received: by 2002:a37:68c5:: with SMTP id d188mr2289713qkc.287.1621291852513;
        Mon, 17 May 2021 15:50:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l65sm11397175qke.7.2021.05.17.15.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 15:50:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon:q54sj108a2: the PMBUS_MFR_ID is actually 6 chars
 instead of 5
To:     Chu Lin <linchuyuan@google.com>
Cc:     linchuyuan@gmail.com, Jason Ling <jasonling@google.com>,
        Zhongqi Li <zhongqil@google.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210517222606.3457594-1-linchuyuan@google.com>
 <ff2e9bf6-f82b-01ce-6206-a9882d9d4a97@roeck-us.net>
 <CAKCA56CUMaAw7Zga9sT_uHQ5odW-bSamssug38xvWhcNNw8eng@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <cdb4666d-27e9-64b3-f51b-8d88287305f8@roeck-us.net>
Date:   Mon, 17 May 2021 15:50:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKCA56CUMaAw7Zga9sT_uHQ5odW-bSamssug38xvWhcNNw8eng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 3:32 PM, Chu Lin wrote:
> On Mon, May 17, 2021 at 3:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 5/17/21 3:26 PM, Chu Lin wrote:
>>> The PMBUS_MFR_ID block is actually 6 chars for q54sj108a2.
>>> /sys/bus/i2c/drivers/q54sj108a2_test# iotools smbus_read8 $BUS $ADDR 0x99
>>> 0x06
>>>
>>
>> What is the 6th character ? Should it be checked as well ?
>>
> The 6th char is \0. Do you suggest we check that as well?
> 
No, that would be a bit pointless. I'll apply the patch.

Thanks,
Guenter


> Thanks,
> Chu
> 
>>> Tested: Devices are able to bind to the q54sj108a2 driver successfully.
>>>
>>> Signed-off-by: Chu Lin <linchuyuan@google.com>
>>> ---
>>>    drivers/hwmon/pmbus/q54sj108a2.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
>>> index aec512766c31..0976268b2670 100644
>>> --- a/drivers/hwmon/pmbus/q54sj108a2.c
>>> +++ b/drivers/hwmon/pmbus/q54sj108a2.c
>>> @@ -299,7 +299,7 @@ static int q54sj108a2_probe(struct i2c_client *client)
>>>                dev_err(&client->dev, "Failed to read Manufacturer ID\n");
>>>                return ret;
>>>        }
>>> -     if (ret != 5 || strncmp(buf, "DELTA", 5)) {
>>> +     if (ret != 6 || strncmp(buf, "DELTA", 5)) {
>>>                buf[ret] = '\0';
>>>                dev_err(dev, "Unsupported Manufacturer ID '%s'\n", buf);
>>>                return -ENODEV;
>>>
>>

