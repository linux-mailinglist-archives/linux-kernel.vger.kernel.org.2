Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA5139A227
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhFCNZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231319AbhFCNZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622726635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2nBspPjF20/3Fz9Ced5rD4OQmXVJBuSYoh/YGtujCs=;
        b=QBsI4a6rpbVwFPj25x2EEv9dtL5N6/NVflB9pKgE07YNJTCcceerpqt7b60s75YyNhropZ
        Wnwra66Ng0nN69GuYoqpIMkbhMnfDJ8/pPzzz9MpRZ06v/6xuJRmAR5B6HXIQZdXnWc/mN
        XCWLmMdkOj3V9IYl0B3Gy9XzSbdJIUI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-F5GXTBXrNNW7SANZC3t2NA-1; Thu, 03 Jun 2021 09:23:53 -0400
X-MC-Unique: F5GXTBXrNNW7SANZC3t2NA-1
Received: by mail-ot1-f70.google.com with SMTP id w25-20020a0568301459b02903cf61c3b88fso853248otp.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I2nBspPjF20/3Fz9Ced5rD4OQmXVJBuSYoh/YGtujCs=;
        b=VpX8Z5Ip59r73a4LAqez3WXegu8710TFdaswilUyLBc/L1TttzjrKGsKaadM+Yay9b
         x+JOW8YjGdxVE4p0Kty4/LKYFPITO/cLt/D1g3pdwHFpkcNnlpjlbvI8BS1jMZhQd9hQ
         0yQfr3M/4Ch98ivBos17m5yFEiEA2KYh9P5qf2l1qd9mMsGtJWGSg+GjEXyZQUghvh7C
         xcBZjzXU3qfV6T2OZyv1Lx65oGvo8T4Ppf/01yZwOyjxkBWD1GqxH8sV2o7KJbiOQMPF
         YYAb3DiVSnRVlw/cICSdQgrvjtQtkfsG77DmOsVrrH6K9J+O7glKpXhbwmfQCt2L9A3o
         9vxw==
X-Gm-Message-State: AOAM533KVXYEw9SGPk9HoWuY1qClwA2N3+laQAredCVr2IwSMiadUZ6D
        1N5k7Z4Oe1Usu6cndizvqy3AWcjMlner1afXjBp/6qSymivCPykwy62PId2BMN+mWlA8OoQM92Y
        psfXA11wr538vcD7k3kJnrlBW
X-Received: by 2002:a05:6830:4006:: with SMTP id h6mr5586605ots.348.1622726632442;
        Thu, 03 Jun 2021 06:23:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+9F/VkBceYlmAJQlazH/NI64dO2xB52KTX53ZpD0nVzlCS2Qb1fhML4o9/H0tm/a7+EM6Lw==
X-Received: by 2002:a05:6830:4006:: with SMTP id h6mr5586593ots.348.1622726632243;
        Thu, 03 Jun 2021 06:23:52 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q26sm655035otn.0.2021.06.03.06.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 06:23:51 -0700 (PDT)
Subject: Re: [PATCH] powerpc: Remove CONFIG_PPC_MMU_NOHASH_32
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <bf1e074f6fb213a1c4cc4964370bdce4b648d647.1622706812.git.christophe.leroy@csgroup.eu>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d201a021-fe6f-4240-8ba6-095e1d9badde@redhat.com>
Date:   Thu, 3 Jun 2021 06:23:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bf1e074f6fb213a1c4cc4964370bdce4b648d647.1622706812.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/3/21 12:53 AM, Christophe Leroy wrote:
> Since commit Fixes: 555904d07eef ("powerpc/8xx: MM_SLICE is not needed anymore"),
> CONFIG_PPC_MMU_NOHASH_32 has not been used.
>
> Remove it.
>
> Reported-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks, one less for me to do.

There are about ~100 similar tree wide, I'll be posting these soon.

Tom

> ---
>   arch/powerpc/platforms/Kconfig.cputype | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 885140055b7a..dc7c46f92302 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -424,10 +424,6 @@ config PPC_MMU_NOHASH
>   	def_bool y
>   	depends on !PPC_BOOK3S
>   
> -config PPC_MMU_NOHASH_32
> -	def_bool y
> -	depends on PPC_MMU_NOHASH && PPC32
> -
>   config PPC_BOOK3E_MMU
>   	def_bool y
>   	depends on FSL_BOOKE || PPC_BOOK3E

