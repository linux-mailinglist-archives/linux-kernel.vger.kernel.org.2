Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310BE45C93E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347090AbhKXP5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbhKXP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:57:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C56C061714
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:54:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso5841837wmr.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eaC+aKUbi8/HkerX1h9TN1jJ5dyc1OgjJ03DE7ihVeE=;
        b=khsoD/AXPGheSlqw/XmU9zZUV9GQXZxsCxruLXYwF5XBfm62jw68XiEimtWYgix7Dm
         p8HTMKmjYGLF/VIpJusTlReo8X9Gg0ok12oBkYbgaf/738Dp4uRc1MwRuNH3bOy0FeAb
         cEv+ggEOfJdkrrkPhphgrMRhDf5EIzNd9HKl8N3Ai39D85tbT4KR7VH1FaWXvnx80eBu
         t97TilsBLPIwX8VGWox35oMmglF6yY3IueGZTxNNDZCjheEiQ8vm5/xkGfu2oOT50ECH
         J22fFpwR+3JQCx4Lbg3iLeQl/L+MplPZWaKuaAZLRsuU5LLdQ793A9lh7Y+DTfKz9f3t
         k31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eaC+aKUbi8/HkerX1h9TN1jJ5dyc1OgjJ03DE7ihVeE=;
        b=HQBCouU0hEVj8wtzMZAPvBCUrDuvvnqRhpRTqd2VkNl43/90E3akxK1W6ZTqlvPA7o
         e74RCLc9D2/eqAtm09+hFpyELqps5i1jBgterM7AOvWS/HLQo3NyA8/U/skZ50iFGTXF
         QuNB4UTeiZvlOIoMXt7ASz+knnSAImDe91LmpRjB9AjK27D5Z8YfY99/gpIj4F8Tk7fR
         sDp95WiFJfXU/w2W+LeVsmnJwa6KSA/6MV2nl179RoqoOTLtfZuHRebxE2jqW/+vZxWu
         1/eo2Zk11gQa8f324W5e+KfV8RxqYw/nZg7TEwzEjs4jqModFfvYz/92wDWUXiqlUnnt
         gBLg==
X-Gm-Message-State: AOAM531waAirAnocMY5QrrZuI8HAttHOhgvDe6b8LxggukavE4GH2gIV
        VUpp32CZBcRRYNg0jSH0ucEE9g==
X-Google-Smtp-Source: ABdhPJxZ7kfHnikIP8xAV2AYB9r4JSjXUZZ4mcZKkK0OwW7XCj1SGkLVIJ/75Ywqtv8Pa0s9H+55sw==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr16169424wmm.5.1637769238950;
        Wed, 24 Nov 2021 07:53:58 -0800 (PST)
Received: from google.com ([2.31.167.61])
        by smtp.gmail.com with ESMTPSA id t8sm102076wmq.32.2021.11.24.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:53:58 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:53:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dario Binacchi <dariobin@libero.it>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Rachna Patil <rachna@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH 0/6] input: touchscreen: am335x: fix and
 improvements
Message-ID: <YZ5gCoaHv3Y/wHIk@google.com>
References: <20211107112236.7969-1-dariobin@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211107112236.7969-1-dariobin@libero.it>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Nov 2021, Dario Binacchi wrote:

> 
> This series grew out of a touchscreen validation activity on a custom
> board. Oscilloscope measurements and driver source analysis led to these
> patches.
> 
> Added Rob Herring 'Acked-by' tag to commit "dt-bindings: input:
> ti-tsc-adc: fix tsc node example".
> 
> 
> 
> Dario Binacchi (6):
>   input: ti_am335x_tsc: set ADCREFM for X configuration
>   input: ti_am335x_tsc: fix STEPCONFIG setup for Z2
>   input: ti_am335x_tsc: lower the X and Y sampling time
>   dt-bindings: input: ti-tsc-adc: fix tsc node example
>   mfd: ti_am335x_tscadc: fix reading a tsc property from DT
>   mfd: ti_am335x_tscadc: drop the CNTRLREG_8WIRE macro
> 
>  .../bindings/input/touchscreen/ti-tsc-adc.txt  |  2 +-
>  drivers/input/touchscreen/ti_am335x_tsc.c      | 18 +++++++++++++-----
>  drivers/mfd/ti_am335x_tscadc.c                 |  7 ++++++-
>  include/linux/mfd/ti_am335x_tscadc.h           |  1 -
>  4 files changed, 20 insertions(+), 8 deletions(-)

You're going to need to rebase this set onto v5.16-rc1.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
