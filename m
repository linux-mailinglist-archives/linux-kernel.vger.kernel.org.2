Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E5388E02
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351220AbhESM37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhESM36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:29:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAA8C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:28:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j14so12088737wrq.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HAplkHgGU3tRto7R2RnYLLvSSEXMkA2joJn6sNhro1k=;
        b=DJXbNNsF04XtEItOYW5lrVVZN/KsAqoEpNcq41ENC5qYeDEC6v5VcjmOgsxMUChDGy
         jQ9kUB9A6XgRtHCDd1SdAaApwcayfo7ZWDFQUWBsfqjBbi0kwl0sbh+anPqeLl8PQT/v
         dLH+xEnyySwTzPLk4Tybr2r+I7whz0byYerE50YGPGQOlKSQXBvhE+If8CZ57o6tOL3O
         6MD2luVU8HwrY08BDY/XQYM9yeJqa7Aj/T0UORHB5M4KOthY1DbiiM+mXd5DVbfkdXGD
         nZwP27zJT77FhdLYg9oUWVpx+AZCz5ePNSv9bZL7iWdyQwDpZTLulZqZqUT3z7YuWj02
         KwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HAplkHgGU3tRto7R2RnYLLvSSEXMkA2joJn6sNhro1k=;
        b=dODcCkixpNn6Pgrg2VyfwTfknBUilFxvczo8/P7n1WCtXCJitBEoiXzDIFDB0cOTy1
         yHnu6vpvGm3Dg1XFGeBfVCuaizDtlOLuef1LEcxWpphendrjAEjuCxvmvL1QQwUr9x2c
         Qwupdm9jT23f90cXec1mD1pgMKfRlgy9MwK/Fz+ZoOiEuqAJ9s1QHKAcXZrlLtVprd2r
         KRc2nmcZWdERjyRqPgoeYVzg/panqT8AtbXhGvqRDYey1/HpjepWAIzomBFoaJxBw7AS
         Q6L6Hl+MyeGW+zkzZoahmyjd3mO9b4McVFu10ebTlT/4rZ6WupNVz2afMKRxNrnknmt4
         E8GA==
X-Gm-Message-State: AOAM533GpmYuW3ae6EA0nsLW13x2u5j2SOsGji11ifcIxkAhZTyMCvVW
        +uDxoJ992zFcLZY1cr9LMpTTKg==
X-Google-Smtp-Source: ABdhPJwDg7RGHqkNTaktkcD8WZv9YGSHhvgCdm578VBT7MBZxnttVfvqsOLOnpBAgbWuj9eL+tuPcQ==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr13986195wrt.365.1621427317348;
        Wed, 19 May 2021 05:28:37 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id i11sm25952850wrq.26.2021.05.19.05.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:28:36 -0700 (PDT)
Date:   Wed, 19 May 2021 13:28:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] mfd: google,cros-ec: add DT bindings for a
 baseboard's switch device
Message-ID: <20210519122835.GC2415519@dell>
References: <20210415032958.740233-2-ikjn@chromium.org>
 <20210512100832.3878138-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210512100832.3878138-1-ikjn@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021, Ikjoon Jang wrote:

> This is for ChromeOS tablets which have a 'cros_cbas' switch device
> in the "Whiskers" base board. This device can be instantiated only by
> device tree on ARM platforms. ChromeOS EC doesn't provide a way to
> probe the device.
> 
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> ---
> 
> Changes in v6:
>  - Remove a label from cbas node in an example
> 
> Changes in v5:
>  - Add missing blank lines and change the description property's position.
>  - Add a note to description: "this device cannot be detected at runtime."
> 
> Changes in v4:
> Define cros-cbase bindings inside google,cros-ec.yaml instead of
> a separated binding document.
> 
>  .../bindings/mfd/google,cros-ec.yaml          | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
