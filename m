Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2385A3A45B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 17:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFKPwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 11:52:38 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:42967 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhFKPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 11:52:37 -0400
Received: by mail-oo1-f48.google.com with SMTP id y18-20020a4ae7120000b02902496b7708cfso810911oou.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+bbdOrD7kdOaD+Tt31FlhXOAwKymm4IhpbTo4TpeypQ=;
        b=gxs5pEAXHroOQ/5AwTnVIp2dhFSfg02wB2jdXG+7OQH6g9kE/koFZErN3pmB4gbUPg
         rkYFwiXSBUuJksYc24zHR23AYoOzftp0i+j/tl2G5Xsix5aJwUt3TJd3Vd0eAwn0nLLG
         VWOdZq3lYhUqUtDhC0YZ3KbDw/HzwJKYlboTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+bbdOrD7kdOaD+Tt31FlhXOAwKymm4IhpbTo4TpeypQ=;
        b=eCITiW990zIK6hYyBT5hcPREi5qP/4cK5RxZ9LBPDODxiZAMpyoUvN0rOif9p/UuvN
         UKQbGw+vauhyrpHo4NRuGv3zP3lThvJsPbbGEtAH/DZN7w6RCRFnq0hSvadhYJZ3TrS5
         4M/toltYLh9fW75XSbTcj5rdVjR/Nmq9pBt6+DA711Hh1ZPoKCiRmBSc7O0Bb113hYOL
         HXh16H2bfQCq1EuC6T46eETGUPbwnPuDs5iDUTQrI1/+y4SUhS7ISN6MdFt3+64oYB81
         ZPEVUunCwgG6w+fkZYqn02U0XRtVRZew+0BsYO6dZJZKI4Ucxo2+dA0pptM2Q/O0b+yI
         tPIA==
X-Gm-Message-State: AOAM531qgKSILLcDMO94+xvPODCvQRDDaV9b6v9duvgJkZg95qUHbAfq
        JCRcc70Pk5m+5TotY1k32KeYig==
X-Google-Smtp-Source: ABdhPJw4qowVJu/mcKsnoS6jPvB4DEVeiJMPE9HFbDr/cCaXTOgl+YKDSvtgsTQQhyyJStSprSAULw==
X-Received: by 2002:a4a:6107:: with SMTP id n7mr3587691ooc.12.1623426565411;
        Fri, 11 Jun 2021 08:49:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h193sm1255276oib.3.2021.06.11.08.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 08:49:24 -0700 (PDT)
Subject: Re: [PATCH v2] usbip: tools: usbipd: use ARRAY_SIZE for sockfdlist
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1623406510-50900-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <YMM9f6yM6IIyjx16@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6fb326ac-c1f0-5e38-3564-787a0c90d986@linuxfoundation.org>
Date:   Fri, 11 Jun 2021 09:49:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMM9f6yM6IIyjx16@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 4:39 AM, Greg KH wrote:
> On Fri, Jun 11, 2021 at 06:15:10PM +0800, Jiapeng Chong wrote:
>> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an
>> element.
>>
>> Clean up the following coccicheck warning:
>>
>> ./tools/usb/usbip/src/usbipd.c:536:19-20: WARNING: Use ARRAY_SIZE.
> 
> Why are you assuming that coccicheck should be run on userspace code?
> 
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>> ---
>> Changes in v2:
>>    -Add ARRAY_SIZE definition to usbip_common.h file.
>>
>>   tools/usb/usbip/libsrc/usbip_common.h | 2 ++
>>   tools/usb/usbip/src/usbipd.c          | 3 +--
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/usb/usbip/libsrc/usbip_common.h b/tools/usb/usbip/libsrc/usbip_common.h
>> index 73a367a..4e12dc4 100644
>> --- a/tools/usb/usbip/libsrc/usbip_common.h
>> +++ b/tools/usb/usbip/libsrc/usbip_common.h
>> @@ -101,6 +101,8 @@
>>   		abort();				\
>>   	} while (0)
>>   
>> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> 
> Why is this needed?
> 
> And if it really really is, why not define it in a way that ALL tools
> can use it.
> 
> And then fix it up be correct for cases when you might call this when it
> is not an array.  This is a very naive implementation.
> 
>> +
>>   struct usbip_usb_interface {
>>   	uint8_t bInterfaceClass;
>>   	uint8_t bInterfaceSubClass;
>> diff --git a/tools/usb/usbip/src/usbipd.c b/tools/usb/usbip/src/usbipd.c
>> index 48398a7..4826d13 100644
>> --- a/tools/usb/usbip/src/usbipd.c
>> +++ b/tools/usb/usbip/src/usbipd.c
>> @@ -532,8 +532,7 @@ static int do_standalone_mode(int daemonize, int ipv4, int ipv6)
>>   		usbip_driver_close(driver);
>>   		return -1;
>>   	}
>> -	nsockfd = listen_all_addrinfo(ai_head, sockfdlist,
>> -		sizeof(sockfdlist) / sizeof(*sockfdlist));
>> +	nsockfd = listen_all_addrinfo(ai_head, sockfdlist, ARRAY_SIZE(sockfdlist));
> 
> The code here is correct, right?  So this is not necessary unless you do
> this for all in-tree userspace tools at the same time.
> 

A quick search shows me 53 defines for this across the kernel. Several
tools are defining this in their header scope as well as in .c files.

There is one in tools/include/linux/kernel.h - the tools that can be
compiled from tools/Makefile are okay. However, we have several tools
that aren't hooked into tools/Makefile and usbip is one of them. Some
tools maintainers probably don't want to add dependency on in-tree
header file so they can build it out of tree as a package. At least
that might be motivation behind adding the define under the specific
tool scope. Not true for usbip - it is something that was overlooked
when it was moved from staging to tools.

It is a good call to not add one more under this tool header scope
and do the cleanup for this properly which would include getting rid
of these duplicate defines that are in the kernel now.

thanks,
-- Shuah

