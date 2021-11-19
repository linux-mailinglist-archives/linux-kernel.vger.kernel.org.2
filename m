Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D144B456B80
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 09:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhKSITS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 03:19:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234075AbhKSITR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 03:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637309775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dGVjhUmhSKpRkRZVK2VPpn5nare3klvTCl9Wthr4AVc=;
        b=FYe/x1F6xeY0bHjEsR/3owRJvo2OQQHtY9Gm0ulJQD1ugbPDLAFpWbPkkxCraCmrwCxqad
        SL5INbjPGo9pqSsn63Q+szofaIKJtzdl27TBn/P0m3TrGSRQxBm4joV/hSV3/FMvd1RTqA
        DRtUeAW2ny8QUWs724zJaV5fyDeN2Kc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-rukghLzcM8GjERiXnx2E6A-1; Fri, 19 Nov 2021 03:16:14 -0500
X-MC-Unique: rukghLzcM8GjERiXnx2E6A-1
Received: by mail-wm1-f72.google.com with SMTP id 201-20020a1c04d2000000b003335bf8075fso3724167wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 00:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dGVjhUmhSKpRkRZVK2VPpn5nare3klvTCl9Wthr4AVc=;
        b=l6W7TvepZV7bTPCqhplb8LNIb6zYhMmc+H2goX9FbEXm8dvKwz4GXnkZxjWk1PHh4C
         IKrg9IlaTxQkwJxHgbQvBjw2apmNuvhtqbRhy1XsuZ3trPWk1Stm8Eos67aUTArWvXOd
         Fcx074f1f42b6iq10JzqWlhGin8PezQ93VZ0M6B+mJiZoqEMxgyxw0VBO2GFhpVaoVaY
         duec1qDdtEEba7git2I3LOGu3wE3AtwWxpt4GQ855yGM8FRXGXBU4K65RoDOznfrRR1f
         bVn5EzyKhKqZBwNOBb+bJT4NBG8oPZluFxKJjbqAR1CQ9FKcTlojjuArbVmc3rdjPkVm
         rmlg==
X-Gm-Message-State: AOAM531wNJ9Fj70ajhSkx7DsLeSza4HlnvGIWBRrwpF3V5VANUdmmYcc
        QLfy0EGEZI3BmqimpHKxt+76+SNzJJ3hO91nICVK2ms80EZ5/vMEOB5IxH1O7zU3Ha+/R1tmNEW
        WSQDreVKHYa1IyBfS2Rjc1oE6
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr4637183wmq.34.1637309772927;
        Fri, 19 Nov 2021 00:16:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyo2XV6Pk/Nz3kbl16d6jJTW64ufiC5kUvq5J0K8M6i2zYcLcY8P63mDySius51uUm3JP3QaA==
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr4637150wmq.34.1637309772703;
        Fri, 19 Nov 2021 00:16:12 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z6sm2858429wmp.1.2021.11.19.00.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 00:16:12 -0800 (PST)
Message-ID: <84b28138-8f10-f3a3-cbe8-878635b4f0d0@redhat.com>
Date:   Fri, 19 Nov 2021 09:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] spi: docs: improve the SPI userspace API documentation
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Ralph Siemsen <ralph.siemsen@linaro.org>
References: <20211118213143.2345041-1-javierm@redhat.com>
 <CAMuHMdVcsfE6TZbu8SJZP7CNKyjwBZdBiN0nDRQCibaGgpLF0g@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVcsfE6TZbu8SJZP7CNKyjwBZdBiN0nDRQCibaGgpLF0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert

On 11/19/21 09:10, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Thu, Nov 18, 2021 at 10:32 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> This doc is fairly outdated and only uses legacy device instantiation
>> terminology. Let us update it and also mention the OF and ACPI device
>> tables, to make easier for users to figure out how should be defined.
>>
>> Also, mention that devices bind could be done in user-space now using
>> the "driver_override" sysfs entry.
>>
>> Suggested-by: Ralph Siemsen <ralph.siemsen@linaro.org>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Thanks for your patch!
>

You are welcome!
 
[snip]

>> +
>> +NOTE: it used to be supported to define an SPI device using the "spidev"
>> +      name.  For example as .modalias = "spidev" or compatible = "spidev".
>> +      But this is no longer supported by the Linux kernel and instead a
>> +      real SPI device name as listed in one of the tables should be used.
> 
> This reads as the tables are fixed.
> Perhaps add
> 
>     You are encouraged to add an entry for your SPI device name to
>      one of the tables.
>

Indeed, you are correct. I'll add that too in v2.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

