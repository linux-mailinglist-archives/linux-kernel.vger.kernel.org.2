Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE82340B032
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhINOEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbhINOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:04:13 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206F5C061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:02:56 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id j66so7031193oih.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VmARyCKCLelCekOleNK/gJNoLUWdrHJ2YTkB4fbGTPQ=;
        b=c0F9jZB7c/UKu9gzU2WL+Bn2OeGdOZCNdEd5xV+ucd/GNggMv6sYIvG9Fa+0mLVyAA
         gdk9d2MIWAe7AL+VCufLSMT0CcaTGkZbzwr6XA2AM09Y/7y89VAOilDandbULKuAsQ/a
         w0PcliZY2Vu9Mqe0ulnD63NZm/wKCupXmqxZT7d7TZKmG+BmAVoCEnAi6a/BqsHWMjR7
         a9G7TAWFnmwDIQ2XgRCq0GWTHWOOIIYlJnqN3A2JC6yP8qdQ2wkCbpEqoVYX84yhxT40
         R6485SM2kx1fqUZ3f6ItNvjyUVEIYGg7TjV3YhUgGEEAAWMJCAFHlVtsOesktjchF7j/
         WhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VmARyCKCLelCekOleNK/gJNoLUWdrHJ2YTkB4fbGTPQ=;
        b=zVHWFB0P7c9zx5t+tNdbxHaxEvXCeORymeyycZyHQzg/mNCiYdiFH7SmVQ3EnJ90TV
         KOy/ICYbwPc5R//cSi5hMkC4Vgm+6n/FPZyTkx5jkxI6Zhlrrjx2rVmtJHt2NpyW3YZg
         jjjCcpGHl0MITAjNRaXQGLZGOyQgcjfXrh/G/bigsuqpRVz13IcabznJNXOazT6gcK5V
         3WTa75AJvRRS7LtipN+iUuNe40JFlKOw2g6zn6nuHSVE0Xv6zTwN/+USnoa8S+r3luq6
         EKAtvZaRemUk4bZV69plfOKDHmBaB3Gu69SWQPNP8vqJz1AezbuYT/5ZYfkRpvXOtuhK
         uBVA==
X-Gm-Message-State: AOAM532ao9kREQ6E7o5bFj3oVqfgn0wNQHVS/3+m9OuLADLwIT4DLAHP
        8XrK/iVzgFCDbHY5Anv9ZJ8=
X-Google-Smtp-Source: ABdhPJyj86z96sdbZQ5zVB7U/pwsuyzdIcpcxeDcgmeO2lNTU/JY8kid8zJCw//k5cndyRacTwlypA==
X-Received: by 2002:a05:6808:5c7:: with SMTP id d7mr1553770oij.147.1631628175464;
        Tue, 14 Sep 2021 07:02:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v24sm2694339oov.18.2021.09.14.07.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 07:02:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
References: <20210912025235.3514761-1-linux@roeck-us.net>
 <315e4a23990444f585a15d2e23a39b8f@AcuMS.aculab.com>
 <46f59bf8-f243-b65c-07b3-8ecbf7b410fa@roeck-us.net>
 <CAMo8BfLOhr8Gw9RbSM_pVhgokDcBZ3PgwQAG6sCxDBAm_rMy7Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] xtensa: Increase size of gcc stack frame check
Message-ID: <a34cac4a-dc17-acf0-f24e-69c06217adb6@roeck-us.net>
Date:   Tue, 14 Sep 2021 07:02:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMo8BfLOhr8Gw9RbSM_pVhgokDcBZ3PgwQAG6sCxDBAm_rMy7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/21 12:04 AM, Max Filippov wrote:
> On Mon, Sep 13, 2021 at 9:11 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> The functions I checked typically have pretty large local data
>> (like, more than 700-800 bytes). The errors are only observed
>> with xtensa:allmodconfig test builds. While it may be arguable
>> if those functions really need that much data on the stack, it
>> is unreasonable to assume that all those errors (again, more
>> than 50) are ever going to get fixed, especially since the errors
>> are only seen with xtensa and not with any other architecture
> 
> That's not what I observe. If I build allmodconfig on v5.15-rc1
> for arm with gcc-8.3 I get 69 of them.
> 

Interesting. I had used gcc 11.2. Anyway, arm:allmodconfig sets
the limit to 2048 for me, for both gcc 8.3 and 11.2, due to
GCC_PLUGIN_LATENT_ENTROPY=y. But you are right, if I disable
GCC_PLUGIN_LATENT_ENTROPY and set the frame size to 1024,
I get lots of frame size errors on arm as well.

>> (including parisc; setting a stack limit of 1024 works just fine
>> with that architecture, at least with gcc 11.x). So the realistic
> 
> This comparison is a bit biased because allmodconfig on xtensa
> enables KASAN which is not supported by the parisc. Disabling
> KASAN roughly halves the size of stack frames for a few
> instances that I've checked.
> 

It wasn't meant to be biased or unbiased, just a (surprising)
observation. Maybe there is some configuration in parisc that
is not enabled with allmodconfig which increases the frame size.

I still don't think that those stack limit warnings (now errors)
will ever get fixed. Which is the point I was trying to make,
and your observation that the stack frames are really that large
because of KASAN just makes that argument stronger.

Other than that, it is not my call to make that to do with this
patch. If you think that it is inappropriate, by all means
reject it.

Thanks,
Guenter
