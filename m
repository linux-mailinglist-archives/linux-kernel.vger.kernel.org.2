Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9543CAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhJ0NrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhJ0NrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:47:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC42AC061767
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 06:44:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g205-20020a1c20d6000000b0032cc6bbd505so5737454wmg.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UdVaTsodMMYginVrZpW44w/IBiUpOzJWzGs+CDuRvjI=;
        b=VkItuuHdr5AVQhI8+5DWjpbWyyEUPBPZOqcspXgcYLbnjsoK95nIWTw3ypTsTpqCOS
         O5VFsLBzga0QfVk2bPewAKBsD3xKWS8vV0jJomJHsvze3TflcJlxfVBhixanYwpZbURM
         D750Ag+ueh57X3pVyuBu1Q4rmwJyZC8d+k+ke4CpIFblqxUpCaOp0MfOeAsJENKp8uZ5
         nN+OxsbJBwzsnmFT0L8yySw8BW6PfqyvD6Y25/mNWAzp6P7WVrLPBZTxNm6QllBAQ4V1
         REH5DrjRHPPgfIzTboARku10z9YINYw2cauESiBpb47tu32+SXppw8O9JbzCmtWDMFQT
         rUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UdVaTsodMMYginVrZpW44w/IBiUpOzJWzGs+CDuRvjI=;
        b=jVQFa8ElR9l9dEYNxRi4ueK3PeoiPjpfziWaqKsKI+YO3Ttp1Kv+90gkMgkoQfXpzY
         sjBkq/E0SU8ULPoH6JGywUYa5wpPM21KtG4gsPHa4S6Z/8+thLkMVbfzSXl5WYkkkT6m
         U9S+8mOiVR74mmb1QjG1Y4KAoEtbLdQifK18BOMBaN24XOYvsPHmSNkk7V5oAPC66qFc
         PSRnUQDbQ8gq682sTCx/CA8gKJiknE1PiQHbW/qxY6YRu/aS4pZXj/rVa+Z4WWiSaFtY
         zy6d0TyUBXRRhlH5ihPRQJfggEyP/8FYtBEwUHxThKmMDNOaqA0uflQud3yhFJdpXPBC
         olCQ==
X-Gm-Message-State: AOAM532Nh/Zi5yVHPPLds8vU0l5xy0sdmr4zbLYfGHlWFBEfKxIbpv0W
        y0XwOCyW5BqnUUMyFrWw/FRFgQ==
X-Google-Smtp-Source: ABdhPJxGf4vRrCceKOIfzIsm8TV9ZqroVYa8Ou1l/8//6iDFOKFMWLjn9c4Mggpk0CkjBIL0Gwe7NA==
X-Received: by 2002:a05:600c:40c4:: with SMTP id m4mr811612wmh.164.1635342273172;
        Wed, 27 Oct 2021 06:44:33 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id n10sm1764616wmq.24.2021.10.27.06.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 06:44:32 -0700 (PDT)
Date:   Wed, 27 Oct 2021 14:44:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 6/9] mfd: max77714: Add driver for Maxim MAX77714 PMIC
Message-ID: <YXlXvovUsvOIPYyV@google.com>
References: <20211019145919.7327-1-luca@lucaceresoli.net>
 <20211019145919.7327-7-luca@lucaceresoli.net>
 <YXG060evUw8rnR3O@google.com>
 <3520ff3d-1ec0-5500-7fee-538afa25d413@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3520ff3d-1ec0-5500-7fee-538afa25d413@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021, Luca Ceresoli wrote:

> Hi Lee,
> 
> On 21/10/21 20:43, Lee Jones wrote:
> > On Tue, 19 Oct 2021, Luca Ceresoli wrote:
> [...]
> >> diff --git a/drivers/mfd/max77714.c b/drivers/mfd/max77714.c
> >> new file mode 100644
> >> index 000000000000..4b49d16fe199
> >> --- /dev/null
> >> +++ b/drivers/mfd/max77714.c
> >> @@ -0,0 +1,165 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Maxim MAX77714 MFD Driver
> >> + *
> >> + * Copyright (C) 2021 Luca Ceresoli
> >> + * Author: Luca Ceresoli <luca@lucaceresoli.net>
> >> + */
> >> +
> >> +#include <linux/i2c.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/mfd/core.h>
> >> +#include <linux/mfd/max77714.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/regmap.h>
> >> +
> >> +struct max77714 {
> >> +	struct device *dev;
> >> +	struct regmap *regmap;
> >> +	struct regmap_irq_chip_data *irq_data;
> > 
> > Is this used outside of .probe()?
> 
> No.

Then you don't need to store it in a struct.

[...]

> >> +	/* Internal Crystal Load Capacitance, indexed by value of 32KLOAD bits */
> >> +	static const unsigned int load_cap[4] = {0, 10, 12, 22};
> > 
> > Probably best to define these magic numbers.
> 
> Since these numbers do not appear anywhere else I don't find added value in:
> 
>   #define MAX77714_LOAD_CAP_0   0
>   #define MAX77714_LOAD_CAP_10  10
>   #define MAX77714_LOAD_CAP_12  12
>   #define MAX77714_LOAD_CAP_22  22
>   [...]
>   static const unsigned int load_cap[4] = {
>       MAX77714_LOAD_CAP_0,
>       MAX77714_LOAD_CAP_10,
>       MAX77714_LOAD_CAP_12,
>       MAX77714_LOAD_CAP_12,
>   };

I don't find value in that nomenclature either! :)

I was suggesting that you used better, more forthcoming names.

 LOAD_CAPACITANCE_00_pF
 LOAD_CAPACITANCE_10_pF
 LOAD_CAPACITANCE_12_pF
 LOAD_CAPACITANCE_22_pF

> besides adding lots of lines and lots of "MAX77714_LOAD_CAP_". Even
> worse, there is potential for copy-paste errors -- can you spot it? ;)

Yes.  Straight away.

> Finally, consider this is not even global but local to a small function.
> 
> But I'd rather add the unit ("pF") to either the comment line of the
> array name (load_cap -> load_cap_pf) for clarity. Would that be OK for you?

I did have to read the code again to get a handle on things (probably
not a good sign).  To keep things simple, just add "/* pF */" onto the
end of the load_cap line for now.  That should clear things up at
first glance.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
