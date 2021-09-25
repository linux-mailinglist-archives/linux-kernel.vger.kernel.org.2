Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1DD417FF1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 08:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347955AbhIYGQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 02:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344881AbhIYGP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 02:15:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80270C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 23:14:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id n18so12006507pgm.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 23:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HpoIPBMeHUCBgpmsYTw+sc71I4iWC1uvwbOBx2lSENg=;
        b=Z0MsPlOS74Rr1GMDtteUjQg45jN+JoN9QeKhxwzHwYaJwdUvlMdrPTAzvBva8cE+EF
         2qTfOYbCvbvo5ziBjecdaPj9LcBY1w4i3vCt4CRdRZZMkgqFErlysy5XU7/9tTwDAfLK
         ygALEWrZ16gBQTLx9NMDksE9Yj5tT8N09uFo0N7l+3eNhMRgz96Guw9PaJvP0oW1FnQ6
         TMKPzUEB7TPLpYvvEIF6HXQsTrgyyX0PR3NtEsr4c5jx9PKoOk4jwUnLW1bfuhq/cfn3
         tCiOw8oDOHXUY9PXZ2ADm7lJtCewPkOYugIXp+zJpuzjRSnXwuvjTDc+Eqtjr0ahYdBS
         Sytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HpoIPBMeHUCBgpmsYTw+sc71I4iWC1uvwbOBx2lSENg=;
        b=kngP6hIbOBb9sSTpMwx1N7oqMWrGalSAX6L/HFQ6IBtn35facGY3POBW7QLE5CVlpD
         Fsfybeis03Vk8unVDAPRhGUND/MtSrqGOBrdJysF1U1BvW1GlUIsOPOyqyT5fzpTtr+P
         +f0qnr3k8+LLX+jVIoy2QtpfQ5oaKydOdUxaeMjCM3//ZyN2UHVikmmHnSeTIHJrrfC3
         3RyAA2SGhMvS3PDW75o51XrMXDL6EBl0Itk82ggs9OVhJibCgWLjlk0f9+utKL/VgVGy
         dR9mWgyHPaOtSFcw+wlgPCYIhUrX7LJj09eJuilADCRI3e2M0BMy9Gz7CktryoAOODBc
         17OQ==
X-Gm-Message-State: AOAM5321VIs0+Frn6g1ZmDPcoZwbmhNiRTEwx+Imnykrm+z965aRjyiF
        /hpHss14tSsflRN3BZ0CVriV7acxvwE=
X-Google-Smtp-Source: ABdhPJwClGx0EGgEbgzb42SUoMAnHpS5mS/fqUcpJvcfWiaNc7Izz5CZVXmx83kKJTTx5fQ6UfrVJg==
X-Received: by 2002:a62:1943:0:b0:444:f894:e19d with SMTP id 64-20020a621943000000b00444f894e19dmr13208951pfz.36.1632550462767;
        Fri, 24 Sep 2021 23:14:22 -0700 (PDT)
Received: from [192.168.1.6] ([223.230.105.60])
        by smtp.gmail.com with ESMTPSA id g4sm11207645pgs.42.2021.09.24.23.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 23:14:22 -0700 (PDT)
Cc:     saurav.girepunje@hotmail.com, Greg KH <gregkh@linuxfoundation.org>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: core: remove the function
 power_saving_wk_hdl
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <YTub30ZRG3oLbxQW@user> <2311011.CixZWWR6MO@localhost.localdomain>
 <20210920123910.GQ2088@kadam> <3091070.onRVGqex5P@localhost.localdomain>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
Message-ID: <6debf2b4-0d9a-8fac-44ed-a29890678d29@gmail.com>
Date:   Sat, 25 Sep 2021 11:44:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3091070.onRVGqex5P@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/09/21 7:24 pm, Fabio M. De Francesco wrote:
> On Monday, September 20, 2021 2:39:10 PM CEST Dan Carpenter wrote:
>> On Mon, Sep 20, 2021 at 02:31:28PM +0200, Fabio M. De Francesco wrote:
>>> On Monday, September 20, 2021 1:32:21 PM CEST Dan Carpenter wrote:
>>>> On Mon, Sep 20, 2021 at 01:13:54PM +0200, Fabio M. De Francesco wrote:
>>>>> On Monday, September 20, 2021 12:36:06 PM CEST Greg KH wrote:
>>>>>> On Sat, Sep 18, 2021 at 10:52:50PM +0530, Saurav Girepunje wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 13/09/21 9:48 pm, Greg KH wrote:
>>>>>>>> On Fri, Sep 10, 2021 at 11:24:39PM +0530, Saurav Girepunje
> wrote:
>>>>>>>>> Remove the function power_saving_wk_hdl() as it just calling
>>>>>>>>> the rtw_ps_processor().Instead of power_saving_wk_hdl() call
>>> directly
>>>>>>>>> rtw_ps_processor().
>>>>>>>>>
>>>>>>>>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>>>>>>>>
>>>>>>>> []
>>>>>>>>
>>>>>>>> Also does not apply to my tree.  Please rebase against my
> staging-
>>> next
>>>>>>>> branch and resend.
>>>>>>>>
>>>>>>>> thanks,
>>>>>>>>
>>>>>>>> greg k-h
>>>>>>>>
>>>>>>>
>>>>>>> Hi Greg,
>>>>>>>
>>>>>>> I always do rebase against your staging-testing branch. Can you
> help
>>> me
>>>>> to
>>>>>>> understand.When we need to rebase on staging-next. Do we always
> need
>>> to
>>>>>>> rebase against staging-next..!
>>>>>>
>>>>>> Yes, you should.  When you are working on code that lots of other
>>> people
>>>>>> are working on, there will be conflicts like this, and you just
> need to
>>>>>> stay on top of it.
>>>>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>>>
>>>>>
>>>>> Sorry, Greg. I'm confused... :(
>>>>>
>>>>> As far as I know, everyone here make patches for staging-testing.
>>>>
>>>> Nope.  It's only you.
>>>
>>> And Saurav (at least) :)
>>>
>>
>> Nope.  Saurav is working against something old.  You can see the
>> #ifdef CONFIG_88EU_P2P stuff that was removed in commit 102243f893ec
>> ("staging: r8188eu: Remove conditionals CONFIG_88EU_{AP_MODE,P2P}") was
>> applied.
>>
> 
> Oh, I didn't notice that he was working against something old.
> 
> My attention was drawn only by the fact that Greg talked about staging-next,
> while I was expecting something like "please rebase and resend against my
> current staging-testing".
> 
>>> I've been misled and in turn I misled Pavel. This is due to a guide in
>>> kernelnewbies.org that explicitly says to use staging-testing:
>>>
>>> https://kernelnewbies.org/OutreachyfirstpatchSetup
>>>
>>> In that page the is a section ("Set up your Linux kernel code
> repository")
>>> which says: "[] Then use the revision control system called git to clone
> Greg
>>> Kroah-Hartman's staging tree repository: git clone -b staging-testing
> git://
>>> git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git".
>>>
>>
>> Huh...
>>
>> Those aren't *bad* instructions.  Working against testing-next is fine,
>> but just be aware that it can rebase.
> 
> Good to know. For what the series Pavel and I submitted we'll complete our
> work, that is sending v9, against current staging-testing. I suppose we'd
> better stay consistent.
> 
> For new work, since you make notice that we have to "be aware that it
> [staging-testing] can rebase", we'll switch to staging-next.
> 
> Thanks for pointing this out.
> 
> Regards,
> 
> Fabio
> 
>>
>> regards,
>> dan carpenter
>>
>>
> 
> 
> 
> 

I will also do rebase to staging-next.

Thanks Greg, Dan for you clarification.
Thanks Fabio for your input .

Regards,
Saurav
