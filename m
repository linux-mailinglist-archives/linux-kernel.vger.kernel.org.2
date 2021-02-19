Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478D931FBA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 16:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBSPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 10:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBSPG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:06:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF43DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 07:05:45 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id ba1so3526972plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 07:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XiaBGnefPGVZiyojOjiX+s6W4j/8HRWeaHwUaEvX3fc=;
        b=Bx1NkyZMHAyZDfmo5hgwsduVDXIrfyfb2POhnhkcVDHh9IY/YaLRluW1in1fg6Xnw8
         ylll6X9unFr9/sy/SPV0JLpPge6MOoRWcWbrDrtv2fFjDvSYeueaP15cXjvOw0GnnNOP
         TqTfGWJOERAffqs0TTLlZza+YRdRPWaL3qzZrbFzKFGMvr7y+LBfptWMU1CbmvTD1lSL
         EXKjSrP63trB+VIAKo4RrYf1sDhppnkkLuiHN7m2m0F6/9O7/K2gHEp9cO8MvuT18+Qc
         cxE6+SIzdL+OXN992mJnSl7705567Oc2FUlfTH2uPsaC5tDQ8NqqAbphm+CRV6sQ4QgS
         v/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XiaBGnefPGVZiyojOjiX+s6W4j/8HRWeaHwUaEvX3fc=;
        b=SVGEAG+BYjzDbsxFrx5u+9rssYIMEu6/GEB9JZrQxwDhupj3bPl5qm36d+6wWaHmNN
         cNM9mDLMOrUnI6BCIOUO/BzGKwTBRGvtsV0wSUr7KLzLYy6zampNriAypdnmp8FRSvDX
         wdCMWEwzjI6beE5z9oNJ8pXSsE/VjvEJZ/0g+Dh5sphvdfRh1V0RAdRCI5pIQgze2N7Z
         8FYdJz2/pENVoWdeg6Yi5lnyCLbPUtREytpAOrVzTWeA6G3Mas7dzeosE5LsSVtfG4RI
         5MALECoYjgjMele4XdBfyu8xZcQ1OcfX5jmrfSLuOvvJRNTSrA/q5NUUcVVxqR6d+KXl
         gozA==
X-Gm-Message-State: AOAM533o916GEG0tnWKyOJJ4l0bIJ/70AAeSGeyBnGjSQtybWg4FtDYy
        HrZhIessjrB7pV1/3ueoxUo=
X-Google-Smtp-Source: ABdhPJz+6CD/YYOF6fSfyH4wNB/jxtQZvi5Da41tCFzko3AKufFgrGNHA8A7ANh3PZs0kxQRgFDkRg==
X-Received: by 2002:a17:902:aa4b:b029:e2:bb4b:a63 with SMTP id c11-20020a170902aa4bb02900e2bb4b0a63mr9430913plr.7.1613747145225;
        Fri, 19 Feb 2021 07:05:45 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 194sm9625165pfu.165.2021.02.19.07.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 07:05:43 -0800 (PST)
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Willy Tarreau <w@1wt.eu>, Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com> <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
 <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com> <YC6ptKgsMh20tmu6@kroah.com>
 <20210218182050.GB15217@1wt.eu> <YC6zq3u2jciI2gyZ@kroah.com>
 <b283eaa5-028f-a3d0-42a1-5b11c48ffe91@broadcom.com>
 <YC915N/9YNqePueL@kroah.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <cf9323b7-71c8-dd96-1755-ce90370af6d5@gmail.com>
Date:   Fri, 19 Feb 2021 07:05:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YC915N/9YNqePueL@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/2021 12:25 AM, Greg Kroah-Hartman wrote:
> On Thu, Feb 18, 2021 at 12:16:50PM -0800, Scott Branden wrote:
>> On 2021-02-18 10:36 a.m., Greg Kroah-Hartman wrote:
>>> On Thu, Feb 18, 2021 at 07:20:50PM +0100, Willy Tarreau wrote:
>>>> On Thu, Feb 18, 2021 at 06:53:56PM +0100, Greg Kroah-Hartman wrote:
>>>>> On Thu, Feb 18, 2021 at 09:21:13AM -0800, Florian Fainelli wrote:
>>>>>> As a company, we are most likely shooting ourselves in the foot by not
>>>>>> having a point of coordination with the Linux Foundation and key people
>>>>>> like you, Greg and other participants in the stable kernel.
>>>>>
>>>>> What does the LF have to do with this?
>>>>>
>>>>> We are here, on the mailing lists, working with everyone.  Just test the
>>>>> -rc releases we make and let us know if they work or not for you, it's
>>>>> not a lot of "coordination" needed at all.
>>>>>
>>>>> Otherwise, if no one is saying that they are going to need these for 6
>>>>> years and are willing to use it in their project (i.e. and test it),
>>>>> there's no need for us to maintain it for that long, right?
>>>>
>>>> Greg, please remember I expressed I really need them for slightly more than
>>>> 3 years (say 3.5-4) :-) I'm fine with helping a bit more as time permits if
>>>> this saves me from having to take over these kernels after you, like in the
>>>> past, but I cannot engage on the regularity of my availability.
>>>
>>> Ok, great!
>>>
>>> That's one person/company saying they can help out (along with what CIP
>>> has been stating.)
>>>
>>> What about others?  Broadcom started this conversation, odd that they
>>> don't seem to want to help out :)
>> Greg, I'm sorry but I'm not in a position to provide such a commitment.
> 
> Ok, who at Broadcom do I need to talk to to get that type of commitment?

I am not sure if I was too subtle before, we (Broadcom) cannot give you
an unified voice to speak with because we are divided in silos/business
units that make their independent decisions.

The group I work in (STB/CM, different from Scott's) is committed to
using the 5.10 kernel for 6 years and that is a decision that has been
taken.

I could give you names of other decision makers in other business units
I know who also deliver Linux for their respective business units
however some of them may not make public appearances on mailing lists,
let alone care about upstreaming their changes so I do not know whether
a 6 years 5.10 kernel is even something they remotely entertain.

Hope this helps.
-- 
Florian
