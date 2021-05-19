Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78080388C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344938AbhESLFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbhESLF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:05:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2722C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 04:04:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t206so7071196wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=axx61CsVmIC6EJaaQTkzv579XEKU5x1f7Bb8b1HhaGM=;
        b=nZwPQTaPj58JJxzQ//b0HQl8VLLVDSfVWUobnUNTXtEqF9vZFoAnO0v//Mp9mNjzOU
         Q4Fmhv8SEOc2a8evXrSh2e1SYzFnVH21poIi1ZuWO10j71fZZE9bcUkFf5ugm9+1fuIb
         IB4QoJqd+gU7nsRRIPyAx/sFP7WZpSpn+d6tjydy9QDrKigqnE5AWOTfqpRSAb8D0t+0
         t89ptUm+TNHEFmJM1qowCNTGo/lD5HDaCMnTnEXh88HgADORQw6wvcm9/XNFv6vBuNfI
         RpzX0EQ9c57noVMiv+QTMKYEEQqrNZ58GWPlNJQYe0avxmMpKd8R6Qo94RtvTkgXfwCf
         M0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=axx61CsVmIC6EJaaQTkzv579XEKU5x1f7Bb8b1HhaGM=;
        b=PIk8YRHgIhqPJp+afR1TWuHwOIvsH1nVU1bLH9Avgl9a1vyqrltUAFqTE+peZaPU18
         fnoZtCPztZigM6ubwvaJ0qHjkhdYr7mN5wrcvgxWZKrwwoYW468akTsPJZl1RKSTMdaV
         XyAepgFDHSrXTIJKCkJ4ajKaoR+QeN/75vsvXEPY8fd1vNHV84eC2h/+HwmvTMZ7YgSQ
         8Xkdo2R/+WdjGdKmYUrnp1cLM+DxxjQTqbwzabtzeNGVIdOGSSe5RbcGVQggrYMhFbXo
         a916XAVOVP6sGsLYKt0KDT8XUiqyFca+XeJBQInK8Qp8ukppBvO0GMcUnK4hCJ9Z51Ec
         XeSQ==
X-Gm-Message-State: AOAM531N//ECfrzwGQ0jBaX7cbUxI58GLThLe3TLkVxKfFr9HO5SfNxc
        3YeTD6p5npfRnqxRgbjOqUX79w==
X-Google-Smtp-Source: ABdhPJxsFqWC646GEWfefCF03WphLTde0lovkd+9AitRmiQnugfQHHOO8OLMuPlfkt5Lemgixyb/Pw==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr8208294wmj.146.1621422247488;
        Wed, 19 May 2021 04:04:07 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id a18sm5492863wmb.13.2021.05.19.04.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:04:06 -0700 (PDT)
Date:   Wed, 19 May 2021 12:03:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mfd: mt6397: add PMIC keys for MT6358
Message-ID: <20210519110357.GC2403908@dell>
References: <20210506094116.638527-1-mkorpershoek@baylibre.com>
 <20210506094116.638527-4-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506094116.638527-4-mkorpershoek@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 May 2021, Mattijs Korpershoek wrote:

> Add compatible strings and interrupts for pmic keys
> which serves as child device of MFD.
> 
> MT6358 has two interrupts per key: one for press, another one for
> release (_R)
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/mfd/mt6397-core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
