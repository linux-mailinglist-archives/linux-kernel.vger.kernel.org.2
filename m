Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AFB31DDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 18:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhBQRAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 12:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbhBQRAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 12:00:48 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996EAC06178A;
        Wed, 17 Feb 2021 09:00:01 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id o10so1863571ote.13;
        Wed, 17 Feb 2021 09:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0nq3SnX/cBiNEbzfLgGbG6G62MT/vD0duwnz4ir4E1c=;
        b=pfNgJCskP6+15JjTsrXE5pAs0A4jk8xIIzUUO/uSkYs4U8hdpUmW8wJW2T3gVAQcEi
         ywcIfevTXuA/t3kY8mcSkW0ySBhlA0DPHF58IvX5w6yNyO1Aq4Zskr2/6jVtsXg1Cvs8
         7GUjQHfy+3t+LlgiWQBJVB52usMza14My7wIBI7wciJoEx02DqjdnVmxhx/fWCs7h35j
         mukHQE9NR4XixiOmhmPe+1/o7av7VnjGyRT/pUEcUzZXug/uZcOPAYNLvdl73qAgDVR9
         qlnpOwZw/pZSd5OplMHx+fqEjDxZnCh0OZfx5MAh1IUuPHLuXVS1q5n2KeDRVOFtCMx6
         Ul/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0nq3SnX/cBiNEbzfLgGbG6G62MT/vD0duwnz4ir4E1c=;
        b=jRm5+HNe1xBqWMr0/J7ha+lZQDYgZwFm7KzlzURAP0xMDWzRMR1IcUenQHfmsWuQ6p
         7GHsxDGd+1UhHhwjcnvSwZcKm8gybNXHqafZqN5hBwL5d0KBD+2L+qwuUylt3+h7C4Dz
         HN1geeQxaiO5n+B264wIhlpkTaQM8or0PvFrYjDUsZ5uYMxfZB5UDpPSaeMoOhVUUcDk
         zj8UrMdmgK0UIGj6FTW/lxRueqH9Iu4RXolSxRMtcQ9MXduQVNwSUcjYtQfANJLsRFGV
         DlqB+NcfFPW1tvbEm94ruptmUzL75ckGkGivCHjbLvxKPSOYZJy2TRoJdJ7cyXx6GAXz
         a/xg==
X-Gm-Message-State: AOAM533tMDIeztNLKMC2LnKqDvYllRIt/FiH/82yo9xFPv4ZBJ150eZc
        VloJJvk4KF7iKQDOod80/qkjCVRlhL4=
X-Google-Smtp-Source: ABdhPJzUnpRL5iP6VqAhjhyySoyOc+HKZI7ZaxizJtUVlP5SRXIzrkIJCwb95rmvgcWt7Erft4dPDA==
X-Received: by 2002:a9d:12c1:: with SMTP id g59mr94273otg.116.1613581200701;
        Wed, 17 Feb 2021 09:00:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o83sm467251ooo.37.2021.02.17.08.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 08:59:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: Using TCPM for ports without Power Delivery support
To:     Cristian.Birsan@microchip.com, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <6cf411e1-8234-d1ca-541d-067665620945@microchip.com>
 <YCuMeW6lbaSq8CIM@kuha.fi.intel.com>
 <5c2e12ff-5a48-1f2a-2f72-77d257f97c1b@microchip.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <64f43be2-1724-8cc5-abff-8cddcfcd0d9a@roeck-us.net>
Date:   Wed, 17 Feb 2021 08:59:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5c2e12ff-5a48-1f2a-2f72-77d257f97c1b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/21 7:28 AM, Cristian.Birsan@microchip.com wrote:
> Hi Heikki,
> 
> On 2/16/21 11:12 AM, Heikki Krogerus wrote:
>>
>> Hi Cristian,
>>
>> On Mon, Feb 15, 2021 at 05:25:29PM +0000, Cristian.Birsan@microchip.com wrote:
>>> My name is Cristian and I'm working on bringing up a USB Type-C Port Controller
>>> (TCPC) without Power Delivery support which is intended to work with USB 2.0
>>> Host/Device.
>>>
>>> The IP is integrated into one of Microchip's SoCs, it is memory-mapped and it
>>> was designed based on USB Type-C Cable and Connector specification revision 1.2.
>>>
>>> In brief, it has support for detecting the threshold voltages on CC1, CC2 lines,
>>> control of the current source (Ip), and pull-down resistors (Rd). The management
>>> of the controller is to be implemented in software (it is not autonomous).
>>>
>>> Having in mind that the controller uses proprietary registers, I chose to
>>> implement it using TCPM directly and skip the TCPC Interface.
>>>
>>> For the beginning, I would like to enable simple use cases like the ones
>>> described in Connection State Diagram: Source and Connection State Diagram: Sink
>>> from USB Type-C Cable and Connector Specification.
>>>
>>> Some of the problems that I encountered until now are:
>>>
>>> 1. tcpm_register_port() fails if set_pd_rx(), pd_transmit() or set_vconn()
>>> functions are missing.
>>>
>>> 2. the port capabilities are specified in the connector DT bindings only through
>>> PDOs, even though PDOs are specific to PD mode.
>>>
>>> 3. once I was able to start the TCPM state machine, it called pd_transmit() in
>>> the process to negotiate the capabilities. For my case I used a dummy function
>>> just to be able to register the port.
>>>
>>> Please let me know what you think and if you have any advice. Am I going in the
>>> right direction or is there a better way to implement this?
>>
>> Don't bother with tcpm if you don't have PD support. Just register
>> your port(s) and the partners directly with the connector class:
>> https://www.kernel.org/doc/html/latest/driver-api/usb/typec.html
>>
>> You can use the driver for the TI HD3SS3220 controller as an example
>> how to do that (drivers/usb/typec/hd3ss3220.c). That thing is also
>> just USB Type-C PHY without PD support just like your port controller.
>>
> 
> Thank you for the suggestion. I had a look at the driver you mentioned and also
> other drivers from the same folder. The chips have logic embedded into
> them to handle CC lines and VBUS while the controller on which I'm working
> provides basic access to CC lines and it is up to the software to drive it.
> VBUS is to be detected/enabled through a standard GPIO.
> 
> The reason for which I tried to use TCPM is that I need to implement in software
> the Sink/Source Connection State Diagrams, CC debounce, and VBUS management.
> I tried to avoid code duplication but on the other hand, my use case does not
> involve PD.
> 
> If there are better chances to upstream the driver using just the connector
> class, I'll move forward with this direction. I just wanted to make sure I
> explained correctly may use case before implementing it.
> 

Personally I think it would be a bad idea to make the mandatory functions optional.
PD is an integral part of tcpm, after all. How about implementing dummy functions
as needed ?

Thanks,
Guenter
