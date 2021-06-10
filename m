Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E55D3A2E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhFJOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:38:12 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:50847 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhFJOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:38:11 -0400
Received: by mail-pj1-f54.google.com with SMTP id g4so3798613pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oyVrFSGAL08XcdlFRxTSklLBcj59OiHskRNYyLrSzHI=;
        b=IYdWGjr7YsprNy0kFSPHQp45XjPXYP9w1MjsSZnyDJ/QqgCHI5PZ1g4Czgp8/tJNOq
         TsrqukcnZr1Gu6bQPqsqYdbg8XO66Jd9PDiZq2cTJ2RsL5StT2NZMFxfrUyfaFSZjhmG
         mzDGPDqNjBK5JrWQaoSAwlM3tPcCQJPKRaPtj7faLOm9Iw1332YBtKCl4F8NQ8ZaS3Pz
         A60rGBXGHC4i8NMtQ+IjIT/ztt8uMZXtN387TZYu5B34ckqTE3qa0fKRPNF/hrAEgimq
         C6gFHeiOKl2dFdIInnUGLGPgQER4rQLaZy4BUHcJ1W2L/hguSlupFIG3WAie9MUc8Lw7
         2bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oyVrFSGAL08XcdlFRxTSklLBcj59OiHskRNYyLrSzHI=;
        b=GkPKpLupeFfXJYRqmcFieqhVOzTnpmGPOuvNKn5hQXRbRUtiaWIR78XOkMWPR5Ehdb
         aCZ3E/ft4MYHVFTMowsSBrtgHfkKZTak1Y40YNRyWE1xBOTGOIDnFJWyWa+PJysH7/qi
         aNsIJvW7DPBvSXsseQbPuRIO3ztKELNGo7hs+uezLwQ0XJaj2w9jbjICA65O0kKPRX8+
         8BzGADQWIJDAxtfKQfs6lElzG/rS8731ptbvZ076z3ddQnM1pKz32IIB1OlWY6vhrYD+
         wfyapIqhJSu87l3cmdksQid6SutE/NAGIaj1Lqr0702jmd5iaaU6lWTuDefhJ1QRQOXQ
         6m7g==
X-Gm-Message-State: AOAM532+psIXj3rN1+JbDWGUxS7bS1QjmM1wZMDE7CrEf2npPJC9Me+S
        P/gVLqXsAehB9a1lPuPD1sJN
X-Google-Smtp-Source: ABdhPJzKI+jvaJVvJEwfwIekR4AVEZldcSpdOKNVfGi25TP+AmnN7uPnu1m/tzX0u7skxjpZL4Gtow==
X-Received: by 2002:a17:90a:1541:: with SMTP id y1mr3680576pja.74.1623335699620;
        Thu, 10 Jun 2021 07:34:59 -0700 (PDT)
Received: from thinkpad ([2409:4072:6d9e:80ad:d341:9a16:2c5c:2249])
        by smtp.gmail.com with ESMTPSA id j12sm2481637pfj.60.2021.06.10.07.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:34:59 -0700 (PDT)
Date:   Thu, 10 Jun 2021 20:04:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: Add NIC and ETHERNET bindings
 for Actions S500 SoC
Message-ID: <20210610143451.GD315240@thinkpad>
References: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
 <b76ceb8849370943e675e5ea1a34a25cb513faec.1622119892.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b76ceb8849370943e675e5ea1a34a25cb513faec.1622119892.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 04:16:43PM +0300, Cristian Ciocaltea wrote:
> Add the missing NIC and ETHERNET clock bindings constants for Actions
> Semi Owl S500 SoC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes in v2:
>  - Added Acked-by from Rob
> 
>  include/dt-bindings/clock/actions,s500-cmu.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/actions,s500-cmu.h b/include/dt-bindings/clock/actions,s500-cmu.h
> index a250a52a6192..a237eb26accb 100644
> --- a/include/dt-bindings/clock/actions,s500-cmu.h
> +++ b/include/dt-bindings/clock/actions,s500-cmu.h
> @@ -74,10 +74,12 @@
>  #define CLK_RMII_REF		54
>  #define CLK_GPIO		55
>  
> -/* system clock (part 2) */
> +/* additional clocks */
>  #define CLK_APB			56
>  #define CLK_DMAC		57
> +#define CLK_NIC			58
> +#define CLK_ETHERNET		59
>  
> -#define CLK_NR_CLKS		(CLK_DMAC + 1)
> +#define CLK_NR_CLKS		(CLK_ETHERNET + 1)
>  
>  #endif /* __DT_BINDINGS_CLOCK_S500_CMU_H */
> -- 
> 2.31.1
> 
