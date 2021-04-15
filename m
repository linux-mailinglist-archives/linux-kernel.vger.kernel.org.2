Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3523B3608C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhDOMD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhDOMD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:03:57 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8FFC061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:03:33 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a8so4316623uan.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yP0jz0gWkwE8Z2s8JJsAXu8+mr7EF1nBBjJ+JwFWlP8=;
        b=uLpZrxzEdpeuw9cGVX7JzwCGHIlkkbMCfghz7I83e0yN87+IwyKf4Q5nclwCchMPyE
         tayKdLL4rXlZIG3q7KwuItxAaWaD1rQGb6TUi2iuLVwZQde4OvPUYGBC5IYuMBEfudiB
         dv4ZCxBDDP2zMlWvHlyaqouhqCvnNHL0DFe0oYMshWnyeGmxooU8bZn4HE17LS6z4Ws+
         jaBP5y6764Hz8TcUO7vhOBs2Wr+t1ZJFDbPSByc6GaLI6P1FeCO9TLEcvqK2Fhtg2PHT
         yXs/HwPjC5icGgpEtEjVoo89UE9WesoQCvlmXq67kuhzvAfERZBD2HfPIfzpgTerog90
         oySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yP0jz0gWkwE8Z2s8JJsAXu8+mr7EF1nBBjJ+JwFWlP8=;
        b=Kwz1l09K/YXUY+DK8aNeOBkgOg8qei4LrhUS9gQQAa/230tA2dCTEndydWoAJN0v6o
         /dUJgfdbI6jJwPwXfuVW/TnmzcK3+KaSipm2Jl6y8idHSExTqUJV4wvGm7i/t31tHJAD
         d2/2RhrvsLv4HFny5GCrXs7DQSyZwWjBBJnMuXEWjfeECN0T4J7Qo0J7jBIS3LVMa419
         xV1djIptl9IBVsn8P4s7F2UwQ+mUH+nK0G39AaGczpvGi1zKkT6anQMA7XTFAMsN01tx
         TSsAASOnT/1whsKJFMAMGAIBQT15qFTCLVVeGSlTsVLaXwP5Ns9WrKqLQAYV71CtbzzC
         +W6w==
X-Gm-Message-State: AOAM5303Mfnoa0ysRQHk3MMdJievFfXP3A0uqGeIfGLORX7E2iuHnGYp
        Q9x3VvR2xMXHvC5fq1TBGJBDrCFidh5YGbKMRvH0Ww==
X-Google-Smtp-Source: ABdhPJzVPPBgXqqGAHLGxvLYlWpW0KUEuaGUllP9CGqxUWae4Hpv3Y7hZ4LtsuEO2vPqMLHpuyRlWLYJskPJ65NAspA=
X-Received: by 2002:ab0:4322:: with SMTP id k31mr1351719uak.15.1618488207953;
 Thu, 15 Apr 2021 05:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com> <20210415084412.51125-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210415084412.51125-2-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 14:02:49 +0200
Message-ID: <CAPDyKFog3OA3YJVQ8D4mw4N5K0Mk53BWBqJEhp2+M2geueFL5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-s3c: correct kerneldoc of sdhci_s3c_drv_data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 at 10:44, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Correct the name of sdhci_s3c_drv_data structure in kerneldoc:
>
>   drivers/mmc/host/sdhci-s3c.c:143: warning:
>     expecting prototype for struct sdhci_s3c_driver_data. Prototype was for struct sdhci_s3c_drv_data instead
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes since v1:
> 1. None
> ---
>  drivers/mmc/host/sdhci-s3c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 8e1dca625620..a07a8f011741 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -130,7 +130,7 @@ struct sdhci_s3c {
>  };
>
>  /**
> - * struct sdhci_s3c_driver_data - S3C SDHCI platform specific driver data
> + * struct sdhci_s3c_drv_data - S3C SDHCI platform specific driver data
>   * @sdhci_quirks: sdhci host specific quirks.
>   * @no_divider: no or non-standard internal clock divider.
>   *
> --
> 2.25.1
>
