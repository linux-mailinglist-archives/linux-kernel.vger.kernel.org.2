Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7579365F49
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhDTSbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhDTSbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:31:03 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F54C06138A;
        Tue, 20 Apr 2021 11:30:25 -0700 (PDT)
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 34FF48021A;
        Tue, 20 Apr 2021 20:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1618943422;
        bh=3Jpb3+eZcEQXJ5FDrKgeysID8DsET41SVuxy3dpQ6JQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=viVEBgfjHaJJSdS+nzm1qAvxsXeHuhyezgSB9OZHtguGOFSHS9PJIbyHXaCuycCYg
         uld3Fz4LcWAcGjlHmJbN7WW0dRpuVtkgEXn4i1X4T7M7uTy44iwApBBUz3C75sK+EP
         L2Zham3bhYQftRv70024TOzlH9SJDx8rcKHdk+sfTF1p4pv4DZ77WJ34imt1GWBQJR
         2w3h/s2OYzFy4AkbVHHK7WxzTWf2fqt2aJ2kmrl+M9Qj+DoKeZLF65iF7hyDzJRvXu
         Er9SRXJM+t9ENmt4uyKXgOahkrbwaRVJ/KeuL4BLvv26ob5QOJjBr4NVg6C3yOW8Zl
         wdt32No7Sa4lg==
Subject: Re: [PATCH v3 10/11] dt-bindings: clock: stm32mp1 new compatible for
 secure rcc
To:     gabriel.fernandez@foss.st.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Etienne Carriere <etienne.carriere@foss.st.com>
References: <20210419093852.14978-1-gabriel.fernandez@foss.st.com>
 <20210419093852.14978-11-gabriel.fernandez@foss.st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <36aafe68-d313-692a-a551-4ff4147e584c@denx.de>
Date:   Tue, 20 Apr 2021 20:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210419093852.14978-11-gabriel.fernandez@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 11:38 AM, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> Introduce new compatible string "st,stm32mp1-rcc-secure" for
> stm32mp1 clock driver when the device is configured with RCC
> security support hardened.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>   .../devicetree/bindings/clock/st,stm32mp1-rcc.yaml          | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> index 4e385508f516..8b1ecb2ecdd5 100644
> --- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> @@ -54,7 +54,9 @@ properties:
>   
>     compatible:
>       items:
> -      - const: st,stm32mp1-rcc
> +      - enum:
> +          - st,stm32mp1-rcc-secure
> +          - st,stm32mp1-rcc

It is still the same IP and same SoC silicon, so shouldn't the 
configuration be discerned via DT property instead of compatible string ?
