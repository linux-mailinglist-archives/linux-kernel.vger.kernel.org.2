Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700C43F4068
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 18:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhHVQP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 12:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhHVQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 12:15:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4021C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 09:15:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i28so32495183lfl.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bHtNQn7dNi72+okaHJRNsXx+7CZvTt5k60Z9TSD+Y2M=;
        b=if3LP1B4i6rU0mOU61JDm4v7XdIV5cK/RwkHJ8oIlYxUeYkJlQhT2sKDCucx4vl6n3
         9Ww6uo4LAK+XTf3qEdZA9jvnOFK3kn5vfKmZsl6rEYdxZ/4E+kmUVjdPgL6hGmW5FBk6
         MrVPQoqkU6r/iby7nra4hJneQU1OtASvmplNJJKe7do5HtZh30GfwdEHjmAl16U070eI
         TdXxIh8wOzR5GO9L0inbv7eym/al2hzUFzpNdDoujtD+zxwqc45LtPSblhLBsqeTmzWY
         makVbcsQeIB0UnQ+dF1+AoyIYT98n0qLf0sd1WUnlTFCgu9yLDOnuRHnXOHYjsSJduVs
         yLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bHtNQn7dNi72+okaHJRNsXx+7CZvTt5k60Z9TSD+Y2M=;
        b=ZT9PxJ7g+0e4/A1ksJkyzxp6a2hcmiFCLbwog0NNNisMqTtGfdROPsBgsgheCcjtdt
         rjMKbVagyKRS9mbiptMJqvrhxOSq4Lf3eMXfd859hne9R/M8vWCnQXAU3cuBlONhu8k8
         8gcc1nWtNjtWK6dWREx3wwaZ9iHRz5VVYBhWoiPur1+buHtMMutebRgem2I8VoOAreMU
         jcBdO9RYItW+XTjHtuCzcC/E1pLaCurkrWeEspL0+CN7b2O3tgC1lq6GCyvaiY95DHaw
         GO45ONhe0uhe3c+Yt+CvJf6OOsN57iluMyly/82xyiSccCWkPUn+6sXLqsZCPzngLWaG
         4PyA==
X-Gm-Message-State: AOAM533R3kRQfT5kpiqv9pDIv5mhEiOxu6gkaj2xFlJHKQ2T5rifqtrh
        8tRZxXZEYc9Ii3DuaHQRrDU=
X-Google-Smtp-Source: ABdhPJyo7iPjiOWWbgHeT8RhzWUYmUrz7Yzm+g0Sb43MdCgUGKWJCJj8lyH+jEHTCEiHGN52lmqyRg==
X-Received: by 2002:a19:6b03:: with SMTP id d3mr22406614lfa.139.1629648912247;
        Sun, 22 Aug 2021 09:15:12 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id a10sm1221831lfl.215.2021.08.22.09.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 09:15:11 -0700 (PDT)
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
References: <cover.1629479152.git.paskripkin@gmail.com>
 <2244219.zNr1yEsLHP@localhost.localdomain>
 <6182ed46-d79d-7f66-c7c0-096486410b4d@gmail.com>
 <23968040.bvS6LFdsLj@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <916d89fd-529f-300d-4e32-ea14b4ac64fa@gmail.com>
Date:   Sun, 22 Aug 2021 19:15:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <23968040.bvS6LFdsLj@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/21 7:03 PM, Fabio M. De Francesco wrote:
> On Sunday, August 22, 2021 3:31:31 PM CEST Pavel Skripkin wrote:
>> On 8/22/21 4:21 PM, Fabio M. De Francesco wrote:
>> > On Sunday, August 22, 2021 2:39:34 PM CEST Greg KH wrote:
>> >> On Sun, Aug 22, 2021 at 03:10:56PM +0300, Pavel Skripkin wrote:
>> >> > On 8/22/21 1:59 PM, Fabio M. De Francesco wrote:
>> >> > > On Sunday, August 22, 2021 12:09:29 PM CEST Pavel Skripkin wrote:
>> > [...]
>> >> > > So, it's up to the callers to test if (!_rtw_read*()) and then act
>> >> > > accordingly. If they get 0 they should know how to handle the errors.
>> >> > 
>> >> > Yes, but _rtw_read*() == 0 indicates 2 states:
>> >> > 	1. Error on transfer side
>> >> > 	2. Actual register value is 0
>> >> 
>> >> That's not a good design, it should be fixed.  Note there is the new
>> >> usb_control_msg_recv() function which should probably be used instead
>> >> here, to prevent this problem from happening.
>> > 
>> > I think that no functions should return 0 for signaling FAILURE. If I'm not
>> > wrong, the kernel quite always prefers to return 0 on SUCCESS and <0 on
>> > FAILURE. Why don't you just fix this?
>> > 
>> That's what I've done in v2. All rtw_read* family will have following 
>> prototype in v2:
>> 
>> int __must_check _rtw_read8(struct adapter *adapter, u32 addr, u8 *data);
>> 

(*)

>> Was it your idea, or you were talking about different approach?
>> 
>> With regards,
>> Pavel Skripkin
> 
> Pavel,
> 
> Yes, it is correct.
> 
> However, after that I had time to look at the calls chain and understand what
> each function does and then I saw that my initial proposal should be made
> along with another one...
> 
> The calls chain is:
> 
> (1)        _rtw_read8()  <--- (returns the data read from next function in chain)
>                                              (no errors returned, see possible fix in next function)
> (2)                usb_read8() <--- (returns the data read from next function in chain)
>                                                   (_data_may_be_unitialised_, no errors returned)
> 		  (possible fix: from "u8 data"; to "char data = -1;")

Anyway char will be cast to u8 and -1 will become 0xff. 0xff is still 
valid register value, I guess.

> (3)                           usbctrl_vendorreq() <---- (returns data read from next function in chain)
> 		                            (data is always a valid pointer saved to third argument)
> 		                            (if it fails, the third argument is unchanged because it
> 		                            still has the address of the "data" argument given by the caller) > (4)	                usb_control_msg() <---- (it always returns how 
many bytes read or valid error codes)
> 		                                  (it _never_ returns 0: either positive or negative values)
> 		
> I have not yet looked at the usb_control_msg_recv() which Greg talked about.
> 
> To summarize: in function (2) "u8 data" should become "char data = -1;".
> 

So, anyway caller _should_ somehow receive an error from 
usb_control_msg(). We can just change rtw_read{8,16,32} return values 
from u{8,16,32} to int32, but anyway it will require all changes, that 
I've done in this series, but in slightly different form. I.e temp int32 
variable + error checking + casting int to u{8,16,32}.

Doesn't it make sense to just switch to more standard prototype (*)? All 
other drivers use this prototype for their private reading functions.



With regards,
Pavel Skripkin
