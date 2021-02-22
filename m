Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6453212CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBVJJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhBVJFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:05:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EA8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:04:43 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l30so2510703wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ibd7IrQ6fNOcWrwjYRZXsDAGOxYzONB2z6r0IEqUmQU=;
        b=yL7TzNgXytnTO6Go+i6klhnStgxH8xwdTDTXSlkHTZW3OM+XGilppMKuTdHTwqL+k7
         6PAJUBv7U86Kxu4+T0MGuOe7BctjORCj2iA8e9BK2rrkx/JsOQ7rhl+IWsO7EwzE5h9Z
         SdsRmTr38GYgbYvNXEmGmMvQwEeI7bPyW8B6irLr3ltRF8FvrZNpacs8KLLAlRmOF6lz
         Qd+bynAs7gR33jdNfKhpfQrnz7C8U+yw+RQ3EA71oM7VwFmv+H3crW17LurcXZnQ69Zh
         bUN6GevDuuY0JYwnQ1pV1pMsk9SPue+arcBYe36VlgItDmpjikMiLxwV3Goy29wbsDa6
         zh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ibd7IrQ6fNOcWrwjYRZXsDAGOxYzONB2z6r0IEqUmQU=;
        b=f9NgJCMbMIRdvoLWzKpCOuFqycZVLgqW/74M6DuSiqmokNBg1K6ygw6d7Wop2K7X0i
         NLLpskNxCP5eKw0HC4hVX5WBJewS40wohx1fqj5c/4oGuIKsUARb1srvcBMhZYI4vTDu
         /MvbBqss6jwcP59HXWC4valuSv8teiO6QkGuqA3D63dCstTteIQzGIUbLSXkYTADijF7
         4t22Y5YP7DpCRsHtAwAuPjSIzuhsTymQjHqYMXre4fi6qrF//qcAdhrNlRG6jvV3E34p
         A4LjEm1lD7U44Gr8+rlInxbpRByvsfN7Yg0eNKFsN2jvEu+JbHg8JhtMfMzKe7tamJU6
         33RQ==
X-Gm-Message-State: AOAM5329QQ3iOTvQDq+6AToMnlYNfs3YChwqX5YkNBvlBdd67Ae21VSO
        m/sZpksf5ekkB/x2jyeGKjPeUw==
X-Google-Smtp-Source: ABdhPJwOHue/t3T/Gsj5IrX0E90nO1og7r9e8V4bXyiNtpeeZqzFVoqABJfZlXM2xJY6LhyUPWUd5w==
X-Received: by 2002:adf:ed41:: with SMTP id u1mr20403648wro.73.1613984681888;
        Mon, 22 Feb 2021 01:04:41 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id u12sm1410725wmq.38.2021.02.22.01.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 01:04:41 -0800 (PST)
Date:   Mon, 22 Feb 2021 09:04:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     openipmi-developer@lists.sourceforge.net, openbmc@lists.ozlabs.org,
        minyard@acm.org, "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        robh+dt@kernel.org, joel@jms.id.au, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 01/19] dt-bindings: aspeed-lpc: Remove LPC partitioning
Message-ID: <20210222090439.GB376568@dell>
References: <20210219142523.3464540-1-andrew@aj.id.au>
 <20210219142523.3464540-2-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210219142523.3464540-2-andrew@aj.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Feb 2021, Andrew Jeffery wrote:

> From: "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
> 
> The LPC controller has no concept of the BMC and the Host partitions.
> This patch fixes the documentation by removing the description on LPC
> partitions. The register offsets illustrated in the DTS node examples
> are also fixed to adapt to the LPC DTS change.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 100 +++++-------------
>  1 file changed, 25 insertions(+), 75 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
