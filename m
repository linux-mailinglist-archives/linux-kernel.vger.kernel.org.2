Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3480334D3FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhC2PdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhC2PdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:33:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BB8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:33:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j18so13314401wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6S59QvVKMEA7QZNeRiH/vZL9UgEuqddM2QtPabiSR8Q=;
        b=krqbhuOQUCF06c9G5rFIWOgWukje7i42PIxNHOoDCRMY3ECy74CSt4d7QsZKGE52iV
         YlELxYZfM1zHCREEZlQM1F+lNa1lh6gMY8+MZ6IR712yHgVNPrR/RF8fpFdZ3+Fc8mvV
         6EZOGxeaF9b6vxPl1cGWC3AA5NCcieErs8Cqw9dvQ+kmpcQ6BE4aDwJKztE0mVaEWeFa
         wT0XXFveMTf26ZO/6H9Z/g+HphlUqdvz1Rhnk8a9yIenZ3BujGUedBTlE1r8KFRzlvUh
         XajKk1zUBFnjum8BmgGARuL/E8Qt8d7hzZ9caB/JQKv3qta6kErXjJrD1v9suu2aumXc
         o7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6S59QvVKMEA7QZNeRiH/vZL9UgEuqddM2QtPabiSR8Q=;
        b=CmsGEbxpA6ffHY2+GeQTyECkcXt2aj00rF1XMmABcFNZoW3B87JLMALp3lRnbODoiM
         SqNVrXDJkiYMujitgjEOP3se3/TuxRx2u7YcgiFAh9N7lsDtaQ/a4126vC1HChiEvxYv
         OvcfdWS8KaqDLSjfS1RzjqB496mSNo7SbZWIwgZZ8gll2tT6GyCiivWKfI0Co1DsU3St
         RX84KK6dTSEglK2c3txihf0j7P2Xn3P8imgFG3IBZ8OahHPgZQAaWQvgDZFnyP/+ottW
         V0dCnjsP5sUjaKUNMO7MqbDTY97+Q3wlYu3BoAvQo7wptBTKpvyuMl1cZ7FLGOuNzoWE
         Llvg==
X-Gm-Message-State: AOAM532ifmQBe7pgkjebl/nbvW/LPIuQ7KimhzWUl22M24SR6i17W+uq
        ATRj3F5fErSoFeD55nqOpeo=
X-Google-Smtp-Source: ABdhPJwm5DBW5AJ1gpDpOlcDBiySR4KqOD2ncs88GWPolI3TDxRgp4K/jQFr2xrL1nc74QSrUC+94Q==
X-Received: by 2002:adf:bb4c:: with SMTP id x12mr12293184wrg.271.1617031982409;
        Mon, 29 Mar 2021 08:33:02 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id v18sm31634589wrf.41.2021.03.29.08.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 08:33:01 -0700 (PDT)
Subject: Re: [PATCH 1/2] drivers/clocksource/mediatek: Split mediatek drivers
 into 2 files
To:     Evan Benn <evanbenn@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-arm-kernel@lists.infradead.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
References: <20210318160414.1.Ia2a09ce93b47eac45308205820db0938d47604df@changeid>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <1f4dd7b1-3bb5-51eb-f980-e2ba41f43823@gmail.com>
Date:   Mon, 29 Mar 2021 17:33:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210318160414.1.Ia2a09ce93b47eac45308205820db0938d47604df@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/2021 06:04, Evan Benn wrote:
> mtk_gpt and mtk_syst drivers for mt6577 and mt6765 devices were not
> sharing any code. So split them into separate files.
> 
> Signed-off-by: Evan Benn <evanbenn@chromium.org>
> ---
> 
>  arch/arm/mach-mediatek/Kconfig                |   3 +-
>  arch/arm64/Kconfig.platforms                  |   3 +-
>  drivers/clocksource/Kconfig                   |  13 +-
>  drivers/clocksource/Makefile                  |   3 +-
>  ...mer-mediatek.c => timer-mediatek-mt6577.c} | 100 -------------
>  drivers/clocksource/timer-mediatek-mt6765.c   | 135 ++++++++++++++++++
>  6 files changed, 151 insertions(+), 106 deletions(-)
>  rename drivers/clocksource/{timer-mediatek.c => timer-mediatek-mt6577.c} (69%)
>  create mode 100644 drivers/clocksource/timer-mediatek-mt6765.c
> 
[...]
> diff --git a/drivers/clocksource/timer-mediatek-mt6765.c b/drivers/clocksource/timer-mediatek-mt6765.c
> new file mode 100644
> index 000000000000..b4f22f226feb
> --- /dev/null
> +++ b/drivers/clocksource/timer-mediatek-mt6765.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Mediatek SoCs General-Purpose Timer handling.
> + *
> + * Copyright (C) 2014 Matthias Brugger
> + *
> + * Matthias Brugger <matthias.bgg@gmail.com>

The mt6765 was written by Stanley, I think we should reflcet that. Please see:
e3af677607d9 ("clocksource/drivers/timer-mediatek: Add support for system timer")

Regards,
Matthias
