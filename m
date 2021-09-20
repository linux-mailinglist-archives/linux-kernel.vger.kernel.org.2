Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDD84112DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhITKaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:30:23 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60348
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232132AbhITKaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:30:21 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D336840192
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632133733;
        bh=h1YWBhjma4M2GwmIPdG3QPXZrXZU7YAH22dk5VSYmW0=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=ilTwwVhcb7Nf6Kp7s4B+meoifEtgKXOZPE1sVizqUBM0WxzseF14SGKkqqIz4twTr
         EgLj1sqa9gTr2Z7rtCtBC7ILXZAXSxD2gOIxT0xXJ0IXG/JL+ATjwsLst9DrePMJob
         IYHBo5vJuEYJBO9MfTo2+xyt3K+abjUHamSk59xYF9umpv3cGm0gq0+A41Qy90X4rV
         Td3Mw4Oh6HP03NFx9RkvvKH+pRlLHurr2T66Emsxo7Dr6QCkwS0eRtL3yPqozBuOQa
         LOhfEaTsWVgucdJGdN0o0/PvIGMt7Yl3CUhHeiRG8gPE9czJ8jAD3k6ERnWijJEPQy
         S63b5XyprKFZg==
Received: by mail-wr1-f71.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so1412328wrh.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 03:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h1YWBhjma4M2GwmIPdG3QPXZrXZU7YAH22dk5VSYmW0=;
        b=nejKgbW5+Z//QMcKMGt5CIRY0k5DtkOTwfVhYxwPMxewa2E0iONYdPdygzvHTNeYwF
         TjWErUAVGZeSrJRXNZxNNCTIbNcWVGU8ElD4gCnMJLG+RSEsk9api1kB+WL0WTVhSjFW
         GN5zF7YbK+h5svWq5YohJbd0AwVrwoONK17GkCSnFLxgjOIDPB6m+lcuRIecpHqqTnIk
         OZCj9M6QBvxktB8eFHu6mSw6YlhEB7k9Xuyf/F9iFESzVkH9pNeOVQua8dgzap0X5Zgb
         Hm0eC0C4qtch/oBdWPUzB1S/yxvnYEDYKvS2N7QLhq+hLjA1i38MFp9d5hviKYimRc/V
         fEeg==
X-Gm-Message-State: AOAM531DjHpv4oFz13vh3Yz+xMX6OAGld8cU+v1m0SI8265b6V/2VUTF
        9bXzRgfwpgb2mNBoKWzzkRbpdZQ+RrBT/X5Y7XNv1nQUwngG9ixnxB6cRxE4AqcrTquCc8PMnb4
        p0jLndrjoh7QiCC1Kt8uF7RvEW0zsQ6rO+UsFFHWX/A==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr23403118wml.179.1632133733198;
        Mon, 20 Sep 2021 03:28:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8roJ7mxUuaEl5Dmc1d3O4yyBSyyeQBPXjTbcVZynN4bU2hmO4ka5BX3dZbMKlKHujyenKwQ==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr23403105wml.179.1632133733070;
        Mon, 20 Sep 2021 03:28:53 -0700 (PDT)
Received: from [192.168.2.20] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id c185sm14249104wma.8.2021.09.20.03.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 03:28:52 -0700 (PDT)
Subject: Re: [PATCH] soc: samsung: exynos-pmu: select CONFIG_MFD_CORE
To:     Arnd Bergmann <arnd@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210920100613.1613919-1-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ec078007-4d70-aa24-3a18-5b1cfb9cba25@canonical.com>
Date:   Mon, 20 Sep 2021 12:28:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920100613.1613919-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2021 12:06, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using devm_mfd_add_devices() fails if no driver selects the
> MFD core code:
> 
> aarch64-linux-ld: drivers/soc/samsung/exynos-pmu.o: in function `exynos_pmu_probe':
> exynos-pmu.c:(.text+0xa0): undefined reference to `devm_mfd_add_devices'
> 
> Add the missing select statement.
> 
> Fixes: 93618e344a5e ("soc: samsung: exynos-pmu: instantiate clkout driver as MFD")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/soc/samsung/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Hi Arnd,

Thanks for the patch but this was already committed few days ago from
different author:
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/commit/?h=next/drivers&id=e37ef6dcdb1f4738b01cec7fb7be46af07816af9


Best regards,
Krzysztof
