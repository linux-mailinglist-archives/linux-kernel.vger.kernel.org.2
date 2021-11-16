Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA675453996
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 19:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbhKPSul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 13:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhKPSuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:50:40 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4B5C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:47:43 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id p17so18442209pgj.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5A7EYLAA7hSd+CWAPJgku7+U4Q5GnEVCsQPwqfwVunQ=;
        b=zXsLWJq8YZDAWNJiS1/Au9aRJK3b6nxmAJ5+uNpL/L+/zxGE2EQBbyIyF/6SgswpBb
         yrcGQbtCYObPaiFIfGZU6n7d5RJLXus4koY8gpoH4R2qBvb6aZaRqXXKtn4L8BYJdYRK
         jp+pY60T997RdeayMLSo88VDWZiS5ETnlsKeT3qLogwBtKh3af4fzDliVOGW4ZliFvnt
         8pdZZKmDII50cBjquvalbB6bAkLz777PyZixixO/I6SzwnAQXI9+Z6SCsKjzmfaAcISG
         bD5XzpPKRgI2K9/qUfPRZyKrDh8PPowIE/roW+XpL9Qx66Q03YeQ5nWgNthWH34KguRQ
         GoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5A7EYLAA7hSd+CWAPJgku7+U4Q5GnEVCsQPwqfwVunQ=;
        b=59gbUdnc9ln+SSjAb1m/uK4v2Ym9cBZ1pwJ8Gz06AXpdbAt7DWGtUohSWbRDwA3Ycv
         QfS8WXR3FqLayIjb0lDJv0RNeDahsQP2g0FxMEEVIgUQOsF/4PVsugYMeIKgcfWtvwdT
         ikdPhGJtpLI5bU+sNvA5P5ffp2nmzBvY3WqCgifv2/1YhQ9CVtT5B1WruA8wBpnIkY5S
         Idh7CqT1yna6ippWaSUKxaZ3SZK0GGwn5RVpfucU73ZpZdMQ2xAIBdntFzCoD3V8Y6gV
         /FKAwiUNIRgcTgWghWRJRFGX2FjHI/nN/280/C5zNtgy6orNYNVlt5O5zc2QpTlRERfq
         tvXw==
X-Gm-Message-State: AOAM5312ircEUO+IDWjUz5JuruVC5hkGBns+gWMA7IkLLDhHmLGnhrB9
        1DrNOF0PD5NW46jCF8JMf99YFQ==
X-Google-Smtp-Source: ABdhPJz6rwB0NI6nTE4no/y6uRy8N8F9l6NATyKKGz9GritzFxr93NWy0UxjG2NbR9Rv1u8KRWnW4A==
X-Received: by 2002:a63:d00c:: with SMTP id z12mr828277pgf.334.1637088462647;
        Tue, 16 Nov 2021 10:47:42 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q89sm3179707pjk.50.2021.11.16.10.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 10:47:41 -0800 (PST)
Date:   Tue, 16 Nov 2021 11:47:37 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] remoteproc: coredump: correct argument 2 type for
 memcpy_fromio
Message-ID: <20211116184737.GA2324186@p14s>
References: <20211110032101.517487-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110032101.517487-1-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Wed, Nov 10, 2021 at 11:21:01AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Address the sparse check warning:
> >> drivers/remoteproc/remoteproc_coredump.c:169:53:
> sparse: warning: incorrect type in argument 2 (different address spaces)
> sparse:    expected void const volatile [noderef] __iomem *src
> sparse:    got void *[assigned] ptr
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_coredump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
> index aee657cc08c6..f39c98aa1b49 100644
> --- a/drivers/remoteproc/remoteproc_coredump.c
> +++ b/drivers/remoteproc/remoteproc_coredump.c
> @@ -166,7 +166,7 @@ static void rproc_copy_segment(struct rproc *rproc, void *dest,
>  			memset(dest, 0xff, size);
>  		} else {
>  			if (is_iomem)
> -				memcpy_fromio(dest, ptr, size);
> +				memcpy_fromio(dest, (void const __iomem *)ptr, size);

Shouldn't this be (const void __iomem *) to respect the signature in [1]?

[1]. https://elixir.bootlin.com/linux/latest/source/include/asm-generic/logic_io.h#L71

>  			else
>  				memcpy(dest, ptr, size);
>  		}
> -- 
> 2.25.1
> 
