Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DC0409875
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345670AbhIMQM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbhIMQMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:12:55 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AE7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:11:39 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso14057183otu.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pF05lJj4lNy2tE9FXorSLt5VhlGQ+NsTtocuOEsRASU=;
        b=nUn0QCbJ0IAMISgDmqkAYu1iK2EWcDmRXhy0FCpX2QZE0CNs+xak6z+P6NU1Xbo27K
         vB4cdBZJ6i+9nIl99sZcFI91QoKrJLwtK0QoPAd6HMlzlfON18pDJZA9f6HuYjXoc9JQ
         l0w7qpUoIfr21ochi8bBpVSlzsMt7rBvuWBEnBlo40xBl2gPOLjbmrfO2ATWeg0h5jry
         RwhBWmdluIk2MMA5Q69hPhPpvaIMdyF8SrE6LmRkgXv0OHPBnXw1Ce0DFhqMXsAjCXEY
         hkOwjrY1hnENZ5vpfASN4TQdIxvb0d6H0uo/5BTgIsQusq7jf9R2MuaRMYNAy69nq8LC
         ByNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pF05lJj4lNy2tE9FXorSLt5VhlGQ+NsTtocuOEsRASU=;
        b=QQhsy9LKde64RVxMcx8UY6+Zxg/gOckkjbAZT08qJcDZokl9dEDaSu7XcERiw1Wc9G
         EtPmqkEs2amZ8QnMU57G9cUc2X1E15JNd1MKHqrO9deCY1ybByArEc9id9pi4+ht1tc1
         GQK1q+nDRW578MKNmBQCllr5+yghNPIUPIyRLGZhld/oQOa0NdP0rfGU+j0OoSVZT+6B
         K9af9tGbWJFNabJUb3lwacyYb2k9wi+xlPwWVVZcYNSZ7iCpaC+SG/fQDdkguOw8vuTZ
         FymrZWU7VmTnaH1PP8LiXZG63NOfyfUnfjS4qtVqy7WgKTEBk+xNW+uGEgJiw4pj4S/p
         mnvw==
X-Gm-Message-State: AOAM530mbKNtsk6qosu4ys9VXzEZltN2t0jhI9NctxOgzH83uF0y+Z9n
        u03aH/8UNtgMH5SUV7m9ICY=
X-Google-Smtp-Source: ABdhPJzsgKf3WKH8fP1W+h9snAHV/O3HMbv1bH0ypEQHKa2OCdwW3gkUXmXUb5k1TUGmTvjxOphSiQ==
X-Received: by 2002:a9d:38d:: with SMTP id f13mr10299861otf.66.1631549498900;
        Mon, 13 Sep 2021 09:11:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b24sm1796190oic.33.2021.09.13.09.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 09:11:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
References: <20210912025235.3514761-1-linux@roeck-us.net>
 <315e4a23990444f585a15d2e23a39b8f@AcuMS.aculab.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] xtensa: Increase size of gcc stack frame check
Message-ID: <46f59bf8-f243-b65c-07b3-8ecbf7b410fa@roeck-us.net>
Date:   Mon, 13 Sep 2021 09:11:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <315e4a23990444f585a15d2e23a39b8f@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 8:57 AM, David Laight wrote:
> From: Guenter Roeck
>> Sent: 12 September 2021 03:53
>>
>> xtensa frame size is larger than the frame size for almost all other
>> architectures. This results in more than 50 "the frame size of <n> is
>> larger than 1024 bytes" errors when trying to build xtensa:allmodconfig.
>>
>> Increase frame size for xtensa to 1536 bytes to avoid compile errors
>> due to frame size limits.
> 
> Have you done anything to check what happens at run-time?
> I'd guess that the deepest stack use is inside printk() in
> some obscure error path.
> 
> In reality all these 1k+ stack frames need killing
> rather than the limit for the compiler warning increased.
> 
> While it may be sensible for a system call entry function
> so allocate a reasonable size buffer on stack (as poll()
> and sendmsg() probably do) allocating big buffers way
> down the call stack could easily cause stack overflow.
> Even a 1k stack frame is huge.
> 

The functions I checked typically have pretty large local data
(like, more than 700-800 bytes). The errors are only observed
with xtensa:allmodconfig test builds. While it may be arguable
if those functions really need that much data on the stack, it
is unreasonable to assume that all those errors (again, more
than 50) are ever going to get fixed, especially since the errors
are only seen with xtensa and not with any other architecture
(including parisc; setting a stack limit of 1024 works just fine
with that architecture, at least with gcc 11.x). So the realistic
options are:

1) accept this or a similar patch
2) stop build testing xtensa:allmodconfig
3) Manually disable CONFIG_WERROR when test building xtensa:allmodconfig

As it looks like, I'll probably implement option 3) in my test builds.
I planned to start doing that around v5.15-rc4/rc5, but I may do it
earlier if it is becoming obvious that the now-errors won't get fixed.

Guenter
