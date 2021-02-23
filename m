Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F43322A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhBWM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhBWM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:26:22 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B80FC061574;
        Tue, 23 Feb 2021 04:25:42 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id o38so12240437pgm.9;
        Tue, 23 Feb 2021 04:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QnraGrfKJNAuzXXyF+P/lQ9nJ4NmJUsr8wDqFM+qAdc=;
        b=B9tYIJ2ZtbhgYOYSgV9nO9ytK8kpwudwBaeVFnSQ3bmwKMBArML1cHY5cSkMAbJ1D0
         TKMn0OAFMu3skyau7AoAYsNyPXHtK1grug4tyTE2tk4gjf0IQ7xzCQqknj87CexzDG4x
         CSWg/T75EO3q89ggpk8KMpY7v8xiWtJZfBun2/yydEpO+mlh/Gxcq8VVDhJEebx7iEOZ
         1dyCKp9T9Vn9t0gInjqMmwUw12rdfN5X/IMN25wIs8t8O9UmM9z8fUdjVBz+mrWjmBK+
         rpzvkcVvIj3pOe3ASDwekn7Nm1A+WGjWa3wRU0I2DVx/4Xz2E4Lkobg0IL8EvvkW9yLz
         oDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QnraGrfKJNAuzXXyF+P/lQ9nJ4NmJUsr8wDqFM+qAdc=;
        b=PKHtcJAwRkIqEoAMLm7NfxiPhpQEVdPcGsRWOhsri2uIikqSZlPlihnBUVhWByv8vS
         bE8zT/m3bvMCi/bVmGMjSI0Bdf9RGJGceljr1m6frDAUqpEjeiUJ7U61n/kkS26lPJu0
         +/QFnKvSXhIBxO7hwenh6S9aieUaLAU4CoXLvHFwZim6G3Z5jkqa/s78olOpDoQn7j4D
         zjLtWXD6g0hypXJglzXLPSZvcAQTFLwdfMAbd1PCF85oKPLVuaR9FgQr3efeJZaTqqXu
         9KEmUgW4oN39rkDfsVt4ZzWRgaZwldzSdTFYSToxsOcKIqFP3bgN/ACikZAichapIQPr
         uEug==
X-Gm-Message-State: AOAM5316T9P8Sn3iQAjdcvWYXIRkIDRlyjrEJO//TTDRTXpXuDTGJkgj
        ZG3d5WDjxJ/DAnFDT2Q0AMI=
X-Google-Smtp-Source: ABdhPJzaWSkZQ3bMSfxPGDzMRFmrkTy+76NiJP/lU1IrVVIMzlFFlSFM97ne2LmTLQPR3q70RC8qng==
X-Received: by 2002:a63:c343:: with SMTP id e3mr2971411pgd.8.1614083142017;
        Tue, 23 Feb 2021 04:25:42 -0800 (PST)
Received: from ?IPv6:2405:201:600d:a089:71c8:9c21:1a6d:84ab? ([2405:201:600d:a089:71c8:9c21:1a6d:84ab])
        by smtp.gmail.com with ESMTPSA id h3sm21156348pgm.67.2021.02.23.04.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 04:25:41 -0800 (PST)
Subject: Re: [RFC] scripts: kernel-doc: fix typedef support for struct parsing
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     lukas.bulwahn@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210222160347.23410-1-yashsri421@gmail.com>
 <875z2jlr2j.fsf@meer.lwn.net>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <19d41289-cf8e-881d-cc0d-9c7e193db242@gmail.com>
Date:   Tue, 23 Feb 2021 17:55:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875z2jlr2j.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/2/21 3:10 am, Jonathan Corbet wrote:
> Aditya Srivastava <yashsri421@gmail.com> writes:
> 
>> There are files in kernel, which use 'typedef struct' syntax for defining
>> struct. For eg, include/linux/zstd.h, drivers/scsi/megaraid/mega_common.h,
>> etc.
>> However, kernel-doc still does not support it, causing a parsing error.
>>
>> For eg, running scripts/kernel-doc -none on include/linux/zstd.h emits:
>> "error: Cannot parse struct or union!"
>>
>> Add support for parsing it.
>>
>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>> ---
>>  scripts/kernel-doc | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>> index 8b5bc7bf4bb8..46e904dc3f87 100755
>> --- a/scripts/kernel-doc
>> +++ b/scripts/kernel-doc
>> @@ -1201,12 +1201,20 @@ sub dump_union($$) {
>>  sub dump_struct($$) {
>>      my $x = shift;
>>      my $file = shift;
>> +    my $decl_type;
>> +    my $members;
>>  
>>      if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
>> -	my $decl_type = $1;
>> +	$decl_type = $1;
>>  	$declaration_name = $2;
>> -	my $members = $3;
>> +	$members = $3;
>> +    } elsif ($x =~ /typedef\s+(struct|union)\s*\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*\s*(\w*)\s*;/) {
> 
> So this isn't your fault, but these regexes are really getting out of
> hand.  I would *really* like to see some effort made into making this
> code more understandable / maintainable as we tweak this stuff.  So:
> 
>  - Splitting out the common part, as suggested by Lukas, would be really
>    useful.  That would also avoid the problem of only occurrence being
>    edited the next tine we add a new qualifier.
> 
>  - Splitting out other subsections of the regex and giving them symbolic
>    names would also help.
> 
>  - We really could use some comments before these branches saying what
>    they are doing; it is *not* obvious from the code.
> 
> See what I'm getting at here?
> 
Yep.
Thanks for the feedback Lukas and Jonathan. I'll get back with a v2
for the patch.

Thanks
Aditya
