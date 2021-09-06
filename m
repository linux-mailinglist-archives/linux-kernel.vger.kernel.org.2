Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC32401957
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbhIFJ5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhIFJ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:57:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC62C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 02:56:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g135so4141757wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=N89MJT7Myf4RYRhKWp+/IBhW7DLXK1lKWBbZhrZUfQ8=;
        b=HXkYWAhb643d4wZ1e5GIwo6jDt1+vFvTZjwJXuPV4aJkXTCbLfxvsKMXMUDaYW0t0V
         /yu9igzA1FznUmPP0dFnqtB0vH3MUnCIXmu4gGhSn5NDtUE6kRn+paagXBqJnV4JBoT+
         yW8/IQwb+M42gE3TaVhJLxDI9/Oofk23JWWpcBg9HrN2/aiSm0UBsS1fDillAlfTLYSy
         xYpUpw/KSmAM43lcSd19WONB5iZvkuVUSsg58eFoLVAiVn5XzT8IGxS4NrMoY/Noa1V2
         kqCpVDUHGuhfAL05PPsorpgU3C9Iaumc8nzY1eZ2aN8vuTG7j0HRGk0aN80CVBiQk0/J
         7HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=N89MJT7Myf4RYRhKWp+/IBhW7DLXK1lKWBbZhrZUfQ8=;
        b=YdBwtPIbRuhsKfYHYs4CcVTPktlY6kQbZTc579Zlq7RsVMnbhYFzOEQpOLnzasaWMB
         p+/8saOGVmPekvk614dIFqvPvx38Wumvv0iDPPi6/u+4lc0V3+BBXrKI37TaBlcei4/i
         A1DWFWKnlfZ+2j4PhjmmTsZ2hDg3jFlgpOKuJBVczjHzAKmXQXdcjR0eV1l/NtBNvLgg
         RsiEHqdaKsXCODG3iR27Bt1xvkQyRwswbfYrwZaXMYo7nDDmpfJwlDYqZtITrV3YvaVy
         SGOnU5hEiBV6BvCt/5cIZU7ZIjpSEV8CN8fJpQTMP36+QuaEfKqojHPrio+xUHsZKwM2
         tMhQ==
X-Gm-Message-State: AOAM530/WnpGbh89zuKxkMvkjgg/5ixEZypcOLRMqXiiVG2rcAhNAusW
        ZnkqkHZKXuaZP8bqOKN7wj9p2g==
X-Google-Smtp-Source: ABdhPJyw094iOaQXndXR+aa9BDRajeOWAA8/8Dhxb4OS80SVpjxbZ8PgzYRWlwpBpJD4bSFEEJvSBQ==
X-Received: by 2002:a7b:c192:: with SMTP id y18mr10421231wmi.163.1630922174866;
        Mon, 06 Sep 2021 02:56:14 -0700 (PDT)
Received: from google.com ([31.124.24.187])
        by smtp.gmail.com with ESMTPSA id o10sm7724440wrc.16.2021.09.06.02.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 02:56:14 -0700 (PDT)
Date:   Mon, 6 Sep 2021 10:56:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd/syscon: Use of_iomap() instead of ioremap()
Message-ID: <YTXlvDA5imU8og8C@google.com>
References: <20210823143122.253094-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210823143122.253094-1-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021, Hector Martin wrote:

> This automatically selects between ioremap() and ioremap_np() on
> platforms that require it, such as Apple SoCs.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
