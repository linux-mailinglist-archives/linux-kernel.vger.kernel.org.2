Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00558423F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbhJFNia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238778AbhJFNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633527392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/piGMVcmtfQU410RPWuDNLfDkB4Ox9Tyhdds4zXiGs=;
        b=JePM933DtVmQyKcPASJArr7S/+gc9gAsmT6tjwlwrhw8CuoqCzFAVSaxxguaAjFcmDyIuf
        FqKMnMbWNmvmxYK3BJurmBtDQqKrgbPx+KKTpegU559QWF57RI23X9WOaXQf913mi4boMC
        7yo0YCzif5uPMiFYNvHG0Ywql7Ga/YY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-ozb9Xa04NiKXHu6eWl36OA-1; Wed, 06 Oct 2021 09:36:20 -0400
X-MC-Unique: ozb9Xa04NiKXHu6eWl36OA-1
Received: by mail-ed1-f69.google.com with SMTP id 2-20020a508e02000000b003d871759f5dso2662373edw.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 06:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u/piGMVcmtfQU410RPWuDNLfDkB4Ox9Tyhdds4zXiGs=;
        b=zVC+UpHny1ZHCdUGETXCcJMLGAUEN2R1pLux22HwjHgOxUUrRtEzvrklkBZw4ZBP9t
         hpfdDa9JPvI5A7VD4gzga8V4LpVxGBz8S6vLvR32U8T+i0GmoR4n4b0iPrx8vTXajJAE
         BJ1BcWUIuOZJd5lfM1SH9zYZ5BRAQ5wIbGVK1XTzjVs9BXkq266MBZQWORHgQSJZ5Zsc
         bODIxTYBJHSqfqv3CMp5T6ItSFuEZtT//djQT91GJqTPodjZak5S649Ex3AbVdCLcl4u
         D2kV0FGKCtRzC0RoSB/ooaFHmqIAEIhvdhiktluTH6KGf8v6AA5/yHraT9lTGM791pBU
         iMAQ==
X-Gm-Message-State: AOAM533aGW/ku+z5j4mk0LZYxHXoeA9hVVOY9DVrD9xDV1X1gobEaqTr
        mLqXJyqHYT/PY4HKWRA2CLyYukNw9s7OPlcG+LsgcLjLUn34yN48VlnShW/K/jCCZK8qTstpLhx
        5jl7zTA980Rkw+vHTPOs+rD4W
X-Received: by 2002:aa7:d5cd:: with SMTP id d13mr30216044eds.232.1633527379435;
        Wed, 06 Oct 2021 06:36:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHZgwmbw5yaPBNCqM31MvnEW6sUbXSRH0z3uAhPPHeOJiVcbVeK/3vI44F2LwrPoIKi3mW8A==
X-Received: by 2002:aa7:d5cd:: with SMTP id d13mr30216018eds.232.1633527379258;
        Wed, 06 Oct 2021 06:36:19 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id j3sm4693182ejy.65.2021.10.06.06.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 06:36:18 -0700 (PDT)
Message-ID: <61759137-0182-8eed-6413-80a8fc82c6e8@redhat.com>
Date:   Wed, 6 Oct 2021 15:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH MANUALSEL 5.14 1/9] selftests: KVM: Align SMCCC call with
 the spec in steal_time
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Oliver Upton <oupton@google.com>,
        Andrew Jones <drjones@redhat.com>, shuah@kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20211006133021.271905-1-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211006133021.271905-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/21 15:30, Sasha Levin wrote:
> From: Oliver Upton <oupton@google.com>
> 
> [ Upstream commit 01f91acb55be7aac3950b89c458bcea9ef6e4f49 ]
> 
> The SMC64 calling convention passes a function identifier in w0 and its
> parameters in x1-x17. Given this, there are two deviations in the
> SMC64 call performed by the steal_time test: the function identifier is
> assigned to a 64 bit register and the parameter is only 32 bits wide.
> 
> Align the call with the SMCCC by using a 32 bit register to handle the
> function identifier and increasing the parameter width to 64 bits.
> 
> Suggested-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Oliver Upton <oupton@google.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Message-Id: <20210921171121.2148982-3-oupton@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   tools/testing/selftests/kvm/steal_time.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
> index ecec30865a74..aafaa8e38b7c 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -118,12 +118,12 @@ struct st_time {
>   	uint64_t st_time;
>   };
>   
> -static int64_t smccc(uint32_t func, uint32_t arg)
> +static int64_t smccc(uint32_t func, uint64_t arg)
>   {
>   	unsigned long ret;
>   
>   	asm volatile(
> -		"mov	x0, %1\n"
> +		"mov	w0, %w1\n"
>   		"mov	x1, %2\n"
>   		"hvc	#0\n"
>   		"mov	%0, x0\n"
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

