Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF1E31C1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhBOSyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:54:24 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40293 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhBOSyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:54:14 -0500
Received: by mail-wm1-f48.google.com with SMTP id o24so10232094wmh.5;
        Mon, 15 Feb 2021 10:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ubEzZWPze3/t5GrzMOvVGOpAzPZ7obyaNgcvcyBuo8A=;
        b=M7tjkOXElhfcQUHFY5KrX96UkYdy6AJYPbf2QeiYx63OXaVZt/s8wurzEXXYQSs/QI
         UffG7UaM0LHBciNuHXBIN89SDG0l8As3L55STDLod1RR2XIcSIM1C8+5wRoIIXG8wcDE
         DRZu8OLjIIgA1Y5IQMt/ZzroPCZYb/BkahnVPWv0xcb2IwbamJ7pWp/T9EIWRJs7N7k4
         Y5rvlCbzPuTJTQFHEWHggTz2Rco5hzPJcoCrdg24b8x0tm+Q48tlwqV/L2w4KPu/3sQ4
         J63UqcTpee1+MfsIf6DPSshev/UmDLXwWsmNz0vjtPBUARHfe84+Jc36Y/8bJKC0xDFK
         59dg==
X-Gm-Message-State: AOAM530xbRmYkaka1+Dg40JiqgcFSK4+aO6PePgNIzNSRDUvj4WvsYjL
        4V83yrKGu8PnoDtsU+Ply1Q=
X-Google-Smtp-Source: ABdhPJy9COcGz38P5XVPC0HZXAmcQ+bCFmYwqlVFdqpT8meiVLJQp2DpRGh1bPel5XIBV0papONmdw==
X-Received: by 2002:a1c:7f4a:: with SMTP id a71mr238538wmd.92.1613415212103;
        Mon, 15 Feb 2021 10:53:32 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id i10sm32631340wrp.0.2021.02.15.10.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:53:31 -0800 (PST)
Date:   Mon, 15 Feb 2021 19:53:29 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 21/25] dt-bindings: serial: samsung: Add
 apple,s5l-uart compatible
Message-ID: <20210215185329.raxlgso6q5hcrijm@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-22-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-22-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:17:09PM +0900, Hector Martin wrote:
> Apple mobile devices originally used Samsung SoCs (starting with the
> S5L8900), and their current in-house SoCs continue to use compatible
> UART peripherals. We'll call this UART variant apple,s5l-uart.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
