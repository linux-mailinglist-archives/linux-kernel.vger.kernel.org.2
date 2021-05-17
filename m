Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17C0382B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhEQLaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:30:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37154 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbhEQL3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:29:52 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1libQJ-0000z0-4d
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 11:28:35 +0000
Received: by mail-ua1-f69.google.com with SMTP id f15-20020a9f2bcf0000b02901f8fe91b89cso3364310uaj.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=esNX7fYr4zGWw4UHT7I+6MGEmlUq84SLXsDfE2Xa3Xk=;
        b=l8jqSjSAq3PlZcakcSqGi+ebAxS44jk6m5sterrROfCqH3S0wMTlhggVfw9PlVMQYa
         QmGEDbTi3yqr173eMHW6YRGmgAZC1QFlMR27ZNIso5+uNfXi+MCXuGjj16tOWkXFlkCh
         RtykFRLxx8ShVrtrpmN99QoBIKbFu/9ogqDSQ9SHa9IDfkE/7+EzK7uuNWOKCo0xd1at
         4vevd18QMAoLKPHzi2XerSEMHEnaPV+m9yItJpIVR0SRv/SvfQAcDJibzBB0rs320t0J
         wjahmmeKKRhafAfSW9G1OTOYm3Kq2aOfSPmlZ+k0besf+WsKC3DwluKr9yheZWHwzVMC
         AcpQ==
X-Gm-Message-State: AOAM5339Dnh5MeSalZ20ZR3KYykp1NwALWpXOq89V3HVp5HfM1tH63n8
        NdHucpoilBw1Xna4VgAZfxLukbr/m9nKPyNC774e7/poLX5Q/qIM0A5CUK+L4ldbtG0lEMsecZI
        p4el1buw7rjxvJg9xraV79h491sMlXAicUwxtEz5ntw==
X-Received: by 2002:a67:d11d:: with SMTP id u29mr51137835vsi.53.1621250914186;
        Mon, 17 May 2021 04:28:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyEUoip1vAtYB4Aouqa7f3RS7fz7TyAZiT6gOnYqGGai+Ao94jeqvyUi+347N5b1UOoQVndw==
X-Received: by 2002:a67:d11d:: with SMTP id u29mr51137821vsi.53.1621250914020;
        Mon, 17 May 2021 04:28:34 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.2])
        by smtp.gmail.com with ESMTPSA id a201sm2224600vke.21.2021.05.17.04.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 04:28:33 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] memory: tegra124-emc: Fix compilation warnings on
 64bit platforms
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20210516161214.4693-1-digetx@gmail.com>
 <20210516161214.4693-4-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <936cfc7d-737e-a582-ea60-ad2ba5b4ca72@canonical.com>
Date:   Mon, 17 May 2021 07:28:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210516161214.4693-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2021 12:12, Dmitry Osipenko wrote:
> Fix compilation warning on 64bit platforms caused by implicit promotion
> of 32bit signed integer to a 64bit unsigned value which happens after
> enabling compile-testing of the driver.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra124-emc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
> index 5699d909abc2..c9eb948cf4df 100644
> --- a/drivers/memory/tegra/tegra124-emc.c
> +++ b/drivers/memory/tegra/tegra124-emc.c
> @@ -272,8 +272,8 @@
>  #define EMC_PUTERM_ADJ				0x574
>  
>  #define DRAM_DEV_SEL_ALL			0
> -#define DRAM_DEV_SEL_0				(2 << 30)
> -#define DRAM_DEV_SEL_1				(1 << 30)
> +#define DRAM_DEV_SEL_0				(2u << 30)
> +#define DRAM_DEV_SEL_1				(1u << 30)

Why not using BIT()? This would make even this 2<<30 less awkard...

Best regards,
Krzysztof
