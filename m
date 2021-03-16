Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3751D33D1E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhCPKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:39:23 -0400
Received: from smtp88.ord1d.emailsrvr.com ([184.106.54.88]:46022 "EHLO
        smtp88.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236698AbhCPKhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1615891069;
        bh=jlFTONTY/lD7VZftb17Wa6RLu5kygAH6ASxfDO7wv9U=;
        h=Subject:To:From:Date:From;
        b=D75qKEsFWQXNCr4swhm3kSOLpjzV53XpqU69Mwjc6vumxWG0VUJMSHzSPbMjFvA5I
         6SmsQXf8ki1qaexszUGFIMDW8Is6a4qGDHKAEiV4PX19evn+f1NqNyt9x8PBAL7BBB
         chxCURrRNw3mCb87sJJsIsCqvK4gYoRtfx664tSU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp12.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 98AFDE012E;
        Tue, 16 Mar 2021 06:37:48 -0400 (EDT)
Subject: Re: [PATCH] staging: comedi: replace slash in name
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org,
        open list <linux-kernel@vger.kernel.org>
References: <20210314035757.2740146-1-ztong0001@gmail.com>
 <5d7a5e1c-35ab-58cb-ebcd-da5b280c802e@mev.co.uk>
 <858341a6-c105-1440-aa4d-ea0217f2ec89@mev.co.uk>
 <CAA5qM4AJRYndkXSiW5Y4OCFcH97mf6UiiEEox+TQs8-N957mJA@mail.gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <92b7c57b-b645-9965-8157-4ca76a803cba@mev.co.uk>
Date:   Tue, 16 Mar 2021 10:37:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAA5qM4AJRYndkXSiW5Y4OCFcH97mf6UiiEEox+TQs8-N957mJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 87150a44-81ea-421b-a51a-36bfccef82dc-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2021 20:00, Tong Zhang wrote:
> Thanks Ian,
> I have submitted a v2 patch based on your suggestions.
> Thanks,
> - Tong

Thanks.  I think the only other Comedi driver with the same problem is 
"drivers/staging/comedi/drivers/das800.c".  It passes dev->board_name as 
the name argument of request_irq(), but that is "cio-das802/16" for one 
of the boards supported by the driver.

> On Mon, Mar 15, 2021 at 6:48 AM Ian Abbott <abbotti@mev.co.uk> wrote:
>>
>> On 15/03/2021 10:44, Ian Abbott wrote:
>>> On 14/03/2021 03:57, Tong Zhang wrote:
>>>> request_irq() wont accept a name which contains slash so we need to
>>>> repalce it with something else -- otherwise it will trigger a warning
>>>> and the entry in /proc/irq/ will not be created
>>>>
>>>> [    1.565966] name 'pci-das6402/16'
>>>> [    1.566149] WARNING: CPU: 0 PID: 184 at fs/proc/generic.c:180 __xlate_proc_name+0x93/0xb0
>>>> [    1.568923] RIP: 0010:__xlate_proc_name+0x93/0xb0
>>>> [    1.574200] Call Trace:
>>>> [    1.574722]  proc_mkdir+0x18/0x20
>>>> [    1.576629]  request_threaded_irq+0xfe/0x160
>>>> [    1.576859]  auto_attach+0x60a/0xc40 [cb_pcidas64]
>>>>
>>>> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
>> [snip]
>>> Userspace applications can use these strings to determine the board
>>> type, so changing the strings would break those applications.
>>>
>>> I suggest passing the comedi driver name "cb_pcidas" to request_irq()
>>> for now.
>>
>> Oops, I meant "cb_pcidas64".  But you could reach that via
>> dev->driver->driver_name if you want (where dev is the struct
>> comedi_device * parameter).

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
