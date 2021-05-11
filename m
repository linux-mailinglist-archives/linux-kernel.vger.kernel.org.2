Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D5E37A4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhEKKph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230237AbhEKKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620729867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9YCTNzQqq3Nnca7i2b7kcNFhUAF6ByevzDuIX2ljPA=;
        b=aU3l4xD89P64XKhPsj/N2e6fxssSdDEaY1LLXj1+KRINH5UbiZ1C+7X71UHNOLhsy3FjMd
        uOfBrhllmjwr5fyxkdncggdTfTtuLpPOnR68gcqJ37NfWCa9ZHQndz5b+SUfdXc3V8u/rz
        efj9/qinsWLFXSa5wwSM5YKMLvVFiPQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-gl0LBtmhOgCGrcPvTafqzQ-1; Tue, 11 May 2021 06:44:25 -0400
X-MC-Unique: gl0LBtmhOgCGrcPvTafqzQ-1
Received: by mail-ed1-f71.google.com with SMTP id d13-20020a056402144db0290387e63c95d8so10724133edx.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a9YCTNzQqq3Nnca7i2b7kcNFhUAF6ByevzDuIX2ljPA=;
        b=SLczYvGT3DqQrsbcItVfjji470hinmeXePDZy4IGVT9Lpyr02v8IS93/YoxtdlQPw7
         xepW3DfSbm0KvRHeUmXTuE9rOS+87N6P6hig7dk1zpw6YrGIv9znQwsx9klGEppZ/zz3
         izTfoKVTjTNUvgSLrELbjA8jWPQI/e94YYdW0AZb/e+lmH6tS3vo6T6p5KA0RBmydvHl
         mXuo5/8L3P9qaid8dl1el3Ekvf9mQhtIlyJTpoWDAERDbxawbc6KfjzNhdZCjYXYzBSP
         6ScAOkZVGqSCmiaGZYj8IQgJfEZ6Q16tnNFQDFl1PuXesRC/MczczqS68Wly87MC57xm
         KflA==
X-Gm-Message-State: AOAM533kuS3sRhcBLJSDwp5KkdYv+4K9L2fOG3VamK5JVxPxYLsr0CcT
        PlyGEkFKM8FY01YAvCw+jlQKAljR8zwwv7+SOAh5vLdtYuCQafA7tkAk+cCOMxJtY/2/dVaCSyv
        HSjdTKsbOEH0yeI9fjE4Ykj5q
X-Received: by 2002:a17:907:93a:: with SMTP id au26mr2209521ejc.271.1620729864487;
        Tue, 11 May 2021 03:44:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV51LVSR8D2jr0aQfX6SMaIXLecAdVC3stzHo4XMOY59C4aPXhk95zXoM5nwQqDso0vtS4Zg==
X-Received: by 2002:a17:907:93a:: with SMTP id au26mr2209504ejc.271.1620729864279;
        Tue, 11 May 2021 03:44:24 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id cr21sm11105474ejc.2.2021.05.11.03.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 03:44:23 -0700 (PDT)
Subject: Re: [PATCH 0/3] iio: accel: kxcjk-1013: Add support for KX023-1025
To:     Stephan Gerhold <stephan@gerhold.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20210511095409.9290-1-stephan@gerhold.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <91258724-09cc-ed39-2277-6fbcca0c53e9@redhat.com>
Date:   Tue, 11 May 2021 12:44:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210511095409.9290-1-stephan@gerhold.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/11/21 11:54 AM, Stephan Gerhold wrote:
> KX023-1025 [1] is another accelerometer from Kionix that has lots
> of additional functionality compared to KXCJK-1013. It combines the
> motion interrupt functionality from KXCJK with the tap detection
> from KXTF9, plus a lot more other functionality.
> 
> This patch set does not add support for any of the extra functionality,
> but makes basic functionality work with the existing kxcjk-1013 driver.
> 
> At first, the register map for the KX023-1025 seems quite different
> from the other accelerometers supported by the kxcjk-1013.
> However, it turns out that at least most of the register bits
> still mean the same for KX023-1025.
> 
> This patch set refactors the kxcjk-1013 driver a little bit
> to get the register addresses from a chip-specific struct.
> The register bits can be re-used for all the different chips.
> 
> The KX023-1025 is used in several smartphones from Huawei.
> I tested these changes on a Huawei Ascend G7, someone else reported
> they also work fine on the Huawei Honor 5X (codename "kiwi").
> 
> [1]: https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Specifications%20Rev%2012.0.pdf
> 
> Stephan Gerhold (3):
>   dt-bindings: iio: kionix,kxcjk1013: Document kionix,kx023-1025
>   iio: accel: kxcjk-1013: Refactor configuration registers into struct
>   iio: accel: kxcjk-1013: Add support for KX023-1025

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

