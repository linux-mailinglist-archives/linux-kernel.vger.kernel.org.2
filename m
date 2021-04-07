Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFD2356AE2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351777AbhDGLP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:15:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37701 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351769AbhDGLPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:15:23 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lU69R-00081U-5E
        for linux-kernel@vger.kernel.org; Wed, 07 Apr 2021 11:15:13 +0000
Received: by mail-wm1-f69.google.com with SMTP id b20-20020a7bc2540000b029010f7732a35fso2004358wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 04:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HouJQzuf2a1RcT0yofIoKLAiQ7qd5aclheZGD67RW3Q=;
        b=Rie1pzH/+S1vkk1TrrcSUIv8qjsr+pUpsSFv4p9ElgJa12mcXRCLGugjR7ySuqKNcX
         VbKKnLk7Boxc3dnEEk5xFb/AxmWNLvHj3YmNDe6uAWMmKYflYbxyJOlcrR0iw1rGt0xF
         /b4zTr2o8+1QGi1R39jIUWptJoheVNKy1Qne1hxOt+WxcnwAkvgNNbG6Ykn/NnYQ2QuC
         nVOS47AXxeZ8B+ngveWM0MSmI2lULvfb3obeYJKxCWZacU55odO90n3dsIHYNCIqxPR3
         3McnZTLUEfTXNQIzKm/x/R/kRFoiyn9BO1FxhE8NkXY2clQPwAUB5uqdmPCxYUDxDDNr
         ykpA==
X-Gm-Message-State: AOAM530p93+v2o0VLZUH7/XACjOsloZMD6kf7pMnoS9XK09et6Izud6G
        vRutUi+ofIRzcHuJRDXQBaKBgpNsiFqoTKmPBRCkWqu0GiICZfotpxU1er298aDcFSz2P/4tU+4
        MzXBPXN+vH9nhYs/+LNsBOiKU+1DBO8SK6wzJv+l8vw==
X-Received: by 2002:a05:600c:289:: with SMTP id 9mr2579310wmk.135.1617794112751;
        Wed, 07 Apr 2021 04:15:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO6lh76dqAK/8ySaxATJaX1KSJP2CwlW9U/9Lc9KH0/ThKDYRhCZamwGMwGpbLu9yd7DIm7w==
X-Received: by 2002:a05:600c:289:: with SMTP id 9mr2579295wmk.135.1617794112628;
        Wed, 07 Apr 2021 04:15:12 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id i127sm8297328wma.6.2021.04.07.04.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 04:15:12 -0700 (PDT)
Subject: Re: [PATCH -next] power: supply: s3c_adc_battery: fix possible
 use-after-free in s3c_adc_bat_remove()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     sre@kernel.org
References: <20210407091903.3268399-1-yangyingliang@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <59bbbad2-a82b-e08d-5225-267fee168ed1@canonical.com>
Date:   Wed, 7 Apr 2021 13:15:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210407091903.3268399-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2021 11:19, Yang Yingliang wrote:
> This driver's remove path calls cancel_delayed_work(). However, that
> function does not wait until the work function finishes. This means
> that the callback function may still be running after the driver's
> remove function has finished, which would result in a use-after-free.
> 
> Fix by calling cancel_delayed_work_sync(), which ensures that
> the work is properly cancelled, no longer running, and unable
> to re-schedule itself.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/power/supply/s3c_adc_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
