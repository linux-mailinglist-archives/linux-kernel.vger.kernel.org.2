Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C83C457622
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhKSSET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:04:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230405AbhKSSES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637344875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/a6rOhLDv3JwL69Ue+qRfZwjwTKZg5m885Paq3oOLk4=;
        b=KrTIgKIWWo3lVMz6dF/mRqMSiYERlFV4+/gQN81Stg3k8EVRqnX1w5tp5ekv2RbJ5WovTB
        JICj9fC5loiqXKNa5naMTGYvHOAD9U62UAseoNHUrNwwBrAiImki4goeQS86Q0WDP9j02t
        9Jqu0APwWUw+uaSp8/Zvhfv0frrPN9Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-KLnRA5F8PQeu-4t0jLVx2w-1; Fri, 19 Nov 2021 13:01:14 -0500
X-MC-Unique: KLnRA5F8PQeu-4t0jLVx2w-1
Received: by mail-wm1-f72.google.com with SMTP id r6-20020a1c4406000000b0033119c22fdbso4417490wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/a6rOhLDv3JwL69Ue+qRfZwjwTKZg5m885Paq3oOLk4=;
        b=zgF4GDTsqeFTNhedIjmRdVGw+OvGhvxwC5eoq+cCpUNAIdfWrvhQNn3v1YZD5nl2pg
         GgNbZPWtFEI+JkRlhUV3LYQV47u+V2kCH6MA7KD3atBsbPyBR/CSqXIQnaygZMq7eqhU
         HXtXGI+Fd1j0MsAO87vNdGR5YKI2S+7MiIkGdazOiR0U85OxdZ4pimIDLM0XK74P8QmB
         /eTp+OyE+yjKabgNuIZZjMnBonWr3E8HlDa02lEb7yL8gcszGPpx7BPswh1CGrsT/qvU
         AGr7BMCgsgYSi+x19uLRu8k27/jK9+/qKO2qGK6rUlCRxsMKeGFxe+nxHs4b1twqwqkV
         G+7Q==
X-Gm-Message-State: AOAM532k1NqEA47JX3IVrIQ6qPsnAOTAvzrTHZ1gKcB5ZCeP7sStrXtr
        +wcMJEaPkwb/ERj9fpsja5NrpYbnq7tvlBsCy9HLMhBozJFlZDXrdUYyqFrZXznIRtdjM94ceWU
        kgs4keq9EYy+wczmz0HUStI9E
X-Received: by 2002:adf:f54c:: with SMTP id j12mr10048574wrp.20.1637344873101;
        Fri, 19 Nov 2021 10:01:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWGJuiXfyI9qCfHWRTyH0ZcihvvNNyBX6Y4qZZ7mds6Ndbk7C5bGC/fg8jnfrzZjCYxEj+8Q==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr10048513wrp.20.1637344872795;
        Fri, 19 Nov 2021 10:01:12 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l5sm332325wml.20.2021.11.19.10.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 10:01:12 -0800 (PST)
Message-ID: <e47bd075-fba1-cc34-b016-91043957c97b@redhat.com>
Date:   Fri, 19 Nov 2021 19:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] spi: docs: improve the SPI userspace API documentation
Content-Language: en-US
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org
References: <20211118213143.2345041-1-javierm@redhat.com>
 <20211119160325.GA1591448@maple.netwinder.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211119160325.GA1591448@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ralph,

On 11/19/21 17:03, Ralph Siemsen wrote:
> Hi Javier,
> 
> On Thu, Nov 18, 2021 at 10:31:43PM +0100, Javier Martinez Canillas 
> wrote:
>> This doc is fairly outdated and only uses legacy device instantiation
>> terminology. Let us update it and also mention the OF and ACPI device
>> tables, to make easier for users to figure out how should be defined.
> 
> Thanks for putting this together! Overall it is a definite improvement.
> 
>> +NOTE: it used to be supported to define an SPI device using the "spidev"
>> +      name.  For example as .modalias = "spidev" or compatible = "spidev".
>> +      But this is no longer supported by the Linux kernel and instead a
>> +      real SPI device name as listed in one of the tables should be used.
> 
> This note is factually correct, but it might be a little too terse for 
> folks who are not full-time kernel developers. I'd suggest making it a 
> bit more prescriptive. As well, the focus can probably be on the case of 
> device tree, since that is the one that generates the warning (and with 
> your patch, causes the driver to fail to load).
> 
> I've struggled to put it into the right words, so the following is just 
> an idea. I've intentionally included the exact wording of the warn/err 
> to improve google-ability. As well, it is interesting to do a google 

Instead of adding the messages here, I think what we should do is to point
to https://www.kernel.org/doc/Documentation/spi/spidev.rst in the spidev
driver messages.

That way we could save people a search in the interwebs. That would be a
separate patch for the spidev driver of course.

> search for the message, and see what kinds of advice is offered. A few 
> that came up for me include:
> https://community.nxp.com/t5/i-MX-Processors/spidev-spidev-listed-directly-in-DT/m-p/426381/highlight/true#M64609
> https://yurovsky.github.io/2016/10/07/spidev-linux-devices.html
> 
> Anyhow, here is a possible addition to the NOTE in your patch.
> 
> spidev listed directly in DT is not supported
> =============================================
>

Agree with including this section. But we could do it as a follow-up.
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

