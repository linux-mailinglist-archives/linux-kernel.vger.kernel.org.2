Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162C844FF21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhKOHRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 02:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhKOHRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:17:31 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C738C061746;
        Sun, 14 Nov 2021 23:14:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso13256985pjb.2;
        Sun, 14 Nov 2021 23:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HzVcp0vd3kEGMH5/OyMT9vvED38Na0W+uUNCEomdejc=;
        b=kr9wsxcjjFvuKgADu1pUcYtLz7LDmQDVjHHnahiXm0pI9xoNIswZBGLtnUOYHVtMF9
         KWp2hrnJErKgEK7yzH+xJ2rgoMYO7HRQ4tmKL5JlnXERTA8JydAfU0UdJndeh7zSPsTo
         OmrQYOdpzoxq2+Cik9oRvr2akTe+xjzf5lv8f4EOXjyHYRvSX3Xa+A6dr1aMhzWQkqWQ
         gYKCnpRh2wzQV77KkP4k6W7So4RvvN7GcHLS6B8KTT94o3NHUKbEhbJCk01RHD/PJX87
         2k2sJ5hSXFLbyhPJqGLXLZXros1LEw8xBl89c5xipFeDS23vo4tpXZeilMQHAFCQSY6W
         UkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HzVcp0vd3kEGMH5/OyMT9vvED38Na0W+uUNCEomdejc=;
        b=BhWEtLuwXc6gpv/gRdBIiRXJhK+X9FAESOssKNY3BxwADvuM/JFQNGXr3Mcm1QwYJO
         iF07VumBrwyzukcHSxR6hEUzkxEnTZCPepWWbDxdT99yxVGoTF6fIoN3yGqzAwoAae3b
         1hUW8V1JL5BgnI2JdTuWhQzIriVPUhuSZBjIVpNYk85anOkk36sWHGykKMazxZB56Zfx
         hzpBXRbPyO1J2GGGWPt4T5arPokHPGLivMFZ+McjaSw9EiBHLFTSWqk9jrTY+XmtF6fj
         O4QAA9P2TvgJyNJfZ9whJXUeCBHnj6NfN2UmZouoQlcViHiG8qbGr2msSSVNL2+p7SFP
         2++Q==
X-Gm-Message-State: AOAM531efNbsyoJUmbOnQmUIKcAaOceCchilSHF/4PTy9WeN0bwLQ+oQ
        o6wwsb+XspAFrCY2d1cD4XU=
X-Google-Smtp-Source: ABdhPJySj5I/eJdhaU9Sw6A3R2L0G0SjKU4xzXos7lygqb20a15Wp1SlgfMpWcqb5ld9oQH0w1Tqxg==
X-Received: by 2002:a17:90b:2309:: with SMTP id mt9mr63325865pjb.213.1636960476001;
        Sun, 14 Nov 2021 23:14:36 -0800 (PST)
Received: from localhost ([103.99.179.247])
        by smtp.gmail.com with ESMTPSA id nn15sm18477103pjb.11.2021.11.14.23.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 23:14:35 -0800 (PST)
Date:   Mon, 15 Nov 2021 15:14:21 +0800
From:   Calvin Zhang <calvinzhang.cool@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Calvin Zhang <calvinzhang.cool@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: make MAX_RESERVED_REGIONS configurable
Message-ID: <YZIIzcO+MPbNH3qR@debian>
References: <20211115063521.3457302-1-calvinzhang.cool@gmail.com>
 <18eb2d82-d3b3-79ec-9c20-c5c5cf5cab52@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18eb2d82-d3b3-79ec-9c20-c5c5cf5cab52@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 10:40:29PM -0800, Randy Dunlap wrote:
>On 11/14/21 10:35 PM, Calvin Zhang wrote:
>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> index 80b5fd44ab1c..591b2c4d9dd0 100644
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -73,6 +73,16 @@ config OF_IRQ
>>   config OF_RESERVED_MEM
>>   	def_bool OF_EARLY_FLATTREE
>> +config OF_MAX_RESERVED_REGIONS
>> +    int "Maximum count of reserved regions"
>> +    depends on OF_RESERVED_MEM
>> +    default 64
>> +    help
>> +        Reserved regions in /reserved-memory node includes static
>> +        reservations with fixed location and dynamic ones for device
>> +        cma regions. This parameter sets the maximum number of reserved
>
>	  CMA
>
>(as is used in mm/Kconfig)
>
>> +        regions in the system.
>
>Also, all 4 lines of the help text should be indented with
>one tab + 2 spaces, not all spaces.
>
Thanks for the review. I will send a v2.
>
>thanks.
>-- 
>~Randy
>
