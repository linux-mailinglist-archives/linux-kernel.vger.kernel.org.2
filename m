Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A926346DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 00:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhCWXUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 19:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhCWXUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 19:20:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F246C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 16:20:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b184so15936780pfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 16:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2mPqZ8T3s6ATLiDuP1AsIgNdhiWZsvEH4M6lDW4cfTI=;
        b=FkYfaAkO0Z6/s4JItNqmcW1gokGmTqNJc9DB36xytboCFozRTY5w7JdrA4JFNrrqUc
         PScrQdfFxWrPte+4sTO//YvN7fQwHcV4zIOKvLkNX+zkTewbGEUrY0GEDOiEQUF4vYuU
         aFAGddHODC9RZFrFAz47xwrt5Rc5jXEikRcLR5EzlVCiEtalcSZHIkFUV2dR22EvrkrX
         0xQkfBA3CaMmqYlEvQNU41R3KeX7PtTHWJztwsyq20bzwZz7nyLoXhDTLGfFphS2wpwu
         5p3iYee6HWfEVuxS+9Mfdy0BB3mLXec96LfugcFuNmiAtUKDyBgTj9/PwhGHdbLPB8XF
         4C/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2mPqZ8T3s6ATLiDuP1AsIgNdhiWZsvEH4M6lDW4cfTI=;
        b=Qceb9H1k0BVMd86VGE5RthfiOgBgGGOT6TZ8eET4hFU3ODLni7Z5KEnRMr8Kt+fTxV
         DCWI9ku2T9LGR974CVO2a4xyIHTsDCBF0rovGWILSEygtEx4Xtpknmhv2cUsJDhJlU8h
         RxQsRgltu/cw9MVZ8IWzszY32QEpf9Ctv5gXMoKjDcLSN9+LtUPztVNtx6pysCPu9WJD
         evPgPT14lhMbT2IHqiUfy7d/pmbD4jIzbwbjWnSCR9kJqmwmKIBn1qsQypU5QDWUt2fo
         McY7SiGqxCU9HWh+Z/q/ND0kgQwCPsC/LrN/jL194v/eiHt0aNiUL76da24I4M39LgEu
         eyJw==
X-Gm-Message-State: AOAM531/AdPBFG/wblIhrO/Z5IexwrjfzSDMQT5Lg9Xbt+3LMF0nby9L
        j3BMT0jrg5DPDSS5StSDLE+Alw==
X-Google-Smtp-Source: ABdhPJxNQ1MKjV1GEOTfkga2yU4EzySf+ImHzG//t/vH8JyfFvC/Ow4Oj+kKSp7Y3MjTm9kaPF1qEw==
X-Received: by 2002:a17:902:8e89:b029:e6:ef44:6a54 with SMTP id bg9-20020a1709028e89b02900e6ef446a54mr756979plb.7.1616541617252;
        Tue, 23 Mar 2021 16:20:17 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 22sm230405pjl.31.2021.03.23.16.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 16:20:16 -0700 (PDT)
Date:   Tue, 23 Mar 2021 17:20:14 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: pru: Fix firmware loading crashes on K3 SoCs
Message-ID: <20210323232014.GA1782475@xps15>
References: <20210315205859.19590-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315205859.19590-1-s-anna@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 03:58:59PM -0500, Suman Anna wrote:
> The K3 PRUs are 32-bit processors and in general have some limitations
> in using the standard ARMv8 memcpy function for loading firmware segments,
> so the driver already uses a custom memcpy implementation. This added
> logic however is limited to only IRAMs at the moment, but the loading
> into Data RAMs is not completely ok either and does generate a kernel
> crash for unaligned accesses.
> 
> Fix these crashes by removing the existing IRAM logic limitation and
> extending the custom memcpy usage to Data RAMs as well for all K3 SoCs.
> 
> Fixes: 1d39f4d19921 ("remoteproc: pru: Add support for various PRU cores on K3 AM65x SoCs")
> Signed-off-by: Suman Anna <s-anna@ti.com>

Probably a good idea to CC stable as well...

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  drivers/remoteproc/pru_rproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 2667919d76b3..16979c1cd2f4 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -585,7 +585,7 @@ pru_rproc_load_elf_segments(struct rproc *rproc, const struct firmware *fw)
>  			break;
>  		}
>  
> -		if (pru->data->is_k3 && is_iram) {
> +		if (pru->data->is_k3) {
>  			ret = pru_rproc_memcpy(ptr, elf_data + phdr->p_offset,
>  					       filesz);
>  			if (ret) {
> -- 
> 2.30.1
> 
