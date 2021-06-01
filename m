Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5053975CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhFAOvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbhFAOvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:51:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A4AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 07:49:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h5-20020a05600c3505b029019f0654f6f1so1247050wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ihM/qXBqWzRvSoQD4j53iilM0ynqghAwVc7Zrz4ZrcY=;
        b=hBzTVjQI9L0XRaGOEzpyRjz3ZnsXv4aKJF0skfz4OE6eppuvG3Dz8etqDW3eZFu3Ay
         cu8Z1AB1oI9WAJ48ki/AXp52k9qRwbZBAi1rpQFnVqwTCxCp5gFoK085k5x9P9tg15r+
         85/Jh32kYWdzLPmCxw6PILZX/AtB311xgFMiNaB0deiQiTHkS8bX8Vbyddq15g2mUJeN
         R8sOiswLT4yiRuVUq1G0P+ZqjX+BXcNuWgfD9x8anxQZfqnMdte+69t6+CWl8MSwl9St
         0PJ1oaZlr+f31lhNePOIwrVM+HX7JdpuMBRWnjPen9Zoj6RNGsTHsfpqpZrg8SHgj4yY
         y/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ihM/qXBqWzRvSoQD4j53iilM0ynqghAwVc7Zrz4ZrcY=;
        b=Js3R4lwl1MPEg6wmvbFKwFuqPSAxV36IgAKKK+B3QQFdQFaACxkQ5SW2XOwZXH6J04
         7/mk/84jN0yr7ibwPrDyk9D5tpRr/12AYgTS7z8quUiWPVl/ET4ZWMGe63s/HVcFwEjV
         qQ5yTkuwaDx6fxrlveQMsonDrkL8+GmAm1HlUX8lQhvKooufKXOf7WDCGIFOIfw/DDHn
         Y0YSl1PCFVVggxod1M/Pl82iFDLqXFG//o2AqTZ/K0PUTuGh3ikRsvsNZmGwnETWA2C9
         ksw2BTqVPB3kq2mMmtLZO0ITcsNxauQd71cm54YteB6J/lcE3UD3dEFgGVq68wXvG9H0
         oo7Q==
X-Gm-Message-State: AOAM533ij8pZvq87ghnrI38OQ8/96N79fDE+uHIdyzago7Z0wyR+hd7k
        DA9xqbnYOLgCjENlDret4uB7yWOMsDd9Eg==
X-Google-Smtp-Source: ABdhPJyKzzXV/+PAHfSE00Fimmlh0sqGCwHz44R14tEi3mK5gO8EfT5Kqe/ywOo9kkcvQgsPWrVhaA==
X-Received: by 2002:a7b:c207:: with SMTP id x7mr20038772wmi.42.1622558966736;
        Tue, 01 Jun 2021 07:49:26 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id p6sm3842925wrf.51.2021.06.01.07.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:49:26 -0700 (PDT)
Date:   Tue, 1 Jun 2021 15:49:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] mfd: db8500-prcmu: Add devicetree bindings
Message-ID: <20210601144924.GJ543307@dell>
References: <20210518145132.428340-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210518145132.428340-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021, Linus Walleij wrote:

> This driver was merged in the early days of device tree
> on Arm in 2012 and somehow we failed to provide bindings
> for it. Fix it up with some YAML bindings.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Enforce unit name on the DT node, 'prcmu@'
> - Remove overspecified unit names for prcmu-timer and thermal and
>   use patternProperties to match this to a regexp instead.
> - Drop dependency interrupt-controller: [ interrupts ] instead make
>   interrupts required. Make interrupts required instead since
>   interrupt-controller is already required.
> ChangeLog v1->v2:
> - Make the main PRCMU node name more generic instead of
>   hammering it down to a specific address.
> ---
>  .../bindings/mfd/stericsson,db8500-prcmu.yaml | 278 ++++++++++++++++++
>  1 file changed, 278 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
