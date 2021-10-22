Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9E64371B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhJVG0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhJVG0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:26:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BB2C061764;
        Thu, 21 Oct 2021 23:23:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d13so3026656wrf.11;
        Thu, 21 Oct 2021 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Aaw8YgvRiaafTD5648Ti2Vgf91t9kC5WLzXGLiyz7vc=;
        b=SvWEwo5EWVAEYqZSB6ZZlNPLbdjIMtfHxce/fMdBZVxTqRcr4z4yPmdpBhQAbktoBV
         BmWMaGdoTFmwaLxW6LbE9ac0Ain+M/Kvk4xCS+ZFRSImz2Gr7YwPoc1nh1Z49b6P/l5j
         6byArAY5Ow3PxV1TM9cEyicQFHd39xiT2IyeMyVo+gCI0DZ3xv5Dl/hrpuaOYcSvqXcZ
         lWJonE/jUapIuyhXo0hoBCtDaGAlmuiDwxZargI2uzlXZwbiGJswCwJWpUoJucSSvt0S
         VcmAFKkmWTKwCEKMqBBCHdLgvFdetrru1iFAngxVMELclJ04uvzCUpb70es1+LzoOuHZ
         aEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aaw8YgvRiaafTD5648Ti2Vgf91t9kC5WLzXGLiyz7vc=;
        b=He89XDmTfWW0poSMeDSx3WBSc+ebyG1Zz1Yn8dBX9QyMe1b7BE1OjKVTm4T4NuOwdh
         k7EtnueCh91NUki4wi+SzVsw0GkItvIjrgwiX1yuM5I7vF0tgw/9SiUu+7va3R11F9E3
         sW8WWGfJbyJKy01y5vZgg6QavHhrt72r+Z+YlLxBDKfB45kLuTJdmXENGEjdGyI5ZUj8
         PZ7Dnq3p4EJLsy49I6OvrFtnOhwamNLjgKN8V8c4FOKVrZdwG0RZZQICAEsFIkHmlrpp
         /E0Gu7UnLaZ4s5bdtXN9JY1lDHl/+sEhynvTAhkgOdePLcJl50KkjBWDqWfMyYyFhAYe
         38CA==
X-Gm-Message-State: AOAM533RbkYDN8zC7fwZbOIGA0tJpL/Kxw92hkqx/VGWN/503q8FYj4+
        M144Kbct0ndlqqYDjvow5VrwdsKlnS8=
X-Google-Smtp-Source: ABdhPJyCktv989C4tDF9GGF3YgYc2NeThoneQAihwX2wDoFKXL8ADDC1uyA4kjaooIL91lLtrNfmVA==
X-Received: by 2002:a5d:638c:: with SMTP id p12mr3028021wru.187.1634883831134;
        Thu, 21 Oct 2021 23:23:51 -0700 (PDT)
Received: from ?IPv6:2003:c7:8f4e:657:6495:ba38:e227:1149? (p200300c78f4e06576495ba38e2271149.dip0.t-ipconnect.de. [2003:c7:8f4e:657:6495:ba38:e227:1149])
        by smtp.gmail.com with ESMTPSA id f17sm1755095wmf.44.2021.10.21.23.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 23:23:50 -0700 (PDT)
Subject: Re: [PATCH v2] Docs: usb: update struct usb_driver, __init and __exit
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20211020201446.GA8482@matrix-ESPRIMO-P710>
 <YXEeHCySQF+jbVty@kroah.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Message-ID: <9e203187-0b9c-fe5b-e30f-40c2f73352c8@gmail.com>
Date:   Fri, 22 Oct 2021 08:23:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXEeHCySQF+jbVty@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/21 10:00 AM, Greg KH wrote:
> On Wed, Oct 20, 2021 at 10:14:46PM +0200, Philipp Hortmann wrote:
>> update struct usb_driver from usb-skeleton.c.
>> update __init and __exit functions that are moved from
>> usb-skeleton.c to common used multi-stage macros.
>>
>> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
>> ---
>> V1 -> V2: changed :c:func:`usb_register` to usb_register()
>>            changed the :c:func:`usb_deregister` to usb_deregister()
>>            used literal blocks for makro module_usb_driver and added one more
>>            stage of multi-stage macros.
>>
>>   .../driver-api/usb/writing_usb_driver.rst     | 70 ++++++++++---------
>>   1 file changed, 36 insertions(+), 34 deletions(-)
>>
>> diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
>> index 2176297e5765..12e0481cceae 100644
>> --- a/Documentation/driver-api/usb/writing_usb_driver.rst
>> +++ b/Documentation/driver-api/usb/writing_usb_driver.rst
>> @@ -54,12 +54,15 @@ information is passed to the USB subsystem in the :c:type:`usb_driver`
>>   structure. The skeleton driver declares a :c:type:`usb_driver` as::
>>   
>>       static struct usb_driver skel_driver = {
>> -	    .name        = "skeleton",
>> -	    .probe       = skel_probe,
>> -	    .disconnect  = skel_disconnect,
>> -	    .fops        = &skel_fops,
>> -	    .minor       = USB_SKEL_MINOR_BASE,
>> -	    .id_table    = skel_table,
>> +           .name        = "skeleton",
>> +           .probe       = skel_probe,
>> +           .disconnect  = skel_disconnect,
>> +           .suspend     = skel_suspend,
>> +           .resume      = skel_resume,
>> +           .pre_reset   = skel_pre_reset,
>> +           .post_reset  = skel_post_reset,
>> +           .id_table    = skel_table,
>> +           .supports_autosuspend = 1,
> 
> Why remove the tabs?  Is that needed here?
You are right will be changed.
> 
>>       };
>>   
>>   
>> @@ -81,36 +84,35 @@ this user-space interaction. The skeleton driver needs this kind of
>>   interface, so it provides a minor starting number and a pointer to its
>>   :c:type:`file_operations` functions.
>>   
>> -The USB driver is then registered with a call to :c:func:`usb_register`,
>> -usually in the driver's init function, as shown here::
>> -
>> -    static int __init usb_skel_init(void)
>> -    {
>> -	    int result;
>> -
>> -	    /* register this driver with the USB subsystem */
>> -	    result = usb_register(&skel_driver);
>> -	    if (result < 0) {
>> -		    err("usb_register failed for the "__FILE__ "driver."
>> -			"Error number %d", result);
>> -		    return -1;
>> -	    }
>> -
>> -	    return 0;
>> -    }
>> -    module_init(usb_skel_init);
>> -
>> +The USB driver is then registered with a call to usb_register()
>> +which is usually in the driver's init function. Since this functionality
>> +is usable with many USB drivers, it is hidden behind multi-stage macros.
> 
> I don't understand the need for the "multi-stage macros" term here.
I am not a native English speaker so "multi-stage macros" is just not a 
fitting wording. May be “staged macros” is better or something else…
> 
> And what functionality is referred to here by "this"?
The “this” is replacing the “init function” but when this is unclear I 
will change in a later proposal…
> 
> 
>> +While the first macros are USB specific the later macros are used in different
>> +subsystems. This removes a lot of boilerplate code.
> 
> What later macros?  Is that really needed to describe here?
I will improve wording...

> I think the above code example should remain, as it is good for learning
> and understanding, and maybe just add something that says "Or you can
> use the following macro to replace all of the above common code."
I understand the need for keeping the code examples. But I would like to 
inform the reader about the macros first.
> 
> 
>>   
>>   When the driver is unloaded from the system, it needs to deregister
>> -itself with the USB subsystem. This is done with the :c:func:`usb_deregister`
>> -function::
>> -
>> -    static void __exit usb_skel_exit(void)
>> -    {
>> -	    /* deregister this driver with the USB subsystem */
>> -	    usb_deregister(&skel_driver);
>> -    }
>> -    module_exit(usb_skel_exit);
>> +itself with the USB subsystem. This is done with usb_deregister()
>> +which is also hidden behind multi-stage macros.
>> +
>> +The init and exit functions are included in the macro module_usb_driver.
>> +Find the first three stages of macros below::
>> +
>> +    module_usb_driver(skel_driver);
>> +                         |
>> +                         V
>> +    module_driver(__usb_driver, usb_register, usb_deregister)
>> +                         |               \               \
>> +                         V                ----------      ----------
>> +    static int __init __driver##_init(void) \      |               |
>> +    { \                 v---------------------------               |
>> +            return __register(&(__driver) , ##__VA_ARGS__); \      |
>> +    } \                                                            |
>> +    module_init(__driver##_init); \                                |
>> +    static void __exit __driver##_exit(void) \                     |
>> +    { \            v------------------------------------------------
>> +            __unregister(&(__driver) , ##__VA_ARGS__); \
>> +    } \
>> +    module_exit(__driver##_exit);
> 
> As the one who wrote these macros, I can't really understand the
> ascii-art here, so I worry about anyone else :)
Code is just better readable, even when code uses more lines. Will be 
changed in next proposal.
> 
> Again, do not think trying to show an implementation detail like this is
> needed.
The big question for me is for whom is this document written? For the 
USB subsystem maintainer that has even written the code by himself? I 
guess not, but may be I am wrong. Or for the kernel newbies like me? 
Please consider that the changed lines are may be not so much of use for 
me anymore as I am in the details.

When I saw the __init and __exit code example first, I was very happy to 
see it and then I was searching in the code for it. I did not find 
“init” and “exit” and was very frustrated. I want to help others to get 
into this example more smoothly.
> 
> thanks,
> 
> greg k-h
> 
Thanks that you replied at all.
Thanks for your very fast reply.

Kernelnewbie Philipp G. Hortmann


