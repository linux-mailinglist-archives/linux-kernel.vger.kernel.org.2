Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B884130FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhIUJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 05:52:46 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37546
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231508AbhIUJwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 05:52:43 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8946E40257
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632217873;
        bh=ANyVFwa8/cSt4LiPU1T6EcsddAoJy9awAm8594hSheg=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=o+ZhixaJEC81CZAoNEXB7W1IyNYWsQBwWM5gVKZsBx46nKXiL5bkywbQOrfhnAGBh
         j5ZIjD6E/6/z3F8SHZoQeJIxH80DggaDiYmlbGXrfvVSh+r8clvp8gNpiTW7Z961F0
         AZVaxNS5QWmxDfG4t4UDBNvLgDDAnipPWPEaM3k97mlvEKfoitD/hTbGw5fKMuxMTE
         sdco5sxk5LbRM+qk0Fem8DFfQ4pKRbQwDF+xnX+mHqUTg0t4Phzr9JXRBWU9tS5ix0
         mf+Vr/eYoxjxpeim/SU0HJnIlOjc3eCIto4rT4I3agIe4COJOfXIvMr7bjdO2ELGzd
         Q4+UL0j2NSgwA==
Received: by mail-wr1-f72.google.com with SMTP id m1-20020a056000180100b0015e1ec30ac3so8337688wrh.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 02:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ANyVFwa8/cSt4LiPU1T6EcsddAoJy9awAm8594hSheg=;
        b=QXTyVLajNdq9/09JWVl0bFxrbWfcZia60YhKzZJOZUkb9RiIWQEdYQJ/S8brvBdUMi
         gquAdhSWK0M8FkXnEE415LieVFt2mnsrSNoGfk1wj2V4bET69VFQ2JQDgHrKmv02uZl8
         rCRz6cF5FCpaaaiQIHlKEyasYlpJvpDuURzWTTGINNdLIHa9JfQha/3LSVU967AMmmxf
         eq3w9De21MAW3GhfThokYYRhQHmZNeijfAxfxQIfsF02zRpT2fK2ABZ5DaryWvBncL41
         IyvlYF3eKj4zcg12CnZPnObrPeDw8O2tbzV/oRJbbwPfg7k8PaTInfExacLqrsZimXQ5
         t5iw==
X-Gm-Message-State: AOAM532hG81t05tX9Tl4fm5GXlt/b3SCtWyaAL4DFl92E9QmfBOAmOZl
        /iQapRZDpCajSx+f3tozRNGQgQ+uvWFtDJWap8MTWnO90UPIpiK9nK6NX8msmzVaPzLpwIX+AJT
        QxvrGgSKYK8ln/U5J1Jye9L/efKW4gM2TRNoAX6/a1Q==
X-Received: by 2002:a1c:210a:: with SMTP id h10mr3660093wmh.117.1632217872135;
        Tue, 21 Sep 2021 02:51:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaD4ttkkbvIoXdYO3QkoQKEbWCzyZA83Qx0shJpz/rWqDxNHrBU0ogPqjDK6L54QUP/fwE2Q==
X-Received: by 2002:a1c:210a:: with SMTP id h10mr3660066wmh.117.1632217871940;
        Tue, 21 Sep 2021 02:51:11 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id x21sm2264969wmc.14.2021.09.21.02.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 02:51:11 -0700 (PDT)
Subject: Re: [PATCH V1 2/3] trace: events: tegra_apb_dma: add SPDX license
 identifier
To:     Bitan Biswas <bbiswas@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
References: <20210921094206.2632-1-bbiswas@nvidia.com>
 <20210921094206.2632-3-bbiswas@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <17f1827a-5919-271d-ef00-d2e95d046226@canonical.com>
Date:   Tue, 21 Sep 2021 11:51:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210921094206.2632-3-bbiswas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2021 11:42, Bitan Biswas wrote:
> Add GPL license in Tegra apb dma trace header file.
> 
> Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
> ---
>  include/trace/events/tegra_apb_dma.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/events/tegra_apb_dma.h b/include/trace/events/tegra_apb_dma.h
> index 971cd02d2daf..fe10897b00b8 100644
> --- a/include/trace/events/tegra_apb_dma.h
> +++ b/include/trace/events/tegra_apb_dma.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Looks good, but you should Cc the copyrights holder (Ben) to be nice and
friendly.

Best regards,
Krzysztof
