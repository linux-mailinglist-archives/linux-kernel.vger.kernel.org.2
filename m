Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF1E31FE23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBSRpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBSRpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:45:06 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FD6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 09:44:26 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id p21so5074931pgl.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 09:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jm0/MjDJ0YFq1nTaFASLA85Anos5rJfXR1qJ+1DOtMY=;
        b=JI4ZYox+H5QYdnAfmqRE7RFXlhVS224uO13Q/KnP/hgsgo/5hGMF6YzAuxOPEXS4+S
         WzcX6WZpiOVixcPHS9RvicFxGnJPq+VJsOAfUteKr4Glg3dFoZegnSbvBJKNB8dDU3T2
         4A/4SUvAih7s+fIB8AYaKAiwJOZ8lffS4QQe5roWSEuJijxquK6IDzrZADKd3bMXAsRL
         qho9axgK2RBrjOPFMtX89sV4Bnrrq/NBnsN2X3Zz1JMhlKXM8LMlhlCKOFQqcYPgAo6p
         7E1Vzsr1z0QaHT1Pz4DFXAUuGiwZgeWrvLyfe6OR9LoHcFsBk7dsuvaRNXAmkMAqLJHp
         1H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jm0/MjDJ0YFq1nTaFASLA85Anos5rJfXR1qJ+1DOtMY=;
        b=M7oySDKtL0rSCRBrnvHdfTFhRIVOyUT25X1DP8WY0LnZyvGLGnf3gANXZqlSmYKGZ0
         4mwo2sQo7N5mRU/gbaryu5/geJlbJxbCExT7L8x3KZ1TdJOd04XlbQigG79mRYcCnvBl
         1GN0ZYlCtP0gOqQz7s4o+K2rtz1Cb0FzA/M4/VBzuorNv2j38rjhTpEUwF7NstAcAFeF
         GJXyBMjaja/9UEENj/Z8eEXyVfcw8KrhQ4degFPJZtf9ViSagTFzkrL2S4Jt/B4TM5ne
         y3/zbes1MnSikze6i1qO8ztU/5A0AIKjMkx3Zb5xdQmn0dCaxQQP3dKRF4awpYtPg1kk
         8CwA==
X-Gm-Message-State: AOAM5303102idDZLn0oNpOg4TCAZdzVqzZtFTASbbycizhfJpkPts6O1
        flWkrlYUYhaqaR8QJh2k9Dg=
X-Google-Smtp-Source: ABdhPJy8a3ILU8qyq4PD0fTDz2nR8e63P94DRT948FzxxqJkM+P4us1YXMV8R4cIRWGAa+l+bnM6jw==
X-Received: by 2002:a62:e401:0:b029:1ec:fdce:b052 with SMTP id r1-20020a62e4010000b02901ecfdceb052mr10194479pfh.79.1613756666011;
        Fri, 19 Feb 2021 09:44:26 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 11sm9442205pgz.22.2021.02.19.09.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 09:44:25 -0800 (PST)
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Willy Tarreau <w@1wt.eu>, Sasha Levin <sashal@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
 <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com> <YC6ptKgsMh20tmu6@kroah.com>
 <20210218182050.GB15217@1wt.eu> <YC6zq3u2jciI2gyZ@kroah.com>
 <b283eaa5-028f-a3d0-42a1-5b11c48ffe91@broadcom.com>
 <YC915N/9YNqePueL@kroah.com> <cf9323b7-71c8-dd96-1755-ce90370af6d5@gmail.com>
 <YC/e93UHxa8V9Q6I@kroah.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f3d66398-667a-4b6b-e431-e923f8ffa079@gmail.com>
Date:   Fri, 19 Feb 2021 09:44:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YC/e93UHxa8V9Q6I@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/2021 7:53 AM, Greg Kroah-Hartman wrote:
> On Fri, Feb 19, 2021 at 07:05:41AM -0800, Florian Fainelli wrote:
>>
>>
>> On 2/19/2021 12:25 AM, Greg Kroah-Hartman wrote:
>>> On Thu, Feb 18, 2021 at 12:16:50PM -0800, Scott Branden wrote:
>>>> On 2021-02-18 10:36 a.m., Greg Kroah-Hartman wrote:
>>>>> On Thu, Feb 18, 2021 at 07:20:50PM +0100, Willy Tarreau wrote:
>>>>>> On Thu, Feb 18, 2021 at 06:53:56PM +0100, Greg Kroah-Hartman wrote:
>>>>>>> On Thu, Feb 18, 2021 at 09:21:13AM -0800, Florian Fainelli wrote:
>>>>>>>> As a company, we are most likely shooting ourselves in the foot by not
>>>>>>>> having a point of coordination with the Linux Foundation and key people
>>>>>>>> like you, Greg and other participants in the stable kernel.
>>>>>>>
>>>>>>> What does the LF have to do with this?
>>>>>>>
>>>>>>> We are here, on the mailing lists, working with everyone.  Just test the
>>>>>>> -rc releases we make and let us know if they work or not for you, it's
>>>>>>> not a lot of "coordination" needed at all.
>>>>>>>
>>>>>>> Otherwise, if no one is saying that they are going to need these for 6
>>>>>>> years and are willing to use it in their project (i.e. and test it),
>>>>>>> there's no need for us to maintain it for that long, right?
>>>>>>
>>>>>> Greg, please remember I expressed I really need them for slightly more than
>>>>>> 3 years (say 3.5-4) :-) I'm fine with helping a bit more as time permits if
>>>>>> this saves me from having to take over these kernels after you, like in the
>>>>>> past, but I cannot engage on the regularity of my availability.
>>>>>
>>>>> Ok, great!
>>>>>
>>>>> That's one person/company saying they can help out (along with what CIP
>>>>> has been stating.)
>>>>>
>>>>> What about others?  Broadcom started this conversation, odd that they
>>>>> don't seem to want to help out :)
>>>> Greg, I'm sorry but I'm not in a position to provide such a commitment.
>>>
>>> Ok, who at Broadcom do I need to talk to to get that type of commitment?
>>
>> I am not sure if I was too subtle before, we (Broadcom) cannot give you
>> an unified voice to speak with because we are divided in silos/business
>> units that make their independent decisions.
> 
> That's fine, I'm totally used to that, large (and even small) companies
> always have different groups with different roadmaps and policies.
> 
>> The group I work in (STB/CM, different from Scott's) is committed to
>> using the 5.10 kernel for 6 years and that is a decision that has been
>> taken.
> 
> Great!  Will you all be testing the -rc releases and letting me know how
> they work for your systems?

Yes I will, can you add me to your CC list for the stable candidates?
That helps me not having to dig for those announcements specifically.

> 
>> I could give you names of other decision makers in other business units
>> I know who also deliver Linux for their respective business units
>> however some of them may not make public appearances on mailing lists,
>> let alone care about upstreaming their changes so I do not know whether
>> a 6 years 5.10 kernel is even something they remotely entertain.
> 
> That's fine, I'm not expecting emails from the list, we can take this
> off-list if you like as it sounds like I need to talk to some different
> managers there, right?  :)

I will put together a list and send you an email off list.
-- 
Florian
