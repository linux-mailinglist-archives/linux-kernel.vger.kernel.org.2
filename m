Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7FD337F55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhCKVEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKVEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:04:02 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424D0C061574;
        Thu, 11 Mar 2021 13:04:02 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id l7so397314pfd.3;
        Thu, 11 Mar 2021 13:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ALluUOsoSqK4P+is/Y65pRMrQ+pvKVSisjX8vHlvv0Y=;
        b=L+SgzsufpGKpowTezzieLVjENQonW5ufjAo6UGxYlvwEYAI4R3Qj8ejfabUzZ/E35o
         eP9qU2CcWjrsiUp0VsPN31ep4vrG2ZKq3HcgPOxDBjbUXCYSXAWaZ+pmUCv+heU0V5oW
         /N+1KeI7yCDxPza1UrJh8a7SkpoEKLDHq4B+3hXsZXbrxyg/dy+zV98l3aAz6sMVOA3s
         Hjit8bp39EJkvN5r58j4op+3TcIFxih28ZAKczlzbdGAvz2SPAuwELFxIL8tExshpE0O
         NiOLjc2mc0mkMvJuD1RhE5BztpkbE4VkrEIxUTb2+BzrwzAHTdIVr3aSp3zFY9z7YoB6
         XjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ALluUOsoSqK4P+is/Y65pRMrQ+pvKVSisjX8vHlvv0Y=;
        b=Uc1M5jn0UHjh8u8B6BV4mmrqApdHu7o70oTM+Q6QSoo0yiHmSTjFdLE2ko2zrWCVMB
         eGjsQ6z+F9Nk+egA2QPi7GNVUT5+Fit+xGqATfBzFlVwY9+50Pg+qNHJjXHuSntHXhJ3
         9JDRDwblzSeNZswTa3ul/+fAIBxYtRz3qAr0IHHDeIPe0tTUO13ORbNrKImNn64xhHXj
         u9z/kNiZz8cVu8nIHDCGreJCw8j6oRV0tquz7PczQMP1QvhVtc0cjYsPqgGg5j4YSAYp
         OZaQkhdAm5Z+v5I5i9EgB67t4o44ajCHRafXkyPAujU3YHzUnBmedjjxmLP59Age3qtB
         mF2Q==
X-Gm-Message-State: AOAM5326HNjOl/NQJSvD015SASVlcGru3FVVYqJgmDQB97uEm2WRigVO
        pwPsLnSvD3EikrZnz9/CWNzyeFPF0UpO2RNe
X-Google-Smtp-Source: ABdhPJwkBvX01oEU2foX84xttZrz/R4IafR2gkTb0wcgibS6UEN6hIYEQ+Oza7/LP/IS8mv91M7qkQ==
X-Received: by 2002:a63:161c:: with SMTP id w28mr8872540pgl.341.1615496641519;
        Thu, 11 Mar 2021 13:04:01 -0800 (PST)
Received: from ?IPv6:2405:201:600d:a089:c1b4:679a:535a:d260? ([2405:201:600d:a089:c1b4:679a:535a:d260])
        by smtp.gmail.com with ESMTPSA id s28sm3336112pfd.155.2021.03.11.13.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 13:04:01 -0800 (PST)
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210309125324.4456-1-yashsri421@gmail.com>
 <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
 <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com>
 <CAKXUXMwg7Vs5hm_X3ZHJj9309w5VYbnNeqXaajHBHS1oAKQydw@mail.gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <838a823b-f3fd-ed1b-70d1-82611f9f4ada@gmail.com>
Date:   Fri, 12 Mar 2021 02:33:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMwg7Vs5hm_X3ZHJj9309w5VYbnNeqXaajHBHS1oAKQydw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/21 11:49 am, Lukas Bulwahn wrote:
> On Tue, Mar 9, 2021 at 10:24 PM Aditya <yashsri421@gmail.com> wrote:
>>
>> On 9/3/21 7:00 pm, Markus Heiser wrote:
>>>
>>> Am 09.03.21 um 13:53 schrieb Aditya Srivastava:
>>>> Starting commented lines in a file mostly contains comments describing
>>>> license, copyright or general information about the file.
>>>>
>>>> E.g., in sound/pci/ctxfi/ctresource.c, initial comment lines describe
>>>> its copyright and other related file informations.
>>>
>>> The opening comment mark /** is used for kernel-doc comments [1]
>>>
>>> [1]
>>> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#how-to-format-kernel-doc-comments
>>>
>>
>> Hi Markus!
>> That's true. But the content inside the comment does not follow
>> kernel-doc format.
>> For e.g., try running kernel-doc -none/man/rst on the above file in
>> the example("sound/pci/ctxfi/ctresource.c").
>> The starting 2-3 lines in files generally do not contain any
>> struct/enum/function, etc. declaration.
>>
> 
> Aditya, can you provide a diff of the warnings over the whole kernel tree?
> 
> At the moment, your patch just implements ignoring the initial
> comment, which probably is good for experimentation.
> 
> Alternatively, we could simply have a dedicated warning and then
> ignore it or even warn and then parse it as-if.
> 
> In the "long run", we would probably want to fix all current files in
> the repository by just replacing '/**' by '/*' and have kernel-doc
> warn about this suspicious pattern, when new files appear (maybe even
> configurable, but that is another feature to enable or disable certain
> kernel-doc checks and warnings). I would certainly assist and
> contribute to such a clean-up task.
> 
> I think the first step is to look at the diff, and see how many cases
> really appear in the tree... then check how many patches throughout
> the whole tree are required and if they are generally accepted.
> 

Hi Lukas!
This is the diff of the warnings over kernel tree before and after
applying these changes.
There are 2 sections in this report:
1) for the warnings present before, but not after, and;
2) after but not before

The part (2) contains, for some cases, where the warning for "warning:
Incorrect use of kernel-doc format:" type has changed to "warning:
wrong kernel-doc identifier on line:" type.

The diff file can be found at:
https://github.com/AdityaSrivast/kernel-tasks/blob/master/random/kernel-doc/avoid_init_line_diff.txt


Thanks
Aditya
