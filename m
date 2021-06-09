Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75F3A1557
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhFINVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:21:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42766 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhFINVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:21:09 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lqy6z-0006Wj-I0
        for linux-kernel@vger.kernel.org; Wed, 09 Jun 2021 13:19:13 +0000
Received: by mail-wr1-f71.google.com with SMTP id t14-20020adfe44e0000b029011851efa802so10711238wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7ukFOcIqlMyCwfcpS6HoUWpF/8CQogyFh7SodyrFVo=;
        b=kDcrZo3vp1jIQcEKZYHfG1FTtpP0E+c0FqNBWn14y/XDWSO5zkKEHudCNUqDzRzwsS
         jM/mSw9g+6QrxMedFNMJP9BJ22hl4bM0CdmWNajLmr2tPCUWTJ1CQbnf8sun5TTDKtnp
         3aFpzCTmBJazIHe566POui0WIUhGMiPgns2h5BN5r2L8adesgkqlmmsw9iizvwLyNmJV
         5w/U2CyhqKXtMqXpSoYbnEt3Y2DIy9pIDZ7ikkBKesrjSzw+CEDT/JtEkKVPcGjhF3qm
         H4Oq8blM40n3f5FM1Db706ZnDgR1qn6HbhmkT/E8npe4BaOExOwj6Q10TlkydqHqgtmv
         xIPg==
X-Gm-Message-State: AOAM531Ho6KOVyeR6M9wWgTnTtXDN0SfsbJkePvDCM/96YKbZ7tfEjva
        x64nBuqCmC3dYJcgWOOzTBiaxPpvViG3oFsEdKP5EW4rnPO3hpabKiZCN5ChDc8er3ORlvPE2ry
        n4Vyvfi7uDC+QvqrW0N7RscKASEAJPpRq+N+683JOhQ==
X-Received: by 2002:a5d:6382:: with SMTP id p2mr29405312wru.338.1623244753069;
        Wed, 09 Jun 2021 06:19:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJkaKG91SyeYUwwhszmOE+6jjkQPDwARKcdf4a5gIWrDST/QYGzNQpTMcJFkRaPMUNnLuOFg==
X-Received: by 2002:a5d:6382:: with SMTP id p2mr29405291wru.338.1623244752943;
        Wed, 09 Jun 2021 06:19:12 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id h9sm20533941wmb.35.2021.06.09.06.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:19:12 -0700 (PDT)
Subject: Re: [PATCH 1/2] memory: tegra: Add missing dependencies
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210609112806.3565057-1-thierry.reding@gmail.com>
 <20210609112806.3565057-2-thierry.reding@gmail.com>
 <0c762772-929e-2eb8-6568-4aa82ea2f9ad@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ee2846c0-9274-0888-90ac-dac72d2ab5fd@canonical.com>
Date:   Wed, 9 Jun 2021 15:19:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0c762772-929e-2eb8-6568-4aa82ea2f9ad@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2021 13:58, Dmitry Osipenko wrote:
> 09.06.2021 14:28, Thierry Reding пишет:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> When enabling the COMPILE_TEST Kconfig option, the Tegra memory
>> controller can be built without ARCH_TEGRA being selected. However, the
>> driver implicitly depends on some symbols pulled in via ARCH_TEGRA,
>> which causes the build to break.
>>
>> Add explicit dependencies for OF_EARLY_FLATTREE and OF_RESERVED_MEM to
>> the Tegra MC Kconfig option to make sure they are selected even if
>> ARCH_TEGRA is not.
>>
>> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>  drivers/memory/tegra/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
>> index f9bae36c03a3..ecfb071fc4f4 100644
>> --- a/drivers/memory/tegra/Kconfig
>> +++ b/drivers/memory/tegra/Kconfig
>> @@ -48,6 +48,8 @@ config TEGRA124_EMC
>>  config TEGRA210_EMC_TABLE
>>  	bool
>>  	depends on ARCH_TEGRA_210_SOC || COMPILE_TEST
>> +	select OF_EARLY_FLATTREE
>> +	select OF_RESERVED_MEM
>>  
>>  config TEGRA210_EMC
>>  	tristate "NVIDIA Tegra210 External Memory Controller driver"
>>
> 
> Will this work if CONFIG_OF is disabled?

Yeah, good question. That's why I propose "depends on". No issues with
unmet or circular dependencies.


Best regards,
Krzysztof
