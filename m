Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C4E32FF83
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 08:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhCGHgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 02:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhCGHgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 02:36:06 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE5AC06174A;
        Sat,  6 Mar 2021 23:36:06 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id kx1so1400373pjb.3;
        Sat, 06 Mar 2021 23:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uKTFoNSndRX4SlCjlrIyTvDGYlDZG2N55rMO+ELI0qU=;
        b=I8BG7lVXrEj5VoT6+CQqfwf5C4c/3lOvXYEWsknxk+BWaRH6VyTJ6sewTkGebGljQR
         kd6pQ95DiYbhsuEvALprxkGG8o+wJf7ZxdM90IbSYZQ81cfj1c+tx+pLPH23YwcsgKXo
         zKmCaAC6GnyKDbFr5gjFzWhHjjsfkctvxa1ATgh8FwVDb2C/td676eMXM0qo7tbIWhjW
         XA+WocJXsnuQmyZffeirde1KddG6NFFPRuZrdZiUWxxMyNMA3OgAK+Q5+vwdbTlv6oNQ
         JN0BougCMjz13oIS1jGbPh3f5Vc/uSkmaGQkue8aIIbMvfqjzkVpaHxCOoBMZHjtFmCe
         8h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uKTFoNSndRX4SlCjlrIyTvDGYlDZG2N55rMO+ELI0qU=;
        b=IaC3noZD6qMCw2c71QFN+0kV8TOxHewEsxswu9G9yq31MdoiDphRlnuvhclTb09t+7
         YclWwxeFgtSUfqlBkiN+foFWWzJX5V5h/dMHCXSJhc569hGUkHs2Mrp2xTHnRM2cpcfQ
         1pVLYqWUSdeS4Fer5bLYlO+Cnr+76LM/Hm/7QnZr0PWSut7WwGLJz5pg0tN1HA+nq4h7
         K9T44qBLUCnRUw1aMo5k86eBgBMOEIf2ORN2M6a94K5DXKZtVeo7ObehB4EEAcw16j6Q
         QYCNuXZLqMa9W95Rnw4aNtRZbpRnc8x0yaXdYYT6RBb/0rADefZ0VJTN7NhV+n5ZazQp
         xZAw==
X-Gm-Message-State: AOAM532vIwVJTZOofqE0BZOQeiEMGQ5HS79kEHrFRY9v8Ct+lkkPR1eD
        YZHnWBxHea2Ros3tQJIe5Kfzhyjp4KwzwpuS
X-Google-Smtp-Source: ABdhPJxi677DhB/Abs4FPlKBS1Vi6AMpM5RLakMx4cIvbV9WE3AFgIWFIzOw/0cDKEBaOF29/oWLkw==
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr18166436pji.172.1615102566122;
        Sat, 06 Mar 2021 23:36:06 -0800 (PST)
Received: from ?IPv6:2405:201:600d:a089:7154:efa8:e27f:8a00? ([2405:201:600d:a089:7154:efa8:e27f:8a00])
        by smtp.gmail.com with ESMTPSA id e12sm6782956pjj.23.2021.03.06.23.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 23:36:05 -0800 (PST)
Subject: Re: [RFC v3] scripts: kernel-doc: fix typedef support for
 struct/union parsing
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <CAKXUXMzHPnM=ie06ZGuFXyJ7RcRjYomjyASbp3ND9-Mb2Es+2w@mail.gmail.com>
 <20210225145033.11431-1-yashsri421@gmail.com>
 <20210306043548.GO2723601@casper.infradead.org>
 <CAKXUXMwD_ZZA7EJaxZBRfMDEvwd4Ghsj2vy9KCfj0R-yx2_K0Q@mail.gmail.com>
 <6a75c9f4-460f-f83e-7fe2-5a3a4c64232b@gmail.com>
 <20210306152001.GP2723601@casper.infradead.org>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <a4d42880-4a91-e5ca-5096-bef498481039@gmail.com>
Date:   Sun, 7 Mar 2021 13:06:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210306152001.GP2723601@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 8:50 pm, Matthew Wilcox wrote:
> On Sat, Mar 06, 2021 at 01:18:38PM +0530, Aditya wrote:
>> On 6/3/21 11:55 am, Lukas Bulwahn wrote:
>>> I agree. That might be a suitable clean-up to keep the code for
>>> functions and struct/union parsing similar in style/spirit.
>>>
>>> Aditya, would you like to create a patch for that?
>>
>> Sure Lukas.
>> I have a doubt though, Can't we use a single expression separated by
>> "|" here, instead of multiple lines? i.e.,
>>
>> $x =~
>> s/__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)\s*//;
>>
>>
>> Probably we could do something similar for dump_function, i.e.,
>> -    $prototype =~ s/^static +//;
>> -    $prototype =~ s/^extern +//;
>> -    $prototype =~ s/^asmlinkage +//;
>> -    $prototype =~ s/^inline +//;
>> -    $prototype =~ s/^__inline__ +//;
>> -    $prototype =~ s/^__inline +//;
>> -    $prototype =~ s/^__always_inline +//;
>> -    $prototype =~ s/^noinline +//;
>>
>> +    $prototype =~
>> s/^(?:static|extern|asmlinkage|__?inline__?|__always_inline|noinline) +//;
>> And so on for other regexps.
>>
>> What do you think?
> 
> I think there's a tradeoff between speed / compactness and readability.
> As someone who doesn't know perl particularly well, I can look at the
> series of lines and say "Oh, it's stripping out these unwanted things".
> Your one line, while undoubtedly more efficient, is considerably less
> easy to understand.
> 
> Maybe there's another way to do it that's more efficient while not
> sacrificing the readability?
> 
> Also, would your suggestion work for 'static inline void foo(void)'?
> I think it needs to remove multiple occurrences of the things in the
> regex.  

Ah, I get it.

But maybe that's what the ?: on the beginning is for?
> 

No, "?:" is just to use this regex for matching, without capturing.
So, the regex will just remove any of those 'starting' occurrences,
consequently, "static inline" occurrence will probably not be removed.
I think the reason for using multiple lines for substitution in
dump_function is for the same reason, ie, subsequent substitution.

But for dump_struct, it is probably not desired, i.e., subsequent
substitution/removal. Also, for the same reason, using it with
dump_struct may cause unwelcomed discrepancies, or cause the user to
understand that here multiple substitutions are required, but is not so.
So, I think that we should use a single expression substitution for
dump_struct, at best. But am not sure if that is required, as
currently also we are not capturing this part of the regex, as well
as, matching only at certain position of the definition expression.

But I am curious to what others think about this.
Will be happy to work on this patch :)

Thanks
Aditya
