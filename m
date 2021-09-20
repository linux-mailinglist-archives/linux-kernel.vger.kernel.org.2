Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A2C4119B9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhITQZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhITQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:25:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC77C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:23:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s16so8481487pfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bNaDFmzVv3uKPgKAqiQqJeFLc8FV9NeWINL4Lel0gO0=;
        b=b0pO9F7KxZdfy+vW9e/AF1J2CxXgi7bTOPPwUmpqOKwsmYQu2JrK2SDKY5lnXdSN6t
         0f+qEjn+IDksJl75FTZnuq3Vlo9rVExKtfY+L5yr+S1TDwJUA0CQnPvzeum048IbTXce
         2ok2uAVgzxTby5Xl3toVcqQt3JJIwwSRrzmg/hLzEJP4JWIzmlP3pP/V8LIURdcsdjII
         oKGh6My7P7DM69py7SaKWNKCUxD1qYv4g27xKHbze5PU6iL6CcpwMggveTWqGVvKzjxC
         7TOj9aPwETWxc1mvjrxhDQ5M5sGXQd1AHLIOQvtZ0O945FhD/n9+PI5cYuLLMcCfQiYA
         MIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bNaDFmzVv3uKPgKAqiQqJeFLc8FV9NeWINL4Lel0gO0=;
        b=Gy46Xqn0+g4UAubzSWaDiwUnGvW83FSpZZQ0yAPEDUqxLwqvCHW+AjG+BWjDT+JX2k
         mjakGKrDfKG0LUyALnY2IuSSqXE9OjXa/C5M9OHUE9J1fddCmBf4sCBO2bXciW6napZt
         LwGAuVFVKMLLl7OSZ7rHiQKRaIsgWRh2mt+2Kn9y3LVLgjLmdH7qdL+LA/rk0CidCxVF
         RtKQT+PR4zTCwQvVEwHMddlw5aYjLm/onRgzxnZkpG0oWXjDrKJNCj3AUiqw0Nf/s89P
         v6coMyDMhdNKI2luwibX4IARtUHTT6rZSlVplicM3aQLgfXURvQI14nCJx2IhdRErV9n
         rQzg==
X-Gm-Message-State: AOAM53253QLPfP/97CWXxkjezGRleg4YVOx+5cw7WizOQTcxAm5c2vJi
        P1XKV6NAjDGT/x6eR9JBQRJ36A==
X-Google-Smtp-Source: ABdhPJyoQVkhBTz7cZbF+5Gwl/g+ZNuJHTyIYkNbuUzIvtdIMoUaRelARr0HCZjzg9YMtLGBYupbXg==
X-Received: by 2002:a62:1d4d:0:b0:443:eac2:8a1b with SMTP id d74-20020a621d4d000000b00443eac28a1bmr21576833pfd.2.1632155036924;
        Mon, 20 Sep 2021 09:23:56 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p24sm14593784pfh.136.2021.09.20.09.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 09:23:55 -0700 (PDT)
Date:   Mon, 20 Sep 2021 10:23:53 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V4 1/6] remoteproc: elf_loader: fix loading segment when
 is_iomem true
Message-ID: <20210920162353.GA2023964@p14s>
References: <20210910090621.3073540-1-peng.fan@oss.nxp.com>
 <20210910090621.3073540-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910090621.3073540-2-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 05:06:16PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> It seems luckliy work on i.MX platform, but it is wrong.
> Need use memcpy_toio, not memcpy_fromio.
> 

Lucky or not I just can't understand how this worked in the first place.

> Fixes: 40df0a91b2a52 ("remoteproc: add is_iomem to da_to_va")

SHA tag should be 12 characters.

> Tested-by: Dong Aisheng <aisheng.dong@nxp.com> (i.MX8MQ)
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I will add a CC:stable, fix the title, fix the SHA and pick this patch.

> ---
>  drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index 469c52e62faff..44e7f9308f4bc 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -220,7 +220,7 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
>  		/* put the segment where the remote processor expects it */
>  		if (filesz) {
>  			if (is_iomem)
> -				memcpy_fromio(ptr, (void __iomem *)(elf_data + offset), filesz);
> +				memcpy_toio((void __iomem *)ptr, elf_data + offset, filesz);
>  			else
>  				memcpy(ptr, elf_data + offset, filesz);
>  		}
> -- 
> 2.25.1
> 
