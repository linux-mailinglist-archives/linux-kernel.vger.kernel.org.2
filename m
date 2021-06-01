Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD43976C0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhFAPd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbhFAPdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:33:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502A1C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:31:42 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l1so3740676pgm.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gTgOBibirnBB2GitVEyLBhHjpuO9U7MjzLnH/sLIBeU=;
        b=SbtiMkA2cXKmqnuhlqRQ/GcAh3HKmymH+KS4LHCxzinxnUkU75yjf4Io01QJJCvB7q
         hfQmHoWixiDYv/P2A6v5KOFcy3B+6G9q5iENVpSgDEkz0HTmElhlWF4KdkXD7MKdPbOz
         jBWOSb2ysqFxXA+qSnXaWcGqZcme+84ZZrUGz80DOYuWIZkFhXIH41Ck7SFC21SyX5eq
         zLGVQp0Qr6Pz5qeDfjfJUogAFfFi2xN22xACq4heVdJalh8pQpX74ViUM/oMqWxCWcsN
         dzU8NkSqnSzLy4Ij0QH3ZvUEyicLdMbOtZi3/zL3bsa85WBb3VJ4/b+D0TOVSVyCo7N7
         5hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gTgOBibirnBB2GitVEyLBhHjpuO9U7MjzLnH/sLIBeU=;
        b=a/jB69W4zcb0klChyvReWys0BPnGKVnBs+1w923xGizeZMhK9oZBGL3h+umV69SNZ9
         7mK3L4VBhhwbr8bjACf3PVjNVdmdHnxr2LNC/oP6h2mZWIJjAKgnvYt0GV93FodnNsz9
         fRMyKY4hVA2vCrXVxoqn6/MSzmQjyMCsqBTsM+0D5oopGi3Os3iFG8jK8w7cbLU8ovfc
         0bsMbBLayEz4wfJ0QfGmskc98Qpto6812JW9r3WSCo5TUBa+J7aEaay1nt331GHUEZ7w
         7STXP0HghjBK/T3Txdq4sI8WaapFauZ9iujbVRstXfVOkIoPKhnFI/hhmdjei6QlRcN+
         b3IA==
X-Gm-Message-State: AOAM530npUyEIVyAkthuw6kg07bN2Sdg616qE0Jr7fqAEgBsei2BtIvL
        vtY3fWrxTGncyk5n3nE7+B7jew==
X-Google-Smtp-Source: ABdhPJzADFE2oje+Od8nkzd/eeIdgUatVlkKC/Lu69DCAQxyWzWme1S5jWFOQp+CvZMFau1cO8TKeA==
X-Received: by 2002:a05:6a00:16c9:b029:2df:c620:8156 with SMTP id l9-20020a056a0016c9b02902dfc6208156mr22365906pfc.40.1622561501732;
        Tue, 01 Jun 2021 08:31:41 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h24sm13959682pfn.180.2021.06.01.08.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:31:40 -0700 (PDT)
Date:   Tue, 1 Jun 2021 09:31:39 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] remoteproc: imx_rproc: correct firmware reload
Message-ID: <20210601153139.GB1759269@xps15>
References: <20210601102939.16139-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601102939.16139-1-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 06:29:39PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> ENABLE_M4 should be set to 1 when loading code to TCM, otherwise
> you will not able to replace the firmware after you stop m4.
> 
> Besides ENABLE_M4, we still need set SW_M4C_RST, because this bit
> will be automatically set with SW_M4C_NON_SCLR_RST set.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  Although this is an fix, but it is not critical, patch is based on
>  https://patchwork.kernel.org/project/linux-remoteproc/cover/1620274123-1461-1-git-send-email-peng.fan@oss.nxp.com/
> 
>  drivers/remoteproc/imx_rproc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index cd2ca96a30e5..ce2ce42bee91 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -33,7 +33,8 @@
>  
>  #define IMX7D_M4_START			(IMX7D_ENABLE_M4 | IMX7D_SW_M4P_RST \
>  					 | IMX7D_SW_M4C_RST)
> -#define IMX7D_M4_STOP			(IMX7D_ENABLE_M4 | IMX7D_SW_M4C_NON_SCLR_RST)
> +#define IMX7D_M4_STOP			(IMX7D_ENABLE_M4 | IMX7D_SW_M4C_RST | \
> +					 IMX7D_SW_M4C_NON_SCLR_RST)
>  
>  /* Address: 0x020D8000 */
>  #define IMX6SX_SRC_SCR			0x00
> @@ -44,7 +45,8 @@
>  
>  #define IMX6SX_M4_START			(IMX6SX_ENABLE_M4 | IMX6SX_SW_M4P_RST \
>  					 | IMX6SX_SW_M4C_RST)
> -#define IMX6SX_M4_STOP			(IMX6SX_ENABLE_M4 | IMX6SX_SW_M4C_NON_SCLR_RST)
> +#define IMX6SX_M4_STOP			(IMX6SX_ENABLE_M4 | IMX6SX_SW_M4C_RST | \
> +					 IMX6SX_SW_M4C_NON_SCLR_RST)
>  #define IMX6SX_M4_RST_MASK		(IMX6SX_ENABLE_M4 | IMX6SX_SW_M4P_RST \
>  					 | IMX6SX_SW_M4C_NON_SCLR_RST \
>  					 | IMX6SX_SW_M4C_RST)
> @@ -691,7 +693,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  		return ret;
>  	}
>  
> -	if (!(val & dcfg->src_stop))
> +	if ((val & dcfg->src_mask) != dcfg->src_stop)
>  		priv->rproc->state = RPROC_DETACHED;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Bjorn hasn't picked up this set yet so it is best to send a v7 of [1] with this
change merged in it.

Thanks,
Mathieu 

[1]. https://patchwork.kernel.org/project/linux-remoteproc/cover/1620274123-1461-1-git-send-email-peng.fan@oss.nxp.com/

>  
>  	return 0;
> -- 
> 2.30.0
> 
