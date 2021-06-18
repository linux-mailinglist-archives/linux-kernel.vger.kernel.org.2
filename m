Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D7E3AD0D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhFRRCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhFRRB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:01:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E1AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 09:59:49 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10342473otl.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 09:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=49XK1U9gaoxfY5QtITJyvfno5XduiDm+gre6lYBi/3s=;
        b=mFeyfsdeuWtcSZ/FNVQ+QgCc7JFeKeFPGXz2SjhPbhLN/i7A7XaLDqIVSczvU1PdTH
         Qme6hOPil2eBqTTPcXiz1ZSrsRPdi8QT1GV+xTKAWrxhx6VrEEkQdlAaTFkFPC4DB+9s
         r98NhmUQKgRngLA37W1BvsW1mwE1te18aLJ/EQLNJKdB6IIxE83BcZjr0akSK8oT3TC6
         WoPFPWgpWMTMxCZ9XkBhHAkX2XuXqRFeJqpAAKUsKMC4th+b3mIkEpSwcPpB3ElMqcfL
         b5d9sqa6Y6onasqQSaVMeGGXhTWlvy7pb/iwvOX8b/7II1Zu/2o6gbtvQ9zxImWY61p9
         zEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=49XK1U9gaoxfY5QtITJyvfno5XduiDm+gre6lYBi/3s=;
        b=IAvcnJliBy+CTE/5NlmyU47kLXar9/nUSwj4RA7Tc1a2+b7XhBIDPBGrtEVY4bFxXz
         nrmKDnqxtttwU0YWmLl1SFRsbFfqMPBPG+iNH6vh7Fbo3XHQGN4P4WQE88s6VC65NdMx
         DffQUlbMRV2vw3R9wDVXn9eZY6K+TigbupDCjrpyQhv3HttVJaYnlhfR6Smt/KOKSF7W
         8ygj1eSOoVN16p05Nxc2H8dGeZX4RluJviBaAqtqfuUVzOqd3+7UOeezF3a8D/CMMHwS
         sfA8pfeZohHrSjgdor/25SBenQW8shfN9TVsiWpVQ8Q4tHQQrwPEwDmUognSzgE4X5eA
         +3Ww==
X-Gm-Message-State: AOAM533ERnRScoN62VJ5vt4ktlcLvEMHJFKF48elt0EqXOMNr3sd9Qc2
        /YsVTpkgQyWGAwgupZCUzlESJw==
X-Google-Smtp-Source: ABdhPJwV59tz1OrYb8hzlY4fu/yZ8YxNdRBIRg6I/mLKYzGsZsWMTdQkXq9FZmKjrLCTslvtClcv1w==
X-Received: by 2002:a9d:2034:: with SMTP id n49mr10849585ota.231.1624035588665;
        Fri, 18 Jun 2021 09:59:48 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h8sm1893608oie.41.2021.06.18.09.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 09:59:48 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:59:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] soc: qcom: geni: add support for gpi dma
Message-ID: <YMzRAS81fkMU+jun@yoga>
References: <20210618141839.3777270-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618141839.3777270-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18 Jun 09:18 CDT 2021, Vinod Koul wrote:

> This is version 2 of the GPI dma series [1]
> 
> This series add the GPI DMA in qcom geni drivers. For this we
> first need to move GENI_IF_DISABLE_RO and struct geni_wrapper to common
> headers and then add support in the gpi dma in geni driver.
> 
> The SPI and I2C driver changes shall follow shortly
> 

Given that the continuation of this series will have build time
dependencies on these patches I think it would be good to see them all
as one chunk (and practically I can create a immutable branch of the
soc/qcom pieces and share with Wolfram and Mark).

Regards,
Bjorn

> [1]: http://lore.kernel.org/r/20210111151651.1616813-1-vkoul@kernel.org
> 
> Changes in v2:
>  - add r-b from Bjorn on patch 1
>  - add more details in log for patch 2
>  - Fix the comments from Doug and Bjorn for patch3, notable use read, modify
>    update for irq registers, use geni_se_irq_clear() for irq, dont update
>    single bit registers, add a bit more description for gpi dma etc
> 
> Vinod Koul (3):
>   soc: qcom: geni: move GENI_IF_DISABLE_RO to common header
>   soc: qcom: geni: move struct geni_wrapper to header
>   soc: qcom: geni: Add support for gpi dma
> 
>  drivers/soc/qcom/qcom-geni-se.c | 47 ++++++++++++++++++++++-----------
>  include/linux/qcom-geni-se.h    | 23 ++++++++++++++--
>  2 files changed, 52 insertions(+), 18 deletions(-)
> 
> -- 
> 2.31.1
> 
