Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88D389C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhETDus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhETDur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:50:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A67EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:49:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso3919644pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+SnlRgT1Xc6ohfBD2dJu/m0JZhJUUZhWe06KN/vy3fY=;
        b=DRt5Ij/MVJsGZlVg9NahZ8EdbSNiK3KF68+d690p94x+QMN5DFHVOiLwSQX6XMuO/V
         /BMH0JRSBzGLpLdMoIq1viF1Y4g6R1Xh52rruHv7yoO9Q9S8tG/Pd/rad6dzfv2WyU06
         6weIC261LS2PQddhiyE+BqS5GMPZtN6X/yf5snt1m4QVF2j/ZrWBRmJKvNfj5br19BS4
         fVQ8a7U5CTuvmgcmEmWn6pOSEfb7Cl/C6YE3Lm0Ux5hIrRlBaVjAP2N0IgjLsbvBjLxJ
         zMVSKirLj3HfPVM644+/hLI4ApBWQKzJb7kToyho7CAxxcZdEGSFzW8VyDOxn+Np59Q8
         HYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+SnlRgT1Xc6ohfBD2dJu/m0JZhJUUZhWe06KN/vy3fY=;
        b=acoMmSBqMHSlAVmZhMkCR1cxNyFAsKJpUEyq/LRHHPYv1A74k+JQcSiB6lfRQpsVBg
         a6tSuR2uSfafop6BXVlbLnZuYInSHx2vRzXEWsA19WVAkznWf018H0bBAv9UWe8PV0Td
         3x3jFkRc03iGD8mAhqxAO36tz/FPDihQoTzzc4EAYti2GAmb2VsiWntZeKZD/YWivaNI
         sSrWARCWwVKoyn/ATecgofY2fEV9j0Tt5NeXBT/bSLt2o+TTPAaD5QMxTTF6hLJIKOx1
         Jht25HWJwHbk6n7p8ki7QSjkJvwHv1wxEgSxirJ5rwDegjPuttCPtevnLQlmX4vqtpI7
         7mzA==
X-Gm-Message-State: AOAM531N19deQ1EP6Ml57Bs+TPzVj/GwFzbGXtvpf2iHgdyYRYEYU2X0
        +v/0WmgsNFNq023QBij1fyoxOQ==
X-Google-Smtp-Source: ABdhPJzHYjsKL7bUvN9XeoQbFPnem90jhxUfH4NDK2Tpf0if5EUiZqVBBMYeATd3+l1X+Xx4wjmevQ==
X-Received: by 2002:a17:90a:9d88:: with SMTP id k8mr2900173pjp.64.1621482566576;
        Wed, 19 May 2021 20:49:26 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id f14sm753415pjq.50.2021.05.19.20.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 20:49:25 -0700 (PDT)
Date:   Thu, 20 May 2021 09:19:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Philippe Dixon <philippesdixon@gmail.com>
Cc:     vireshk@kernel.org, rmfrfs@gmail.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: spi: add blank line after variable
 declaration
Message-ID: <20210520034923.ddp4sxq5vfajhojz@vireshk-i7>
References: <20210519193938.GA7131@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519193938.GA7131@ubuntu>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-21, 12:39, Philippe Dixon wrote:
> This patch fixes the following checkpatch.pl warning:
> 
> WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Philippe Dixon <philippesdixon@gmail.com>
> ---
>  drivers/staging/greybus/spilib.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
> index 30655153df6a..ad0700a0bb81 100644
> --- a/drivers/staging/greybus/spilib.c
> +++ b/drivers/staging/greybus/spilib.c
> @@ -246,6 +246,7 @@ static struct gb_operation *gb_spi_operation_create(struct gb_spilib *spi,
>  	xfer = spi->first_xfer;
>  	while (msg->state != GB_SPI_STATE_OP_DONE) {
>  		int xfer_delay;
> +
>  		if (xfer == spi->last_xfer)
>  			xfer_len = spi->last_xfer_size;
>  		else

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
