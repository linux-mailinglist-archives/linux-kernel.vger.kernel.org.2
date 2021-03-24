Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD58934764E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhCXKjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbhCXKi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:38:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A1C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:38:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id 14so673958wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2MN1HupZ2wU1N48DN3xopdGtWYSQO4jTJCN0wDe7jKo=;
        b=ForY/pCiS80CgudsYEzzbIxR+kr2cfbrUmgzu/ludY/Uo92HPWP+SLqDWeZfxq3WSe
         HTHwDHlrQxlLWT7P7Gq8eo9BSbEShZ7hjHRYm+FqCm5EvOgkFAEOk+QHzDYOVD+U1j0f
         tDwmW4UVfjTDmjAVPP4QM5xp5ThZOQECpMToplMoLRPOXLw/Y4IhVIILv38jPcpI6xNN
         XRdQhxIB83+2oYPLvz6k45cBAaJnHHduSScmxqQamSzovWUpRTHRSE1t5w28lN0nIAss
         g5A7AXDjoyOKqTqpGIXiA7P5po/OiVPWnnd2Q9XN/aOPBLxK67bsfxN6PjDXnw+Fs2Sx
         9y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2MN1HupZ2wU1N48DN3xopdGtWYSQO4jTJCN0wDe7jKo=;
        b=B2SNKhhTotwp45R0yFwe5RDQcyuPpl6aK06S12g4NjNhbuEgvDSf7kYNz/Tf8Zhl22
         h4tCIm7bLR0QtxRlljBs5onpLG6PTCk4wi2gpCxEJGW/G62Vz1ETQ/Q1TX5O1mSZrwgO
         S8FEhj+hEuuFmiA5Hp1n96u51NTtjQTIrtLOSvLAdTMxO6UBIfL+xJwKr1xtYXq/TwIX
         IhXPmaVNcaACpI+TPalvj9n/ya+/Nasjn/4ksNui4SA2eRL+fzNXPg/qvX/FSW8txY6O
         /7yCD4vNBY3YKyFpXMwQd2ixkkPb4TgzxGUYrYtpCaYPnHdZq1pxIQ2ElxDv4luMB1JF
         mXEA==
X-Gm-Message-State: AOAM530Ytk5V0d8wV6CBTKeX+2TYHxhG/EWUJJNNX74K+3Gfm4dSRglZ
        f2xg0lsztew5vb6wY39mkxf9AW+gXo5Wzw==
X-Google-Smtp-Source: ABdhPJwIZdrt9EiiBePHl2O9+VwbRbzY7HrD7Y+Yu81cs+LLDiS4bf1HGZlx6QURHuOw/yy5G8QTIw==
X-Received: by 2002:a5d:42ca:: with SMTP id t10mr2743090wrr.274.1616582336777;
        Wed, 24 Mar 2021 03:38:56 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id j12sm2678133wrx.59.2021.03.24.03.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 03:38:56 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:38:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RESEND 1/1] powerpc: asm: hvconsole: Move 'hvc_vio_init_early's
 prototype to shared location
Message-ID: <20210324103854.GK2916463@dell>
References: <20210303124603.3150175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303124603.3150175-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2021, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/tty/hvc/hvc_vio.c:385:13: warning: no previous prototype for ‘hvc_vio_init_early’ [-Wmissing-prototypes]
>  385 | void __init hvc_vio_init_early(void)
>  | ^~~~~~~~~~~~~~~~~~
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/hvconsole.h     | 3 +++
>  arch/powerpc/platforms/pseries/pseries.h | 3 ---
>  arch/powerpc/platforms/pseries/setup.c   | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)

Any idea who might pick this up please?

It's been on the list for months.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
