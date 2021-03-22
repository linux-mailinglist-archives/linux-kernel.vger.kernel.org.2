Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88A1344789
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCVOjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhCVOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:39:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68383C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:39:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h10so19613812edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SjgNHXvq7cJESfZig4dPCnkMu4c0xea+yITeMSWUkvY=;
        b=s8QUroAINe7EMlrSGg+jY+mBaOD2RrahcHWNxoDF58gs6A4UaptTwDnyLlOjrLP18/
         EM+qnAYvJjYuwyrqrWP1+LmXx5NQKEDkjrKP8rzbMcbAm1Xya1OCF2usz1lQ9nB37vGX
         veZwoxcLLCCZlRnYlr7U6D5Y+wHXnvrr8zvdCTDZf16d3/JJ01hvhgHSoDVrvoKlSohX
         VjaalTHNAZJ03O9ExVZSyu2fxkh0GbMH1WMPbQqRN5dBVeRCncYkRnhAYZMEOt2WPgtl
         hc54qQpSdgSVLthkejsjHFe9qjk5pTejZetmzFT+Q5EtQqLQivVdwOa/X4jaGhhXLUxc
         SX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SjgNHXvq7cJESfZig4dPCnkMu4c0xea+yITeMSWUkvY=;
        b=B/sHYymgno+nTKK7fFuw3962yL5tRKYR7048/CPmpj0OcrcTTCZ4n1NR/TIwcSTyTw
         sd7LKyiPjuvgnaWuoSIAQ+F1ELaYxZcY1Zag7Sjof26QzKyN9R7HsqhI5LUB0Voz4eRB
         fGJzzCBa8GJztA+J3gDwSrAfws+IhrTX6jTjm5kdHbYWDC0TXna3Ic5aXhyJ+uD7Nq12
         TkBXDMDMcX0QbYVehWmqbyIYhM2nf60lw8JiroPiepaUN57XzNYpjebxnj1njT9skSsX
         I+X1l6zo6C23nbzgc0J8+MF2KmX2utU2h8u2Xn5TOC0TP+/sy0Jp+fSfOHPn7/iaUY8I
         vjUA==
X-Gm-Message-State: AOAM530oy9V9aao1/bJkoEpoBf/1X7Jd/gTralb1nYvIKkcOo50wEtfc
        gIXCbHdAt8pqiRPLDHK681O9bt+eBwHRZA==
X-Google-Smtp-Source: ABdhPJxr8xFQ3jYtkPybyAr5XJAXTUAIE1WZRsRj9b8yHSXvheQNLP9z+cvYuziGx1H1+FYI6sNbQg==
X-Received: by 2002:aa7:cd64:: with SMTP id ca4mr25743757edb.334.1616423947218;
        Mon, 22 Mar 2021 07:39:07 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id eo22sm9854915ejc.0.2021.03.22.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:39:06 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:39:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] mfd: intel-lpss: Constify device property
 structures
Message-ID: <20210322143905.GT2916463@dell>
References: <20210301144222.31290-1-andriy.shevchenko@linux.intel.com>
 <20210301144222.31290-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301144222.31290-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021, Andy Shevchenko wrote:

> There is no point to have non-constant device properties in this driver.
> Thus, constify them for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-acpi.c |  8 ++++----
>  drivers/mfd/intel-lpss-pci.c  | 10 +++++-----
>  drivers/mfd/intel-lpss.h      |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
