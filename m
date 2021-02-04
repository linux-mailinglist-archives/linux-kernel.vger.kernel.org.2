Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A330F10C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhBDKiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbhBDKiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:38:08 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23AFC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 02:37:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v15so2900810wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 02:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ut2HD96uIVr60+SHCo/y5aTIX1q+AGPG3ASGala+vA4=;
        b=oIm5i6IYOCq1XJMgwhawrRT37cmrMZs+1GZy0FrvORiyGYY0E02G7aSi4e5PjXk1m2
         sYgUi6n1iLvbWBkobBl2oi+Jkn7iwHANtSvbaEiQmNIgctxzz0VSKCq3fVBGmE1MQJ4B
         lriEcAhkeezqyymnggSnNTa7iewkEoXJ1qL3GhFdkofNuwR1RGM04JyR/2ac/MuciKvA
         46ts/iYOzTYmbUCKMlF4SQrfrm5LRdVIeL30eVzGCIBUD9RDTUaugia+beipRO3Sv9e0
         aK7hxwFDEvE1AedUUTssftkmrn3K1XHzK9qGRF392/8N3waH6pDkC44lw8GWKzbpXg28
         KPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ut2HD96uIVr60+SHCo/y5aTIX1q+AGPG3ASGala+vA4=;
        b=j6L2fGEY7l72JfXl2e7D5tQK/qkOg5fUt2LVlrSbwNMHumrUc7T3fkGqNRwoYcWLYJ
         m2Ol0pko0hj1Y410NQ//0dAbhLLi/CQvGVJAU/Fa77IZ2drA2aolBEdfSPEhFNEYUq48
         BgSDDX1/sSabTEdtjLlsVFKl+fnBMBaV7+MaD7S/0+IQEBOn9p7M5kSseMuP5A8LQQFA
         rML9ax4Ou8XB/xosjOICoBpRZStSIt9x/jWgLSl26Ykus9KzxTrkxP19OZ/GM6ChCALS
         n4rWtK17qVBzYAfnSVRGnhEzyfw2lfs8xdhsw3GXfep738ItXOFXBQK1pku4RO3OpX3G
         YFBg==
X-Gm-Message-State: AOAM533TA/Lv9Tv/sTbkxhYkqBz0GQ7dgcjMBXNLZDyZfUxZVHsdqKXn
        fQsH7p9iOlXryMuRCYw3Cn0sTw==
X-Google-Smtp-Source: ABdhPJwmz32Ujgao+oLAJ2FURbWOFVFbT6YgMj2VOvD0vY61+vvfCBjMJE7lkrybGAOp7MmaIvZqsA==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr8651711wre.83.1612435046577;
        Thu, 04 Feb 2021 02:37:26 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id r12sm4450240wmg.44.2021.02.04.02.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 02:37:25 -0800 (PST)
Date:   Thu, 4 Feb 2021 10:37:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH RESEND] mfd: wm831x-auxadc: Prevent use after free in
 wm831x_auxadc_read_irq()
Message-ID: <20210204103724.GC2789116@dell>
References: <20210129143724.GX20820@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210129143724.GX20820@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021, Dan Carpenter wrote:

> The "req" struct is always added to the "wm831x->auxadc_pending" list,
> but it's only removed from the list on the success path.  If a failure
> occurs then the "req" struct is freed but it's still on the list,
> leading to a use after free.
> 
> Fixes: 78bb3688ea18 ("mfd: Support multiple active WM831x AUXADC conversions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/wm831x-auxadc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patchwork still can't find this.

I've applied it manually, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
