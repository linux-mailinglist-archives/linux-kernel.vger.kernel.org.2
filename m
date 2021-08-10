Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AEF3E55DF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbhHJItj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:49:39 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:39720
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236991AbhHJItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:49:36 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 2FF6A3F367
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628585353;
        bh=CAgpG6WrguxqP2IRH8Bsd0WkckHriXozJ08neyhr3cI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=JWFi+ZDbq6bwz22bOA5b8cCyluHW+ZCYfAO7G58QBs8Td2VTaJBP9toRBhgY5lCt5
         o/vxQrYu1Q4MPKoA4xOVpyGrX57l+JbsMX0Yl/tOedtoLBwr/kzCu1G6twLohsFVtw
         XOHICZRCvtBOZ6KW3ouHSBVMoxkbE0NupFlmxZQijff2wUvwEiimmvUTZw80BWcBCq
         ZzuUXnR7ZkFO4c0AbCwbDjzta+aDkYKoYZBVTOVPdaQFrO6pw6wV/ObL7JW3mqnopu
         lF0C6mzv8spP0uq15DUooi8WWsb+9fG7zzE91hbwwJGWuQcVFf6+HMh2/RdknMUtZh
         RL5kMFIQgveaw==
Received: by mail-ed1-f72.google.com with SMTP id dh21-20020a0564021d35b02903be0aa37025so8188631edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 01:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CAgpG6WrguxqP2IRH8Bsd0WkckHriXozJ08neyhr3cI=;
        b=iDhGr191iaP/RRm7cnDA+LM7uw51dbtHdOmgpg8i4fYIYhhCIPt6gYsOwSf3cZBjpG
         t5i55E2flOiWysHUOkH1ZzIz7TgcydgiKUKaI63Tw13VzoBuJvnxVAh8EAlaF9SvKYFi
         MWMjLzF73cXxbKS1I1RmoVwkW0+FRP3lkDoy/yRrv2Lcw2b3PfFCJ1Z0rXBi8tGJo3cx
         CVpJeHJPGeDrYRkSkCPSf+D1y8/wad9Gwbgl0dusyLIic8sn3OEbo02AU5NMgHorGs+o
         dAmwxtA7E5K63Lc12Yb3k4tXYIZD6MGrZ+8HD7onhebdM6CXGz2m/VKfqDav2OMKwNwn
         oQ/w==
X-Gm-Message-State: AOAM531eQKLJpFiC2Z0tUTbYX50NXFp5grt1M90qLH/mgHILmIwL5Dag
        rSwlh8jxcSPXHM5y2AhbiI5ZqfjS6zPv8d6JA1RyQgTDB/iAkMGCji6X/2XUjoGf4YaE++xGNmH
        E/NET+2EH6/yTw5sL0xCWz21ACOePtQuZ5oTCx/iqBQ==
X-Received: by 2002:aa7:d815:: with SMTP id v21mr3613324edq.262.1628585352915;
        Tue, 10 Aug 2021 01:49:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz77fy9fLXSFWJs9Es0lAOffB7mrFKyLwbEVB/OFWy0HcQWY8xncNUb2Z+7ZIpeUXJe0xIKOA==
X-Received: by 2002:aa7:d815:: with SMTP id v21mr3613305edq.262.1628585352799;
        Tue, 10 Aug 2021 01:49:12 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id ee11sm6556872edb.26.2021.08.10.01.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 01:49:12 -0700 (PDT)
Subject: Re: [PATCH] thermal: exynos: Fix an error code in exynos_tmu_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Abhilash Kesavan <a.kesavan@samsung.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20210810084413.GA23810@kili>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <dfa9cdf6-5dc6-586f-9db3-300d4232acf0@canonical.com>
Date:   Tue, 10 Aug 2021 10:49:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810084413.GA23810@kili>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2021 10:44, Dan Carpenter wrote:
> This error path return success but it should propagate the negative
> error code from devm_clk_get().
> 
> Fixes: 6c247393cfdd ("thermal: exynos: Add TMU support for Exynos7 SoC")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks, good catch!

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
