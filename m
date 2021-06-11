Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276BF3A3C47
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhFKGwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 02:52:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48877 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFKGww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 02:52:52 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrb0I-0001NP-BG
        for linux-kernel@vger.kernel.org; Fri, 11 Jun 2021 06:50:54 +0000
Received: by mail-wr1-f72.google.com with SMTP id g14-20020a5d698e0000b0290117735bd4d3so2136800wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 23:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MFwg4dzMT+GNp+7cUeqFsxComPsZ7z1fOjFQNUeqhI0=;
        b=CB2BPazucMTs2G3KjlgCc3iG+bwVaoC44UZpbyl9y4uFG3wI8XkoVWVqrZpgy9Fz1i
         UCSYsmUYrgOWySf+wc8exxb1/9nttUzdt93BwXVlSO2N5zBSBAjsOHjYsgeegkpkRJXn
         SQN/NwQpuK14jjA9OaZHGlrXBHZDnYvY8Lw4bogGes9t+YNX3HSnKiBVUcP/ujLd+/ba
         Bgmo8QV6AdwnHSX9Gxh7EFzzf68bagS5/XzV4UXxXzXuDfUQVR2d4hlomK82cm2/FGe/
         toMJOBtoFbeE3xsaReMh1447kq21lKTjf1Waby82xxO2WEF+2RBtgP7IoirEDhYL6dPO
         1lHw==
X-Gm-Message-State: AOAM530qi9DOrAof2ZaD6Rbq5gHibqUQRlIDJgjn2iMccgf4RApYtLLs
        43xJVmsAm7spch/++ytVOq0fiOMdpc22ZEv3ogCHtArf63Qw/TfkXWDB8NaoHR8+RL7cwAkQ716
        fBaXWaHiSs4i9Rpo43NtRsaNLDGo9SHkpX3Zy+tYOsQ==
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr2174154wrn.117.1623394254112;
        Thu, 10 Jun 2021 23:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy31T/BcShcrMp6vqZMVXq+YF3HnLvUjMIbmy/dslDGjk5mBhfMArMfNaYMDS2ArUSnzgf7uw==
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr2174138wrn.117.1623394254009;
        Thu, 10 Jun 2021 23:50:54 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id z5sm6045020wrv.67.2021.06.10.23.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 23:50:53 -0700 (PDT)
Subject: Re: [PATCH v1] of: reserved-memory: Add stub for
 RESERVEDMEM_OF_DECLARE()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210610162313.20942-1-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <5f599a94-5977-981d-5271-3075be27c348@canonical.com>
Date:   Fri, 11 Jun 2021 08:50:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610162313.20942-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2021 18:23, Dmitry Osipenko wrote:
> The reserved-memory Kconfig could be disabled when drivers are
> compile-tested. In this case RESERVEDMEM_OF_DECLARE() produces a
> noisy warning about the orphaned __reservedmem_of_table section.
> Add the missing stub that fixes the warning. In particular this is
> needed for compile-testing of NVIDIA Tegra210 memory driver which
> uses reserved-memory.
> 
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/linux/of.h              | 11 +++++++----
>  include/linux/of_reserved_mem.h |  8 ++++++--
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
