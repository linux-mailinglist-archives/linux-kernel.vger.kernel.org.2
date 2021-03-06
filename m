Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1660832F8D3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 08:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhCFHtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 02:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhCFHsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 02:48:46 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B7FC06175F;
        Fri,  5 Mar 2021 23:48:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so369830pjh.1;
        Fri, 05 Mar 2021 23:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DSZXu94+R555WhtuFMRch+eV8hmVBvr/x43d2hheJJc=;
        b=VluraUHuZsIPa2k+Kvj6GH7BSkPT41eqr4M/CQ/PUSvCotnYQfO6dOYS7/3E6EecX2
         2+MnYrBdCyZRgy4So3JceeAQkU/QAp5BVIV74Lefs08LkPlmCV5ZdKJreID3r/1VeepX
         q3McCPKRMX8szQ0hAEX13XyB7Z6raB0oihzyt7ukQ23MDkt5uzxTnXfexj4ogbw20IFC
         bQNvhn0GKIv4RtUmsgauvLn4+PnLWHrk5RjHRBfv5Xofv1r8w88hhM4ZWZoxZkong2DQ
         e5v4d5dAUmMeZQyHpOeCU5apI0HruD/KYJyLElAZXp72x7+ifWCkAtMcmOuVZ3CKAGvf
         n/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DSZXu94+R555WhtuFMRch+eV8hmVBvr/x43d2hheJJc=;
        b=Eej4gghUT23gHEMEYu2p0HNGy5Rhp2BMFRXixwXKBC3c+EUj06FkDRula27ORtv8n7
         oV6RhyudEAesWhACo9KeaYcB9vBi/kNy/rjDJQ5hc8ikW19oQ8bs9NpbDWelk5iIbtEM
         PsDOhef4SVxzc++Ma0IKgb03Z5HIRhgodeZFrvoedf+vyXIKBbvVNbNEf7SL78MgvF1J
         Re3PqpcykHJ/ye3ryQHo4DP//BlJvcjhyCZ2NE9RojAns4UQOEjRe9Bs/Egwqp2Xz1Bi
         5UCnGwzU9qWmG7fXpKRX4wzJlqYG2tQBDfbOold3hzaEgv1vRnUpLCJw70aSA9vHFg+1
         aQJg==
X-Gm-Message-State: AOAM530htLptfGKb8as6bP8g4N6FgYj+Eynm7y0ztrHLLsojzDR23Ojb
        Fd12s4I/53fUmIxO5C5rOr8=
X-Google-Smtp-Source: ABdhPJx9oouAzAWFEXuhiUUwFZmuNk93Mo4/2GAEE/laT9yMPbZYkKWgCky8dE7eqgyhymy47DspLw==
X-Received: by 2002:a17:902:b7cb:b029:e4:55cd:ddf0 with SMTP id v11-20020a170902b7cbb02900e455cdddf0mr11953507plz.45.1615016925270;
        Fri, 05 Mar 2021 23:48:45 -0800 (PST)
Received: from ?IPv6:2405:201:600d:a089:2cbb:f743:ffa5:41bc? ([2405:201:600d:a089:2cbb:f743:ffa5:41bc])
        by smtp.gmail.com with ESMTPSA id x23sm4452314pff.133.2021.03.05.23.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 23:48:44 -0800 (PST)
Subject: Re: [RFC v3] scripts: kernel-doc: fix typedef support for
 struct/union parsing
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <CAKXUXMzHPnM=ie06ZGuFXyJ7RcRjYomjyASbp3ND9-Mb2Es+2w@mail.gmail.com>
 <20210225145033.11431-1-yashsri421@gmail.com>
 <20210306043548.GO2723601@casper.infradead.org>
 <CAKXUXMwD_ZZA7EJaxZBRfMDEvwd4Ghsj2vy9KCfj0R-yx2_K0Q@mail.gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <6a75c9f4-460f-f83e-7fe2-5a3a4c64232b@gmail.com>
Date:   Sat, 6 Mar 2021 13:18:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMwD_ZZA7EJaxZBRfMDEvwd4Ghsj2vy9KCfj0R-yx2_K0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 11:55 am, Lukas Bulwahn wrote:
> On Sat, Mar 6, 2021 at 5:35 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Thu, Feb 25, 2021 at 08:20:33PM +0530, Aditya Srivastava wrote:
>>> +++ b/scripts/kernel-doc
>>> @@ -1201,12 +1201,23 @@ sub dump_union($$) {
>>>  sub dump_struct($$) {
>>>      my $x = shift;
>>>      my $file = shift;
>>> +    my $decl_type;
>>> +    my $members;
>>> +    my $type = qr{struct|union};
>>> +    # For capturing struct/union definition body, i.e. "{members*}qualifiers*"
>>> +    my $definition_body = qr{\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*};
>>> -    if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
>>> -     my $decl_type = $1;
>>> +    if ($x =~ /($type)\s+(\w+)\s*$definition_body/) {
>>> +     $decl_type = $1;
>>>       $declaration_name = $2;
>>> -     my $members = $3;
>>> +     $members = $3;
>>> +    } elsif ($x =~ /typedef\s+($type)\s*$definition_body\s*(\w+)\s*;/) {
>>> +     $decl_type = $1;
>>> +     $declaration_name = $3;
>>> +     $members = $2;
>>> +    }
>>
>> In the same spirit as dump_function, would something like this work?
>>
> 
> I agree. That might be a suitable clean-up to keep the code for
> functions and struct/union parsing similar in style/spirit.
> 
> Aditya, would you like to create a patch for that?
> 

Sure Lukas.
I have a doubt though, Can't we use a single expression separated by
"|" here, instead of multiple lines? i.e.,

$x =~
s/__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)\s*//;


Probably we could do something similar for dump_function, i.e.,
-    $prototype =~ s/^static +//;
-    $prototype =~ s/^extern +//;
-    $prototype =~ s/^asmlinkage +//;
-    $prototype =~ s/^inline +//;
-    $prototype =~ s/^__inline__ +//;
-    $prototype =~ s/^__inline +//;
-    $prototype =~ s/^__always_inline +//;
-    $prototype =~ s/^noinline +//;

+    $prototype =~
s/^(?:static|extern|asmlinkage|__?inline__?|__always_inline|noinline) +//;
And so on for other regexps.

What do you think?

Thanks
Aditya
