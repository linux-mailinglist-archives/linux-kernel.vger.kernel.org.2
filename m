Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15199388AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbhESJbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhESJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:31:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6843BC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 02:30:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g18so7820440pfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 02:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1GASlDyaGEqbt4zHelakmZp77xcr7uR+7KhR+EY5YCI=;
        b=Jf+NbjHcI3Bk8n3ZcgUVIFZoGAcO2Hqy/cQ1OqrFlIN4jSWweQEmBYRdj+M+0jZMBs
         hN4mpnCPNTJa+0SolRtC6LBonCtQf1tIIrSzPN25Pn1S8Fpx/H5zVeuyDtrp56yUf02y
         7AE8QkbrwyuUABzBLi6lRE4eQgiZyXD+3ONxyyNFIvwHkbpom4qNucJA7GgU3fB8pblq
         M+YekG9WeYm9nUsbZkp6r/vqqhL+6gZuuOi52U49Y96Sa96dmp0Q0MY66U9N0tMEqP/R
         QhIbG5O8hiB6hiQ4SiUG0dH2rK7f286crJcFZezTTBxwNcsRupn3heGMXzVWIV6rfiJ7
         vkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1GASlDyaGEqbt4zHelakmZp77xcr7uR+7KhR+EY5YCI=;
        b=hXJRZd8ZX6SYVzOk9OmC2djWibw2mUhWAm9bm0GbJdmUyduVgq4ESIgMA6X9SS8wpH
         EJKcTJubDaoFQij0Vug6wC6oVIN4KhnDuN0HqHCHCOW9IxISeAYiuirDs9y08lGIeSlV
         EVLWxPFQ0wzocRiG3HCDlZtwcq3Y/so6qyevZE5EcaMJAfMjz6RKgZZzGANUh9UABs7x
         FqER/1/mLU4i6YWas9NzXa5+jQuQyLWKadKpRK3FhJJcLe69nu6oeq6tvVXDCca5vMVG
         ADVmgUCdtdrZWM/TlpmBABzhExpXDB0KdGy2mcRmsA/xxHi3j9A5DnfY0x5PNVjU7KDH
         YSmg==
X-Gm-Message-State: AOAM531fb1QARMCixXu+jqYqAbfI0BPYguoxKwWJaaP4fQZBISXtDJBw
        yE2XCjaorZAXywvq2QZJ6liwwmQjFbm2gSys
X-Google-Smtp-Source: ABdhPJw9GKsc0sSBVVTDwO3wD9KybBzmYvrkeC8jYw8CaUKASCSxk6ZGwxCL9HfbZf8QGz2MzsqK2w==
X-Received: by 2002:a62:541:0:b029:2dc:9e95:95cc with SMTP id 62-20020a6205410000b02902dc9e9595ccmr9799344pff.79.1621416615762;
        Wed, 19 May 2021 02:30:15 -0700 (PDT)
Received: from [192.168.1.2] ([103.196.78.23])
        by smtp.gmail.com with ESMTPSA id o4sm14925324pjf.9.2021.05.19.02.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 02:30:15 -0700 (PDT)
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 'const' keyword
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20210519081958.7223-1-hridayhegde1999@gmail.com>
 <YKTM8KmXI8bXUSqp@kroah.com>
From:   Hriday Hegde <hridayhegde1999@gmail.com>
Message-ID: <0ddb894f-f66f-f31b-ef8a-0646e0a99b9f@gmail.com>
Date:   Wed, 19 May 2021 15:00:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKTM8KmXI8bXUSqp@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am not really sure how to do that and how to reflect it in the patch i followed what was taught in the Beginners course and it does not mention building. I know i need to test it out but is running 'patch -p1 < x.patch what i need to do?

On 19-05-2021 14:01, Greg Kroah-Hartman wrote:
> On Wed, May 19, 2021 at 01:19:58AM -0700, Hriday Hegde wrote:
>> Fixing following warnings found by checkpatch.pl
>> WARNING: struct file_operations should normally be const
>> 380: FILE: drivers/staging/android/ashmem.c:380:
>> +	static struct file_operations vmfile_fops;
>>
>> Signed-off-by: Hriday Hegde <hridayhegde1999@gmail.com>
>> ---
>>  drivers/staging/android/ashmem.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
>> index 8ee4320a5dc6..8ff2794b08e3 100644
>> --- a/drivers/staging/android/ashmem.c
>> +++ b/drivers/staging/android/ashmem.c
>> @@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>>  
>>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>>  {
>> -	static struct file_operations vmfile_fops;
>> +	static const struct file_operations vmfile_fops;
>>  	struct ashmem_area *asma = file->private_data;
>>  	int ret = 0;
>>  
>> -- 
>> 2.25.1
>>
>>
> Any reason why you didn't build your change before submitting this
> patch?
>
> thanks,
>
> greg k-h
