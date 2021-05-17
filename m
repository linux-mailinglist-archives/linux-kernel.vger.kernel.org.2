Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662F5382B18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbhEQLdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:33:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37253 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbhEQLde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:33:34 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1libTt-0001Mu-J4
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 11:32:17 +0000
Received: by mail-vs1-f69.google.com with SMTP id u15-20020a67d98f0000b0290231b5a375e1so534015vsj.20
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e3FmcbAaz97i/0mGPm1xongWtwPhysb9DCbSOZdwmwA=;
        b=BpX7/LCUK47fPeNJrBwxtJsUQOxXAjxIE1x7CcBpGbKlC9mUlXNtYbcN3cGSudBgYz
         RPUJsFxNqFUZAqz12LujqTbA12Chx0p0iQp+7yHy7U0XgW2UX8+AG0Jby7cSAWnGBesE
         cYyCw/ciCAWQ1NAwkH5SrqZdfKkKNTFuw2+y+PrxjPeLt/JarX7yxdneOBqm+EcT0Mha
         0Gw+3rixHxYiXDfimAX4YwnAp7F/nYxBFE1Iz9go/qPfHJ39hM5XyshPUnVrDc7ixP64
         ewpjcQMWBBhDnQ9wmDNddZSIWGdG0SfCt4Xo5NXfeoluOXz8SYAoPy7guoPiahrDe9dL
         yUfA==
X-Gm-Message-State: AOAM530cl7O6N3XFk7wbf4pRVJeb/MiVwCEPpsnRLgtaZolnw/mmR94n
        obfUPAwFeaee+iL6gF24o/aDfmyIX1rA+h4gxYIzj3nmhV4Ak7YcCd3/Y0WhLwb5USJzBd+Z5l7
        5evyOjlV0Wp4IQI6a8I3Oi7xaxD1YfbT0a5GBlj4O0Q==
X-Received: by 2002:a67:f5d8:: with SMTP id t24mr3528630vso.6.1621251136687;
        Mon, 17 May 2021 04:32:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxba69ETvN3lOnnrYg5F3n4HbkorzTagbIUTpFc4lICqYwpy05W0NIDtIzwmjmnSTcepezZTA==
X-Received: by 2002:a67:f5d8:: with SMTP id t24mr3528605vso.6.1621251136493;
        Mon, 17 May 2021 04:32:16 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.2])
        by smtp.gmail.com with ESMTPSA id q22sm2660541uao.13.2021.05.17.04.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 04:32:16 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Enable compile-testing of Tegra memory drivers
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
References: <20210516161214.4693-1-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <2dfaf36f-481d-82bf-79b6-2e7b80cfbe0e@canonical.com>
Date:   Mon, 17 May 2021 07:32:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210516161214.4693-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2021 12:12, Dmitry Osipenko wrote:
> This series enables compile-testing for all of NVIDIA Tegra memory
> drivers.
> 
> Changelog:
> 
> v2: - Added patch which should fix compilation warning of tegra124-emc driver
>       on 64bit platforms that was reported by kernel build robot. Thanks
>       to Nathan Chancellor for the suggested fix.
> 
>         memory: tegra124: Fix compilation warnings on 64bit platforms
> 
>     - Added missing stubs to the tegra-clk header in another new patch. This
>       was also reported by kernel build robot for v1.
> 
>         clk: tegra: Add stubs needed for compile-testing
> 
>     - The memory/tegra/Kconfig now uses `if TEGRA_MC`, which was suggested
>       by Krzysztof Kozlowski to v1. This makes Tegra Kconfig to look consistent
>       with the Exynos Kconfig.
> 

Hi Thierry,

The memory drivers part depends on soc and clk patches. There is also
another series from Dmitry (devm_tegra_core_dev_init_opp_table()) with
memory-soc dependency.  I guess it makes sense you take everything via
soc-tegra, but just in case, can you keep the memory drivers on
dedicated branch?


Best regards,
Krzysztof
