Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA3932BC91
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359378AbhCCOMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842935AbhCCKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:42 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0181BC061356;
        Wed,  3 Mar 2021 00:28:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d3so35729666lfg.10;
        Wed, 03 Mar 2021 00:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ib2TgD5LoGzEOYOzBLqBPjEaDbQedhA/DCVHfBWRCxM=;
        b=h2ZFm53/uMkUZaIMF16VaaI22yjZ3lsf5bqyAoveT937pPEp2dj85/2eEFzK/+d/uT
         NOkPQRKQZnnf+HmFa4HJeVolycoXP/cFFwI+SbCllFFuvhyU8uJYxVtg1gQSma703P/R
         vBWG4WQvZ6f48lT9u00r6irJUSEcagE5pEoxOikqmUf5z9jKORZ36aKNbzly67hUSB1j
         pji5kRLXK3bHo8CUFnpAM5OfGU10ws2zWaR2aZtTKfbpoi27MhOmhXT7PalZ+bFEG9GR
         n02UkdnTaojXDKznDb65VfgO7SyPj0gC0EWZawtJMtFDfDqqqAFd87vNrFo5ZbW0QJ8E
         n28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ib2TgD5LoGzEOYOzBLqBPjEaDbQedhA/DCVHfBWRCxM=;
        b=D1zqVrsjNt7xJYJA1NLykIiz3lmld4KJaXGObqyhVi2SJRgNuzn1CbRy3BLLDxty6r
         IbjrLUFDcRLwgbnxGPllA0JdrpetSeUeqBretyePy0NgY9Fxcb3CEHBkIDypK1SdR8y5
         DbLGM6zYyYMziDBRkzU+fc6eJLZSsLMIU9wnSIczZW6UcMrABsfP8/O7GusXiSLZMrbB
         l88tTZAPfP80Hax6zCzyJqsRn3/c/eSj1gVSpwp3mQ37XVrvMq9x8uNmr5AcrEBhIsd8
         JIaOBlzFfl/CeYU9Ij08IVASTRN0Zas8tnaQJGr37ifTEI2XXSddt51PXe+5qpYp7nij
         o7kQ==
X-Gm-Message-State: AOAM5316PslROQs2AC5f9xOCPfsFwMsIE2iM7imdcPW/n+xjtjtUlotI
        NaamdFq6JQD6KI44iIyM5q2Zv/f181Q=
X-Google-Smtp-Source: ABdhPJzdo3EZD4OA6XpZETK1794bIMLnAyMAhAQ3I/atDvFI3Ud5c2mLqDPfih8Lyw8AbxoS403cRQ==
X-Received: by 2002:a05:6512:a8e:: with SMTP id m14mr4917828lfu.641.1614760125381;
        Wed, 03 Mar 2021 00:28:45 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id p13sm3161447ljj.49.2021.03.03.00.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 00:28:44 -0800 (PST)
Subject: Re: [PATCH v1 5/5] ASoC: tegra30: i2s: Add reset control
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Paul Fertser <fercerpav@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210302112123.24161-1-digetx@gmail.com>
 <20210302112123.24161-6-digetx@gmail.com>
Message-ID: <cbb1f0d4-ddc5-733d-896d-dd76ce01ca69@gmail.com>
Date:   Wed, 3 Mar 2021 11:28:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210302112123.24161-6-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.03.2021 14:21, Dmitry Osipenko пишет:
> The I2S reset may be asserted at a boot time. Tegra30 I2S driver doesn't
> manage the reset control and currently it happens to work because reset
> is implicitly deasserted by the Tegra AHUB driver, but the reset of I2C
> controller should be synchronous and I2S clock is disabled when AHUB is
> reset. Add reset control to the Tegra30 I2S driver.
> 
> Note that I2S reset was always specified in Tegra30+ device-trees, hence
> DTB ABI changes aren't required. Also note that AHUB touches I2S resets,
> hence AHUB resets are now requested in a released state, allowing both
> drivers to control the I2S resets together.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  sound/soc/tegra/tegra30_ahub.c | 14 ++++++++++---
>  sound/soc/tegra/tegra30_i2s.c  | 36 +++++++++++++++++++++++++++++++++-
>  sound/soc/tegra/tegra30_i2s.h  |  1 +
>  3 files changed, 47 insertions(+), 4 deletions(-)

...
> @@ -579,7 +587,7 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ahub->reset = devm_reset_control_array_get_exclusive(&pdev->dev);
> +	ahub->reset = devm_reset_control_array_get_exclusive_released(&pdev->dev);

Thinking a bit more about this, it looks like we actually want something
like:

	devm_reset_control_array_get_exclusive_released_named()

that will request resets by given names and in a given order, similarly
to devm_clk_bulk_get(). This will be very handy for both Tegra audio and
GPU drivers. I'll prepare a v2 if there are no objections.
