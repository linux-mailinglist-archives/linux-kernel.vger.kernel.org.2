Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350793B13B7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFWGLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 02:11:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48006 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFWGLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 02:11:01 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lvw43-0003LO-BL
        for linux-kernel@vger.kernel.org; Wed, 23 Jun 2021 06:08:43 +0000
Received: by mail-wr1-f69.google.com with SMTP id k25-20020a5d52590000b0290114dee5b660so637226wrc.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 23:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ft0xDxTbAS/DkqF80QwfrpX5K+lmscttPPKtFT3L718=;
        b=BFfzp9iEpQcDKw8vxYN4TtxBbpfqaAvp00Vq8YIAKC8fV8Dww0HApG0HWffh5+JzTf
         /nL/3DSp9+LbgOXFoz7As7jAtA9LZPY1j6OMwlEGcpQiFDOa4qtNygmeNk+eFBxzMZXp
         FehD5Xhk7eG4KkyPpVERGSe0eeeCIvGq8/lKgYo2KqI2WeXvBth6y9NzbW6ALxAaseBA
         a+xqfxLpWsuKdToF6Njaa19JF42H9Gbs0Vu541ttUt5Q00+pKNm1BV52Ne2poFnyz4Yy
         /kygecJiU9F5LR9xyHwyVBjZv7KdHglEA7SC48him/QmlmoW0BAQrZYFmacSIQ4cukOm
         t5xg==
X-Gm-Message-State: AOAM530cw3voaiSYWcqz4OeqbwC5G/dVsYIU9N4PaG0PEIlJu8UuVgkM
        +R+V5XI6Rur/0RkesfMt+Oi6bJZJ7XTJFruDUUVifznFcWTBvM5gDhBb8ff+r97yZKz2nNayfeY
        CfdlWjr1BwBPfRsmrbeuxL5qKYosf5SHDCFLimKywlw==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr9684546wrn.247.1624428523068;
        Tue, 22 Jun 2021 23:08:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQHsmrszVjqAWlc6DIo9w9CNb0wo7W5QI/0lUMBqx3D74+rrFhvB1fso2J+48Uubs2neXvDQ==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr9684525wrn.247.1624428522857;
        Tue, 22 Jun 2021 23:08:42 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id c8sm730522wri.91.2021.06.22.23.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 23:08:42 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] arm64: dts: exynos7: Add cpu cache information
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
Cc:     linux-samsung-soc@vger.kernel.org
References: <CGME20210622130203epcas5p48a3111fc6586b1bfe0bd3cb90f783ce0@epcas5p4.samsung.com>
 <20210622130551.67446-1-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0832a33f-8426-6be4-377e-a0a6331e1025@canonical.com>
Date:   Wed, 23 Jun 2021 08:08:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210622130551.67446-1-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2021 15:05, Alim Akhtar wrote:
> This patch adds cpu caches information to its dt
> nodes so that the same is available to userspace
> via sysfs.
> This SoC has 48/32 KB I/D cache for each cores
> and 2MB of L2 cache.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
> Changes since v1:
> * no change in this patch
> * changes as per Krzysztof's review comments in patch 2/2
> 
>  arch/arm64/boot/dts/exynos/exynos7.dtsi | 35 +++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

Thanks, patches look good. It's too late in the cycle, so I will take
these after the merge window.


Best regards,
Krzysztof
