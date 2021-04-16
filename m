Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14718361C07
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbhDPIop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:44:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58659 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbhDPIol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:44:41 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lXK5I-0005Ew-JI
        for linux-kernel@vger.kernel.org; Fri, 16 Apr 2021 08:44:16 +0000
Received: by mail-ej1-f70.google.com with SMTP id w2-20020a1709062f82b0290378745f26d5so1784137eji.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=18JK8yDx0NtD/4aG8Ry1RsSt82JPj7kXl6NfpXnnE+w=;
        b=U0NpaRXuOFnt5isWeBxTTxS7QbN5JLu1WMe+RWXEOUQrM76KbepfYOjrdT0osFy/3x
         dNs8y0RG/+Nf+bDjE3I8DptK4Ilf3f/7OanA1qCG0d0t1EvfaiNc146R9MMjzk4zst5H
         jH725hdDvvPcOT8CN6Ab/PUySK/kV/xlurgs+eywh1UNLqiSNdeNyJkeM+6+sBGU10m3
         YQ8ItrXJEP/RJXXOljhRIU0x9Xm4GLSpelYeVT4fHC2nKBmgB9kVAWqL62c2ajYgQQ/y
         KcAnL/ndoIphGk8A3X8+R6EQbWGLr4oHPhn7GnsMtrzlTR/STOUr4wS9vx/pV3vfaWaG
         s30Q==
X-Gm-Message-State: AOAM532mlP7SjKKB6DACBTTqkA6OkOIVZR1j0Hp7pepJfEJifB0AUkyc
        vENgTVudjxQ20ACt00XAx46/xWsm7wlPHbiakjkUdT/EefZ771C5oOoh03o7+kfrz40GxwDPCvx
        tGbLG0VD4FOUg/m7yp/CfxbF9wHgbbEnA4iIEbcqAzA==
X-Received: by 2002:a05:6402:1393:: with SMTP id b19mr8644388edv.333.1618562656306;
        Fri, 16 Apr 2021 01:44:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWlZwkE7N5B0Dp/1iadZ9AeAo0s6MU3gYpUBAwDZeypnM8XTtbr/fqA3I+xsF7L+M1syvUFQ==
X-Received: by 2002:a05:6402:1393:: with SMTP id b19mr8644380edv.333.1618562656146;
        Fri, 16 Apr 2021 01:44:16 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id r10sm3799693ejd.112.2021.04.16.01.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:44:15 -0700 (PDT)
Subject: Re: [PATCH] rtc: Fix missing IRQF_ONESHOT as only threaded handler
To:     zhuguangqing83@gmail.com, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20210416021949.1569-1-zhuguangqing83@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <66e46265-f2b5-2133-4cd4-5dc0421e9a37@canonical.com>
Date:   Fri, 16 Apr 2021 10:44:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210416021949.1569-1-zhuguangqing83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2021 04:19, zhuguangqing83@gmail.com wrote:
> From: Guangqing Zhu <zhuguangqing83@gmail.com>
> 
> Coccinelle noticed:
> 1. drivers/rtc/rtc-s5m.c:810:7-32: ERROR: Threaded IRQ with no primary
>    handler requested without IRQF_ONESHOT
> 2. drivers/rtc/rtc-rk808.c:441:7-32: ERROR: Threaded IRQ with no primary
>    handler requested without IRQF_ONESHOT
> 3. drivers/rtc/rtc-max77686.c:779:7-27: ERROR: Threaded IRQ with no primary
>    handler requested without IRQF_ONESHOT
> 4. drivers/rtc/rtc-tps65910.c:415:7-32: ERROR: Threaded IRQ with no primary
>    handler requested without IRQF_ONESHOT
> 5. drivers/rtc/rtc-lp8788.c:277:8-33: ERROR: Threaded IRQ with no primary
>    handler requested without IRQF_ONESHOT
> 6. drivers/rtc/rtc-max8998.c:283:7-32: ERROR: Threaded IRQ with no primary
>    handler requested without IRQF_ONESHOT
> 7. drivers/rtc/rtc-rc5t583.c:241:7-32: ERROR: Threaded IRQ with no primary
>    handler requested without IRQF_ONESHOT
> 8. drivers/rtc/rtc-max8997.c:495:7-32: ERROR: Threaded IRQ with no primary
>    handler requested without IRQF_ONESHOT
> 
> Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
> ---
>  drivers/rtc/rtc-lp8788.c   | 2 +-
>  drivers/rtc/rtc-max77686.c | 4 ++--
>  drivers/rtc/rtc-max8997.c  | 2 +-
>  drivers/rtc/rtc-max8998.c  | 3 ++-
>  drivers/rtc/rtc-rc5t583.c  | 2 +-
>  drivers/rtc/rtc-rk808.c    | 2 +-
>  drivers/rtc/rtc-s5m.c      | 4 ++--
>  drivers/rtc/rtc-tps65910.c | 2 +-
>  8 files changed, 11 insertions(+), 10 deletions(-)
>

The same with all other patches for IRQF_ONESHOT which are send recently:
1. On what board did you test it?
2. Is this just blind patch from Coccinelle without investigation
whether it is needed (hint: it might not be needed in all of these
places, because at least some of them do not use default primary handler).
3. If you think otherwise, please explain.

Best regards,
Krzysztof
