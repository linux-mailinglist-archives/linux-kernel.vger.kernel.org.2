Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9D2393E64
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhE1IFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235694AbhE1IFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622189019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0IXbcSm8mT+lhuVdC+CT+mjkkm7+PBeCbiBVe/0dKys=;
        b=Uqpa1n3CJGUDccfzAiS63uM3E2SRvy/px/njILOOZZtOukQYLQ+8IJFpO+9ZX3dPSkH9sp
        8yONhsV9a238C5sGNvgFg5VJ7PoFpoJ9Mxfh/rDO0kgXc+ZgOxTZFTum9o+kTlJAe3a6NZ
        Z0uUqTa6MetqZLoFP+kczeVAVtQI9/U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-MwILguTsMwK0tE_6URdrRA-1; Fri, 28 May 2021 04:03:07 -0400
X-MC-Unique: MwILguTsMwK0tE_6URdrRA-1
Received: by mail-wr1-f70.google.com with SMTP id p11-20020adfcc8b0000b029011277d49b71so709523wrj.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0IXbcSm8mT+lhuVdC+CT+mjkkm7+PBeCbiBVe/0dKys=;
        b=cXwQNPNbQNjs3YBGfmAIGuubr27B8mybGIzJTlIRgbnK/ka6OxsC5M9YarurQv7PQB
         iiDPfpSI4SFiFR4ClyjDCb2jbq+IDec0HrRsNr2Q+441fKAj82UNrMv5gJT8foXsoAUc
         0GLlmBAN1ukr0uA2el+T+ZKdcJFVXTS8bB/jI40eiXL9jOoccVnCOf5a2B5f7md50eQK
         McFNkTF4a+/3UhLqEV6195aq++OUqw5JeUJ4Zo6r7YubQD5nPdMvY1gF5UWxy5D8qXk1
         3+8FnLtAMR5lAbRi34qCnW9LQkVATHhBZY5UNyfMvmCphD/eCd27SQV9VIrXi/SwgULc
         0qrQ==
X-Gm-Message-State: AOAM530qbOAhaqh7s5HQcBx+tMzSYlx+JrecTPXsgokE9sw1Wl2rxAYw
        78V1Hey9J/c2ZdnBvDmDkhY4UDWO70Y+2ngjAgSlaI7uk+FF4brblMIsZVwKGpnAkSxeUolTmsA
        tHUnes6hpYO21GbZp+GG91zlu
X-Received: by 2002:adf:fdce:: with SMTP id i14mr7029839wrs.303.1622188986614;
        Fri, 28 May 2021 01:03:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+e8iRBOPicMDS91UKoWmjw1Ow4Oln/9p2aaPMHWdMTZ3KKJsPjuaTgqaOu1DwibvjoXOU8Q==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr7029814wrs.303.1622188986368;
        Fri, 28 May 2021 01:03:06 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q20sm2949464wrf.45.2021.05.28.01.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 01:03:05 -0700 (PDT)
Subject: Re: [PATCH 2/2] drivers/firmware: consolidate EFI framebuffer setup
 for all arches
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>, David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-efi@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210521193704.3042024-1-javierm@redhat.com>
 <e23a44ba-5e9d-d27b-b5e8-0cce3b158ed7@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <c6c6b686-6e13-2f1a-0310-b558428304c1@redhat.com>
Date:   Fri, 28 May 2021 10:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e23a44ba-5e9d-d27b-b5e8-0cce3b158ed7@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/22/21 7:14 AM, Thomas Zimmermann wrote:

[snip]

>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -127,6 +127,7 @@ config ARM
>>   	select PERF_USE_VMALLOC
>>   	select RTC_LIB
>>   	select SET_FS
>> +	select SYSFB
> 
> Don't select this as part of the architecture. Rather make an option for 
> SYSFB that depends in the architectures that supports it.
>

Thanks a lot for the suggestion! I did this by making SYSFB's Kconfig option
to be default y and depends on the supported architectures as you mentioned.

This not only is a cleaner approach but also will allow to not touch all the
architectures platform code.

I'll wait for a few more days in case someone else has feedback and post a v2.
 
> Best regards
> Thomas
> 
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

