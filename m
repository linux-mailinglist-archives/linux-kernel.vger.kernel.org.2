Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4571E3A4869
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhFKSHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhFKSHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:07:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2B1C061574;
        Fri, 11 Jun 2021 11:05:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso9089620wms.1;
        Fri, 11 Jun 2021 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=bN6nTLxY4EsdLFWLAWGteRiQWDdS+7C3QFVM088ASFE=;
        b=MM4COoLSA7xG8EChlBEJ5B1a4kKgW8GYL3rFLe6rgXd6dn1J+MOxxh8OBahI8Hf3qU
         +IJVTL1QnCphHj6oaxN+dt+SObRs3mRxsjlRmjvRxbEArc50YKYVF9yHU0ZvZO09yMwC
         znDdwS39pU0jkxg6Js37O8sxuwXXTUBffOZuewsnqSGzGs+u3xOVwfQ1iwXHo+aw+vIV
         YDP2acm0m9nDjx6LypqbhkCFNS4twy3JWewxVb+u/uVbEpyNkTPgOxeNglCF7gpyh+jQ
         ANxc/c0GKqCQBa7u0xibwBT4hYPzrrcqUlWKf4t6IAh92oXBzAr9b/WiHYtvOhw0bCAe
         uZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bN6nTLxY4EsdLFWLAWGteRiQWDdS+7C3QFVM088ASFE=;
        b=TCiITQcD74tNDOuqF5O7guouhbp73gDniXeu7K5o19lTH60MaBfT2tpbrhk+/h5VFg
         peBnsajNbVkHDY2RJlTQ2qNK2j0OXSP/oAdSPqSVLUg9XL6zL3/BwhcP25sG/hf3aYGA
         PNypx0M4ZvDfBWqSBuv0oSM5MfFAdTW8a3uz/tepcg9z88WOR/e6y2OtDqBfTU0drlOD
         uX9dZ9Gvb5rkPhWy3u/i/IQTW8MGbbcZybnUg+BpF9WsMgucndGXudaKTxl7++0ZX5yB
         7uNtq4FJz+K5vMlvEo+SJx7UkyQd0Ojv18FKOl2uXcSKNrY5sdM04LA1wkf3E+DJLdUd
         oKLw==
X-Gm-Message-State: AOAM533hXVXfqXTGAo0RzGG+TzHQFrBPxo832dPSzL6IbvonU+a7sIj/
        AONAefDnJH4Vn8jTBiDQd5M=
X-Google-Smtp-Source: ABdhPJzIrCFOo0eiP8MxWhbZw3VV3cxplb7U2Gsw28q2AGWfsBBjPEgKHks424+y3z36m1ru4TB1Ug==
X-Received: by 2002:a05:600c:4f09:: with SMTP id l9mr19610113wmq.114.1623434731861;
        Fri, 11 Jun 2021 11:05:31 -0700 (PDT)
Received: from localhost.localdomain (haganm.plus.com. [212.159.108.31])
        by smtp.gmail.com with ESMTPSA id a1sm8888617wrg.92.2021.06.11.11.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 11:05:30 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] ARM: dts: NSP: Add DT files for Meraki MX65 series
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
 <20210610232727.1383117-6-mnhagan88@gmail.com>
From:   Matthew Hagan <mnhagan88@gmail.com>
Message-ID: <15622641-7689-551e-3e56-35a9eed62828@gmail.com>
Date:   Fri, 11 Jun 2021 20:02:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610232727.1383117-6-mnhagan88@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2021 00:27, Matthew Hagan wrote:

> diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx65w.dts b/arch/arm/boot/dts/bcm958625-meraki-mx65w.dts
> new file mode 100644
> index 000000000000..0045a33055c1
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm958625-meraki-mx65w.dts
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Device Tree Bindings for Cisco Meraki MX65W.
> + *
> + * Copyright (C) 2021 Matthew Hagan <mnhagan88@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "bcm958625-meraki-mx65x.dtsi"

Should be including "bcm958625-meraki-alamo.dtsi". Will fix in next version, subject to any other feedback.

