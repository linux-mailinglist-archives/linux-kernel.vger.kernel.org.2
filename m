Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9A23EBC6D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 21:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhHMTJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 15:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhHMTJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 15:09:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08932C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 12:09:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so3724538pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KK5PMM54npEpLZliacDt3bjyqyNhWCWju9QlXW/gHeU=;
        b=U/guKoSq65qEHQXiT1haSu/HNuyYOFEzBcn85ZhyuHkLjJslFTSZcFnvCxO+uxJcGZ
         ED/p3mZ8czr3VfKHD8NDwnZOOpPJLvmNHKKSBIf/r4Ic1SS4na4TL3V43Jlfn8BUBLfo
         laUSw9vHzOJAsHJRLwNUgt5mz0u8UjQGJkgd2PepLnY1JNZf91p5eTRF1upcNf1mVhLA
         xJaPiV5aW4S9ofBhGURAlkz0+qh5ULHuToCTtEynzDka22ed5kBGexYIQBXGAtHDgQqR
         So1v8rCOcapmuKSzYXmBwY6o7aDoKbSIGaI2yWedwVPWit9ZRgAF7Ut9c/RKouBeXo2p
         pWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KK5PMM54npEpLZliacDt3bjyqyNhWCWju9QlXW/gHeU=;
        b=JPkG5L0sTy79n/Hc4kRMNKXj/vEDkaQR47kUBLSvTjcaab1vYCdHI259DS0rKbKTYJ
         JfzdlwBtY0HIpoXUYGfbzfRiCCGlYTTBm2s873THrdeFUejppmISGFxuUFii+uRa56V0
         rkM1a1dx9D6RMtZ/LmQvqTY9qecfjEUtK5gzkTPVadddE2ibB2dYLMW7MQsuZF3tOe75
         haLN5xbTsbSemdZcnaZm7YC8AhjruJ05y8szXxYy+KERyjQeZg/QT7vH9TSC7rSmOdBj
         g4rlP9YE+2tYRhRXcC5G0VSXmIit+JsweaCVmwbnYqGcz7AdjAOnT8LdHOkxxGVzTt4e
         FCCw==
X-Gm-Message-State: AOAM532R5cpchcd5/T/Kvxacv2IWgWZQh6RbbqOzzCp79NiKsm8xKJJn
        eGFMEeoKVkgumP8ycVvRsWXDoA==
X-Google-Smtp-Source: ABdhPJxXdASnvDJiJ6fHGFND576uYst/fbUWHCZzRU/brb8tc0H0JIPhAWxB5EB9agwiBwVnP6hUkw==
X-Received: by 2002:a17:902:9b90:b029:12d:5ce1:4d99 with SMTP id y16-20020a1709029b90b029012d5ce14d99mr3193439plp.37.1628881765412;
        Fri, 13 Aug 2021 12:09:25 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d14sm2556095pjc.0.2021.08.13.12.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 12:09:25 -0700 (PDT)
Subject: Re: [PATCH -next v3] nbd: add the check to prevent overflow in
 __nbd_ioctl()
To:     Baokun Li <libaokun1@huawei.com>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Cc:     patchwork@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20210804021212.990223-1-libaokun1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1799b798-34dc-9589-72d8-367516daf7ee@kernel.dk>
Date:   Fri, 13 Aug 2021 13:09:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804021212.990223-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 8:12 PM, Baokun Li wrote:
> If user specify a large enough value of NBD blocks option, it may trigger
> signed integer overflow which may lead to nbd->config->bytesize becomes a
> large or small value, zero in particular.
> 
> UBSAN: Undefined behaviour in drivers/block/nbd.c:325:31
> signed integer overflow:
> 1024 * 4611686155866341414 cannot be represented in type 'long long int'
> [...]
> Call trace:
> [...]
>  handle_overflow+0x188/0x1dc lib/ubsan.c:192
>  __ubsan_handle_mul_overflow+0x34/0x44 lib/ubsan.c:213
>  nbd_size_set drivers/block/nbd.c:325 [inline]
>  __nbd_ioctl drivers/block/nbd.c:1342 [inline]
>  nbd_ioctl+0x998/0xa10 drivers/block/nbd.c:1395
>  __blkdev_driver_ioctl block/ioctl.c:311 [inline]
> [...]
> 
> Although it is not a big deal, still silence the UBSAN by limit
> the input value.

Applied with unlikely() removed.

-- 
Jens Axboe

