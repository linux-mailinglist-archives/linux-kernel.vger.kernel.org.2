Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0546237A25E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhEKInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhEKInZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:43:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D094BC061574;
        Tue, 11 May 2021 01:42:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d11so19232106wrw.8;
        Tue, 11 May 2021 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tXnJhPK1FADLbH/EXZbWk8gnh9IOj/tx9NT7IBJWZIg=;
        b=cZVO/0otPsNR8D5c/CorG0TW2rkM2F3cpMnryKGBxXaM2nYoIYZU02rmneGXH0r76/
         uC7wefZNl2FuJ6dtFChNP0CHzagAMvZME+5zDmFpHoKchxSn7Xb2zmP/F7SnFSQLZLFU
         t1sbth+J9W/jLgcp6eJUt2foIjPR7aY0/zet/IP/E8K+ALWVSMsZNYn6LcEa6vJaoQAJ
         cz23MRoBdi5aHzREPXdmyudVinP5UfVC7q05U98QPdy7vNQnrWzZgmi2km8X7NK2rs55
         h37/mlV4Fs4E1QAA03h6BhmGvhkBmJJmLuAfgfqN+KIkXaPoTyOSiLOxP8xhkGlGib8T
         BNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tXnJhPK1FADLbH/EXZbWk8gnh9IOj/tx9NT7IBJWZIg=;
        b=asSzgTV2ZIVUOtAc+epEVOqJLX6lE8A34bmRXAd7hCTw/3IjB9uKpQz8Kg0WYsPoQa
         2X32tDSWgXUNrITiluD7tSyzMNxPsxHcJnZXHPCqcklBZKlSuid9ySwhnoCzIeOcFAoC
         HEVTzuBYCL9YZCq2ex2giZGpAaIf3uXbA90d8NP3ITNPyVdmRBQ+QRzwbcY9JmWJBMdq
         abPvmr0shbgNEioRoXvbdpyJjg4dX0IF0iyFtYeHiZ9wTWPbHFTT0r5oj5L92yAkWPs8
         YOD2bSqZqdrW7FrUo2+vfkVRQbyfeBV8+qWvA74prUo5NEZvEPVyWMNAVLN7RkAIDo2C
         1Few==
X-Gm-Message-State: AOAM533mLADq/Re/YSoG6tD/X9lFtqvT2gNEawZXDbOtE7elYXnQF8r7
        v07SDJB9VjWAAv0QjQW3TTRPzxO47PQ=
X-Google-Smtp-Source: ABdhPJxNFN20cSoAE51Czy+t07NtQS6C9XwX+cxq/GdVWJa1NPpp9tblZl5ezqNBt1VicIAE1skkAw==
X-Received: by 2002:a05:6000:1051:: with SMTP id c17mr35528000wrx.43.1620722535379;
        Tue, 11 May 2021 01:42:15 -0700 (PDT)
Received: from [192.168.2.202] (p5487be9d.dip0.t-ipconnect.de. [84.135.190.157])
        by smtp.gmail.com with ESMTPSA id f3sm25952628wrp.7.2021.05.11.01.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 01:42:14 -0700 (PDT)
Subject: Re: [PATCH] usb: xhci: Increase timeout for HC halt
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210511002933.1612871-1-luzmaximilian@gmail.com>
 <828bf140-1be6-9d92-1598-bfdf689bbdae@linux.intel.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <c1b24d1a-497d-a303-7b54-e1d65402f08c@gmail.com>
Date:   Tue, 11 May 2021 10:42:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <828bf140-1be6-9d92-1598-bfdf689bbdae@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 9:19 AM, Mathias Nyman wrote:
> On 11.5.2021 3.29, Maximilian Luz wrote:
>> On some devices (specifically the SC8180x based Surface Pro X with
>> QCOM04A6) HC halt / xhci_halt() times out during boot. Manually binding
>> the xhci-hcd driver at some point later does not exhibit this behavior.
>> To work around this, double XHCI_MAX_HALT_USEC, which also resolves this
>> issue.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>   drivers/usb/host/xhci-ext-caps.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
>> index fa59b242cd51..fb591e41cd50 100644
>> --- a/drivers/usb/host/xhci-ext-caps.h
>> +++ b/drivers/usb/host/xhci-ext-caps.h
>> @@ -7,8 +7,8 @@
>>    * Author: Sarah Sharp
>>    * Some code borrowed from the Linux EHCI driver.
>>    */
>> -/* Up to 16 ms to halt an HC */
>> -#define XHCI_MAX_HALT_USEC	(16*1000)
>> +/* Up to 32 ms to halt an HC */
>> +#define XHCI_MAX_HALT_USEC	(32 * 1000)
> 
> xHCI spec has a 16ms limit stated in several places, for example section 5.4.1
> "xHC is forced to halt within 16 ms. of software clearing the R/S bit to ‘0’,
> irrespective of any queued Transfer or Command Ring activity"

Right, thanks, I wasn't aware of this.

> To make sure hosts work we could increase it to 32, but comment could be
> changed to make sure it doean't get optimized back to 16 ms later.
> 
> How about:
> /* HC should halt within 16 ms, but use 32 ms as some in reality take longer */
> 
> If that's ok I can take this and modify the comment

That makes sense, yes. Please feel free to change that comment as you wish.

Regards,
Max
