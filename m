Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA5A333A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 11:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhCJKlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 05:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhCJKlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:41:04 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925CBC061762
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 02:41:03 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id f12so22742768wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 02:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WkEYLNZKWBGlnhJh5/km8rZ3DoQwSCNLt1pwHkgN/WY=;
        b=mHQYTozuc0TTEvwola4UDXnujaWX5hjYQa9oyx2Km6taceH5yU6itTe3PHtZRoodFk
         PcpDyrzEdhly/3+4FAgeUEG40pSos2nmuPn1KTn0DaKzmxXkOLlhaSMgX3xY0TP5yGho
         XUAGxYyDak/7+4NtvRj+ZYLT5U1J2/9BlGZ3cDktu+mUvRsohm8uzz6kt2LvcNFTcmIJ
         iLoeMXyTF9AvGdP4MtkZmWxddvxG8KX8rGFLE97/3fMt941pJ/GCNgLhf3sq73X85KMT
         ZvEMyGQ06vuK16Gnxi7/pPa0ZujXMlI26tTXN4iq9PCwUotcEIAVxQcOPv9rOzFR0PW4
         Q9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WkEYLNZKWBGlnhJh5/km8rZ3DoQwSCNLt1pwHkgN/WY=;
        b=ddUsmDqeqqFfu43pCpbwWvl+FjbvCfexuChmOZgnzeBt8s+hVubD0w6wbuB3SgI0N3
         y8TKIV7GCYS3UzrF9aUjWCtWMJy46KOxmp/NUsHLLGhkJtuiEl00vvch6bmMZM51Ovii
         v2QLeWxLaIVyCkQrCK1bIN5j0pt0yjIGDtwRNEHGUysX4OrU15k+EfKO+XaXhpX0I4X+
         /0v7Nb9N9XsOH0lTj8N2p5AQPP43krNBdl6Ag96w3LVdfKWxg0CUPBw5lH1WI0peDxED
         KYApW2KatmlGwQ1BMbUFHnItdS9FuYUT7Qkzd04Z3E/6b3plufKboOaQK3/rzjYhlvW+
         /Xwg==
X-Gm-Message-State: AOAM531GGti3H3BtJXDsId2BJincVmgqdtKX1sq5Gfu7jUvL7PVd3lcN
        UFd2lOXHI3YhptlCbsNs05uE7A==
X-Google-Smtp-Source: ABdhPJxwjavMwOHE+n1ODwYYFNhz44dTAKmAcPmhdGkziT2QVK5lAqeefbljMchSOuIx6t1sYrSA2w==
X-Received: by 2002:adf:fecc:: with SMTP id q12mr2761099wrs.317.1615372862210;
        Wed, 10 Mar 2021 02:41:02 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id x11sm8453405wmi.3.2021.03.10.02.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 02:41:01 -0800 (PST)
Date:   Wed, 10 Mar 2021 10:40:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 07/15] mfd: Support for ROHM BD71815 PMIC core
Message-ID: <20210310104058.GH701493@dell>
References: <cover.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
 <aaec00c776c83d301cfe66685ca9c8e01cccc9d8.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaec00c776c83d301cfe66685ca9c8e01cccc9d8.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2021, Matti Vaittinen wrote:

> Add core support for ROHM BD71815 Power Management IC.
> 
> The IC integrates regulators, a battery charger with a coulomb counter,
> a real-time clock (RTC), clock gate and general-purpose outputs (GPO).
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> Changes since v2:
>   - styling / clean-ups suggested by Lee
>   - corrected clk-mode dt property values to match changed bindings
> 
>  drivers/mfd/Kconfig              |  15 +-
>  drivers/mfd/rohm-bd71828.c       | 486 +++++++++++++++++++-------
>  include/linux/mfd/rohm-bd71815.h | 563 +++++++++++++++++++++++++++++++
>  include/linux/mfd/rohm-bd71828.h |   3 +
>  4 files changed, 934 insertions(+), 133 deletions(-)
>  create mode 100644 include/linux/mfd/rohm-bd71815.h

[...]

> diff --git a/include/linux/mfd/rohm-bd71815.h b/include/linux/mfd/rohm-bd71815.h
> new file mode 100644
> index 000000000000..9927aadac234
> --- /dev/null
> +++ b/include/linux/mfd/rohm-bd71815.h
> @@ -0,0 +1,563 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *

Nit: If you rework this for any reason, please remove this line.

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
