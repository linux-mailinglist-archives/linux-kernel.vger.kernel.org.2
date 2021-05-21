Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F165F38CFD2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhEUVYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:24:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56463 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhEUVYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:24:14 -0400
Received: from mail-vs1-f72.google.com ([209.85.217.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lkCbY-00015F-J9
        for linux-kernel@vger.kernel.org; Fri, 21 May 2021 21:22:48 +0000
Received: by mail-vs1-f72.google.com with SMTP id w23-20020a67d1970000b029022afcb86374so7433053vsi.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jSKiGkFsHm8qeUwaLdynXEY7fptjk7YiH8pCxN+OTOM=;
        b=QX83mB5N+abu5NQsbOEpGPFA8boqs9DXasssp+PABERELuROCNv+fa7Bah/u/CT0J1
         DuRbodh4l6uzBDvtR72UUY8gI5Sui6g+RNoR3LcOlOwhXhtuSc6C9aj3mMiaergnWWTc
         NVZtWFlrnH3jqiLUg0bO34l83Sa1I0fRP/iD+fYGh0hcXzrT3xPJPs9HKrmeaLbSmnm4
         pWXmO8rCmiV/ZCWUShJP+ZM9zcDvapirjzM+N1Xq8AwMlH0RodboRS17uXek6zCZE4zD
         b1BKjsZ2MSSs9wK8RR0wIgl/rgnXvJQfb4SLU38S3RJ59bJOtqwplsg+I594onFkK+au
         INxQ==
X-Gm-Message-State: AOAM533qx1m+Ry3GVLDgxD+kg+XUSctccsdPmaxF2L1YAs+m65T+qL2J
        0vI7lOP4jx/kRs3GD5GeDq/ESSFndb7YfnW6KupeAtJLpJQ/cWz2ItWOaxT2mVOEV1krr+/de5y
        RAilo9GshWcbAh0OWmlafxbagQuEYsoM/Ghlp2duuYA==
X-Received: by 2002:ab0:63d4:: with SMTP id i20mr11750993uap.21.1621632167735;
        Fri, 21 May 2021 14:22:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvQ2l1U8szglgOD1N+hyDpgNDWEMA/0qq5+dQBkcYT64fZxhNQR94GbFgCi0ec6pzhy1FOKA==
X-Received: by 2002:ab0:63d4:: with SMTP id i20mr11750968uap.21.1621632167595;
        Fri, 21 May 2021 14:22:47 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id 39sm798548uaq.5.2021.05.21.14.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 14:22:47 -0700 (PDT)
Subject: Re: [PATCH v1 09/13] memory: tegra20-emc: Use
 devm_tegra_core_dev_init_opp_table()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
References: <20210520230751.26848-1-digetx@gmail.com>
 <20210520230751.26848-10-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f24704bf-c9aa-1552-659f-a3eff9086ecc@canonical.com>
Date:   Fri, 21 May 2021 17:22:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520230751.26848-10-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2021 19:07, Dmitry Osipenko wrote:
> Use common devm_tegra_core_dev_init_opp_table() helper for the OPP table
> initialization.
> 
> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 48 +++---------------------------
>  1 file changed, 4 insertions(+), 44 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
