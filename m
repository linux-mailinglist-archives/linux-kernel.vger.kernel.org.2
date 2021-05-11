Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7A37A0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhEKH1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:27:47 -0400
Received: from smtpcmd04132.aruba.it ([62.149.158.132]:58153 "EHLO
        smtpcmd04132.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKH1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:27:46 -0400
Received: from [192.168.1.128] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id gMmqlBMMF8ee9gMmqlihSO; Tue, 11 May 2021 09:26:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1620717999; bh=kEaSU4SIBYA1oeKhe8QqIpUWvEBjftWiyVsrsWAfXWI=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=bDT7EP6/XxNUuWH82gVVadEXsxBKwv11eA6HyaRgFUJR3yJ33jCjZ9epz+ad6nUHS
         amdjZ2DkqhLNF5D9bA23PjOsNbCcXjgA9IxbhPceQ1msRTYKM7gE7e5DhOjS9TN0n0
         GfOAzIx9lToklaNRGcvjUnk+mRkZWgVaCiZxd6SoevX71X0kkmNXn+zg+OXSNTH74s
         btEgnLpxjRprMydUCO095XRpD4HU9EGv/eTPhIOmAtooh3D8NpCGDxdIqZYV4sp9QG
         v2WvACUdDXPSKX+/GyVb9l6VZpO+BgC2zvu8j27i8VZX9fGfslnxGfXUkPYU0/b9mK
         5jF+XR++9ssAg==
Subject: Re: [PATCH v1 1/1] pps: clients: parport: Switch to use
 module_parport_driver()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Alexander Gordeev <lasaine@lvk.cs.msu.su>
References: <20210510141302.56654-1-andriy.shevchenko@linux.intel.com>
 <77c821e1-adc7-4088-0dcb-da65ba7a39a2@enneenne.com>
 <YJovqMqJj3mBeRE8@smile.fi.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <55aeec09-63c7-7d1a-13c9-cd8f4b7dc1f9@enneenne.com>
Date:   Tue, 11 May 2021 09:26:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJovqMqJj3mBeRE8@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOcdBtU7s4JCopLSwY3HU6rOfStrOEgIxac0K/bnFmBTOJl8st9DqopeVEVH2ddKX61uonG4scB0t/dOdUf+f0Cdt14/HWlsfM7hOFxN4PxNlmABoe1v
 57hZ+by4eVZqGuLzDT9yommQR84nlgn44baW3EUlzi/saVVb9YeOIOLthUhMyVGpR209+FQRfT2FIrxRZWqp+688EldFp/SLQCbjUbHSA3i7W0lfwy/9xXD3
 5p+KlB+mhWg1kzEhVGtmUl1ihhO9pevlfoeWUckD1pinUejIfT6upGDeFzYbBts1TA/Cvk+qz7aC1mlBbkI0wA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/21 09:18, Andy Shevchenko wrote:
> On Tue, May 11, 2021 at 09:05:00AM +0200, Rodolfo Giometti wrote:
>> On 10/05/21 16:13, Andy Shevchenko wrote:
>>> Switch to use module_parport_driver() to reduce boilerplate code.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>  drivers/pps/clients/pps_parport.c | 42 ++++++-------------------------
>>>  1 file changed, 8 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
>>> index 7a41fb7b0dec..42f93d4c6ee3 100644
>>> --- a/drivers/pps/clients/pps_parport.c
>>> +++ b/drivers/pps/clients/pps_parport.c
>>> @@ -22,8 +22,6 @@
>>>  #include <linux/parport.h>
>>>  #include <linux/pps_kernel.h>
>>>  
>>> -#define DRVDESC "parallel port PPS client"
>>> -
>>>  /* module parameters */
>>>  
>>>  #define CLEAR_WAIT_MAX		100
>>> @@ -138,6 +136,12 @@ static void parport_attach(struct parport *port)
>>>  		.dev		= NULL
>>>  	};
>>>  
>>> +	if (clear_wait > CLEAR_WAIT_MAX) {
>>> +		pr_err("clear_wait value should be not greater then %d\n",
>>> +		       CLEAR_WAIT_MAX);
>>> +		return;
>>> +	}
>>> +
>>
>> Why do you need to do so? Maybe a comment would be welcomed.
> 
> It's in original code, I just moved it to ->probe().
> 
> What comment do you want to have here, because original code has no comment (I
> think in any case it's out of scope of this change, but may be prepended or
> appended to the series)?

Mmm... these functions can be called at different times, so I don't know if we
can just move the code safely.

Maybe Alexander (in CC) can help us? :)

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
