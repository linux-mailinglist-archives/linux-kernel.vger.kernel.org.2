Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E718B3AA548
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 22:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhFPU2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 16:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhFPU2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 16:28:48 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3048C061760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:26:40 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so3892290otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T6gAZUccFikvtHCOVi1+1qn3JiUL2nu1CR9FCcCl0vw=;
        b=J/uaZSGnkBHGkMQg/39IxMz3uwjTcFNFFgiHfdL/4cg5SNHXVxYnfsS0ciu3LzKJKV
         rQCAuNJaO1Y7oLoifjLYWa1AdP14YPjexECYs8Fjc15FmDvEil6DaqQ3DJ3SpM4SA5Fm
         nbu/8lS3NmZKqOZjbzIp18VXH8tYK0Qr3Cr6QdnBFruCkpN6VOnsM07MXtwBTCJ/goGm
         VCGjjiEatOMYQW+5nkaxVBu11QWLIGH1DQK0gHLHEnCDEbaVssB8oF2EOzQ52POxe/57
         /4UsfSYfXHOtQmEFLUutCYn7IXYkaUjtTOoZZHRI0GFH55DDkqqed/6u60qo2+JNGYoq
         dJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T6gAZUccFikvtHCOVi1+1qn3JiUL2nu1CR9FCcCl0vw=;
        b=dqEAGkHCCHCwi7GS8plK0Au8wWa9iflUN4Rk7JN/lfylpjpRwSPammjykdlibnMRI8
         use8Ry+vDC6vJTQMSQ+3pytIL84eBegDiQBpNBj4P2OPWMXHFb1bghDtjD1QUzbsDLDJ
         z+mHuRaZ5Z5GwbDUG1NXXLNAbyE+yzC3ZnfU9XM+ii0es4PgOMC+xPyYxVekpfKlpxsu
         pOglzV2oeacNJWzvBLSI4VZ3ht2g0WWM7UI+vhmqf2OZL2/f5MqJvU+SBwYOlgiUpGdl
         mWZnuCmSGdiZxa5G6PSM2kDp+OMpwY6h/t2SoC/F+S8dpEVjiBVmKEzF266crmGWbmXp
         G1QQ==
X-Gm-Message-State: AOAM530yqPIsKmAk3EOq5/LRex2vw9NyJj/ZXAK7yKUp0x2oO/kaw2Y7
        R8GH9drq5x6dfV358BAykUK+Vw==
X-Google-Smtp-Source: ABdhPJwtJnLmMYb4u0xCB0siYoVRKCx2zq1adGTibu3BIJ45pIRYbWxgJUiCYuJ5TeotUMoowtOdwA==
X-Received: by 2002:a05:6830:411c:: with SMTP id w28mr1462057ott.196.1623875200030;
        Wed, 16 Jun 2021 13:26:40 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v1sm796040ota.22.2021.06.16.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:26:39 -0700 (PDT)
Date:   Wed, 16 Jun 2021 15:26:37 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     jassisinghbrar@gmail.com, manivannan.sadhasivam@linaro.org,
        agross@kernel.org, rananta@codeaurora.org, vnkgutta@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mailbox: qcom-ipcc: Fix IPCC mbox channel exhaustion
Message-ID: <YMpefUyfBhfgsmOh@yoga>
References: <1623865378-1943-1-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623865378-1943-1-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16 Jun 12:42 CDT 2021, Sibi Sankar wrote:

> Fix IPCC (Inter-Processor Communication Controller) channel exhaustion by
> setting the channel private data to NULL on mbox shutdown.
> 
> Err Logs:
> remoteproc: MBA booted without debug policy, loading mpss
> remoteproc: glink-edge: failed to acquire IPC channel
> remoteproc: failed to probe subdevices for remoteproc: -16
> 
> Fixes: fa74a0257f45 ("mailbox: Add support for Qualcomm IPCC")
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Cc: stable@vger.kernel.org

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/mailbox/qcom-ipcc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
> index 2d13c72944c6..584700cd1585 100644
> --- a/drivers/mailbox/qcom-ipcc.c
> +++ b/drivers/mailbox/qcom-ipcc.c
> @@ -155,6 +155,11 @@ static int qcom_ipcc_mbox_send_data(struct mbox_chan *chan, void *data)
>  	return 0;
>  }
>  
> +static void qcom_ipcc_mbox_shutdown(struct mbox_chan *chan)
> +{
> +	chan->con_priv = NULL;
> +}
> +
>  static struct mbox_chan *qcom_ipcc_mbox_xlate(struct mbox_controller *mbox,
>  					const struct of_phandle_args *ph)
>  {
> @@ -184,6 +189,7 @@ static struct mbox_chan *qcom_ipcc_mbox_xlate(struct mbox_controller *mbox,
>  
>  static const struct mbox_chan_ops ipcc_mbox_chan_ops = {
>  	.send_data = qcom_ipcc_mbox_send_data,
> +	.shutdown = qcom_ipcc_mbox_shutdown,
>  };
>  
>  static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
