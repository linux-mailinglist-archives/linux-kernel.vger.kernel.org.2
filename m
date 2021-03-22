Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44B8343ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhCVLDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhCVLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:02:52 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FF6C061574;
        Mon, 22 Mar 2021 04:02:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o19so18743785edc.3;
        Mon, 22 Mar 2021 04:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=bP+9z6+/AkKUxzaywvKK+rP+LUX4mnyV5vUY0XfiapI=;
        b=U5A5HLjn1OM9WQMo02CnQFoZT61qpIexv+AYTEiQV8KkU8A993NDIWHj1SSlsr+jh3
         LJAYURPXOwBg8QK5wHvw9nEbrnotmZDTWaOAgDWf0ZfLTU8YeTjND/XVWrWgYASDMVtu
         DLhHKO87djD3auYQ+5pCZCDynOFIzb2ueBNZyiMleMJYWn98RKv69PvRsFQuwi/szjJS
         NcefUZWOeQf7IKCShLRQEKfS7MyLy/N01NeKO+JLpc64E01o3eUvPzNBOF1isNJo6I5V
         WppEE+UkE59L3NZtvdN7IuDfVCIIb5mGi/KKQV0N+6UYnTpMDVikH/qNM4xE7yNhe8GZ
         fc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=bP+9z6+/AkKUxzaywvKK+rP+LUX4mnyV5vUY0XfiapI=;
        b=j+FbfrxSsTPqrd7xcFuNQkQj70m1dbBfrJ4nNgwumIZOveEivI9XVAaNx6CqCr69WG
         t3Od3D4Ns9CeVE2NJNhXJq2msGWM5JuDR8M7jBnJms11lgV46wjLUqevMY+XUk9kKSbu
         K8h9h+c4Xc5202UCOqH9ituxwEoNsJYqmnWk+AnR+99GG59kX8Qoi7aa6gogw1DZ9UmG
         R+od4UxzJX++k6r605ykAZ682ALtj3jJGkm7SnIO/xGVuHgvezM+rOImJ1BQ9Cz2Ig+U
         YNrx+I+jejCf2vwsfEijjLwc3hmhUB/ckSORWX8cJjjuW2CayuV6o9N/nIPJ/50T5MOa
         x+Pw==
X-Gm-Message-State: AOAM532BeHU9NdTGSmm/FxZqMsPVkBPZVV7rzt/qLRuIQt+h2xXFxMAW
        A81c5OzAimjRVN4/gmmwlI4=
X-Google-Smtp-Source: ABdhPJzf/qlCLC5yeB8AWurXmXJOGGXXV5jfC4r8FY0SKsW+7CbDGnuB4Xh+HdZ1h6zlHChYCMYn3g==
X-Received: by 2002:aa7:cf90:: with SMTP id z16mr24987525edx.273.1616410970752;
        Mon, 22 Mar 2021 04:02:50 -0700 (PDT)
Received: from [93.173.65.134] (93-173-65-134.bb.netvision.net.il. [93.173.65.134])
        by smtp.gmail.com with ESMTPSA id v8sm11125318edc.30.2021.03.22.04.02.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 Mar 2021 04:02:50 -0700 (PDT)
Message-ID: <60587922.2040903@gmail.com>
Date:   Mon, 22 Mar 2021 13:01:54 +0200
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     arnd@arndb.de, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v4 2/2] staging: Add driver for XillyUSB (Xillybus variant
 for USB)
References: <20210311095033.20956-1-eli.billauer@gmail.com> <20210311095033.20956-3-eli.billauer@gmail.com> <YFc6z9REEo27FMA+@kroah.com>
In-Reply-To: <YFc6z9REEo27FMA+@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Greg.

Thanks for your comments. I'd like to address a couple of them.

First, there's the lockless FIFO that is implemented in the driver:

On 21/03/21 14:23, Greg KH wrote:
>
>> +
>> +static unsigned int fifo_read(struct xillyfifo *fifo,
>> +			      void *data, unsigned int len,
>> +			      int (*copier)(void *, const void *, int))
>> +{
>> +	unsigned int done = 0;
>> +	unsigned int todo = len;
>> +	unsigned int fill;
>> +	unsigned int readpos = fifo->readpos;
>> +	unsigned int readbuf = fifo->readbuf;
>> +
>> +	fill = atomic_read(&fifo->fill);
>>      
> And the number changed right after reading it :(
>
> Again, no atomics, use a lock please.
>
> This is a USB device, you are NOT doing high-speed data transfers at
> all.
>
>    
The current XillyUSB hardware is USB 3.0 based, running at ~400 MB/s, 
and this is just the beginning. For comparison, when the PCIe-based 
Xillybus started at 200 MB/s, I didn't believe it would reach 6.6 GB/s.

So that's why I made the effort to implement a lockless FIFO, with all 
the extra synchronization fuss. And yes, it works perfectly, and has 
been heavily fuzz tested on an x86_64 machine. The memory barriers are 
carefully placed to make this work on less favorable platforms as well, 
but even if I got it wrong -- odds are that the fix will be a line or two.

Replacing atomics with spinlocks is a piece of cake, of course. But 
given this extra information, do you still think it's a good idea?

As for the specific remark on fifo->fill changing after reading it -- 
that's OK, since it would just mean that the reader of the FIFO doesn't 
see the extra data that has just been written to it. This doesn't break 
anything.

Moving on to the second topic:

>> +static loff_t xillyusb_llseek(struct file *filp, loff_t offset, int whence)
>>      
> USB devices do not have a "seek", why is this needed?
>
>    
Xillybus' device nodes are optionally seekable, which gives the user 
application access to a RAM array on the FPGA (or logic emulating it, 
such as registers). This holds true for the existing Xillybus API as 
well as the one for XillyUSB.

Thanks and regards,
    Eli
