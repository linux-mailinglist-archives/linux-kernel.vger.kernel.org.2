Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38CA31C1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhBOSwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:52:33 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:35476 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhBOSwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:52:20 -0500
Received: by mail-wm1-f53.google.com with SMTP id n10so10278765wmq.0;
        Mon, 15 Feb 2021 10:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7VLbDmBh1F/YGMxpE9NHm5x49D+lAFFocqDiTimIiEw=;
        b=oE2iut3+wtIKCrDrOD6tZhY1FqG8eXjwYwiyFnXhhiiLHiwqNK1+SrftaH9bqWuQtD
         I+5nx3c91AXh37ajlZ66T77VcEXReqo5nyQXksxDxdBPwwO0if2vdCgExJiZzZHoGbJb
         PeNxlZ9nhxCmM+/qFWKQlZOB56HawTTDTJnECkzUcUcNt9f88HqzbCWW946dzOyEEoDV
         oBUM2Lpw65LRYJqh+03UyqpL/uPMc8KwwGJfQbAPkE7fYUgWooWYeuwVfmsrD/UT6nYB
         nXIyIFNVBWu+sr9e0UGwW/j5oySviNXSTwM25jKSM3NK6D7QT9Xw7Nr7ac+zV/Fuhz+0
         bzrw==
X-Gm-Message-State: AOAM532NpRXCo7y8dvwPmSVvRxHsSAbjK1aqDzPYgbhhNuUYm8FZy6h1
        hJXbVpVrW39KC1NrHOiOC/4=
X-Google-Smtp-Source: ABdhPJzvSfb8WcTXHlyM9/N9punv4dhA6JbySGAa4T1NjeEp8641RYR8Z87lla8aUegaRoPw1jTtdg==
X-Received: by 2002:a05:600c:28d3:: with SMTP id h19mr191379wmd.147.1613415098130;
        Mon, 15 Feb 2021 10:51:38 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id t6sm15658631wrn.96.2021.02.15.10.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:51:36 -0800 (PST)
Date:   Mon, 15 Feb 2021 19:51:35 +0100
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
Subject: Re: [PATCH v2 20/25] tty: serial: samsung_tty: Use
 devm_ioremap_resource
Message-ID: <20210215185135.onivzktfscv5myh2@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-21-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-21-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:17:08PM +0900, Hector Martin wrote:
> This picks up the non-posted I/O mode needed for Apple platforms to
> work properly.
> 
> This removes the request/release functions, which are no longer
> necessary, since devm_ioremap_resource takes care of that already. Most
> other drivers already do it this way, anyway.
> 
> Also fix a bug checking the return value, which should use IS_ERR().

No, no, no. We never, never combine fixing bugs with some rework.
However devm_ioremap() returns NULL so where is the error?

Did you test your patches on existing platforms? If not, please mark all
of them as RFT on next submission, so Greg does not pick them too fast.

Best regards,
Krzysztof
