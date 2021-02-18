Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0D31EF54
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhBRTK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbhBRRmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:42:43 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35947C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:42:03 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id f8so1641718plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sgTMUl/OFW+nHhWvUiUo/pFcYSW1SpmiRTvDTB80NzA=;
        b=g7o86jUXKtwLKqb/q8PBGPUlen+Z2YN2EJFGe2T23AyLLrRM7Ehb1O+gVi9zpiSQMI
         VkNpxldkxeIWBwLhhyLqEsrYOcsTuVryOjl/IkUPAVP+pBHSUFLmXn66W0WMFDZni5NU
         aLN6DyV49pgdz8CyiBXJb2ajbMIfTmVM7WlX6RzCJaeKtkNQgFhxsQBmVRmqqPokhyTR
         n36D/w5DnXPKQd62FDOf+WzPcsKGOlee8fbtl6qwfl5ZPd167jICAYBdgCrPwmJx5Fgg
         B+r5ar3YGzxRm1mOkt85Jd47iggM8hlMI8c9yqx6BeZA3UFTjmbc8NkHFrBOB9tBkR0Z
         QemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sgTMUl/OFW+nHhWvUiUo/pFcYSW1SpmiRTvDTB80NzA=;
        b=uacx8uw50gKXbu0JGXTkWQ4I1H/ci6cZR4CHYPrjwFcNtiVOO3g0gCWJW+g9rCwIGZ
         BHVyjDRuytsGokiF4/i2lC3G38sKYhsln+TqkIJqxMw7FuNv2+fLM9HKQtEW2swpXMdI
         c/OPsqyNRRNws0PJbyTWZA9hpoA2uEQA1PIkwsS2aMjZ8shTwtEk+aoTEZ+VKpfgZUe0
         ZkoV0TIpQZKMsENKUrqI3OdjLVBaKaqxa6iuA3b7qv5e0bEqxWCZt/Y2c86OFwZA6vgU
         o8HywdTD+7+iGhWDLth5eD0Ot1BvYhAl9xrTwal/vWKSsvd148P82aSom5hGxlWgXw+F
         i7sw==
X-Gm-Message-State: AOAM531VL7JfijFmKVINM5qfrzyz0V+hIYtujg+M3KQ1H5ys8ZR8aYZ8
        2sXi8XKOmB8OsLZtek5EImt61nDyUg8=
X-Google-Smtp-Source: ABdhPJwSSPxZbcme91I3hAl/BFHwsuVl3GlKaWF54ijXVEci985KvYZAbC7dGz578ycuEomqVQzmyQ==
X-Received: by 2002:a17:903:114:b029:e2:f8fb:b6a1 with SMTP id y20-20020a1709030114b02900e2f8fbb6a1mr4965651plc.77.1613670122526;
        Thu, 18 Feb 2021 09:42:02 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v1sm8225065pfi.99.2021.02.18.09.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 09:42:02 -0800 (PST)
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com> <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f2a03516-0247-522e-184a-7df4840ed345@gmail.com>
Date:   Thu, 18 Feb 2021 09:42:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/2021 11:48 AM, Scott Branden wrote:
> Hi Greg,
> 
> On 2021-02-17 1:40 a.m., Greg Kroah-Hartman wrote:
>> On Tue, Jan 26, 2021 at 07:51:18PM +0100, Greg Kroah-Hartman wrote:
>>> On Tue, Jan 26, 2021 at 10:30:16AM -0800, Scott Branden wrote:
>>>> Hi Greg,
>>>>
>>>>
>>>> On 2021-01-25 11:29 p.m., Greg Kroah-Hartman wrote:
>>>>> On Mon, Jan 25, 2021 at 11:55:11AM -0800, Scott Branden wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> The 5.10 LTS kernel being officially LTS supported for 2 years presents a problem:
>>>>>> why would anyone select a 5.10 kernel with 2 year LTS when 5.4 kernel has a 6 year LTS.
>>>>> Because they want to use all of the latest stuff that 5.10 provides
>>>>> them.  Don't you want faster and more secure kernels for your devices?
>>>> Yes, 5.10 is a more secure and less buggy kernel than 5.4.
>>>
>>> Great, use it, ship it to your customers and we are all happy.  What do
>>> you need me for any of this?  :)
>>>
>>>>>>   And AOSP has already declared the use
>>>>>> of 5.10 kernel in their Android S and T releases.
>>>>> Publically?  Where?  And is that really the name of the new Android
>>>>> releases, I thought they switched to numbers now (hence the naming of
>>>>> the current android-common kernel branches, marketing is fun...)
>>>> https://source.android.com/devices/architecture/kernel/android-common
>>>> Feature and launch kernels provides kernels supported per version.
>>>
>>> Oh nice, didn't know that.
>>>
>>> But note, Android kernels do not reflect the lifespan of LTS kernels.
>>> If that were the case, I would still be supporting 3.18 as they are
>>> doing that at the moment for their devices and customers, and will be
>>> doing so for I think another full year.
>>>
>>> So while Android is nice to see here, remember that is what Google is
>>> promising to support for their users.  You can do the same thing for
>>> your users, what do you need me here for this?  You can do the same
>>> thing that Google is doing for 3.18 right now, pick the stable fixes
>>> from upstream, backport them, test them, and push them out to their
>>> users.
>>>
>>> While Google is a great help to me in the LTS effort, providing huge
>>> amounts of resources to enable my life easier with this (i.e. funding
>>> Linaro's testing efforts), their promise to their customers/users does
>>> not depend on me keeping LTS kernels alive, if I stopped tomorrow their
>>> contracts are still in place and they know how to do this work
>>> themselves (as is proof with 3.18).
>>>
>>> So you can provide the same kind of guarantee to support any kernel
>>> version for any amount of time to any customer you like, it shouldn't
>>> require me to do that work for you, right?
>>>
>>>>>> Is there some way we could make the LTS support more clear.
>>>>>> A 2 year declaration is not LTS any more.
>>>>> Not true at all, a "normal" stable kernel is dropped after the next
>>>>> release happens, making their lifespan about 4 months long.  2 years is
>>>>> much longer than 4 months, so it still is a "long term supported" kernel
>>>>> in contrast, correct?
>>>> Perhaps a new name needs to be made for "LTS" for 6 years to distinguish it from 2 years.
>>>> The timeframes are very different.
>>>
>>> At this point in time, anyone wanting a kernel longer than 2 years
>>> should know how this all works.
>>>
>>> If not, please do some basic research, I have written whitepapers on
>>> this and given numerous talks.  The information is out there...
>>>
>>>>>> If 5.10 is "actually" going to be supported for 6 years it would be quite valuable to make such a declaration.
>>>>>> https://www.kernel.org/category/releases.html
>>>>> Why?  What would that change?
>>>>>
>>>>> Ok, seriously, this happens every year, and every year we go through the
>>>>> same thing, it's not like this is somehow new, right?
>>>> No, but why do we need to keep playing the same game every year now.
>>>
>>> Because, 5.4 almost did not become "6 years" of support from me.  That
>>> was because in the beginning, no one said they were going to use it in
>>> their devices and offer me help in testing and backporting.  Only when I
>>> knew for sure that we had people helping this out did I change the date
>>> on kernel.org.
>>>
>>> So far the jury is still out for 5.10, are you willing to help with
>>> this?  If not, why are you willing to hope that others are going to do
>>> your work for you?  I am talking to some companies, but am not willing
>>> to commit to anything in public just yet, because no one has committed
>>> to me yet.
>>
>> Following up on this as I did not hear back from you.  Are you and/or
>> your company willing to help out with the testing of 5.10 to ensure that
>> it is a LTS kernel?  So far I have not had any companies agree to help
>> out with this effort, which is sad to see as it seems that companies
>> want 6 years of stable kernels, yet do not seem to be able to at the
>> least, do a test-build/run of those kernels, which is quite odd...
> I personally cannot commit to supporting this kernel for 6 years
> (and personally do not want to backport new features to a 6 year old kernel).
> And customers are finicky and ask for one thing and then change their mind later.
> We'll have to see what decisions are made at a company level for this as there
> are added costs to run tests on LTS kernel branches.  We already run extensive QA on
> whatever active development branches are in use and a subset on the mainline
> branch as well.  QA resources are finite and committing those for 6 years is
> not something that makes sense if customers drop that kernel version.
> Testing of the LTS kernel changes really moves out of our hands and into the
> customer's testing after our major releases to them.

There are many different things, and I am not sure I follow you on all
counts.

If your customers are asking you for a 6 year LTS kernel, does not that
mean they themselves plan to commit to that time frame?

Assuming you are delivering a downstream kernel with all that is needed
to run on the hardware you support plus all the extra fancy stuff your
customers pay you for, what more do the customers do on top? Do they
happen to merge stable updates with your downstream tree, and why do
they do that, should not you be their upstream?

> 
> Other difficulty with the LTS version is the frequency it is updated.  We would not
> pickup the changes that frequently to test.  A quarterly, bi-annually, or when a critical fix
> is identified would be when we update and perform any meaningful testing when in maintainence.

Well you really have the best of both worlds here, you are not forced to
update your downstream fork of the stable kernel every week, though
bonus points if you do.

For instance I try to test all the stable release candidates for 4.9,
5.4 and 5.10, and merge the stable tags every week when they show up. We
do release to our customers every 6 weeks though, so usually they will
jump several stable releases, and they are fine with that.

Yes it takes time, but I would rather do that than have to continuously
respond to questions about is this CVE fixed in kernel X.Y.Z like it
used to be before we did that. It also helps catch problem faster before
customers do, the usual benefits of continuous integration/delivery.
-- 
Florian
