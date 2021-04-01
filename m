Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4FB352040
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhDAUDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:03:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45358 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbhDAUDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:03:07 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lS1Wt-0004mZ-5A
        for linux-kernel@vger.kernel.org; Thu, 01 Apr 2021 17:54:51 +0000
Received: by mail-wr1-f69.google.com with SMTP id e10so3084130wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 10:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4CFEk31lTBQWiiG7xpH+2x4YOILEoKb0ei8GsZfyc6M=;
        b=AXZdRFPH3qWCN+kY8Fo/k+xHBk2KOQZYIHMsbw2H7d0LliD/V80aCBoJUCVlzd4f1B
         5C5p/0QjYpN4MJQWyVnC/ETk93E+P0NmJy78Xv6jTbFq+6m88iOAA/c7QC4QSoo/RMk1
         BdIRQXwC4igw5il5OsuTNfL9UKr8aaXBQHTp+ZndzKnDSaSfVFagqEVh6ir/0n+vHO8P
         LqJNmmc822+TVaY0ubb0jMrGAhEovvSQQWzmDQAFp+znO/epkjpWlnvSk1gVTJqi5m8P
         EkOqXT4ywCgwqvmKAOVF49aCA6PGdRSxRUV75dyW4QlyFd4UlomrD5sYmOVxe1XfT5Rx
         IMjg==
X-Gm-Message-State: AOAM532TX1wCaunG8EZ5NjGDw7k+JqZZ8q1LMmK+xfeEagCME8K9oKg1
        UxVtdzwBvHJYJjuA62/QzPxSM1IzRL5UmCckL+E9pU0nK2zKQOGANJuPFdPQmisDasZ1XXbel5w
        tQoIthDorZFkLQmcuMsgy/9IQTHIUgHsyOQK+rwscmg==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr11550916wrk.146.1617299690879;
        Thu, 01 Apr 2021 10:54:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGW8yJwE93ict/YwQPJbUO7czbRnQb9qCGHhsljP71igXkiNSeAG4zprIUYcV5sJ4fZi6pAg==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr11550902wrk.146.1617299690759;
        Thu, 01 Apr 2021 10:54:50 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id l8sm11083996wrx.83.2021.04.01.10.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 10:54:50 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] NVIDIA Tegra memory improvements
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210330230445.26619-1-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <b9bc9700-d3c1-54b4-72a3-ace4c3b9e9ed@canonical.com>
Date:   Thu, 1 Apr 2021 19:54:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330230445.26619-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2021 01:04, Dmitry Osipenko wrote:
> Hi,
> 
> This series replaces the raw voltage regulator with a power domain that
> will be managing SoC core voltage. The core power domain patches are still
> under review, but it's clear at this point that this is the way we will
> implement the DVFS support.
> 
> The remaining Tegra20 memory bindings are converted to schema. I also
> made a small improvement to the memory drivers.
> 
> Changelog:
> 
> v2: - Fixed typos in the converted schemas.
>     - Corrected reg entry of tegra20-mc-gart schema to use fixed number of items.
>     - Made power-domain to use maxItems instead of $ref phandle in schemas.
> 
> Dmitry Osipenko (6):
>   dt-bindings: memory: tegra20: emc: Replace core regulator with power
>     domain
>   dt-bindings: memory: tegra30: emc: Replace core regulator with power
>     domain
>   dt-bindings: memory: tegra124: emc: Replace core regulator with power
>     domain
>   dt-bindings: memory: tegra20: mc: Convert to schema
>   dt-bindings: memory: tegra20: emc: Convert to schema
>   memory: tegra: Print out info-level once per driver probe

Thanks, applied subset - 1-4 and 6. For patch 5/6 I expect v3.

Best regards,
Krzysztof

> 
>  .../nvidia,tegra124-emc.yaml                  |   7 +-
>  .../memory-controllers/nvidia,tegra20-emc.txt | 130 --------
>  .../nvidia,tegra20-emc.yaml                   | 294 ++++++++++++++++++
>  .../memory-controllers/nvidia,tegra20-mc.txt  |  40 ---
>  .../memory-controllers/nvidia,tegra20-mc.yaml |  79 +++++
>  .../nvidia,tegra30-emc.yaml                   |   7 +-
>  drivers/memory/tegra/tegra124-emc.c           |  12 +-
>  drivers/memory/tegra/tegra20-emc.c            |  20 +-
>  drivers/memory/tegra/tegra30-emc.c            |  18 +-
>  9 files changed, 406 insertions(+), 201 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.yaml
> 


Best regards,
Krzysztof
