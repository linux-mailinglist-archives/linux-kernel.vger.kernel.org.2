Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119B63AE5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFUJYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:24:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40784 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUJYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:24:47 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lvG8X-0000ZK-3C
        for linux-kernel@vger.kernel.org; Mon, 21 Jun 2021 09:22:33 +0000
Received: by mail-ej1-f71.google.com with SMTP id q14-20020a1709066aceb029049fa6bee56fso529112ejs.21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7esRvVcinYR7rlyfgxB0axaJuCa7vrRfbX3KD5RVOvA=;
        b=uKWWDPH/Ym4kNfQNqyOwgJ5ciBIF6bXfp+SjNEuIqgbeiKYlKdt5gBumh2x0JBtxeu
         r65cofibZ+ELpnkh0oib1qE7vqjBFM0elLdZgEabWf0mOVDATGzpEaeWL0Qg8zJt0Fcb
         psT5GuucOncBapFIY9xqUo7jh9ysd6FAw0P8dKW81TU640Gi5C2HHQHK236xzwKbkEzG
         0kKT2wYr8II8I2im1GVtSbq0nCCkMsk6bo/f/5lPoPDjXmPJ3i6sne2Gh2QnBJOPxkIQ
         u015g6IcFW3t27v2RKspEc2jyzVcDsNrZV4IxxNWOI1nH4dsuzq7j39WI5hMdJcE2gxD
         7cGQ==
X-Gm-Message-State: AOAM532b1PYaKkuZkGvFOpWCwZN4oc8W69RfPYBZZH0GC+hfCP41m2Ye
        ah+6KRl7jFRRMZNkPaadVYOYEYhm8pbCyjbkLxr3CDeQ/DYblWbLRO4fkgPUSrGSgIIKCYfUec5
        iFzdsCLZxK4CDGDNEmiJ62hYLX8z6JKZroHdCG8dOJA==
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr23244120ejb.542.1624267352893;
        Mon, 21 Jun 2021 02:22:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK87IiOxM4hAhjXuyIaQM65msNysHT4P/N9iideRyYDPL+x8j12EeilZUbJEJaGVB4YOM4Vw==
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr23244113ejb.542.1624267352732;
        Mon, 21 Jun 2021 02:22:32 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id gz12sm4555566ejc.36.2021.06.21.02.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 02:22:32 -0700 (PDT)
Subject: Re: [PATCH -next 4/4] ASoC: samsung: s3c24xx-i2s: Use
 devm_platform_get_and_ioremap_resource()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     s.nawrocki@samsung.com, broonie@kernel.org
References: <20210616091652.2552927-1-yangyingliang@huawei.com>
 <20210616091652.2552927-5-yangyingliang@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a5d4ccb1-e98b-f983-ff0a-d57ddd2c045e@canonical.com>
Date:   Mon, 21 Jun 2021 11:22:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616091652.2552927-5-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2021 11:16, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  sound/soc/samsung/s3c24xx-i2s.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
